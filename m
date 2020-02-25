Return-Path: <SRS0=m/64=4N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A9D6C35E0D
	for <git@archiver.kernel.org>; Tue, 25 Feb 2020 19:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69EF920732
	for <git@archiver.kernel.org>; Tue, 25 Feb 2020 19:45:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LtxOy5eB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731594AbgBYTpp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Feb 2020 14:45:45 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:37347 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729207AbgBYTpp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Feb 2020 14:45:45 -0500
Received: by mail-pj1-f66.google.com with SMTP id m13so163969pjb.2
        for <git@vger.kernel.org>; Tue, 25 Feb 2020 11:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZZTZxi0X8ZPWaOyvc+agiDVKJX8KaV1Dvf26aqFUbew=;
        b=LtxOy5eB+DsJO395C7NC4mOGLH+qJ4dMI2Q2fEMW6V1/Tu3IBr2RxLUYX2iGreHo4a
         8MWbva+JyTsL3/0L+cXJUfD8aOviCRVyUdRqrjFZkX811ZjTEhdK1qqgqRgw70RSwu2w
         qGsizBWpdGoZeBUAuN6wC6ZFktIDjrqJ4hAm+9PMoPYfIcYYfJ2EItLJNOhJ4kbzHLXj
         WRZW9ugSGgbzD1mdqUZXdh45cHrrSvp9d2JjJpxcPFJaFBeLQARSbEEmxXDj7tf19YNx
         OBKR8Q3+GHE9PpzKBjbx0CBuCKcQDTbfPmPKaG1YrzSegBeidGEqpmyYy18hLpnE7HrA
         RFwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZZTZxi0X8ZPWaOyvc+agiDVKJX8KaV1Dvf26aqFUbew=;
        b=Oo+qe6TV92/8cfRA/47Sg9LYF0RNCBuKAXfzyIsEUnn1yPC+W5gIi4uudpEtPUHO7M
         BsOAmfYYrxu4WGogIOvLgbOgWVs2WdCSbhJEtbRgaRVCNwABCI9Rv+ChOAwHQP4dWm3m
         JJ8/4TqsjMCJ+98Vnn3+MU4qYhDuIRbHa+Q5ns1nWu43pskcK58UlY0htl7BimBhOoOt
         FAVLYyDXWEHjk1mboLowD1KB0c6n5GJURR8AUcHMUuwe8Odhs+wnj08Ai47bvXGiPj2r
         GFziUsfPulZCZ6PJaXkeMJpB+cAaTuZBeOzy4Aje6mWDY77Tr531SSiem7bDuL2idvn0
         OJvw==
X-Gm-Message-State: APjAAAXtM41tEEyQdqmMULWylj4NIdlXUGM1toTRXN3LmsDVGl9YIHBw
        z7t/iDF2EWouO7QF1HO0q3wEnEPV229s7Q==
X-Google-Smtp-Source: APXvYqxffoZEgHKArd/W98YQJJKylI3/p1KG3gApoRO4UpcJvq/fUhNMyGJC8Zw2fAC4okLN64zEeA==
X-Received: by 2002:a17:902:9b8b:: with SMTP id y11mr110388plp.189.1582659943687;
        Tue, 25 Feb 2020 11:45:43 -0800 (PST)
Received: from konoha.iitr.ac.in ([103.37.201.170])
        by smtp.gmail.com with ESMTPSA id h185sm18411682pfg.135.2020.02.25.11.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 11:45:42 -0800 (PST)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, christian.couder@gmail.com,
        peff@peff.net, newren@gmail.com, stolee@gmail.com,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: [GSoC][RFC] Proposal: Convert scripts to builtins
Date:   Wed, 26 Feb 2020 01:15:36 +0530
Message-Id: <20200225194536.20549-1-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello everyone,

I am Shourya, and this is the first draft of my proposal for the project titled:
'Convert scripts to builtins'. I need your feedback and more than that I need help
to improve my project timeline.
Specifically, I'd like your thoughts on the early commencement of the project and
how should I adjust the timeline accordingly. Any guidance the Community can provide
is greatly appreciated :)

Thanks,
Shourya

-x-x-x-x-x-x-x-x-x-x-x-x-x--x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x


# Convert scripts to builtins

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

I am Shourya Shukla, a sophomore in Computer Science and Engineering at the
Indian Institute of Technology Roorkee[1]. I was introduced to programming at
a young age and I have been trying to learn new concepts everyday since. My
interests include modern mobile networks, Internet of Things and system software
development. I have been working on a project which involves providing cellular
network access to users in a disaster-struck are via drones. I love low-level
coding and FLOSS as well. I have been an active part of the Git community since
January of this year, contributing to Git.


## Work Envinronment

I am fluent in C/C++, Java and Shell script, and have an understanding of Python
as well. I use Git as my VCS and Visual Studio Code with integrated GDB as my
primary code editor and Ubuntu 19.10 as my primary Operating System unless the
work specifically needs Windows.


## Contributions to Git

Contributing to Git helped me understand a lot about how modern & robust softwares
work as well as how real world development takes place. I plan on contrubuting even
more to Git and make my contributions count. As of now, my contributions at Git are:

---------------
status: merged
git/git:
[Microproject][2]: Modernise tests and use helper functions in test script.


## The Project: 'Convert scripts to builtins'

#### Overview

There has been an ongoing work in the conversion of various Git commands
such as `add`, `commit`, `blame`, etc. from their shell form into their C form.
`git submodule` is one of the commands left to fully convert into its C form.
Stefan Beller <stefanbeller@gmail.com> converted a large part of this command
up until 2019. Prathamesh Chavan <pc44800@gmail.com> also aided in the conversion
of the command during his GSoC project in the year 2017. In its current state, four
subcommands are due for conversion, namely: 'add`, `set-branch`, `set-url` and `summary`.
Also, the Command Line parsing Interface needs improvements, such as better error messages
and support for more subcommands.


#### Project Timeline

I have been studying the code of `submodule.c`, `submodule--helper.c` and `git-submodule.sh`
since the submission of my microproject. After studying the codes, I tried to devise an effective
conversion strategy for `submodule`. I noticed that `submodule.c` contains various helper functions
for `submodule--helper.c` whereas the latter houses the main "converted" command as of now.
      
Therefore, the timeline looks like:
  
  - Community Bonding Period (April 27 - May 18)
    --> Get familiar with the community
    --> Improve the project workflow
   
  - Phase 1 (May 19 - June 6)
    --> Convert `summary` subcommand
    --> Improve CLI parsing
    
  - Phase 2 (June 7- August 8)
    --> Convert `add` subcommand
    --> Convert `set-url` subcommand
    --> Convert `set-branch` subcommand
    
  - Final Phase (August 9 - August 17)
    --> Documentation
    --> Final touch-ups to code

If there is some extra time left, I will try to implement some BONUS features.

**BONUS features:** Consist of command touch ups and improcing some bugs such as code
                    sections with 'NEEDSWORK' tags.


## Relevant Work

I have divided the project into 3 subprojects(SP).

    1. **SP 1:** Convert `summary`
    2. **SP 2:** Convert `add` and improve CLI(Command Line Interface) parsing        
    3. **SP 3:** Convert `set-url` and `set-branch`
    
After discussions with Christian Couder, I plan to start SP1 before GSoC itself. Currently,
I am studying the code in detail and constructing a scaffolding for this implementation.
I aim to complete the leftover bits of SP1 during Phase 1 and SP2 & SP3 during Phase 2 of
GSoC.

As Derrick Stolee advised[3], the conversion may not be possible in one whole summer, hence,
I think an early start might be needed to finish things in time if possible.


## Availability

The official GSoC period starts from April 27 and ends on August 17. My vacations start
from May 10 and will be over by July 13. I can easily devote 45-50 hours per week until
the commencement of my Semester. Other than this project, I have no commitments planned
for my vacations. I shall keep the community posted in case of any change in plans.


## Post GSoC

Even after the completion of Google Summer of Code, I plan on continuing my contributions
to Git, on the technical front(in terms of code and documentation contributions) as well
as on the social front(solving people's doubts/problems on the List as well as on StackOverflow).
I vision to convert the remaining of the commands as pointed out by Dscho[3] as well as improve
the test files.

I aim to develop mentorship skills as well as the ability to guide others and try to give back to
the community by mentoring and guiding others as well(by reviewing their code, helping them out, etc.)

------------------------------------------------------------------------------------------------
[1]: https://www.iitr.ac.in/
[2]: https://lore.kernel.org/git/20200116203622.4694-1-shouryashukla.oo@gmail.com/
[3]: https://lore.kernel.org/git/nycvar.QRO.7.76.6.2001301154170.46@tvgsbejvaqbjf.bet/T/#m232941f6cdcf92b97b3531f6fc582935c06734cf
[4]: https://lore.kernel.org/git/nycvar.QRO.7.76.6.2001301154170.46@tvgsbejvaqbjf.bet/T/#m637c5c97d42dc68aab85420b5ffcaeb34c270ad3
