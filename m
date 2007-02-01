From: Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH] detached HEAD -- finishing touches
Date: Thu, 1 Feb 2007 16:52:42 -0500
Message-ID: <20070201215242.GA1775@thunk.org>
References: <Pine.LNX.4.64.0701311405430.3021@xanadu.home> <20070131231942.GB31145@coredump.intra.peff.net> <Pine.LNX.4.64.0701311907500.3021@xanadu.home> <20070201030030.GA1979@coredump.intra.peff.net> <7vd54ur26u.fsf@assigned-by-dhcp.cox.net> <7vlkjip7mu.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Nicolas Pitre <nico@cam.org>,
	cworth@cworth.org, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Feb 01 22:53:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCjrV-00049Y-5R
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 22:52:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750887AbXBAVwx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 16:52:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750936AbXBAVwx
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 16:52:53 -0500
Received: from THUNK.ORG ([69.25.196.29]:59615 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750887AbXBAVww (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 16:52:52 -0500
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HCjwF-0001Nn-Sw; Thu, 01 Feb 2007 16:57:52 -0500
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HCjrG-00047r-B2; Thu, 01 Feb 2007 16:52:42 -0500
Content-Disposition: inline
In-Reply-To: <7vlkjip7mu.fsf_-_@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38411>

On Thu, Feb 01, 2007 at 01:08:41AM -0800, Junio C Hamano wrote:
>     [git.git]$ git checkout master
>     You are not on any branch and switching to branch 'master'
>     may lose your changes.  At this point, you can do one of two things:
>      (1) Decide it is Ok and say 'git checkout -f master';
>      (2) Start a new branch from the current commit, by saying
>          'git checkout -b <branch-name>'.
>     Leaving your HEAD detached; not switching to branch 'master'.

How hard would it be to simply simply set a flag once git has entered
a detached HEAD state, and clear the flag if any git operation has
modified the repository at all.  If the flag is still set, then
obviously the repository hasn't changed and so there are no changes
that could be lost.  i.e., if I've do:

<tytso@candygram> {/usr/projects/e2fsprogs/hg-to-git/test}  [master]
181% git checkout 2ab15cafae661765ecd7f256b1993b94d5534faf
warning: you are not on ANY branch anymore.
If you meant to create a new branch from this checkout, you may still do
so (now or later) by using -b with the checkout command again.  Example:
  git checkout -b <new_branch_name>
<tytso@candygram> {/usr/projects/e2fsprogs/hg-to-git/test}  
182% git checkout master
You are not on any branch and switching to branch 'master'
may lose your changes.  At this point, you can do one of two things:
 (1) Decide it is Ok and say 'git checkout -f master';
 (2) Start a new branch from the current commit, by saying
     'git checkout -b <branch-name>'.
Leaving your HEAD detached; not switching to branch 'master'.

It's really obvious there are no changes, so it makes git seem a
little stupid to always be saying "may lose your changes".  Can we
simply let git know that there weren't any changes?  

Otherwise we're just training users to just always use the -f option.

						- Ted
