Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D9DC20986
	for <e@80x24.org>; Tue,  4 Oct 2016 13:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754004AbcJDNF4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 09:05:56 -0400
Received: from mout.gmx.net ([212.227.17.22]:49896 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753807AbcJDNFz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 09:05:55 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0LzHZ7-1an3Gz21nV-014TbL; Tue, 04 Oct 2016 15:05:52
 +0200
Date:   Tue, 4 Oct 2016 15:05:51 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 5/6] wt-status: teach has_{unstaged,uncommitted}_changes()
 about submodules
In-Reply-To: <cover.1475586229.git.johannes.schindelin@gmx.de>
Message-ID: <3825aa3ed793d328e1d3327ed939a7e29c6faa7a.1475586229.git.johannes.schindelin@gmx.de>
References: <cover.1473580914.git.johannes.schindelin@gmx.de> <cover.1475586229.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:4eMNqrJc3ngHDKbEZ8f366qmTM65AxVlbc/NXeAL/U9KS1kVv81
 XWWCk++xmm2UrMLo065Th17yqWxhmdUsYeoXbAFlF302mhR3rbPUGk6Duj0bIaDuFLuSTO+
 4ZggqX4qlOUIzmDaWdGBK6SC6gJHvtJU1QZ8iSETM14HONE/s4bb0gTC7AnPjKRN2GwE34s
 28lmWyAiy977iTBDewM4w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:byJlBZRfCx4=:POYLu1H/+YiqBagzPyskoY
 ogvhJaZ5CgAE43DZGHlADFqJXUP1RQI8EUyxSo1xYYpkK90L6Dv1lulHBDyy3j22qtC4dPNJK
 JKS9gOYJebRgEmDE6fsGpbIFS3DC8eorL11Gy9Qy2jIh0uWqiu/bvu6RhXklEpCM3rxSpLtY/
 8EFDjEmjuXrh56aNdFx34zKiiWG3k7Yjyr2KqB2+zKiY8GYKh/aBC2BuyKPl5aCnA+sMGKZsC
 TYNObwFW4xawPiVUgc8LMVMIaFpF6lw55qqY/hB8COIhNwqRKNi+gyMESqgJUQ06TsMRBA3iv
 kAEkfPJSD8hQyhoEP6V+vQI4covozCXm2d+VrGem0TFpGB2ZRKrkwDQJnKbY+7FzHgA/U6fE0
 Czpngrc3s/yKnY6QJO7eguGlmBoxbKP8MPDE46uBMGL5ZcL17/jB6+APSAXdn25NmXIuMT22S
 CGcejnUQpk0/LQ4P+q06uRbuPF6J9QPGdZ8eMSjvS77DlsG01XnURi5lfwVDEbxlaCMQR7j4/
 L85TJw+mSZf3AUgWalITuK26lPCdkL0QC8PSvzwoOFG0Z78PmsAVGHs4seokf5UVW2RcTSjjO
 UR5gOW0JGf3NdtiNlMiszm+lD6w3QhLhGo+RwsUEvdAHRk9E8fx9kk8NXyJ+PCx+xJce8XC+P
 yPBGyJCgGU32xge2HAkUnfJQn/W7yndisdXgq6M/jsZK1QqmTKo8buqaJJW7JHh90CZMy+XgY
 DpiG2i4BWV/s1hct+UogbpHywV8LwouO9tho5qvyPKOys3JBG5FsJq2dukmf0ociROKnYHYKI
 JxC/Oay
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sometimes we are *actually* interested in those changes... For
example when an interactive rebase wants to continue with a staged
submodule update.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/pull.c |  2 +-
 wt-status.c    | 16 +++++++++-------
 wt-status.h    |  7 ++++---
 3 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 14ef8b5..c639167 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -810,7 +810,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 
 		if (!autostash)
 			require_clean_work_tree(N_("pull with rebase"),
-				"Please commit or stash them.", 0);
+				"Please commit or stash them.", 1, 0);
 
 		if (get_rebase_fork_point(rebase_fork_point, repo, *refspecs))
 			hashclr(rebase_fork_point);
diff --git a/wt-status.c b/wt-status.c
index f4103e4..061597a 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -2214,13 +2214,14 @@ void wt_status_print(struct wt_status *s)
 /**
  * Returns 1 if there are unstaged changes, 0 otherwise.
  */
-int has_unstaged_changes(void)
+int has_unstaged_changes(int ignore_submodules)
 {
 	struct rev_info rev_info;
 	int result;
 
 	init_revisions(&rev_info, NULL);
-	DIFF_OPT_SET(&rev_info.diffopt, IGNORE_SUBMODULES);
+	if (ignore_submodules)
+		DIFF_OPT_SET(&rev_info.diffopt, IGNORE_SUBMODULES);
 	DIFF_OPT_SET(&rev_info.diffopt, QUICK);
 	diff_setup_done(&rev_info.diffopt);
 	result = run_diff_files(&rev_info, 0);
@@ -2230,7 +2231,7 @@ int has_unstaged_changes(void)
 /**
  * Returns 1 if there are uncommitted changes, 0 otherwise.
  */
-int has_uncommitted_changes(void)
+int has_uncommitted_changes(int ignore_submodules)
 {
 	struct rev_info rev_info;
 	int result;
@@ -2239,7 +2240,8 @@ int has_uncommitted_changes(void)
 		return 0;
 
 	init_revisions(&rev_info, NULL);
-	DIFF_OPT_SET(&rev_info.diffopt, IGNORE_SUBMODULES);
+	if (ignore_submodules)
+		DIFF_OPT_SET(&rev_info.diffopt, IGNORE_SUBMODULES);
 	DIFF_OPT_SET(&rev_info.diffopt, QUICK);
 	add_head_to_pending(&rev_info);
 	diff_setup_done(&rev_info.diffopt);
@@ -2251,7 +2253,7 @@ int has_uncommitted_changes(void)
  * If the work tree has unstaged or uncommitted changes, dies with the
  * appropriate message.
  */
-int require_clean_work_tree(const char *action, const char *hint, int gently)
+int require_clean_work_tree(const char *action, const char *hint, int ignore_submodules, int gently)
 {
 	struct lock_file *lock_file = xcalloc(1, sizeof(*lock_file));
 	int err = 0;
@@ -2261,13 +2263,13 @@ int require_clean_work_tree(const char *action, const char *hint, int gently)
 	update_index_if_able(&the_index, lock_file);
 	rollback_lock_file(lock_file);
 
-	if (has_unstaged_changes()) {
+	if (has_unstaged_changes(ignore_submodules)) {
 		/* TRANSLATORS: the action is e.g. "pull with rebase" */
 		error(_("Cannot %s: You have unstaged changes."), _(action));
 		err = 1;
 	}
 
-	if (has_uncommitted_changes()) {
+	if (has_uncommitted_changes(ignore_submodules)) {
 		if (err)
 			error(_("Additionally, your index contains uncommitted changes."));
 		else
diff --git a/wt-status.h b/wt-status.h
index 68e367a..54fec77 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -129,8 +129,9 @@ __attribute__((format (printf, 3, 4)))
 void status_printf(struct wt_status *s, const char *color, const char *fmt, ...);
 
 /* The following functions expect that the caller took care of reading the index. */
-int has_unstaged_changes(void);
-int has_uncommitted_changes(void);
-int require_clean_work_tree(const char *action, const char *hint, int gently);
+int has_unstaged_changes(int ignore_submodules);
+int has_uncommitted_changes(int ignore_submodules);
+int require_clean_work_tree(const char *action, const char *hint,
+	int ignore_submodules, int gently);
 
 #endif /* STATUS_H */
-- 
2.10.0.windows.1.325.ge6089c1


