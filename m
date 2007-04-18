From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/2] Custom low-level merge driver support.
Date: Wed, 18 Apr 2007 12:00:08 -0700
Message-ID: <7vzm55fqyv.fsf@assigned-by-dhcp.cox.net>
References: <11768880622402-git-send-email-junkio@cox.net>
	<Pine.LNX.4.64.0704181247410.12094@racer.site>
	<20070418153445.GC12888@admingilde.org>
	<alpine.LFD.0.98.0704180910120.2828@woody.linux-foundation.org>
	<7vslaxhamd.fsf@assigned-by-dhcp.cox.net>
	<alpine.LFD.0.98.0704181136360.2828@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Waitz <tali@admingilde.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Apr 18 21:00:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeFO3-0000dz-L6
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 21:00:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993034AbXDRTAL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 15:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993035AbXDRTAL
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 15:00:11 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:63867 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993034AbXDRTAJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 15:00:09 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070418190007.IIFD1257.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Wed, 18 Apr 2007 15:00:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id oj081W00X1kojtg0000000; Wed, 18 Apr 2007 15:00:09 -0400
In-Reply-To: <alpine.LFD.0.98.0704181136360.2828@woody.linux-foundation.org>
	(Linus Torvalds's message of "Wed, 18 Apr 2007 11:45:56 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44931>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Wed, 18 Apr 2007, Junio C Hamano wrote:
>> 
>> While I agree with all of the above, I am currently fighting
>> with a back-to-drawing-board design problem.
>> 
>> The series made the low-level 3-way merge machinery
>> customizable, which is a progress, but I think merge-recursive
>> needs a hook to affect middle-level merge decision, similar to
>> what git-merge-one-file does.
>
> Hmm. I think that it's not so much a "hook", as a "recursive merge is a 
> separate merge policy altogether, that just *defaults* to the same final 
> merge policy".

I suspect I did not state my problem clearly.

> For example, for a three-way merge, it makes sense to do the three-way 
> merge for the "internal" merge too. But it might be that that isn't true 
> for all strategies.

Yes, that is what I alluded to in one of my previous message,
but I think the "foo-recursive" idea is a good one.  I was
planning to give only "3-way" or "pick ancestor" choice to
external low-level merge drivers.

But I think that is a separate issue.

The logic I said I wanted to override in the message you are
responding to is the big toplevel if () else if () ... chain in
process_entry(), and the nested if () else if () ... logic in
merge_file().  They roughly implement what git-merge-one-file
does.

Currently low-level 3-way merge drivers are invoked only in some
cases, exactly where git-merge-one-file used to invoke "RCS
merge".  The specific case of RelNotes symlink I wanted to
override is one of the cases that ll_merge() is not even
invoked.
