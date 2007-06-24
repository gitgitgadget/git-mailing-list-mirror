From: Yann Dirson <ydirson@altern.org>
Subject: Re: [StGIT RFC] Changing patch@branch syntax
Date: Sun, 24 Jun 2007 23:26:03 +0200
Message-ID: <20070624212603.GA6361@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20070515220310.GJ16903@nan92-1-81-57-214-146.fbx.proxad.net> <b0943d9e0705220527x5d4c3d0fw2d0d66b37aab3f97@mail.gmail.com> <20070522210020.GV19253@nan92-1-81-57-214-146.fbx.proxad.net> <20070621230207.GD7730@nan92-1-81-57-214-146.fbx.proxad.net> <b0943d9e0706220859n2c2962ffy21464526a5ebd6cd@mail.gmail.com> <20070622200037.GE7730@nan92-1-81-57-214-146.fbx.proxad.net> <b0943d9e0706221529w63a41e82r557179a45b461f61@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT list <git@vger.kernel.org>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 24 23:26:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2Zb6-0003mv-K9
	for gcvg-git@gmane.org; Sun, 24 Jun 2007 23:26:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409AbXFXV0P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Jun 2007 17:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbXFXV0P
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jun 2007 17:26:15 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:55103 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751352AbXFXV0O (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jun 2007 17:26:14 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 3F7E05A108;
	Sun, 24 Jun 2007 23:26:12 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 76B051F151; Sun, 24 Jun 2007 23:26:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <b0943d9e0706221529w63a41e82r557179a45b461f61@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50823>

On Fri, Jun 22, 2007 at 11:29:14PM +0100, Catalin Marinas wrote:
> On 22/06/07, Yann Dirson <ydirson@altern.org> wrote:
> >On Fri, Jun 22, 2007 at 04:59:05PM +0100, Catalin Marinas wrote:
> >> I also don't think we need to make this distinction in the names as
> >> different commands or options take different type of arguments:
> >>
> >> stg show <patch>
> >> stg series --branch <stack>
> >
> >Currently, "stg show HEAD" or any other git ref does work, except when
> >there are name clashes.
> 
> But the argument to 'show' here is either a patch or a git ref (not a
> stack or a pool). It first tries to find a patch and fall back to a
> git ref. You don't specify a stack to 'show'.

Well, currently "stg show <stack>" will just take <stack> as a git
ref, and will show the top commit, which may well be the base commit
of the stack - not very exciting, I agree.


> What might be easier with a complete spec is bash completion. I find
> this mandatory precise description similar to the Hungarian notation.
> Since most of the time I work with push/pop commands, I don't like
> always putting a ":" for every patch

Right, push/pop should only get the local name in the current
patchset, no ":" whatsoever in there.  It is not the same for "show",
since we often want to look at patches in other stacks.


> (BTW, what about patch ranges, I don't think they can go across
> multiple stacks).

Right - we probably only want ranges in the rightmost component of a
patchspec.


> >And since we're going to have all of patches, stacks, and pools in the
> >same "stackable" family, we're going to use them interchangeably in
> >more and more places.  But there are also places where we can use at
> >will stack names and generic git heads (eg. "stg branch X").
> 
> Currently, stack names and git branches are the same. Would this
> change with hydra? I use StGIT to maintain my branches on
> http://www.linux-arm.org/git?p=linux-2.6.git;a=heads and I find the
> stack name == git branch simplification pretty useful.
> 
> What commands/options would we have where we need to distinguish
> between stack and patch names?

I have often wondered if it would be useful to have a given
patch@stack as a base for another stack, or maybe as one of the
"heads" of an hydra.  Still not sure it would make any sense, however
- especially, proper use of hydras would possibly suppress the need
for the former.


> >I'd rather having a single name-resolution mechanism, instead of one
> >for patches and one for branches.
> 
> I don't see why we couldn't have a single name resolution but without
> the mandatory ":". An example (but in reverse order) is internet
> names. I only type "intranet" rather than "intranet." in a browser. To
> fully qualify, I type "intranet.arm.com".

There is a difference, in that in name resolution there is a
well-define algorithm to resolve this, and in that "intranet" alone is
not a valid fully-qualified name.  In current StGIT, in cases where
"name" matches both a local patch a git ref... well, we can still ask
for refs/heads/name as fully-qualified name - looks like I had
forgotten that one ;)


Let's try to find a proper solution.

We have on one hand a number of commands (in the patch/stack sets)
that act solely within the patchset, and thus have no need for
referencing stackables outside the current patchset:

	new, push, pop, goto, float, sink, clean, uncommit, export,
	import, mail, refresh 

Similar commands, but which no technical issue restrain from acting on
stackables in other patchsets:

	delete, hide, unhide, patches, series, files, log, rename, show

Commands that solely refer to patchsets, not stackables:

	applied, unapplied, top, branch, rebase

Commands that need to refer to patches in other patchsets:

	pick

Commands that don't care:

	assimilate, commit, init, pull, fold


I consider we have a couple of special cases:

	clean currently does not care, but see task #5235
	rebase currently only needs patchets, do we need to extend that to patches ?
	mail currently does not accept --branch or patch@stack but probably could
	new creates a patch in the current stack, we may want to unify
		this with "branch -c" in some way (maybe "stg
		(patch|stack|pool) new" ?)
	show is special in that when its arg is not a ref to a patch,
		it falls back to git-show.  We may want to change
		that, to be an stgit-only command.
	sync uses non-standard way to refer to the other stack - do we
		really need to sync several patches in one command ?

	clone is also special, in that it is currently the only one to
		have a use for the repo - it could surely be extended
		to accept a stackable (eg. "stg clone http://this/repo#pool2:stk1")

To summarize, appart from "show" which does not really need to know
about branches, no current command would have any ambiguity.

A couple of commands in the 1st category will needto be enhanced to be
more useful with pools of stacks (to specify which stack of the pool
to act on), but that does not change the problem, they do not act on
non-stackable git-core branches.


> If it is easier for you, you could create a branch (for-upstream etc.)
> and just send me an email to merge it.

Right.  With a bit more work on hydra/pool, I could even tell you to
pull from an pool member ;)


> - concreteCommand, I would write classes with capital first letter
> (unwritten convention in StGIT)

OK


> - why the Repository class definition in stgit/__init__.py? Can it not
> be in a different file?

This is part of the things to clean up.  By putting it here I was sure
the class was going to available as stgit.Repository.  I'm not fluent
in python yet, I'll have to dig for a better way - that one surely
does not scale at all.


> Also, shourt stgit/git.py be aware of the repository?

I'd rather think that we should have git.Repository (and further
structurate git.py with more objects, like git.Branch), with
stgit-specific stuff in the stgit.Repository subclass.

Best regards,
-- 
Yann.
