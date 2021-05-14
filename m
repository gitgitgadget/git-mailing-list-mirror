Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	PDS_SHORTFWD_URISHRT_QP,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC8DC433B4
	for <git@archiver.kernel.org>; Fri, 14 May 2021 16:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAF8C61285
	for <git@archiver.kernel.org>; Fri, 14 May 2021 16:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbhENQBa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 May 2021 12:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbhENQB3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 May 2021 12:01:29 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA64CC061574
        for <git@vger.kernel.org>; Fri, 14 May 2021 09:00:16 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d16so27091pfn.12
        for <git@vger.kernel.org>; Fri, 14 May 2021 09:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=c9aTanq7IxyVeSCDBAaCnXKb44n/lpcUuXLAbhQzC/U=;
        b=NXTwwHAAwL3cJq3eoDSu2Q8MmeexbfJLOP1c3Ev6aWAQc9j3usw3lFfYBHrBi2WD2d
         XzDkSIUl/x/BL2DRVeMcBgM07IpkBhK1qwA0DU3lPJCoTKW5Hj24eC/o2JscXsn5vOJC
         8Xb2vVvoqtkIf4GnGHfFFGc+mhVHHC5PZP537cQiyHdMUsnmsiL9ooj+3G9AliCjRpMB
         gDWfJBThHjHh8C+GqANzfhRun6S5qADyL2yUcWdlvWDMFNYBZIG6lo+ltpEdSJepS4Ql
         wkvYPf2p9UZeaxjDTAUYcjJQy0CU9Or+GQ+3n1isUYGcACZaH55zdfJswJzHAI2DEht+
         dJ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=c9aTanq7IxyVeSCDBAaCnXKb44n/lpcUuXLAbhQzC/U=;
        b=YLNAZaaiMEWolOXhtyxgL6EvLxRWq34lLFTRPSJhnAIA1PrGgB6Cbt4oW1gse374T0
         jb2cFzttljT2UNZ5uRLEsLPHPw+ENlI1D0wtSCdQd9o41Jx5KmNIKzsw9nPtWP1dapNR
         WWvwfPFY+Msi7iG/54ml55ORSzq1PuRaTsF8nnddniqdZQ8AY8CsN0jAqb7u+LFl4sZ6
         4F/v2Cm3KenV4f0ZrEp+GwtTKcCZWATXGK/Ay4hl88g4rEIn9QSAmYstFlOk5CmW5IgL
         ow9vn9NAGvTX667qpx0scYuB8qt2d4vMTD32gBa2ZyzYcXPl4YpjqyAg+wWpofcVER0V
         1npw==
X-Gm-Message-State: AOAM531o35h/MXBt7rADqVIR8MeR9NB/7JhnDg/swcQZF07rR00NLc5U
        MGrxUXtqUKcPevMzI2f3V+7N4PsMufQWgqJl
X-Google-Smtp-Source: ABdhPJx1mt30yaCOmAWoiJbpdYBqJZdp4rG5oAnE+TIpUyJK1VPlkTWkbu3D3JWKKdZ1gc2i98+3Qg==
X-Received: by 2002:a63:5b0e:: with SMTP id p14mr46710331pgb.110.1621008015556;
        Fri, 14 May 2021 09:00:15 -0700 (PDT)
Received: from atharva-on-air.dlink ([119.82.121.70])
        by smtp.gmail.com with ESMTPSA id gb9sm9569977pjb.7.2021.05.14.09.00.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 May 2021 09:00:14 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [GSoC][Draft Proposal v2] Finish converting git submodule to
 builtin
From:   Atharva Raykar <raykar.ath@gmail.com>
In-Reply-To: <F3446051-620F-4C7B-A306-5C36922A976C@gmail.com>
Date:   Fri, 14 May 2021 21:30:10 +0530
Cc:     Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <DB9F1934-C7AF-4F44-853B-136C009910E9@gmail.com>
References: <E6E88000-9C18-4035-9A14-8B406617351A@gmail.com>
 <F3446051-620F-4C7B-A306-5C36922A976C@gmail.com>
To:     git <git@vger.kernel.org>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08-Apr-2021, at 15:49, Atharva Raykar <raykar.ath@gmail.com> wrote:
>=20
> Here's my updated draft. Changes since v1:
>=20
> - Elaborated more on example porting strategy, stating how the patches
>   could be broken up.
> - Made language at the end of section 6 less ambiguous.
> - Updated status of microproject.
> - s/git/Git in several places.
>=20
> Markdown version: =
https://gist.github.com/tfidfwastaken/0c6ca9ef2a452f110a416351541e0f19
>=20
> =
--8<-----8<-----8<-----8<-----8<-----8<-----8<-----8<-----8<-----8<-----8<=
--
>                          ___________________
>=20
>                           GSOC GIT PROPOSAL
>=20
>                             Atharva Raykar
>                          ___________________
>=20
>=20
> Table of Contents
> _________________
>=20
> 1. Personal Details
> 2. Background
> 3. Me and Git
> .. 1. Current knowledge of Git
> 4. The Project: Finish converting `git submodule' to builtin
> 5. Prior work
> 6. General implementation strategy
> 7. Timeline (using the format dd/mm)
> 8. Beyond GSoC
> 9. Blogging
> 10. Final Remarks: A little more about me
>=20
>=20
> 1 Personal Details
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
>  Name : Atharva Raykar
>  Major : Computer Science and Engineering
>  Email : raykar.ath@gmail.com
>  IRC nick : atharvaraykar on #git and #git-devel
>  Address : RB 103, Purva Riviera, Marathahalli, Bangalore
>  Postal Code : 560037
>  Time Zone : IST (UTC+5:30)
>  GitHub : github.com/tfidfwastaken
>=20
>=20
> 2 Background
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
>  I am Atharva Raykar, currently in my third year of studying Computer
>  Science and Engineering at PES University, Bangalore. I have always
>  enjoyed programming since a young age, but my deep appreciation for
>  good program design and creating the right abstractions came during =
my
>  exploration of the various rabbitholes of knowledge originating from
>  communities around the internet. I have personally enjoyed learning
>  about Functional Programming, Database Architecture and Operating
>  Systems, and my interests keep expanding as I explore more in this
>  field.
>=20
>  I owe my appreciation of this rich field to these communities, and I
>  always wanted to give back. With that goal, I restarted the [PES Open
>  Source] community in our campus, with the goal of creating spaces
>  where members could share knowledge, much in the same spirit as the
>  communities that kickstarted my journey in Computer Science. I learnt
>  a lot about collaborating in the open, maintainership, and reviewing
>  code. While I have made many small contributions to projects in the
>  past, I am hoping GSoC will help me make the leap to a larger and =
more
>  substantial contribution to one of my favourite projects that made it
>  all possible in my journey with Open Source.
>=20
>=20
> [PES Open Source] <https://pesos.github.io>
>=20
>=20
> 3 Me and Git
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
>  Here are the various forms of contributions that I have made to Git:
>=20
>  - [Microproject] userdiff: userdiff: add support for Scheme Status: =
In
>    progress, patch v3 requiring a review List:
>    =
<https://lore.kernel.org/git/20210408091442.22740-1-raykar.ath@gmail.com/>=

>=20
>  - [Git Education] Conducted a workshop with attendance of hundreds of
>    students new to git, and increased the prevalence of of git's usage
>    in my campus.
>    Photos: <https://photos.app.goo.gl/T7CPk1zkHdK7mx6v7> and
>    <https://photos.app.goo.gl/bzTgdHMttxDen6z9A>
>=20
>  I intend to continue helping people out on the mailing list and IRC
>  and tending to patches wherever possible in the meantime.
>=20
>=20
> 3.1 Current knowledge of Git
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>=20
>  I use Git almost daily in some form, and I am fairly comfortable with
>  it. I have already read and understood the chapters from the Git Book
>  about submodules along with the one on objects, references, packfiles
>  and the refspec.
>=20
>=20
> 4 The Project: Finish converting `git submodule' to builtin
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
>  Git has historically had many components implemented in the form of
>  shell scripts. This was less than ideal for several reasons:
>  - Portability: Non-POSIX systems like Windows don't play nice with
>    shell script commands like grep, cd and printf, to name a few, and
>    these commands have to be reimplemented for the system. There are
>    also POSIX to Windows path conversion issues.
>  - No direct access to plumbing: Shell commands do not have direct
>    access to the low level Git API, and a separate shell is spawned to
>    just to carry out their operations.
>  - Performance: Shell scripts tend to create a lot of child processes
>    which slows down the functioning of these commands, especially with
>    large repositories.
>  Over the years, many GSoC students have converted the shell versions
>  of these commands to C. Git `submodule' is the last of these to be
>  converted.
>=20
>=20
> 5 Prior work
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
>  I will be taking advantage of the knowledge that was gained in the
>  process of the converting the previous scripts and avoiding all the
>  gotchas that may be present in the process. There may be a bunch of
>  useful helper functions in the previous patches that can be reused as
>  well (more investigation needed to determine what exactly is
>  reusable).
>=20
>  Currently the only other commands left to be completed for =
`submodule'
>  are `add' and `update'. Work for `add' has already been started by a
>  previous GSoCer, Shourya Shukla, and needs to picked up from there.
>  `update' has had some of its functionality moved over to
>  `submodule--helper.c' where Stefan Beller added the helper functions
>  `update-clone', `update-module-mode', `remote-branch' and more.
>=20
>  References:
>  =
<https://github.com/gitgitgadget/git/issues/541#issuecomment-769245064>
>  <https://github.com/git/git/commit/4d6d6ef1fc>
>  =
<https://github.com/git/git/commit/48308681b072a1d32e1361c255347324a8ad151=
e>
>  =
<https://github.com/git/git/commit/ee69b2a90c5031bffb3341c5e50653a6ecca89a=
c>
>  =
<https://github.com/git/git/commit/92bbe7ccf1fedac825f2c6ab4c8de91dc5370fd=
2>
>=20
>  I'll have these as my references when I am working on the project:
>  His blog about his progress:
>  <https://shouryashukla.blogspot.com/2020/08/the-final-report.html>
>  (more has been implemented since)
>  Shourya's latest patch for `submodule add':
>  =
<https://lore.kernel.org/git/20201007074538.25891-1-shouryashukla.oo@gmail=
.com/>
>=20
>  For the most part, the implementation looks fairly complete, but =
there
>  seems to be a segfault occurring, along with a few changes suggested
>  by the reviewers. It will be helpful to contact Shourya to fully
>  understand what needs to be done.
>=20
>  Prathamesh's previous conversion work:
>  =
<https://lore.kernel.org/git/20170724203454.13947-1-pc44800@gmail.com/#t>
>=20
>  The ultimate goal would be to get rid of `git-submodules.sh'
>  altogether -- which will complete the porting efforts of `submodule'
>  to C.
>=20
>=20
> 6 General implementation strategy
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
>  The way to port the shell to C code for `submodule' will largely
>  remain the same. There already exists the builtin
>  `submodule--helper.c' which contains most of the previous commands'
>  ports. All that the shell script for `git-submodule.sh' is doing for
>  the previously completed ports is parsing the flags and then calling
>  the helper, which does all the business logic.
>=20
>  So I will be moving out all the business logic that the shell script
>  is performing to `submodule--helper.c'. Any reusable functionality
>  that is introduced during the port will be added to `submodule.c' in
>  the top level.
>=20
>      For example: The general strategy for converting `cmd_update()' =
would
>      be to have a call to `submodule--helper' in the shell script to a
>      function which would resemble something like `module_update()'. =
This
>      would perform the work being done by the shell script past the =
flags
>      being parsed and make the necessary call to `update_clone()', =
which
>      returns information about the cloned modules. For each cloned =
module,
>      it will find out the update mode through `module_update_mode()', =
and
>      run the appropriate operation according to that mode (like a =
rebase,
>      if that was the update mode).
>=20
>      One possible way this work can be broken up into multiple =
patches, is
>      by moving over the shell code into C in a bottom-up manner.
>      For example: The shell part which retrieves the latest revision =
in the
>      remote (if --remote is specified) can be wrapped into a command =
of
>      `submodule--helper.c'. Then we can move the part where we run the
>      update method (ie the `case' on line 611 onwards) into a C =
function.
>      Eventually, the shell part will just look like a bunch of =
invocations
>      to `submodule--helper', at which point, the whole thing can be
>      encapsulated in a single command called `git submodule--helper =
update'
>      (Bonus: Move the whole functionality to C, including the parsing =
of
>      flags, to work towards getting rid of `git-submodule.sh'). I =
believe
>      this is a fairly non-destructive and incremental way to work, and =
the
>      porting efforts by Stefan seem to follow this same kind of =
philosophy.
>      I will most likely end up tuning the size of these increments =
when I
>      get around to planning in my first phase of the project.
>=20
>  After this process, I will be adding the `add' and `update' command =
to
>  the commands array in `submodule--helper.c'. And since these two
>  functions are the last bit of functionality left to convert in
>  submodules, an extended goal can be to get rid of the shell script
>  altogether, and make the helper into the actual builtin [1].
>=20
>  [1]
>  =
<https://lore.kernel.org/git/nycvar.QRO.7.76.6.2011191327320.56@tvgsbejvaq=
bjf.bet/>

Hi all. I wanted to keep you informed, there have been some changes
in my personal schedule.

> 7 Timeline (using the format dd/mm)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
>  Periods of limited availability (read: hectic chaos):
>  - =46rom 13/04 to 20/04 I will be having project evaluations and lab
>    assessments for five of my courses.
>  - =46rom 20/04 to 01/05 I have my in-semester exams.
>  - For a period of two weeks in the range of 08/05 to 29/05 I will be
>    having my end-semester exams.
>  My commitment: I will still have time during my finals to help people
>  out on the mailing list, get acquainted with the community and its
>  processes, and even review patches if I can. This is because we get
>  holidays between each exam, and my grades are good enough to that I
>  can prioritise Git over my studies ;-)

Because of how hard COVID's second wave has hit my place, my exams
(which happen offline) had been indefinitely postponed. My university
has since given me the new dates for the finals -- either I give it on
June 2, or give it on an unannounced date in July. Either way it will
be happening during the GSoC coding period.

I just want to reiterate that I will be less available in the two weeks
during which the exams take place. I intend to work half-time on the
project only for those two weeks, and I don't mind working a little
extra on the other days to make up for it.

I will send another update for which slot I will be choosing *if* I get
selected for GSoC. Since the dates are shifting around a lot, according
to the situation, I will send updates on those as well.

>  And on the safe side, I will still engage with the community from now
>  till 07/06 so that the community bonding period is not compromised in
>  any way.
>=20
>  Periods of abundant availability: After 29/05 all the way to the =
first
>  week of August, I will be having my summer break, so I can dedicate
>  myself to Git full-time :-)
>=20
>  I would have also finished all my core courses, so even after that, I
>  will have enough of time to give back to Git past my GSoC period.
>=20
>  Phase 1: 07/06 to 14/06 -- Investigate and devise a strategy to port
>  the submodule functions
>  - This phase will be more diagrams in my notebook than code in my
>    editor -- I will go through all the methods used to port the other
>    submodule functions and see how to do the same for what is left.
>  - I will find the C equivalents of all the shell invocations in
>    `git-submodule.sh', and see what invocations have /no/ equivalent
>    and need to be created as helpers in C (Eg: What is the equivalent
>    to the `ensure-core-worktree' invocation in C?). For all the =
helpers
>    and new functionality that I do introduce, I will need to create =
the
>    testing strategy for the same.
>  - I will go through all the work done by Shourya in his patch, and =
try
>    to understand it properly. I will also see the mistakes that were
>    caught in all the reviews for previous submodule conversion patches
>    and try to learn from them before I jump to the code.
>  - Deliverable: I will create a checklist for all the work that needs
>    to be done with as much detail as I can with the help of inputs =
from
>    my mentor and all the knowledge I have gained in the process.
>=20
>  Phase 2: 14/06 to 28/06 -- Convert `add' to builtin in C
>  - I will work on completing `git submodule add'. One strategy would =
be
>    to either reimplement the whole thing using what was learnt in
>    Shourya's attempt, but it is probably wiser to just take his patch
>    and modify it. I would know what to do by the time I reach this
>    phase.
>  - I will also add tests for this functionality. I will also document
>    my changes when required. These would be unit tests for the helpers
>    introduced, and integration of `add' with the other commands.
>  - Deliverable: Completely port `add' to C!
>=20
>  Phase 3: 28/06 to 16/08 -- Convert `update' to builtin
>  - Some work has already been done by Stephan Beller that moves the
>    functionality of `update' to `submodule--helper.c':
>    =
<https://github.com/git/git/commit/48308681b072a1d32e1361c255347324a8ad151=
e>,
>    but a lot of the business logic of going into the submodule and
>    checking out or merging or rebasing needs to still be converted.
>    Plenty to do here.
>  - As with `add', all of the appropriate tests need to be written and
>    the changes documented. As I have learnt from the Pro Git Book,
>    there are a lot of subtleties with how update does its work that I
>    need to watch out for.
>  - Deliverable: Completely port `update' to C!
>=20
>  Bonus Phase: If I am ahead of time -- Remove the need for a
>  `submodule--helper', and make it a proper C builtin.
>  - Once all the submodule functionality is ported, the shell script is
>    not really doing much more than parsing the arguments and passing =
it
>    to the helper. We won't need this anymore if it is implemented.
>=20
>=20
> 8 Beyond GSoC
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
>  I love the process of working as a community more than anything else,
>  and I already felt very welcomed by the Git community the moment I
>  started sending in my microproject patch series. Whether I am =
selected
>  or not, I will continue giving back to Git wherever I can. Since my
>  final year is light on coursework, I will be able to mentor people =
and
>  help expand the Git developer community through all the ways I can =
(be
>  it code review, helping people find the right resources or evangelism
>  of Git).
>=20
>=20
> 9 Blogging
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
>  I will be blogging about my progress on a weekly basis and either =
post
>  it on my website at <https://atharvaraykar.me> (probably will tuck it
>  away in a /gsoc path). Technical blogging is not particularly new to
>  me, and I hope my posts can help future contributors of Git.
>=20
>=20
> 10 Final Remarks: A little more about me
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
>  These are some of my core values that I believe will be important to
>  pull off this project and make the most of my time in GSoC:
>  - Hard problems don't frustrate me, rather they excite me. Bugs make
>    my brain perk up. I love the process of learning.
>  - I am pro-transparency. If I am having some trouble, I will be open
>    about it. I don't hesitate to ask questions and dig deep if I need
>    to.
>  - At the same time, when I ask a question, I only do so after I have
>    struggled with the problem for enough time and done my due =
diligence
>    in trying to solve it. Clear communication is very important to =
make
>    this work.
>  - I am also very comfortable with learning things all on my own (I
>    have barely known any other way), and working in a remote,
>    asynchronous setting.
>  I hope to make the world better in my own small way by contributing =
to
>  a tool that everyone uses and I like. It's more rewarding than any
>  internship that my peers are doing this year. I look forward to
>  learning more.
>=20

--
Atharva Raykar

