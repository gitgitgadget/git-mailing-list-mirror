From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (stable)
Date: Sat, 11 Aug 2007 01:41:59 -0700
Message-ID: <7vir7mo42w.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 11 10:42:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJmXx-0004aE-SL
	for gcvg-git@gmane.org; Sat, 11 Aug 2007 10:42:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754608AbXHKImG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 11 Aug 2007 04:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754181AbXHKImF
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Aug 2007 04:42:05 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:45453 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753637AbXHKImD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Aug 2007 04:42:03 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070811084200.ISUT2095.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Sat, 11 Aug 2007 04:42:00 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id aYhz1X00S1kojtg0000000; Sat, 11 Aug 2007 04:42:00 -0400
X-maint-at: 93969438dca50c7f0039fcf35e7ab82776d4122f
X-master-at: f9286765b2c409e5b88efe8c20a2634d6842bc5f
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55594>

I thought we were pretty in good shape and in a nice and quiet
freeze period.

Until a few days ago.

Then suddenly, flurry of activity happened.  A few performance
issues were raised and fixed:

 * "git-status" on a huge tree was way suboptimal and found to
   have unnecessary O(n^2) codepath.  Fixing this also sped up
   "git-diff --cached";
 * "git-commit paths..." had a few other bottlenecks.  "git-add
   --stdin" was one of them;
 * In addition, Linus optimized all three cases of "git
   read-tree" that had the same inefficiency;
 * "git-bundle create" had a stupid "one-byte-at-a-time" loop
   that was unnecessary.

Also one of the new features in 1.5.3, GIT_WORK_TREE, was found
to be not-quite-ready.  I think the few commits during the last
couple of days should finally make it ready.

I have resisted merging any new features that were not present
in 1.5.3-rc1, but it appears that we would need to have a few
more -rc rounds before the final _anyway_, so I went into a
merge-binge. A couple of well done topics from the next branch
are now in master:

    * Carlos's "builtin tag" series;
    * David's "format documentation in info format as well" series;

Expect the tip of 'master' to be tagged v1.5.3-rc5 and let's
hope it to be the last -rc before 1.5.3 final.

----------------------------------------------------------------

* The 'master' branch has these since the last announcement
  in addition to the above.

Alex Riesen (1):
  Fix filehandle leak in "git branch -D"

Brian Downing (1):
  cvsserver: Fix for work trees

Carlos Rica (3):
  Make git tag a builtin.
  builtin-tag.c: Fix two memory leaks and minor notation changes.
  Make verify-tag a builtin.

David Kastrup (4):
  Documentation/git-commit.txt: correct bad list formatting.
  Add support for an info version of the user manual
  INSTALL: explain info installation and dependencies.
  Documentation/Makefile: remove cmd-list.made before redirecting to
      it.

Johannes Schindelin (3):
  launch_editor(): Heed GIT_EDITOR and core.editor settings
  Teach "git stripspace" the --strip-comments option
  Reinstate the old behaviour when GIT_DIR is set and GIT_WORK_TREE
      is unset

Junio C Hamano (9):
  git-clone: aggressively optimize local clone behaviour.
  Reorder the list of commands in the manual.
  Fix formatting of git-blame documentation.
  Fix an illustration in git-rev-parse.txt
  tweak manpage formatting
  Revert "tweak manpage formatting"
  Optimize "diff --cached" performance.
  allow git-bundle to create bottomless bundle
  allow git-bundle to create bottomless bundle

Linus Torvalds (7):
  connect: accept file:// URL scheme
  Start moving unpack-trees to "struct tree_desc"
  Fix "git commit directory/" performance anomaly
  Move old index entry removal from "unpack_trees()" into the
      individual functions
  Optimize the common cases of git-read-tree
  Optimize the two-way merge of git-read-tree too
  Optimize the three-way merge of git-read-tree

Mark Levedahl (2):
  builtin-bundle.c - use stream buffered input for rev-list
  builtin-bundle - use buffered reads for bundle header

Shawn O. Pearce (3):
  Teach update-paranoid how to store ACLs organized by groups
  Teach the update-paranoid to look at file differences
  Use the empty tree for base diff in paranoid-update on new branches

Simon Hausmann (2):
  git-p4: Fix support for symlinks.
  git-p4: Fix git-p4 submit to include only changed files in the
      perforce submit template.

Steve Hoelzer (2):
  git-stash documentation: stash numbering starts at zero, not one
  git-stash documentation: add missing backtick

Steven Grimm (1):
  Add a note about the index being updated by git-status in some
      cases

Uwe Kleine-K=C3=B6nig (2):
  send-email: rfc822 forbids using <address@domain> without a
      non-empty "phrase"
  send-email: get all the quoting of realnames right
