Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF3EC04A68
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 05:42:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbiG1Fmj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 01:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiG1Fmh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 01:42:37 -0400
Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F457564F4
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 22:42:34 -0700 (PDT)
Received: from bsmtp2.bon.at (unknown [192.168.181.106])
        by bsmtp5.bon.at (Postfix) with ESMTPS id 4LtfgD5HL1z5wN3
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 07:42:32 +0200 (CEST)
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 4Ltfg945Pbz5tlF;
        Thu, 28 Jul 2022 07:42:28 +0200 (CEST)
Message-ID: <4b09bf98-dae2-491e-9858-801a9bcdd2fa@kdbg.org>
Date:   Thu, 28 Jul 2022 07:42:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: Feature request: better error messages when UTF-8 bites
Content-Language: en-US
To:     CH <ch-and-git.vger.kernel.org@ch.pkts.ca>
References: <f5a49da29fd0e5577083f1006d394158@ch.pkts.ca>
From:   Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org
In-Reply-To: <f5a49da29fd0e5577083f1006d394158@ch.pkts.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 27.07.22 um 22:21 schrieb CH:
> Somehow when copying and pasting a commit from a website to the command
> line, a UTF-8 Byte Order Mark (BOM)
> [https://en.wikipedia.org/wiki/Byte_order_mark] was appended to one of
> the commit ids.  BOMs are invisible, as are many other UTF-8 code
> points.  The upshot was that Git didn't like it, and complained bitterly:
> 
>> $ strace -etrace=execve -s 200 git diff
>> 038179704f0066aa815d5429221cf381ff4ef289 
>> 47346a462d8ba40b9a8b073e351c362522c46aa6
>>
>> execve("/usr/bin/git", ["git", "diff",
>> "038179704f0066aa815d5429221cf381ff4ef289\357\273\277",
>> "47346a462d8ba40b9a8b073e351c362522c46aa6"], 0x7fffec3c4bb0 /* 80 vars
>> */) = 0
>>
>> fatal: ambiguous argument '038179704f0066aa815d5429221cf381ff4ef289':
>> unknown revision or path not in the working tree.
>> Use '--' to separate paths from revisions, like this:
>> 'git <command> [<revision>...] -- [<file>...]'
>> +++ exited with 128 +++
> 
> Feature request:
> ================
> 
> When printing the "fatal: ambiguous argument '......': ....", perhaps
> escape (url or otherwise) the ambiguous argument when printing it in the
> error message, or maybe add a sentence about non-ASCII characters being
> found.

That's not going to fly, IMHO, because when I type

   git diff todo/René

I would not want to see

fatal: ambiguous argument 'todo/Ren\303\251': unknown ...

I'm convinced that there are thousands of users who use non-ASCII branch
and file names that they also frequently mis-type. They'd all be greeted
with unintelligible nerdy gibberish.

I may be able to change my mind if ambiguous input (in the sense of "is
not what it seems to be") leads to a security hazard that is unique to Git.

-- Hannes
