From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Teach 'git apply' to look at $GIT_DIR/config
Date: Wed, 21 Feb 2007 00:39:16 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0702210014140.6485@iabervon.org>
References: <7vlkiwsepm.fsf@assigned-by-dhcp.cox.net> <7v8xewsd2j.fsf@assigned-by-dhcp.cox.net>
 <20070217232603.GB30839@coredump.intra.peff.net> <7vmz3cqs3d.fsf@assigned-by-dhcp.cox.net>
 <20070217233203.GA6014@coredump.intra.peff.net>
 <Pine.LNX.4.64.0702191450580.20368@woody.linux-foundation.org>
 <7vodnp68p8.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702191527320.20368@woody.linux-foundation.org>
 <7vwt2d4s6c.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702191601300.20368@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Feb 21 06:39:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJkCN-0006RK-4p
	for gcvg-git@gmane.org; Wed, 21 Feb 2007 06:39:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030188AbXBUFjS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Feb 2007 00:39:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030228AbXBUFjS
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Feb 2007 00:39:18 -0500
Received: from iabervon.org ([66.92.72.58]:2298 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030188AbXBUFjR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Feb 2007 00:39:17 -0500
Received: (qmail 1469 invoked by uid 1000); 21 Feb 2007 00:39:16 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 21 Feb 2007 00:39:16 -0500
In-Reply-To: <Pine.LNX.4.64.0702191601300.20368@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40279>

On Mon, 19 Feb 2007, Linus Torvalds wrote:

> Imagine somebody sending you a patch to a set of files, and they didn't 
> use git to generate that patch. What would it look right? Right, it might 
> well look like
> 
> 	diff -u file.c.orig file.c
> 	--- file.c.orig
> 	+++ file.c
> 	@@ -29,6 +29,7 @@
> 	...
> 
> and it happens to be in some subdirectory. What would you do?
> 
> I'd use "git apply". And I would be really upset *if* git-apply actually 
> applied the patch to some *other* subdirectory than the one I was in.

"git apply" should be able to notice the many clues that this patch 
doesn't go at the root: (1) it's not -r; (2) it's not a rename, but the 
filenames aren't the same; (3) there isn't an extra path element to 
remove.

Wouldn't the patch author have to do something like 
"cd drivers; diff -ur usb.orig usb > patch" (i.e., have old and new 
_directories_ in the _same_ source tree, rather than just files, or 
separate source trees) in order to generate a patch that would be confusing?

I think "git apply" should just know that if the filenames don't match, 
and it's not a rename, and the --- filename isn't /dev/null, then add the 
current directory and use -p0.

	-Daniel
*This .sig left intentionally blank*
