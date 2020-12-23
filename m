Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B83C433DB
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 14:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA20623159
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 14:20:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbgLWOUi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Dec 2020 09:20:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbgLWOUh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Dec 2020 09:20:37 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34EA2C0613D3
        for <git@vger.kernel.org>; Wed, 23 Dec 2020 06:19:57 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id r5so16292792eda.12
        for <git@vger.kernel.org>; Wed, 23 Dec 2020 06:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VcSbkcvqJkLWmPpqBw2gOAsDN7p6rLnqK46v41DlAb8=;
        b=baC09d/gzda87HMUKF2gpaEqkP3n12kyW1DCw+4ILH5NECIthQGvTK0klkOoFDoJmo
         xi/QJiWUYDiiAHSpzfV6k5KGOhOIa8lEFk4vF/SbjZLt1vr+uvELGU6OYcoEU1TfGYcN
         Sp2sdj2ssnFPXGBbNggNiCyZegiqmMBBaqQWrEo3Kg/SBWAusBbsyc9G19DTPfUsX+Ii
         K/ebegs3nXVN8USadPjdindKITPhopAjSIpsb+U5YDC66BZ8HaICCv3gfUw9aMgi+Io2
         VP9X7DFEhx6IWIgX3cTjJZFCljHJxugMLU1ZYw4wuWDpbIvU0tqT6gqUyGmh0jRsHule
         Og0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VcSbkcvqJkLWmPpqBw2gOAsDN7p6rLnqK46v41DlAb8=;
        b=pIropJk/QY2ytWQg/EmDn3SSHPn9wigKmyHB+ZHMIW0R2HRDWrnbFAMsr2oGtFeDPE
         I5kcxLezIJKcLQOVQH/m6WbxIDPitE9bOdn0nuyWat/hp54tV2l8lvsiEvqTLOdVgJHc
         0SprrJ8D3gkGWY3ev3zMkIV40MdvE1aDPqTppxDyvF9Y/R1pbDjdpTpztz35VbWRZqkh
         JwqSm0cTYL4bRXnbNBnmNag8XdxToCOk9ge3LIQmpS8GbR0lNhdPcbvPzAXcrJy8y0Pm
         3FAE9dJGB1hBi536GFYXLU4j57E6EA+ZLIduAwsKMWgLxy2QnH8HGwUmSXPJTdXo7TTb
         rotA==
X-Gm-Message-State: AOAM530FZH1zvf8NQ+I9DA2zwLGDEnZPjj0rUH98N7d4p5S/ydO9LYlt
        IEZFrmuDnrxNW9pVQeKMXI1Xv9cPzgI=
X-Google-Smtp-Source: ABdhPJx5yKTUxIBSUjjGt0OM9twfr5cwH12RjlDewtK5Y5KnW0X5OdwFjJsDsNxOuB1hMJWKtsLz+w==
X-Received: by 2002:a05:6402:45:: with SMTP id f5mr24690398edu.273.1608733195947;
        Wed, 23 Dec 2020 06:19:55 -0800 (PST)
Received: from szeder.dev (94-21-146-153.pool.digikabel.hu. [94.21.146.153])
        by smtp.gmail.com with ESMTPSA id ga37sm10885935ejc.96.2020.12.23.06.19.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Dec 2020 06:19:55 -0800 (PST)
Date:   Wed, 23 Dec 2020 15:19:50 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH try2 0/4] completion: bash: a bunch of fixes
Message-ID: <20201223141950.GA23264@szeder.dev>
References: <20201219140621.1961760-1-felipe.contreras@gmail.com>
 <xmqqy2hoanps.fsf@gitster.c.googlers.com>
 <5fe3484465fac_198be208bf@natae.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5fe3484465fac_198be208bf@natae.notmuch>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 23, 2020 at 07:38:12AM -0600, Felipe Contreras wrote:
> Junio C Hamano wrote:
> > Felipe Contreras <felipe.contreras@gmail.com> writes:
> > 
> > > This is just the bug fixes from the previous series.
> > >
> > > These should be pretty obvious and straightforward.
> > >
> > > Felipe Contreras (4):
> > >   completion: bash: fix prefix detection in branch.*
> > >   completion: bash: add correct suffix in variables
> > >   completion: bash: fix for suboptions with value
> > >   completion: bash: fix for multiple dash commands
> > 
> > It seems that this tickles some platform specific glitches in the
> > tests (the detailed CI report can only be seen when logged in, it
> > seems):
> > 
> >     https://github.com/git/git/runs/1597682180#step:5:35614
> 
> I found that output very hard to parse, but I think I understand the
> issue. It's interesting.
> 
> Apaprently macOS uses zsh by default,

The completion and prompt tests are suppsed to be run by Bash, no
matter what the default shell, or are skipped, or the setup is broken
(a non-Bash shell sets $BASH, or 'exec bash' runs zsh).

Our CI jobs use the default Bash version, which in the macOS jobs
is v3.2.

> and in zsh, this:
> 
>   local sfx
>   echo "'${sfx- }'"
> 
> Prints an empty string.
> 
> That's because in zsh "local sfx" is effectively "local sfx=''" which in
> my opinion is a bug.

Bash versions up to 4.0-alpha suffered from this bug as well; I believe
the relevant changelog entry for 4.0-beta is this:

  e.  Fixed a bug that caused local variables to be created with the empty
      string for a value rather than no value.

So the default Bash version on macOS still has this bug, thus
__gitcomp_nl_append() is invoked with an empty string sfx parameter
instead of a space, causing the test failure.  I can reproduce the
test failure on Linux using Bash v3.2 (and v3.1 and v3.0), and it
passes with v4.0 and later versions.

 
> I see 5 courses of action:
> 
>  1. Drop the offending patch: this is wrong because the bug is still
>     there, we are just not checking for it.
>  2. Add a BASH prereq just for that test, or test_expect_unstable (we
>     would need to add extra code for both of those).
>  3. Add the fix, but not the test for the fix.

I'm for this option 3: this patch does fix a bug for users of Bash
v4.0 or later, while it doesn't change the behavior with v3.2 or
earlier (and with zsh, if I understand correctly).  OTOH, the test
doesn't seem to be all that useful: while it does demonstrate the
issue, it checks only one of those callsites that passed the wrong
suffix, and, more importantly, it doesn't protect us from adding
another callsites with similarly wrong suffex in the future.

In any case, the commit message should note that the fix doesn't work
with all Bash versions and why.

