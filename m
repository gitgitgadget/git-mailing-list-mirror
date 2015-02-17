From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Git gc removes all packs
Date: Tue, 17 Feb 2015 21:37:41 +0100
Message-ID: <54E3A695.1050708@alum.mit.edu>
References: <CAC+L6n1M7LtGaJy94fnhXm94zJ32HXLNVGMguWSqHm=qqLLDxA@mail.gmail.com> <20150205200332.GD15326@peff.net> <54E36EBF.2070600@alum.mit.edu> <20150217165514.GA12176@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: Dmitry Neverov <dmitry.neverov@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 17 21:37:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNotx-0005Ew-91
	for gcvg-git-2@plane.gmane.org; Tue, 17 Feb 2015 21:37:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751775AbbBQUhp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2015 15:37:45 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:43264 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750807AbbBQUho (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Feb 2015 15:37:44 -0500
X-AuditID: 1207440d-f79976d000005643-f9-54e3a69777a0
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id F4.25.22083.796A3E45; Tue, 17 Feb 2015 15:37:43 -0500 (EST)
Received: from [192.168.69.130] (p5DDB008A.dip0.t-ipconnect.de [93.219.0.138])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t1HKbfK4011445
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 17 Feb 2015 15:37:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.4.0
In-Reply-To: <20150217165514.GA12176@peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEKsWRmVeSWpSXmKPExsUixO6iqDt92eMQg4brXBa95z4xW3Rd6Way
	+NHSw+zA7LFz1l12j2e9exg9Pm+SC2CO4rZJSiwpC85Mz9O3S+DOWLTkEWtBA3/F4lOzWRoY
	33N3MXJySAiYSOxbdJkRwhaTuHBvPVsXIxeHkMBlRokl23tZIJxzTBLLWxpYQap4BbQlZh9f
	ywxiswioSvz4+w2sm01AV2JRTzMTiC0qECRx6PRjFoh6QYmTM5+A2SICshLfD28EqufgYBZw
	kuh7EwMSFgYas/j6QlaIXVsYJfYeuwc2n1NAT2LiizfsIDazgLrEn3mXmCFseYnmrbOZJzAK
	zEKyYhaSsllIyhYwMq9ilEvMKc3VzU3MzClOTdYtTk7My0st0jXSy80s0UtNKd3ECAlf3h2M
	/9fJHGIU4GBU4uG1mPAoRIg1say4MvcQoyQHk5Io74w5j0OE+JLyUyozEosz4otKc1KLDzFK
	cDArifAGpQDleFMSK6tSi/JhUtIcLErivGpL1P2EBNITS1KzU1MLUotgsjIcHEoSvEVLgRoF
	i1LTUyvSMnNKENJMHJwgw7mkRIpT81JSixJLSzLiQbEaXwyMVpAUD9DemSDtvMUFiblAUYjW
	U4yKUuK8x5cAJQRAEhmleXBjYUnpFaM40JfCvL0g7TzAhAbX/QpoMBPQ4Pl/HoEMLklESEk1
	MIa/S1ZfsP7EZp5YPq0T0dbb38+YGjkjW/Gp2lRT6Z07HyQt0H8nPHNyVNmBpzMs07V1eIMj
	GXje7Hpc2tPOrhGW4W10veDw2sTn68QesC1nfRzps8speaG4T+ui0m43nlW+9mk8 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263981>

On 02/17/2015 05:55 PM, Jeff King wrote:
> On Tue, Feb 17, 2015 at 05:39:27PM +0100, Michael Haggerty wrote:
> 
>>> You can't symlink refs like this. The loose refs in the filesystem may
>>> be migrated into the "packed-refs" file, at which point your symlink
>>> will be broken. That is a likely reason why git would not find any refs.
>>>
>>> So your setup will not ever work reliably.  But IMHO, it is a bug that
>>> git does not notice the broken symlink and abort an operation which is
>>> computing reachability in order to drop objects. As you noticed, it
>>> means a misconfiguration or filesystem error results in data loss.
>>
>> There's a bunch of code in refs.c that is there explicitly for reading
>> loose references that are symlinks. If the link contents literally start
>> with "refs/", then they are read and treated as a symbolic ref.
>> Otherwise, the symlink is just followed.
> 
> Right, but we should be able to notice that:
> 
>   1. We found a symlink.
> 
>   2. We couldn't read it its ref value (because it's a broken link).
> 
> I think we _do_ notice that at the lowest level, and set REF_ISBROKEN.
> But the problem is that the reachability code in prune and in
> pack-objects (triggered by "repack -ad") uses for_each_ref, and not
> for_each_rawref. So they ignore "broken" refs rather than complaining,
> even though failing to read a ref may mean we could drop objects which
> were only mentioned by that ref.

Yes, this makes sense too. But my point was that sticking symlinks to
random files in your refs hierarchy is pretty questionable even *before*
the symlink gets broken. If we would warn the user as soon as we saw
such a thing, then the user's problem would never have advanced as far
as it did. Do you think that emitting warnings on *intact* symlinks is
too draconian?

> [...]

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
