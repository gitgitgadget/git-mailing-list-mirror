From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git cherry-pick before archive
Date: Fri, 11 Jul 2008 19:46:27 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807111944000.8950@racer>
References: <6dbd4d000807110846m2921ddb9r88eb3986762b8f81@mail.gmail.com>  <alpine.DEB.1.00.0807111649290.8950@racer>  <6dbd4d000807110909n1ced22eeraef45af441c20cca@mail.gmail.com>  <20080711161158.GD10347@genesis.frugalware.org>  <alpine.DEB.1.00.0807111924180.8950@racer>
 <6dbd4d000807111128l4721113dh3713bc7abd3d837e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Git Mailing List <git@vger.kernel.org>
To: Denis Bueno <dbueno@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 11 20:47:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHNeV-0005ku-Nl
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 20:47:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755287AbYGKSqb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 14:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751434AbYGKSqb
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 14:46:31 -0400
Received: from mail.gmx.net ([213.165.64.20]:42012 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755148AbYGKSq3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 14:46:29 -0400
Received: (qmail invoked by alias); 11 Jul 2008 18:46:27 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp033) with SMTP; 11 Jul 2008 20:46:27 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/OpplTfurOhg/mzCxH2xMz9FMSZk7erA0DzxMfNa
	NSfzpKRKTADP+b
X-X-Sender: gene099@racer
In-Reply-To: <6dbd4d000807111128l4721113dh3713bc7abd3d837e@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88155>

Hi,

On Fri, 11 Jul 2008, Denis Bueno wrote:

> On Fri, Jul 11, 2008 at 14:25, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > Anyway, back to Denis' question: I could imagine (haven't tested,
> > thought), that "git revert -n <the-same-commit>" would undo the "git
> > cherry-pick -n".
> 
> So I need to be able to maintain the patch that is applied to the tree
> before archiving, so instead of a commit ID, I'm now using a patch
> file, and the sequence of actions is like so:
> 
>     $ <assume index is clean>
>     $ git apply --cached patchfile || exit 1
>     $ git archive --format=tar --prefix=pfx/ $(git write-tree) \
>           | gzip > prj.tgz
>     $ git reset
> 
> This way I don't even need to reverse-apply the patch, because I never
> touch the working copy.  Of course, this can't be done in this way in
> any other revision control system, because they don't have an index.

Well, they have.  They just do not expose it.

BTW in your case, I would suggest this:

	INDEX_FILE=.git/bla git read-tree HEAD &&
	INDEX_FILE=.git/bla git apply --cached patchfile &&
	INDEX_FILE=.git/bla git archive [...] &&
	rm .git/bla

IOW: Just use a temporary index for your work.

Ciao,
Dscho
