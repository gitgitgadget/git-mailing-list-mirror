From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git 1.7.0
Date: Fri, 12 Feb 2010 17:24:02 -0800
Message-ID: <7vljey6i8d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Sat Feb 13 02:24:30 2010
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1Ng6kH-0007iq-Gl
	for glk-linux-kernel-3@lo.gmane.org; Sat, 13 Feb 2010 02:24:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752213Ab0BMBYS (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Fri, 12 Feb 2010 20:24:18 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51538 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750907Ab0BMBYQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Feb 2010 20:24:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A87FA99D84;
	Fri, 12 Feb 2010 20:24:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=oPJg
	4WsPyvidvnZPndJ/+OqiFgk=; b=XjgygOjSWBM3oEEC5ZNYVYAshfV/ORGbJiOL
	MlyuDv8Sy0rqMRgOteqNzS6NZaGt2TorXsj+AxpCLvS/wuoIl2pPhyn0q0CEBwXI
	O4PyD5P7KsGvkxMokh6kOMYX0J2F/OjwNLlAqdBxfESg5t7fHzC/buMARc+67Zdi
	rqQNzEg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=k8O
	jtitKZrdN0xqCaU8VPeHXu+SPuVNmSp0d/pMFhTSXshh1o4RbFjEu3ukBeT1LUjm
	dYvwEys0KWIJN7c5lsf3n1p7rG53iz9/6UnLi9lw/HOdERaQTbCpMWIJNkqXSE0W
	rKJLT+HfVeakcnD+KWkuZQ2o6xY0Mleievx6PapI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F38499D7E;
	Fri, 12 Feb 2010 20:24:10 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A180999D7A; Fri, 12 Feb
 2010 20:24:04 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7CB35F2A-183E-11DF-BE04-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139769>

The latest feature release Git 1.7.0 is available at the usual
places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.7.0.tar.{gz,bz2}			(source tarball)
  git-htmldocs-1.7.0.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.7.0.tar.{gz,bz2}		(preformatted docs)

The RPM binary packages for a few architectures are found in:

  RPMS/$arch/git-*-1.7.0-1.fc11.$arch.rpm	(RPM)

Git v1.7.0 Release Notes
========================

Notes on behaviour change
-------------------------

 * "git push" into a branch that is currently checked out (i.e. pointed at by
   HEAD in a repository that is not bare) is refused by default.

   Similarly, "git push $there :$killed" to delete the branch $killed
   in a remote repository $there, when $killed branch is the current
   branch pointed at by its HEAD, will be refused by default.

   Setting the configuration variables receive.denyCurrentBranch and
   receive.denyDeleteCurrent to 'ignore' in the receiving repository
   can be used to override these safety features.

 * "git send-email" does not make deep threads by default when sending a
   patch series with more than two messages.  All messages will be sent
   as a reply to the first message, i.e. cover letter.

   It has been possible already to configure send-email to send "shallow thread"
   by setting sendemail.chainreplyto configuration variable to false.  The
   only thing this release does is to change the default when you haven't
   configured that variable.

 * "git status" is not "git commit --dry-run" anymore.  This change does
   not affect you if you run the command without argument.

 * "git diff" traditionally treated various "ignore whitespace" options
   only as a way to filter the patch output.  "git diff --exit-code -b"
   exited with non-zero status even if all changes were about changing the
   amount of whitespace and nothing else;  and "git diff -b" showed the
   "diff --git" header line for such a change without patch text.

   In this release, the "ignore whitespaces" options affect the semantics
   of the diff operation.  A change that does not affect anything but
   whitespaces is reported with zero exit status when run with
   --exit-code, and there is no "diff --git" header for such a change.

 * External diff and textconv helpers are now executed using the shell.
   This makes them consistent with other programs executed by git, and
   allows you to pass command-line parameters to the helpers. Any helper
   paths containing spaces or other metacharacters now need to be
   shell-quoted.  The affected helpers are GIT_EXTERNAL_DIFF in the
   environment, and diff.*.command and diff.*.textconv in the config
   file.

 * The --max-pack-size argument to 'git repack', 'git pack-objects', and
   'git fast-import' was assuming the provided size to be expressed in MiB,
   unlike the corresponding config variable and other similar options accepting
   a size value.  It is now expecting a size expressed in bytes, with a possible
   unit suffix of 'k', 'm', or 'g'.

Updates since v1.6.6
--------------------

(subsystems)

 * "git fast-import" updates; adds "option" and "feature" to detect the
   mismatch between fast-import and the frontends that produce the input
   stream.

 * "git svn" support of subversion "merge tickets" and miscellaneous fixes.

 * "gitk" and "git gui" translation updates.

 * "gitweb" updates (code clean-up, load checking etc.)

(portability)

 * Some more MSVC portability patches for msysgit port.

 * Minimum Pthreads emulation for msysgit port.

(performance)

 * More performance improvement patches for msysgit port.

(usability, bells and whistles)

 * More commands learned "--quiet" and "--[no-]progress" options.

 * Various commands given by the end user (e.g. diff.type.textconv,
   and GIT_EDITOR) can be specified with command line arguments.  E.g. it
   is now possible to say "[diff "utf8doc"] textconv = nkf -w".

 * "sparse checkout" feature allows only part of the work tree to be
   checked out.

 * HTTP transfer can use authentication scheme other than basic
   (i.e./e.g. digest).

 * Switching from a version of superproject that used to have a submodule
   to another version of superproject that no longer has it did not remove
   the submodule directory when it should (namely, when you are not
   interested in the submodule at all and didn't clone/checkout).

 * A new attribute conflict-marker-size can be used to change the size of
   the conflict markers from the default 7; this is useful when tracked
   contents (e.g. git-merge documentation) have strings that resemble the
   conflict markers.

 * A new syntax "<branch>@{upstream}" can be used on the command line to
   substitute the name of the "upstream" of the branch.  Missing branch
   defaults to the current branch, so "git fetch && git merge @{upstream}"
   will be equivalent to "git pull".

 * "git am --resolved" has a synonym "git am --continue".

 * "git branch --set-upstream" can be used to update the (surprise!) upstream,
   i.e. where the branch is supposed to pull and merge from (or rebase onto).

 * "git checkout A...B" is a way to detach HEAD at the merge base between
   A and B.

 * "git checkout -m path" to reset the work tree file back into the
   conflicted state works even when you already ran "git add path" and
   resolved the conflicts.

 * "git commit --date='<date>'" can be used to override the author date
   just like "git commit --author='<name> <email>'" can be used to
   override the author identity.

 * "git commit --no-status" can be used to omit the listing of the index
   and the work tree status in the editor used to prepare the log message.

 * "git commit" warns a bit more aggressively until you configure user.email,
   whose default value almost always is not (and fundamentally cannot be)
   what you want.

 * "git difftool" has been extended to make it easier to integrate it
   with gitk.

 * "git fetch --all" can now be used in place of "git remote update".

 * "git grep" does not rely on external grep anymore.  It can use more than
   one thread to accelerate the operation.

 * "git grep" learned "--quiet" option.

 * "git log" and friends learned "--glob=heads/*" syntax that is a more
   flexible way to complement "--branches/--tags/--remotes".

 * "git merge" learned to pass options specific to strategy-backends.  E.g.

    - "git merge -Xsubtree=path/to/directory" can be used to tell the subtree
      strategy how much to shift the trees explicitly.

    - "git merge -Xtheirs" can be used to auto-merge as much as possible,
      while discarding your own changes and taking merged version in
      conflicted regions.

 * "git push" learned "git push origin --delete branch", a syntactic sugar
   for "git push origin :branch".

 * "git push" learned "git push --set-upstream origin forker:forkee" that
   lets you configure your "forker" branch to later pull from "forkee"
   branch at "origin".

 * "git rebase --onto A...B" means the history is replayed on top of the
   merge base between A and B.

 * "git rebase -i" learned new action "fixup" that squashes the change
   but does not affect existing log message.

 * "git rebase -i" also learned --autosquash option that is useful
   together with the new "fixup" action.

 * "git remote" learned set-url subcommand that updates (surprise!) url
   for an existing remote nickname.

 * "git rerere" learned "forget path" subcommand.  Together with "git
   checkout -m path" it will be useful when you recorded a wrong
   resolution.

 * Use of "git reset --merge" has become easier when resetting away a
   conflicted mess left in the work tree.

 * "git rerere" had rerere.autoupdate configuration but there was no way
   to countermand it from the command line; --no-rerere-autoupdate option
   given to "merge", "revert", etc. fixes this.

 * "git status" learned "-s(hort)" output format.

(developers)

 * The infrastructure to build foreign SCM interface has been updated.

 * Many more commands are now built-in.

 * THREADED_DELTA_SEARCH is no more.  If you build with threads, delta
   compression will always take advantage of it.

Fixes since v1.6.6
------------------

All of the fixes in v1.6.6.X maintenance series are included in this
release, unless otherwise noted.

 * "git branch -d branch" used to refuse deleting the branch even when
   the branch is fully merged to its upstream branch if it is not merged
   to the current branch.  It now deletes it in such a case.

 * "fiter-branch" command incorrectly said --prune-empty and --filter-commit
   were incompatible; the latter should be read as --commit-filter.

 * When using "git status" or asking "git diff" to compare the work tree
   with something, they used to consider that a checked-out submodule with
   uncommitted changes is not modified; this could cause people to forget
   committing these changes in the submodule before committing in the
   superproject. They now consider such a change as a modification and
   "git diff" will append a "-dirty" to the work tree side when generating
   patch output or when used with the --submodule option.
