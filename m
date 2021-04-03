Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C806C433ED
	for <git@archiver.kernel.org>; Sat,  3 Apr 2021 14:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63F4C611ED
	for <git@archiver.kernel.org>; Sat,  3 Apr 2021 14:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236720AbhDCOIx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Apr 2021 10:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236380AbhDCOIw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Apr 2021 10:08:52 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275A5C0613E6
        for <git@vger.kernel.org>; Sat,  3 Apr 2021 07:08:50 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id il9-20020a17090b1649b0290114bcb0d6c2so5830839pjb.0
        for <git@vger.kernel.org>; Sat, 03 Apr 2021 07:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :cc:to;
        bh=xCoBc+j1m6Hs+3UG/4uX4i9TaxW0SNygGt9LA+eAoNI=;
        b=rGZCdCP8lJPb0etU9MAHtKaKcmookTx1UylNVELNXvcl5Psv89dthrCmCKLyv5/4Kz
         NRE6SFxBuxtd8/mFrrEbzxANK2Eb1b5e5/ckC7yomwmRhNoM84bH6knwwWolCLqz+Fpr
         ZYGU2cGPiaYDru0VHEZkoMRC2POwotWsRdhO5dTD0VRV+LItNY/5fwr9TQbILGVuwdKk
         GnPMpCTUAjZNsISYdSdmsS9CEYY2Roce4LZL+1TDMuHnVdcWw03BDPDLFY1LpM9HV71o
         if1NbaCMP6r3f3Z9PAS0z1BzpAl2F3/tam6z8r7Ndc1DSEW3+dqrpcj720AHYfxw2X0e
         5NNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=xCoBc+j1m6Hs+3UG/4uX4i9TaxW0SNygGt9LA+eAoNI=;
        b=hK3K/gvDXaPrK+5d0F+XwVU1LVh7e/3/f7j5w6guKzMUcOV9zgC4aJHP/aCkrg6Hts
         Y/yrwpdVCxacFPmAbOCrp6WIazG8XDc/5kglyZ2+s8Wy2dPRcEWCujHwzrMM28gOCRPF
         QsXs35ruI4TZxbvC7dBjvW6ZecB6Cd1+L4mvS6BL8eLqcNI790L3lSo7361lpwstxCUu
         z+PDo08lOWhiHO43alrDwyKoQNh7huabIPJ1NMDICIr+PGVnjsAv7PuWfr5D7tzxyF/k
         Hl4fI66RnsJGhY2u6EkegvpDoO30GOjBr73aTsP0AKW3zNoL1+LrZdIxRHSC0zM5NBmX
         YU4Q==
X-Gm-Message-State: AOAM5311aOgkg+7S2Yq1Aw5pbzNTZoa4d0zPdsXIkuxS9ZVMpeYnXx+I
        9SLftTFwTcrH5asIjk6zrA5/BM33+8Lq2w==
X-Google-Smtp-Source: ABdhPJw2xXDWFBQeCpdQCIGnIgYjbKhjKid18DDts1Tdf0sToLutWSl2PbELUU+R5kqTJZ6nsXpqKA==
X-Received: by 2002:a17:902:fe07:b029:e6:6cba:d95a with SMTP id g7-20020a170902fe07b02900e66cbad95amr16908728plj.70.1617458928123;
        Sat, 03 Apr 2021 07:08:48 -0700 (PDT)
Received: from atharva-on-air.dlink ([119.82.121.20])
        by smtp.gmail.com with ESMTPSA id w7sm6602786pff.208.2021.04.03.07.08.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Apr 2021 07:08:47 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: [GSoC][Draft Proposal] Finish converting git submodule to builtin
Message-Id: <E6E88000-9C18-4035-9A14-8B406617351A@gmail.com>
Date:   Sat, 3 Apr 2021 19:38:43 +0530
Cc:     christian.couder@gmail.com, shouryashukla.oo@gmail.com,
        periperidip@gmail.com
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

Below is my draft of my GSoC proposal. I have noticed that Chinmoy has =
already
submitted a proposal for the same idea before me, so would that be =
considered
"taken"? (I don't think I can submit another proposal for the other idea =
either,
because someone has already sent one for that as well)

Since I have already put my effort into this for a while, I thought I =
might as
well send it, but I'll accept whatever the mentors say about the =
eligibility of
this proposal.

Here is a prettier markdown version:
https://gist.github.com/tfidfwastaken/0c6ca9ef2a452f110a416351541e0f19


=
--8<-----8<-----8<-----8<-----8<-----8<-----8<-----8<-----8<-----8<-----8<=
--

                          ___________________

                           GSOC GIT PROPOSAL

                             Atharva Raykar
                          ___________________


Table of Contents
_________________

1. Personal Details
2. Background
3. Me and Git
.. 1. Current knowledge of git
4. The Project: Finish converting `git submodule' to builtin
5. Prior work
6. General implementation strategy
7. Timeline (using the format dd/mm)
8. Beyond GSoC
9. Blogging
10. Final Remarks: A little more about me


1 Personal Details
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

  Name        : Atharva Raykar
  Major       : Computer Science and Engineering
  Email       : raykar.ath@gmail.com
  IRC nick    : atharvaraykar on #git and #git-devel
  Address     : RB 103, Purva Riviera, Marathahalli, Bangalore
  Postal Code : 560037
  Time Zone   : IST (UTC+5:30)
  GitHub      : http://github.com/tfidfwastaken


2 Background
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

  I am Atharva Raykar, currently in my third year of studying Computer
  Science and Engineering at PES University, Bangalore. I have always
  enjoyed programming since a young age, but my deep appreciation for
  good program design and creating the right abstractions came during my
  exploration of the various rabbitholes of knowledge originating from
  communities around the internet. I have personally enjoyed learning
  about Functional Programming, Database Architecture and Operating
  Systems, and my interests keep expanding as I explore more in this
  field.

  I owe my appreciation of this rich field to these communities, and I
  always wanted to give back. With that goal, I restarted the [PES Open
  Source] community in our campus, with the goal of creating spaces
  where members could share knowledge, much in the same spirit as the
  communities that kickstarted my journey in Computer Science. I learnt
  a lot about collaborating in the open, maintainership, and reviewing
  code. While I have made many small contributions to projects in the
  past, I am hoping GSoC will help me make the leap to a larger and more
  substantial contribution to one of my favourite projects that made it
  all possible in my journey with Open Source.


[PES Open Source] <https://pesos.github.io>


3 Me and Git
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

  Here are the various forms of contributions that I have made to Git:

  - [Microproject] userdiff: userdiff: add support for Scheme Status: In
    progress, patch v2 pending List:
    =
<https://public-inbox.org/git/20210327173938.59391-1-raykar.ath@gmail.com/=
>

  - [Git Education] Conducted a workshop with attendance of hundreds of
    students new to git, and increased the prevalence of of git's usage
    in my campus.
    Photos: <https://photos.app.goo.gl/T7CPk1zkHdK7mx6v7> and
    <https://photos.app.goo.gl/bzTgdHMttxDen6z9A>

  I intend to continue helping people out on the mailing list and IRC
  and tending to patches wherever possible in the meantime.


3.1 Current knowledge of git
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  I use git almost daily in some form, and I am fairly comfortable with
  it. I have already read and understood the chapters from the Git
  Book about submodules along with the one on objects, references,
  packfiles and the refspec.


4 The Project: Finish converting `git submodule' to builtin
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D

  Git has historically had many components implemented in the form of
  shell scripts. This was less than ideal for several reasons:
  - Portability: Non-POSIX systems like Windows don't play nice with
    shell script commands like grep, cd and printf, to name a few, and
    these commands have to be reimplemented for the system. There are
    also POSIX to Windows path conversion issues.
  - No direct access to plumbing: Shell commands do not have direct
    access to the low level git API, and a separate shell is spawned to
    just to carry out their operations.
  - Performance: Shell scripts tend to create a lot of child processes
    which slows down the functioning of these commands, especially with
    large repositories.
  Over the years, many GSoC students have converted the shell versions
  of these commands to C. Git `submodule' is the last of these to be
  converted.


5 Prior work
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

  I will be taking advantage of the knowledge that was gained in the
  process of the converting the previous scripts and avoiding all the
  gotchas that may be present in the process. There may be a bunch of
  useful helper functions in the previous patches that can be reused as
  well (more investigation needed to determine what exactly is
  reusable).

  Currently the only other commands left to be completed for `submodule'
  are `add' and `update'. Work for `add' has already been started by a
  previous GSoCer, Shourya Shukla, and needs to picked up from there.

  Reference:
  =
<https://github.com/gitgitgadget/git/issues/541#issuecomment-769245064>

  I'll have these as my references when I am working on the project:
  His blog about his progress:
  <https://shouryashukla.blogspot.com/2020/08/the-final-report.html>
  (more has been implemented since)
  Shourya's latest patch for `submodule add':
  =
<https://lore.kernel.org/git/20201007074538.25891-1-shouryashukla.oo@gmail=
.com/>

  For the most part, the implementation looks fairly complete, but there
  seems to be a segfault occurring, along with a few changes suggested
  by the reviewers. It will be helpful to contact Shourya to fully
  understand what needs to be done.

  Prathamesh's previous conversion work:
  =
<https://lore.kernel.org/git/20170724203454.13947-1-pc44800@gmail.com/#t>


6 General implementation strategy
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D

  The way to port the shell to C code for `submodule' will largely
  remain the same. There already exists the builtin
  `submodule--helper.c' which contains most of the previous commands'
  ports. All that the shell script for `git-submodule.sh' is doing for
  the previously completed ports is parsing the flags and then calling
  the helper, which does all the business logic.

  So I will be moving out all the business logic that the shell script
  is performing to `submodule--helper.c'. Any reusable functionality
  that is introduced during the port will be added to `submodule.c' in
  the top level.

  For example: The general strategy for converting `cmd_update()' would
  be to have a call to `submodule--helper' in the shell script to a
  function which would resemble something like `module_update()' which
  would perform the work being done by the shell script past the flags
  being parsed and make the necessary calls to `update_clone()', and the
  git interface in C for performing the merging, checkout and rebase
  where necessary.

  After this process, the builtin is added to the commands array in
  `submodule--helper.c'. And since these two functions are the last bit
  of functionality left to convert in submodules, an extended goal can
  be to get rid of the shell script altogether, and make the helper into
  the actual builtin [1].

  [1]
  =
<https://lore.kernel.org/git/nycvar.QRO.7.76.6.2011191327320.56@tvgsbejvaq=
bjf.bet/>


7 Timeline (using the format dd/mm)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

  Periods of limited availability (read: hectic chaos):
  - =46rom 13/04 to 20/04 I will be having project evaluations and lab
    assessments for five of my courses.
  - =46rom 20/04 to 01/05 I have my in-semester exams.
  - For a period of two weeks in the range of 08/05 to 29/05 I will be
    having my end-semester exams.
  My commitment: I will still have time during my finals to help people
  out on the mailing list, get acquainted with the community and its
  processes, and even review patches if I can. This is because we get
  holidays between each exam, and my grades are good enough to that I
  can prioritise git over my studies ;-)

  And on the safe side, I will still engage with the community from now
  till 07/06 so that the community bonding period is not compromised in
  any way.

  Periods of abundant availability: After 29/05 all the way to the first
  week of August, I will be having my summer break, so I can dedicate
  myself to git full-time :-)

  I would have also finished all my core courses, so even after that, I
  will have enough of time to give back to git past my GSoC period.

  Phase 1: 07/06 to 14/06 -- Investigate and devise a strategy to port
  the submodule functions
  - This phase will be more diagrams in my notebook than code in my
    editor -- I will go through all the methods used to port the other
    submodule functions and see how to do the same for what is left.
  - I will find the C equivalents of all the shell invocations in
    `git-submodule.sh', and see what invocations have /no/ equivalent
    and need to be created as helpers in C (Eg: What is the equivalent
    to the `ensure-core-worktree' invocation in C?). For all the helpers
    and new functionality that I do introduce, I will need to create the
    testing strategy for the same.
  - I will go through all the work done by Shourya in his patch, and try
    to understand it properly. I will also see the mistakes that were
    caught in all the reviews for previous submodule conversion patches
    and try to learn from them before I jump to the code.
  - Deliverable: I will create a checklist for all the work that needs
    to be done with as much detail as I can with the help of inputs from
    my mentor and all the knowledge I have gained in the process.

  Phase 2: 14/06 to 28/06 -- Convert `add' to builtin in C
  - I will work on completing `git submodule add'. One strategy would be
    to either reimplement the whole thing using what was learnt in
    Shourya's attempt, but it is probably wiser to just take his patch
    and modify it. I would know what to do by the time I reach this
    phase.
  - I will also add tests for this functionality. I will also document
    my changes when required. These would be unit tests for the helpers
    introduced, and integration of `add' with the other commands.
  - Deliverable: Completely port `add' to C!

  Phase 3: 28/06 to 16/08 -- Convert `update' to builtin
  - Some work has already been done by Stephan Beller that moves the
    functionality of `update' to `submodule--helper.c':
    =
<https://github.com/git/git/commit/48308681b072a1d32e1361c255347324a8ad151=
e>,
    but a lot of the business logic of going into the submodule and
    checking out or merging or rebasing needs to still be converted.
    Plenty to do here.
  - As with `add', all of the appropriate tests need to be written and
    the changes documented. As I have learnt from the Pro Git Book,
    there are a lot of subtleties with how update does its work that I
    need to watch out for.
  - Deliverable: Completely port `update' to C!

  Bonus Phase: If I am ahead of time -- Remove the need for a
  `submodule--helper', and make it a proper C builtin.
  - Once all the submodule functionality is ported, the shell script is
    not really doing much more than parsing the arguments and passing it
    to the helper. We won't need this anymore if it is implemented.


8 Beyond GSoC
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

  I love the process of working as a community more than anything else,
  and I already felt very welcomed by the git community the moment I
  started sending in my microproject patch series. Whether I am selected
  or not, I will continue giving back to git wherever I can. Since my
  final year is light on coursework, I will be able to mentor people and
  help expand the git developer community through all the ways I can (be
  it code review, helping people find the right resources or evangelism
  of git).


9 Blogging
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

  I will be blogging about my progress on a weekly basis and either post
  it on my website at <https://atharvaraykar.me> (probably will tuck it
  away in a /gsoc path). Technical blogging is not particularly new to
  me, and I hope my posts can help future contributors of git.


10 Final Remarks: A little more about me
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

  These are some of my core values that I believe will be important to
  pull off this project and make the most of my time in GSoC:
  - Hard problems don't frustrate me, rather they excite me. Bugs make
    my brain perk up (this sentence best left with context). I love
    learning.
  - I am pro-transparency. If I am having some trouble, I will be open
    about it. I don't hesitate to ask questions and dig deep if I need
    to.
  - At the same time, when I ask a question, I only do so after I have
    struggled with the problem for enough time and done my due diligence
    in trying to solve it. Clear communication is very important to make
    this work.
  - I am also very comfortable with learning things all on my own (I
    have barely known any other way), and working in a remote,
    asynchronous setting.
  I hope to make the world better in my own small way by contributing to
  a tool that everyone uses and I like. It's more rewarding than any
  internship that my peers are doing this year. I look forward to
  learning more.

