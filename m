Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EADDDC2D0E7
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 18:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4F0920774
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 18:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uY5tcY9V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbgCYSvG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 14:51:06 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:55386 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727129AbgCYSvG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 14:51:06 -0400
Received: by mail-pj1-f65.google.com with SMTP id mj6so1412245pjb.5
        for <git@vger.kernel.org>; Wed, 25 Mar 2020 11:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lHkeXqzGomqTgNK1/NUn+uROPj42LOuWQFJMmfrMqc4=;
        b=uY5tcY9VQBZFH3CjMSi1Sp8+ocgk1uulgC2PN93GoEBypm3kn0zJknrOKkJsZ10DCP
         Fch9yDINbkMFpyY1AaZtu1GGNTM6VeQ8QwW/vGiSUds4Qnz3K7L0S6jTJGA7+MkKIr6c
         zfAYqOJ0RsTnc8m8uwQZ4NLQPtX8LP4Ev2O5LHp5LsxRxwu+bfrVZzd3O/ArgXEDo0IM
         JXjfEmnsdVwrwT8WF/YC7ef5h+BIw86RLodcHA26g3071CejWvUXszRHkIcxqLWpf/C9
         05krHs7y2El7NeLuX0o2o42wk4gsfLuMiGhc86TwaBXd0q/roWQIxPxtk97FT5HZV2d8
         cv2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lHkeXqzGomqTgNK1/NUn+uROPj42LOuWQFJMmfrMqc4=;
        b=Wk9mv7m79G5XDa4vImnG1V3Of05Z4BazLCjHcHPUWVNxrCV1gvbLyXr1jrtZydauv9
         iDe488BBUS447WT711+mNLAd2lTQi/JdtySK4+9Ksl0/QeUKVx3o+dv1tz7OJ/ce+Wgw
         MAZkMT9Ib0Z2XzDxbfCz9YHgb2Ev0KrpfNcHG9e3Zzq/dgnp724xlJu8+7dthSIqp/lE
         G3r0bp69z51aPVTSr/O4A9/zxkmGZqj8g+PRc2PR6U44VvHQsmaZBbkG40SiSyFGRF22
         68Tl4lw8ScSeWj3SXhp2UF7i/JCAmzNlULywLGnqE8K1VW57IDFPnbLWn6pbHJhb/8Vb
         kbAg==
X-Gm-Message-State: ANhLgQ1IgqJ1PEA8nmszGzAxho34N1IzUPEH5k12UnZk4PtsZaCaWyEH
        OqeP8I2VlC/YF7oRIIKYKEpwbch7Oc8oCqKq
X-Google-Smtp-Source: ADFU+vuo7/jZu8ncJNtFmZeVGY0OEwbcqVKj44v/3xsWNuCRSkhpCYLbF7rbAVJpwMtPq25JRifn9Q==
X-Received: by 2002:a17:90a:cb14:: with SMTP id z20mr5082598pjt.170.1585162262311;
        Wed, 25 Mar 2020 11:51:02 -0700 (PDT)
Received: from konoha.iitr.ac.in ([103.37.201.175])
        by smtp.gmail.com with ESMTPSA id r8sm9824pjo.22.2020.03.25.11.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 11:51:01 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, peff@peff.net, heba.waly@gmail.com,
        newren@gmail.com, Johannes.Schindelin@gmx.de,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: [GSoC][RFC][Proposal v5] Convert submodule to builtin
Date:   Thu, 26 Mar 2020 00:20:53 +0530
Message-Id: <20200325185053.10274-1-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello everyone,

Thank you so much for reviewing my proposal v3 and v4 Christian! :)
This is the fifth draft of my GSoC Proposal. After discussions with Christian, I decided to improve the timeline and made some changes accordingly.

Also, could you please tell me which contributions are worth keeping in the 'Contributions to Git' section? I listed almost everything here. I have
answered multiple questions on StackOverflow as well. There is no need to separately link them right? I have mentioned my StackOverflow profile below BTW.

Changes made:
	1. Added more entries in the 'Contributions to Git' section
	2. Improved the 'Outline' section
	3. Added the 'Submodules and git submodule' section
	4. Added more links in the 'Contribution process and interaction with the mentors' section
	5. Improved the 'Project Timeline' section. Made some changes to the timeline
	6. Made some additions in the 'Workflow' section
	7. Corrected grammatical errors and spelling mistakes

PS: A prettier version of this proposal is on Docs, it is more readable than the plain-text version :)
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
GitHub        : periperidip[https://github.com/periperidip]
Linkedin      : shuklashourya[https://www.linkedin.com/in/shuklashourya]
StackOverflow : rasengan__[https://stackoverflow.com/users/10751129/rasengan]
Website	      : https://sites.google.com/view/periperidip
Address       : <<address>>
Time Zone     : IST (UTC +0530)


## Background

I am Shourya Shukla, a sophomore in Computer Science and Engineering at the Indian Institute of Technology Roorkee[https://www.iitr.ac.in/].
I was introduced to programming at a young age and I have been trying to learn new concepts everyday since. My
interests include modern mobile networks, Internet of Things, system software development and Cryptography. I have been working
on a research project[https://github.com/periperidip/UAV-based-wireless-networks-2] which involves providing cellular network
access to users in a disaster-struck area via drones. I love low-level coding and FLOSS as well. I have been an active part of
the Git community since January of this year, contributing to Git.


## Work Environment

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
List: https://lore.kernel.org/git/20200116203622.4694-1-shouryashukla.oo@gmail.com/

List
[Solved doubt]: fatal: cannot rebase with locally recorded submodule modifications
List:https://lore.kernel.org/git/20200207220403.28961-1-shouryashukla.oo@gmail.com/

List
[Aided a new contributor]: Need help to start contributing
List:https://lore.kernel.org/git/20200205032925.5272-1-shouryashukla.oo@gmail.com/

List
[Aided a potential GSoC student]: [GSoC] Microproject for git
List:https://lore.kernel.org/git/20200318192719.1127-1-shouryashukla.oo@gmail.com/

List
[Reviewed a Microproject]: [GSoC][PATCH 1/2] t4131: modernize style
List:https://lore.kernel.org/git/20200319163817.4239-1-shouryashukla.oo@gmail.com/


## The Project: Convert submodule to builtin

#### Outline

Some Git commands were initially implemented directly in shell script with some instances of Perl as well. As times progressed, various platforms to run Git emerged & projects became large(spanning millions of lines of code), enter, problems in production level code:

- There were issues with portability of code. The submodule shell script uses commands such as echo, grep, cd, test and printf to name a few. When switching to non-POSIX compliant systems, one
will have to re-implement these commands specific to the system. There are also POSIX-to-Windows path conversion issues. To fix these issues, it was decided to convert these scripts into
portable C code(the original intention C was developed with, to have portable code and software).

- There is large overhead involved in calling the command. As these commands implemented in shell script are not buitlins, they tend to call multiple fork() and exec() syscalls for creating more child processes hence creating another shell. This is the aforementioned overhead we are talking about and it rather takes a huge toll on big repositories in terms of the time elapsed to run a command as well as the extra memory consumed.

- If commands tend to use other commands inside of them(such as git submodule using git rev-parse, git ls-files and git add to name a few), the overhead mentioned in the point above tends to rise exponentially which again would contribute to the slowing down of the whole git suite.

Various commands have been converted as of now due to the reasons mentioned above, such as add, blame, bisect(work in progress), etc. In my project, I intend to convert submodule into C fully, hence making it a ‘builtin’.


#### Submodules and git submodule

Submodule, as defined in the gitglossary is, “A repository that holds the history of a separate project inside another repository (the latter of which is called superproject).”, which translates to, an independent git repository inside another git repository.

Submodules are used when we need to use some work from an external repository(say we need a particular library(eg: boost) to implement in our code) but at the same time keep it “independent” from our repository, meaning that they do not really interfere with our superproject’s tree as the submodules commit are not put on the top of, or in fact, anywhere into the superprojects tree. Any changes in the submodule are reflected as a change in any other directory w.r.t the superproject. In a nutshell, the submodule’s tree is independent of the superproject’s tree.

Git, for instance, uses the sha1collisiondetection repository[https://github.com/cr-marcstevens/sha1collisiondetection/tree/855827c583bc30645ba427885caa40c5b81764d2] as a submodule.
git submodule is a command to manipulate and deal with submodules. Our aim is to convert this command from its shell form into its C form.


#### Previous Work

There has been an ongoing work in the conversion of various Git commands such as 'add', 'commit', 'blame', etc. from their shell form into their C form. 'git submodule' is one of the commands left to fully convert into its C form. Stefan Beller <stefanbeller@gmail.com> converted a large part of this command up until 2019. Prathamesh Chavan <pc44800@gmail.com> also aided in the conversion of the command during his GSoC project in the year 2017. In its current state, four git submodule subcommands are due for conversion, namely: 'add', 'set-branch', 'set-url' and 'summary'. Also, the Command Line parsing Interface needs improvements, such as better error messages and support for more subcommands.

Prathamesh implemented and improved the subcommands status[https://lore.kernel.org/git/20170713200538.25806-4-pc44800@gmail.com/], sync[https://lore.kernel.org/git/20180114211529.6391-2-pc44800@gmail.com/], deinit[https://lore.kernel.org/git/20180114211529.6391-3-pc44800@gmail.com/] and some more. The relevancy of this to my project is that some helper functions(located in submodule.c) such as print_submodule_summary(),prepare_submodule_summary(), etc. have been implemented beforehand. In the case of subcommand summary, use these functions, integrate them with the basic scaffolding(mentioned in the table below) and implement the module_summary() frontend function. He also ported various helper functions such as set_name_rev()[https://lore.kernel.org/git/20170619215025.10086-3-pc44800@gmail.com/]. He kept offering improvements to his conversions till around January of 2018.

Stefan Beller finished the implementation of the subcommand init[https://lore.kernel.org/git/1453418323-29587-1-git-send-email-sbeller@google.com/] as well as laid its foundation[https://lore.kernel.org/git/1453255396-31942-3-git-send-email-sbeller@google.com/]. He implemented foreach[https://lore.kernel.org/git/20180509002952.172347-5-sbeller@google.com/] and improved deinit[https://lore.kernel.org/git/20180327232824.112539-1-sbeller@google.com/] & update[https://lore.kernel.org/git/1444960333-16003-6-git-send-email-sbeller@google.com/] as well. He also ported various helper functions such as resolve_relative_url()[https://lore.kernel.org/git/1460767813-25916-2-git-send-email-sbeller@google.com/].


#### Current Status of the subcommand and future vision

The current status of the conversion as well as the direction I will take for the conversion of the subcommands are as follows:

add: pending conversion, full code needs to be written for the same. Need to implement callback macros and structures, i.e. struct add_cb,
ADD_CB_INIT, as well as frontend function module_add(). Other helper functions may be needed in the process as well. Compare with shell
script and try to “translate” it into C. I guesstimate around 400-500 lines of code for this(including helper functions).

set-branch: pending conversion, full code needs to be written for the same. Need to implement macros and structures, i.e. struct setbranch,
SETBRANCH_CB_INIT, as well as frontend function module_setbranch(). Other helper functions(such as remote_submodule_branch() &
get_default_remote() which are already implemented may prove helpful later) may be needed in the process as well. Compare with shell
script and try to “translate” it into C. This subcommand may take about 200 lines of C code to implement(including helper functions).

set-url: pending conversion, full code needs to be written for the same. Need to implement macros and structures, i.e. struct seturl,
SETURL_CB_INIT, as well as frontend function module_seturl(). Other helper functions(such as remote_url() & resolve_resolve_url() which
are already implemented may prove helpful later) may be needed in the process as well. Compare with shell script and try to “translate” it
into C. It will have a similar implementation to set-branch because they are “setter” functions. This subcommand may take about 200 lines
of C code to implement(including helper functions).

summary: pending conversion, work in progress; callback structures, functions and macros have been created, also, basic scaffolding of the command
is done, i.e., functions module_summary(), summary_submodule(), summary_submodule_cb(). As this is a prototype, some functions may be scrapped
or added later. Other functions to complement the subcommand have already been created; learn from Prathamesh's mistakes and implement a better code.
After discussions with Junio C Hamano[https://lore.kernel.org/git/20200318163234.21628-1-shouryashukla.oo@gmail.com/T/#ma3912b761b6deda937691a19c1a070e5e9b34bd7],
I intend to add a “--recursive” option as well for summary so as to obtain summaries of nested submodules as well.
I estimate about 400 lines of code for this subcommand(excluding the  “--recursive” option, yet including the helper functions)

status: conversion complete, currently in a functional state.
	
init: conversion complete, currently in a functional state.

deinit: conversion complete, currently in a functional state.
	
update: conversion complete, currently in a functional state.
	
foreach: conversion complete, currently in a functional state.

sync: conversion complete, currently in a functional state.

absorbgitdirs: conversion complete, currently in a functional state.

I aim to follow the same approach as Stefan and Prathamesh as mentioned above, that is, I will also create a scaffolding first(which will be based on the already implemented commands). Followed by a comparison with the shell script and then picking out which helper functions might be needed and also reusing already implemented functions in 'submodule.c' and 'submodule--helper.c'.

Though, there is about a 3 year gap between their work and mine, the model for porting seems to be consistent even if coding style may vary and might even give out improvements over previous implementations.


#### Contribution process and interaction with the mentors

I will keep committing changes on my GitHub fork[https://github.com/periperidip/git] and finally post a patch series on the Mailing List. I will make sure to keep interacting with the community as well as the mentors regularly. I aim to write weekly “progress report” blogs, which I will post on my website[https://sites.google.com/view/periperidip] as well as the List. Apart from that, I will document anything new I learn as well as my journey in the GSoC program on my blogs and maybe as self-answered questions on StackOverflow with the aim that they will help me as well as others in case of reference.


#### Project Timeline

I have been studying the code of 'submodule.c', 'submodule--helper.c' and 'git-submodule.sh'
since the submission of my microproject. After studying the codes, I tried to devise an effective
conversion strategy for 'submodule'. I noticed that 'submodule.c' contains various helper functions
for 'submodule--helper.c' whereas the latter houses the main "converted" command as of now.
      
The subcommands ‘set-branch’ and ‘set-url’ will provide easy conversion due to the vast array of helper functions already available for them. Hence, I intend to implement them before the other subcommands due to their simplicity in implementation as well as the motivation it will give me to do more.

After considering a lot of things, and important advice from Christian Couder, I have decided that I will first implement ‘set-url’ and ‘set-branch’, followed by ‘summary’ and finally ‘add’. Integration testing and documentation updates will keep following the implementations. To add on, the conversion of summary might become a tad bit easier due to the existence of a patch[https://lore.kernel.org/git/20170731205621.24305-9-pc44800@gmail.com/] to convert it, which will aid me in learning from the mistakes committed before and thus help me offer an even more improved version of the subcommand. .


Therefore, after all these considerations, the timeline looks like:

- Empty Period (Present - April 26)
--> I am writing a paper(on the project[https://github.com/periperidip/UAV-based-wireless-networks-2] I have been working upon) for a conference which I have to finalise and submit by first week of April. Hence, I might be inactive in that period
--> My end-semester exams begin on April 23(tentative, may change due to the Corona pandemic) hence I might be a bit busy a week or so before their commencement as well as the 14 days in which exams take place
--> I plan on starting the conversion of set-url’ and 'set-branch’ in this period. Although I am busy, I will try my best to implement a basic scaffolding and maybe even complete some good portion of the subcommands and will keep my mentors posted regarding the same


- Community Bonding Period (April 27 - May 18)
--> Get familiar with the community
--> Improve the project workflow: make some timeline changes if necessary
--> Finish implementation of set-url’ and 'set-branch’ subcommands
--> Update the Documentation


- Phase 1 (May 19 - June 6)
--> Convert ‘summary’ subcommand
--> Improve CLI parsing(give out better error messages)
--> Update the Documentation
--> Add appropriate tests for integration testing of ‘set-url’, ‘set-branch’ and ‘summary’

    
- Phase 2 (June 7- August 8)
--> Convert 'add' subcommand
--> Improve the remaining bits of the CLI parsing
--> Update the Documentation
--> Add appropriate tests for integration testing of ‘add’ with the whole system


- Final Phase (August 9 - August 17)
--> Improve and add Documentation(if there is any still left)
--> Apply final touch-ups to code

If there is some extra time left, I will try to implement some BONUS features.

**BONUS features:** Consist of command touch ups and improving some bugs such as code sections with 'NEEDSWORK' tags, improving the test files and maybe improve some previous implementations of helper functions. Also, there are some incomplete bits[https://github.com/git/git/blob/v2.26.0/git-submodule.sh#L451-L712] of the ‘update’ subcommand as well in the shell file, as pointed out by Dscho[https://github.com/gitgitgadget/git/issues/541#issuecomment-602613250], which may need to be corrected.


## Workflow

I have divided the project into 3 subprojects(SP).

1. **SP 1:** Convert ‘set-branch’ and set-url’
2. **SP 2:** Convert ‘summary’ and and improve CLI(Command Line Interface) parsing
3. **SP 3:** Convert ‘add’ and improve CLI parsing

After discussions with Christian Couder, I plan to start SP1 before GSoC itself. Currently,
I am studying the code in detail and constructing a scaffolding for this implementation.
I aim to complete the leftover bits of SP1 during Phase 1 and SP2 & SP3 during Phase 2 of
GSoC.

As Derrick Stolee advised[https://lore.kernel.org/git/nycvar.QRO 7.76.6.2001301154170.46@tvgsbejvaqbjf.bet/T/#m232941f6cdcf92b97b3531f6fc582935c06734cf],
the conversion may not be possible in one whole summer, hence, I think an early start might be needed to finish things in time if possible.

As of now(March 21(UTC)), my progress is described by the following commit[https://github.com/periperidip/git/commit/db3604f653e02a90145abb56cffb2d4860ececa2].
I have implemented the frontend function(almost) module_summary(). I hope to increase my work speed once I get a hang of the inner working and coding style
of the command.


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


## Final Remarks

I have a habit of not giving up. I will keep trying things until I succeed at them. Same was my case with learning to use Git in my freshman year. I was so scared of it for some reason that I refrained from using ‘git bash’. But I knew that I had to master this tool(or at least learn it to a satisfactory extent) because of the utility it has in a programmer’s life. I kept going, watching tons of tutorials, reading the documentation and articles and lo, here I am writing code for Git.

I hope that you give me the chance to showcase my abilities by considering my proposal for working with you during the summer of 2020. Really looking forward to learning from you :)

