Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B47BB1FAE2
	for <e@80x24.org>; Tue, 20 Mar 2018 23:02:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751718AbeCTXCg (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Mar 2018 19:02:36 -0400
Received: from avasout04.plus.net ([212.159.14.19]:55781 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751688AbeCTXCc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Mar 2018 19:02:32 -0400
Received: from [10.0.2.15] ([80.189.70.162])
        by smtp with ESMTPA
        id yQH0eat6hsD7byQH1e987V; Tue, 20 Mar 2018 23:02:31 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=CvORjEwD c=1 sm=1 tr=0
 a=zzlqjQC3YyNvDZl/Gy+4mg==:117 a=zzlqjQC3YyNvDZl/Gy+4mg==:17
 a=IkcTkHD0fZMA:10 a=NEAV23lmAAAA:8 a=5rxgeBVgAAAA:8 a=U7UbAiMzAAAA:8
 a=-g_arkhoZMa9Vdi9YzwA:9 a=9zyFYljk-rIbivDk:21 a=Wday6L0f_gUK2sTJ:21
 a=QEXdDO2ut3YA:10 a=PwKx63F5tFurRwaNxrlG:22 a=cNtvukwP7kaFzDVqf0Q5:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 0/2] -Wuninitialized
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        GIT Mailing-list <git@vger.kernel.org>
References: <8f6d8e2e-aba4-128c-f17c-6c1b9c12436c@ramsayjones.plus.com>
 <nycvar.QRO.7.76.6.1803201514490.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <b939f3e7-9ccf-9a26-9ccf-2b2c13853e42@ramsayjones.plus.com>
Date:   Tue, 20 Mar 2018 23:02:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1803201514490.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfLIePUWxRw4AKXIG8LnoSkSxkrP/sRN3O9gGV4oAnHL3NHGijEXWPnGei0KQcAx3sZSB1SgaslKiuGDupFf3rwc8dpJ2lEigI6X5RSAem4TSENSP8347
 rLG4wP2zBRapZK93g1vu9roC1Vw9Pggd142O8y5ao48Mn4HuTJENEq7A53b9F6g5ks43oa7tfuJ8SQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 20/03/18 14:46, Johannes Schindelin wrote:
> Hi Ramsay,
> 
> On Mon, 19 Mar 2018, Ramsay Jones wrote:
> 
>> This series removes all 'self-initialised' variables (ie. <type> var =
>> var;).  This construct has been used to silence gcc
>> '-W[maybe-]uninitialized' warnings in the past [1]. Unfortunately, this
>> construct causes warnings to be issued by MSVC [2], along with clang
>> static analysis complaining about an 'Assigned value is garbage or
>> undefined'. The number of these constructs has dropped over the years
>> (eg. see [3] and [4]), so there are currently only 6 remaining in the
>> current codebase. As demonstrated below, 5 of these no longer cause gcc
>> to issue warnings.
> 
> Thank you so much for working on this!

These patches are based on a very old branch (that goes back
at least as far as 2010, see [1]). (I have too many in my repo,
so it will be good to remove this one)!

> In Git for Windows, to work around the MSVC issues you mention, I have
> this ugly work-around (essentially, it has a FAKE_INIT() macro that either
> performs that GCC workaround or initializes the variable to NULL/0):
> 
> 	https://github.com/git-for-windows/git/commit/474155f32a

Oh, wow! (Hmm, actually that doesn't look too bad :-D )

> FWIW I just tested your patches with Visual Studio 2017 and there are no
> C4700 warnings (the equivalent of GCC's "may be uninitialized" warning)
> [*1*].
> 
> You can find the patches (your patches rebased onto Git for Windows'
> master, plus a patch adding the project files for Visual Studio) here:
> 
> https://github.com/git-for-windows/git/compare/master...dscho:msvc-uninitialized-warning-test

Thanks for testing the patches.

> So here is my ACK, in case you want it ;-)

Thanks!

ATB,
Ramsay Jones

[1] https://public-inbox.org/git/4CFA8D4D.2020500@ramsay1.demon.co.uk/
