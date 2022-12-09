Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D85F4C4332F
	for <git@archiver.kernel.org>; Fri,  9 Dec 2022 10:40:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiLIKkU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Dec 2022 05:40:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiLIKkR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2022 05:40:17 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4AFDF8D
        for <git@vger.kernel.org>; Fri,  9 Dec 2022 02:40:16 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id fa4-20020a17090af0c400b002198d1328a0so8065166pjb.0
        for <git@vger.kernel.org>; Fri, 09 Dec 2022 02:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dNUhO6JzrG4005ozL70Kmby40acnl2+CNBtS17MHy7Y=;
        b=W3/XVyzCmhiftLfF8d/S5ZWXjvDBBLnTG0+YmCUGh5TycJr+KHf5hIpV+hupQjCSF/
         moIpJB7T7FPTvV2ld2jgE0TiqGFp+AMAmfDoMZIBMu88WR2g6cSvn5f7ujeKdiTvPr0F
         0409YbeEF7422PAS7pL6QVkvIRm6YLaQZ7BxPEeq5Of6NgS6mCoBHxfF6ZyTQPpfTshe
         TxlNwRKgH/jnELCfzp8wxLkTvMxZANyNreBu8Np9JGgLakrUcowmXreWMoKr0uCa/2Fy
         Ohk+AvQOe9Qbjk1XrZu01bnH2l9h7f1ca3IetEw3ad/KF/+JsaC/VCjaEh3HIvUIkwsb
         38HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dNUhO6JzrG4005ozL70Kmby40acnl2+CNBtS17MHy7Y=;
        b=EJNqsU/JcJ/8j4RUFNsq0Z8YFQdqlSznDHW+ReGzZpl0vHdBLTBBkvu9AcfU1gLWaD
         fP28iB8d1aq7u0N0oWVz5sW5Y5NxSHKIllw7FS26AbNiRLBl7QI8ZIejsXzwP3POzgXV
         KE40YE7oR4oIdpcSGXiP/IZggZyWfNtIwPEIWuasiQ/Lk4RfrHFF4bt8cuH9+5Qn+ijd
         kKmPEwSSuR3CfK2y4JaPdzuhI1JiKhVtOrFJwp0gFlkTieHOktqSVMTiTBszaJmbKvoV
         x4zzECTOeSFY6+MkJz/SlPigjnykv2DibyJg8OsAWK6vmpWTQNIlBwqU3SAT4HF0KU7x
         g+Qw==
X-Gm-Message-State: ANoB5plnM6LnBQffwRdFAtqX0nLIBHTzylsyfWijklHlqcHxmhdsnjn2
        Z9ph6V+qmiTsOZcWHhuti4zMUV6M7+n8Iw==
X-Google-Smtp-Source: AA0mqf5xw4lOLJ50I8GeGlR4vIU1luBKHdkYaV6bpVBGGAPgXBtX9UG2U50DN+p1h3p3k1ZfiDDsnQ==
X-Received: by 2002:a17:902:7409:b0:18b:8907:b51c with SMTP id g9-20020a170902740900b0018b8907b51cmr3546231pll.1.1670582416049;
        Fri, 09 Dec 2022 02:40:16 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id o2-20020a170902d4c200b001899c2a0ae0sm1052035plg.40.2022.12.09.02.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 02:40:15 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Eric Musser <eric.musser@snowflake.com>,
        Victoria Dye <vdye@github.com>
Subject: Re: rebase update-refs can delete ref branch
References: <CAGW=zr_BD=7d5dZi+yO4cpufFi=jEjH=wQoTndDLfTi14UresQ@mail.gmail.com>
        <8edcef4f-4438-e07a-a6fb-698b6179fcc4@github.com>
        <xmqq1qp90zvi.fsf@gitster.g>
Date:   Fri, 09 Dec 2022 19:40:15 +0900
In-Reply-To: <xmqq1qp90zvi.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        09 Dec 2022 17:01:37 +0900")
Message-ID: <xmqqa63wzwq8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Thanks for digging the history.  It is unfortunate that, even though
> the fix exactly identifies b3b1a21d (sequencer: rewrite update-refs
> as user edits todo list, 2022-07-19) as the culprit and it is trivial
> to see that was shipped as part of Git 2.38, the fix was not queued
> to allow merging 44da9e0841 into 2.38.x maintenance track, so it is
> unlikely to appear in any 2.38.x maintenance releases we might issue
> in the future.

Well, I changed my mind.  Let's bite the bullet and cherry-pick the
single patch, just for this once (as a general principle, I hate
cherry-picking and try to avoid unless the fix is absolutely needed).

This is primarily because we have enough material to prepare for
Git 2.38.2 already accumulated on the 'maint' front, all from the
bugfixes merged to 'master' for the upcoming Git 2.39.

I'd plan to tag 2.38.2 and 2.39 at the same time on coming Monday,
but note that I am operating in Asia/Tokyo timezone, so it may be
Sunday for many folks in the western hemisphere.




