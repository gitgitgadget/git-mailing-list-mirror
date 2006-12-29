From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git (stable)
Date: Thu, 28 Dec 2006 21:44:25 -0800
Message-ID: <7vvejvp87a.fsf@assigned-by-dhcp.cox.net>
References: <7v3b73gx43.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Dec 29 06:44:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1H0AXe-0005nK-UT
	for gcvg-git@gmane.org; Fri, 29 Dec 2006 06:44:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964832AbWL2Fo1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Dec 2006 00:44:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754244AbWL2Fo1
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Dec 2006 00:44:27 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:44986 "EHLO
	fed1rmmtao07.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754071AbWL2Fo0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Dec 2006 00:44:26 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061229054425.GUPC3976.fed1rmmtao07.cox.net@fed1rmimpo02.cox.net>;
          Fri, 29 Dec 2006 00:44:25 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 4Vkf1W0081kojtg0000000; Fri, 29 Dec 2006 00:44:39 -0500
To: git@vger.kernel.org
X-maint-at: e6d40d65df07059fc655fabe62fa5b575ead7815
X-master-at: eff73751bb94b0241fd2204effb8680fe9973cbf
In-Reply-To: <7v3b73gx43.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Mon, 25 Dec 2006 19:22:04 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35582>

I've merged a handful topics since v1.5.0-rc0.

 - reflog is now integral part of the data tracked by git, as
   far as local repository is concerned.  You do not have to end
   your sentence with "... but only if you haven't pruned" when
   you tell your users "don't worry, you can get it back with
   master@{2.hours.ago}" anymore.

 - a single command "git gc" would help your repository
   housekeeping chores.

 - shallow-clone capable upload-pack/fetch-pack pair is in.
   Although I think the way they cauterize the ancestry graph
   during the want-have exchange is basically sound, I haven't
   used it extensively and suspect not many people have.  The
   additional code, however, does not seem to harm the normal,
   non-shallow operation in any way; this is to give them wider
   exposure.

 - recording the commit encoding in the new "encoding" header
   and using it together with i18n.{logoutput,commit}encoding
   upon output is also in.  I think Nico's suggestion to use
   LANG also makes sense (perhaps with LC_CTYPE), but haven't
   done that myself yet.

 - git-svn got a handful improvements.

 - segfaulting bug in xdl_merge was fixed.

I'm waiting for ack's to my workaround for http-fetch breakage
when built with cURL 7.16.0, which I would like to resolve
before v1.5.0-rc1.  Also I have a reproducible problem which I
suspect is with Shawn's sliding mmap(), and am hoping we can
ship the sliding mmap() as part of the v1.5.0 after resolving
it.

----------------------------------------------------------------
* The 'master' branch has these since the last announcement.

   Alexandre Julliard (6):
      Shallow clone: do not ignore shallowness when following tags
      fetch-pack: Properly remove the shallow file when it becomes empty.
      upload-pack: Check for NOT_SHALLOW flag before sending a shallow to
        the client.
      git-fetch: Reset shallow_depth before auto-following tags.
      get_shallow_commits: Avoid memory leak if a commit has been reached
	already.
      fetch-pack: Do not fetch tags for shallow clones.

   Andy Parkins (1):
      hooks/commit-msg: add example to add Signed-off-by line to message

   Eric Wong (9):
      git-svn: quiet down tests and fix some unportable shell constructs
      git-svn: dcommit should diff against the current HEAD after committing
      t6024-recursive-merge: quiet down this test
      test-lib: quiet down init-db output for tests
      t9200-git-cvsexportcommit.sh: quiet down commit
      git-svn: remove non-delta fetch code paths
      git-svn: print out the SVN library version in --version, too
      git-svn: verify_ref() should actually --verify
      git-svn: sort multi-init output

   Jakub Narebski (2):
      gitweb: Add mod_perl version string to "generator" meta header
      gitweb: Precompile CGI routines for mod_perl

   Jim Meyering (1):
      update hook: redirect _both_ diagnostic lines to stderr upon tag failure

   Johannes Schindelin (6):
      upload-pack: no longer call rev-list
      support fetching into a shallow repository
      allow cloning a repository "shallowly"
      allow deepening of a shallow repository
      add tests for shallow stuff
      xdl_merge(): fix a segmentation fault when refining conflicts

   Junio C Hamano (32):
      We should make sure that the protocol is still extensible.
      Why does it mean we do not have to register shallow if we have one?
      Why didn't we mark want_obj as ~UNINTERESTING in the old code?
      shallow clone: unparse and reparse an unshallowed commit
      add for_each_reflog_ent() iterator
      Protect commits recorded in reflog from pruning.
      Teach git-repack to preserve objects referred to by reflog entries.
      reflog: fix warning message.
      Move in_merge_bases() to commit.c
      git reflog expire
      reflog expire: prune commits that are not incomplete
      reflog expire: do not punt on tags that point at non commits.
      show-branch --reflog: add documentation.
      Document --numstat in git-apply and git-diff
      Document git-reset <commit> -- <paths>...
      Move encoding conversion routine out of mailinfo to utf8.c
      i18n.logToUTF8: convert commit log message to UTF-8
      Teach log family --encoding
      everyday: update for v1.5.0
      count-objects -v: show number of packs as well.
      rerere gc: honor configuration and document it
      git-reflog: gc.* configuration and documentation.
      everyday: replace a few 'prune' and 'repack' with 'gc'
      Use 'repack -a -d -l' instead of 'repack -a -d' in git-gc
      Set NO_MMAP for Cygwin by default
      UTF-8: introduce i18n.logoutputencoding.
      gcc does not necessarily pass runtime libpath with -R
      Rename t3900 test vector file
      t3900: test conversion to non UTF-8 as well
      GIT_SKIP_TESTS: allow users to omit tests that are known to break
      core.logallrefupdates: log remotes/ tracking branches.
      Allow non-fast-forward of remote tracking branches in default clone

   Nicolas Pitre (3):
      add .mailmap for git-shortlog output with the git repository
      Add git-reflog to .gitignore
      move git-blame to its place in .gitignore

   Quy Tonthat (1):
      git-send-email: default value for "From:" field.

   Robert Fitzsimons (1):
      gitweb: Re-enable rev-list --parents for parse_commit.

   Shawn O. Pearce (8):
      Don't crash during repack of a reflog with pruned commits.
      Create 'git gc' to perform common maintenance operations.
      Use GIT_REFLOG_ACTION environment variable instead.
      Honor GIT_REFLOG_ACTION in git-rebase.
      Use branch names in 'git-rebase -m' conflict hunks.
      Ensure `git-pull` fails if `git-merge` fails.
      Honor pull.{twohead,octopus} in git-merge.
      Allow git-merge to select the default strategy.
