From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: A note on merging conflicts..
Date: Sun, 2 Jul 2006 17:42:03 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0607021715370.9789@iabervon.org>
References: <Pine.LNX.4.64.0606301927260.12404@g5.osdl.org>
 <7vy7vedntn.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0606302046230.12404@g5.osdl.org>
 <20060701150926.GA25800@lsrfire.ath.cx> <20060701180125.GA27550@fieldses.org>
 <Pine.LNX.4.64.0607011115500.12404@g5.osdl.org> <Pine.LNX.4.64.0607011754370.9789@iabervon.org>
 <Pine.LNX.4.64.0607011552170.12404@g5.osdl.org> <Pine.LNX.4.64.0607011905030.9789@iabervon.org>
 <Pine.LNX.4.64.0607011937190.9789@iabervon.org> <20060702113133.GA11529@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 02 23:41:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fx9hL-00022m-5u
	for gcvg-git@gmane.org; Sun, 02 Jul 2006 23:41:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750984AbWGBVlo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Jul 2006 17:41:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750988AbWGBVlo
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Jul 2006 17:41:44 -0400
Received: from iabervon.org ([66.92.72.58]:52746 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1750984AbWGBVlo (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Jul 2006 17:41:44 -0400
Received: (qmail 1298 invoked by uid 1000); 2 Jul 2006 17:42:03 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 2 Jul 2006 17:42:03 -0400
To: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
In-Reply-To: <20060702113133.GA11529@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23125>

On Sun, 2 Jul 2006, Rene Scharfe wrote:

> On Sat, Jul 01, 2006 at 07:45:33PM -0400, Daniel Barkalow wrote:
> > That is: (this only has the logic portion, and it's against master, so it 
> > isn't actually a really working patch or anything; also, it doesn't handle 
> > "--not a...b" correctly, whatever that should mean)
> 
> [concept patch snipped]
> 
> You mean something like the patch below?  It seems to work, but in my
> unscientific tests it's significant slower than the version based on
> get_merge_bases() (0.17s vs 0.05s for
> "git-rev-list 89719209...262a6ef7 66ae0c77...ced9456a").  Did I do
> something wrong?
> 
> You had no mark_parents_left_right() in your patch.  I added it because
> otherwise it wouldn't remove any common commits.  Was this supposed to
> work some other way?

I'd been assuming that there was something that would propagate flags to 
parents in general in add_parents_to_list(). Of course, that doesn't make 
sense for arbitrary flags. It might be better to handle it there, and 
avoid traversing parent lists twice.

I'm surprised that it isn't faster than using get_merge_bases(); I'd 
expect it to be faster than the call to get_merge_bases(), let alone 
get_merge_bases() plus the processing of output candidates. It should be 
doing less work that get_merge_bases() ultimately does (since 
get_merge_bases() has to do the boundary calculation after doing 
practically everything that the left and right addition to revision.c 
does), so there's clearly something strange going on.

	-Daniel
*This .sig left intentionally blank*
