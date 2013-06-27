From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [RFC/PATCH 0/1] cygwin: Remove the Win32 l/stat() functions
Date: Fri, 28 Jun 2013 00:09:55 +0100
Message-ID: <51CCC643.1050702@ramsay1.demon.co.uk>
References: <51C5FD28.1070004@ramsay1.demon.co.uk> <51C6BC4B.9030905@web.de> <51C8BF2C.2050203@ramsay1.demon.co.uk> <7vy59y4w3r.fsf@alter.siamese.dyndns.org> <51C94425.7050006@alum.mit.edu> <51CB610C.7050501@ramsay1.demon.co.uk> <20130626223552.GA12785@sigill.intra.peff.net> <51CBD2FD.5070905@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	Johannes Sixt <j6t@kdbg.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, mlevedahl@gmail.com,
	dpotapov@gmail.com, GIT Mailing-list <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Jun 28 01:21:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsLVg-0003Ow-9l
	for gcvg-git-2@plane.gmane.org; Fri, 28 Jun 2013 01:21:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754008Ab3F0XVt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Jun 2013 19:21:49 -0400
Received: from mdfmta004.mxout.tbr.inty.net ([91.221.168.45]:51639 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753707Ab3F0XVs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jun 2013 19:21:48 -0400
Received: from mdfmta004.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta004.tbr.inty.net (Postfix) with ESMTP id 683B4A0C083;
	Fri, 28 Jun 2013 00:21:47 +0100 (BST)
Received: from mdfmta004.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta004.tbr.inty.net (Postfix) with ESMTP id 8B62EA0C07F;
	Fri, 28 Jun 2013 00:21:46 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])
	by mdfmta004.tbr.inty.net (Postfix) with ESMTP;
	Fri, 28 Jun 2013 00:21:44 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
In-Reply-To: <51CBD2FD.5070905@alum.mit.edu>
X-MDF-HostID: 9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229167>

Michael Haggerty wrote:
> On 06/27/2013 12:35 AM, Jeff King wrote:
[ ... ]
>> I think Michael's assessment above is missing one thing.
> 
> Peff is absolutely right; for some unknown reason I was thinking of the
> consistency check as having been already fixed.

Well, the "cygwin: Remove the Win32 l/stat() functions" patch *does* fix
the problem. :-D It's just a pity we can't use it on performance grounds. :(

>> [...#ifdef out consistency check on cygwin when lock is held...]
> 
> Yes, this would work.
> 
> But, taking a step back, I think it is a bad idea to have an unreliable
> stat() masquerading as a real stat().  If we want to allow the use of an
> unreliable stat for certain purposes, let's have two stat() interfaces:
> 
> * the true stat() (in this case I guess cygwin's slow-but-correct
> implementation)
> 
> * some fast_but_maybe_unreliable_stat(), which would map to stat() on
> most platforms but might map to the Windows stat() on cygwin when so
> configured.
> 
> By default the true stat() would always be used.  It should have to be a
> conscious decision, taken only in specific, vetted scenarios, to use the
> unreliable stat.

You have just described my second patch! :D

> 
> For example, I can't imagine that checking the freshness of the index or
> of the packed-refs file is ever going to be a bottleneck, so there is no
> reason at all to use an unreliable stat() here.
> 
> On the other hand, stat() seems definitely to be a bottleneck when
> testing for changes in a 100,000 file working tree, and here occasional
> mistakes might be considered acceptable.  So for this purpose the
> unreliable stat() might be used.

I have already written the first pass at this patch, but I'm having
difficulty with naming (get_cached_stat_data, get_index_stat_data,
get_stat_data, ... ;-)

ATB,
Ramsay Jones
