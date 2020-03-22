Return-Path: <SRS0=O1OI=5H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94106C4332B
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 14:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46E9D2072D
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 14:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tpF1EKA2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgCVO4R (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Mar 2020 10:56:17 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38468 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbgCVO4Q (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Mar 2020 10:56:16 -0400
Received: by mail-ot1-f65.google.com with SMTP id t28so10830958ott.5
        for <git@vger.kernel.org>; Sun, 22 Mar 2020 07:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/7f6BkqYyiJWStSXWV5hQpsc/y6gnbmVJ50PCf7RQ0c=;
        b=tpF1EKA2Wf1l+wH22eR5EbJEJYzDhc9V9Ib/4ZG+AUrecz0C1Oy3JzbhBIe0s9bGQ9
         fsQLJ0IvM9dBudCm6G5ZkSVdZiJkAsqqEnttbsqBJ7clt2Fixk96Xd+4Ow6/gmr20OoG
         aKHnd5v+waOTqZ6yywJ1YrMym1lfEHLdjzHRUPI3oMNKifTrJJ60rOp5VH2evz8Ck/c/
         L/6wQ4KcNlIzPWgDPE+5eS4z8SbctIu+X5foGp4uzc3cE2WYdnVCfhod6G/ZmbNcHXs+
         gIbZDwZapfFAdobel+t8YPTsE7+e79fzF9CzavlYsvxNLP27igOtoGncdYQAoG8J2/FO
         IZuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/7f6BkqYyiJWStSXWV5hQpsc/y6gnbmVJ50PCf7RQ0c=;
        b=czNIdbDiyHq8Vp84Xs1QAYZSzzjZgs1r2qRGT2hOJwtrOznni7emLij65KK6AZlhp+
         6K2nhX4WKAWc7HI5XG9BYqw5BGw9TIVO4izwWt9cvh9HHtGEhmgyQshhpvn9V2ht228C
         LAw1U1GRHpzbwg0b1kjap+/5kMr9moWkqi1EC4naZybj5+RUWz1Jxaq0FRN4+IoCFO2X
         RCDSq55YHd/KFHQ8LA5xEKDq5QxYiS8Rnjomw/q3zbJJONv4HvQfFh6uXtePsaB1JviY
         UkiBD2UuOtrtcctDvhYjFQVVg08JxviaKZNX9VCAwf0TAMLVf9zHI7DBe0qh1a4mt+yX
         Fg9w==
X-Gm-Message-State: ANhLgQ3rqPvMMytBhOiUx3MJWmwX2buzuLa7vwlmq0KpbFCQXmcVafmS
        MLHciq+AGWrAIUoWe81aOkzxs8Ke5MyrfKRSzySESjFOAII=
X-Google-Smtp-Source: ADFU+vsmEDgvckHNPR61YIjLj9jp4jzQ7vXz42j+mGgE03YQBD1YL7kSzhKrzUGHkWeC78rwSVZHSUbqsrP9gOm97Y4=
X-Received: by 2002:a9d:720a:: with SMTP id u10mr13690930otj.177.1584888974890;
 Sun, 22 Mar 2020 07:56:14 -0700 (PDT)
MIME-Version: 1.0
References: <CA+CkUQ-dhyd_5ey1z-v59FzNyWFFVosMBfunSnN5t1EqxVMvVw@mail.gmail.com>
In-Reply-To: <CA+CkUQ-dhyd_5ey1z-v59FzNyWFFVosMBfunSnN5t1EqxVMvVw@mail.gmail.com>
From:   Hariom verma <hariom18599@gmail.com>
Date:   Sun, 22 Mar 2020 20:26:02 +0530
Message-ID: <CA+CkUQ__JPsLCkkdHg7gh8J7VvXLA+v2j3NgV6cZAw94if=9mA@mail.gmail.com>
Subject: [GSoC][RFC][PROPOSAL v3] Unify ref-filter formats with other --pretty formats
To:     git <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>,
        johannes.schindelin@gmx.de, peff@peff.net,
        Junio C Hamano <gitster@pobox.com>, t.gummerer@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I would love to get my proposal reviewed and have suggestions from you all.

Thanks,
Hariom

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Link to docs: https://docs.google.com/document/d/15GPvle6S0iNg430aJx-gMrXvs=
gnzTlFNFhyP-K6Zmtw/edit?usp=3Dsharing

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

**Unify ref-filter formats with other --pretty formats**

Name  :  Hariom Verma
Major  :  Computer Science and Engineering
Mobile no.  : [...]
Email  : [...]
IRC : harry-hov (on #git-devel@freenode)
Github : harry-hov
Linkedin : https://www.linkedin.com/in/harry-hov/
Time Zone  : IST (UTC +05:30)

## About me

I am a Computer Science undergraduate at Shri G S Institute of
Technology & Science, Indore, India. I am passionate about software
freedom and open source communities. I've been writing in C, C++,
Python & Dart for almost 3 years, and contributed to some projects
which can be seen on [Github](https://github.com/harry-hov).

I=E2=80=99m contributing to Git since Oct 2019 and would love to be a membe=
r
of such a versatile community.

## Me & Git

My contributions have helped me understand the review and patch
submission process in a better way. Also, I now feel a bit more
comfortable with Git=E2=80=99s codebase.

------------------------------
[PATCH] t2402: test worktree path when called in .git directory
Status: Merged into master
Mailing List: https://public-inbox.org/git/pull.570.git.1583305200143.gitgi=
tgadget@gmail.com/
Github: https://github.com/git/git/commit/4d864895a23bbbb5403d9aa8a65d0576d=
2029597

------------------------------
[PATCH v3 3/3] receive.denyCurrentBranch: respect all worktrees
[PATCH v3 2/3] t5509: use a bare repository for test push target
[PATCH v3 1/3] get_main_worktree(): allow it to be called in the Git direct=
ory
Status: Merged into master
Mailing List:
[3/3]: https://public-inbox.org/git/d21a590d6c23f231c54b731b737c363b83660f7=
9.1582484231.git.gitgitgadget@gmail.com/
[2/3]: https://public-inbox.org/git/ae749310f067c43429741987cd9f47c1ae4ceb3=
f.1582484231.git.gitgitgadget@gmail.com/
[1/3]: https://public-inbox.org/git/8718facbc951614f19407afa6ca8d6110507483=
d.1582484231.git.gitgitgadget@gmail.com/
Github:
[3/3]: https://github.com/git/git/commit/4ef346482d6d5748861c1aa9d56712e847=
369b40
[2/3]: https://github.com/git/git/commit/f8692114dbb1b3ffe0b71871a015c632c1=
95b784
[1/3]: https://github.com/git/git/commit/45f274fbb118cc4cb00640c30b4e3069d9=
6755a0

------------------------------
[PATCH 1/1] git-compat-util.h: drop the `PRIuMAX` and other fallback defini=
tions
Status: Merged into master
Mailing List:
https://public-inbox.org/git/177deddcf83c2550c0db536a7a6942ba69a92fa5.15746=
00963.git.gitgitgadget@gmail.com/
Github: https://github.com/git/git/commit/e547e5a89e3641bae02e762bcb0062951=
bb698e5

------------------------------
[PATCH v2 1/1] builtin/blame.c: constants into bit shift format
Status: Merged into master
Mailing List:
https://public-inbox.org/git/838478a185322572ed4747eb484b678a8e2d7ac6.15713=
34411.git.gitgitgadget@gmail.com/
Github: https://github.com/git/git/commit/86795774bb9ca3c63b94d3d0930405c1b=
a9148ec

## Proposed Project

### Abstract

Git has an old problem of duplicated implementations of some logic.
For example, Git had at least 4 different implementations to format
command output for different commands. The foremost aim of this
project is to simplify codebase by getting rid of duplication of a
similar logic and, as a result, simplify adding new functionality.
The current task is to reuse ref-filter formatting logic in pretty to
minimize code duplication and to have one unified interface to extract
all needed data from the object and to print it properly.

### Previous Work

Olga<olyatelezhnaya@gmail.com> has done great work in =E2=80=9CUnifying Git=
=E2=80=99s
format languages=E2=80=9D during Outreachy Round 15. Her work is mostly
related to `cat-file` and `ref-filter`.
She already did a pretty nice job in preparing ref-filter for more
general usage of its formatting logic. It will give me the possibility
to make a migration of pretty.c easier.

### Potential Problem

The biggest challenge is to maintain backward compatibility while
using reuse ref-filter formatting logic in pretty. One can't just
delete some commands, rewrite them and change their interface.
Also, bugs could get introduced while rewriting pretty.c. Getting rid
of them is also an imperative task. So I may need to have a good
knowledge of GDB.
Nit: Almost a week before the end of the internship, Olga needed to
redesign the solution(maybe to keep the logic same). I need to learn
from her mistakes and will also need to keep that in mind while
designing the solution for pretty.c

### The Plan

My task is to change formatting logic in pretty.c. Actually, to remove
the current formatting solution and reuse solution from ref-filter
(maybe without changing pretty.c logically).
As Thomas<t.gummerer@gmail.com>
[suggested](https://public-inbox.org/git/20190331184930.GV32487@hank.intra.=
tgummerer.com/),
I=E2=80=99ll start by first looking at what actually needed to be replaced
(for example by studying the PRETTY FORMATS section in 'man git-log',
what which verbs you can use in the ref-filter ('man
git-for-each-ref') to achieve the same thing.
Then I=E2=80=99ll research how one format is implemented in 'pretty.c', and
see how a similar thing using the ref-filter is implemented in
'ref-filter.c'.
e.g. the "%(objectname:short) %(contents:subject)" (this is missing
coloring, but just to get you the idea) is similar to
'--pretty=3Doneline'.  Now one can try to find how 'oneline' is
implemented in 'pretty.c', and could translate that to use the
'ref-filter' API.
The idea is to use various atoms present in ref-filter to implement
pretty format options.

Valid atoms in ref-filter:
https://github.com/git/git/blob/master/ref-filter.c#L474-L520

Also, I have gone through solid part of [Git
Internals](https://git-scm.com/book/en/v2/Git-Internals-Git-Objects)
to have an understanding of objects and refs.

Possible Approach: I can just brute-force the process, merge pretty.h
and ref-filter.h, and then step-by-step clean it up. Or I can create a
blank file and put there needed functions step by step. Or I can just
pick one format option at a time and convert it to use ref-filter
logic. I am thinking about it, still don=E2=80=99t know what is better. May=
be
later one?
I guess we will sort this out ;)

## Estimated Timeline

I have my end semester exams between 10 April - 30 April. I=E2=80=99ll be
inactive from 1 April to 3 May for my exam preparation and
submissions, which is way off the timeline.
And also I have been shortlisted for Worlds Biggest Hackathon i.e
Smart India Hackathon(SIH)(https://www.sih.gov.in/)(36 hr
Hackathon)(18 & 19 July).

I believe I have enough fuel to get started on my goals - as a result
to my involvement with the organisation for almost 5 months now.

--> Period
- Inactive Period
- April 1, 2020 - May 3, 2020
--> Tasks
- Between 3-7 April - traveling and attending SIH Grand Finale
- End-Semester will be near so I=E2=80=99ll be bit inactive, though always
available on email or any other means of communication.

--> Period
- Community Bonding
- April 27, 2020 - May 18, 2020
--> Tasks
- understanding all the logic of pretty.* and ref-filter.*
(what functions are used and how all formatting process is going)
- Identifying the best candidates to be converted first.

--> Period
- My BirthDay
- May 18, 2020
--> Tasks
- Typical cake-cutting ceremony.

--> Period
- Coding phase 1
- May 18, 2020 - June 15, 2020
--> Tasks
- Tweaking ref-filter(if necessary) lil bit. So its logic can be
reused in pretty.
- rewriting pretty.c skeleton, so that it could reuse formatting logic
from ref-filter
- Converting a couple of formatting options to reuse ref-filter
formatting logic.

--> Period
- Coding phase 2
- June 19, 2020 - July 13, 2020
--> Tasks
- Converting more formatting options to reuse ref-filter formatting logic.
- Teach new formatting options to --pretty using ref-filter

--> Period
- Final Coding Phase
- July 17, 2020 - Aug 10, 2020
--> Tasks
- Final touch-ups and bug fixes(if any)
- Update Documentation

*Debugging and improving the test coverage will always be the priority
in every phase.
*During April 27, 2020 - August 17, 2020, a blog series will be
written on a weekly basis about my current findings and will also
write about =E2=80=9CWhat I=E2=80=99m working on=E2=80=9D to further provid=
e the status of my
summer project.

## Blogging about Git

I have always been reluctant to articulate my opinions and broadcast
them to the world in any way. I have a long way to go as a writer,
thinker, and as a human being before my opinions on matters of
personal significance to me will be worth sharing. (Whoa! I have
opinions about my opinions! Ad infinitum!)
Having said that, I think GSoC and Git might be a great couple for
facilitating my first foray into technical blogging. And over the
course of the summer and beyond, I would love to write about my
progress and experiences contributing to Git.

## Availability

My exams will end on 30 April. I might travel home after that. So, I
can start actively writing code for this project after 3 May. My
college resumes on 15 July. I can easily devote 45-50 hours a week
until my college reopens and 35-40 hours per week after that. I'm also
free on the weekends and I intend to complete most of the work before
my college reopens. Other than this project, I have no commitments for
this summer. I will also periodically post my status through blogs.

## Post GSoC

As I said, I would love to be a member of Git=E2=80=99s community. So, I
intend to keep contributing even after the GSoC period ends.
Here are some other things I=E2=80=99d like to do beyond GSoC
--> I=E2=80=99d love to co-mentor someone for Git (someday!)
--> I just can=E2=80=99t ignore my love for Algorithms, so most probably af=
ter
GSoC I would like to work on [Accelerate rename detection and
range-diff](https://github.com/gitgitgadget/git/issues/519)
--> I love writing, and I=E2=80=99d love to work on improving Git=E2=80=99s
documentation and work on documentation issues.
--> Eventually, I=E2=80=99d like to learn more about git-for-windows and
contribute to git-for-windows code base
--> Keep learning from all of you...

## Experience with Open Source

--> Organized many Git workshops for newcomers with HackSocIndore.
- HackSocIndore is a group of developers that organizes Hackathons,
Workshops & Technical Events. I=E2=80=99m the core team member at HackSoc.

--> Mentor, Kharagpur Winter of Code (KWoC)
- Kharagpur Winter of Code is a 5-week long online program for
students who are new to Open Source Development.
- KWoC 2019: https://kossiitkgp.org/public-files/KWoC/2019-Certificates/KWo=
C19-Hariom%20Verma.pdf
- KWoC 2018: https://kossiitkgp.org/public-files/KWoC/2018-Certificates/KWo=
C18-Hariom%20Verma.pdf

## Motivation

Git is everyone's favorite VCS. Apart from that... once I made some
initial bite-sized contributions to git, I really loved how easy it
was to get quick feedback from the community.

## Closing remarks (Optional)

I am a quick learner, and always willing to put in the extra effort to
cultivate the requisite skills needed to solve a given problem, even
if I don=E2=80=99t possess said skills to begin with!
I feel like my way of looking at problems has served me well while
contributing to Git and various open source projects.
I hope you will give me a chance to prove that by considering my
application for working with you over the summer on my proposed
project! Really looking forward to learning from all of you! Here=E2=80=99s=
 to
a summer full of learning and growth!

Heartfelt thanks and warm regards!

Hariom Verma
