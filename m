From: Junio C Hamano <junkio@cox.net>
Subject: Re: [wishlist] git branch -d -r remotename
Date: Sun, 18 Mar 2007 12:42:30 -0700
Message-ID: <7vvegyl4nt.fsf@assigned-by-dhcp.cox.net>
References: <45FD0804.6010401@vilain.net>
	<20070318110507.5701413A382@magnus.utsl.gen.nz>
	<20070318113210.5843E13A382@magnus.utsl.gen.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Sun Mar 18 20:42:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HT1Gz-000528-Vu
	for gcvg-git@gmane.org; Sun, 18 Mar 2007 20:42:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933020AbXCRTmc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Mar 2007 15:42:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933026AbXCRTmc
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 15:42:32 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:40046 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933020AbXCRTmb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2007 15:42:31 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070318194232.ECHA2807.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Sun, 18 Mar 2007 15:42:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id cKiW1W00e1kojtg0000000; Sun, 18 Mar 2007 15:42:31 -0400
In-Reply-To: <20070318113210.5843E13A382@magnus.utsl.gen.nz> (Sam Vilain's
	message of "Sun, 18 Mar 2007 23:01:33 +1200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42511>

Sam Vilain <sam@vilain.net> writes:

> One time again, this time with the call to porcelain command
> `git-branch` replaced with the plumbing command `symbolic-ref HEAD`
>
> I also changed the output to be a little less "Got here\n" style.
>
> Subject: [PATCH] git-remote: implement prune -c
>
> It would be nice to prune local refs which are irrelevant; add an
> option to git-remote prune, with documentation.

I do not understand what workflow you are assuming, so your use
of the word "irrelevant" does not mean much to me.  I suspect
other readers of the patch and documentation wouldn't find it
clear in what situation this option is useful.

Perhaps you are thinking about this scenario?  I am only
guessing because you are not clear enough:

	$ git clone
        ... time passes ...
        $ git checkout -b next origin/next
        ... build, install, have fun ...
	$ git checkout master
        ... time passes ...
        $ git branch
        ... notice that you do not hack on your copy of 'next'
        ... and want to remove it
	$ git remote prune -c

In any case, are you checking irrelevancy?  What if your foo branch has
more changes to be sent upstream?  Even when the remote has a
bit older version doesn't your code remove yours?  For example,
if you did this, instead of the above, what happens?

	$ git clone
        ... time passes ...
        $ git checkout -b next origin/next
        ... build, install, have fun ...
	... find an opportunity to improve ...
        $ edit
        $ git commit ;# on your 'next'.
        ... build, install, test ...
	$ git checkout master
        ... time passes ...
        $ git branch
        ... notice that you do not hack on your copy of 'next' anymore,
        ... and want to remove it
	$ git remote prune -c

If the above is the usage scenario you are trying to help, then
wouldn't it be helpful if you could also help removing 'my-next'
in this slightly altered example?

	$ git clone
        ... time passes ...
        $ git checkout -b my-next origin/next
        ... build, install, have fun ...
	$ git checkout master
        ... time passes ...
        $ git branch
        ... notice that you do not hack on your copy of 'next'
        ... which is 'my-next', and want to remove it
	$ git remote prune -c
