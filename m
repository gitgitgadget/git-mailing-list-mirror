Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A311CC433DB
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 10:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CF2164E54
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 10:14:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbhBHKNm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Feb 2021 05:13:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbhBHKEc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Feb 2021 05:04:32 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6829BC06174A
        for <git@vger.kernel.org>; Mon,  8 Feb 2021 02:03:52 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id 19so3589043qkc.13
        for <git@vger.kernel.org>; Mon, 08 Feb 2021 02:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mn2Rm4+6N0+janenw2okScQT+Qp16BgrbsZVqc6AZqc=;
        b=o+CeD17B/k07G2E8GO66/iNipPcLjfKj+mWJ/wLWAYIjJST44+FpK4UllsTvQxYkV4
         uE2vIlzcqpObN4T76JF0lwna/tZokemRhPKsV2vLZ/ioi9Cf/b9M4Ug88Csxsyg8Jqo8
         VlO4YlnzsNCrjCuktdFCGhxJfw7Z0gxH8U/lM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mn2Rm4+6N0+janenw2okScQT+Qp16BgrbsZVqc6AZqc=;
        b=M2Fiz+n0jJDhj5RYdq3/HMOWMT1rY4Htv7zhO/bvLXLOjSVCIi0o3+dW0iDRfG97g1
         3K8PJyd/94bVR3g7ua7wshlQWjoG88JKHgUH0kTMdOjtn0oISgfSH/ZhvAdth1RPwm4+
         dnWyxPHjt0UzroDJrhsuwSRr6TqSU/zlCFssczYLYQHehcvt0cIBdPLVyiC96Uk2jC2U
         4waCCNQ41jzpS2Gih5Vn9zerpqdp4ln92Yy+XyBy9PkNvdUfKwToVQhhoYyE0GOhTzJu
         WES2W73QMwvg0hzsGgqkYwgqpS5q2/absog42PSzhole3+lQBuIf96S3kfNzbsQ/sDnS
         5jng==
X-Gm-Message-State: AOAM532DcQWR6ttc88u4NmBA+yy4SSKiRmnlkH5v4VQACqhzg7IuXLN9
        n23ThyV5HK4a6YK0hYI7xrm+2XoBg/zXoJ9ErFyutw==
X-Google-Smtp-Source: ABdhPJy04KWDlkqpY6yxqwoKXC5ycNourqInylW9ejMgWtWvcaIx0m92OBqhWqP5qzrMnOI1atY443JaKehREoZ6/3M=
X-Received: by 2002:a37:b204:: with SMTP id b4mr16006743qkf.72.1612778631159;
 Mon, 08 Feb 2021 02:03:51 -0800 (PST)
MIME-Version: 1.0
References: <CAKH6PiWS5DvqctFnvZ+uyOzBs75hcy9HzbW_3gUCu+RE+oOYyw@mail.gmail.com>
 <YCAk8Zx8KvZhaJMx@camp.crustytoothpaste.net> <xmqqlfbz927i.fsf@gitster.c.googlers.com>
 <YCAzcs1e08Qnk2wa@coredump.intra.peff.net> <CAPig+cQ=nR7O+uNAufB7ohKN2ZoUP6n1aLbZBz2jeFKMFbaAcA@mail.gmail.com>
In-Reply-To: <CAPig+cQ=nR7O+uNAufB7ohKN2ZoUP6n1aLbZBz2jeFKMFbaAcA@mail.gmail.com>
From:   Adam Dinwoodie <adam@dinwoodie.org>
Date:   Mon, 8 Feb 2021 10:03:15 +0000
Message-ID: <CA+kUOakk_=DRzroNb+0_RcfbkaOYLJxY=AtYMe4YQwuhB+_P_w@mail.gmail.com>
Subject: Re: default editor
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        M Douglas McIlroy <m.douglas.mcilroy@dartmouth.edu>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 7 Feb 2021 at 21:59, Eric Sunshine <sunshine@sunshineco.com> wrote:
> By the way, it's also possible to install Cygwin's Git from the Cygwin
> installer rather than attempting to use the Git provided by the
> Git-For-Windows project. The combination of Cygwin `ed` and Cygwin
> `git` works just fine (in my tests) once you configure `ed` as the Git
> editor either by setting GIT_EDITOR or EDITOR environment variables to
> `ed -l` or by configuring git itself:
>
>     git config --global --add core.config 'ed -l'
>
> (You would want to uninstall Git-For-Windows, too, if you have it installed.)

As the Cygwin Git maintainer, I'd strongly recommend this approach:
either use a Cygwin toolchain or a Git for Windows one, rather than
trying to combine the two. While Cygwin and the Git for Windows
environment share common ancestry, they have substantial differences
arising from the fact that Cygwin generally attempts to provide an
environment that's as close to Unix-like as possible, while Git for
Windows is aiming for compatibility with native Windows applications.
Differences in handling paths and return codes are to be expected.

I expect it is possible to use a Cygwin editor with Git for Windows,
but I don't think it's an expected use case, and I'm not aware of
anyone else having produced and published documentation of the
configuration and wrapper scripts I imagine you would need to convert
between the two interfaces.

Adam
