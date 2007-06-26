From: Sam Vilain <sam@vilain.net>
Subject: Re: git for subversion users
Date: Tue, 26 Jun 2007 16:33:55 +1200
Message-ID: <46809733.2060200@vilain.net>
References: <e2a1d0aa0706251248j1b8da150xbe19826bec15eed6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Patrick Doyle <wpdster@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 26 06:34:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I32kk-0001OD-Mm
	for gcvg-git@gmane.org; Tue, 26 Jun 2007 06:34:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751684AbXFZEeH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Jun 2007 00:34:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751771AbXFZEeG
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jun 2007 00:34:06 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:54523 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751250AbXFZEeF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2007 00:34:05 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id 6258913A502; Tue, 26 Jun 2007 16:34:02 +1200 (NZST)
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id B7E7213A4F8;
	Tue, 26 Jun 2007 16:33:57 +1200 (NZST)
User-Agent: Thunderbird 1.5.0.10 (X11/20070307)
In-Reply-To: <e2a1d0aa0706251248j1b8da150xbe19826bec15eed6@mail.gmail.com>
X-Enigmail-Version: 0.94.2.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50947>

Patrick Doyle wrote:
> Hello all,
> I've read http://utsl.gen.nz/talks/git-svn/intro.html, "An
> introduction to git-svn for Subversion/SVK users and deserters" and, I
> guess I'm looking for a little more information.
  [...]
> svn://host/wpd/{project1,project2,project3}.  Since it's my own
> personal playground, I don't need branches, and tend to remember tags
> just be commit number.

There's your first issue - misunderstanding branching :)  You should end
up realising that every little idea or feature forms a code branch in
the direction of its implementation, the choice is whether to let the
branches twist and grow together or train them in clear directions.

> Here's where I get stuck...
> 1) How can I remind myself of what I changed relative to what was in
> the Subversion repository the last time I sync'd to it?  Under my
> current model of operation, I come in after a weekend/night away, do
> "svn status" and "svn diff" to remind myself what's changed, and
> commit those changes with appropriate log messages.  I am hoping that
> I can make the changes locally, commiting them with nice log messages
> as I make the changes, and then "push" them to the subversion server
> when convenient.

use git-branch -a to show you the name that the remote subversion branch
is set up on.

then you can use "git-diff svn/trunk" (say, if it listed it as
"svn/trunk") to show you the files changed between your working copy and
the last subversion commit you did.

I can see that this point isn't very clear from the tutorial if you go
straight in at "How to ... commit back to Subversion".  That section
needs a bit of an overall introduction I think.  The idea is that first,
you make the changes in your local branch. (see
http://utsl.gen.nz/talks/git-svn/intro.html#local-commit).  Then you use
dcommit to save it to Subversion.  Using this you can stage multiple
commits, and if you don't like them you can go back and review them
before they are set in SVN forever.

That mode of operation is already natural for SVK users which the
tutorial was primarily targeted at - so they were probably already
looking for information on how to create a local branch, make local
changes and then push back.

> 2) This is going to have some obvious problems when I work on other
> projects shared with other developers.  We know how to address this
> with Subversion (good communication, updating the working copy prior
> to a commit, resolving the minor conflicts, etc...) what can I expect
> when my local repository is git?

If svn is still the master there should be no difference to the way you
normally collaborate development using Subversion.  The central server
is still the publishing point for trunk, however many release
engineering branches you use, and feature branches.  It's only if you
want to start mixing groups of people, some working with subversion, and
other people using git-svn and merging between each other at the git
level, that you can start getting confused.  They can safely operate at
the patch trading level though.

> 3) If I try to commit my change with:
> 
> $ git-svn dcommit
> 
> I get an error
> Commit 0e3e....
> has no parent commit, and therefore nothing to diff against.
> You should be working from a repository originally created by git-svn
> 
> and that's where I get confused.  Is this a bug/feature of 1.5.0.2
> that will disappear if I switched to 1.5.2.2?
> 
> Are there any other tips/resources for mixed mode operation
> (centralized Subversion server, distributed git client(s))?

Almost certainly because you haven't committed locally yet.

Sam.

> 
> Thanks for any pointers.
> 
> --wpd
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
