From: Junio C Hamano <junkio@cox.net>
Subject: Re: [Census] So who uses git?
Date: Tue, 31 Jan 2006 15:47:28 -0800
Message-ID: <7vek2oot7z.fsf@assigned-by-dhcp.cox.net>
References: <46a038f90601251810m1086d353ne8c7147edee4962a@mail.gmail.com>
	<Pine.LNX.4.64.0601272345540.2909@evo.osdl.org>
	<46a038f90601272133o53438987ka6b97c21d0cdf921@mail.gmail.com>
	<1138446030.9919.112.camel@evo.keithp.com>
	<7vzmlgt5zt.fsf@assigned-by-dhcp.cox.net>
	<20060130185822.GA24487@hpsvcnb.fc.hp.com>
	<Pine.LNX.4.63.0601311127250.25248@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0601311750270.25300@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Carl Baldwin <cnb@fc.hp.com>,
	Keith Packard <keithp@keithp.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 01 00:47:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F45Dh-00015l-TB
	for gcvg-git@gmane.org; Wed, 01 Feb 2006 00:47:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751069AbWAaXrb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jan 2006 18:47:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751084AbWAaXrb
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jan 2006 18:47:31 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:36514 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751069AbWAaXrb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jan 2006 18:47:31 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060131234627.YFAD15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 31 Jan 2006 18:46:27 -0500
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.64.0601311750270.25300@iabervon.org> (Daniel
	Barkalow's message of "Tue, 31 Jan 2006 18:16:26 -0500 (EST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15367>

Daniel Barkalow <barkalow@iabervon.org> writes:

> I sort of suspect that "git commit some_other_file" should really read 
> HEAD into a temporary index, update "some_other_file" in that (and the 
> main index), and commit it.
> ...
> The surprising thing is that "git commit path ..." means
> "everything I've already mentioned, plus path..." not just
> "path ...", and it's particularly surprising because people
> only tend to specify paths when they've done something they
> don't want to commit.

Interesting idea, and a good point.

Not that I particularly would like to encourage people to make
partial commits by making it easier, but as long as we allow our
users to say "commit path...", your proposal would reduce the
confusion.

I wonder which is faster, to check if index differs from HEAD
and do the temporary index only when they differ, or always use
a temporary without checking?  The former needs one diff-index
--cached, zero or one read-tree, one write-tree and one
commit-tree.  The latter always needs one read-tree, one
write-tree and one commit-tree.

Wait.  We already do diff-index --cached during git-commit
anyway (it is in git-status).  Maybe with a bit of code
restructuring we can do the temporary index part optional.
