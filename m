Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81CD4C7EE22
	for <git@archiver.kernel.org>; Wed, 10 May 2023 22:56:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236681AbjEJW4T (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 May 2023 18:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236605AbjEJWz6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2023 18:55:58 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1533C29
        for <git@vger.kernel.org>; Wed, 10 May 2023 15:55:55 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-64395e2a715so7833284b3a.3
        for <git@vger.kernel.org>; Wed, 10 May 2023 15:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683759355; x=1686351355;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GFoGwirTwj3NXoCmBvV+nTpyovvtz0giEZ8/VBg3xD4=;
        b=MKCEBnLwP/YoYqqlgkSnyNBP/RiHd1IVl98Yj+Bannk7Pq7dMAZ5VxZHb/z11STUci
         NnZwsAttw/Ch1rTJ9iL5bcZSdmIkGi/c4OKWpL29OLySSdhJE1tvxCBMKyNJOmcfHlpM
         cUMHeSXkGOnQdv3p7Hg+hflQJCS8ruFN3jrwktEvfWv8lyQZ/KRmQB9z/UH+69X62x/5
         cGLfGtbqfHc46R8ZL4k99UT1vUlXKMoANRQrS3afgEhc60G73LEywQwIjfy/osYX75kg
         7hMt4nrj/R5D1x3Sokr3M9UZP9E/wrkDO+KGFOPRT6vtoUEkyI/rDJHnhsujpwbPtwvs
         4lVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683759355; x=1686351355;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GFoGwirTwj3NXoCmBvV+nTpyovvtz0giEZ8/VBg3xD4=;
        b=GSRutZPtbwuCOl69NwoqwIwiNI5W//AqJCuIVGU81zMQkVcoFf9T5HVmz03F/ZTI8M
         CnMwYOUrFQJT5E6SwqBFjPmwu9X6nJIGXvw/tF6MqKIrMeCiznUMFcuRzWoCGwv4kZnH
         uYchS7drb2WjVN6bO+Xb4gCq419QEqkOzMVifK5BzKDUpJy5HtvUEOkLHn1T+zBBGCpe
         Ig8kLJZuqAmErD8A8fHp0N6N4WoXELJuf0fILWmHqCyjIjmy1icpKzAllmjjyuIPzFLX
         j6NINnjp/hQ7vlmx+jusrWLyCKWRFslWKJynkuVRKmfcS8ms+nZ+j/ps4qpHBEKSZZe+
         HdBg==
X-Gm-Message-State: AC+VfDw7VUU6+ukXjHqN+FQphxBiJmjEVUmAGEWQJK4yvnuTmUuoDYmR
        ULVHvKS8vy+wyTWDn5Tf4MA=
X-Google-Smtp-Source: ACHHUZ5g+McasbKBamJRfmFx36E8ndagXJXmMWnKB4gOcpGimwqrkGlU0EkY8Z0VVmLx5LUUMXKSBQ==
X-Received: by 2002:a05:6a00:190c:b0:63d:47c8:856e with SMTP id y12-20020a056a00190c00b0063d47c8856emr25980820pfi.2.1683759354829;
        Wed, 10 May 2023 15:55:54 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id e24-20020aa78258000000b0062dd8809d6esm3993353pfn.150.2023.05.10.15.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 15:55:54 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v3 0/3] pack-bitmap: boundary-based bitmap traversal
References: <cover.1682380788.git.me@ttaylorr.com>
        <cover.1683567065.git.me@ttaylorr.com>
Date:   Wed, 10 May 2023 15:55:54 -0700
In-Reply-To: <cover.1683567065.git.me@ttaylorr.com> (Taylor Blau's message of
        "Mon, 8 May 2023 13:38:02 -0400")
Message-ID: <xmqqmt2b23ut.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Here is another small reroll of my series to implement a boundary-based
> bitmap traversal algorithm that I worked on towards the end of 2021 with
> Peff.
>
> The algorithm is the same as in the last round, though I cleaned up a
> few things throughout thanks to another very helpful review from Stolee.
>
> One significant change from last time is that the new algorithm is
> opt-in behind feature.experimental, giving users a way to try out the
> new implementation while still being able to switch back to the
> known-good traversal in case anything goes wrong.

It seems that the comments the topic received on the previous round
have all been addressed adequately?  Does everybody feel comfortable
merging this topic to 'next'?

Thanks.
