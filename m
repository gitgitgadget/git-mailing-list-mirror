Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B684203C3
	for <e@80x24.org>; Thu, 21 Jul 2016 19:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752176AbcGUTFT (ORCPT <rfc822;e@80x24.org>);
	Thu, 21 Jul 2016 15:05:19 -0400
Received: from siwi.pair.com ([209.68.5.199]:31663 "EHLO siwi.pair.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751858AbcGUTFS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jul 2016 15:05:18 -0400
Received: from [10.160.15.137] (unknown [167.220.148.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by siwi.pair.com (Postfix) with ESMTPSA id 4C297845A1;
	Thu, 21 Jul 2016 15:05:17 -0400 (EDT)
Subject: Re: [PATCH v1 4/6] Expanded branch header for Porcelain Status V2
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>
References: <1468966258-11191-1-git-send-email-jeffhost@microsoft.com>
 <1468966258-11191-5-git-send-email-jeffhost@microsoft.com>
 <20160720160635.GC24902@sigill.intra.peff.net>
 <578FC0E8.4010102@jeffhostetler.com>
 <20160720205411.GB578@sigill.intra.peff.net>
 <alpine.DEB.2.20.1607211745050.14111@virtualbox>
Cc:	Jeff Hostetler <jeffhost@microsoft.com>, git@vger.kernel.org,
	gitster@pobox.com
From:	Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <57911C65.2050601@jeffhostetler.com>
Date:	Thu, 21 Jul 2016 15:03:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1607211745050.14111@virtualbox>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org



On 07/21/2016 11:46 AM, Johannes Schindelin wrote:
> On Wed, 20 Jul 2016, Jeff King wrote:
>
>> On Wed, Jul 20, 2016 at 02:20:24PM -0400, Jeff Hostetler wrote:
>>
>>>> IIRC, it happens when HEAD points to a broken ref. So something like:
>>>>
>>>>     git init
>>>>     echo broken >.git/refs/heads/master
>>>>
>>>> would cause resolving HEAD to return NULL.
>>>
>>> That worked and I see "(unknown)".
>>>
>>> This is a bit of a nit, but is there a value we'd like
>>> to see there, such as "(unknown)" or "(broken)" or "(missing)"
>>> in that case?  (And make it clear that this is a different
>>> case from "(detached)".)
>>>
>>> I'm thinking it would be nicer to always have a field
>>> there for parsing.
>>
>> My gut feeling is to err on the side of being vague, like "unknown".
>> This is something that _shouldn't_ ever happen, and if it does, it could
>> be a broken on-disk ref, a transient syscall error, or some other
>> weirdness. I don't think we need to get too specific in this context
>> (we'll likely have said something else useful on stderr already, I
>> think).
>
> FWIW I think "unknown" is a nice conservative way to shrug Git's
> shoulders.
>
> When we call `git status --porcelain=v2` and read "unknown", we could
> always try to find out more using additional low-level tools and/or disk
> access: this is such a rare case that it does not *really* matter all that
> much.

yes, this case causes even rev-parse fits.  I'l make it return a
known quantity so that users don't have to deal with stuff like:

$ more .git/HEAD
ref: refs/heads/foo
$ more .git/refs/heads/foo
brokwn
$ git rev-parse HEAD
HEAD
fatal: ambiguous argument 'HEAD': unknown revision or path not in the 
working tree.
Use '--' to separate paths from revisions, like this:
'git <command> [<revision>...] -- [<file>...]'
$ git rev-parse HEAD --
fatal: bad revision 'HEAD'
$


Jeff
