From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH/RFH] send-pack: fix pipeline.
Date: Fri, 29 Dec 2006 15:53:29 -0800
Message-ID: <7vlkkql0na.fsf@assigned-by-dhcp.cox.net>
References: <7v1wmjoumq.fsf@assigned-by-dhcp.cox.net>
	<7vzm96latb.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0612291307520.4473@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Andy Whitcroft <apw@shadowen.org>
X-From: git-owner@vger.kernel.org Sat Dec 30 00:53:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H0RXa-00071I-VU
	for gcvg-git@gmane.org; Sat, 30 Dec 2006 00:53:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755093AbWL2Xxc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Dec 2006 18:53:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755099AbWL2Xxc
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Dec 2006 18:53:32 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:38992 "EHLO
	fed1rmmtao05.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755093AbWL2Xxb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Dec 2006 18:53:31 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061229235330.HGGA15640.fed1rmmtao05.cox.net@fed1rmimpo01.cox.net>;
          Fri, 29 Dec 2006 18:53:30 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 4nsk1W00r1kojtg0000000; Fri, 29 Dec 2006 18:52:45 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0612291307520.4473@woody.osdl.org> (Linus
	Torvalds's message of "Fri, 29 Dec 2006 13:20:41 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35610>

Linus Torvalds <torvalds@osdl.org> writes:

> On Fri, 29 Dec 2006, Junio C Hamano wrote:
>>
>> I really need a sanity checking on this one.  I think I got the
>> botched pipeline fixed with the patch I am replying to, but I do
>> not understand the waitpid() business.  Care to enlighten me?
>
> I think it was a beginning of a half-hearted attempt to check the exit 
> status of the rev-list in case something went wrong.
>
> Which we simply don't do, so if git-rev-list ends up with some problem 
> (due to a corrupt git repo or something), it will just send a partial 
> pack.
>
> For some reason I thought we had fixed that by just generating the object 
> list internally, but I guess we don't do that. That's just stupid. We 
> should make "send-pack.c" use
>
> 	list-heads | git pack-objects --revs
>
> 	list-heads | git-rev-list --stdin | git-pack-objects
>
> because as it is now, I think send-pack is more fragile than it needs to 
> be.
>
> Or maybe I'm just confused.

Dont' worry, you are no more confused than I am ;-).

"I thought we've done the 'pack-objects --revs' for the
upload-pack side but haven't done so on the send-pack side." was
what I initially wrote, but apparently we haven't.  On the other
hand, I think upload-pack gets error termination from rev-list
right.

It seems that repack is the only thing that uses the internal
rev-list.
