Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E9B6C433EF
	for <git@archiver.kernel.org>; Thu,  7 Jul 2022 19:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236487AbiGGTRk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jul 2022 15:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236436AbiGGTRj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jul 2022 15:17:39 -0400
X-Greylist: delayed 181 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 07 Jul 2022 12:17:37 PDT
Received: from avasout-peh-004.plus.net (avasout-peh-004.plus.net [212.159.14.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824AA59248
        for <git@vger.kernel.org>; Thu,  7 Jul 2022 12:17:37 -0700 (PDT)
Received: from [10.0.2.15] ([147.147.167.40])
        by smtp with ESMTPA
        id 9WxLoa8U1uTE09WxMoO20y; Thu, 07 Jul 2022 20:14:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1657221274; bh=enQv3m0YTuNr/HORH/TgxAczC/oeRI5qmYWnH03Z6XE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=YQHQ9/uLuVj9otkGTEPZz3mTof8SzSze4QQ+UYc/f6/PqhmrDfuiIUBE3YCtPVfCS
         rYF0Do9nU+Ct5AqWsmjgXtSq64xobzbe5DQWW6pxt5S6MkDUeZJxgjMG+dETuVgB07
         2SGuYNJD2D12TH/ceRuqr9CZtldSASMqFe/+iHyvFdccQfZ0nNE1VwL3heF7LIGDi1
         DiVDkkhLv4H4J0DYEP9lt23GxGnQzIF84iNGTqqSoe10xOFH1DM/zDdyh1ddac0hTD
         veYYByIdVPd11KRj4R9G3mrMWRbMeMi62JDHr85FCAtpsDykgt3/TmKMw+lbH91EVs
         NaMzsPOodQf8g==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=DfIEF9hW c=1 sm=1 tr=0 ts=62c7309a
 a=nyqnwr6A7Kzjd6EpZhiMcA==:117 a=nyqnwr6A7Kzjd6EpZhiMcA==:17
 a=IkcTkHD0fZMA:10 a=Y6dKmrH1PYL5vlQLHkAA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Message-ID: <fa951e27-7b7b-848c-01c8-f706f97d87e7@ramsayjones.plus.com>
Date:   Thu, 7 Jul 2022 20:14:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: t0301-credential-cache test failure on cygwin
Content-Language: en-GB
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <9dc3e85f-a532-6cff-de11-1dfb2e4bc6b6@ramsayjones.plus.com>
 <xmqqtu7t30uv.fsf@gitster.g>
 <4529b11a-e514-6676-f427-ffaec484e8f1@ramsayjones.plus.com>
 <Yscl/Jx4g74RwkCK@coredump.intra.peff.net>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <Yscl/Jx4g74RwkCK@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfK5KmkojiE36aGX2nT7b6VLcrBIawt5oCEFEj4clque7nksHB6ZRIi+SYBDduA7E7Pa9Dba9F6rPPXN0LRSnHctL4YWJcCLS5CdEv+QbReHHc2DeLQfd
 WHBCFMsh0403maBvEiD2XrJe1KjReyUtxsp9WR86f8OE1I/JSaFfj61KTAveAQET6A5GNIAeKCY48xlIWKGZAwNcHfk1/Bwfn1k=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 07/07/2022 19:29, Jeff King wrote:
> On Thu, Jul 07, 2022 at 04:17:08PM +0100, Ramsay Jones wrote:
> 
>> Also, I would like to understand why the code is written as it is
>> currently. I'm sure there must be a good reason - I just don't know
>> what it is! I suspect (ie I'm guessing), it has something to do with
>> operating in a high contention context [TOCTOU on socket?] ... dunno. ;-)
> 
> By the way, I was slightly surprised you did not find the explanation in
> the commit history. A blame[1] of credential-cache--daemon.c shows that
> the comment was added by 7d5e9c9849 (credential-cache--daemon: clarify
> "exit" action semantics, 2016-03-18) which mentions the race in the
> tests. And then searching for that commit message in the list yields the
> thread I linked earlier with more context[2].

Heh, just 10min before I read your previous email (er, actually your
previous, previous email) I found commit 7d5e9c9849 (credential-cache--daemon:
clarify "exit" action semantics, 2016-03-18). I hadn't had time to dig
any further yet (as usual I'm trying to do 3 things at the same time).

What can I say? It was nearly 3am and I wanted to go bed. It took nearly
50min just to write the email. This was just a _quick_ look remember! ;-)

Sorry!

ATB,
Ramsay Jones


