From: Yann Dirson <ydirson@altern.org>
Subject: Re: [StGIT RFC] Changing patch@branch syntax
Date: Tue, 22 May 2007 23:00:20 +0200
Message-ID: <20070522210020.GV19253@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20070515220310.GJ16903@nan92-1-81-57-214-146.fbx.proxad.net> <b0943d9e0705220527x5d4c3d0fw2d0d66b37aab3f97@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT list <git@vger.kernel.org>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 22 23:02:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqbUe-0000s8-Sk
	for gcvg-git@gmane.org; Tue, 22 May 2007 23:02:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755860AbXEVVCG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 May 2007 17:02:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757147AbXEVVCG
	(ORCPT <rfc822;git-outgoing>); Tue, 22 May 2007 17:02:06 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:33150 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755860AbXEVVCF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2007 17:02:05 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id E2E546080F;
	Tue, 22 May 2007 23:02:01 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 786B51F158; Tue, 22 May 2007 23:00:20 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <b0943d9e0705220527x5d4c3d0fw2d0d66b37aab3f97@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48114>

On Tue, May 22, 2007 at 01:27:08PM +0100, Catalin Marinas wrote:
> We had a discussion some time ago about using slashes for the //top or
> //bottom syntax and we ended up using two slashes. We could do the
> same to delimitate the branch from the patch - branch//patch//top. The
> branch or patch can have (single) slashes in their name.
> 
> We couldn't use ":" at that time as it was used for the 'diff -r x:y'
> command. I later switched to the git ".." format (when git eventually
> defined it). As Karl said, branch:patch@top is another way, unless we
> later decide to add another level, the repository, and would like to
> have a uniform syntax (maybe always use ":" instead of "//"). We could
> run commands like:
> 
>  stg pick ../../path/to/linux-repo//branch//patch

Indeed I would possibly already have used this if it had been
available (working with 2 working copies for 2 cvs branches of a
single project, using stg-cvs in each).


> I don't think using "#" is feasible as bash ignores everything after
> it unless you use quotes or escape.

No, bash only considers # as a comment leader if there is space before
it, which would not be the case here (and is why the
http://repo#branch in cogito worked without problems).  Not sure about
other shells, though.

I'm not very comfortable with // either, since having it special makes
it harder for script writers (need to canonicalize dirnames to ensure
a double slash is not inserted by error).  Whereas it's not a big
problem to solve when the script writer is aware of the problem, it's
not something everyone would think about, and it may even break
existing scripts.


Following the "stg pick" example above, would we also want to allow
picking from a remote repo ?  Then the URL fragment notation could be
suited, and we could have something like:

	http://full/path/to/repo#my/branch:my/patch//top

That is, a formal syntax of:

	[[[repo#]branch:]patch][//modifier]

Going further, since specifying a repo without a branch probably has
no meaning (unless we want to default to the HEAD branch), we could
simplify to the following:

	[[[repo#]branch#]patch][//modifier]

I don't think we really want to allow "repo#patch", meaning that patch
on the current branch, as this gets easily confused by branch switching.


> Another nice thing to have is a way to get older versions of a patch
> via patchlogs. This should probably follow the current git notation,
> i.e. patch^^^ or patch~N.

Yes, that's something I've thought about several times, without coming
with a satisfying solution either: using the git notation to refer to
something different is not a good idea (we already have a "push"
command with a completely different meaning, let's keep these beasts
out if possible ;).  There is already another syntax used by git for
reflogs (ref@{N}), which would have the same problem.

We should also keep in mind that someday we'll surely have merge
entries in patchlogs (one of the things near the top of my todo list),
so the same facility available in git for commit parents as ref^N will
be useful as well.

Another thing is, it would be great if the syntax we elect for this
would be "reserved" by git-core, so git-core does not start to use it
one day and cause a conflict.  Maybe it could be "reserved" so other
porcelains can as well use it (yes, there is the problem of how those
other porcelains interact with stgit then - or rather, how will we
help the user not to get confused) ?

Best regards,
-- 
Yann.
