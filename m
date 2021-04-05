Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	PDS_SHORTFWD_URISHRT_QP,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8652FC433ED
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 16:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 638CB613A3
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 16:03:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241871AbhDEQDK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Apr 2021 12:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241868AbhDEQDJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Apr 2021 12:03:09 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B0BC061756
        for <git@vger.kernel.org>; Mon,  5 Apr 2021 09:03:01 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id qo10so7104548ejb.6
        for <git@vger.kernel.org>; Mon, 05 Apr 2021 09:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QN3feokyMWYfQzerSFylGwksK/dnNDSoPxv2Zv4IZtw=;
        b=kWy9WwQAyuPbS89DXDurBQx/x/sz7UKrs9wfkE8EZ/ZxUHe+hsV8ya5X8KITHahNsz
         DFcjOhlK/ayePFx1UlrJqSwCRLMLNTLUDgB0Z0fJp09OK4oE1518ZLn84G6NFD9F5puR
         TxE4glyXe4675YjWS9Lb4MVLFXErmQcX7gY20QOELtk3Y7noWXFQ65AsPEA4RQk9sUIw
         mhGnRjs3z4BA/5UwTUQ5mLfZvu86XDKdZDmdCaHmjLuRp2BZqHXdgwd4es+jlGdZFUZ0
         o3aQJg8mo1vPLA5rmjKm/ZJpgTgKyMj4ZirjnArQajWiX17XKxMKFsb68PepHzvRgbQM
         ZfwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QN3feokyMWYfQzerSFylGwksK/dnNDSoPxv2Zv4IZtw=;
        b=B7slI8Ali8gjZqdy+XfODOu40pUOp6EUNatCazIrMisybrqdyVDwLecpknPvWverJt
         Q0k6MsW5q5JC+wXPkLS56yyf1kfSyGlsVX9ei9GR59IQV2fv4b+LW730xzA65eRPRfPX
         zesIGfRjQhJ9vgWgDGtKCcSwVqisiicaBAp9FQgGfHx7C4+ypUUHsUbH3ozrufQQrEJu
         jehPeoB2Bp+L5SwDPx9oe0d2hZeVjD9n55hpn9/gBacWo864iky5Ab2kg0bSUSjEpaRt
         ii7MS/brmDM/z0mS23obvG9ax1WvoozM+xfTYXqhpkcl8LtpgMEee3yTC9LHyPxN81P1
         ZsZQ==
X-Gm-Message-State: AOAM530fxJsig4SUQp+SSWNCtPt2NE+myxmJFvOtlCnr4uIMlGXNNYRl
        Bb37c9uCQGSCk7vrgIVVjM5S2AZXaF1jNIUdEWo=
X-Google-Smtp-Source: ABdhPJxQKTC4Ygbkf4JytDHmd72UckV2HOivOM26vResQczJyeAzhPpHjkbruNEa584WGav/wxZlhWtgHEleJhdBhj8=
X-Received: by 2002:a17:907:a059:: with SMTP id gz25mr16632308ejc.211.1617638579941;
 Mon, 05 Apr 2021 09:02:59 -0700 (PDT)
MIME-Version: 1.0
References: <E6E88000-9C18-4035-9A14-8B406617351A@gmail.com>
In-Reply-To: <E6E88000-9C18-4035-9A14-8B406617351A@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 5 Apr 2021 18:02:48 +0200
Message-ID: <CAP8UFD2eXtW4e-Pm5N2GyXZXPpYaZBci7bs=yHGTaTaD=ZaKag@mail.gmail.com>
Subject: Re: [GSoC][Draft Proposal] Finish converting git submodule to builtin
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sat, Apr 3, 2021 at 4:08 PM Atharva Raykar <raykar.ath@gmail.com> wrote:
>
> Hi all,
>
> Below is my draft of my GSoC proposal. I have noticed that Chinmoy has al=
ready
> submitted a proposal for the same idea before me, so would that be consid=
ered
> "taken"? (I don't think I can submit another proposal for the other idea =
either,
> because someone has already sent one for that as well)

Unfortunately, it looks like we will mentor only 2 students on the 2
projects listed on https://git.github.io/SoC-2021-Ideas/, so we might
have to make tough choices.

> Since I have already put my effort into this for a while, I thought I mig=
ht as
> well send it, but I'll accept whatever the mentors say about the eligibil=
ity of
> this proposal.

Thanks for sending it anyway!

> Here is a prettier markdown version:
> https://gist.github.com/tfidfwastaken/0c6ca9ef2a452f110a416351541e0f19
>
>
> --8<-----8<-----8<-----8<-----8<-----8<-----8<-----8<-----8<-----8<-----8=
<--
>
>                           ___________________
>
>                            GSOC GIT PROPOSAL
>
>                              Atharva Raykar
>                           ___________________
>
>
> Table of Contents
> _________________
>
> 1. Personal Details
> 2. Background
> 3. Me and Git
> .. 1. Current knowledge of git
> 4. The Project: Finish converting `git submodule' to builtin
> 5. Prior work
> 6. General implementation strategy
> 7. Timeline (using the format dd/mm)
> 8. Beyond GSoC
> 9. Blogging
> 10. Final Remarks: A little more about me
>
>
> 1 Personal Details
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>   Name        : Atharva Raykar
>   Major       : Computer Science and Engineering
>   Email       : raykar.ath@gmail.com
>   IRC nick    : atharvaraykar on #git and #git-devel
>   Address     : RB 103, Purva Riviera, Marathahalli, Bangalore
>   Postal Code : 560037
>   Time Zone   : IST (UTC+5:30)
>   GitHub      : http://github.com/tfidfwastaken
>
>
> 2 Background
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>   I am Atharva Raykar, currently in my third year of studying Computer
>   Science and Engineering at PES University, Bangalore. I have always
>   enjoyed programming since a young age, but my deep appreciation for
>   good program design and creating the right abstractions came during my
>   exploration of the various rabbitholes of knowledge originating from
>   communities around the internet. I have personally enjoyed learning
>   about Functional Programming, Database Architecture and Operating
>   Systems, and my interests keep expanding as I explore more in this
>   field.
>
>   I owe my appreciation of this rich field to these communities, and I
>   always wanted to give back. With that goal, I restarted the [PES Open
>   Source] community in our campus, with the goal of creating spaces
>   where members could share knowledge, much in the same spirit as the
>   communities that kickstarted my journey in Computer Science. I learnt
>   a lot about collaborating in the open, maintainership, and reviewing
>   code. While I have made many small contributions to projects in the
>   past, I am hoping GSoC will help me make the leap to a larger and more
>   substantial contribution to one of my favourite projects that made it
>   all possible in my journey with Open Source.
>
>
> [PES Open Source] <https://pesos.github.io>
>
>
> 3 Me and Git
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>   Here are the various forms of contributions that I have made to Git:
>
>   - [Microproject] userdiff: userdiff: add support for Scheme Status: In
>     progress, patch v2 pending List:
>     <https://public-inbox.org/git/20210327173938.59391-1-raykar.ath@gmail=
.com/>
>
>   - [Git Education] Conducted a workshop with attendance of hundreds of
>     students new to git, and increased the prevalence of of git's usage
>     in my campus.
>     Photos: <https://photos.app.goo.gl/T7CPk1zkHdK7mx6v7> and
>     <https://photos.app.goo.gl/bzTgdHMttxDen6z9A>
>
>   I intend to continue helping people out on the mailing list and IRC
>   and tending to patches wherever possible in the meantime.

Nice!

> 3.1 Current knowledge of git

s/git/Git/

> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
>   I use git almost daily in some form, and I am fairly comfortable with
>   it. I have already read and understood the chapters from the Git
>   Book about submodules along with the one on objects, references,
>   packfiles and the refspec.
>
>
> 4 The Project: Finish converting `git submodule' to builtin
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>   Git has historically had many components implemented in the form of
>   shell scripts. This was less than ideal for several reasons:
>   - Portability: Non-POSIX systems like Windows don't play nice with
>     shell script commands like grep, cd and printf, to name a few, and
>     these commands have to be reimplemented for the system. There are
>     also POSIX to Windows path conversion issues.
>   - No direct access to plumbing: Shell commands do not have direct
>     access to the low level git API, and a separate shell is spawned to
>     just to carry out their operations.
>   - Performance: Shell scripts tend to create a lot of child processes
>     which slows down the functioning of these commands, especially with
>     large repositories.
>   Over the years, many GSoC students have converted the shell versions
>   of these commands to C. Git `submodule' is the last of these to be
>   converted.
>
>
> 5 Prior work
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>   I will be taking advantage of the knowledge that was gained in the
>   process of the converting the previous scripts and avoiding all the
>   gotchas that may be present in the process. There may be a bunch of
>   useful helper functions in the previous patches that can be reused as
>   well (more investigation needed to determine what exactly is
>   reusable).
>
>   Currently the only other commands left to be completed for `submodule'
>   are `add' and `update'. Work for `add' has already been started by a
>   previous GSoCer, Shourya Shukla, and needs to picked up from there.

Yeah, 'update' uses  =CC=80git submodule--helper update-clone`, `git
submodule--helper update-module-mode` and other `git
submodule--helper` sub-commands, but is not fully ported.

>   Reference:
>   <https://github.com/gitgitgadget/git/issues/541#issuecomment-769245064>
>
>   I'll have these as my references when I am working on the project:
>   His blog about his progress:
>   <https://shouryashukla.blogspot.com/2020/08/the-final-report.html>
>   (more has been implemented since)
>   Shourya's latest patch for `submodule add':
>   <https://lore.kernel.org/git/20201007074538.25891-1-shouryashukla.oo@gm=
ail.com/>
>
>   For the most part, the implementation looks fairly complete, but there
>   seems to be a segfault occurring, along with a few changes suggested
>   by the reviewers. It will be helpful to contact Shourya to fully
>   understand what needs to be done.
>
>   Prathamesh's previous conversion work:
>   <https://lore.kernel.org/git/20170724203454.13947-1-pc44800@gmail.com/#=
t>

It would be nice if, after finishing 'add' and 'update', you could
also completely get rid of git-submodule.sh and instead use `git
submodule-helper` as `git submodule`.

> 6 General implementation strategy
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>   The way to port the shell to C code for `submodule' will largely
>   remain the same. There already exists the builtin
>   `submodule--helper.c' which contains most of the previous commands'
>   ports. All that the shell script for `git-submodule.sh' is doing for
>   the previously completed ports is parsing the flags and then calling
>   the helper, which does all the business logic.
>
>   So I will be moving out all the business logic that the shell script
>   is performing to `submodule--helper.c'. Any reusable functionality
>   that is introduced during the port will be added to `submodule.c' in
>   the top level.

Ok.

>   For example: The general strategy for converting `cmd_update()' would
>   be to have a call to `submodule--helper' in the shell script to a
>   function which would resemble something like `module_update()' which
>   would perform the work being done by the shell script past the flags
>   being parsed and make the necessary calls to `update_clone()', and the
>   git interface in C for performing the merging, checkout and rebase
>   where necessary.

It would be nice if you could go into more details about what
`module_update()' would look like. Do you see steps that you could
take to not have to do everything related to `module_update()' in only
one patch?

>   After this process, the builtin is added to the commands array in
>   `submodule--helper.c'. And since these two functions are the last bit

It's not very clear here that by "these two functions" you reference
the 'add' and 'update' sub-commands.

>   of functionality left to convert in submodules, an extended goal can
>   be to get rid of the shell script altogether, and make the helper into
>   the actual builtin [1].

Nice that you are talking about this!

>   [1]
>   <https://lore.kernel.org/git/nycvar.QRO.7.76.6.2011191327320.56@tvgsbej=
vaqbjf.bet/>
>
>
> 7 Timeline (using the format dd/mm)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>   Periods of limited availability (read: hectic chaos):
>   - From 13/04 to 20/04 I will be having project evaluations and lab
>     assessments for five of my courses.
>   - From 20/04 to 01/05 I have my in-semester exams.
>   - For a period of two weeks in the range of 08/05 to 29/05 I will be
>     having my end-semester exams.
>   My commitment: I will still have time during my finals to help people
>   out on the mailing list, get acquainted with the community and its
>   processes, and even review patches if I can. This is because we get
>   holidays between each exam, and my grades are good enough to that I
>   can prioritise git over my studies ;-)

s/git/Git/

>   And on the safe side, I will still engage with the community from now
>   till 07/06 so that the community bonding period is not compromised in
>   any way.
>
>   Periods of abundant availability: After 29/05 all the way to the first
>   week of August, I will be having my summer break, so I can dedicate
>   myself to git full-time :-)
>
>   I would have also finished all my core courses, so even after that, I
>   will have enough of time to give back to git past my GSoC period.

Ok.

Also: s/git/Git/

>   Phase 1: 07/06 to 14/06 -- Investigate and devise a strategy to port
>   the submodule functions
>   - This phase will be more diagrams in my notebook than code in my
>     editor -- I will go through all the methods used to port the other
>     submodule functions and see how to do the same for what is left.
>   - I will find the C equivalents of all the shell invocations in
>     `git-submodule.sh', and see what invocations have /no/ equivalent
>     and need to be created as helpers in C (Eg: What is the equivalent
>     to the `ensure-core-worktree' invocation in C?). For all the helpers
>     and new functionality that I do introduce, I will need to create the
>     testing strategy for the same.
>   - I will go through all the work done by Shourya in his patch, and try
>     to understand it properly. I will also see the mistakes that were
>     caught in all the reviews for previous submodule conversion patches
>     and try to learn from them before I jump to the code.
>   - Deliverable: I will create a checklist for all the work that needs
>     to be done with as much detail as I can with the help of inputs from
>     my mentor and all the knowledge I have gained in the process.
>
>   Phase 2: 14/06 to 28/06 -- Convert `add' to builtin in C
>   - I will work on completing `git submodule add'. One strategy would be
>     to either reimplement the whole thing using what was learnt in
>     Shourya's attempt, but it is probably wiser to just take his patch
>     and modify it. I would know what to do by the time I reach this
>     phase.
>   - I will also add tests for this functionality. I will also document
>     my changes when required. These would be unit tests for the helpers
>     introduced, and integration of `add' with the other commands.
>   - Deliverable: Completely port `add' to C!
>
>   Bonus Phase: If I am ahead of time -- Remove the need for a
>   `submodule--helper', and make it a proper C builtin.
>   - Once all the submodule functionality is ported, the shell script is
>     not really doing much more than parsing the arguments and passing it
>     to the helper. We won't need this anymore if it is implemented.

Ok, great!
