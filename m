Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 815C7C54FD0
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 01:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45C02206DD
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 01:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="reAncUY4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbgD0BIZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Apr 2020 21:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726316AbgD0BIY (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 26 Apr 2020 21:08:24 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31DDC061A0F
        for <git@vger.kernel.org>; Sun, 26 Apr 2020 18:08:24 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id d3so673446pgj.6
        for <git@vger.kernel.org>; Sun, 26 Apr 2020 18:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0jLGldChHHjeB4QUe1QZxD+l0pVhAmipssrbrDEnCUg=;
        b=reAncUY4ab4OLujXeiWP0bbkhveJTGv70vtJ2KIihmnvg0Gq1mEiRKCnP4bSttCmH3
         dviOYwN3CTOSAMnIOhOsIIifmbBLYZ62pxN5pysm1aKxNsT9X+lvOlveuoLq882+mgd9
         4WJIAIVNekmOqD09wkJ0BiQuDJ9zAC18IE9yLzK2zPCUNNComTBEbydQEdQVR9r4Cjij
         h/vsVq2oC28kiToWmHvtmj/nYOyfEyPYoYlB+6aKCV5o13LNy6y1D7i6VzHdCHSDU3YF
         RHB4mG7dEjGuB0+n1sZY66ak81JfBUqr/uZ9vSqlmRI3d2XbX3igoypnWaAlg0cMDRHT
         ukOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0jLGldChHHjeB4QUe1QZxD+l0pVhAmipssrbrDEnCUg=;
        b=gg9IVJfU/P8JLBl20a0t0mceJqAhS44tSaEbHYehGB0ToCA6jM/fT3NNRqrnJOo0d8
         8YmzXUXB+SaGPJkJNCkb6uKsXHhA7uQMsyCkrq4wL27hurI1W5mfa7jz915DqoTkrpQ/
         pXqaXCikcWxH+co0NnYI8j8Udy1qBtjRCVpQxhqTYO4ocqY16h2cJPI7rzZZhvv63sWR
         baxOtD5Afjd6d5/DuYWiJyoETsS7sUFjXPWpsBWnsWjZzuZ8r4jWlXh/gggH1ycYld+B
         OjZk6f0i1ONxciosyQ6r34snEkrmIyUnLI80N3m23AGNesG4ocpnbLz68/mYaUSnCf4f
         io5g==
X-Gm-Message-State: AGi0PuYBDkLhaj6c8J9kMBiwy3s8quKEiBd37FbztW1ivu2L48qtKoix
        RGe5MciZbAj+rnWxPbkqHblF22yq
X-Google-Smtp-Source: APiQypKNZH8tn6ytddNPV84y/DxkBL4EPJ5ySy436oK20VvGZ0f85djGJ5/OoOFVZZWHkihu4jGXdA==
X-Received: by 2002:a63:5663:: with SMTP id g35mr6063535pgm.356.1587949704259;
        Sun, 26 Apr 2020 18:08:24 -0700 (PDT)
Received: from localhost ([2402:800:6374:bf12:8518:c5e6:e4cc:3967])
        by smtp.gmail.com with ESMTPSA id r78sm126771pgr.40.2020.04.26.18.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2020 18:08:23 -0700 (PDT)
Date:   Mon, 27 Apr 2020 08:08:21 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 2/4] compat/regex: include alloca.h before undef it
Message-ID: <20200427010821.GD14800@danh.dev>
References: <cover.1587648870.git.congdanhqx@gmail.com>
 <cover.1587740959.git.congdanhqx@gmail.com>
 <290ba923b5ee5bcaa4801454b6692deb532bd681.1587740959.git.congdanhqx@gmail.com>
 <820d44c5-5852-fa83-a814-8e58dd120565@ramsayjones.plus.com>
 <20200424170916.GA29153@danh.dev>
 <0bee8daa-99d0-4939-e225-8783bc0457f8@ramsayjones.plus.com>
 <20200424223440.GC721@danh.dev>
 <ffcaaf4f-a43f-2d20-b70d-dfb8b1d7c687@ramsayjones.plus.com>
 <20200426005451.f7pyoiijgbk4hpsj@danh.dev>
 <e9163e0d-2572-e7e0-6aa3-09ce04750b22@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9163e0d-2572-e7e0-6aa3-09ce04750b22@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-04-26 17:17:56+0100, Ramsay Jones <ramsay@ramsayjones.plus.com> wrote:
> 
> 
> On 26/04/2020 01:54, Danh Doan wrote:
> > On 2020-04-25 21:28:05+0100, Ramsay Jones <ramsay@ramsayjones.plus.com> wrote:
> [snip]
> >> OK, I had a quick look at the <alloca.h> header file on a glibc
> >> system (linux) and new-lib system (cygwin) and they both do
> >> (more or less) the same thing: first #undef alloca, and then
> >> if being compiled by gcc, define alloca(size) to be __builtin_alloca(size).
> > 
> > musl people don't do that.
> > They just go ahead define it, if any other header file requires
> > alloca, they will include alloca.h
> > 
> >> So, even if <alloca.h> is #included after regex.c:66, it wouldn't
> >> be a problem. Since I don't have access to a musl based system,
> >> I don't know what that system header is doing.
> > 
> > musl's alloca.h is available here:
> > 
> > https://git.musl-libc.org/cgit/musl/tree/include/alloca.h
> 
> Hmm, OK, so that partly explains the problem. I wonder if the
> musl guys would accept a bug report?

I don't think they have a policy of no `#undef` whatsoever.
But, I think they're picky when come to C-correctly and
POSIX-correctly.
Does C or POSIX define alloca(3) at all?

And, I /think/ they'll likely ignore this one, [musl-faq] says:

	Assuming that including one header will cause symbols from
	another unrelated header to be exposed. This is an application
	bug, and fixing it is as simple as adding the missing #include
	directives. 

I guess they meant, if we have `alloca` defined, we must have included
`alloca.h` somewhere.

> >> However, I said *even if* above, because I don't see why it is trying
> >> to #include <alloca.h> in the first place! ;-)
> > 
> > I looked into my system again. The inclusion chain is:
> > 
> > compat/regex/regex.c:77
> > `-> compat/regex/regex_internal.h:26
> >     `-> /usr/include/stdlib.h:138 [*1*]
> > 
> > [*1*]: https://git.musl-libc.org/cgit/musl/tree/include/stdlib.h#n137
> > 
> > I don't know why _GNU_SOURCE and/or _BSD_SOURCE is defined.
> 
> ... and this explains the main cause. Hmm, as you say, why are
> one (or both) of those pp variables set. :(

Okay, I tracked it down.

compat/regex/regex.c:63
`-> /usr/include/limits.h:4
   `-> /usr/include/features.h:15

https://git.musl-libc.org/cgit/musl/tree/include/features.h?id=8e452abae67db445fb6c3e37cd566c4788c2e8f3#n14
musl defined `_BSD_SOURCE` if none of those below macro was defined:

- _BSD_SOURCE
- _POSIX_SOURCE
- _XOPEN_SOURCE
- _GNU_SOURCE
- __STRICT_ANSI__

I don't think we have any business to define which one of those macros
should be defined in the compat code.

> 
> [snip] 
> >> BTW, why are you compiling with NO_REGEX set anyway?
> > 
> > Because I use musl-libc, and musl-libc doesn't have StartEnd
> 
> Ah, OK. ;-)
> 
> Well, even if the musl project accepted a PR and provided a fix, that
> will not help you in the short term! :D
> 
> Hmm, whatever patch you decide to send (even the original one) I think
> you need to add an explanation of the problem to the commit message,
> including why the patch provides a solution. (You don't have to type
> a novel - see commit bd8f005583 :-P ).
> 
> I haven't thought about this too much, but some options:
> 
>   - iff the musl library sets some kind of identifying pp variable
>     (_MUSL_LIBC_ or somesuch - I haven't looked), then you could
>     make the '#include <alloca.h>' conditional on that variable.
>     This has the benefit of making it obvious to people reading the
>     code that this is specific to musl-libc.

musl's wiki's faq [musl-wiki-faq]:

	Q: Why is there no __MUSL__ macro?

>   - you could simply remove that '#ifdef GAWK' block completely (Lines
>     64->67). We set GAWK and NO_MBSUPPORT  unconditionally in the Makefile
>     so that it compiles (see commit a997bf423d), but these particular
>     lines simply reflect the gawk projects dislike of alloca (along with
>     the desire to catch any attempts to add new calls which are not protected
>     by HAVE_ALLOCA). Given that we are very unlikely to add new calls ...
> 
>   - change the conditional on this block to (totally untested, just typing
>     into my email client) '#if defined(GAWK) && defined(HAVE_ALLOCA)'.
>     This should work, but it does disable the 'catch any attempts to add
>     new _unintentional_ calls' aspect of that block; so you may as well
>     remove it ...

I'll go with your patch in the next email.
<1a0c2b25-e283-9936-1fa2-ce51df1404dc@ramsayjones.plus.com>

[musl-faq]: https://www.musl-libc.org/faq.html
[musl-wiki-faq]: https://wiki.musl-libc.org/faq.html

-- 
Danh
