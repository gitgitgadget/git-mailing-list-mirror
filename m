Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1851C636D6
	for <git@archiver.kernel.org>; Sun,  5 Feb 2023 19:51:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjBETvV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Feb 2023 14:51:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjBETvU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Feb 2023 14:51:20 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81261B326
        for <git@vger.kernel.org>; Sun,  5 Feb 2023 11:51:18 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id ee13so3188665edb.5
        for <git@vger.kernel.org>; Sun, 05 Feb 2023 11:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sJois4hVbL23GvCwf1O1ivJFns3Sf4kOu9hU6+Ec9M0=;
        b=cJIIP/x94QxgMa9Ctbz8UVopWhIUA9m8+LKBoVFe3LhhRdhRGiXRwOS7IJa6Cn05tN
         3WlIgyu0L3CJYxSv7NJzon60PXEoPri9XK4zzhR/fTy7Yy+tKTEMDvvuJHjmnyPYA8rl
         g280oZ7hlas8JmjoIM4x14Kr0g9akKPnWzhjJGlRRk9rYx9aiWntUZ04h12ToqQg2iH/
         SeSHhZ7HaybSTvl8qt4fjPTw3UVNSCoE0LiBPt7BMOkjVOOH9GvVNkKB10b267j+1QxR
         TcSzk4yaVK+YHL/l31GCCC7CSweOajA1TSgXdESKze6fHHZ+2Gd4jJybJl9ulRNoq4BQ
         62nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sJois4hVbL23GvCwf1O1ivJFns3Sf4kOu9hU6+Ec9M0=;
        b=gguchzs0VZU7KSZJZpVBZIBvteQgSezVNCclKTB10auL8lk0SuVbKPQUPQv7E44rXI
         rG42CEKzO+qsq3BCuM/c4v2+BuLBuF9VZ+f8alh8RW99dT4cSrde4svpTyQ73eglpPWZ
         79HDPLQFaymTatOxUKmKRoUR5Y5c0doMFu2s4wTHRjSLL0zPP67lYFFJ7Msn1itccegN
         7iQ3n19OUzbNK6ghl35pGsXdbtkHWsXUejNsdaL4nsiEmN/dctf92NW3wVFTXc4/ETfq
         niWXduQ2PSJhuSFrUfiSpU6pwcTn88mhomf/d0Bf98JIUy8/ijCaYI2T8LnSJiGjMsAn
         bIvA==
X-Gm-Message-State: AO0yUKVZzFO5yY+GJVP3H53UwOEZL5KSFGRUrZ/lLvqnB7h4CCRhNrWN
        yRgNmc+ieDJsv1TV7EZy4n1b0vk7agQZR/xsf8g=
X-Google-Smtp-Source: AK7set8xD4R7Xx16gj4OEcr+W6hTzCrkPiSuKEIsTdYvBDkhmcezFf3Ipd4E+lIong+1SgFjWFoHkHOIOr8uJnu4/aU=
X-Received: by 2002:a50:d0da:0:b0:4aa:9bd9:d81b with SMTP id
 g26-20020a50d0da000000b004aa9bd9d81bmr1553435edf.70.1675626677303; Sun, 05
 Feb 2023 11:51:17 -0800 (PST)
MIME-Version: 1.0
References: <CALnO6CAZtwfGY4SYeOuKqdP9+e_0EYNf4F703DRQB7UUfd_bUg@mail.gmail.com>
 <CANgJU+X_e0owKC3uWPaA_gVP54syF1+MJ-cTn+fjPrNS5LDsMA@mail.gmail.com>
 <Y9rv29c0dYUAYx8B@coredump.intra.peff.net> <CANgJU+XNLqf0E2+YC8yxtRPVh=mevc3P0eeye2_nx=ULB2iVWw@mail.gmail.com>
 <Y9098dyaTtiNk506@coredump.intra.peff.net> <CANgJU+UJ-p54MDmQWYTEsdh_ss-q8TUEcqHFm568Lpfsy2dU+w@mail.gmail.com>
In-Reply-To: <CANgJU+UJ-p54MDmQWYTEsdh_ss-q8TUEcqHFm568Lpfsy2dU+w@mail.gmail.com>
From:   "D. Ben Knoble" <ben.knoble@gmail.com>
Date:   Sun, 5 Feb 2023 14:51:05 -0500
Message-ID: <CALnO6CC2w5LUAjXVw7CWKAVobjFMc7M7jm7HuuGT1SO0q5cYbA@mail.gmail.com>
Subject: Re: grep: fix multibyte regex handling under macOS (1819ad327b7a1f19540a819813b70a0e8a7f798f)
To:     demerphq <demerphq@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 4, 2023 at 6:32 AM demerphq <demerphq@gmail.com> wrote:
> I think that if you look at other broadly ported projects there is
> evidence that owning your own dependencies makes a project easier and
> cheaper to port to new platforms. [=E2=80=A6] No doubt there
> are many other long running projects with precedents in this area.
> What does Vi or Vim do? What does Emacs do? Etc.

Vi and Vim have their own pattern language descended from Ed. They
thus have their own implementation for it. (Vim's has at least two
different "engines" powering the same syntax, and tries to
automatically pick the best one in case; I'm not sure if Vim compiles
the patterns before using them.) The advantage is that, as has been
pointed out, you can rely on Vi or Vim patterns.

=E2=80=A6

Any thoughts on some sort of stop-gap measure to fix --word-diff while
Git decides how to handle the regex engine incompatibilities? How
important is the sequence of bytes at the end of --word-diff regexes
in userdiff.c?

--=20
D. Ben Knoble
