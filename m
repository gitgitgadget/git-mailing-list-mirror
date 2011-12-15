From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 28/51] refs.c: rename ref_array -> ref_dir
Date: Thu, 15 Dec 2011 09:19:08 +0100
Message-ID: <4EE9AD7C.2050605@alum.mit.edu>
References: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu> <1323668338-1764-29-git-send-email-mhagger@alum.mit.edu> <7v7h21xps9.fsf@alter.siamese.dyndns.org> <4EE6E61F.8080405@alum.mit.edu> <7vk461vuy9.fsf@alter.siamese.dyndns.org> <4EE7A387.3070400@alum.mit.edu> <4EE7CDF2.3040408@alum.mit.edu> <7vzkewt5qu.fsf@alter.siamese.dyndns.org> <7vborct37c.fsf@alter.siamese.dyndns.org> <20111214023320.GA22141@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Drew Northup <drew.northup@maine.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 15 09:19:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rb6XO-0007xY-Pn
	for gcvg-git-2@lo.gmane.org; Thu, 15 Dec 2011 09:19:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757321Ab1LOITb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Dec 2011 03:19:31 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:43577 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752550Ab1LOIT3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2011 03:19:29 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.134] (p54BEA4CB.dip.t-dialin.net [84.190.164.203])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id pBF8J8nG026952
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 15 Dec 2011 09:19:09 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.23) Gecko/20110921 Lightning/1.0b2 Thunderbird/3.1.15
In-Reply-To: <20111214023320.GA22141@sigill.intra.peff.net>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187197>

On 12/14/2011 03:33 AM, Jeff King wrote:
> On Tue, Dec 13, 2011 at 04:19:19PM -0800, Junio C Hamano wrote:
>> Actually, I do not think it even needs to be the "extra *REF* API". The
>> only thing that matters is that these commits are considered to be extra
>> anchor point in the history, in addition to the usual rule of considering
>> that everything reachable from our refs is complete. The data structure to
>> hold them does not even have to be a "struct ref". Just an array of object
>> names (or "struct object *") should suffice.
> 
> Since my cff38a5 (receive-pack: eliminate duplicate .have refs,
> 2011-05-19), receive-pack simply has a packed array of binary sha1s (in
> a "struct sha1_array" object). That might be the simplest thing.

It was pretty easy to eliminate the use of extra_refs from receive-pack.
 I'll submit the patches as soon as I can.  The patches will be based
off of patch 16/51 of the ref-api-D series, since Junio indicated that
he wants to queue up those commits (let me know if you have a different
preference).

Now I'm looking at the uses of extra_refs in git-clone.  One thing it
does is add some extra refs then write them to the packed-refs file.  I
still have to dig into it, but this seems strange.  If the refs are
being written to packed-refs, it seems like they must be real (not
extra) refs, or perhaps are just about to become real refs as part of
the clone.  Or is something more egregious is going on?

Moving the pack_refs() function to refs.c was on the agenda anyway, so
it should be possible to sort this out at the same time.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
