From: Junio C Hamano <junio@pobox.com>
Subject: [ANNOUNCE] Git v2.6.3
Date: Thu, 05 Nov 2015 15:13:27 -0800
Message-ID: <xmqqegg43uqw.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 06 00:13:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZuTj2-0003gP-Bn
	for gcvg-git-2@plane.gmane.org; Fri, 06 Nov 2015 00:13:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757087AbbKEXNd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Nov 2015 18:13:33 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55477 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756621AbbKEXN3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Nov 2015 18:13:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 410672752C;
	Thu,  5 Nov 2015 18:13:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=Vm5NrD6XRlQI+ucf8bxdGxjA6
	5M=; b=X/2mS5m1M9VfFvt1vj+jIbbhyEiOZXwU2NQ2lCSEjIwjJ5nv46mAxVqNV
	8bzmCTVmblueM9DYjOZGpEWLKFQjF3sBXaQfXuJr714WLFELlT2BgAZyMxAL5mB8
	J6MLMPl2xK1mv+JAQtvp21dzokkra5IK8Q6vko92KFkf6V4Ao0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=a9mcG8VNJj32QiCF3jm
	EF5qRCeeHc6VgIgfuWAKbrwOZ7WOEb0NlhaPUkOkn9v0XnV2lPrGjfWwjpJ/VtiT
	PNZu5O1Sn+Gq5sf+iTjHyojcshzuGCWknAStbt023HgowBcoTmb9zm2XbLP3AO+4
	0MoRGA94VZIdPNBna50Ey1Sw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 36A932752A;
	Thu,  5 Nov 2015 18:13:29 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 99D2427528;
	Thu,  5 Nov 2015 18:13:28 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D2D9508A-8412-11E5-901C-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280947>

The latest maintenance release Git v2.6.3 is now available at
the usual places.  This contains bug & regression fixes that
have already been merged to the 'master' front.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.6.3'
tag and the 'maint' branch that the tag points at:

  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D git://git.sourceforge.jp/gitroot/git-core/git.git
  url =3D git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url =3D https://github.com/gitster/git

----------------------------------------------------------------

Git v2.6.3 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

=46ixes since v2.6.2
------------------

 * The error message from "git blame --contents --reverse" incorrectly
   talked about "--contents --children".

 * "git merge-file" tried to signal how many conflicts it found, which
   obviously would not work well when there are too many of them.

 * The name-hash subsystem that is used to cope with case insensitive
   filesystems keeps track of directories and their on-filesystem
   cases for all the paths in the index by holding a pointer to a
   randomly chosen cache entry that is inside the directory (for its
   ce->ce_name component).  This pointer was not updated even when the
   cache entry was removed from the index, leading to use after free.
   This was fixed by recording the path for each directory instead of
   borrowing cache entries and restructuring the API somewhat.

 * When the "git am" command was reimplemented in C, "git am -3" had a
   small regression where it is aborted in its error handling codepath
   when underlying merge-recursive failed in some ways.

 * The synopsis text and the usage string of subcommands that read
   list of things from the standard input are often shown as if they
   only take input from a file on a filesystem, which was misleading.

 * A couple of commands still showed "[options]" in their usage string
   to note where options should come on their command line, but we
   spell that "[<options>]" in most places these days.

 * The submodule code has been taught to work better with separate
   work trees created via "git worktree add".

 * When "git gc --auto" is backgrounded, its diagnosis message is
   lost.  It now is saved to a file in $GIT_DIR and is shown next time
   the "gc --auto" is run.

 * Work around "git p4" failing when the P4 depot records the contents
   in UTF-16 without UTF-16 BOM.

 * Recent update to "rebase -i" that tries to sanity check the edited
   insn sheet before it uses it has become too picky on Windows where
   CRLF left by the editor is turned into a trailing CR on the line
   read via the "read" built-in command.

 * "git clone --dissociate" runs a big "git repack" process at the
   end, and it helps to close file descriptors that are open on the
   packs and their idx files before doing so on filesystems that
   cannot remove a file that is still open.

 * Correct "git p4 --detect-labels" so that it does not fail to create
   a tag that points at a commit that is also being imported.

 * The internal stripspace() function has been moved to where it
   logically belongs to, i.e. strbuf API, and the command line parser
   of "git stripspace" has been updated to use the parse_options API.

 * Prepare for Git on-disk repository representation to undergo
   backward incompatible changes by introducing a new repository
   format version "1", with an extension mechanism.

 * "git gc" used to barf when a symbolic ref has gone dangling
   (e.g. the branch that used to be your upstream's default when you
   cloned from it is now gone, and you did "fetch --prune").

 * The normalize_ceiling_entry() function does not muck with the end
   of the path it accepts, and the real world callers do rely on that,
   but a test insisted that the function drops a trailing slash.

 * "git gc" is safe to run anytime only because it has the built-in
   grace period to protect young objects.  In order to run with no
   grace period, the user must make sure that the repository is
   quiescent.

 * A recent "filter-branch --msg-filter" broke skipping of the commit
   object header, which is fixed.

 * "git --literal-pathspecs add -u/-A" without any command line
   argument misbehaved ever since Git 2.0.

 * Merging a branch that removes a path and another that changes the
   mode bits on the same path should have conflicted at the path, but
   it didn't and silently favoured the removal.

 * "git imap-send" did not compile well with older version of cURL libr=
ary.

 * The linkage order of libraries was wrong in places around libcurl.

 * It was not possible to use a repository-lookalike created by "git
   worktree add" as a local source of "git clone".

 * When "git send-email" wanted to talk over Net::SMTP::SSL,
   Net::Cmd::datasend() did not like to be fed too many bytes at the
   same time and failed to send messages.  Send the payload one line
   at a time to work around the problem.

 * We peek objects from submodule's object store by linking it to the
   list of alternate object databases, but the code to do so forgot to
   correctly initialize the list.

 * "git status --branch --short" accessed beyond the constant string
   "HEAD", which has been corrected.

 * "git daemon" uses "run_command()" without "finish_command()", so it
   needs to release resources itself, which it forgot to do.

Also contains typofixes, documentation updates and trivial code
clean-ups.

----------------------------------------------------------------

Changes since v2.6.2 are as follows:

David Turner (2):
      t7063: fix flaky untracked-cache test
      name-hash: don't reuse cache_entry in dir_entry

Dimitriy Ryazantcev (1):
      l10n: ru.po: update Russian translation

James McCoy (1):
      filter-branch: remove multi-line headers in msg filter

Jeff King (7):
      introduce "extensions" form of core.repositoryformatversion
      introduce "preciousObjects" repository extension
      t6031: move triple-rename test to t3030
      t6031: generalize for recursive and resolve strategies
      merge: detect delete/modechange conflict
      add_submodule_odb: initialize alt_odb list earlier
      merge-file: clamp exit code to maximum 127

Johannes Schindelin (10):
      t5700: demonstrate a Windows file locking issue with `git clone -=
-dissociate`
      sha1_file: consolidate code to close a pack's file descriptor
      gc: demonstrate failure with stale remote HEAD
      sha1_file.c: add a function to release all packs
      clone --dissociate: avoid locking pack files
      pack-objects: do not get distracted by broken symrefs
      imap-send: only use CURLOPT_LOGIN_OPTIONS if it is actually avail=
able
      Squelch warning about an integer overflow
      Silence GCC's "cast of pointer to integer of a different size" wa=
rning
      t3404: "rebase -i" gets broken when insn sheet uses CR/LF line en=
dings

Junio C Hamano (10):
      am -3: do not let failed merge from completing the error codepath
      Documentation/gc: warn against --prune=3D<now>
      usage: do not insist that standard input must come from a file
      Documentation/everyday: match undefline with the text
      Documentation: match underline with the text
      Documentation: match undefline with the text in old release notes
      Documentation: AsciiDoc spells em-dash as double-dashes, not trip=
le
      add: simplify -u/-A without pathspec
      rebase-i: work around Windows CRLF line endings
      Git 2.6.3

Lars Schneider (2):
      git-p4: add test case for "Translation of file content failed" er=
ror
      git-p4: handle "Translation of file content failed"

Luke Diamand (3):
      git-p4: failing test for ignoring invalid p4 labels
      git-p4: do not terminate creating tag for unknown commit
      git-p4: fix P4 label import for unprocessed commits

Max Kirillov (3):
      submodule refactor: use strbuf_git_path_submodule() in add_submod=
ule_odb()
      path: implement common_dir handling in git_pathdup_submodule()
      blame: fix option name in error message

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (7):
      path.c: delete an extra space
      gc: save log from daemonized gc --auto and print it next time
      t0002: add test for enter_repo(), non-strict mode
      enter_repo: avoid duplicating logic, use is_git_directory() inste=
ad
      enter_repo: allow .git files in strict mode
      clone: allow --local from a linked checkout
      clone: better error when --reference is a linked checkout

Ralf Thielow (1):
      am, credential-cache: add angle brackets to usage string

Ray Donnelly (1):
      test-path-utils.c: remove incorrect assumption

Remi Pommarel (3):
      Makefile: link libcurl before zlib
      Makefile: make curl-config path configurable
      configure.ac: detect ssl need with libcurl

Ren=C3=A9 Scharfe (7):
      t7060: add test for status --branch on a detached HEAD
      wt-status: exit early using goto in wt_shortstatus_print_tracking=
()
      wt-status: avoid building bogus branch name with detached HEAD
      wt-status: don't skip a magical number of characters blindly
      wt-status: use skip_prefix() to get rid of magic string length co=
nstants
      run-command: factor out child_process_clear()
      daemon: plug memory leak

Sidhant Sharma (1):
      worktree: usage: denote <branch> as optional with 'add'

Stefan Agner (1):
      git-send-email.perl: Fixed sending of many/huge changes/patches

Tobias Klauser (2):
      strbuf: make stripspace() part of strbuf
      stripspace: use parse-options for command-line parsing

Waldek Maleska (1):
      Correct fscanf formatting string for I64u values

Xue Fuqiao (2):
      Documentation: fix header markup
      user-manual: fix the description of fast-forward
