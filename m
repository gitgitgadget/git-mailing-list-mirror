Return-Path: <SRS0=lsTH=42=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6671C10F27
	for <git@archiver.kernel.org>; Mon,  9 Mar 2020 13:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8989A20848
	for <git@archiver.kernel.org>; Mon,  9 Mar 2020 13:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qCRhzzXa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgCINKq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Mar 2020 09:10:46 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38581 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgCINKq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Mar 2020 09:10:46 -0400
Received: by mail-pl1-f193.google.com with SMTP id w3so3971191plz.5
        for <git@vger.kernel.org>; Mon, 09 Mar 2020 06:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UwHuS8Twc7N4iPkpf4NuRq4pI35RNq6SxImUddGEqwk=;
        b=qCRhzzXaq0ECQZItrN9/SIU1i02YhVYBNp7UWIGyucAkrng5UQAXHrClkusrh5vwlI
         mpe0HpSv/dVUdL3pNt/gtGhiHbj5irfAsFH9mx2dYsSoWl4F3ZXAnRo4YD+MtkTUF5LO
         z9JpjwndSxhJr6ydYTr3lr8Ax1BD/Wbm1LbR1a3S3Hb7vf2Mk47a1Ku8mHBnZpQyEHCw
         u+8YhCs+rglst05ndbwM0xg+rSi3pHDHcjBSocm7z8NbQNbkL4bFgT/ovg8c8fRXn1sy
         LC2IYlE+O+EVPyW4FEihqPeut6omEK4eNfJuXU5BeBj9uJ4f3am1VbJ/n9MXDyg610oY
         VK/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UwHuS8Twc7N4iPkpf4NuRq4pI35RNq6SxImUddGEqwk=;
        b=qe7YXxTVDWxeG5OjBPbrz5g62WLyxy5zgcHnyUcbb2Eye7UDPUVqhdBY4dVgFREObY
         II3XmD6mvdi7MfMF6ZvsynvEjyuR/Wi8IY3tmlmoJzzxJHiKg7ebRIA+qMDQewZ5cmzi
         I5ZJzaU+24Qv4IqN5XUaW39zx4aVD2NaJaQPi6Xf+2dWAI1gzsNMiqXM2akd3KTEz+4L
         BPdaSGt/WIWC5kkN2Le+ox5uHl6th4230+XGAkIiVAKn0OvxGxBqWQgWMSfIVZWAdzKP
         oI+NNZGckVOOIuEHyIrBTFNv+tYhHbFBGPdJPMlpeqGGTk6eX03iUfHQO26x0DBymx3r
         jHcQ==
X-Gm-Message-State: ANhLgQ3akkNRQIdqfJjN49ad3Fx6NrYDY04HfNo4Wo0tgQklJHR1HPeI
        /QqACYfR//t0a4+xg8MuZPLY8dSqr2xKqQ==
X-Google-Smtp-Source: ADFU+vu88RzxaoMILcG1ehYaGi4lI+JXndV6lduLuWbuMT6TLhDXqGxBz4TXP9IaUpTe5uTtCa4Gfw==
X-Received: by 2002:a17:90b:3692:: with SMTP id mj18mr3183396pjb.170.1583759444281;
        Mon, 09 Mar 2020 06:10:44 -0700 (PDT)
Received: from localhost.localdomain ([139.167.54.66])
        by smtp.gmail.com with ESMTPSA id s61sm3321244pjd.33.2020.03.09.06.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 06:10:43 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, christian.couder@gmail.com,
        peff@peff.net, heba.waly@gmail.com, newren@gmail.com,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: [GSoC][RFC][Proposal v2] Convert submodule to builtin
Date:   Mon,  9 Mar 2020 18:40:27 +0530
Message-Id: <20200309131027.18994-1-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello everyone,

Thank you so much for reviewing my proposal Christian! :)
Apologies for the late reply, I was busty with exams for the past 10 days. This is the second
draft of my GSoC Proposal. I have acted upon Christian's advice and reviews of my proposal.

Changes made:
	1. Improve project timeline
	2. Separate 'Overview' into 'Outline' and 'Previous work'
	3. Corrected grammatical errors and spelling mistakes
	4. Provided some links to relevant things asked for.

Google Docs: https://docs.google.com/document/d/1vqu84h0E83BnNyuj19HkgoWsGYHsGgY2Jkc5kTB4fSs/edit?usp=sharing

Thanks,
Shourya

-x-x-x-x-x-x-x-x-x-x-x-x-x--x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x


# Convert submodule to builtin

## Contact Information
--------------------

Name          : Shourya Shukla
Major         : Computer Science and Engineering
E-mail        : shouryashukla.oo@gmail.com
IRC           : rasengan_chidori on #git & #git-devel
Mobile no     : <<mobile no>>
GitHub        : periperidip
Linkedin      : shuklashourya
StackOverflow : rasengan__
Address       : <<address>>
Time Zone     : IST (UTC +0530)


## Background

I am Shourya Shukla, a sophomore in Computer Science and Engineering at the Indian Institute of Technology Roorkee[https://www.iitr.ac.in/].
I was introduced to programming at a young age and I have been trying to learn new concepts everyday since. My
interests include modern mobile networks, Internet of Things and system software development. I have been working
on a research project[https://github.com/periperidip/UAV-based-wireless-networks-2] which involves providing cellular network
access to users in a disaster-struck area via drones. I love low-level coding and FLOSS as well. I have been an active part of
the Git community since January of this year, contributing to Git.


## Work Envinronment

I am fluent in C/C++, Java and Shell script, and have an understanding of Python
as well. I use Git as my VCS and Visual Studio Code with integrated GDB as my
primary code editor and Ubuntu 19.10 as my primary Operating System unless the
work specifically needs Windows.


## Contributions to Git

Contributing to Git helped me understand a lot about how modern & robust software
work as well as how real world development takes place. I plan on contributing even
more to Git and make my contributions count. As of now, my contributions at Git are:

---------------
status: merged
git/git:
[Microproject]: Modernise tests and use helper functions in test script.
GitHub: https://github.com/git/git/commit/c513a958b69090c02ad422b0cd4622009bb4b9f5
List: https://github.com/git/git/commit/c513a958b69090c02ad422b0cd4622009bb4b9f5


## The Project: Convert submodule to builtin

#### Outline

Git was initially implemented directly in shell script with some instances of Perl as well. As times progressed,
various platforms to run Git on emerged, _enter_, problems in production code. There were multiple problems with
compatibility of code across platforms(e.g.: POSIX-to-Windows path conversion issues). To fix this issue, it was
decided to convert these scripts into portable C code(the original intention C was developed with, to have portable
code and software).

Various commands have been converted as of now, such as add, blame, bisect(work in progress), etc. In my project,
I intend to convert submodule into C fully, hence making it a ‘builtin’. 


#### Previous Work

There has been an ongoing work in the conversion of various Git commands such as 'add', 'commit', 'blame', etc. from
their shell form into their C form. 'git submodule' is one of the commands left to fully convert into its C form.
Stefan Beller <stefanbeller@gmail.com> converted a large part of this command up until 2019. Prathamesh Chavan <pc44800@gmail.com>
also aided in the conversion of the command during his GSoC project in the year 2017. In its current state, four subcommands are
due for conversion, namely: 'add', 'set-branch', 'set-url' and 'summary'. Also, the Command Line parsing Interface needs improvements,
such as better error messages and support for more subcommands.

Prathamesh Chavan implemented and improved the subcommands summary, status, sync, deinit and some more. The relevancy of this to my project
is that some helper functions(located in submodule.c) such as print_submodule_summary(),prepare_submodule_summary(), etc. have been implemented
beforehand. In the case of subcommand summary, the work left is to stitch these functions together and implement the main module_summary()
function. I plan on working in a similar fashion by contributing changes to my GitHub handle as well as the refined versions to the List,
so that my mentors are able to keep a track of my progress regularly.

#### Project Timeline

I have been studying the code of 'submodule.c', 'submodule--helper.c' and 'git-submodule.sh'
since the submission of my microproject. After studying the codes, I tried to devise an effective
conversion strategy for 'submodule'. I noticed that 'submodule.c' contains various helper functions
for 'submodule--helper.c' whereas the latter houses the main "converted" command as of now.
      
Therefore, the timeline looks like:	
  
  - Empty Period (Present - April 26)
    --> I am writing a paper(of the project I have been working upon) for a conference which I have to finalise and submit by first week of April.
    --> My end-semester exams begin on April 23 hence I might be a bit busy before a week or so before the start date.
    --> I plan on starting the conversion of ‘summary’ in this period. Although, I am busy, I will try my best to implement
        a basic scaffolding  and maybe even complete some good portion of the subcommand for the command and will keep my
        mentors posted regarding the same.
 
  - Community Bonding Period (April 27 - May 18)
    --> Get familiar with the community
    --> Improve the project workflow: make some timeline changes if necessary.
    --> Finish implementation of `summary` subcommand
   
  - Phase 1 (May 19 - June 6)
    --> Convert 'set-url' subcommand
    --> Improve CLI parsing
    
  - Phase 2 (June 7- August 8)
    --> Convert 'add' subcommand
    --> Convert 'set-branch' subcommand
    
  - Final Phase (August 9 - August 17)
    --> Improve and add Documentation(if there is any still left)
    --> Apply final touch-ups to code

If there is some extra time left, I will try to implement some BONUS features.

**BONUS features:** Consist of command touch ups and improving some bugs such as code
                    sections with 'NEEDSWORK' tags.


## Relevant Work

I have divided the project into 3 subprojects(SP).

    1. **SP 1:** Convert 'summary'
    2. **SP 2:** Convert 'set-url' and and improve CLI(Command Line Interface) parsing   
    3. **SP 3:** Convert 'add' and 'set-branch'
    
After discussions with Christian Couder, I plan to start SP1 before GSoC itself. Currently,
I am studying the code in detail and constructing a scaffolding for this implementation.
I aim to complete the leftover bits of SP1 during Phase 1 and SP2 & SP3 during Phase 2 of
GSoC.

As Derrick Stolee advised[https://lore.kernel.org/git/nycvar.QRO.7.76.6.2001301154170.46@tvgsbejvaqbjf.bet/T/#m232941f6cdcf92b97b3531f6fc582935c06734cf],
the conversion may not be possible in one whole summer, hence, I think an early start might be needed to finish things in time if possible.


## Availability

The official GSoC period starts from April 27 and ends on August 17. My vacations start
from May 10 and will be over by July 13. I can easily devote 45-50 hours per week until
the commencement of my Semester. Other than this project, I have no commitments planned
for my vacations. I shall keep the community posted in case of any change in plans.


## Post GSoC

Even after the completion of Google Summer of Code, I plan on continuing my contributions
to Git, on the technical front(in terms of code and documentation contributions) as well
as on the social front(solving people's doubts/problems on the List as well as on StackOverflow).
I vision to convert the remaining of the commands as pointed out by Dscho[https://lore.kernel.org/git/nycvar.QRO.7.76.6.2001301154170.46@tvgsbejvaqbjf.bet/T/#m637c5c97d42dc68aab85420b5ffcaeb34c270ad3]
as well as improve the test files.

I aim to develop mentorship skills as well as the ability to guide others and try to give back to
the community by mentoring and guiding others as well(by reviewing their code, helping them out, etc.)

