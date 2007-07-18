From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Wrong time in git-log when using right/ timezone
Date: Wed, 18 Jul 2007 13:57:13 -0700
Message-ID: <7vk5sx77me.fsf@assigned-by-dhcp.cox.net>
References: <20070718153614.GA28815@hartlich.com>
	<alpine.LFD.0.999.0707180948080.27353@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Hartlich <wwsgj@hartlich.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jul 18 22:57:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBGaF-00033H-LL
	for gcvg-git@gmane.org; Wed, 18 Jul 2007 22:57:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757925AbXGRU5P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jul 2007 16:57:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755016AbXGRU5P
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 16:57:15 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:52977 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756086AbXGRU5O (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2007 16:57:14 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070718205714.ZSIP1349.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Wed, 18 Jul 2007 16:57:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id R8xD1X00F1kojtg0000000; Wed, 18 Jul 2007 16:57:13 -0400
In-Reply-To: <alpine.LFD.0.999.0707180948080.27353@woody.linux-foundation.org>
	(Linus Torvalds's message of "Wed, 18 Jul 2007 10:01:31 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52898>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Wow. I just tried:
>
> 	git show --raw --date=local
>
> with TZ=CET and TZ=right/Europe/Berlin respectively.
> ...
> ie apparently Berlin is in a timezone of its own that is roughly one 
> minute and 23 seconds away from CET.
>
> What the *heck*?
>
> I really don't think this is git that is confused: I get the exact same 
> thing with "date" too:
>
> 	[torvalds@woody git]$ TZ=right/Europe/Berlin date ; TZ=CET date
> 	Wed Jul 18 18:52:25 CEST 2007
> 	Wed Jul 18 18:52:48 CEST 2007
>
> so it really *is* the tzdata that says that Berlin is not +0200, and it's 
> not even +0159, it's something really strange with fractional minutes away 
> from UTC.
>
> What can I say? "Those wacky Germans - they have a wonderful sense of 
> humor"?

No, I do not think the wackiness is from Germans.

Using right/ perhaps without realizing the differences between
TZ=right/Europe/Berlin and TZ=Europe/Berlin is probably the
source of confusion.

I do not offhand know what role "leap second adjustment" should
play in the context of converting from Unix time we store in git
commit objects to human readable role.  As far as I understand,
the returned timestamp from time(2), which we record in commit
objects, is already "leap second adjusted".
