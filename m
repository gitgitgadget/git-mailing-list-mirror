Return-Path: <SRS0=QAHC=4O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60BDFC4BA06
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 00:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29AC221D7E
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 00:03:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h2Qi6Aab"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729090AbgBZADp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Feb 2020 19:03:45 -0500
Received: from mail-ot1-f51.google.com ([209.85.210.51]:32800 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbgBZADo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Feb 2020 19:03:44 -0500
Received: by mail-ot1-f51.google.com with SMTP id w6so1328871otk.0
        for <git@vger.kernel.org>; Tue, 25 Feb 2020 16:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=DwND3Fb976El/zMRZlKQLfaaLYC7IC9oTQtBIbg+pw0=;
        b=h2Qi6AabjAT/s6w+YlEHhcpMQH2bATgYp3GM+3ZDQXIG37mhWZNGSyAjk4WgY7Uv+l
         /ILknXRriS4GLLwxifWZhgU04uRmavP0QUqUDtXmlXcfSBtFA3wZsMzSZ+vzay4VFXsv
         EYuQR9WQw9ENVp3p8edwZg5AtFz/OyUj2XMhqh/3dEFKCzoWBcdKmSWPUGBTxiVqog52
         YpbGXZMFJ1BtY/E/yn4lKgWVwS98JEB67jkvh6MNxhhrf+0NPXpEL5YqOBjbz3OfXH6j
         JZcYbZfJxVFUL7orjFuLa12Uiu0GBmDb+Zwkb9Docj77hE7j9lhMSw1uty3I9aS1BlM0
         spOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=DwND3Fb976El/zMRZlKQLfaaLYC7IC9oTQtBIbg+pw0=;
        b=RoXcwZ2/R87645qAlzK8RSYFK/Ir/GgMZoIkMDzOrkb6uwK45Z8Rvk5yCHJHusmjpM
         Gruibi7BQ672rnyQ+bXTXUbTxCxpi2sTrs/buww9aHMf5g2jTXCFqzbGnPJBTg0Dp1v5
         g4SDt2kW3cfvUJStnIkcAaOBS3A45bQw20h/4iMsIQqtD7hQd8E0v+tneZbJFVP/rj/n
         /fn1J/hjsAXnFj7zLXqE87uL3pFhYdHUyNK78474UkE4Uw8FfMkX14ihvrAPbdN4Ki6P
         PNkm20kZ8m8cp4BcVbVccK2QOyfqccYCpc565L/NtD5/Qd8GRy7yQHn1SKgSCFGAXSLs
         za+A==
X-Gm-Message-State: APjAAAXmoo9NxKPBeC6wasQaBuelQhls0+UnQ8ZKapxrvA4nXU05bA0l
        KqcPUmXFeOMZH7F5AKQnDDEl+F2WvALrc31Y/u7rMqVHHS8FNw==
X-Google-Smtp-Source: APXvYqyCbTOSvZHqMQuNOmBvWcGuWCWtfDLsuQPvNoUxiQKz8Eg+R8f2jp4/cCNQP4iEZTAtwLj5RPRWOPP0jZoZWuo=
X-Received: by 2002:a9d:7f11:: with SMTP id j17mr932345otq.281.1582675422867;
 Tue, 25 Feb 2020 16:03:42 -0800 (PST)
MIME-Version: 1.0
From:   Hariom verma <hariom18599@gmail.com>
Date:   Wed, 26 Feb 2020 05:33:31 +0530
Message-ID: <CA+CkUQ9Pnta8Ut9ZaeKLSPn_EyQwh=Wgm1eiSWirghgtcWZqoA@mail.gmail.com>
Subject: [GSoC][RFC][PROPOSAL v1] Unify ref-filter formats with other --pretty formats
To:     git <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>,
        johannes.schindelin@gmx.de,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        peff@peff.net, Hariom Verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is the initial version of my proposal. I would really love to
have comments on it.
Also, how should I manage the project timeline?

Project title says some past GSoC and Outreachy Interns had worked on this.
I would also like to be redirected there. So I can learn from there
work as well.

Thanks,
Hariom

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

View on Docs: https://docs.google.com/document/d/15GPvle6S0iNg430aJx-gMrXvs=
gnzTlFNFhyP-K6Zmtw/edit?usp=3Dsharing

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

**Unify ref-filter formats with other --pretty formats**

Name  :  Hariom Verma
Major  :  Computer Science and Engineering
Mobile no.  : <<mob_no>>
Email  : <<email>>
Time Zone  : IST (UTC +05:30)

## About me
I am a Computer Science undergraduate at Shri G S Institute of
Technology & Science, Indore, India. I am passionate about software
freedom and open source communities. I've been writing in C, C++,
Python & Dart for almost 3 years, and contributed to some projects
which can be seen on Github.

I=E2=80=99m contributing to Git since Oct 2019 and would love to be a membe=
r
of such a versatile community.

### Contact:
IRC: harry-hov (on #git-devel@freenode)
GitHub: harry-hov
Linkedin: https://www.linkedin.com/in/harry-hov/

## Me & Git
My contributions have helped me understand the review and patch
submission process in a batter way. Also, I now feel a bit more
comfortable with Git=E2=80=99s codebase.

Commit
Status
-------------------
receive.denyCurrentBranch: respect all worktrees[1]
Status: next

t5509: use a bare repository for test push target[2]
Status: next

get_main_worktree(): allow it to be called in the Git directory[3]
Status: next

git-compat-util.h: drop the `PRIuMAX` and other fallback definitions[4]
Status: Merged to master

builtin/blame.c: constants into bit shift format[5]
Status: Merged to Master

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

### Plan
As Thomas Gummerer suggested[6] I=E2=80=99ll start by first looking at what
actually needed to be replaced (for example by studying the PRETTY
FORMATS section in 'man git-log', what which verbs you can use in the
ref-filter ('man git-for-each-ref') to achieve the same thing.
Then I=E2=80=99ll research how one format is implemented in 'pretty.c', and
see how a similar thing using the ref-filter is implemented in
'ref-filter.c'.
e.g. the "%(objectname:short) %(contents:subject)" (this is missing
coloring, but just to get you the idea) is similar to
'--pretty=3Doneline'.  Now one can try to find how 'oneline' is
implemented in 'pretty.c', and could translate that to use the
'ref-filter' API.

### Potential Problem
The biggest challenge is to maintain backward compatibility while
using reuse ref-filter formatting logic in pretty. One can't just
delete some commands, rewrite them and change their interface.
Also, bugs could get introduced.

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

## Experience with Open Souce (Optional)
-> Organized many Git workshops for newcomers with HackSocIndore[7].
HackSocIndore is a group of developers that organizes Hackathons,
Workshops & Technical Events. I=E2=80=99m the core team member at HackSoc.
-> Mentor, Kharagpur Winter of Code (KWoC)[8]
Kharagpur Winter of Code is a 5-week long online program for students
who are new to Open Source Development.


[1]:https://public-inbox.org/git/d21a590d6c23f231c54b731b737c363b83660f79.1=
582484231.git.gitgitgadget@gmail.com/
[2]:https://public-inbox.org/git/ae749310f067c43429741987cd9f47c1ae4ceb3f.1=
582484231.git.gitgitgadget@gmail.com/
[3]:https://public-inbox.org/git/8718facbc951614f19407afa6ca8d6110507483d.1=
582484231.git.gitgitgadget@gmail.com/
[4]:https://public-inbox.org/git/177deddcf83c2550c0db536a7a6942ba69a92fa5.1=
574600963.git.gitgitgadget@gmail.com/
[5]:https://public-inbox.org/git/838478a185322572ed4747eb484b678a8e2d7ac6.1=
571334411.git.gitgitgadget@gmail.com/
[6]:https://public-inbox.org/git/20190331184930.GV32487@hank.intra.tgummere=
r.com/
[7]:https://www.hacksoc.in
[8]:https://kwoc.kossiitkgp.org
