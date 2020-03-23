Return-Path: <SRS0=3T2S=5I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F6AC3F2CD
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 17:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A03320722
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 17:16:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WZon5bZK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbgCWRQH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Mar 2020 13:16:07 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:54230 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727127AbgCWRQG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Mar 2020 13:16:06 -0400
Received: by mail-pj1-f66.google.com with SMTP id l36so124385pjb.3
        for <git@vger.kernel.org>; Mon, 23 Mar 2020 10:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8K//kXUKAWFas5HsnWLyABjicjlo+76itIgqSzj5iSE=;
        b=WZon5bZKZ5Mnn/lFJ2jtCRdpuWXGg6T0E/1cW1DmtOvsH05Cfn7C//CXgip8doAH2r
         wlrYquX052pk2/d8oWDB+z/ZddOlWImdqXl49u+hKuxLPW2KSs9K0exsK9RqvLBRbeD1
         lf7UwegA2xGOlAyOks7ADYgEr1En3Wn54SzFCWAJ46w/002U4yFRz/t4UBodF5PXPrF7
         M3c+692YBiUGdi3TFkPhioIT9m2zlt7QpvwvDc+poXpx2tWaS5egtfFMzu2ogBhz0NbF
         kO7KoEQo0XurwUi8PZPEqgsxCsM5QlW7ym9y7IpmB5/FS9sCYpM/Q47oEESd6rMFx1fn
         5amw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8K//kXUKAWFas5HsnWLyABjicjlo+76itIgqSzj5iSE=;
        b=B8ncV0C62kshRZaN7Gy5+1CowCaR6XTIpbRCSmeDIxn0ixTqbm0NUI0dTH/tUS7DsL
         Cq1L4NnAt6sbvb5gcXLWGLzwzk6vjTKezv09PDTvi5KvTRFn201K0JryNU9Igwf40Bmg
         TXj+5BR01pqtrvacPgfnIb8t47JM9yOOX/cfUiixvl2nsz/Da+6PqHG9ThlSkxL9eQyK
         vFlFaA7nCbr4sR1swL2eRyfCvcd4xl1oTB8iK8zhVbr05tifs0ttIKWl0k6Bd0RVpceg
         gJBnfTj9HNO+HDLM3PURg97NU6uY69yKNnAyqAhJ14A6Da4fCmLqDSiV4S1SWpKxIKMp
         aKhg==
X-Gm-Message-State: ANhLgQ3fVnx15zU+BLvUhhI33LgnmLF901JI5WtOuj7sLEDMFvRaOJ+6
        WSBl7Poovlhimp2GFRO4ClwRGBrmwjzsOJpk
X-Google-Smtp-Source: ADFU+vv0RrDHwKQMLyDF+WpQF+oBMt7TS+idNcDSWJ63hntQqwOoPCeOx1IlnXV4YyowHM+/Z2JwXw==
X-Received: by 2002:a17:90b:3601:: with SMTP id ml1mr415743pjb.104.1584983763431;
        Mon, 23 Mar 2020 10:16:03 -0700 (PDT)
Received: from konoha.iitr.ac.in ([103.37.201.178])
        by smtp.gmail.com with ESMTPSA id 189sm13814020pfw.203.2020.03.23.10.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 10:16:01 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, peff@peff.net, heba.waly@gmail.com,
        newren@gmail.com, Johannes.Schindelin@gmx.de,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: [GSoC][RFC][Proposal v4] Convert submodule to builtin
Date:   Mon, 23 Mar 2020 22:45:54 +0530
Message-Id: <20200323171554.5254-1-shouryashukla.oo@gmail.com>
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
Apologies for the late reply, I had been working on the conversion since and needed some concrete study for my proposal. This is the fourth draft of my GSoC Proposal. Though my v3 did not get reviewed, I decided to deploy an even more improved version of my proposal, so here it goes. I have acted upon Christian's advice and reviews of my proposal.

Link to v3:
https://lore.kernel.org/git/20200318191033.443-1-shouryashukla.oo@gmail.com/

Changes made:
	1. Corrected some of the links provided[v3]
	2. Renamed 'Relevant Work' to 'Workflow'[v3]
	3. Corrected grammatical errors and spelling mistakes[v3+v4]
	4. Added more information about the conversion process as well as the current
	   state of the subcommands left to convert, along with a potential process and
	   direction of the conversion[v3]
	5. Improved the Timeline[v4]
	6. Added more description and strenghtened the information in change 4[v4]
	7. Added more relevant information in the 'Previous Work' section[v4]
	8. Added website link in the 'Contact Information' section[v4]
	9. Added the 'Current Status of the subcommand and future vision' section[v4]
	10. Added the 'Contribution process and interaction with the mentors' section[v4]
	11. Added the 'Final Remarks' section[v4]

One thing I wanted to ask was that how do I foresee a good strategy and required helper functions
for the subcommands add, set-branch and set-url, as I am not working on them currently, hence I am
not able to exactly predict a path as of now. I can foresee a skeleton for these subcommands but
not a precise track for the same. :/

I have almost completed the frontend 'module_summary()' function. This commit describes the following:
https://github.com/periperidip/git/commit/db3604f653e02a90145abb56cffb2d4860ececa2
Note: Travis CI failed due to some errors there are in the change which I will address in the next commit.

Currently, I am studying other subcommands and trying to find a better direction for the code. I am also studying
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


## The Project: Convert submodule to builtin

#### Outline

Git commands were initially implemented directly in shell script with some instances of Perl as well. As times progressed, various platforms to run Git emerged, _enter_, problems in production code. There were multiple problems with shell scripts, such as: large function call overhead for large projects and compatibility of code across platforms(e.g.: POSIX-to-Windows path conversion issues). To fix this issue, it was decided to convert these scripts into portable C code(the original intention C was developed with, to have portable code and software).

Various commands have been converted as of now, such as add, blame, bisect(work in progress), etc. In my project, I intend to convert submodule into C fully, hence making it a ‘builtin’. 


#### Previous Work

There has been an ongoing work in the conversion of various Git commands such as 'add', 'commit', 'blame', etc. from their shell form into their C form. 'git submodule' is one of the commands left to fully convert into its C form. Stefan Beller <stefanbeller@gmail.com> converted a large part of this command up until 2019. Prathamesh Chavan <pc44800@gmail.com> also aided in the conversion of the command during his GSoC project in the year 2017. In its current state, four subcommands are due for conversion, namely: 'add', 'set-branch', 'set-url' and 'summary'. Also, the Command Line parsing Interface needs improvements, such as better error messages and support for more subcommands.

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

I aim to follow the same approach as Stefan and Prathamesh as mentioned above. Though, there is about a 3 year gap between their work and mine, the model for porting seems to be consistent even if coding style may vary and might even give out improvements over previous implementations.


#### Contribution process and interaction with the mentors

I will keep committing changes on my GitHub fork[https://github.com/periperidip/git] and finally post a bundled patch on the Mailing List. I will make sure to keep interacting with the community as well as the mentors regularly. 	I aim to write weekly “progress report” blogs, which I will post on my website as well as the List. Apart from that, I will document anything new I learn as well as my journey in the GSoC program on my blogs and maybe as self-answered questions on StackOverflow with the aim that they will help me as well as others in case of reference.


#### Project Timeline

I have been studying the code of 'submodule.c', 'submodule--helper.c' and 'git-submodule.sh'
since the submission of my microproject. After studying the codes, I tried to devise an effective
conversion strategy for 'submodule'. I noticed that 'submodule.c' contains various helper functions
for 'submodule--helper.c' whereas the latter houses the main "converted" command as of now.
      
The subcommands ‘set-branch’ and ‘set-url’ will provide easy conversion due to the vast array of helper functions already available for them. Hence, I have coupled them with other commands and tasks such as the conversion of ‘add’ and improving CLI parsing.
In spite of the easiness of the aforementioned conversions, I have decided to convert ‘summary’ first because of the large variety of resources available for it as well as a direction of conversion available(as done by Prathamesh) which will aid me in learning from the mistakes committed before and thus help me offer an even more improved version of the subcommand.
Therefore, after all these considerations, the timeline looks like:	
  
  - Empty Period (Present - April 26)
    --> I am writing a paper(on the project[https://github.com/periperidip/UAV-based-wireless-networks-2] I have been working upon) for a conference which I have to finalise and submit by first week of April.
    --> My end-semester exams begin on April 23 hence I might be a bit busy before a week or so before the start date.
    --> I plan on starting the conversion of ‘summary’ in this period. Although, I am busy, I will try my best to implement a basic scaffolding and maybe
	even complete some good portion of the subcommand for the command and will keep my mentors posted regarding the same.
 
  - Community Bonding Period (April 27 - May 18)
    --> Get familiar with the community
    --> Improve the project workflow: make some timeline changes if necessary.
    --> Finish implementation of `summary` subcommand
    --> Update the Documentation

   
  - Phase 1 (May 19 - June 6)
    --> Convert 'set-url' subcommand
    --> Improve CLI parsing(give out better error messages)
    --> Update the Documentation
    --> Add appropriate tests for integration testing of ‘set-url’ and ‘summary’

    
  - Phase 2 (June 7- August 8)
    --> Convert 'add' subcommand
    --> Convert 'set-branch' subcommand
    --> Update the Documentation
    --> Add appropriate tests for integration testing of ‘add’ and ‘set-branch’ with the whole system

    
  - Final Phase (August 9 - August 17)
    --> Improve and add Documentation(if there is any still left)
    --> Apply final touch-ups to code

If there is some extra time left, I will try to implement some BONUS features.

**BONUS features:** Consist of command touch ups and improving some bugs such as code sections with 'NEEDSWORK' tags, improving the test files and maybe improve some previous implementations of helper functions.


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

