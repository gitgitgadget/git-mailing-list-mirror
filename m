From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-index-pack really does suck..
Date: Tue, 03 Apr 2007 15:31:36 -0700
Message-ID: <7vd52lum2f.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0704030754020.6730@woody.linux-foundation.org>
	<db69205d0704031227q1009eabfhdd82aa3636f25bb6@mail.gmail.com>
	<Pine.LNX.4.64.0704031304420.6730@woody.linux-foundation.org>
	<alpine.LFD.0.98.0704031625050.28181@xanadu.home>
	<Pine.LNX.4.64.0704031346250.6730@woody.linux-foundation.org>
	<20070403210319.GH27706@spearce.org>
	<Pine.LNX.4.64.0704031411320.6730@woody.linux-foundation.org>
	<20070403211709.GJ27706@spearce.org>
	<Pine.LNX.4.64.0704031425220.6730@woody.linux-foundation.org>
	<Pine.LNX.4.64.0704031427050.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Nicolas Pitre <nico@cam.org>, Chris Lee <clee@kde.org>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Apr 04 00:31:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYrXa-0004mq-J0
	for gcvg-git@gmane.org; Wed, 04 Apr 2007 00:31:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161107AbXDCWbj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Apr 2007 18:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161108AbXDCWbj
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Apr 2007 18:31:39 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:59810 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161107AbXDCWbi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2007 18:31:38 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070403223138.HCPU28911.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Tue, 3 Apr 2007 18:31:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id imXc1W0111kojtg0000000; Tue, 03 Apr 2007 18:31:37 -0400
In-Reply-To: <Pine.LNX.4.64.0704031427050.6730@woody.linux-foundation.org>
	(Linus Torvalds's message of "Tue, 3 Apr 2007 14:28:22 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43682>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Side note: with "alternates" files, you might well *always* have the 
> objects. If you do
>
> 	git clone -l -s ...
>
> to create various branches, and then pull between them, you'll actually 
> end up in the situation that you'll always find the objects and get back 
> to the really expensive case..

Ah, that's true.  If you "git clone -l -s A B", create new
objects in A and pull from B, the transfer would not exclude
new objects as they are not visible from B's refs.

In that scenario, the keep-pack behaviour is already worse than
the unpack-objects behaviour.  The former creates a packfile
that duplicates objects that are in A while the latter, although
expensive, ends up doing nothing.

I wonder if we can have a backdoor to avoid any object transfer
in such a case to begin with...
