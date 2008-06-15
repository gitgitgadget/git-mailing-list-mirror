From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [Crash] git-push $remote $non_ref:$anything
Date: Sun, 15 Jun 2008 17:06:52 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0806151626260.19665@iabervon.org>
References: <20080615193823.GA11218@glandium.org> <20080615195541.GA7683@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mike Hommey <mh@glandium.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jun 15 23:08:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7zSZ-0006oa-PP
	for gcvg-git-2@gmane.org; Sun, 15 Jun 2008 23:08:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752229AbYFOVGy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2008 17:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752166AbYFOVGy
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jun 2008 17:06:54 -0400
Received: from iabervon.org ([66.92.72.58]:51467 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752070AbYFOVGy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2008 17:06:54 -0400
Received: (qmail 13010 invoked by uid 1000); 15 Jun 2008 21:06:52 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 15 Jun 2008 21:06:52 -0000
In-Reply-To: <20080615195541.GA7683@sigill.intra.peff.net>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85118>

On Sun, 15 Jun 2008, Jeff King wrote:

> [cc'ing Daniel for remote.c advice]
> 
> On Sun, Jun 15, 2008 at 09:38:23PM +0200, Mike Hommey wrote:
> 
> > I somehow managed to get a segfault by running this:
> > 
> > git push origin non-existant-branch-name:non-existant-branch-name
> 
> Hmm. The problem is the ref-guessing code. Given "git push foo:bar",
> when we try to figure out what "bar" means we first try to find
> refs/heads/bar or refs/heads/bar on the remote. But if that fails, we
> are pushing a new item, so we try to use the same prefix as what "foo"
> resolved to (e.g., if "foo" is a branch, we make it "refs/heads/bar").
> 
> So if "foo" doesn't resolve, we end up dereferencing NULL as part of our
> guess. And the fix is obvious and the patch is below.
> 
> But it kind of makes me wonder why we bother looking at the dst side of
> the refspec at all, since the src has already failed. Is there a good
> reason not to just bail from match_explicit when we can't resolve the
> src?

The only thing I can think of is that a user might have made some mistake 
that would be more obvious with the error messages about both sides. Aside 
from that, it doesn't seem to have any possible effects anyway.

	-Daniel
*This .sig left intentionally blank*
