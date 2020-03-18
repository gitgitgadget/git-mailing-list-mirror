Return-Path: <SRS0=hWrV=5D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF03C10DCE
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 19:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00F8F20754
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 19:10:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KY6lKDSv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgCRTKr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Mar 2020 15:10:47 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45688 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbgCRTKq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Mar 2020 15:10:46 -0400
Received: by mail-pg1-f193.google.com with SMTP id m15so14192771pgv.12
        for <git@vger.kernel.org>; Wed, 18 Mar 2020 12:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EIiKzhQ+ltSARFaei/mRazeUxoQHUadn53REW+OvvZk=;
        b=KY6lKDSvJWWJdBhEPMAgKPTEXyD261XvmRPICVX4YBBCksC3aPWTpVWF47HOeWpunV
         KF2Qaw7qJZRbaUOW7mUJUZz5FcJdMP64jtpVBYizB2CsR6tNEpuO6sKYGEr9+VZUtilu
         57t5NfJ80mfr+rAq9cKUIxO6dG8NQ4wvHQRVwk8s99ctkNUev5l/epSeNXsNIOaplIgS
         YNYe1a2aD/7crjD7tbsNpU7Oajbid8oLzaqm/iwqE754vcz8Da2VWta/0N2+E0vmQt0+
         F8efH/h5luE95Z25hwxpnsCTtuqTKzprEh8sHAI3f/e5/dFWfQPateUQSnoqSfu9JByy
         AACA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EIiKzhQ+ltSARFaei/mRazeUxoQHUadn53REW+OvvZk=;
        b=a5iduOIAuYQxNoqovZlWdWbxgh26i7Ga52vOx1fwjG+b2L04DTHzyPUh62Su6TUB1V
         7XiSMsMthHqCJq0cmOp2Duwu1loYETN9m2O7utRsiOlK9j+uicrmGf1OTk65ZJMLKUW0
         +xwIq8Vjp1eWUh+wY5V/hdwUR0BP1cyqJNYapO4Gq7aznkNxRUgmBTFGavpWeGBwg5PW
         Myx66TjeZimTcgjl847KCaS2rQ4/36O07FAlXv4q7h3ZguXLtYMTtAescm7uYaww+SSK
         0h9ZTmlEkkLIeRxxEQMfC+xOf6FViJ/OXJ7EeLsqK+FsKlY7WBsbxVRDHrVOw9bcc4gN
         kM9Q==
X-Gm-Message-State: ANhLgQ08//O7RqnZvzaxcEJcTDShgNqz/s7vhtx4AW1+LvdB9Zx8J6PO
        XLiqls0LGYqlSnrv7BAU+Q05TZZzBbSJkw==
X-Google-Smtp-Source: ADFU+vsLlvOt4qSkGqxY07oESd/6aVU6sH1WI15cVq/YjAkWRV52/DMrFRTl+K3Fb4tcbN/MsYn2EQ==
X-Received: by 2002:a63:4825:: with SMTP id v37mr5791832pga.283.1584558643506;
        Wed, 18 Mar 2020 12:10:43 -0700 (PDT)
Received: from konoha.iitr.ac.in ([103.37.201.173])
        by smtp.gmail.com with ESMTPSA id t60sm3148612pjb.9.2020.03.18.12.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 12:10:42 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, christian.couder@gmail.com,
        peff@peff.net, heba.waly@gmail.com, newren@gmail.com,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: [GSoC][RFC][Proposal v3] Convert submodule to builtin
Date:   Thu, 19 Mar 2020 00:40:33 +0530
Message-Id: <20200318191033.443-1-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello everyone,

Thank you so much once again for reviewing my proposal v2 Christian! :)
Apologies for the late reply, I had been working on the conversion since and needed some concrete study for my proposal. This is the third draft of my GSoC Proposal. I have acted upon Christian's advice and reviews of my proposal.

Changes made:
	1. Corrected some of the links provided
	2. Renamed 'Relevant Work' to 'Workflow'
	3. Corrected grammatical errors and spelling mistakes
	4. Added more information about the conversion process as well as the current
	   state of the subcommands left to convert, along with a potential process and
	   direction of the conversion.

I think the proposal needs to be even more descriptive conversion process and direction, I will keep exploring the code even more and try to formulate an even better direction in the coming couple of days.

One thing I wanted to ask was that how do I foresee a good strategy and required helper functions
for the subcommands add, set-branch and set-url, as I am not working on them currently, hence I am
not able to exactly predict a path as of now. I can foresee a skeleton for these subcommands but
not a precise track for the same. :/

Also, a small report on my progress: I have created a scaffolding of the 'summary' subcommand as stated in this commit:
https://github.com/periperidip/git/commit/d33948dfc5d4c8faede9d3213adc3964557f33e1

I have progressed further than this commit and I will update the GitHub fork shortly. Currently, I am
studying other subcommands and trying to find a better direction for the code. I am also studying
Prathamesh Chavan's 2017 GSoC project and patches thoroughly.

PS: A prettier version of this proposal is on Docs, it is more readable than the plain-text version :)
Google Docs: https://docs.google.com/document/d/1vqu84h0E83BnNyuj19HkgoWsGYHsGgY2Jkc5kTB4fSs/edit?usp=sharing

PPS: I noticed that there are new subcommands in the 'submodule--helper.c' but they are not defined
in submodule's documentation. Will they be added after the full completion of the conversion?

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


## The Project: Convert submodule to builtin

#### Outline

Git commands were initially implemented directly in shell script with some instances of Perl as well. As times progressed, various platforms to run Git on emerged, _enter_, problems in production code. There were multiple problems with shell scripts, such as: compatibility of code across platforms(e.g.: POSIX-to-Windows path conversion issues). To fix this issue, it was decided to convert these scripts into portable C code(the original intention C was developed with, to have portable code and software).

Various commands have been converted as of now, such as add, blame, bisect(work in progress), etc. In my project, I intend to convert submodule into C fully, hence making it a ‘builtin’. 


#### Previous Work

There has been an ongoing work in the conversion of various Git commands such as 'add', 'commit', 'blame', etc. from their shell form into their C form. 'git submodule' is one of the commands left to fully convert into its C form. Stefan Beller <stefanbeller@gmail.com> converted a large part of this command up until 2019. Prathamesh Chavan <pc44800@gmail.com> also aided in the conversion of the command during his GSoC project in the year 2017. In its current state, four subcommands are due for conversion, namely: 'add', 'set-branch', 'set-url' and 'summary'. Also, the Command Line parsing Interface needs improvements, such as better error messages and support for more subcommands.

Prathamesh Chavan implemented and improved the subcommands summary, status, sync, deinit and some more. The relevancy of this to my project is that some helper functions(located in sbmodule.c) such as print_submodule_summary(),prepare_submodule_summary(), etc. have been implemented beforehand. In the case of subcommand summary, the work left is to stitch these functions together and implement the main module_summary() function. The current status of The conversion is:

	add: pending conversion, full code needs to be written for the same. Need to implement
	     callback macros and structures, i.e. struct add_cb(), ADD_CB_INIT, as well as frontend 		     function module_add(). Other helper functions may be needed in the process as well. 		     Compare with shell script and try to “translate” it into C.
	set-branch: pending conversion, full code needs to be written for the same. Need to implement 			    macros and structures, i.e. struct _setbranch(), SETBRANCH_CB_INIT, as well as 			    frontend function module_setbranch(). Other helper functions may be needed in the 			    process as well. Compare with shell script and try to “translate” it into C. 	set-url: pending conversion, full code needs to be written for the same. Need to implement 			macros and structures, i.e. struct _seturl(), SETURL_CB_INIT, as well as frontend 			function module_seturl(). Other helper functions may be needed in the process as 			well. Compare with shell script and try to “translate” it into C.Compare with shell 			script and try to “translate” it into C. It will have a similar implementation to 			set-branch because they are “setter” functions
	summary: pending conversion, work in progress; callback structures, functions and macros have
		 been created, also, basic scaffolding of the command is done, i.e., functions
		 module_summary(), summary_submodule(), summary_submodule_cb(). As this is a
		 prototype, some functions may be scrapped or added later. Other functions to
		 complement the subcommand have already been created; learn from Prathamesh's
		 mistakes and implement a better code.
	status: conversion complete, currently in a functional state.
	init: conversion complete, currently in a functional state.
	deinit: conversion complete, currently in a functional state.
	update: conversion complete, currently in a functional state.
	foreach: conversion complete, currently in a functional state.
	sync: conversion complete, currently in a functional state.
	absorbgitdirs: conversion complete, currently in a functional state.



I plan on working in a similar fashion by contributing changes to my GitHub handle as well as the refined versions to the List, so that my mentors are able to keep a track of my progress regularly. I plan to create a weekly blog for the same, but in case it is not possible, I will post weekly updates on the List.


#### Project Timeline

I have been studying the code of 'submodule.c', 'submodule--helper.c' and 'git-submodule.sh'
since the submission of my microproject. After studying the codes, I tried to devise an effective
conversion strategy for 'submodule'. I noticed that 'submodule.c' contains various helper functions
for 'submodule--helper.c' whereas the latter houses the main "converted" command as of now.
      
Therefore, the timeline looks like:	
  
  - Empty Period (Present - April 26)
    --> I am writing a paper(of the project I have been working upon) for a conference which I have to finalise and submit by first week of April.
    --> My end-semester exams begin on April 23 hence I might be a bit busy before a week or so before the start date.
    --> I plan on starting the conversion of ‘summary’ in this period. Although, I am busy, I will try my best to implement a basic scaffolding and maybe
	even complete some good portion of the subcommand for the command and will keep my mentors posted regarding the same.
 
  - Community Bonding Period (April 27 - May 18)
    --> Get familiar with the community
    --> Improve the project workflow: make some timeline changes if necessary.
    --> Finish implementation of `summary` subcommand
   
  - Phase 1 (May 19 - June 6)
    --> Convert 'set-url' subcommand
    --> Improve CLI parsing(give out better error messages)
    
  - Phase 2 (June 7- August 8)
    --> Convert 'add' subcommand
    --> Convert 'set-branch' subcommand
    
  - Final Phase (August 9 - August 17)
    --> Improve and add Documentation(if there is any still left)
    --> Apply final touch-ups to code

If there is some extra time left, I will try to implement some BONUS features.

**BONUS features:** Consist of command touch ups and improving some bugs such as code
                    sections with 'NEEDSWORK' tags.


## Workflow

I have divided the project into 3 subprojects(SP).

    1. **SP 1:** Convert 'summary'
    2. **SP 2:** Convert 'set-url' and and improve CLI(Command Line Interface) parsing   
    3. **SP 3:** Convert 'add' and 'set-branch'
    
After discussions with Christian Couder, I plan to start SP1 before GSoC itself. Currently,
I am studying the code in detail and constructing a scaffolding for this implementation.
I aim to complete the leftover bits of SP1 during Phase 1 and SP2 & SP3 during Phase 2 of
GSoC.

As Derrick Stolee advised[https://lore.kernel.org/git/nycvar.QRO 7.76.6.2001301154170.46@tvgsbejvaqbjf.bet/T/#m232941f6cdcf92b97b3531f6fc582935c06734cf],
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

