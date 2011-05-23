From: Jeff King <peff@peff.net>
Subject: Re: git checkout no longer warning about uncommitted/untracked files!
Date: Mon, 23 May 2011 17:18:26 -0400
Message-ID: <20110523211826.GD6281@sigill.intra.peff.net>
References: <1306171797211-6395441.post@n2.nabble.com>
 <1306184704408-6396225.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: funeeldy <Marlene_Cote@affirmednetworks.com>
X-From: git-owner@vger.kernel.org Mon May 23 23:18:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOcWI-0007Dh-4u
	for gcvg-git-2@lo.gmane.org; Mon, 23 May 2011 23:18:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757599Ab1EWVS3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2011 17:18:29 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:47684
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757584Ab1EWVS2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2011 17:18:28 -0400
Received: (qmail 23715 invoked by uid 107); 23 May 2011 21:20:32 -0000
Received: from sigill-wired.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.8)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 23 May 2011 17:20:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 23 May 2011 17:18:26 -0400
Content-Disposition: inline
In-Reply-To: <1306184704408-6396225.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174277>

On Mon, May 23, 2011 at 02:05:04PM -0700, funeeldy wrote:

> This is with version 1.7.5.2 - it just keeps the files as modified when I
> checkout a different branch.

Right. This has always been the way git works.

> The bad thing about this is that if I make a change on both branches,
> only the last change is kept, silently.

No, in the example below, you don't actually make a change on a branch.
You make a change to your _worktree_, but that change is not associated
with a branch until you actually commit (which you never do in your
example).

> private/marlene_cote/test/anroot/projects/kernel main_int $ git st
> # On branch main_int
> # Changed but not updated:
> #   (use "git add <file>..." to update what will be committed)
> #   (use "git checkout -- <file>..." to discard changes in working
> directory)
> #
> #	modified:   Makefile
> #
> no changes added to commit (use "git add" and/or "git commit -a")

OK, so you have a change to your Makefile...

> /private/marlene_cote/test/anroot/projects/kernel main_int $ git checkout
> main
> M	Makefile
> Branch main set up to track remote branch main from origin.
> Switched to a new branch 'main'

And now you switch to another branch. Because the version of Makefile in
"main" is the same as the one on "main_int", git can switch branches and
preserve your worktree change (if there had been a change to Makefile in
main_int, you would have seen an error, and git would have told you to
commit or stash your change sfirst).

> /private/marlene_cote/test/anroot/projects/kernel main $ git checkout
> main_int
> M	Makefile
> Switched to branch 'main_int'

Now you're back on main_int, but again, you still have the same change
in Makefile in your worktree.

> /private/marlene_cote/test/anroot/projects/kernel main_int $ git checkout
> main
> M	Makefile
> Switched to branch 'main'

And back to main, with the same change in the worktree.

> v/private/marlene_cote/test/anroot/projects/kernel main $ vi Makefile 

And now you edit the Makefile to new content. If you are expecting the
intermediate state of the Makefile to be kept, it is not. You never
committed it.

> /private/marlene_cote/test/anroot/projects/kernel main $ git checkout
> main_int
> M	Makefile
> Switched to branch 'main_int'

And you still have the new content, because none of these checkouts is
changing your Makefile at all; you are just switching other files around
while the same changes to Makefile sit in the worktree.

-Peff
