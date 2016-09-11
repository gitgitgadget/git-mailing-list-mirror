Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E9D020985
	for <e@80x24.org>; Sun, 11 Sep 2016 08:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753063AbcIKIC2 (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Sep 2016 04:02:28 -0400
Received: from mout.gmx.net ([212.227.15.18]:55059 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752463AbcIKICV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2016 04:02:21 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0M0xbD-1atlLF1FRH-00v7mt; Sun, 11 Sep 2016 10:02:14
 +0200
Date:   Sun, 11 Sep 2016 10:02:12 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/5] Pull out require_clean_work_tree() functionality from
 builtin/pull.c
In-Reply-To: <cover.1472137582.git.johannes.schindelin@gmx.de>
Message-ID: <cover.1473580914.git.johannes.schindelin@gmx.de>
References: <cover.1472137582.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:1YNzCUkJKMYKe1uiTklhQFNj++Pj+8RJ8OizPt72BR7/MeHsZSp
 Y4yVhkeHotCF5z2s5K6xvsoWsqmc7tfNNc6G7ePm9z2lpSGoebCfTN7kpBXQpnyHsSZnVxZ
 EW5MJjU3lhQAoWkO1gye8Cbt8LXcbK8g+St9ZDE/OM1iQAtLhflCRNczYYMItYQWe8wJlKl
 cJRCx6zj39P0E1Vm021CQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:u34jbMXNVXY=:Fl36W2KzHkLAupJlkpup3I
 RCo/btzZGcbXVxw3sDTGbT3xHiUme4w2Wr9fB2mnyh0ITpD1c6RtIALUqHZbZ/cut5YEWxnyN
 UKCv4ErDiXiMBNWb8A2on9wh7u1klOq6TEPqatY7zD5+RrwaHVFj2Q8yya4S6iuVXk0sjc0il
 O0RQ5nRMlev/jhszgVJZEVv7M8iqWrPt04DR5FbaRPzjYVqHPGfBeYkqGO+0EyzEQt6NJUdmZ
 z4jPyeCbyev1VYJ0Wftu8xUXrVomOi+I4KSQdHZJVOqNQWZ3YOUbF+mM9+9NERvsYM4es4VGX
 ok3CtYFi4prv4YUj/FiS3cQZwV3wbVc+KTDvQmvTGSnR/8/sIok1miYe/KSbsJHnxgf1+FMzJ
 MvCMFjPVo6grnTM4U0BswBiu7DcdwVvr0UomtOsp/HCkE/HmSxxP+VHRy6vTowoR43lhPs048
 oseSTbmMDHJqHR+hfbsZC7p1fxLkjntjaK5yLJZN2GQdLyOwYMMVYRTDwffR5TlczEe2HE3/x
 g/9ckqfIy7OXR74j/3w0tSV36kLGtrUvvVaN7xh5ILt1YvftN03vVNQdgY1/N27cTsD7kL/jV
 bEf49xvaJkBNzvUGlPeg47C4+FQ/yn7IYCCLF1HBb1rWmh0i9MbCrpVrLrXPOX3QjwETXX/OG
 FDbinTUVleidGDhFpPXUFoV1TuMVE5D7z8LlvDqO3jOxwjgv0ULg3AWwJxDmOCl1Kvatr0mcf
 b0EmoVNhsSaslL4tkatEudFXEHGM+6esFdBQ5kiEx2Jh+APCAAHFrZOdi2VnruCH2/94pidRb
 t/HREyc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the 5th last patch series of my work to accelerate interactive
rebases in particular on Windows.

Basically, all it does is to make reusable some functions that were
ported over from git-pull.sh but made private to builtin/pull.c.

Changes since v1:

- skipped patch that tries to make require_clean_work_tree() smart
  enough to read the index if it was not read yet.

- added a code-comment clarifying that it is the duty of
  require_clean_work_tree()'s caller to ensure that the index has been
  read.

- made the action in require_clean_work_tree() translateable. This
  amazingly easy without complexifying the code, simply by using N_()
  and _() as indicated by Jakub.


Johannes Schindelin (5):
  pull: drop confusing prefix parameter of die_on_unclean_work_tree()
  pull: make code more similar to the shell script again
  Make the require_clean_work_tree() function truly reusable
  Export also the has_un{staged,committed}_changed() functions
  wt-status: teach has_{unstaged,uncommitted}_changes() about submodules

 builtin/pull.c | 71 +++--------------------------------------------------
 wt-status.c    | 77 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 wt-status.h    |  6 +++++
 3 files changed, 86 insertions(+), 68 deletions(-)

Published-As: https://github.com/dscho/git/releases/tag/require-clean-work-tree-v2
Fetch-It-Via: git fetch https://github.com/dscho/git require-clean-work-tree-v2

Interdiff vs v1:

 diff --git a/builtin/pull.c b/builtin/pull.c
 index 843ff19..c639167 100644
 --- a/builtin/pull.c
 +++ b/builtin/pull.c
 @@ -809,7 +809,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
  			die(_("Updating an unborn branch with changes added to the index."));
  
  		if (!autostash)
 -			require_clean_work_tree("pull with rebase",
 +			require_clean_work_tree(N_("pull with rebase"),
  				"Please commit or stash them.", 1, 0);
  
  		if (get_rebase_fork_point(rebase_fork_point, repo, *refspecs))
 diff --git a/wt-status.c b/wt-status.c
 index 129b054..086ae79 100644
 --- a/wt-status.c
 +++ b/wt-status.c
 @@ -2258,20 +2258,13 @@ int require_clean_work_tree(const char *action, const char *hint, int ignore_sub
  	struct lock_file *lock_file = xcalloc(1, sizeof(*lock_file));
  	int err = 0;
  
 -	if (read_cache() < 0) {
 -		error(_("Could not read index"));
 -		if (gently)
 -			return -1;
 -		exit(1);
 -	}
 -
  	hold_locked_index(lock_file, 0);
  	refresh_cache(REFRESH_QUIET);
  	update_index_if_able(&the_index, lock_file);
  	rollback_lock_file(lock_file);
  
  	if (has_unstaged_changes(ignore_submodules)) {
 -		error(_("Cannot %s: You have unstaged changes."), action);
 +		error(_("Cannot %s: You have unstaged changes."), _(action));
  		err = 1;
  	}
  
 @@ -2279,7 +2272,8 @@ int require_clean_work_tree(const char *action, const char *hint, int ignore_sub
  		if (err)
  			error(_("Additionally, your index contains uncommitted changes."));
  		else
 -			error(_("Cannot %s: Your index contains uncommitted changes."), action);
 +			error(_("Cannot %s: Your index contains uncommitted changes."),
 +			      _(action));
  		err = 1;
  	}
  
 diff --git a/wt-status.h b/wt-status.h
 index f0e66c4..54fec77 100644
 --- a/wt-status.h
 +++ b/wt-status.h
 @@ -128,6 +128,7 @@ void status_printf_ln(struct wt_status *s, const char *color, const char *fmt, .
  __attribute__((format (printf, 3, 4)))
  void status_printf(struct wt_status *s, const char *color, const char *fmt, ...);
  
 +/* The following functions expect that the caller took care of reading the index. */
  int has_unstaged_changes(int ignore_submodules);
  int has_uncommitted_changes(int ignore_submodules);
  int require_clean_work_tree(const char *action, const char *hint,

-- 
2.10.0.windows.1.10.g803177d

base-commit: cda1bbd474805e653dda8a71d4ea3790e2a66cbb
