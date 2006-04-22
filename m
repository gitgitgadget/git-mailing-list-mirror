From: Geert Bosch <bosch@adacore.com>
Subject: Re: RFC: New diff-delta.c implementation
Date: Sat, 22 Apr 2006 13:28:23 -0400
Message-ID: <EB4042E4-D74E-4346-A9CA-50E9CB33F18C@adacore.com>
References: <602974A9-09A3-46E9-92D6-D30728923C11@adacore.com> <Pine.LNX.4.64.0604212308080.2215@localhost.localdomain> <A856A2C5-2BD7-4DC5-9CCC-CD53E9A2623C@adacore.com> <7v7j5hkglq.fsf@assigned-by-dhcp.cox.net> <6794F5B2-A277-4CD9-9BA8-509F86378E68@adacore.com> <Pine.LNX.4.64.0604220846040.2215@localhost.localdomain> <81E2B4A6-3591-418D-9448-47648AF4A687@adacore.com> <7v3bg5k0ev.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 22 19:28:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FXLuJ-0000ZH-Ir
	for gcvg-git@gmane.org; Sat, 22 Apr 2006 19:28:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750819AbWDVR21 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 22 Apr 2006 13:28:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750823AbWDVR21
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Apr 2006 13:28:27 -0400
Received: from nile.gnat.com ([205.232.38.5]:13037 "EHLO nile.gnat.com")
	by vger.kernel.org with ESMTP id S1750819AbWDVR20 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 22 Apr 2006 13:28:26 -0400
Received: from localhost (localhost [127.0.0.1])
	by filtered-nile.gnat.com (Postfix) with ESMTP id EB17D48CDD2;
	Sat, 22 Apr 2006 13:28:25 -0400 (EDT)
Received: from nile.gnat.com ([127.0.0.1])
 by localhost (nile.gnat.com [127.0.0.1]) (amavisd-new, port 10024) with LMTP
 id 29021-01; Sat, 22 Apr 2006 13:28:25 -0400 (EDT)
Received: from [172.16.1.2] (sdsl-216-220-103-157.dsl.bway.net [216.220.103.157])
	by nile.gnat.com (Postfix) with ESMTP id 8E61548CBEC;
	Sat, 22 Apr 2006 13:28:25 -0400 (EDT)
In-Reply-To: <7v3bg5k0ev.fsf@assigned-by-dhcp.cox.net>
To: Junio C Hamano <junkio@cox.net>
X-Mailer: Apple Mail (2.749.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19039>


On Apr 22, 2006, at 13:03, Junio C Hamano wrote:
>> What is the exact role of the max_size parameter that
>> is passed to diff_delta? I took it to mean return 0 if
>> the size of the delta would be bigger than max_size and
>> max_size is nonzero.
>
> No, that is a _strong_ hint to tell diff_delta to quit
> early without wasting cycles if the result exceeds the
> given size, either because we already have a delta smaller
> than that, or because we expect to get an undeltified
> representation compressed down to that size.  So if
> your algorithm cannot notice early stage of the processing
> if the result would exceed that max_size, just code things
> to ignore it first.

That's about how I implemented it in my last patch.
Is it correct that 0 means that there is no max_size?
Should I set *delta_size to 0 when doing an early
return, or leave it alone?

Note that this really is a micro-optimization, since
all the expensive stuff is the indexing and then the
matching. Since my algorithm matches both forward and
backward, there is no way to know that the patch size
can't be optimized until after matching completes,
even though it will never actually create the patch
or allocate memory for it.

   -Geert
