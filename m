From: David Roundy <droundy@abridgegame.org>
Subject: Re: [darcs-devel] Darcs and git: plan of action
Date: Tue, 19 Apr 2005 06:42:53 -0400
Message-ID: <20050419104252.GA28269@abridgegame.org>
References: <7ivf6lm594.fsf@lanthane.pps.jussieu.fr> <20050418122011.GA13769@abridgegame.org> <Pine.LNX.4.58.0504180832330.7211@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: darcs-devel@darcs.net, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 19 12:44:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNqD9-0000Lh-SK
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 12:44:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261348AbVDSKsE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 06:48:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261375AbVDSKsE
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 06:48:04 -0400
Received: from user-10mt71s.cable.mindspring.com ([65.110.156.60]:319 "EHLO
	localhost") by vger.kernel.org with ESMTP id S261348AbVDSKr6 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Apr 2005 06:47:58 -0400
Received: from droundy by localhost with local (Exim 4.50)
	id 1DNqBx-0007M8-Eo; Tue, 19 Apr 2005 06:42:53 -0400
To: Linus Torvalds <torvalds@osdl.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>, darcs-devel@darcs.net,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504180832330.7211@ppc970.osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 18, 2005 at 08:38:25AM -0700, Linus Torvalds wrote:
> On Mon, 18 Apr 2005, David Roundy wrote:
> > .... In particular, it would make life (that is, life interacting back
> > and forth with git) easier if we were to embed darcs patches in their
> > entirety in the git comment block.
> 
> Hell no.

I was afraid that would be the response...

> The commit _does_ specify the patch uniquely and exactly, so I really 
> don't see the point. You can always get the patch by just doing a
> 
> 	git diff $parent_tree $thistree
> 
> so putting the patch in the comment is not an option.

The issue is that in darcs the parent and child trees *don't* uniquely or
exactly specify the patch.  In fact, even the output of git diff will
depend on what version of diff you're using (e.g. if someone were to use
BSD diff rather than GNU diff).

> > As I say, it's a bit ugly, and before we explore the idea further, it would
> > be nice to know if this would cause Linus to vomit in disgust and/or refuse
> > patches from darcs users.
> 
> That's definitely the case. I will _not_ be taking random files etc just 
> to keep other peoples stuff straightened up.

Okay.

> > Another slightly less noxious possibility would be to store the darcs
> > patch as a "hidden" file, if git were given the concept of
> > commit-specific files.
> 
> No, git will not track commit-specific files. There's the comment
> section, and that _is_ the commit-specific file. But I will refuse to
> take any comments that aren't just human-readable explanations, together
> with maybe one extra line of
> 
> 	# Darcs ID: 780c057447d4feef015a905aaf6c87db894ff58c
> 
> (others will want to track _their_ PR numbers etc) and that's it. The 
> actual darcs data that that ID refers to can obviously be maintained in 
> _another_ git archive, but it's not one I'm going to carry about.

The trouble is that the philosophy of darcs and git are about as orthogonal
as one can come.  Git treats the content as fundamental, where in darcs the
changes are fundamental.  Since in darcs there can be different changes
that lead from the same parent to the same child--and these differences are
meaningful when merges happen---when interacting with git, we either need
to restrict darcs to only describe changes in a way that can be uniquely
determined by a parent and child, or we need to have extra metadata
somewhere.

For bidirectional functionality, we either need to avoid the use of
advanced darcs features, or we need to include that information in git
somehow, or we need to keep a parallel darcs archive holding that
information.

Would a small amount of human-readable change information be acceptable in
the free-form comment area? In the rename thread I got the impression this
would be okay for renames.  For example,

rename foo bar

or (this is less important, but you might consider it to be a useful
human-readable comment)

replace [_a-zA-Z0-9] old_variable new_variable file/path

Currently these two patch types account for almost the sum total of the
cases where different patches lead to the same resulting trees.
-- 
David Roundy
