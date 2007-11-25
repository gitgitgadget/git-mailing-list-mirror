From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: What's cooking in git.git (topics)
Date: Sun, 25 Nov 2007 21:51:28 +0000
Message-ID: <20071125215128.GC23820@fieldses.org>
References: <7vwsso3poo.fsf@gitster.siamese.dyndns.org> <7vfxz89x9q.fsf@gitster.siamese.dyndns.org> <7vabpctx3b.fsf@gitster.siamese.dyndns.org> <7vsl30eyuk.fsf@gitster.siamese.dyndns.org> <7vve7tuz3a.fsf@gitster.siamese.dyndns.org> <20071123103003.GB6754@sigill.intra.peff.net> <Pine.LNX.4.64.0711231319220.27959@racer.site> <20071124113814.GA17861@sigill.intra.peff.net> <alpine.LFD.0.99999.0711241042011.9605@xanadu.home> <7vtznbqx2w.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 25 22:52:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwPOO-0005nN-S3
	for gcvg-git-2@gmane.org; Sun, 25 Nov 2007 22:51:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755370AbXKYVvj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2007 16:51:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755037AbXKYVvi
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Nov 2007 16:51:38 -0500
Received: from mail.fieldses.org ([66.93.2.214]:38822 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752905AbXKYVvi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2007 16:51:38 -0500
Received: from bfields by fieldses.org with local (Exim 4.68)
	(envelope-from <bfields@fieldses.org>)
	id 1IwPNw-0007oA-TH; Sun, 25 Nov 2007 21:51:28 +0000
Content-Disposition: inline
In-Reply-To: <7vtznbqx2w.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66014>

On Sat, Nov 24, 2007 at 11:09:59AM -0800, Junio C Hamano wrote:
> Nicolas Pitre <nico@cam.org> writes:
> > I think that would be better to append a single line at the end of the 
> > display with a clue about what "non fast forward" means.
> 
> I'd agree, but having said all the above, I am not entirely
> happy not mentioning "what next" at all.
> 
> There are two equally valid "what next" after your push is
> rejected due to non-fast-forwardness.
> 
>  (1) You know what you are doing.
> 
>    - You are pushing into a "back-up" repository, not for a
>      public consumption.
> 
>    - You are pushing a branch that are advertised to rebase and
>      rewind into your own publishing repository, and other
>      people interacting with the branch know about this.
> 
>    - You pushed a wrong head there very recently and are fairly
>      confident that nobody has seen that mistake, and pushing
>      the correct one to fix the mistake.
> 
>      In these cases, forcing the push is the right solution
>      (except that the third one is dubious, because it depends
>      heavily on the "fairly confident" part).
> 
>  (2) You were building on a stale head, and were indeed about to
>      lose others' changes with a non-fast-forward push.
> 
>      The right solution is to rebuild what you push so that you
>      will not lose others' changes.  Rebuilding can take two
>      different forms:
> 
>    - You may want to git-fetch and rebase your work on top of
>      others'.
> 
>    - You may want to git-pull, which will merge your work with
>      what others did.
> 
> But of couse the above is way too long as the help text.
> 
> Does the user-manual talk about this?  It has a really good
> description of how to notice when a merge is not resolved
> automatically and what to do next ("Resolving a merge" section).
> Perhaps we can enhance "Pushing changes to a public repository"
> section to include "what if the push is refused" information.

There's a very brief mention of this:

	"As with git-fetch, git-push will complain if this does not
	result in a <<fast-forwards,fast forward>>.  Normally this is a
	sign of something wrong.  However, if you are sure you know what
	you're doing, you may force git-push to perform the update
	anyway by preceding the branch name by a plus sign:

But it'd probably be better to have a separate section.  That makes it
possible to say a little more, and also gets a section called "what to
do when a push fails" into the table of contents.

(Though that's a little vague--push can also fail just because you
mispell the url or something.  A more precise reference to the
particular error might be better, but we'll have to agree on the error
message first....)

Anyway, here's a first draft.

--b.

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 8355cce..7544715 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1929,15 +1929,9 @@ or just
 $ git push ssh://yourserver.com/~you/proj.git master
 -------------------------------------------------
 
-As with git-fetch, git-push will complain if this does not result in
-a <<fast-forwards,fast forward>>.  Normally this is a sign of
-something wrong.  However, if you are sure you know what you're
-doing, you may force git-push to perform the update anyway by
-proceeding the branch name by a plus sign:
-
--------------------------------------------------
-$ git push ssh://yourserver.com/~you/proj.git +master
--------------------------------------------------
+As with git-fetch, git-push will complain if this does not result in a
+<<fast-forwards,fast forward>>; see the following section for details on
+handling this case.
 
 Note that the target of a "push" is normally a
 <<def_bare_repository,bare>> repository.  You can also push to a
@@ -1965,6 +1959,55 @@ See the explanations of the remote.<name>.url, branch.<name>.remote,
 and remote.<name>.push options in gitlink:git-config[1] for
 details.
 
+[[forcing-push]]
+What to do when a push fails
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+If the push does not result in a <<fast-forwards,fast forward>> of the
+remote branch, then it will fail with an error like:
+
+-------------------------------------------------
+error: remote 'refs/heads/master' is not an ancestor of
+ local  'refs/heads/master'.
+ Maybe you are not up-to-date and need to pull first?
+error: failed to push to 'ssh://yourserver.com/~you/proj.git'
+-------------------------------------------------
+
+The most likely reason for this is that you have replaced some of the
+history that you already pushed, so that your "master" is no longer a
+descendant of upstream's "master",  This could happen, for example, if
+you:
+
+	- use `git reset --hard` to remove already-published commits, or
+	- use `git commit --amend` to replace already-published commits
+	  (as in <<fixing-a-mistake-by-editing-history>>), or
+	- use `git rebase` to rebase any already-published commits (as
+	  in <<using-git-rebase>>).
+
+If you are sure you want to replace the branch in the public repository
+by your branch, you may force git-push to perform the update anyway by
+preceding the branch name with a plus sign:
+
+-------------------------------------------------
+$ git push ssh://yourserver.com/~you/proj.git +master
+-------------------------------------------------
+
+Normally whenever a branch head in a public repository is modified, it
+is modified to point to a descendent of the commit that it pointed to
+before.  By forcing a push in this situation, you break that convention.
+(See <<problems-with-rewriting-history>>).
+
+Nevertheless, this is a common practice for people that need a simple
+way to publish a work-in-progress patch series, and it is an acceptable
+compromise as long as you warn other developers that this is how you
+intend to manage the branch.
+
+It's also possible for a push to fail in this way when other people have
+the right to push to the same repository.  In that case, the correct
+solution is to update your work by either a pull or a fetch followed by
+a rebase; see the <<setting-up-a-shared-repository,next section>> for
+more.
+
 [[setting-up-a-shared-repository]]
 Setting up a shared repository
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
