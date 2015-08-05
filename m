From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git
Date: Wed, 05 Aug 2015 15:55:23 -0700
Message-ID: <xmqqoail1h2c.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 06 00:55:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZN7at-0002NC-KZ
	for gcvg-git-2@plane.gmane.org; Thu, 06 Aug 2015 00:55:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753651AbbHEWz1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2015 18:55:27 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:35648 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751328AbbHEWz0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2015 18:55:26 -0400
Received: by pabxd6 with SMTP id xd6so28811990pab.2
        for <git@vger.kernel.org>; Wed, 05 Aug 2015 15:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:user-agent:mime-version
         :content-type;
        bh=GWoP75AUgyVBrwgcrV4xRq91d9UUoA2Ct7EBwtRW/ys=;
        b=bRJU/o9jQj+144JvFZxwubY08h6n5KmL/BOH0xsukFKBrRMFLAGM0nWgJBrgS4Zm3H
         +y7ZcVk7vogviZ17t1r62jRC9IVUWwtzWeBSh8rFxkW0aMZxm+OvY1JPdSPtI7zZrSZe
         tRwqgnQ3fodhzURSD9RtL+g6o+z7m7VHbr6FV78BBxoNTVNEu9/4yI+Uh6JYN7Muwl6X
         EsSw3IUh59L3HB4pfZ/IQaGs/Km0Pld76Xbfyedue42pim5qXZMiar0Q02ZGWY6oHl+y
         gJsSvBxa3bH44rzLoEfTyymM6WY9vQa6chY4UsrOQWMuJg3sQPRkLE4CoTE6Jb4lnv20
         vY8A==
X-Received: by 10.66.231.69 with SMTP id te5mr23963948pac.98.1438815325597;
        Wed, 05 Aug 2015 15:55:25 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:5cf0:2451:9503:37d])
        by smtp.gmail.com with ESMTPSA id tz1sm4068161pbc.50.2015.08.05.15.55.24
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 05 Aug 2015 15:55:24 -0700 (PDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275406>

This is still a draft but only to show the highlights on new topics.

* bb/remote-get-url (2015-08-05) 1 commit
 - remote: add get-url subcommand

 "git remote" learned "get-url" subcommand to show the URL for a
 given remote name used for fetching and pushing.

 Expecting a reroll.


* dt/untracked-subdir (2015-08-05) 2 commits
 - DONTMERGE: Waiting for an Ack from Duy
 - untracked-cache: fix subdirectory handling
 (this branch uses dt/untracked-sparse.)

 This seems to break some tests.



* cb/open-noatime-clear-errno (2015-08-05) 1 commit
 - git_open_noatime: return with errno=0 on success

 Breaks build; need to tweak.


* jk/guess-repo-name-regression-fix (2015-08-05) 2 commits
 - clone: use computed length in guess_dir_name
 - clone: add tests for output directory
 (this branch is used by ps/guess-repo-name-at-root.)

 "git clone $URL" in recent releases of Git contains a regression in
 the code that invents a new repository name incorrectly based on
 the $URL.  This has been corrected.

 May need some tests from SQUASH??? on ps/guess-repo-name-at-root
 squashed into this, but otherwise looks good.


* ps/guess-repo-name-at-root (2015-08-05) 4 commits
 - SQUASH???
 - clone: abort if no dir name could be guessed
 - clone: do not use port number as dir name
 - clone: do not include authentication data in guessed dir
 (this branch uses jk/guess-repo-name-regression-fix.)

 "git clone $URL", when cloning from a site whose sole purpose is to
 host a single repository (hence, no path after <scheme>://<site>/),
 tried to used the site name as the new repository name, but did
 not remove username or password when <site> part was of the form
 <user>@<pass>:<host>.  The code is taught to redact these.


* jk/notes-merge-config (2015-08-05) 4 commits
 - SQUASH???
 - notes: add notes.merge option to select default strategy
 - notes: add tests for --commit/--abort/--strategy exclusivity
 - notes: document cat_sort_uniq rewriteMode

 "git notes merge" can be told with "--strategy=<how>" option how to
 automatically handle conflicts; this can now be configured by
 setting notes.merge configuration variable.

 The last step to add more specific notes.$ref.merge looked
 questionable.

 Waiting for reroll.


* mk/submodule-gitdir-path (2015-08-05) 2 commits
 - path: implement common_dir handling in git_path_submodule()
 - submodule refactor: use git_path_submodule() in add_submodule_odb()

 The submodule code has been taught to work better with separate
 work trees created via "git worktree add".


* mm/pull-upload-pack (2015-07-30) 1 commit
 - pull.sh: quote $upload_pack when passing it to git-fetch

 "git pull" in recent releases of Git has a regression in the code
 that allows custom path to the --upload-pack=<program>.  This has
 been corrected.

 Will merge to 'maint'.

 This should have already become irrelevant in 'master' with "git
 pull" getting rewritten in C.


* ps/t1509-chroot-test-fixup (2015-08-05) 2 commits
 - tests: fix cleanup after tests in t1509-root-worktree
 - tests: fix broken && chains in t1509-root-worktree

 t1509 test that requires a dedicated VM environment had some
 bitrot, which has been corrected.

 Will merge to 'next'.


* pt/am-builtin-options (2015-08-05) 4 commits
 - am: let --signoff override --no-signoff
 - am: let command-line options override saved options
 - squash! test_terminal: redirect child process' stdin to a pty
 - test_terminal: redirect child process' stdin to a pty
 (this branch uses pt/am-builtin.)

 After "git am --opt1" stops, running "git am --opt2" pays attention
 to "--opt2" only for the patch that caused the original invocation
 to stop.


* sb/remove-get-pathspec (2015-08-03) 1 commit
 - builtin/mv: remove get_pathspec()

 Expecting a reroll ($gmane/275224).


* sb/submodule-helper (2015-08-05) 1 commit
 - submodule: implement `module_list` as a builtin helper

 The beginning of "git submodule" rewritten in C.


* tb/complete-rebase-i-edit-todo (2015-08-05) 1 commit
 - completion: offer '--edit-todo' during interactive rebase

 Comments?


* jk/negative-hiderefs (2015-07-28) 2 commits
 - refs: support negative transfer.hideRefs
 - docs/config.txt: reorder hideRefs config

 Allow negative !ref entry in multi-value transfer.hideRefs
 configuration to say "don't hide this one".

 An update to test coming?
