Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C01B9C4363D
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 17:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83F762083B
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 17:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZYgzQJlI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbgIYR3m (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 13:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbgIYR3m (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 13:29:42 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F3FC0613CE
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 10:29:42 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id c62so3587290qke.1
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 10:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dKDpOg6e/0e6lVf0DwGmkE1rHiHlR7mQGtNJL4NY/98=;
        b=ZYgzQJlI0IfMoJSu6SpvuSe5eOPOIYAA9vqlD7ENhurjxXV6cJvazXRaM8LFCOccmv
         5quDBK/V4jhGykcywUni9C9xpE3oD4QD+hPiqrl7+6HfHWSR6ENqfKHm5jcr7GMu7jDs
         4bTZ/RHxuvMq/2TBF9NpkXJJ73EGCrd6pvklSq0tcWSl5IijykOFQ48RoSEw5SaGcd9a
         C8qPO2plkTFRe7RiPveXe3DGHlVEtz30BBTKSwLCk64tyTsFDYA1Y7p9a1+13ZN3L2YT
         foLfwngkkhxk9CzCM73V42E/KHIP2Be45v8kUAO8qnOLw0J7cDOtDrREC6KH5u47RRbx
         +E8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dKDpOg6e/0e6lVf0DwGmkE1rHiHlR7mQGtNJL4NY/98=;
        b=V1RgRLuldxMWX1EgMe1GpGYMOBed0qwSiQZdZ43C5qd1IBJBBX9Ao4dLp4hdnDprPZ
         V4WhdHVYs7AXCwj/sY/vASzMLA5PQ4ispuQDJWyOFM5bCu1Z8Om1yisn6GtNTzOx+4AS
         yprnmY9E3AdR23fxAZJBTgGCEIcd2Jb4FIgZ3Y5CoWJvqtxKw1GhCja8Wkcvq7T3MLmr
         uJOiunQU2l7LCvqyCFA/hHPab4IaYbfmxu+FRUwSpxhb+zjMywxomlv+iIcaGxOQWH3a
         Ua1cncA4BlG4YgHP+UV8FSt2XtadnQttdNU0H/vtyATjv2SkrRrakcYvINNs4NEGVFxY
         ASGg==
X-Gm-Message-State: AOAM531l/JnHmNCyHCEkAHmpJIZvvbgvWvn27CKTFW8lYMVtLcOi2Gof
        3Err3VA687qpF7zDP3YkaY0MTEeCu6YmzUzkLj+OIRomCos=
X-Google-Smtp-Source: ABdhPJxV7ab9sP/eyj3KpV1ze1/yBYC8t0TFcoma44udXrMaem4BAyIj57AucAbeNWPx5TCx6XTrV5xARszZ6RLmvhU=
X-Received: by 2002:a05:620a:34c:: with SMTP id t12mr995753qkm.431.1601054981349;
 Fri, 25 Sep 2020 10:29:41 -0700 (PDT)
MIME-Version: 1.0
References: <pull.738.git.1601044118.gitgitgadget@gmail.com> <dddfa3a9b48fa24466a20952d485be1a7f515019.1601044118.git.gitgitgadget@gmail.com>
In-Reply-To: <dddfa3a9b48fa24466a20952d485be1a7f515019.1601044118.git.gitgitgadget@gmail.com>
From:   Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Date:   Fri, 25 Sep 2020 22:59:29 +0530
Message-ID: <CAKiG+9XqJ92rjVczBG9ByVK_KRfJeToO0pFb3RhFpom2ChFE-g@mail.gmail.com>
Subject: Re: [PATCH 07/10] cmake (Windows): complain when encountering an
 unknown compiler
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 25, 2020 at 7:58 PM Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> We have some custom handling regarding the link options, which are
> specific to each compiler.
>
> Therefore: let's not just continue without setting the link options when
> configuring for a currently unhandled compiler, but error out.
>
> Note: for some reason, the `invalidcontinue.obj` trick seems not to work
> in this developer's hands when building Git in Debug mode: the assertion
> dialog that is supposed to be suppressed still pops up, complaining
> about the `entry` variable being uninitialized when it is used in
> `config.c`'s line 1961.

Does this happen when running Git under the Visual Studio debugger?
If so this might help
_CrtSetReportMode(_CRT_ASSERT,0);

After digging a bit more I found out that _CRTDBG_MODE_DEBUG is
environment sensitive.
It depends on how the debugger handles DbgPrintEx().

Thank You,
Sibi Siddharthan
