Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 875A9C38145
	for <git@archiver.kernel.org>; Tue,  6 Sep 2022 21:21:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiIFVVD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Sep 2022 17:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiIFVVA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2022 17:21:00 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5100FB4420
        for <git@vger.kernel.org>; Tue,  6 Sep 2022 14:20:59 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id i9so3242030qka.0
        for <git@vger.kernel.org>; Tue, 06 Sep 2022 14:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=4XNIKjvMV5d+3EH0/jtCOffdWZ+Mbe3sL1Vh3J7qn4I=;
        b=Q50Qlb5IWAgjLw7IQkICaB66wGp4lSibGLWZ1PzzNh5BdfUgMef+Q7/b8XK/xpOb0a
         d3/AlTwXbNntRe9/Y3cYvpAzprFleJo7bQwxVwE/IuvY6NtS8P/JPrfqz5tLGNA6+QIT
         yVs2OJ7+VxEdUraE0Uikl5bBu7oRPfGfmYu6fqyJlEh9Ut8bv9K5rtm/qn5nw6kkj2oe
         L7f1p2npJYKNOHv+piNPyHnBORtnoWeTazWTi0/udWOLZHkVDo8e98XcwCSsqxAWf5WG
         p9LLv1tJxMxJajA30J+0xTKUlLk+laBqKV3X/B4cPtWyM69nnizCIzxsnlXYpjBB1DC0
         v2Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=4XNIKjvMV5d+3EH0/jtCOffdWZ+Mbe3sL1Vh3J7qn4I=;
        b=XKW/MxESvmlA42GUyi65BMMqovP6CY4DEFF2mxebZLW2SKNW2DE6TUlCvqpoPScYS7
         K3WvMNkup5kb2nsmwL8wSLqwR3cH/FbZ0iAFkmiMJ/GUNF1WjYtzUIEupAxJ9tXo0sga
         ScSPsMn2j7li/eYANxS/A5AeFCWBhC+hMeUFK85mZISdehG/2dYDW9iyE0yAJVvRNN6w
         AcZ9rO64G+lXOy9bwOJuyLphZrTrwLTDx7RK1G6t//Ti9XMSfSximC4FNvkqrs8imgVm
         3bobG+Ld4lQtXsjmFLKR1MYGsYkpBWcnuKOXu2/n65fkYoIBjGEfu1/QNqqfZc56oXts
         ftMw==
X-Gm-Message-State: ACgBeo2NR6JNRAtIQ30+1V/fX54h8CBRuZVSdy66BYWwmOdG0LhyFZh4
        MRskAemqiBEbleYG1QjMHpQE/xSWB29Z+MmW
X-Google-Smtp-Source: AA6agR4dCsot7c48pbxkuW8EutDI13P2Mpixr6Kv5hvzkkgVhWpRBHiqihIw8BYMm2LeDFP3DnNFXw==
X-Received: by 2002:a05:620a:4689:b0:6bb:6a4a:f2fe with SMTP id bq9-20020a05620a468900b006bb6a4af2femr485185qkb.243.1662499258464;
        Tue, 06 Sep 2022 14:20:58 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id hf9-20020a05622a608900b00342fb07944fsm9929461qtb.82.2022.09.06.14.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 14:20:58 -0700 (PDT)
Date:   Tue, 6 Sep 2022 17:20:57 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] bug with rev-list --verify-objects and commit-graph
Message-ID: <Yxe5uVmrJ9d8vp1Y@nand.local>
References: <Yxe0k++LA/UfFLF/@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yxe0k++LA/UfFLF/@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 06, 2022 at 04:58:59PM -0400, Jeff King wrote:
> While looking at something unrelated, I noticed that "git rev-list
> --verify-objects" will not actually notice corruptions of commits that
> are found in a commit graph. This fixes it.

I reviewed both of these patches, and they look good to me. Thanks!

Thanks,
Taylor
