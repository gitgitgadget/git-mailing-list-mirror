From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git
Date: Sun, 05 Mar 2006 23:13:20 -0800
Message-ID: <7v1wxg82r3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Mar 06 08:14:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FG9uH-0006sD-MY
	for gcvg-git@gmane.org; Mon, 06 Mar 2006 08:13:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751936AbWCFHNX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Mar 2006 02:13:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751941AbWCFHNW
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Mar 2006 02:13:22 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:36522 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751936AbWCFHNW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Mar 2006 02:13:22 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060306071032.IKMY17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 6 Mar 2006 02:10:32 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17283>

The "deathmatch" between Ryan's annotate and Fredrik's blame is
officially on.  Currently the last test in all three branches
fail.  Please do not get alarmed.

I'd like asciidoc tweaks in "next" by Francis Daly tested by
people who have access to different vintages of docbook-xsl by
trying to build manpages.  Look for displayed examples, such as
the one in git-branch documentation.  I've tried it with v1.68
and getting far better results than before, and Francis says
v1.69 works fine with or without the change. IOW this is a
workaround for a problem in v1.68.

I've been tweaking on-and-off the similarity estimator in the
"next" branch.  It has become independent from the xdelta code
used for pack generation.  It may detect more renames that it
missed before, and it may miss some other renames and copies.
In general, it seems that the algorithm tends to detect slightly
more breaks than before.  I'd appreciate feedback from people
interested in this area.

Another thing I have started in "pu" branch is to stop placing
an object we decided to delta that is already max-depth deep
back in the delta-base window, because such a thing only wastes
the delta base slot.  The changed pack-objects does pick up more
delta, but the resulting pack seems bigger and I am puzzled why.

This may suggest that our criteria to delta should be tightened
a bit (the value of max_size in try_delta should be decreased).
We are better off storing a plain deflated representation instad
of generating a bad, bigger delta.  Insights?

-- -- --

* The 'master' branch has these since the last announcement.

- Documentation fixes (Dmitry V. Levin, Mark Wooding, Martin
  Langhoff, Jeff Muizelaar)

  git/Documentation: fix SYNOPSIS style bugs
  Documentation/Makefile: Some `git-*.txt' files aren't manpages.
  cvsserver: updated documentation
  cosmetics: change from 'See-Also' to 'See Also'
  documentation: add 'see also' sections to git-rm and git-add

- The deathmatch between annotate/blame (Ryan Anderson, Fredrik
  Kuivinen, me cheerleading)

  annotate: Support annotation of files on other revisions.
  git-blame: Make the output human readable
  git-blame: Use the same tests for git-blame as for git-annotate
  blame: avoid -lm by not using log().
  blame and annotate: show localtime with timezone.
  blame: avoid "diff -u0".
  annotate/blame tests updates.
  annotate-blame test: don't "source", but say "."
  annotate-blame test: add evil merge.

- Tweak rev-list (Linus Torvalds)

  get_revision(): do not dig deeper when we know we are at the end.

- Fix git-commit --amend (me)

  git-commit --amend: allow empty commit.

- Misc fixes and cleanups (Mark Wooding and me)

  gitignore: Ignore some more boring things.
  contrib/emacs/Makefile: Provide tool for byte-compiling files.
  Const tightening.

* The 'next' branch, in addition, has these.

- Fix manpage formatting (Francis Daly)

  Tweak asciidoc output to work with broken docbook-xsl

- Tweak break/rename/copy similarity estimator tweaks (me)

  diffcore-rename: similarity estimator fix.
  count-delta: no need for this anymore.
  diffcore-break: similarity estimator fix.
  diffcore-delta: make change counter to byte oriented again.

- Help pack generation tweaks (me)

  verify-pack -v: show delta-chain histogram.

- checkout-index --temp (Shawn Pearce)

  Add --temp and --stage=all options to checkout-index.

* The 'pu' branch, in addition, has these.

- WIP: pack generation tweak (me)

  [WIP] do not waste delta window with objects with already at max-depth.
