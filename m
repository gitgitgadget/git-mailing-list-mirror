From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] GIT 1.6.3.rc1
Date: Sat, 18 Apr 2009 18:10:08 -0700
Message-ID: <7v1vrptpn3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 19 03:12:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvLZh-0007P1-5x
	for gcvg-git-2@gmane.org; Sun, 19 Apr 2009 03:12:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753909AbZDSBK0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Apr 2009 21:10:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753280AbZDSBK0
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Apr 2009 21:10:26 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40626 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753276AbZDSBKZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Apr 2009 21:10:25 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 32274ABE65;
	Sat, 18 Apr 2009 21:10:21 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 4BC36ABE63; Sat,
 18 Apr 2009 21:10:14 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: DA8C34FC-2C7E-11DE-904C-C121C5FC92D5-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116873>

A release candidate GIT 1.6.3.rc1 is available at the usual places
for testing:

  http://www.kernel.org/pub/software/scm/git/

  git-1.6.3.rc1.tar.{gz,bz2}			(source tarball)
  git-htmldocs-1.6.3.rc1.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.6.3.rc1.tar.{gz,bz2}		(preformatted docs)

The RPM binary packages for a few architectures are found in:

  testing/git-*-1.6.3.rc1-1.fc9.$arch.rpm	(RPM)

----------------------------------------------------------------

GIT v1.6.3 Release Notes (draft)
================================

With the next major release, "git push" into a branch that is
currently checked out will be refused by default.  You can choose
what should happen upon such a push by setting the configuration
variable receive.denyCurrentBranch in the receiving repository.

To ease the transition plan, the receiving repository of such a
push running this release will issue a big warning when the
configuration variable is missing.  Please refer to:

  http://git.or.cz/gitwiki/GitFaq#non-bare
  http://thread.gmane.org/gmane.comp.version-control.git/107758/focus=108007

for more details on the reason why this change is needed and the
transition plan.

For a similar reason, "git push $there :$killed" to delete the branch
$killed in a remote repository $there, if $killed branch is the current
branch pointed at by its HEAD, gets a large warning.  You can choose what
should happen upon such a push by setting the configuration variable
receive.denyDeleteCurrent in the receiving repository.

When the user does not tell "git push" what to push, it has always
pushed matching refs.  For some people it is unexpected, and a new
configuration variable push.default has been introduced to allow
changing a different default behaviour.  To advertise the new feature,
a big warning is issued if this is not configured and a git push without
arguments is attempted.


Updates since v1.6.2
--------------------

(subsystems)

* various git-svn updates.

(performance)

* many uses of lstat(2) in the codepath for "git checkout" have been
  optimized out.

* pruning reflog entries that are unreachable from the tip of the ref
  during "git reflog prune" (hence "git gc") was very inefficient.

(usability, bells and whistles)

* Boolean configuration variable yes/no can be written as on/off.

* rsync:/path/to/repo can be used to run git over rsync for local
  repositories.  It may not be useful in practice; meant primarily for
  testing.

* http transport learned to prompt and use password when fetching from or
  pushing to http://user@host.xz/ URL.

* (msysgit) progress output that is sent over the sideband protocol can
  be handled appropriately in Windows console.

* "--pretty=<style>" option to the log family of commands can now be
  spelled as "--format=<style>".  In addition, --format=%formatstring
  is a short-hand for --pretty=tformat:%formatstring.

* "--oneline" is a synonym for "--pretty=oneline --abbrev-commit".

* "--graph" to the "git log" family can draw the commit ancestry graph
  in colors.

* If you realize that you botched the patch when you are editing hunks
  with the 'edit' action in git-add -i/-p, you can abort the editor to
  tell git not to apply it.

* The number of commits shown in "you are ahead/behind your upstream"
  messages given by "git checkout" and "git status" used to count merge
  commits; now it doesn't.

* @{-1} is a new way to refer to the last branch you were on introduced in
  1.6.2, but the initial implementation did not teach this to a few
  commands.  Now the syntax works with "branch -m @{-1} newname".

* "git-add -p" now supports "q"uit action.

* git-archive learned --output=<file> option.

* git-archive takes attributes from the tree being archived; strictly
  speaking, this is an incompatible behaviour change, but is a good one.
  Use --worktree-attributes option to allow it to read attributes from
  the work tree as before (deprecated git-tar tree command always reads
  attributes from the work tree).

* git-bisect shows not just the number of remaining commits whose goodness
  is unknown, but also shows the estimated number of remaining rounds.

* You can give --date=<format> option to git-blame.

* "git-branch -r" shows HEAD symref that points at a remote branch in
  interest of each tracked remote repository.

* "git-branch -v -v" is a new way to get list of names for branches and the
  "upstream" branch for them.

* git-config learned -e option to open an editor to edit the config file
  directly.

* git-clone runs post-checkout hook when run without --no-checkout.

* git-difftool is now part of the officially supported command, primarily
  maintained by David Aguilar.

* git-fast-export choked when seeing a tag that does not point at commit.

* git-for-each-ref learned a new "upstream" token.

* git-format-patch can be told to use attachment with a new configuration,
  format.attach.

* git-format-patch can be told to produce deep or shallow message threads.

* git-format-patch can be told to always add sign-off with a configuration
  variable.

* git-format-patch learned format.headers configuration to add extra
  header fields to the output.  This behaviour is similar to the existing
  --add-header=<header> option of the command.

* git-format-patch gives human readable names to the attached files, when
  told to send patches as attachments.

* git-grep learned to highlight the found substrings in color.

* git-imap-send learned to work around Thunderbird's inability to easily
  disable format=flowed with a new configuration, imap.preformattedHTML.

* git-rebase can be told to rebase the series even if your branch is a
  descendant of the commit you are rebasing onto with --force-rebase
  option.

* git-rebase can be told to report diffstat with the --stat option.

* Output from git-remote command has been vastly improved.

* "git remote update --prune $remote" updates from the named remote and
  then prunes stale tracking branches.

* git-send-email learned --confirm option to review the Cc: list before
  sending the messages out.

(developers)

* Test scripts can be run under valgrind.

* Test scripts can be run with installed git.

* Makefile learned 'coverage' option to run the test suites with
  coverage tracking enabled.

* Building the manpages with docbook-xsl between 1.69.1 and 1.71.1 now
  requires setting DOCBOOK_SUPPRESS_SP to work around a docbook-xsl bug.
  This workaround used to be enabled by default, but causes problems
  with newer versions of docbook-xsl.  In addition, there are a few more
  knobs you can tweak to work around issues with various versions of the
  docbook-xsl package.  See comments in Documentation/Makefile for details.

Fixes since v1.6.2
------------------

All of the fixes in v1.6.2.X maintenance series are included in this
release, unless otherwise noted.

Here are fixes that this release has, but have not been backported to
v1.6.2.X series.

* "git-apply" rejected a patch that swaps two files (i.e. renames A to B
  and B to A at the same time).  May need to be backported by cherry
  picking d8c81df and then 7fac0ee).

* The initial checkout did not read the attributes from the .gitattribute
  file that is being checked out.

* git-gc spent excessive amount of time to decide if an object appears
  in a locally existing pack (if needed, backport by merging 69e020a).
