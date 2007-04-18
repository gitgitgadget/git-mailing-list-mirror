From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 2/2] Add keyword unexpansion support to convert.c
Date: Wed, 18 Apr 2007 00:15:02 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0704172346190.27922@iabervon.org>
References: <200704171041.46176.andyparkins@gmail.com>
 <Pine.LNX.4.64.0704170829500.5473@woody.linux-foundation.org>
 <46250175.4020300@dawes.za.net> <Pine.LNX.4.64.0704171121090.5473@woody.linux-foundation.org>
 <20070417235649.GE31488@curie-int.orbis-terrarum.net>
 <7vps62lfbw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Robin H. Johnson" <robbat2@gentoo.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	Rogan Dawes <lists@dawes.za.net>,
	Andy Parkins <andyparkins@gmail.com>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Apr 18 06:15:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1He1Zt-0005Vu-Vt
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 06:15:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751892AbXDREPG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 00:15:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752667AbXDREPF
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 00:15:05 -0400
Received: from iabervon.org ([66.92.72.58]:2880 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751892AbXDREPE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 00:15:04 -0400
Received: (qmail 15811 invoked by uid 1000); 18 Apr 2007 04:15:02 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 18 Apr 2007 04:15:02 -0000
In-Reply-To: <7vps62lfbw.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44861>

On Tue, 17 Apr 2007, Junio C Hamano wrote:

> "Robin H. Johnson" <robbat2@gentoo.org> writes:
> 
> > As for a usage case:
> > - J.PEBKAC.User gets a a tree (from a tarball or GIT, we should gain the
> >   same output)
> > - Copies some file outside of the tree (the user is NOT smart enough,
> >   and resists all reasonable attempts at edumacation)
> > - Modifies said file outside of tree.
> > - Contacts maintainer with entire changed file.
> > - User vanishes off the internet.
> >
> > The entire file he sent if it's CVS, contains a $Header$ that uniquely
> > identifies the file (path and revision), and the maintainer can simply
> > drop the file in, and 'cvs diff -r$OLDREV $FILE'.
> > If it's git, the maintainer drops the file in, and does 'git diff
> > $OLDSHA1 $FILE'.
> 
> I personally hope that the maintainer drops such a non-patch
> that originates from a PEBKAC.  At least I hope the tools that I
> personally use are not maintained by such a maintainer ;-)

As a concrete example, say I'm not a Gentoo developer at all, but I'm 
trying to get some package to install in a slightly odd situation. (E.g., 
I want to build a version of gcc for ARM microcontrollers, which requires 
flags to be set that aren't normally available for the ARM architecture.) 
In order to do this, I need to make some changes to the gcc ebuild to pass 
those USE flags through to configure. Since I'm not a Gentoo developer, I 
don't have the version-controlled tree, just: (1) the tree that gets 
reverted to the official state every time I sync and (2) my tree of local 
overlays. (2) also contains other packages I've made modifications to 
(adding patches to packages where those patches are only in unreleased 
version, but solve my problems, e.g.), so it's clearly the place to put 
the gcc change.

Now, if I figure out how to get the ebuild working, I'll be happy just to 
have a working compiler for this weird target, and I don't care too much 
further. But then if word gets out that I managed this, or if I notice a 
bug report that other people are failing to get it to build, I may want to 
post my working ebuild. And maybe the maintainer decides that my method 
was good, and wants to use it. But then it could be a lot of work to 
figure out what differences are from me beating on this ebuild, what are 
important, and what are reverts of changes make upstream after I made my 
copy (particularly because the same ebuild for gcc also gets a lot more 
development making it better as the system native compiler).

If the ebuild has the blob ID that the file had when it left Gentoo 
version control and went out into local hack land, it would be relatively 
easy to figure out what patch should be applies to get the useful changes.

(In case you're wondering, I actually eventually gave up and installed a 
gnu-arm binary distribution, because I was in a hurry to get the project 
going, and building from source kept failing to get configured properly; 
but if my first line of attack had worked, I would have ended up with the 
described hacked ebuild.)

	-Daniel
*This .sig left intentionally blank*
