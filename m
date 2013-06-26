From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [RFC/PATCH 0/1] cygwin: Remove the Win32 l/stat() functions
Date: Wed, 26 Jun 2013 22:45:48 +0100
Message-ID: <51CB610C.7050501@ramsay1.demon.co.uk>
References: <51C5FD28.1070004@ramsay1.demon.co.uk> <51C6BC4B.9030905@web.de> <51C8BF2C.2050203@ramsay1.demon.co.uk> <7vy59y4w3r.fsf@alter.siamese.dyndns.org> <51C94425.7050006@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-1?Q?Torsten_B=F6gers?= =?ISO-8859-1?Q?hausen?= 
	<tboegi@web.de>, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, mlevedahl@gmail.com,
	dpotapov@gmail.com, GIT Mailing-list <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Jun 27 00:07:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Urxsa-0007co-Tc
	for gcvg-git-2@plane.gmane.org; Thu, 27 Jun 2013 00:07:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753160Ab3FZWHu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Jun 2013 18:07:50 -0400
Received: from mdfmta010.mxout.tbr.inty.net ([91.221.168.51]:60581 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752978Ab3FZWHt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jun 2013 18:07:49 -0400
Received: from mdfmta010.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP id CD9926F8C45;
	Wed, 26 Jun 2013 23:07:48 +0100 (BST)
Received: from mdfmta010.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP id E67156F8BBE;
	Wed, 26 Jun 2013 23:07:47 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP;
	Wed, 26 Jun 2013 23:07:45 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
In-Reply-To: <51C94425.7050006@alum.mit.edu>
X-MDF-HostID: 3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229065>

Michael Haggerty wrote:
> On 06/25/2013 07:07 AM, Junio C Hamano wrote:
>> Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:
>>
>>> Michael Haggerty and Jeff King have been re-vamping the reference
>>> handling code. The failures noted above were provoked by patches
>>> in the 'mh/ref-races' branch. At the time I wrote this patch, that
>>> branch was only included in 'pu', but I notice that this topic has
>>> now progressed to 'next' (see commit 71f1a182).
>>
>> I had an impression that up to 98eeb09e (for_each_ref: load all
>> loose refs before packed refs, 2013-06-20) that is now in 'next'
>> does not agressively use the lstat timestamp of the packed-refs
>> file, and the "optional" bit 5d478f5c (refs: do not invalidate the
>> packed-refs cache unnecessarily, 2013-06-20), and the one in 'next'
>> should be safe with the cheating-lstat.  Isn't it the case?
>>
>> In any case, if removing the cheating-lstat will improve the
>> robustness without hurting performance, I am all for it.
>>
>> The less platform specific hacks, the better ;-).
> 
> The following patch in the "non-optional" commits (which has already
> been merged to next) uses stat() via the new stat_validity API:
> 
> ca9199300e get_packed_ref_cache: reload packed-refs file when it changes
> 
> This patch adds some *extra* cache invalidation that was heretofore
> missing.  If stat() is broken it could
> 
> (a) cause a false positive, resulting in some unnecessary cache
> invalidation and re-reading of packed-refs, which will hurt performance
> but not correctness; or
> 
> (b) cause a false negative, in which case the stale cache might be used
> for reading (but not writing), just as was *always* the case before this
> patch.
> 
> As far as I understand, the concern for cygwin is (a).  I will leave it
> to others to measure and/or decide whether the performance loss is too
> grave to endure until the cygwin stat() situation is fixed.
> 

Hmm, I'm not sure I understand ... However, I can confirm that the
'mh/ref-races' branch in next is broken on cygwin. (i.e. it is not
just a speed issue; it provokes fatal errors).

See reply to Junio.

ATB,
Ramsay Jones
