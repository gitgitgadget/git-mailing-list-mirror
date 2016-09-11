Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4334D207DF
	for <e@80x24.org>; Sun, 11 Sep 2016 08:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755026AbcIKIDL (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Sep 2016 04:03:11 -0400
Received: from mout.gmx.net ([212.227.15.19]:58501 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754957AbcIKIDG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2016 04:03:06 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LzLJR-1awZxX0rL7-014PP7; Sun, 11 Sep 2016 10:03:02
 +0200
Date:   Sun, 11 Sep 2016 10:03:01 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 5/5] wt-status: teach has_{unstaged,uncommitted}_changes()
 about submodules
In-Reply-To: <cover.1473580914.git.johannes.schindelin@gmx.de>
Message-ID: <b3eb48c4a00e33b6077e270932231291dde6f184.1473580914.git.johannes.schindelin@gmx.de>
References: <cover.1472137582.git.johannes.schindelin@gmx.de> <cover.1473580914.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:YLfWbH6BkSl7ESU/D+Bu0xrSjw++If3a2XVuORGJib31NVA4sf9
 Xx5kgj1gNNuG5zaU+nOX8+K6uJA8Py+Yid3NH7DUzh98SLPlIaghd9EqMYOa1SNhQeH36JL
 U4anL+OEWfLeusNCR3igYOPl9f7eFaBMqz0rbO76Q2YiAweYmc5a0S/lB86Jxu0nyfyFLT4
 k6C0brQ8oA9z13FtOgvxQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZVrFq+hM2dQ=:fA+5AvoVMHOEu+JILl5N8a
 gTP+uvQCI8em4sZAmuzFgUhFGlW4+w4IkUNUVE2uEk4J2lBRYqHBAjDeZg0wBf4umpZaqiEHG
 oMGojF04OP5V+q8AJFYZ0+Ymic/kx+hCWV+jigIFxpBkCl3Blo7AmQDdSx+caOvLteV5sTzXp
 4xUKhByM93WdIgPFDEZvdlZmlFDNN/5pT1jDN/pRHIBYEGqMJ/I+1+gxsmP6jxBVoimzc0kU5
 tegvsTzXVxrr8QMHwZGoWYO6ozDyCIxtpObIEI4RENZKrVn+fFoXGaXjpynhDAxKwqh2vPp8t
 Mxm04du6jB9KVWAus9Nu+uihbPejrhimjsRlMu51wzXhqXPYg1iHMRxyuQeLH3fkewX3/ej8b
 sHw6hclqGXiQaQUrMO6rjZJguyt0ayBe0h4hlBDjsU6RZeHmN7yI99cGEvEwIrsn3Ywk8arMX
 H43mzkDiSb4b9TEqK1XRzcDpMZlSuGYx5dKIZGu9JQr1u4ZtRp/o8aaqDNJaoWAAeLSJg8Dfq
 IfDZWd5YkpKMvVxbR87TQNkvkYMJQH5WFHR7I5ReJIcODABUWo7ahcQZaDphiien3Fe/zcCsx
 1/op7JXHwutvG5DzjCux4vwMpS6SiH2Cf2DaGr7VKmRtWUubdHsuxhjInGmeVmQ70j/WqS2mb
 /HPnzp4R4L736LrNWyFTAvRPiD0j8/F9MEP6Gvvzrue9ltm50q4oT0G2NW9wSW0GPGV8vpgGt
 SpTcpy0/C2sHfVNx0u7CHkAC6piMtS1vaV7TbKl2W7xk3IYipTt3Ska5MJ9qa0+YIlQLyGKFg
 o+bZtyi
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
index f1120e6..086ae79 100644
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
@@ -2261,12 +2263,12 @@ int require_clean_work_tree(const char *action, const char *hint, int gently)
 	update_index_if_able(&the_index, lock_file);
 	rollback_lock_file(lock_file);
 
-	if (has_unstaged_changes()) {
+	if (has_unstaged_changes(ignore_submodules)) {
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
2.10.0.windows.1.10.g803177d
