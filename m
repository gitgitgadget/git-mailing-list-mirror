Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B81DAC433FE
	for <git@archiver.kernel.org>; Wed, 30 Nov 2022 03:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233147AbiK3Doh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Nov 2022 22:44:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233259AbiK3DoC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2022 22:44:02 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F107617A
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 19:43:21 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id q71so14906073pgq.8
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 19:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PfCqj26O614xNR12mf70cjJPtgzx8zq7IxRIA68a2qQ=;
        b=Tbyp44HClhvQAbvtHhe7tjd1R7g2YKjfmsQPJMVqpwLtsxLCsR8Zu8+KztYQSKC2NA
         4tUu0eiO73gNZSUESZFHnYNlHG50xgf7XvRCdSqPy1znZwu/JyVSi3D8K7kU4yPikgWg
         pD5Kgi3mVPw3mtoKu8say7oSOIMBVuSJYXRyAWqijOBcT8QcKuTcAy7Ge6wneyg6dAGC
         qvQ9rHZ+hDoJd1c99wGSU9XYOYgQKVDNDbvI2FWwntgbYzLrdnvDxdZY1ijoQ1MUy4gT
         snfqTEE3zwWFTP1n6TyDrPDMd620xx5dx38qpkTJ5tCUjS7c2B+IHbXOIRGYMOcDdzCs
         gNYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PfCqj26O614xNR12mf70cjJPtgzx8zq7IxRIA68a2qQ=;
        b=ajfo5NeEL1cTRogqStT7i6yGIYdNedkPdWkB6AurJ+JdocnntN8XKK3bMk40BHRN6C
         oBIn8jYDWRjKW6Jh5nnnSP3FcOtrNZz15wdjjiBRBwtOeA9k1Ko5L539L4twz1R0G7A/
         Dw42Oze2jtjLq9Cmnu9tF7va/ddd+T+LQRUn10Ibsemxd9TgLyZ8XfAQRn21BH4zQjF9
         7cNafzgNO43moJ3QhWXetogOkpzaduzC6X0XV78EgBp5vnbWIYhKu8Qp13mW3BBNKdKJ
         szeQX6W2VJInnaEf8kfgaKdUHKI2XD1G8Nek8EiOBeLa/J7iJZgD8UQzbdMOMZcwJMZn
         JjfQ==
X-Gm-Message-State: ANoB5pkAVURSCeamH7l7MJd6slF0N294A45m0aVD45Mz8cfUINCb/cs6
        ymBE97lHbp9LKVl6bGkLfUI=
X-Google-Smtp-Source: AA0mqf7oLyXkfMqCVp2fW9WienZ+Kx3aIIE1TK/pDMUvHPJaGunCb+RDsQWVVCoHTbhUxkvPKedX3w==
X-Received: by 2002:a63:1142:0:b0:477:e0f7:aba3 with SMTP id 2-20020a631142000000b00477e0f7aba3mr20912236pgr.388.1669779800593;
        Tue, 29 Nov 2022 19:43:20 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id z13-20020a62d10d000000b005743595a4b7sm242291pfg.103.2022.11.29.19.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 19:43:19 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: ab/remove--super-prefix and -rc0 (was What's cooking in git.git
 (Nov 2022, #07; Tue, 29))
References: <xmqqsfi22j67.fsf@gitster.g>
        <kl6lsfi1d1tf.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Wed, 30 Nov 2022 12:43:19 +0900
In-Reply-To: <kl6lsfi1d1tf.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Tue, 29 Nov 2022 10:59:24 -0800")
Message-ID: <xmqqilix150o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> Hm, it looks like ab/remove--super-prefix missed the preview release..
> Per the discussion ending at [1] I think my one-patch fix to "git
> fetch" [2] should have made it into the release (it's pretty low-risk
> and doesn't introduce too much churn to ab/remove--super-prefix). Is it
> too late for that?

Nobody seemed to have commented on [2].  Is this fixing recent
regressions, or is it more like addressing an "if it hurts, do not
do it then" problem?

The fact alone that these questions need to be asked _now_ is a good
indication that it is way too late for this cycle, I would have to
say.

Thanks.


