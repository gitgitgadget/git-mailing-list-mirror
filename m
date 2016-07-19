Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B14C51FEAA
	for <e@80x24.org>; Tue, 19 Jul 2016 17:59:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753482AbcGSR7e (ORCPT <rfc822;e@80x24.org>);
	Tue, 19 Jul 2016 13:59:34 -0400
Received: from lang.hm ([66.167.227.134]:49599 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753453AbcGSR7d (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2016 13:59:33 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id u6JHxKe5012603;
	Tue, 19 Jul 2016 10:59:20 -0700
Date:	Tue, 19 Jul 2016 10:59:20 -0700 (PDT)
From:	David Lang <david@lang.hm>
X-X-Sender: dlang@asgard.lang.hm
To:	Duy Nguyen <pclouds@gmail.com>
cc:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Herczeg Zsolt <zsolt94@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	"Theodore Ts'o" <tytso@mit.edu>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: Git and SHA-1 security (again)
In-Reply-To: <CACsJy8Bvqt9r2dRtRfx1C-3Fp16z3SJ=hp0i7-itwFwfEfZwTw@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1607191057170.25425@nftneq.ynat.uz>
References: <CAPp-Vrb_n6z39RLHZ4AeUaBFiJfL3_xX8Utfq7+bTgzZrza58Q@mail.gmail.com> <20160716201313.GA298717@vauxhall.crustytoothpaste.net> <alpine.DEB.2.20.1607170949360.28832@virtualbox> <20160717142157.GA6644@vauxhall.crustytoothpaste.net>
 <CACsJy8C+2=qv5Vu=tGeDTK_Q+XSAv3qEJw0nrHbEWU7psDf=Cg@mail.gmail.com> <20160717154234.GC6644@vauxhall.crustytoothpaste.net> <20160717162349.GB11276@thunk.org> <20160717220417.GE6644@vauxhall.crustytoothpaste.net> <1468804249.2037.0@smtp.gmail.com>
 <alpine.DEB.2.20.1607180905320.28832@virtualbox> <CAPp-Vran2GZFTyJHb2qxgh3uRpM0ar7K2+VbbLcBK74_7aaxVw@mail.gmail.com> <alpine.DEB.2.20.1607181750470.3472@virtualbox> <CACsJy8Ba=c+-WV2TsY768_fTDO2KesS1b6BK7kdykNY6gkh=UQ@mail.gmail.com>
 <alpine.DEB.2.20.1607190910370.3472@virtualbox> <CACsJy8CSUu=AemQ-7uxth_2M=ko_KDGsdObwYdiE=L4OMKcVZw@mail.gmail.com> <alpine.DEB.2.02.1607191032270.25425@nftneq.ynat.uz> <CACsJy8Bvqt9r2dRtRfx1C-3Fp16z3SJ=hp0i7-itwFwfEfZwTw@mail.gmail.com>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, 19 Jul 2016, Duy Nguyen wrote:

> On Tue, Jul 19, 2016 at 7:34 PM, David Lang <david@lang.hm> wrote:
>> On Tue, 19 Jul 2016, Duy Nguyen wrote:
>>
>>> On Tue, Jul 19, 2016 at 9:18 AM, Johannes Schindelin
>>> <Johannes.Schindelin@gmx.de> wrote:
>>>>>
>>>>> But we can recreate SHA-1 from the same content and verify GPG, right?
>>>>> I know it's super expensive, but it feels safer to not carry SHA-1
>>>>> around when it's not secure anymore (I recall something about
>>>>> exploiting the weakest link when you have both sha1 and sha256 in the
>>>>> object content). Rehashing would be done locally and is better
>>>>> controlled.
>>>>
>>>>
>>>> You could. But how would you determine whether to recreate the commit
>>>> object from a SHA-1-ified version of the commit buffer? Fall back if the
>>>> original did not match the signature?
>>>
>>>
>>> Any repo would have a cut point when they move to sha256 (or whatever
>>> new hash), if we can record this somewhere (e.g. as a tag or a bunch
>>> of tags, or some dummy commits to mark the heads of the repo) then we
>>> only verify gpg signatures _in_ the repository before this point.
>>
>>
>> remember that a repo doesn't have a single 'now', each branch has it's own
>> head, and you can easily go back to prior points and branch off from there.
>>
>> Since timestamps in repos can't be trusted (different people's clocks may
>> not be in sync), how would you define this cutoff point?
>
> The set of all heads at the time the conversion happens (maybe plus
> all the real tags). We can make an octopus merge commit to cover all
> the heads, then it can be the reference point.

so to make sure I'm understanding this, anything not reachable from that merge 
must be the new hash, correct? Including forks, merges, etc that happen from 
earlier points in the history.

David Lang
