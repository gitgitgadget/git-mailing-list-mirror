From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] Fix fetch/pull when run without --update-head-ok
Date: Tue, 14 Oct 2008 18:15:07 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0810141808020.22125@pacific.mpi-cbg.de.mpi-cbg.de>
References: <alpine.DEB.1.00.0810111336350.22125@pacific.mpi-cbg.de.mpi-cbg.de> <alpine.LNX.1.00.0810121501590.19665@iabervon.org> <alpine.DEB.1.00.0810131129110.22125@pacific.mpi-cbg.de.mpi-cbg.de> <7vod1obmlh.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0810132001230.22125@pacific.mpi-cbg.de.mpi-cbg.de> <alpine.LNX.1.00.0810131546180.19665@iabervon.org> <alpine.DEB.1.00.0810141145491.22125@pacific.mpi-cbg.de.mpi-cbg.de> <20081014150227.GC4856@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Oct 14 18:15:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpmSl-0005ma-1R
	for gcvg-git-2@gmane.org; Tue, 14 Oct 2008 18:09:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751800AbYJNQIW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2008 12:08:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751891AbYJNQIW
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Oct 2008 12:08:22 -0400
Received: from mail.gmx.net ([213.165.64.20]:48175 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751665AbYJNQIW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2008 12:08:22 -0400
Received: (qmail invoked by alias); 14 Oct 2008 16:08:20 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp027) with SMTP; 14 Oct 2008 18:08:20 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18dJjpqY+MdqjAbXgoqUGLBoeP4QkzoIZRUkUgZnh
	QPf+dIdhGQlZHZ
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <20081014150227.GC4856@spearce.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98194>

Hi,

On Tue, 14 Oct 2008, Shawn O. Pearce wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > On Mon, 13 Oct 2008, Daniel Barkalow wrote:
> > 
> > > On Mon, 13 Oct 2008, Johannes Schindelin wrote:
> > > 
> > > > I actually understand now why the tests started failing: the change from 
> > > > resolve_ref() to get_branch() as requested by Daniel are at fault: 
> > > > get_branch() does not check if the branch has an initial commit.
> > 
> > So, my vote is to revert back to resolve_ref(), even if it needs more 
> > lines.
> 
> Yes, I agree, resolve_ref() is the best thing to be using here,
> even if it is more code.  get_branch() validates the commit and we
> don't want that.  We really just want to know if the current branch
> is going to be updated, we don't care to what/why.

Actually, get_branch() does _not_ validate.  Which is why it thinks that 
the current branch is "master" even if there is no commit yet.

OTOH, resolve_ref() reads the SHA-1 of the ref, which fails in the case 
that there has not been any commit yet.

Still, I think that it would be nice to allow "git pull origin 
master:master" in a freshly initied non-bare repository, so I like 
resolve_ref() better.

Ciao,
Dscho
