Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA86C54FD0
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 16:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0557A2087E
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 16:46:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V5qgg/DK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbgD0Qqx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 12:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbgD0Qqw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Apr 2020 12:46:52 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB06BC03C1A7
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 09:46:52 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id j7so8908415pgj.13
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 09:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EzH4uNVIEciPO8ifhTQWBPqmrcR0uwkm2xeFiKRbHFM=;
        b=V5qgg/DKC/p1ocGXyFI47ZHqZkTazAJcSWYht0bsaiQg01ubDTnf9wwko1D58UOPXa
         iS8mBLoLw/a4tg1wJVaat3olHSuXy328eUw8VcCs89boeVMSbpDbeA56IeNBxX3MgKJj
         E8EOefvAC44CjTuBKNqLtYaBNAUR4fbMKgNryLSmCdS4/J+R2lCsouKQZyfITRUzTzPj
         P5h8ZJ1uhGE8cSzB0xrQ1W/nGcaLwy0UcaHne/oRuzabdwz2AaZMmjTJq2auR6Vlqqbk
         S0vwOhhSADRxHfeZ63CSCh8gguT2Q1onQVHZeu/p0++wJ4t5DihuQLX11cNljt4QT7Lz
         XyhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EzH4uNVIEciPO8ifhTQWBPqmrcR0uwkm2xeFiKRbHFM=;
        b=UmQS7yfWEniWSGBEyVYy70s/1wbrId/N8NrGrr8aO5LhxgNjJKBQJ2D7rEBiPSpitb
         2nSU/QAz+lzvJYAlp2XXD+hqKTiYU4H0/zFmNpMBKhhbHkWSC9Tbh/8B2XQesXONaYNJ
         gir5NV5PbC8K1/1r9QKKHlzmGTQ4HEZdXM97O16TBniZa+K8ORW3is7jJCHEGG6AekoH
         /vJOtYHXruAg3QoHgwktJwnkbNzmcl6SxJpRpp+Ygz2Eipytwjrpaq0lgbuZW7xsXLuq
         +8miWxeA/dWhx2T0LAj50xabphQSK46Dd8Afg9/7DI+2t4FMULrhdYG5D/IoCoX7LAGM
         R7Fw==
X-Gm-Message-State: AGi0PuZc36rXAsLNhmvXK+Bxr/t/TeMtXXN6HB1Zw3lhDlY0uPMZiir3
        MaNJVIAqyn+XkAbZBzHGSeqhX5nz
X-Google-Smtp-Source: APiQypL/AnRmtgKXTpEdA5cH5AJ7DzzR2dkaQFPXft9c0TYDQVvWsm+jF8KqUEdblq5a4Z/G3WTaJw==
X-Received: by 2002:a63:615:: with SMTP id 21mr23146381pgg.22.1588006012207;
        Mon, 27 Apr 2020 09:46:52 -0700 (PDT)
Received: from localhost ([2402:800:6374:bf12:8518:c5e6:e4cc:3967])
        by smtp.gmail.com with ESMTPSA id 62sm12900411pfu.181.2020.04.27.09.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 09:46:51 -0700 (PDT)
Date:   Mon, 27 Apr 2020 23:46:49 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 2/4] compat/regex: include alloca.h before undef it
Message-ID: <20200427164649.GA31366@danh.dev>
References: <290ba923b5ee5bcaa4801454b6692deb532bd681.1587740959.git.congdanhqx@gmail.com>
 <820d44c5-5852-fa83-a814-8e58dd120565@ramsayjones.plus.com>
 <20200424170916.GA29153@danh.dev>
 <0bee8daa-99d0-4939-e225-8783bc0457f8@ramsayjones.plus.com>
 <20200424223440.GC721@danh.dev>
 <ffcaaf4f-a43f-2d20-b70d-dfb8b1d7c687@ramsayjones.plus.com>
 <20200426005451.f7pyoiijgbk4hpsj@danh.dev>
 <e9163e0d-2572-e7e0-6aa3-09ce04750b22@ramsayjones.plus.com>
 <20200427010821.GD14800@danh.dev>
 <f3af49c7-6c35-d2f6-c87c-e7342b1c2b6f@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3af49c7-6c35-d2f6-c87c-e7342b1c2b6f@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-04-27 17:28:03+0100, Ramsay Jones <ramsay@ramsayjones.plus.com> wrote:
> No alloca() is not in either the POSIX or C standard(s).
> This was an extension from the early days of BSD Unix.

Okay, I saw it was mentioned in GNU manpage for alloca(3)

 
> For some reason, I thought you had to explicitly '#include <alloca.h>'
> to use it, but it appears that (by default) you get a bonus include
> from the <stdlib.h> header, unless you restrict the headers using the
> various macros and/or compiler command-line options.

It looks like <alloca.h> is GNU's invention.

*BSD defined it in <stdlib.h>:
https://www.freebsd.org/cgi/man.cgi?alloca
https://man.openbsd.org/alloca
https://netbsd.gw.com/cgi-bin/man-cgi?alloca+3+NetBSD-current

Even GNU's alloca(3) says:

       Normally, gcc(1) translates calls to alloca() with inlined code.  This
       is not done when either the -ansi, -std=c89, -std=c99, or the -std=c11
       option is given and the header <alloca.h> is not included.  Otherwise,
       (without an -ansi or -std=c* option) the glibc version of <stdlib.h>
       includes <alloca.h> 

> As it happens, even on glibc systems, the <alloca.h> header is included
> by the <stdlib.h> header, unless you take steps to suppress it. So, we
> would have had the same issue, if it wasn't for the aforementioned
> '#undef alloca' the the glibc header file.

From above information, I think it's fine to include <stdlib.h> first.
It's AT&T Unix's invention and everyone seems to follow it (except Windows,
but the lack of complains from our Windows friends may signify that
their alloca is fine already).

I've sent it already for v3.

 
> When I need to look at pp output, while debugging things like this,
> I cherry-pick a patch to the Makefile:
> 
>   $ git diff
>   diff --git a/Makefile b/Makefile
>   index 6d5cee270c..cd8753bf54 100644
>   --- a/Makefile
>   +++ b/Makefile
>   @@ -2423,6 +2423,9 @@ $(ASM_OBJ): %.o: %.S GIT-CFLAGS $(missing_dep_dirs)
>    %.s: %.c GIT-CFLAGS FORCE
>           $(QUIET_CC)$(CC) -o $@ -S $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) $<
>    
>   +%.i: %.c GIT-CFLAGS FORCE
>   +       $(QUIET_CC)$(CC) $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) -E $< >$*.i
>   +
>    ifdef USE_COMPUTED_HEADER_DEPENDENCIES
>    # Take advantage of gcc's on-the-fly dependency generation
>    # See <http://gcc.gnu.org/gcc-3.0/features.html>.
>   @@ -2474,7 +2477,7 @@ http-walker.sp http-walker.s http-walker.o: EXTRA_CPPFLAGS = -DNO_EXPAT
>    endif
>    
>    ifdef NO_REGEX
>   -compat/regex/regex.sp compat/regex/regex.o: EXTRA_CPPFLAGS = \
>   +compat/regex/regex.i compat/regex/regex.sp compat/regex/regex.o: EXTRA_CPPFLAGS = \
>           -DGAWK -DNO_MBSUPPORT
>    endif
>    
>   $ 

I think it's worth to have this included. `.s` rules is there, anyway.
Personally, I've run this to trace the inclusion:

	make V=1 CFLAGS=-E compat/regex/regex.o compat/regex/regex.sp


-- 
Danh
