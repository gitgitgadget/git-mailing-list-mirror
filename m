X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] index-pack usage of mmap() is unacceptably slower on many OSes other than Linux
Date: Wed, 20 Dec 2006 12:17:20 -0800
Message-ID: <7vbqlye2zz.fsf@assigned-by-dhcp.cox.net>
References: <86y7p57y05.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0612181251020.3479@woody.osdl.org>
	<86r6uw9azn.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0612181625140.18171@xanadu.home>
	<86hcvs984c.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0612181414200.3479@woody.osdl.org>
	<8664c896xv.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0612181511260.3479@woody.osdl.org>
	<Pine.LNX.4.64.0612181906450.18171@xanadu.home>
	<20061219051108.GA29405@thunk.org>
	<Pine.LNX.4.64.0612182234260.3479@woody.osdl.org>
	<Pine.LNX.4.63.0612190930460.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v1wmwtfmk.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0612191027270.18171@xanadu.home>
	<7vk60npv7x.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0612191409500.18171@xanadu.home>
	<Pine.LNX.4.64.0612191148270.3483@woody.osdl.org>
	<4588453A.3060904@garzik.org>
	<7vzm9jo1df.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0612191640010.6766@woody.osdl.org>
	<7v7iwnnzed.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 20 Dec 2006 20:17:27 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>, Nicolas Pitre <nico@cam.org>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7v7iwnnzed.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Tue, 19 Dec 2006 17:12:42 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34958>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gx7sT-0001qs-JH for gcvg-git@gmane.org; Wed, 20 Dec
 2006 21:17:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030349AbWLTURX (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 20 Dec 2006
 15:17:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030351AbWLTURW
 (ORCPT <rfc822;git-outgoing>); Wed, 20 Dec 2006 15:17:22 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:58930 "EHLO
 fed1rmmtao03.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1030349AbWLTURW (ORCPT <rfc822;git@vger.kernel.org>); Wed, 20 Dec 2006
 15:17:22 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao03.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061220201721.YCUW29122.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>; Wed, 20
 Dec 2006 15:17:21 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id 18Gf1W00X1kojtg0000000; Wed, 20 Dec 2006
 15:16:40 -0500
To: Jeff Garzik <jeff@garzik.org>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> writes:

> Linus Torvalds <torvalds@osdl.org> writes:
>
>> On Tue, 19 Dec 2006, Junio C Hamano wrote:
>>
>>> Jeff Garzik <jeff@garzik.org> writes:
>>> 
>>> > If you are going to do this, you have to audit -every- file, to make
>>> > sure git-compat-util.h is -always- the first header.
>>> 
>>> Will do.
>>
>> Well, since any cases where it isn't (and where we'd care) will  show up 
>> as just a compiler warning, I doubt we really even need to. We can fix 
>> things up as they get reported too..
>
> True, but I've done it already, so... 
>
> Test compile especially on non Linux boxes are appreciated (I'll
> do one on an OpenBSD bochs tomorrow myself anyway, though).

I've pushed the results out, along with the index-pack updates
from Linus/Nico.

I needed to fix the changes to git-compat-util.h a bit from the
version I sent earlier to make OpenBSD happy (sys/types.h there
did not expose u_int unless _BSD_SOURCE was set, and
netinet/in.h was duplicated by mistake).
