Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69CF1C433DF
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 13:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CC092072D
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 13:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbgHQNUK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 09:20:10 -0400
Received: from siwi.pair.com ([209.68.5.199]:39150 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727931AbgHQNUJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 09:20:09 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id B73753F40FB;
        Mon, 17 Aug 2020 09:20:07 -0400 (EDT)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 880113F40FA;
        Mon, 17 Aug 2020 09:20:07 -0400 (EDT)
Subject: Re: [PATCH 1/5] Makefile: drop builtins from MSVC pdb list
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20200813145515.GA891139@coredump.intra.peff.net>
 <20200813145719.GA891370@coredump.intra.peff.net>
 <20200813150428.GA2244@syl.lan>
 <20200813150828.GA891963@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2008141611490.54@tvgsbejvaqbjf.bet>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <4fc1eaf3-86d8-99de-3a8f-34f49250cee3@jeffhostetler.com>
Date:   Mon, 17 Aug 2020 09:20:01 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.2008141611490.54@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 8/14/20 10:18 AM, Johannes Schindelin wrote:
> Hi Peff,
> 
> On Thu, 13 Aug 2020, Jeff King wrote:
> 
>> On Thu, Aug 13, 2020 at 11:04:28AM -0400, Taylor Blau wrote:
>>
>>> On Thu, Aug 13, 2020 at 10:57:19AM -0400, Jeff King wrote:
>>>> Over the years some more programs have become builtins, but nobody
>>>> updated this MSVC-specific section of the file (which specifically says
>>>> that it should not include builtins). Let's bring it up to date.
>>>>
>>>> Signed-off-by: Jeff King <peff@peff.net>
>>>> ---
>>>> Given that nobody has mentioned this, it makes me wonder if anybody is
>>>> even using this part of the Makefile at all these days. Or maybe having
>>>> extra lines here isn't a problem (though it's also missing some entries,
>>>> like one for git-bugreport).
>>>
>>> If having extra entries didn't cause a problem, I would suspect that it
>>> was just that. But that missing entries *also* doesn't cause a problem,
>>> I'd suspect that this section of the Makefile just isn't being used.
>>>
>>> Of course, I'm not using it since I'm not on Windows, but maybe dscho or
>>> Stolee would know if there are legitimate uses. Of course, if there
>>> aren't, I'm favor of getting rid of this section entirely.
>>
>> I cc'd Jeff Hostetler, who added it. :)
>>
>> I'm also pretty not-knowledgeable about Windows, but I think that
>> anybody using MSVC would do so through Visual Studio these days. And
>> that's being covered with recent cmake stuff. Or maybe I'm just
>> clueless. We'll see.
> 
> We have a couple ways to build Git on Windows:
> 
> - the standard way, in a Git for Windows SDK (which is a slightly modified
>    subset of MSYS2). This uses GCC and GNU make and all the things that you
>    might suspect given Git's origins on Linux.
> 
> - the Visual Studio way, after running `make vcxproj` in Git for Windows'
>    SDK. As part of the `vcxproj` target, the non-C parts of Git are
>    generated and committed.
> 
> - the "new" Visual Studio way, after running CMake. The non-C parts are
>    generated through CMake, which is nice because no Git for Windows SDK is
>    required to build this from start to finish.
> 
> - the Visual C way, as championed by Jeff (and which was a prerequisite to
>    working on the `vcxproj` target): in a Git for Windows SDK, use GNU make
>    but replace GCC by MSVC (via the command-line): `make MSVC=1`.


On Windows, I always use either "make" or "make MSVC=1" from a SDK
shell window to build and test.  This lets me debug in either GDB or
Visual Studio directly against the EXE.  (That is, without any of the
project complications in the debugger or the artificial commits created
for the .vcxproj files.)  MSVC builds are built from source all the way 
down (including third-party libraries) thanks to vcpkg.

However, I never install my "make MSVC=1" builds, so I don't care about
the PDBs being redistributed.  As @dscho said, we added that thinking
that we would be able to do MSVC-based releases one day, but that ship
sank.

There were some very-early GVFS users who we (personally) gave MSVC-
based builds to help get stack traces via internal Watson channels,
but that is unnecessary now.

Jeff


> 
> While all four methods work, the only one that is regularly used with the
> `make install` command is the first one.
> 
> The location you modified is in the `MSVC` part of `compat.mak.uname`,
> i.e. in the Visual C part.
> 
> We originally had a tentative plan to eventually, maybe, build Git for
> Windows using Visual C by default. However, it turned out that the
> standard malloc in Visual C's runtime was tuned for other workloads than
> Gits, and that nedmalloc performed better, and we originally could not get
> nedmalloc to compile with a modern Visual C, so we stopped that effort.
> 
> That's why you still have support for `make MSVC=1 install`.
> 
> Since it seems not to be too much trouble, I would prefer to keep it
> working for now, even if it is rarely exercised and regressions might
> creep in (like the ones you fixed).
> 
> Thanks,
> Dscho
> 
