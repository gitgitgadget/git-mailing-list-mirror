Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75BD9207EC
	for <e@80x24.org>; Thu,  6 Oct 2016 22:42:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935408AbcJFWmL (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Oct 2016 18:42:11 -0400
Received: from avasout02.plus.net ([212.159.14.17]:47076 "EHLO
        avasout02.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933672AbcJFWmI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2016 18:42:08 -0400
Received: from [10.0.2.15] ([194.75.29.46])
        by avasout02 with smtp
        id sNi21t0070zhorE01Ni3Eq; Thu, 06 Oct 2016 23:42:06 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=G/5eKJs5 c=1 sm=1 tr=0
 a=g54qAj+LxVGqXy9pVcJ+0w==:117 a=g54qAj+LxVGqXy9pVcJ+0w==:17
 a=IkcTkHD0fZMA:10 a=S3BrH6ej_XDh2nDupuMA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: Regression: git no longer works with musl libc's regex impl
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20161004150848.GA7949@brightrain.aerifal.cx>
 <20161004152722.ex2nox43oj5ak4yi@sigill.intra.peff.net>
 <20161004154045.GT19318@brightrain.aerifal.cx>
 <alpine.DEB.2.20.1610041802310.35196@virtualbox>
 <CACBZZX4XPqZauD_M_ieOwVauT1fi3MQb4+6taELQaRG9M-Kz_w@mail.gmail.com>
Cc:     Rich Felker <dalias@libc.org>, Jeff King <peff@peff.net>,
        Git <git@vger.kernel.org>, musl@lists.openwall.com
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <20336ac7-a494-d725-f928-834b1b3194fe@ramsayjones.plus.com>
Date:   Thu, 6 Oct 2016 23:42:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <CACBZZX4XPqZauD_M_ieOwVauT1fi3MQb4+6taELQaRG9M-Kz_w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 06/10/16 20:18, Ævar Arnfjörð Bjarmason wrote:
> On Tue, Oct 4, 2016 at 6:08 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>> As to making NO_REGEX conditional on REG_STARTEND: you are talking about
>> apples and oranges here. NO_REGEX is a Makefile flag, while REG_STARTEND
>> is a C preprocessor macro.
>>
>> Unless you can convince the rest of the Git developers (you would not
>> convince me) to simulate autoconf by compiling an executable every time
>> `make` is run, to determine whether REG_STARTEND is defined, this is a
>> no-go.
> 
> But just to clarify, does anyone have any objection to making our
> configure.ac compile a C program to check for this sort of thing?
> Because that seems like the easiest solution to this class of problem.

Err, you do know that we already do that, right?

[see commit a1e3b669 ("autoconf: don't use platform regex if it lacks REG_STARTEND", 17-08-2010)]

In fact, if you run the auto tools on cygwin, you get a different setting
for NO_REGEX than via config.mak.uname. Which is why I don't run configure
on cygwin. :-D

[The issue is exposed by t7008-grep-binary.sh, where the cygwin native
regex library matches '.' in a pattern with the NUL character. ie the
test_expect_failure test passes.]

ATB,
Ramsay Jones


