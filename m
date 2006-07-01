From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: A note on merging conflicts..
Date: Sat, 1 Jul 2006 18:24:12 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0607011754370.9789@iabervon.org>
References: <Pine.LNX.4.64.0606301927260.12404@g5.osdl.org>
 <7vy7vedntn.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0606302046230.12404@g5.osdl.org>
 <20060701150926.GA25800@lsrfire.ath.cx> <20060701180125.GA27550@fieldses.org>
 <Pine.LNX.4.64.0607011115500.12404@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
	Rene Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 02 00:24:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fwnsl-0000wD-6U
	for gcvg-git@gmane.org; Sun, 02 Jul 2006 00:24:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbWGAWYA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Jul 2006 18:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751129AbWGAWX7
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Jul 2006 18:23:59 -0400
Received: from iabervon.org ([66.92.72.58]:46354 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1751126AbWGAWXz (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Jul 2006 18:23:55 -0400
Received: (qmail 22181 invoked by uid 1000); 1 Jul 2006 18:24:12 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 1 Jul 2006 18:24:12 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607011115500.12404@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23068>

On Sat, 1 Jul 2006, Linus Torvalds wrote:

> That said, it does have a real downside, and that's simply that it can 
> take a long time to compute.

I think a...b can be computed by (in pseudocode, obviously):

 mark(a, 1);
 add(list, a);
 mark(b, 2);
 add(list, b);
 while (interesting(list)) {
   if (*list->marks != 3)
     output(*list);
   for (parent : *list->parents) {
     mark(parent, *list->marks);
     add(list, parent);
   }
 }

It's basically the original merge-bases code, from way back; the several 
flaws with it for computing a good merge base don't matter if you're just 
excluding the merge bases. If you look at the big examples in merge-base.c 
(pre-libification), it's obvious that what we want for a...b is everything 
marked 1 or 2, and the trickiness in that code is getting things correctly 
marked 3 versus 7, which doesn't matter here.

	-Daniel
*This .sig left intentionally blank*
