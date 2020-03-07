Return-Path: <SRS0=zTfj=4Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC95C10F00
	for <git@archiver.kernel.org>; Sat,  7 Mar 2020 19:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B4D220665
	for <git@archiver.kernel.org>; Sat,  7 Mar 2020 19:40:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HgsV+HTP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbgCGTkS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Mar 2020 14:40:18 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43592 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgCGTkR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Mar 2020 14:40:17 -0500
Received: by mail-ot1-f67.google.com with SMTP id j5so5802386otn.10
        for <git@vger.kernel.org>; Sat, 07 Mar 2020 11:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=FPbz3/9pLIGvilWD340yCgwf9Pj6z2jJyuV94qEA6WM=;
        b=HgsV+HTP4UqAmlrQBV04VDosVyTBstiWBtAxmYBLrTix74rqsxcjgB0hdTwp06lQA/
         KpV6cEMMfc+8HBi4Ja3pRlomXQKRObwvZ/VYnOWdrCVA/+3Zj2SmrmmNMRkrO6vzCa+y
         fBPZX+DS80yGDjX2MATkAxWhmByZZA6Gp1+yMQeldD90fuQxPakYic31K34Uwe6gT0kJ
         5lEs3T4kxP6Lr9LB+kE3dUWkEgrk8i5Aa8aLyJT47UA6KKzLDEjXg55DLeq4hbIcY4zJ
         hvTrrR0dH88O9QtIvsZ2P6/8RL3HNHoNwM4EJAda1lT53WE6/jh73IsU6yECCL0RuNE+
         EpkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=FPbz3/9pLIGvilWD340yCgwf9Pj6z2jJyuV94qEA6WM=;
        b=H3putowcvRSlZiWkZ9jIf8WTUvp3KWnYUdvO+jHMQk/B+154ifW0jF0dFa7EKRAI2k
         eVtNLaXrDDB4fa2WwZN7hMLvddNBX+LzPll9ovXlSiWHwVyKSGmmPlb+jnnIaeS/zkvm
         2deNQ0e953Pvw6pkbtRohR2pw+qmDgU9fNlx/ed1UeEDBtEqtjm9JCy1uAuCi5Q7hp3q
         LKRK6jdEIXqZIr8OqZQR9kllIIvHfMpUgXOotzeVwL1DDS2Ztz3R+P1ASBs/q6SRDWG7
         JHd4PdI1EEIZAeI9NkhLKpx/+o2dGNXBbPXyuRoJx/JHTMCUHDxSEWlGZCRCbWqJ8YWk
         PMfg==
X-Gm-Message-State: ANhLgQ1+wW9xfkH22KperNTjudkELsxaTcUvC0FA8v7l8XwPfHNb5lWH
        DJUv4HWM1bH7LquQJ+tidMFrS96Q1CezeHkn8k0=
X-Google-Smtp-Source: ADFU+vsVymIsWjWjuNJ29w7QGPpANimjSN146O7sLmIf/u/TKFOkiqAW2XZYv4z253XyaAaSKFhqQLxv84wFxnB/3dg=
X-Received: by 2002:a05:6830:108d:: with SMTP id y13mr7469105oto.241.1583610015977;
 Sat, 07 Mar 2020 11:40:15 -0800 (PST)
MIME-Version: 1.0
From:   Hariom verma <hariom18599@gmail.com>
Date:   Sun, 8 Mar 2020 01:10:05 +0530
Message-ID: <CA+CkUQ-dhyd_5ey1z-v59FzNyWFFVosMBfunSnN5t1EqxVMvVw@mail.gmail.com>
Subject: [GSoC][RFC][PROPOSAL v2] Unify ref-filter formats with other --pretty formats
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        johannes.schindelin@gmx.de, olyatelezhnaya@gmail.com, peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, Mar 4, 2020 at 8:46 PM Christian Couder
<christian.couder@gmail.com> wrote:
> Hi,
> Thanks for your proposal!

Thanks for your review!

I have improved the proposal as suggested by you.
Thus sending the v2 for the review.

I know mentors may have limited time So I tried to keep my proposal
short and DRY (Don=E2=80=99t Repeat Yourself)

Changelog:
+ Timeline
+ Previous Work
+ Links after the text
+ Few minor changes
+ Fixed dead links
- Links at the end of the doc

Regards,
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

Possible Approach: I can just brute-force the process, merge pretty.h
and ref-filter.h, and then step-by-step clean it up. Or I can create a
blank file and put there needed functions step by step. Or I can just
pick one format option at a time and convert it to use ref-filter
logic. I am thinking about it, still don=E2=80=99t know what is better. May=
be
later one?
I guess we will sort this out ;)

## Estimated Timeline

I have my end semester exams between 10 April - 30 April and also I
have been shortlisted for Worlds Biggest Hackathon i.e Smart India
Hackathon(SIH)(https://www.sih.gov.in/).
I=E2=80=99ll be inactive from 1 April to 3 May for my exam preparation and
Hackathon, which is way off the timeline.
I believe I have enough fuel to get started on my goals - as a result
to my involvement with the organization for almost 5 months now.

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
- Converting formatting options to reuse ref-filter formatting logic.
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
Also, I just can=E2=80=99t ignore my love for Algorithms, so most probably
after GSoC I would like to work on =E2=80=9CAccelerate rename detection and
range-diff=E2=80=9D.

## Experience with Open Source (Optional)

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
