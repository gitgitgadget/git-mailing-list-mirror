Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3427BC433E0
	for <git@archiver.kernel.org>; Sun,  7 Feb 2021 22:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0214F64E35
	for <git@archiver.kernel.org>; Sun,  7 Feb 2021 22:33:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbhBGWdG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Feb 2021 17:33:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbhBGWdF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Feb 2021 17:33:05 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9F1C06174A
        for <git@vger.kernel.org>; Sun,  7 Feb 2021 14:32:24 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id j5so13058963iog.11
        for <git@vger.kernel.org>; Sun, 07 Feb 2021 14:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=M7FuGgcBbdscuudDxcwo0aWkTv5veRI3exC7Qvp0NYs=;
        b=Azp66C/gj716Y65MPSzWALLY46l+739TKyTXNX0CMks+x0Q5+ioHCovXtzkW5OxYQK
         MEBGWHiAhfE1FfIHp1BkMpJ9QqCaHjZHgBq35BgERQYFFSttS8TUoNHYaEo2W5JOSIZm
         yQbFvu+vkz6PL/kMM6+u02PMrowlE6a2tABe8afw94gw9jgOQ04saB/GzwdDYoCYmxpG
         LEsuTDa+dyD0TAuPC35r/Lty07FJI7t0ZR/xxUYki/EIPgSPeoI/DCd95MSyODtOxAjd
         j0GCmy8px2Adt9DENpxaGF7nA8tHQfeOe6DjKDFEiTUBTI4TJ3ZcfSjfFYEeTSoizqEY
         b8IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=M7FuGgcBbdscuudDxcwo0aWkTv5veRI3exC7Qvp0NYs=;
        b=cyROVkY7f1c+FJGAbFmusEBAJ5w+ZIMspjyvGlPsSN7tyHdgw5TF/xtwV0pljAD2sB
         qqIVNMAw/TO/TH4t7MRBKB5fkf+BhdjjMjEYLCf/spOZImthvBuFK5qOvWniFconYvKT
         eadJw/vswyNukf0V1MKPBlh0E7a4GTdu10+dNLJa4y+MAZ3b9ZHd63UZLJ041/NlPhdM
         T60xPlhMC1Tf92GQfIAP2Ei3ZAySjNGI6PolzNTKSUMQpNTlay/5xvvQCDChu8f3JeLy
         mQt7YlSBhuSzz7bPLNMUJVrQLSKrsk/d4pjz2GdT9jsVU8twH3l3kfIZDlNECgazye0q
         w7KA==
X-Gm-Message-State: AOAM530Z+NedY4sjodmf+6clTkdTf0l+39wJqR5IcN3Ca3RvxbOIMW9s
        ydhQLzRMRifJN4MOUKPqaXc5EAiNZ8ZhSEy9kLg0887p5Tw=
X-Google-Smtp-Source: ABdhPJw+5Wql2yFO0FA8pTSRMH/xx7PPV3bW2qumMWnVg4hbTjSm9c6tOjKLGMAEiyctaE1cB0wIt7rC8vYPr/HtmxQ=
X-Received: by 2002:a6b:7717:: with SMTP id n23mr13010572iom.73.1612737144114;
 Sun, 07 Feb 2021 14:32:24 -0800 (PST)
MIME-Version: 1.0
References: <CA+2K_KotVrV=rjE6fcd_FfxxS0sewkywvO0EMVZdoHbSiqJTQw@mail.gmail.com>
In-Reply-To: <CA+2K_KotVrV=rjE6fcd_FfxxS0sewkywvO0EMVZdoHbSiqJTQw@mail.gmail.com>
From:   Filippo Valsorda <valsorda@google.com>
Date:   Sun, 7 Feb 2021 23:31:58 +0100
Message-ID: <CA+2K_KqH=Gn=Yx-UYzMBO+gZje3G3PJ_3-5HeO81wyZKvVwOSA@mail.gmail.com>
Subject: Re: BUG: commit-reach.c:66: bad generation skip
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I was able to workaround this bug with a "git gc" invocation.

On Sun, Feb 7, 2021 at 11:28 PM Filippo Valsorda <valsorda@google.com> wrote:
>
> What did you do before the bug happened? (Steps to reproduce your issue)
>
> $ git merge origin/master
>
>
> What happened instead? (Actual behavior)
>
> BUG: commit-reach.c:66: bad generation skip     ad18 >        7 at
> be28e5abc5ddca0d6b2d8c91b7bb9c05717154e7
>
>
> Anything else you want to add:
>
> Running in a worktree of a clone of https://go.googlesource.com/go.
> HEAD is 0d34d85dee216b62a4212d25de57e1119c1e7ee5, branch is
> filippo/boringcrypto/16,
> tracking and matching origin/dev.boringcrypto.
> origin/master is 724d0720b3e110f64598bf789cbe2a6a1b3b0fd8.
>
>
> [System Info]
> git version:
> git version 2.30.0
> cpu: x86_64
> no commit associated with this build
> sizeof-long: 8
> sizeof-size_t: 8
> shell-path: /bin/sh
> uname: Darwin 20.3.0 Darwin Kernel Version 20.3.0: Mon Dec  7 22:04:02
> PST 2020; root:xnu-7195.80.16.111.1~1/RELEASE_X86_64 x86_64
> compiler info: clang: 12.0.0 (clang-1200.0.32.28)
> libc info: no libc information available
> $SHELL (typically, interactive shell): /Users/valsorda/homebrew/bin/zsh
>
>
> [Enabled Hooks]
> pre-commit
> commit-msg
