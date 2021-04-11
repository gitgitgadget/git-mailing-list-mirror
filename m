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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D860C433B4
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 10:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEE0D6108F
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 10:17:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235284AbhDKKSM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Apr 2021 06:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbhDKKSC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Apr 2021 06:18:02 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90EBC061574
        for <git@vger.kernel.org>; Sun, 11 Apr 2021 03:17:45 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id p10so4837907pld.0
        for <git@vger.kernel.org>; Sun, 11 Apr 2021 03:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Tc3YS9l6+G/f2n+gFwQrOWVXNN7NmQ9/MV8BCNkgIsY=;
        b=eb8TRQVaFJQ/PtEhJQOtvVgQilbYjbRKdQbIkM1C4m5HtLBUGQkUxNbCsawbwr4wke
         yfu9h7z68VjKf6NrxCsJ7fVUBgUwKsm9+gI/cNyrlhE3DNH6F7wo+3LjUfonNGTXJSgI
         EhWM+h1cOk72X6OEJZWXiMmaw+D0In/5icpXLcmw0WrzjMxDlDBm5BaC7/uTi5zW50+C
         6VMFeO4nXNBDSQfsRDW/FhA13nOibQP19batrUI5zQ/zYsxUhbVwU5WdKC2l7DoP9sDk
         NtXAnngR5crlugOHqkt67AK+lKfhhUWn2rVPjpJ4gbKOpp4MfKnRn4OPIqwGPBKpumrl
         tyXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Tc3YS9l6+G/f2n+gFwQrOWVXNN7NmQ9/MV8BCNkgIsY=;
        b=jZNSG7x8PXqh2Fp/5OMib9K0SrZ5pDoQaRIjYUQHmkWexEOgavfAPKCfaXeVjDg2ZJ
         90AIQZsbkRbrGzNfbKzoJTsxAzeV2laInbdVyzb7yGMsY8Ru7skN85RfSD5ol8qneudM
         kgHbOG2OAK1tWBQrRcY5FoZti90QvTCoEfvKcFkHcnN98RJrgHnkkvoI/49UFeJfEpEV
         rpJ4KvIN2UzkRvDceK280/Y3X/9txgWvvqA45Vt85EwTcJvUzNWNiV6zWqTEOkx4kNwC
         tPl+bcxbC4PC1zFKkEGz/tXK5MdXDn/x0ZJJhhMf5IFecHdse8xNOBp9gPO45ENdBC7d
         JuVQ==
X-Gm-Message-State: AOAM532l0TVLEZboN4F2PVh6zsBRhYt97A0ODrd7VVMCjH4m31LKPkWo
        BFaJInAXyEKrY6qP9MIhU2N9NK/DeDC2yA==
X-Google-Smtp-Source: ABdhPJx33G9FCLtnERMM8X1NrhvXiZmE+Q/eyuKifk2x83BIN8Y2vwxn1n1LheFaZwzvHdlWsLVLFQ==
X-Received: by 2002:a17:902:d506:b029:e9:a6e9:b48b with SMTP id b6-20020a170902d506b02900e9a6e9b48bmr13138360plg.71.1618136264805;
        Sun, 11 Apr 2021 03:17:44 -0700 (PDT)
Received: from atharva-on-air.dlink ([180.151.104.48])
        by smtp.gmail.com with ESMTPSA id n4sm6987102pfu.45.2021.04.11.03.17.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Apr 2021 03:17:44 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: [GSoC][Draft Proposal v3] Finish converting git submodule to builtin
From:   Atharva Raykar <raykar.ath@gmail.com>
In-Reply-To: <F3446051-620F-4C7B-A306-5C36922A976C@gmail.com>
Date:   Sun, 11 Apr 2021 15:47:41 +0530
Cc:     christian.couder@gmail.com, shouryashukla.oo@gmail.com,
        periperidip@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <483DAACA-28AA-462F-B721-9492DCD38DD1@gmail.com>
References: <E6E88000-9C18-4035-9A14-8B406617351A@gmail.com>
 <F3446051-620F-4C7B-A306-5C36922A976C@gmail.com>
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v2:

- Add more detail in my example of how I would convert `submodule =
update`
  -- mainly I showed possible names for the invocations, the arguments =
it
  takes, and operations it performs.

- Clarify that `module_update()` is a function that I will write, and
  does not currently exist in the codebase.

- Add stepwise high-level workflow in section 6

- Exorcise the last remaining gits and bring back Gits

Markdown version: =
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
.. 1. Current knowledge of Git
4. The Project: Finish converting `git submodule' to builtin
5. Prior work
6. General implementation strategy
7. Timeline (using the format dd/mm)
8. Beyond GSoC
9. Blogging
10. Final Remarks: A little more about me


1 Personal Details
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

  Name : Atharva Raykar
  Major : Computer Science and Engineering
  Email : raykar.ath@gmail.com
  IRC nick : atharvaraykar on #git and #git-devel
  Address : RB 103, Purva Riviera, Marathahalli, Bangalore
  Postal Code : 560037
  Time Zone : IST (UTC+5:30)
  GitHub : github.com/tfidfwastaken


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

  - [Microproject] userdiff: add support for Scheme
    Status: In progress, patch v3 requiring a review
    List: =
<https://lore.kernel.org/git/20210408091442.22740-1-raykar.ath@gmail.com/>=


  - [Git Education] Conducted a workshop with attendance of hundreds of
    students new to Git, and increased the prevalence of of Git's usage
    in my campus.
    Photos: <https://photos.app.goo.gl/T7CPk1zkHdK7mx6v7> and
    <https://photos.app.goo.gl/bzTgdHMttxDen6z9A>

  I intend to continue helping people out on the mailing list and IRC
  and tending to patches wherever possible in the meantime.


3.1 Current knowledge of Git
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  I use Git almost daily in some form, and I am fairly comfortable with
  it. I have already read and understood the chapters from the Git Book
  about submodules along with the one on objects, references, packfiles
  and the refspec.


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
    access to the low level Git API, and a separate shell is spawned to
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
  `update' has had some of its functionality moved over to
  `submodule--helper.c' where Stefan Beller added the helper functions
  `update-clone', `update-module-mode', `remote-branch' and more.

  References:
  =
<https://github.com/gitgitgadget/git/issues/541#issuecomment-769245064>
  <https://github.com/git/git/commit/4d6d6ef1fc>
  =
<https://github.com/git/git/commit/48308681b072a1d32e1361c255347324a8ad151=
e>
  =
<https://github.com/git/git/commit/ee69b2a90c5031bffb3341c5e50653a6ecca89a=
c>
  =
<https://github.com/git/git/commit/92bbe7ccf1fedac825f2c6ab4c8de91dc5370fd=
2>

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

  The ultimate goal would be to get rid of `git-submodules.sh'
  altogether -- which will complete the porting efforts of `submodule'
  to C.


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

      For example: The general strategy for converting `cmd_update()' =
would
      be to have an invocation of to `submodule--helper update <flags>' =
in
      the shell script which maps to a C function which I would create,
      named `module_update()'. This would perform the work being done by =
the
      shell script past the flags being parsed and make the necessary =
call
      to `update_clone()'.
      `update_clone()' takes care of cloning all the submodules and =
returns
      their SHA1, whether the module was just cloned, and the path to =
the
      submodule. For each cloned module, it uses the information in =
those
      entries to find out the update mode through =
`module_update_mode()',
      and run the appropriate operation according to that mode (like a
      rebase, if that was the update mode). The SHA1 from =
`update_clone()'
      helps us determine whether we need to update the submodules to =
match
      what the superproject expects.

      One possible way this work can be broken up into multiple patches =
is
      by moving over the shell code into C in a bottom-up manner.

      For example: The shell part which retrieves the latest revision in =
the
      remote (if --remote is specified) can be wrapped into an =
invocation
      like `git submodule--helper update-remote ${nofetch:+--nofetch}
      <sm_path>'. This would return the remote name and SHA1 for the =
remote
      tracked by the submodule. Then we can move the part where we run =
the
      update method (ie the `case' on line 611 onwards) into a C =
function
      that is invoked by something that looks like `git =
submodule--helper
      run-update-operation $update-module'. This will run the update
      function, ie, either checkout, merge or rebase depending on the =
flags
      passed, or configuration setup by the end user. Eventually, the =
shell
      part will just look like a bunch of invocations to
      `submodule--helper', at which point, the whole thing can be
      encapsulated in a single command called `git submodule--helper =
update
      <flags>' (Bonus: Move the whole functionality to C, including the
      parsing of flags, to work towards getting rid of =
`git-submodule.sh').
      I believe this is a fairly non-destructive and incremental way to
      work, and the porting efforts by Stefan seem to follow this same =
kind
      of philosophy. I will most likely end up tuning the size of these
      increments when I get around to planning in my first phase of the
      project.

  What I have mentioned above is just illustrating what my workflow
  might look like, and the details are subject to change as I will
  probably discover nicer ways to get to the end goal of moving
  everything to `submodule--helper'. What will remain unchanged though,
  is my high level workflow, which can be summarized to these four
  steps:

  1. Identify parts in git-submodule.sh that have cohesive functionality
  2. Rewrite that functionality in C, which can be invoked from `git
     submodule--helper <function name> <args>`
  3. Remove the shell code and replace it with the above invocation.
     This could be sent as one patch, making it easier to review. Steps
     1 to 3 are repeated until the shell code is reduced to a bunch of
     calls to `submodule--helper'
  4. Once the shell code is reduced to only a bunch of calls to
     `submodule--helper', wrap all of that into one call that looks like
     `git submodule--helper update <flags>' that encapsulates all the
     functionality done by the other helper function calls.

  After this process, I will be adding the `add' and `update' command to
  the commands array in `submodule--helper.c'. And since these two
  functions are the last bit of functionality left to convert in
  submodules, an extended goal can be to get rid of the shell script
  altogether, and make the helper into the actual builtin [1].

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
  can prioritise Git over my studies ;-)

  And on the safe side, I will still engage with the community from now
  till 07/06 so that the community bonding period is not compromised in
  any way.

  Periods of abundant availability: After 29/05 all the way to the first
  week of August, I will be having my summer break, so I can dedicate
  myself to Git full-time :-)

  I would have also finished all my core courses, so even after that, I
  will have enough of time to give back to Git past my GSoC period.

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
  and I already felt very welcomed by the Git community the moment I
  started sending in my microproject patch series. Whether I am selected
  or not, I will continue giving back to Git wherever I can. Since my
  final year is light on coursework, I will be able to mentor people and
  help expand the Git developer community through all the ways I can (be
  it code review, helping people find the right resources or evangelism
  of Git).


9 Blogging
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

  I will be blogging about my progress on a weekly basis and either post
  it on my website at <https://atharvaraykar.me> (probably will tuck it
  away in a /gsoc path). Technical blogging is not particularly new to
  me, and I hope my posts can help future contributors of Git.


10 Final Remarks: A little more about me
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

  These are some of my core values that I believe will be important to
  pull off this project and make the most of my time in GSoC:
  - Hard problems don't frustrate me, rather they excite me. Bugs make
    my brain perk up. I love the process of learning.
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

