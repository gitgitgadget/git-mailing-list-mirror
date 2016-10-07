Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DFEF20986
	for <e@80x24.org>; Fri,  7 Oct 2016 16:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938959AbcJGQJI (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Oct 2016 12:09:08 -0400
Received: from mout.gmx.net ([212.227.17.20]:62923 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936461AbcJGQJF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2016 12:09:05 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0M20Jj-1b2uQ90Scd-00tz3p; Fri, 07 Oct 2016 18:09:02
 +0200
Date:   Fri, 7 Oct 2016 18:09:00 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 5/6] wt-status: teach has_{unstaged,uncommitted}_changes()
 about submodules
In-Reply-To: <cover.1475856491.git.johannes.schindelin@gmx.de>
Message-ID: <8cf74bc43aea1fd2093ac5edf320c28d78bdcbb2.1475856491.git.johannes.schindelin@gmx.de>
References: <cover.1475586229.git.johannes.schindelin@gmx.de> <cover.1475856491.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:uyGTbRFr3KLKG1m85HS3uuAH1d22wkOCmG62NwW7Ax8F9JSFBAo
 H7H7s1KktrXLmQ3afEbYZdEiGm84Cz73cB19bO/1YqqcxTwRkPyzsf1uvc6Pu0ERZFfd4Gz
 l/4cQpTgnO+urh3hpiF0w1rYUoTcvCl44AqZItQECOhiIHnfiGEzQPorZyZRHMPHYm/gkfz
 HrO8pv0q+oU4UPscyUD5A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:AHrHD8BkKd4=:Rf4R1a11ahrUDxPN/b2BMr
 KWekbjHKyDQsr+NyY0tC/YNnQm91Pi8lw5+TY7ex/eJ0UjAWvpyyR5AKWTvbGa17bGo9ArZOu
 8UHFs3kULg2AgNpNUuM4A+iPSI2RRJdsRaBReynp7n9AxRROjWsaJSzmUGMX9SfmarRp3Fx2W
 d+3pc77n+NUsm2A0PEEXBBSjZof4TGOrUmbWtN6juzU2r32fadfIbQGVRQg+Eb3+JnIz9MQJ6
 zi4PpsRHmMy701gWgvmukBh4P+9dkUPUfXffZrgmSaNhdIhaUwI9PhMi+tPYmnzPYd7RKf7R+
 vFVkA9J0pzkFOmWgdN0zQAC+iT0O9dXTY9jWFjs9TLZ7v7jGSx3O7HuN0U55Zf08s/2vdPRap
 PFlo/k1pviJW6W7J0QpMyzKIamSaQEy4HOi9NXrrwtphiqKIC2m3zgSHe6ebOvgHoHWj1bqWx
 ACX7cbbRheWEn47R+5gEyi9+aFvV0AmnLAueAy0BA+NrtD6PKyyjAAh/gaAYkqKCVriAsOqOf
 cCYa48YhiBpHBXYbiFy6gBlvZgRBal/crDL869+45jAP/SbyRempZGg1m0+ADdWeD4x+Ltd/5
 EsfglZUUCAc2Dhjl33qADeiV9yn7BgTIttxJVC6wjfE8OBSTdnzr8qJboygMXkJm0An3Ukb4N
 oAhnaB1oRCGSvygWhdzyokvxZC331mc4X4gLiYjQ/T/SBqI3M9iIiXdojHB2wdXyipIydTWDw
 ggMCa0uozixCZ9o6OJzijYeMlAZyIuVEV8MHpOHVFZ+VKY5cBYgucZE/Pmi8LtcaplxUby/5/
 nxsjqh5
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
index 01b6465..d6e46ee 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -810,7 +810,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 
 		if (!autostash)
 			require_clean_work_tree(N_("pull with rebase"),
-				_("please commit or stash them."), 0);
+				_("please commit or stash them."), 1, 0);
 
 		if (get_rebase_fork_point(rebase_fork_point, repo, *refspecs))
 			hashclr(rebase_fork_point);
diff --git a/wt-status.c b/wt-status.c
index 8fe7d0a..0020140 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -2213,13 +2213,14 @@ void wt_status_print(struct wt_status *s)
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
@@ -2229,7 +2230,7 @@ int has_unstaged_changes(void)
 /**
  * Returns 1 if there are uncommitted changes, 0 otherwise.
  */
-int has_uncommitted_changes(void)
+int has_uncommitted_changes(int ignore_submodules)
 {
 	struct rev_info rev_info;
 	int result;
@@ -2238,7 +2239,8 @@ int has_uncommitted_changes(void)
 		return 0;
 
 	init_revisions(&rev_info, NULL);
-	DIFF_OPT_SET(&rev_info.diffopt, IGNORE_SUBMODULES);
+	if (ignore_submodules)
+		DIFF_OPT_SET(&rev_info.diffopt, IGNORE_SUBMODULES);
 	DIFF_OPT_SET(&rev_info.diffopt, QUICK);
 	add_head_to_pending(&rev_info);
 	diff_setup_done(&rev_info.diffopt);
@@ -2250,7 +2252,7 @@ int has_uncommitted_changes(void)
  * If the work tree has unstaged or uncommitted changes, dies with the
  * appropriate message.
  */
-int require_clean_work_tree(const char *action, const char *hint, int gently)
+int require_clean_work_tree(const char *action, const char *hint, int ignore_submodules, int gently)
 {
 	struct lock_file *lock_file = xcalloc(1, sizeof(*lock_file));
 	int err = 0;
@@ -2260,13 +2262,13 @@ int require_clean_work_tree(const char *action, const char *hint, int gently)
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


