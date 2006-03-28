From: Paul Mackerras <paulus@samba.org>
Subject: Re: Gitk strangeness..
Date: Tue, 28 Mar 2006 13:31:09 +1100
Message-ID: <17448.40941.256361.866229@cargo.ozlabs.ibm.com>
References: <7v64lzo1j7.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0603271802030.15714@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 28 04:31:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FO3zU-00041h-Gh
	for gcvg-git@gmane.org; Tue, 28 Mar 2006 04:31:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750903AbWC1Cb0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Mar 2006 21:31:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751145AbWC1Cb0
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Mar 2006 21:31:26 -0500
Received: from ozlabs.org ([203.10.76.45]:65250 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750903AbWC1CbZ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Mar 2006 21:31:25 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 8EB8A67A39; Tue, 28 Mar 2006 13:31:24 +1100 (EST)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603271802030.15714@g5.osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18103>

Linus Torvalds writes:

> Paul, do this on the current git tree:
> 
> 	gitk b0a3de42..dff86e28
> 
> and tell me it doesn't look horrid.

Wow!  That's spectacular! :)

> Maybe it's not a new thing, and it's just that the recent pattern of 
> merges in the git tree makes any version of gitk do horrible things.

A large part of it is that I took out the stuff where gitk used to
reorder the commits it got from git-rev-list.  One of the side-effects
of doing the reordering was that for commits which aren't listed in
the git-rev-list output (i.e. which are drawn with open circles), gitk
was able to draw them immediately after their last child.  Now gitk
doesn't discover that they aren't listed until it has drawn all the
commits that are listed, which means we can get a whole pile of
open-circle commits at the bottom of the graph.

I think the best thing to do is to change git-rev-list.  One
possibility would be to add an option to make git-rev-list omit
parents that are not in the requested set, which would mean that gitk
would not draw the open-circle commits any more.

The other option would be to make git-rev-list list the open-circle
commits explicitly, with an indication that they are not in the
requested set but are parents of commits in the requested set.

Or I can put the logic back into gitk.  I'd rather do it in
git-rev-list though since it will be faster that way.

Do you think that having the open-circle commits in the graph is
useful?

Paul.
