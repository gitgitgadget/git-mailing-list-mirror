Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F16FC433EF
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 20:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 595A8610D1
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 20:16:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237348AbhIVUSW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 16:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237309AbhIVUSV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 16:18:21 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA2BC061574
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 13:16:50 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id n17so4251017vsr.10
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 13:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tIqotQKJA5VehNFyQlfPSA30tjH/fEZ9xRu4jG4gzXw=;
        b=CbZ4y8ESrlnYj9q5Et9xT6Ib5vRxbzwgpIu2aeiN2kqYdW2pKbtFKTh0vxZGOLFebg
         ZAFUz5ZPMdDI7qQY1d4/gfTdIOPHh83YSSMyMcIm3XvG7UOLazCGwI7wGcIoEGc8HtkA
         TEzTHJM/O1UznuICWUcCA9+XtfosUnkY/fnAzfHjL4lKUv85ewP3A9B9LDK31xhSD6/5
         ZwayXQuVAANy02wEZrxsCbOCOTcm4TR1n7CDl6y/rLz29UJAbx/DVQM+EtVzz21uLep9
         gE0hU13bAA0W/L9kpK0pJ8h/iFWUTrgQyqk3WogRrSj+zZZAAswQ5iagufd44YCP3ILS
         SJHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tIqotQKJA5VehNFyQlfPSA30tjH/fEZ9xRu4jG4gzXw=;
        b=yJWEmMzE5dyh/JZCmHiJnCdJxpLW3T/YGUhyvNn9J0jVHCQv+XB2c0fXajApOZGVlR
         6YKZfQXwAiDxFrQqHS1k4fcXOlmDgttlALSF9ydDQGcGLCwjlfUHafNQNoRJHrP40HWa
         swErKGwr9RdNR2fILYu5dgO+q4qwTM+e8VZ2B3yqa5s4fNVnvaJsf6cJnRblxpkxWoRL
         GmYSbaITWa/yKo+5AsMOfmqWveyr1U1rJHgarmz/UwowRL5yWsyLsRj0uDdDnl7E13vW
         OEguYTyNssnU8+D9On4QfHWuF+0dJecpW862Zzfk3fxXLuNXVG7VFISTRP4MN5IkBxkY
         EIDQ==
X-Gm-Message-State: AOAM531MmiXiOIlyOohpgrR5Z0BT0/HF5W5CZwwQ5jDdjjSg0cqRgncq
        uqh/J/uJasNGAGxIBMPyeX2wgXqyqrDi2Sz1V9Mp44CI8oI=
X-Google-Smtp-Source: ABdhPJzF91r6LPO68u5hqNYI6g8+PL6bsr7IH3FaiQbDA8gEdrSXCJtToVq40UTP4X1sDfsA7hpSIg0wo+CVA1nEv7Y=
X-Received: by 2002:a67:ee9a:: with SMTP id n26mr1318283vsp.14.1632341809724;
 Wed, 22 Sep 2021 13:16:49 -0700 (PDT)
MIME-Version: 1.0
References: <4381472f-a9db-b8a7-a395-81c3935309ae@kdbg.org>
In-Reply-To: <4381472f-a9db-b8a7-a395-81c3935309ae@kdbg.org>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Wed, 22 Sep 2021 13:16:38 -0700
Message-ID: <CAPUEspguHsx+BtViT5tO3eyZSJf7mJ0of-K3vAMqB0-ju4fpsg@mail.gmail.com>
Subject: Re: [PATCH cb/pedantic-build-for-developers] lazyload.h: fix warnings
 about mismatching function pointer types
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 22, 2021 at 12:56 PM Johannes Sixt <j6t@kdbg.org> wrote:
>
> Here, GCC warns about every use of the INIT_PROC_ADDR macro, for example:
>
> In file included from compat/mingw.c:8:
> compat/mingw.c: In function 'mingw_strftime':
> compat/win32/lazyload.h:38:12: warning: assignment to
>    'size_t (*)(char *, size_t,  const char *, const struct tm *)'
>    {aka 'long long unsigned int (*)(char *, long long unsigned int,
>       const char *, const struct tm *)'} from incompatible pointer type
>    'FARPROC' {aka 'long long int (*)()'} [-Wincompatible-pointer-types]
>    38 |  (function = get_proc_addr(&proc_addr_##function))
>       |            ^
> compat/mingw.c:1014:6: note: in expansion of macro 'INIT_PROC_ADDR'
>  1014 |  if (INIT_PROC_ADDR(strftime))
>       |      ^~~~~~~~~~~~~~

did you have CFLAGS adding -Wincompatible-pointer-types explicitly?

This is the reason why the code that got merged to master had -Wno
for this case.

> (message wrapper for convenience). Insert a cast to keep the compiler
> happy. A cast is fine in these cases because they are generic function
> pointer values that have been looked up in a DLL.

I have a more complete "fix" which I got stuck testing GGG[1]; you are likely
going to also hit -Wcast-function-type otherwise.

>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  How can this have worked ever without a warning?

POSIX have a specific exception that allows (void *) for this, it is incorrect
though in platforms where pointers to code and data might be different
(ex DOS with its segmented model)

Carlo

[1] https://github.com/git/git/pull/1094
