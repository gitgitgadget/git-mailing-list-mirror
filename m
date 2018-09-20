Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 572EB1F453
	for <e@80x24.org>; Thu, 20 Sep 2018 16:03:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728375AbeITVrR (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Sep 2018 17:47:17 -0400
Received: from avasout06.plus.net ([212.159.14.18]:35187 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbeITVrQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Sep 2018 17:47:16 -0400
Received: from [10.0.2.15] ([80.189.70.183])
        by smtp with ESMTPA
        id 31Q1gHO0xWLW231Q2gwWHQ; Thu, 20 Sep 2018 17:03:06 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=fJUXI6Se c=1 sm=1 tr=0
 a=6SF67mWK+VR8hB1Kjo6y2g==:117 a=6SF67mWK+VR8hB1Kjo6y2g==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=gO1Qu0pG3_wdf42VTcEA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 1/9] Makefile: add a hdr-check target
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, GIT Mailing-list <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>
References: <d24df21a-7ab2-84f6-8b18-83fd9c8c2b30@ramsayjones.plus.com>
 <xmqqbm8s2qjd.fsf@gitster-ct.c.googlers.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <b7b9b26d-c175-05b9-7144-101bcaf592d4@ramsayjones.plus.com>
Date:   Thu, 20 Sep 2018 17:03:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <xmqqbm8s2qjd.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfHRby8cPzaiCqqHokVMef0eYvjl1jkX0hlImJegDa1ASSrt4cFJH9gP0uREujmhZhawdK6MJ5QA0BE/8DVloPrEgkJEq7RwCQFekDdS7skzmlK0265h6
 EILwYzMF312lxPRFM9/pzNUg0iq5gnQXtKqXfRxemlgeDZ82shkk4QMs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 20/09/18 15:26, Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
> 
>> Commit ef3ca95475 ("Add missing includes and forward declarations",
>> 2018-08-15) resulted from the author employing a manual method to
>> create a C file consisting of a pair of pre-processor #include
>> lines (for 'git-compat-util.h' and a given toplevel header), and
>> fixing any resulting compiler errors or warnings.
> 
> It makes sense to have tool do what we do not have to do manually.
> 
> One thing that makes me wonder with the patch is that the new check
> command does not seem to need to see what is on CFLAGS and friends.
> Having seen that "make DEVELOPER=1" adds more -W... on the command
> line of the compiler and makes a build fail on a source that
> otherwise would build, I am wondering if there are some (subset of)
> options that the header-check command line wants to give to the
> compiler.

Yes, this was one of my first concerns (I even asked Elijah what
compiler options he used), but I was getting useful results without
passing CFLAGS, so I just ignored that issue ... :-D

[The 'on-the-fly' compilation units don't correspond to any _actual_
compilation unit, so it's not easy to use existing rules ... but we
could use 'hco' rule specific definitions to add flags, I suppose ...]

> Of course, there are also conditionally compiled sections of code,
> which are affected by the choice of -DMACRO=VALUE; how does this new
> feature handle that?

Indeed. This bothered me as well. The 'compat' directory does not
follow the 'usual pattern' of the main headers and is particularly
sensitive to the lack of various -DMACROs. I had initially included
_all_ sub-directories in the 'exclude list' (to follow what Elijah
had done), but then removed one at a time ...

I am open to suggestions for improvements. ;-)

ATB,
Ramsay Jones



