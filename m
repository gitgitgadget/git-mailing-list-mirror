Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C84FF1F404
	for <e@80x24.org>; Fri, 26 Jan 2018 17:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751638AbeAZRez (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 12:34:55 -0500
Received: from siwi.pair.com ([209.68.5.199]:29367 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751403AbeAZRey (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jan 2018 12:34:54 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 523AC8450D;
        Fri, 26 Jan 2018 12:34:53 -0500 (EST)
Received: from [192.168.1.71] (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 7CCB3844F8;
        Fri, 26 Jan 2018 12:34:52 -0500 (EST)
Subject: Re: [RFC PATCH 0/1] Implement CMake build
To:     Isaac Hier <isaachier@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <20180123001648.24260-1-isaachier@gmail.com>
 <675fa58d-bff3-d7e4-5fac-ecf1401932f4@jeffhostetler.com>
 <CAG6xkCbe+pLwTCButZGdPucHoRCq-a8mWfifd6z2bzGZNseE9A@mail.gmail.com>
 <ee5185b1-7820-b2ac-1bde-da1c761fa594@jeffhostetler.com>
 <CAG6xkCa_nKtzhJJq=v7gazWe+8FnN3mz1vDftzZw2WUFqJ1bzw@mail.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <c134350c-5f73-9194-9815-a7f61ed30d03@jeffhostetler.com>
Date:   Fri, 26 Jan 2018 12:34:51 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CAG6xkCa_nKtzhJJq=v7gazWe+8FnN3mz1vDftzZw2WUFqJ1bzw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 1/25/2018 7:21 PM, Isaac Hier wrote:
> Hi Jeff,
> 
> I have been looking at the build generator, which looks promising, but
> I have one concern. Assuming I can generate a CMakeLists.txt that
> appropriately updates the library sources, etc. how do you suggest I
> handle new portability macros? For example, assume someone adds a
> macro HAVE_X to indicate the availability of some platform-specific
> function x. In the current Makefile, a comment would be added to the
> top indicating when HAVE_X or NO_X should be set, and that option
> would toggle the HAVE_X C macro. But CMake can test for the
> availability of x, which is one of the main motives for adding a CMake
> build. The current build generator uses the output of make, so all it
> would know is whether or not HAVE_X is defined on the platform that
> ran the Makefile, but not the entire list of platform that git
> supports.
> 
> Bottom line: should I add the portability tests as they are now,
> without accounting for future portability macros? One good alternative
> might be to suggest the authors of new portability macros include a
> small sample C program to test it. That would allow me to easily patch
> the CMake tests whenever that came up. In a best case scenario, a
> practice could be established to write the test in a specific
> directory with a certain name so that I could automatically update the
> CMake tests from the build generator.
> 
> Thanks for the help,
> 
> Isaac

It's been years since I've used cmake as anything other than
a casual (downstream) consumer, so I'm not sure I can answer
your questions.

The vcxproj target we have is a bit of a hack to automatically
capture the set of source files and target libraries and executables.
We don't try to capture the spirit of all of the HAVE_ and NO_ flags
when we build the *.vcxproj files.  And we make some assumptions in
the generation template for the usual VC/VS settings.  But then
Windows is a single target and we don't have to worry about some
things (like whether or not qsort is present).

I don't want to discourage you from attempting this.  (And I realize
that my initial response might have given that impression -- I mainly
wanted to say that we don't currently have a problem on Windows with
the current Makefile situation.)

A full cmake system would let us simplify some things, but it also
complicates some things.  So we might be trading one set of problems
for another.  For example, the libgit2 project uses cmake.  Not to
pick on them, but when I look at it, I see a lot of the same issues
(but perhaps with better syntax than the makefile).

     https://github.com/libgit2/libgit2/blob/master/CMakeLists.txt

As to your portability test questions, I'm afraid I don't know.
Sorry,
Jeff


