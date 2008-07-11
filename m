From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git cherry-pick before archive
Date: Fri, 11 Jul 2008 19:53:17 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807111950540.8950@racer>
References: <6dbd4d000807110846m2921ddb9r88eb3986762b8f81@mail.gmail.com>  <alpine.DEB.1.00.0807111649290.8950@racer>  <6dbd4d000807110909n1ced22eeraef45af441c20cca@mail.gmail.com>  <20080711161158.GD10347@genesis.frugalware.org>  <alpine.DEB.1.00.0807111924180.8950@racer>
  <6dbd4d000807111128l4721113dh3713bc7abd3d837e@mail.gmail.com>  <alpine.DEB.1.00.0807111944000.8950@racer> <6dbd4d000807111149s4fb661cak9fac152864260901@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Git Mailing List <git@vger.kernel.org>
To: Denis Bueno <dbueno@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 11 20:54:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHNl4-0008Lp-NV
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 20:54:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbYGKSxU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 14:53:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751455AbYGKSxU
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 14:53:20 -0400
Received: from mail.gmx.net ([213.165.64.20]:36041 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750860AbYGKSxT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 14:53:19 -0400
Received: (qmail invoked by alias); 11 Jul 2008 18:53:17 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp026) with SMTP; 11 Jul 2008 20:53:17 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18vVDtNYCQvUMWMc41oe50doG+euZcfxzDB10g5SK
	u7oeplfrW4gL8o
X-X-Sender: gene099@racer
In-Reply-To: <6dbd4d000807111149s4fb661cak9fac152864260901@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88157>

Hi,

On Fri, 11 Jul 2008, Denis Bueno wrote:

> On Fri, Jul 11, 2008 at 14:46, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > BTW in your case, I would suggest this:
> >
> >        INDEX_FILE=.git/bla git read-tree HEAD &&
> >        INDEX_FILE=.git/bla git apply --cached patchfile &&
> >        INDEX_FILE=.git/bla git archive [...] &&
> >        rm .git/bla
> >
> > IOW: Just use a temporary index for your work.
> 
> What is the rationale?  So I can relieve the assumption that the index 
> is clean?

Not completely.

It will just leave the current index alone, ignoring the changes within 
it.  It will also avoid having to update the index several times.

IMO it is just the thing you should do here: you do not want to stage 
anything for commit, so keep .git/index as-is, and use a temporary staging 
area instead.

It also avoids the need to "undo" things that might not be easily undone: 
if your patch contains stuff that was partly in the index, but 
uncommitted, neither "git reset" nor "git revert -n" will do what you 
want.

Ciao,
Dscho
