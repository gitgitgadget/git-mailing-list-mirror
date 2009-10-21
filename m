From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] pull: refuse complete src:dst fetchspec arguments
Date: Tue, 20 Oct 2009 20:15:23 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0910202001050.14365@iabervon.org>
References: <d561e70f0aa802ceb96eba16d3bb2316134d69c8.1256062808.git.trast@student.ethz.ch> <BLU0-SMTP97AA2287062D9A104101C8AEC00@phx.gbl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Sean Estabrooks <seanlkml@sympatico.ca>
X-From: git-owner@vger.kernel.org Wed Oct 21 02:15:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0OrU-0005NI-8q
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 02:15:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752389AbZJUAPV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2009 20:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752085AbZJUAPU
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 20:15:20 -0400
Received: from iabervon.org ([66.92.72.58]:57906 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751319AbZJUAPU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2009 20:15:20 -0400
Received: (qmail 16819 invoked by uid 1000); 21 Oct 2009 00:15:24 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 21 Oct 2009 00:15:24 -0000
In-Reply-To: <BLU0-SMTP97AA2287062D9A104101C8AEC00@phx.gbl>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130872>

On Tue, 20 Oct 2009, Sean Estabrooks wrote:

> On Tue, 20 Oct 2009 20:23:06 +0200
> Thomas Rast <trast@student.ethz.ch> wrote:
> 
> Hi Thomas,
> 
> > git-pull has historically accepted full fetchspecs, meaning that you
> > could do
> > 
> >   git pull $repo A:B
> > 
> > which would simultaneously fetch the remote branch A into the local
> > branch B and merge B into HEAD.  This got especially confusing if B
> > was checked out.  New users variously mistook pull for fetch or read
> > that command as "merge the remote A into my B", neither of which is
> > correct.
> > 
> > Since the above usage should be very rare and can be done with
> > separate calls to fetch and merge, we just disallow full fetchspecs in
> > git-pull.
> 
> It is however a handy shortcut to be able to specify the full refspec
> and specify where you want the head stored locally.  It seems a shame to
> throw away that functionality because of one confusing case.   Wouldn't
> it be better to test of the confusing case and instead error out if the
> local refname is already checked out?

Surely, "where you want the head stored locally" is somewhere that's 
information about a remote repository, and therefore under "refs/remotes/" 
(or "refs/tags/" or something) and therefore not possible to be checked 
out (in the "HEAD is a symref to it" sense).

I don't think it should be possible to fast-forward or create a local 
branch from a remote branch while simultaneously merging it into the 
currently-checked-out local branch.

Actually, I think it would be good to prohibit fetching into a new or 
existing local branch, whether or not it is checked out. We'd probably 
need to provide a plumbing method of doing a fetch, though, for script 
environments that aren't using the normal porcelain meanings of refs/ 
subdirectories. (Defining a bare repo with --mirror as not having local 
branches, of course)

	-Daniel
*This .sig left intentionally blank*
