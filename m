From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (topics)
Date: Wed, 24 Oct 2007 05:51:28 -0700
Message-ID: <7vzly84qwf.fsf@gitster.siamese.dyndns.org>
References: <20071022063222.GS14735@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 24 14:51:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ikfi7-0003t7-T4
	for gcvg-git-2@gmane.org; Wed, 24 Oct 2007 14:51:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755955AbXJXMvf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2007 08:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755975AbXJXMvf
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Oct 2007 08:51:35 -0400
Received: from rune.pobox.com ([208.210.124.79]:58032 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754463AbXJXMvd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2007 08:51:33 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 8783614E911;
	Wed, 24 Oct 2007 08:51:54 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 7FBB914E63A;
	Wed, 24 Oct 2007 08:51:52 -0400 (EDT)
X-master-at: 8d863c98b2f9b0d3777227b85b13b4095dd0f6dc
X-next-at: a7925cfd582cd182c2d28d40f30760b1c89bce87
In-Reply-To: <20071022063222.GS14735@spearce.org> (Shawn O. Pearce's message
	of "Mon, 22 Oct 2007 02:32:22 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62213>

Thanks to Shawn who was a terrific interim maintainer while I
was away, there are quite a few new topics in 'pu'.  The ones in
'next' look safe enough to me, and may graduate to 'master' by
the end of the month.  We'll see.

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.  The topics list the commits in reverse chronological
order.

* cc/skip (Mon Oct 22 07:49:39 2007 +0200) 9 commits
 - Bisect: add a "bisect replay" test case.
 - Bisect: add "bisect skip" to the documentation.
 - Bisect: refactor "bisect_{bad,good,skip}" into "bisect_state".
 - Bisect: refactor some logging into "bisect_write".
 - Bisect: refactor "bisect_write_*" functions.
 - Bisect: implement "bisect skip" to mark untestable revisions.
 - Bisect: fix some white spaces and empty lines breakages.
 - rev-list documentation: add "--bisect-all".
 - rev-list: implement --bisect-all

Still "just parked" as Shawn described, but three patches were
replaced and as a result the series has a single liner fix since
the last "What's cooking".

* ds/gitweb (Mon Oct 22 10:28:03 2007 +1000) 1 commit
 + gitweb: Provide title attributes for abbreviated author names.

* lt/rename (Mon Oct 22 10:29:16 2007 -0700) 2 commits
 - Linear-time/space rename logic (exact renames only)
 - Split out "exact content match" phase of rename detection

The tip commit has been replaced with a new one (actually,
squash of a few commits) since Shawn's announcement and now
t4001 passes.

* js/PATH (Sun Oct 21 22:59:01 2007 +0100) 1 commit
 - execv_git_cmd(): also try PATH if everything else fails.

I do not quite get why this is needed; need to go back to the
discussion myself.  On the other hand, I found the alternative
approach suggested on the list very interesting (i.e. instead of
"also try", just letting exec*p use PATH, relying on the fact
that we do prepend-to-path anyway).  What happened to it?  Was
there a downside?

* ja/shorthelp (Sun Oct 21 01:41:41 2007 +0300) 1 commit
 + On error, do not list all commands, but point to --help option

Shawn says he likes this, and I tend to agree.

* db/fetch-pack (Sat Oct 20 16:03:49 2007 -0400) 60 commits
 + Define compat version of mkdtemp for systems lacking it
 + Avoid scary errors about tagged trees/blobs during git-fetch
 + fetch: if not fetching from default remote, ignore default merge
 + Support 'push --dry-run' for http transport
 + Support 'push --dry-run' for rsync transport
 + Fix 'push --all branch...' error handling
 + Fix compilation when NO_CURL is defined
 + Added a test for fetching remote tags when there is not tags.
 + Fix a crash in ls-remote when refspec expands into nothing
 ...

This has been cooking forever in git timescale.  Judging from
the type of fixes going in, I can see people are using this in
production and the topic is not terribly broken.

* js/forkexec (Fri Oct 19 21:48:06 2007 +0200) 74 commits
 + Use the asyncronous function infrastructure to run the content
   filter.
 + Avoid a dup2(2) in apply_filter() - start_command() can do it for
   us.
 + t0021-conversion.sh: Test that the clean filter really cleans
   content.
 + upload-pack: Run rev-list in an asynchronous function.
 + upload-pack: Move the revision walker into a separate function.
 + Use the asyncronous function infrastructure in builtin-fetch-
   pack.c.
 + Add infrastructure to run a function asynchronously.
 + upload-pack: Use start_command() to run pack-objects in
   create_pack_file().
 + Have start_command() create a pipe to read the stderr of the
   child.
 + Use start_comand() in builtin-fetch-pack.c instead of explicit
   fork/exec.
 + Use run_command() to spawn external diff programs instead of
   fork/exec.
 + Use start_command() to run content filters instead of explicit
   fork/exec.
 + Use start_command() in git_connect() instead of explicit
   fork/exec.
 + Change git_connect() to return a struct child_process instead of a
   pid_t.

Gave a cursory look at a few of the patches but they all looked
fine.

* tf/afs (Fri Oct 19 07:38:16 2007 -0500) 1 commit
 - Better support AFS hardlinking across object directories

I share Shawn's concern of breaking the "never replace existing
object" security.  Will probably drop this patch in the current
shape.

* jk/terse-fetch (Fri Oct 19 03:40:57 2007 -0400) 62 commits
 - park
 - git-fetch: mega-terse fetch output

Haven't caught up with the output format discussion.  Hopefully
somebody will implement the list concensus and resend a
replacement patch, at which time I can drop these two before
looking at these two patches ;-).

* np/progress (Fri Oct 19 01:01:40 2007 -0400) 9 commits
 + Stop displaying "Pack pack-$ID created." during git-gc
 + Teach prune-packed to use the standard progress meter
 + Change 'Deltifying objects' to 'Compressing objects'
 + fix for more minor memory leaks
 + fix const issues with some functions
 + pack-objects.c: fix some global variable abuse and memory leaks
 + pack-objects: no delta possible with only one object in the list
 + cope with multiple line breaks within sideband progress messages
 + more compact progress display

"Compressing objects" caught my eye, but it all makes sense.

* sp/mergetool (Thu Oct 18 12:25:34 2007 +0200) 3 commits
 + mergetool: avoid misleading message "Resetting to default..."
 + mergetool: add support for ECMerge
 + mergetool: use path to mergetool in config var
   mergetool.<tool>.path

* jk/send-pack (Thu Oct 18 02:17:46 2007 -0400) 2 commits
 + t5516: test update of local refs on push
 + send-pack: don't update tracking refs on error

* js/rebase (Wed Oct 17 10:31:35 2007 +0100) 1 commit
 + Fixing path quoting in git-rebase

I have a feeling that this should have forked off of 'maint'.
The change looks obvious and trivial, so perhaps after getting a
testcase (hint, hint) merge to 'master' and then cherry-pick to
'maint' as well.

* js/reflog-delete (Wed Oct 17 02:50:45 2007 +0100) 1 commit
 + Teach "git reflog" a subcommand to delete single entries

Obviously this was meant for git-stash, but I am not sure if
allowing to drop reflog entries in the middle is a good idea in
general.  If we are going to change the UI and the end-user view
for stash _anyway_, we may be better off reimplementing stash as
separate, numbered and/or named refs (e.g. refs/stash/stash-$n).

* jc/stash-create (Mon Jul 9 00:51:23 2007 -0700) 2 commits
 + rebase: allow starting from a dirty tree.
 + stash: implement "stash create"

As I already said earlier, I do not think unstashing always on
top of rebased state is the right thing to do anyway, we would
want to change the behaviour of the tip one, but the question is
how.

* dz/color-addi (Tue Oct 16 21:42:23 2007 -0400) 1 commit
 - Add color support to git-add--interactive

* jc/revert-merge (Tue Oct 23 13:33:26 2007 -0700) 1 commit
 - revert/cherry-pick: work on merge commits as well

Allowing to revert/cherry-pick a merge commit.  I got my first
exposure to the new option parser because I had to adjust to the
new "--mainline" option.  The option is supposed to take positive
integer as a value but I left it as a generic OPT_INTEGER for
now and as a result you may get funny error messages if you give
nonsense input.

* ph/parseopt (Mon Oct 15 23:06:02 2007 +0200) 22 commits
 - Make builtin-pack-refs.c use parse_options.
 - Make builtin-name-rev.c use parse_options.
 - Make builtin-count-objects.c use parse_options.
 - Make builtin-fsck.c use parse_options.
 - Update manpages to reflect new short and long option aliases
 - Make builtin-for-each-ref.c use parse-opts.
 - Make builtin-symbolic-ref.c use parse_options.
 - Make builtin-update-ref.c use parse_options
 - Make builtin-revert.c use parse_options.
 - Make builtin-describe.c use parse_options
 - Make builtin-branch.c use parse_options.
 - Make builtin-mv.c use parse-options
 - Make builtin-rm.c use parse_options.
 - Port builtin-add.c to use the new option parser.
 - parse-options: allow callbacks to take no arguments at all.
 - parse-options: Allow abbreviated options when unambiguous
 - Add shortcuts for very often used options.
 - parse-options: make some arguments optional, add callbacks.
 - Rework make_usage to print the usage message immediately
 - Add tests for parse-options.c
 - parse-options: be able to generate usages automatically
 - Add a simple option parser.

* sp/push-refspec (Sun Oct 14 10:54:45 2007 +0200) 6 commits
 - push, send-pack: use same rules as git-rev-parse to resolve
   refspecs
 - add ref_cmp_full_short() comparing full ref name with a short name
 - push, send-pack: support pushing HEAD to real ref name
 - rev-parse: teach "git rev-parse --symbolic" to print the full ref
   name
 - add get_sha1_with_real_ref() returning full name of ref on demand
 - push, send-pack: fix test if remote branch exists for colon-less
   refspec

* kh/commit (Mon Sep 17 20:06:47 2007 -0400) 4 commits
 + Export rerere() and launch_editor().
 + Introduce entry point add_interactive and add_files_to_cache
 + Enable wt-status to run against non-standard index file.
 + Enable wt-status output to a given FILE pointer.

* jc/spht (Tue Oct 2 18:00:27 2007 -0700) 1 commit
 - git-diff: complain about >=8 consecutive spaces in initial indent
* jc/nu (Mon Oct 1 19:35:12 2007 -0700) 2 commits
 - PARK a bit more work
 - (PARK) WIP
* jc/pathspec (Thu Sep 13 13:38:19 2007 -0700) 3 commits
 - pathspec_can_match(): move it from builtin-ls-tree.c to tree.c
 - ls-tree.c: refactor show_recursive() and rename it.
 - tree-diff.c: split out a function to match a single pattern.
