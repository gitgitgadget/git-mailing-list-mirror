From: David Roundy <droundy@abridgegame.org>
Subject: Re: [darcs-devel] Darcs and git: plan of action
Date: Wed, 20 Apr 2005 07:29:43 -0400
Message-ID: <20050420112942.GG29945@abridgegame.org>
References: <7ivf6lm594.fsf@lanthane.pps.jussieu.fr> <20050418122011.GA13769@abridgegame.org> <7iy8bf7fh2.fsf@lanthane.pps.jussieu.fr> <20050419110407.GB28269@abridgegame.org> <7i4qe3x8ig.fsf@lanthane.pps.jussieu.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: darcs-devel@darcs.net, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 20 13:31:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DODPZ-00029J-Dp
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 13:30:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261399AbVDTLen (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 07:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261431AbVDTLen
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 07:34:43 -0400
Received: from user-10mt71s.cable.mindspring.com ([65.110.156.60]:61760 "EHLO
	localhost") by vger.kernel.org with ESMTP id S261399AbVDTLej (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2005 07:34:39 -0400
Received: from droundy by localhost with local (Exim 4.50)
	id 1DODOp-0000a5-83; Wed, 20 Apr 2005 07:29:43 -0400
To: Juliusz Chroboczek <Juliusz.Chroboczek@pps.jussieu.fr>
Mail-Followup-To: Juliusz Chroboczek <Juliusz.Chroboczek@pps.jussieu.fr>,
	darcs-devel@darcs.net, Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7i4qe3x8ig.fsf@lanthane.pps.jussieu.fr>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 19, 2005 at 02:20:55PM +0200, Juliusz Chroboczek wrote:
> [Removing Linus from CC, keeping the Git list -- or should we remove it?]

I think leaving much of this on git would be appropriate, since there are
issues of how to relate to git that should be relevant.

> > If we do it right (automatically tagging like crazy people), darcs
> > users between themselves can cherry-pick all they like, without
> > introducing inconsistencies or losing interoperability with git.
> 
> You've lost me here.  How can you cherry-pick if every tag depends on
> the preceding patches?  Or are you thinking of pulling just the patch
> and not the tag -- in that case, what happens when you push to git a
> Darcs patch that depends on a patch that originated with git?

Yes, I'm thinking of pulling patches from one darcs repo to another.  If we
cherry-pick in this way, we need to create a "git-tag" for each patch that
we pull without its associated tag.  To git, this would look like two
separate changes that have the same commit log, except that they have
different parents and different commiters and commit dates.

I don't think this will be a problem for git, and since darcs will
recognize the two patches as the identical darcs patch (we'll need to put
somewhere in the git commit log a magic word indicating that this patch
originated in darcs), there won't be a problem for darcs either.

In case I haven't been clear (which seems likely), the scenario is that
darcs user 1 makes the following changes to his darcs version of a
git-based repository:

changes in 1: A -> B
tags in 1:    A1   B1

Darcs user 2 wants B, but not A, and didn't do any development:

changes in 2: B
tags in 2:    B2

User 2 pushes to git, and now git has (where P is the parent of both of the
above):

git:
P -> B/B2  (where B/B2 is the commit log with B2 as "committer info" and B
            as the "author info and long comment)

User 1 pushes (everything) to git and merges the two (patch M, which has
two parents, B1 and B2:

git:

   ->B/B2---------
  /               \
P--> A/A1 -> B/B1---> M

It's a little lame, and if user 2 doesn't do any real work, the git-using
person might be annoyed, but I think it's doable.
-- 
David Roundy
http://www.darcs.net
