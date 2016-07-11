Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FEDF1F744
	for <e@80x24.org>; Mon, 11 Jul 2016 20:14:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752458AbcGKUNy (ORCPT <rfc822;e@80x24.org>);
	Mon, 11 Jul 2016 16:13:54 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50457 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750767AbcGKUNw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Jul 2016 16:13:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D026B2CC9F;
	Mon, 11 Jul 2016 16:13:50 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=ocJs/WAyX9lzxd5AEbzJ7Morm
	4o=; b=iwGzp0XOiK8r4FtM0K+KJd3Vtq4DEoQl7n1L1b/cGG2U5g6WWjCIMWlvH
	vt8nE8NXYLCD6ei4FIZ896a1P2S21ZFdF4bYc8SM5MWoGjkvtZUfyKdH2JsVsd56
	RBFU1jjNos3V0aw8vJDSdcp0V4MJR+pis/BJdhhueNBaorx6xE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=PPRVSEEmfVDMns3HEQb
	jf22Mu4zM7EMzo+FK/qybNhWiEkkQ3XECc6sC0ycrVwlQ+i3j2muAbdPpTjdPHj3
	GOvLufW/48EDUwH2Ut3UdP3HUL4GxJRQsfi/REuzAR3kEtH93VnyV+9FCCNcON1p
	jJ4WtYQZa8V8sOqxWeaFw6R4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C8AB32CC9E;
	Mon, 11 Jul 2016 16:13:50 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3B9C22CC9D;
	Mon, 11 Jul 2016 16:13:50 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	git@vger.kernel.org
Cc:	Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] Git v2.9.1
Date:	Mon, 11 Jul 2016 13:13:48 -0700
Message-ID: <xmqqbn247x1f.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FB4A06AE-47A3-11E6-AAED-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The latest maintenance release Git v2.9.1 is now available at the
usual places.  This release includes fixes to two bugs that have
been reported on the list recently, among other changes:

 - v2.9.0 changed cloning of submodules in a top-level superproject
   that was cloned shallowly to explicitly ask for the exact commit
   bound at the superproject, which many instances of servers are
   not yet prepared to handle (the feature appeared in a few
   releases ago but the server operators may not have enabled it
   yet).

 - "git bisect" at the end tries to give something similar to an
   output from "git show --raw" for the found culprit, but the step
   was broken due to an internal API change.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.9.1'
tag and the 'maint' branch that the tag points at:

  url = https://kernel.googlesource.com/pub/scm/git/git
  url = git://repo.or.cz/alt-git.git
  url = git://git.sourceforge.jp/gitroot/git-core/git.git
  url = git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url = https://github.com/gitster/git

----------------------------------------------------------------

Git v2.9.1 Release Notes
========================

Fixes since v2.9
----------------

 * When "git daemon" is run without --[init-]timeout specified, a
   connection from a client that silently goes offline can hang around
   for a long time, wasting resources.  The socket-level KEEPALIVE has
   been enabled to allow the OS to notice such failed connections.

 * The commands in `git log` family take %C(auto) in a custom format
   string.  This unconditionally turned the color on, ignoring
   --no-color or with --color=auto when the output is not connected to
   a tty; this was corrected to make the format truly behave as
   "auto".

 * "git rev-list --count" whose walk-length is limited with "-n"
   option did not work well with the counting optimized to look at the
   bitmap index.

 * "git show -W" (extend hunks to cover the entire function, delimited
   by lines that match the "funcname" pattern) used to show the entire
   file when a change added an entire function at the end of the file,
   which has been fixed.

 * The documentation set has been updated so that literal commands,
   configuration variables and environment variables are consistently
   typeset in fixed-width font and bold in manpages.

 * "git svn propset" subcommand that was added in 2.3 days is
   documented now.

 * The documentation tries to consistently spell "GPG"; when
   referring to the specific program name, "gpg" is used.

 * "git reflog" stopped upon seeing an entry that denotes a branch
   creation event (aka "unborn"), which made it appear as if the
   reflog was truncated.

 * The git-prompt scriptlet (in contrib/) was not friendly with those
   who uses "set -u", which has been fixed.

 * A codepath that used alloca(3) to place an unbounded amount of data
   on the stack has been updated to avoid doing so.

 * "git update-index --add --chmod=+x file" may be usable as an escape
   hatch, but not a friendly thing to force for people who do need to
   use it regularly.  "git add --chmod=+x file" can be used instead.

 * Build improvements for gnome-keyring (in contrib/)

 * "git status" used to say "working directory" when it meant "working
   tree".

 * Comments about misbehaving FreeBSD shells have been clarified with
   the version number (9.x and before are broken, newer ones are OK).

 * "git cherry-pick A" worked on an unborn branch, but "git
   cherry-pick A..B" didn't.

 * "git add -i/-p" learned to honor diff.compactionHeuristic
   experimental knob, so that the user can work on the same hunk split
   as "git diff" output.

 * "log --graph --format=" learned that "%>|(N)" specifies the width
   relative to the terminal's left edge, not relative to the area to
   draw text that is to the right of the ancestry-graph section.  It
   also now accepts negative N that means the column limit is relative
   to the right border.

 * The ownership rule for the piece of memory that hold references to
   be fetched in "git fetch" was screwy, which has been cleaned up.

 * "git bisect" makes an internal call to "git diff-tree" when
   bisection finds the culprit, but this call did not initialize the
   data structure to pass to the diff-tree API correctly.

 * Formats of the various data (and how to validate them) where we use
   GPG signature have been documented.

 * Fix an unintended regression in v2.9 that breaks "clone --depth"
   that recurses down to submodules by forcing the submodules to also
   be cloned shallowly, which many server instances that host upstream
   of the submodules are not prepared for.

 * Fix unnecessarily waste in the idiomatic use of ': ${VAR=default}'
   to set the default value, without enclosing it in double quotes.

 * Some platform-specific code had non-ANSI strict declarations of C
   functions that do not take any parameters, which has been
   corrected.

 * The internal code used to show local timezone offset is not
   prepared to handle timestamps beyond year 2100, and gave a
   bogus offset value to the caller.  Use a more benign looking
   +0000 instead and let "git log" going in such a case, instead
   of aborting.

 * One among four invocations of readlink(1) in our test suite has
   been rewritten so that the test can run on systems without the
   command (others are in valgrind test framework and t9802).

 * t/perf needs /usr/bin/time with GNU extension; the invocation of it
   is updated to "gtime" on Darwin.

 * A bug, which caused "git p4" while running under verbose mode to
   report paths that are omitted due to branch prefix incorrectly, has
   been fixed; the command said "Ignoring file outside of prefix" for
   paths that are _inside_.

 * The top level documentation "git help git" still pointed at the
   documentation set hosted at now-defunct google-code repository.
   Update it to point to https://git.github.io/htmldocs/git.html
   instead.

Also contains minor documentation updates and code clean-ups.

----------------------------------------------------------------

Changes since v2.9.0 are as follows:

Alfred Perlstein (1):
      git-svn: document the 'git svn propset' command

Andrew Oakley (1):
      git-p4: correct hasBranchPrefix verbose output

Armin Kunaschik (1):
      t7800: readlink may not be available

Charles Bailey (1):
      t7810: fix duplicated test title

Dave Nicolson (1):
      Documentation: GPG capitalization

David Turner (1):
      mailmap: use main email address for dturner

Ed Maste (1):
      rebase: update comment about FreeBSD /bin/sh

Edward Thomson (2):
      format_commit_message: honor `color=auto` for `%C(auto)`
      add: add --chmod=+x / --chmod=-x options

Eric Wong (1):
      daemon: enable SO_KEEPALIVE for all sockets

Heiko Becker (1):
      gnome-keyring: Don't hard-code pkg-config executable

Jeff King (9):
      rev-list: "adjust" results of "--count --use-bitmap-index -n"
      rev-list: disable bitmaps when "-n" is used with listing objects
      tree-diff: avoid alloca for large allocations
      fetch: document that pruning happens before fetching
      add--interactive: respect diff.compactionHeuristic
      bisect: always call setup_revisions after init_revisions
      t0006: rename test-date's "show" to "relative"
      t0006: test various date formats
      local_tzoffset: detect errors from tm_to_time_t

Johannes Schindelin (3):
      mingw: let the build succeed with DEVELOPER=1
      perf: accommodate for MacOSX
      t2300: "git --exec-path" is not usable in $PATH on Windows as-is

Jonathan Nieder (1):
      doc: git-htmldocs.googlecode.com is no more

Josef Kufner (1):
      pretty: pass graph width to pretty formatting for use in '%>|(N)'

Junio C Hamano (5):
      blame, line-log: do not loop around deref_tag()
      clone: do not let --depth imply --shallow-submodules
      Start preparing for 2.9.1
      More fixes for 2.9.1
      Git 2.9.1

Keith McGuigan (1):
      builtin/fetch.c: don't free remote->name after fetch

LE Manh Cuong (1):
      sh-setup: enclose setting of ${VAR=default} in double-quotes

Lars Vogel (1):
      Use "working tree" instead of "working directory" for git status

Michael J Gruber (5):
      cherry-pick: allow to pick to unborn branches
      Documentation/technical: describe signature formats
      Documentation/technical: signed tag format
      Documentation/technical: signed commit format
      Documentation/technical: signed merge tag format

Nguyễn Thái Ngọc Duy (1):
      pretty.c: support <direction>|(<negative number>) forms

Peter Colberg (2):
      refs.h: fix misspelt "occurred" in a comment
      config.c: fix misspelt "occurred" in an error message

Pranit Bauva (1):
      strbuf: describe the return value of strbuf_read_file

Ramsay Jones (1):
      regex: fix a SIZE_MAX macro redefinition warning

René Scharfe (9):
      t4051: rewrite, add more tests
      xdiff: factor out match_func_rec()
      xdiff: handle appended chunks better with -W
      xdiff: ignore empty lines before added functions with -W
      xdiff: -W: don't include common trailing empty lines in context
      xdiff: don't trim common tail with -W
      t7810: add test for grep -W and trailing empty context lines
      grep: -W: don't extend context to trailing empty lines
      xdiff: fix merging of appended hunk with -W

SZEDER Gábor (1):
      reflog: continue walking the reflog past root commits

Stefan Beller (1):
      t5614: don't use subshells

Tom Russello (4):
      doc: clearer rule about formatting literals
      doc: change environment variables format
      doc: more consistency in environment variables format
      doc: change configuration variables format

Ville Skyttä (1):
      git-prompt.sh: Don't error on null ${ZSH,BASH}_VERSION, $short_sha

