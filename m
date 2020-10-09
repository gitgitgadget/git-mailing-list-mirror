Return-Path: <SRS0=ku3G=DQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B91A8C433E7
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 23:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B7F522314
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 23:00:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IsSXMUjj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389215AbgJIXAi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Oct 2020 19:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731374AbgJIXAi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Oct 2020 19:00:38 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8B4C0613D2
        for <git@vger.kernel.org>; Fri,  9 Oct 2020 16:00:38 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id g9so8435141pgh.8
        for <git@vger.kernel.org>; Fri, 09 Oct 2020 16:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cTSymlMRgS2Jf1L3FCZLhZRfaW7luP06ZB885Mgp1hQ=;
        b=IsSXMUjjIT1JnGYrM0w8aEceEh4FjvXxve5B1h8XHIvME1PW1QrzFsf5Au6bil9Pzf
         vdbnnLHrJdk8wZ6pRhmAeOtkdXvdHLNnVSA90yWUAbtu1hsp68eYrQ1udK9SitdWGb2e
         1GY67zlHdG3mzUrhAKtz0ZjbAPogRqKzLxQgEbdWMCphR7SCVyjcUnyZRaz8ngAIsgO9
         c3xtWUf7GfCb1qg2pRDUKfPmiAWSIDXWxlnmLGpIslmOsUziBNJSPTidmnaSKLPywGsp
         Wo5vc/my+jSX/dHkv3ivoK58Sp7s83fRTFIPbWI96+VWlA7m+8mPxy8mJjrOzl/luuMc
         rnNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cTSymlMRgS2Jf1L3FCZLhZRfaW7luP06ZB885Mgp1hQ=;
        b=YbClTnrGW3y49AxT8fpHXfL+g1K75us4Cf08dQlsIhG4VjpdD+1QOwPRD64qrwhv6C
         c+hP5aVXdOJgelKBUEwPwL/Zu3XIZd0jz59FpyprIw8ii7IGJldXuZ7/woPLFqTgQwIl
         cQD9Uz7SmDKqkeFiXZUp7sXlR/1Xu2rlO+XERViCzsyNy3zZFgw7eliIocGzSwN/WHji
         F1b8D+QSrITwarSbFmPIV/Fl8+ltxZEINqMnqgU4FfSf3WoIzKho79MAs3kDu1nZuCQf
         YYOzHn1t/sQhSvEpp5UHiDmoYBI+LgKxDVLU4yaoudcaJHhWYWluFzTho318y6YbCsG7
         jg7Q==
X-Gm-Message-State: AOAM532FRnfuZhYKIahTSrtwxx3+RaZcAo49N4EuksvEIniB3BW6tOQf
        4wwi/PaEBSPeeBapbi1iGnU=
X-Google-Smtp-Source: ABdhPJweEgCWDLF+weHARXOfdxu+ueQeC5JPcnW3c4bOzMtuS2RRvmPxOf1MtA8fKEsVGGpfz4WOzA==
X-Received: by 2002:a17:90a:3b48:: with SMTP id t8mr7091310pjf.32.1602284437440;
        Fri, 09 Oct 2020 16:00:37 -0700 (PDT)
Received: from generichostname (c-67-188-114-10.hsd1.ca.comcast.net. [67.188.114.10])
        by smtp.gmail.com with ESMTPSA id 11sm12936596pja.8.2020.10.09.16.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 16:00:36 -0700 (PDT)
Date:   Fri, 9 Oct 2020 16:00:33 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [RFC] CodingGuidelines: mark external declarations with "extern"
Message-ID: <20201009230033.GA31120@generichostname>
References: <xmqq8scgzqis.fsf@gitster.c.googlers.com>
 <20201009015505.GB1314@generichostname>
 <xmqqtuv4uncn.fsf@gitster.c.googlers.com>
 <xmqqy2kfryiu.fsf@gitster.c.googlers.com>
 <xmqqtuv3ryhr.fsf_-_@gitster.c.googlers.com>
 <20201009195701.GA967869@coredump.intra.peff.net>
 <xmqqpn5rrvfg.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqpn5rrvfg.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, Oct 09, 2020 at 01:33:39PM -0700, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> > The argument for including it is less clear to me. You say below:
> >
> >> [...]By doing so, we would also prevent a
> >> mistake of not writing "extern" when we need to (i.e. decls of data
> >> items, that are not functions) when less experienced developers try
> >> to mimic how the existing surrounding declarations are written.
> >
> > but to my recollection that has not been a big problem. And it's one
> > that's usually easily caught by the compiler. A missing "extern" on a
> > variable will usually get you a multiple-definition warning at
> > link-time (if you manage to also omit the actual definition you won't
> > see that, though "make sparse" will warn that your variable ought to be
> > static).
> 
> Not really, that is where the "common" extension comes in, to help
> us with it hurt others without it, unknowingly X-<.

I'm not really sure what you mean by the "common" extension. 

>         $ cat >a.c <<\EOF
>         #include <stdio.h>
>         #include "c.h"
> 
>         int common = 47;
> 
>         int main(int ac, char **av)
>         {
>             printf("%d\n", common + other);
>             return 0;
>         }
>         EOF
>         $ cat >b.c <<\EOF
>         #include "c.h"
> 
>         int other = 22;
>         EOF
>         $ cat >c.h <<\EOF
>         int common;
>         int other;
>         EOF
>         $ gcc -Wall -o c a.c b.c; ./c
>         59

On gcc 10.2.0, it errors out successfully. Although on clang 10.0.1, it
compiles successfully and produces "69". That being said, I think extern
variables are relatively rare in our codebase and, when it happens, they
usually come as part of lists of other extern variables so a developer
who's mimicking the surrounding code would be able to copy it
successfully. Otherwise, the decl usually pops out in header files as it
is quite unusual.

> And I have a strong preference, after thinking about it, to have
> "extern" in front in the declarations.  It gives another clue for
> patterns I feed to "git grep" to latch onto, and help my eyes to
> scan and tell decls and defns apart in the output.  The benefit
> alone is worth the extra 7 columns in front spent, which you call
> "clutter".

To be honest, I do not have any preference between having the explicit
extern or not. I do have a strong preference, however, for having a
codebase that's consistently written. When I was doing the refactor, I
wouldn't have minded introducing extern everywhere although that wasn't
suggested as an alternative.

I agree that these are all benefits of declaring functions explicitly as
extern. However, I don't think they're worth the cost of either another
huge rewrite or an inconsistent codebase.

> > IMHO the real problem here is that C's syntax for returning a function
> > pointer is so horrendous. How about this (on top of your earlier patch
> > to drop the extern from that declaration)?
> 
> In general, I like a typedef for callback function that shortens the
> decl of a function that takes such a callback, so I think
> 
> > +void set_error_routine(report_fn routine);
> > +void set_warn_routine(report_fn routine);
> > +report_fn get_error_routine(void);
> > +report_fn get_warn_routine(void);
> 
> these are good, but they are better with "extern" in front in a
> header file to make it clear they are declarations and not
> definitions when they appear in "git grep" output.

I agree that this looks a lot better, with or without the extern.
