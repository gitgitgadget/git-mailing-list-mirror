From: Petr Baudis <pasky@suse.cz>
Subject: Random Git Issues/Wishlist
Date: Sat, 22 Jul 2006 21:55:02 +0200
Message-ID: <20060722195502.GS13776@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Jul 22 21:55:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G4NZC-0004yU-SJ
	for gcvg-git@gmane.org; Sat, 22 Jul 2006 21:55:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751041AbWGVTzF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 22 Jul 2006 15:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751045AbWGVTzF
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Jul 2006 15:55:05 -0400
Received: from w241.dkm.cz ([62.24.88.241]:49826 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751042AbWGVTzE (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 22 Jul 2006 15:55:04 -0400
Received: (qmail 4884 invoked by uid 2001); 22 Jul 2006 21:55:02 +0200
To: git@vger.kernel.org
Content-Disposition: inline
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24077>

  Hi,

  this is a random list of issues that come up in my mind when I was
thinking about things we could discuss at the Git BOF at OLS in case
enought Git developers gathered - which of course didn't happen but
perhaps it might be useful to mention them as well. Feel free to follow
up with *your* stuff (and comments or patches, of course).

  (i) libgit - right now it has just evolved from bundling random Git
internal calls and has no defined API whatsoever; luckily, nothing
external hopefully uses it yet. If we wait much longer, people will
probably start to and we might start getting into a trouble there.
Another thing is what to do with the builtins, shall we bundle most of
the code in libgit? If not, many libgit users will probably end up just
reimplementing large chunks of their functionality. I've actually
thought about also interfacing libbuiltin.so when doing Git.pm but I
didn't yet for the sake of simplicity.

  (ii) Documentation - it's currently very bad. Incomplete, out of sync,
missing tons of parameters and other things, and so on. We should be
more responsible when adding features to always document them right
away.

  (iii) Lazy clone, shallow clone, whatever you call it. This has
several possible degrees of implementation:

	(a) Just being able to get the latest revision (this really
	    shouldn't be that hard to do)
	(b) Arbitrarily cut off the revisions at some point; this means
	    that you will get _some_ repository but with incomplete
	    history and we should handle that sensibly, like...
	(c) ...having kind of "remote alternates", which means that if
	    we hit an object we don't have we will look it remotely as
	    well; this means moving the remote access functions much
	    more inside the really core Git; we want to be smart and
	    e.g. bundle tree requests with all the msisingblob requests
	    and so on; we don't want to fetch *everything* when the
	    user just does git log, though
	(d) As an extension of (a), having some side of server-client
	    stuff which would also know how to do rev-lists and such
	    remotely; I'm not sure if the demand here is big enough
	    to justify that

  (iv) Packing - I really feel bad about requiring users to manually
repack periodically, and also that's hurting the dumb server users
unless you take special provisions and so on

  (v) Subprojects support; in a sort of long-term limbo because I guess
everyone is too lazy to finally implement something and the users aren't
loud enough ;-) (or they just moved on to another VCS)

  (vi) Renames - should we follow them in logs? Will we? When? How
exactly in the interesting cases?

  (vii) Private tags. refs/private or refs/tags/.hidden? Will we even?
When?

  (viii) Patches versioning in StGit - many people I've told about StGit
complained that it doesn't version patches (and possibly moved to mq?).
We should have some scheme for doing meta-history (especially
interesting when/if we aim to make altering history easy).

  (ix) What about the user survey? It sorta stalled, as far as I can
see.

  (x) Metainformation over the Git protocol - kernel.org wants this
badly because rsyncing the repositories leads to *endless* problems;
there are some more complicated rsync schemes possible but hpa would be
happiest with making it possible to just use git to sync the
repositories out; this might be in part dependent on (iv) since the
repository maintainers basically lose control over the packing

  (xi) Annotate or blame? Most people seem to be in favour of blome,
but having both is confusing; by now one of them should've already won.

  (xii) Special merging - I now maintian the SuSE glibc package in git
and I'd like to use something more sensible than diff3 merger for
merging the changelogs from various branches; it's trivially solvable
conflicts all the time

  (xiii) General user interface issues, like confusing error messages,
incomplete usage help, needlessly complicated (see our git init
discussion in the other thread) or inconsistent usage (git rebase,
anyone?) in general and other stuff aside of (ii).

  That's probably all you'll hear from me for now, I guess. It's your
turn now.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Snow falling on Perl. White noise covering line noise.
Hides all the bugs too. -- J. Putnam
