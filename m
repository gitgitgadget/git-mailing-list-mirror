Return-Path: <SRS0=kv1d=5J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FAD3C43331
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 20:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6F2C208E0
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 20:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ug2pCxBC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbgCXUTK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Mar 2020 16:19:10 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45911 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbgCXUTK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Mar 2020 16:19:10 -0400
Received: by mail-pg1-f194.google.com with SMTP id o26so3095498pgc.12
        for <git@vger.kernel.org>; Tue, 24 Mar 2020 13:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=yPCKP+9zqXoXoX/2ajxABAtJ8f+HRA/9/fnSb+n/z68=;
        b=ug2pCxBCWqzPoCoxhRYukXkbCmgWaVwaM02rRF4F5cJU8d7AmYtu1BrRw4okDYwvJL
         /t0kZiLVBDtIXETGyHJrg878g9XDyHwVgrMfJEEwrx8k2NIe4mRDlX4CUM+hZQ4r0pgY
         Uqru73JzFExkaminIPx3/nYWVb7dK4HoAN3dpNDN/1TCFCKgON0EO/5IfmhfEd9gm5SQ
         9q/+ad9jYxvu4sCqqC3c7+vAmVhmpmzXkBl3+s5sBUJibi0lTHnSR7uYgg+4UYz6Zqgu
         5gMUCNMiMpx1P22xXG836lZpjLpE3TDDEVtuwzrjbH3NIAES3MukjO+i+x+SLTAnj9NT
         GoPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=yPCKP+9zqXoXoX/2ajxABAtJ8f+HRA/9/fnSb+n/z68=;
        b=nFpsuvq+rxR3kEuW9EEad1s7kfLjS+zBlz3BUfODpWZNJXjM5nWctzGi1Jia10l7rM
         nE7HjIAdN1x2l3ayu16ubWZ5evk5hq7B/YS3u5Zv7bmn78PKkUs1O+StnXoooKRiJp22
         Ef0X1nM+1KM17F3gZGvc9CiSKFega+3FbttDLrgtFVidTklZi2hwjIPr6gk7nqILixfX
         pniTcNsBFt56kq9KWbhzE3iThKciWc9Qnr3PiUkDNl5RAiuUtaYMDNYiZWF/P+ytCc4H
         0a3VI7MnNsolr48zO4YBmdKfGqFUuD4DabNb2JzH+9FYpeLD/KJXAsGWqZbWdBAzB6b6
         Y3tA==
X-Gm-Message-State: ANhLgQ0Epa5D3CD6zRf/bp8popRXqLpOWK38tMuoJdFQBtchgP/aW0ai
        OOSBCorenVGMh8nBrZab3a28yt+xTZ8=
X-Google-Smtp-Source: ADFU+vvou8/emiiVZq/0Eh1yPcu7e2IsN3lkcHkscPf5PeS+Elcp4zz9hipw/DJ/g2vtx2JLNKLRag==
X-Received: by 2002:a63:ec44:: with SMTP id r4mr28221088pgj.425.1585081148627;
        Tue, 24 Mar 2020 13:19:08 -0700 (PDT)
Received: from [192.168.0.113] ([27.106.96.28])
        by smtp.gmail.com with ESMTPSA id v123sm16328604pfb.85.2020.03.24.13.19.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2020 13:19:07 -0700 (PDT)
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes.Schindelin@gmx.de, peff@peff.net,
        Junio C Hamano <gitster@pobox.com>, stolee@gmail.com
From:   Parth Gala <parthpgala@gmail.com>
Subject: [GSoC][RFC][PROPOSAL v1] Improvements to git log
Message-ID: <049680a7-6042-9e23-34b1-3ace1f6778b6@gmail.com>
Date:   Wed, 25 Mar 2020 01:49:04 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello everyone,

Thanks for taking the time out to read my GSoC proposal.
I would love to receive feedback on this. One question I have is that
how should I contact my mentor(Christian Coulder) in the period from
April 4 - April 26 stated below, which will be akin to the community
bonding period for me, ie do the conversations take place on the mailing
list or personal emails or any other medium during this particular period ?

Google docs : 
https://docs.google.com/document/d/1H06V1sjE2i74NtXihiDNnApvx0iMemU2RotHt0SeDCI/edit?usp=sharing 

-------------x--------------x----------------x--------------x---------------x---------- 

Improvements to git log



## Contact Information

Name            :    Parth Gala
Major           :    Electronics and Communications Engineering
Email           : parthpgala@gmail.com
Mobile          :    ---
Github          :    ParthGala2k
Linkedin        :    Parth Gala
IRC             :    parth56
Timezone        :    IST (UTC +0530)



## Background

Hello, my name is Parth Gala, I am a sophomore majoring in Electronics
and Communications Engineering at Dwarkadas J. Sanghvi College of
Engineering.I have been programming for a few years now and have been
inquisitive to learn more about new things in the field of Computer
Science. I am proficient in C/C++, Java and Shell script and try to run
redundant tasks using scripts.



## Work Environment

I use Vim as my primary code editor and GDB as the debugger. I have been
using Linux(Ubuntu 18.04) as my primary operating system for two years
and was introduced to the world of open source about a year ago when I
started to learn Git and Github and have gained sufficient familiarity
with each of them.



## Motivation

I have been active in the git community since January this year. I was
inspired to contribute open source since it is a great way to get
started with making enterprise level software which is well documented
and tested. Google Summer of Code is the best way to get kick started in
that direction, and given I use git on a regular basis and would
continue doing so, it would be a great experience contributing to it as
well.


## Previous Contributions

Contributing to git helped me realize how high quality software is 
developed
by first considering the design, adding unit tests and more importantly, 
about
using git itself better to maintain a neat commit history and tracking 
newer
changes.


* Contributions to git


GitGitGadget https://github.com/gitgitgadget/git/pull/545
Mailing list 
https://lore.kernel.org/git/pull.545.git.1581535151.gitgitgadget@gmail.com/
Status          Yet to be merged

GitGitGadget https://github.com/gitgitgadget/git/pull/582
Status          Being reviewed by Johannes Schindelin before submitting 
to mailing list



## Project

* Abstract

’git log’ is a frequently used command that displays commit history of
the branch in various formats in order to make it easier to analyze the
changes made to code over a course of time and using various flags that
help you filter out only the commits that you need.

I plan to add a new pretty format called 'concise' which would show the
decorations(if any) on one line and the oneline commit message on the other
line. This would overcome the first problem stated below.

Another addition is the --log-day option which groups the commits by order
of their dates and displays a line on top of each commit specifying their
date only if it changes from the previous date displayed. This would be
useful if one wants to only check what changes took place on a certain day
and make it catchy to the eye to see which day a particular change was 
made.


## Current Shortcomings

Although there are various options in git log, still a few are missing that
many users would like for example “git log --oneline” shows the decorations
right after the commit hash but before the commit message causing the
alignment of messages to be disturbed. This can be overcome by setting a
custom format string to print the decorations after the message. Having the
decorations at the end has its own disadvantages, say, you only need to
check the status of a branch rather than its contents, then you would 
prefer
to have the decorations right next to the shortened commit hash.

Another desirable feature to have is a date line like ‘==YYYY-MM-DD==’ 
in the log
output right over the commits wherever a date changes.



## Goals

1. Create a --pretty=concise format to deal with the first issue.
2. Create a --log-day option to show date.


## Timeline Tentative

# April 4 - April 26

Discuss the compatibility of --log-day option with all other log options
and finalize its design so as to be easily extended or modified for
similar future enhancements such as --log-month or --log-day[range],
--log-day[onward] options and whether the option asks for author date
or the commiter date upon Junio's advice and do the same for
--pretty=concise.

Also discussion of the stitching of these two
options(output for when both are used together) shall be done in order
to decide how the design should be done. At the same time go through as
much of the relevant code in detail as possible for the said
enhancements.

I will be mostly unoccupied during this period and hope to
complete largely all the ‘community bonding period’ work with my
potential mentor Christian Coulder during this period itself.


## Community Bonding Period : April 26 - May 16

I will be having some submissions during the first few days of this
period followed by my end semester exams which will start May 4 and end
May 16. Since there are generous holidays between each paper, I intend
to keep a check on my GSoC project and be in touch with Christian during
this period for around 2 hours a day to depending on what needs to be
discussed or finalized before the project starts.

I also hope to finetune the project workflow and make timeline changes
if necessary during this period.


## Phase 1 : May 18 - June 13

1. Complete the --pretty=concise format option.
2. Add tests and documentation for the same.


## Phase 2 : June 14 - July 28

1. Work on the --log-time option.
2. Add tests and documentation for the same.


## Phase 3 : July 29 - August 10

1. Stitch both commands for being used together.
2. Update tests for both the previous phases.


## Final Phase : August 10 - August 17

1. Polish the patches to apply final touch-ups(if any)
2. Update documentation.

If there is any extra time left, I would like to discuss the viability and
use of --log-month option with the community and add it to the entire 
package
if many users on the mailing list would find that option useful to their
workflow.

I plan to communicate with my mentors in the form of PRs against my own
fork of the project and also intend to keep the community updated with my
progress in the form of weekly reports on the mailing list and inform 
everyone
involved in case of any changes to the timeline.


## Availability

I will be done with my mid-sems by April 4 following which I will be
largely unoccupied for 3 weeks until April 26 in which period I plan to
complete my obligations for the community bonding period.

My end sems will start May 4 upto May 16, so I will be relatively busy
for a week before it, but due to generous holidays between I will be able
to work upto 2 hours on my GSoC Project.

My vacations will start May 17 upto the second week of July, so during this
period I will be easily able to devote 45-50 hours a week. Even after my
college resumes, I will be able to contribute around 40 hours a week to the
project. Apart from this I have no other commitments or plans for the 
summers
barring the odd weekend trek



## Post GSoC

I would love to learn from such a rich community of developers who have
built a tool that a majority of the software world uses on a daily
basis. Needless to say that only the lure of the new features would also
be enough to bring me back to the community again and again but I will
still contribute to the community in code and discussions post GSoC, and
if possible be a co-mentor someday ?



## Final Remarks

I am a quick learner with a knack of not giving up on problems. I can
have a go at it all day long and learn everything necessary to git(get)
the job done. Selected or not I will continue to hustle and contribute
to git and other open source projects that interest me and improve
myself and the planet little by little everyday. After all that’s what
open source is all about !



----------x-------------x------------x------------x-------------x--------------x------------- 




