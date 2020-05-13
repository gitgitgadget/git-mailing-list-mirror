Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E9DC433DF
	for <git@archiver.kernel.org>; Wed, 13 May 2020 20:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F2F4206A5
	for <git@archiver.kernel.org>; Wed, 13 May 2020 20:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQOWYeG2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390863AbgEMUSz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 16:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732650AbgEMUSz (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 13 May 2020 16:18:55 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3355C061A0C
        for <git@vger.kernel.org>; Wed, 13 May 2020 13:18:54 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id t9so11602536pjw.0
        for <git@vger.kernel.org>; Wed, 13 May 2020 13:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Z9MNRCfSj4rv0c5RJbKu9WXUb4seDVG2lQMja5wDX9Y=;
        b=KQOWYeG27kLReGyePT3THvpwMIKURJIF48rJzjvF1jLWvaHR+rqwz7UdCSW1KfX5qh
         REUY+tTaGYPyegFaMOYqlvCOZ8LuycDU5czT2BicrmKDEIpegcervmzqPKy2XfCfaJIr
         2PsEUNkg4YqvmdUmaHmXG5J5KK7jr6o+Wz4qSBiIA3wZ3UVjGfWB+EwSPng0Hx5LZUgv
         v9+rI54C8Rj6Dvin96SMFNNiehF/c1cX3j6dN7SJxttazZ8ObuqL39osnooyMoo92EEr
         E/jYxK7YYyZR6NEjlasIY/zQZsI2fmRUN935coTpEGJknIleltuarUigrQpXRNXVhrH+
         kvuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Z9MNRCfSj4rv0c5RJbKu9WXUb4seDVG2lQMja5wDX9Y=;
        b=jkQyIipnB5soMLmAB4jaID/QwQrtTmoKKLW3zDzwpG11AR6pG6KHWmFhvwjfkeY2vJ
         BipRFPxJpVEuw5GFJp50ED4EPvtkuhGcGHYse+LZ5XK1bQ0sO4HTPQquomMRPNx3DjT1
         JDqr7Lv5CUEWxMNn0OZ+rNCk3ibWSqrGt1Z4qLB/0UTQ8Xzc74LKAgF6whGg1jMX2VE0
         EvMdJcMoR/V89I/dHFu0nC/YUK/cJWaZlEJVoLifok8vS3wpu0h4sVMWqv3buexImMwQ
         5JyS9kKMyXwFRRpxWkNQ3SL/T9AKoA6+Aw+uLTNRlMWRwuUd7bsj6Fbj/w5mf6gmc83t
         wI4w==
X-Gm-Message-State: AGi0PuYAVzfHKp59JrvWiiNwnxy9d66pJusNrcZg8eAQxkI2GHLAuYEC
        Pq6NnWpWgv5viy78ytT8j+Y=
X-Google-Smtp-Source: APiQypKFT0Cj6UzRLicVLCxcUqg9+ACNZmXu63uM1Z6PKyvOxUolQwE9MAXTWqp79x2ng57BnKpXYw==
X-Received: by 2002:a17:90a:8b:: with SMTP id a11mr35267594pja.163.1589401134310;
        Wed, 13 May 2020 13:18:54 -0700 (PDT)
Received: from Carlos-MBP (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id t80sm360348pfc.23.2020.05.13.13.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 13:18:53 -0700 (PDT)
Date:   Wed, 13 May 2020 13:18:51 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Ed Maste <emaste@freebsd.org>
Subject: Re: [PATCH] t4210: detect REG_ILLSEQ dynamically
Message-ID: <20200513201851.GA30804@Carlos-MBP>
References: <20200513111636.30818-1-carenas@gmail.com>
 <CAPig+cTUc2-ddWQ+oww5Ez7_N9qKgCuErk8OuOgPkXNrACdppw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cTUc2-ddWQ+oww5Ez7_N9qKgCuErk8OuOgPkXNrACdppw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 13, 2020 at 11:44:53AM -0400, Eric Sunshine wrote:
> On Wed, May 13, 2020 at 7:17 AM Carlo Marcelo Arenas Belón
> <carenas@gmail.com> wrote:
> > diff --git a/t/t4210-log-i18n.sh b/t/t4210-log-i18n.sh
> > @@ -56,21 +56,29 @@ test_expect_success !MINGW 'log --grep does not find non-reencoded values (latin
> > +test_have_prereq GETTEXT_LOCALE &&
> > +! LC_ALL=$is_IS_locale test-tool regex --silent $latin1_e $latin1_e EXTENDED &&
> > +test_set_prereq REGEX_ILLSEQ
> 
> Nit: Is there precedent for formatting the code like this? At first
> glance, I read these as three distinct statements rather than one
> large composite statement. I wonder if indenting the continuation
> lines would make this more easily-digested.

yes, I copied the syntax from t7812, and I agree looks ugly and would had
rather done it with an if as Junio suggested, but couldn't find precedent
in another tests.

indeed, I would rather go away with the whole prereq and set a variable
with a nice sounding name and use it below to `if test` the right tests,
would that be ok?

> >  for engine in fixed basic extended perl
> >  do
> > +       ireq=
> >         prereq=
> > +       case $engine in
> > +       basic|extended)
> > +               ireq=!REGEX_ILLSEQ,
> > +               ;;
> > +       perl)
> > +               prereq=PCRE
> > +               ;;
> > +       esac
> 
> Why do you introduce a new variable 'ireq' here considering that...
> 
> > +       test_expect_success !MINGW,GETTEXT_LOCALE,$ireq$prereq "-c grep.patternType=$engine log --grep searches in log output encoding (latin1 + locale)" "
> > +       test_expect_success !MINGW,GETTEXT_LOCALE,$ireq$prereq "-c grep.patternType=$engine log --grep does not die on invalid UTF-8 value (latin1 + locale + invalid needle)" "
> 
> ...it is always used alongside 'prereq'? It seems that you could just
> assign "!REGEX_ILLSEQ" to 'prereq' without need for 'ireq'. (And
> 'ireq' is a rather inscrutable name -- I have trouble figuring out
> what it means.)

sadly I can't because there are 3 tests, and only 2 of them (the ones shown
in the patch) will have that prerequisite dynamically added, while all
will have $prereq.

will send a v2 as an RFC with your suggestions

> >                 LC_ALL=\"$is_IS_locale\" git -c grep.patternType=$
> > diff --git a/t/test-lib.sh b/t/test-lib.sh
> > @@ -1454,12 +1454,6 @@ case $uname_s in
> > -FreeBSD)
> > -       test_set_prereq REGEX_ILLSEQ
> > -       test_set_prereq POSIXPERM
> > -       test_set_prereq BSLASHPSPEC
> > -       test_set_prereq EXECKEEPSPID
> > -       ;;
> 
> The commit message explains why you remove the 'REGEX_ILLSEQ', but why
> are all the other lines removed, as well? Such removal seems unrelated
> to the stated purpose of this patch.

they were all added by the previous fix I am ammending and therefore are
no longer needed.

the 3 unrelated variables were originally copied from the '*' entry on
that case, and therefore FreeBSD will now use the ones there instead of
its special case.

Carlo
