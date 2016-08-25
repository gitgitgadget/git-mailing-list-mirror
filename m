Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF17C1F859
	for <e@80x24.org>; Thu, 25 Aug 2016 15:37:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759948AbcHYPhh (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Aug 2016 11:37:37 -0400
Received: from mout.gmx.net ([212.227.15.18]:57748 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751063AbcHYPhB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2016 11:37:01 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0Lcj9b-1atC1r1yyt-00kBZJ; Thu, 25 Aug 2016 17:07:24
 +0200
Date:   Thu, 25 Aug 2016 17:07:22 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 6/6] wt-status: teach has_{unstaged,uncommitted}_changes()
 about submodules
In-Reply-To: <cover.1472137582.git.johannes.schindelin@gmx.de>
Message-ID: <952098a37c704dd6e40912623d1a1fd600c37fe8.1472137582.git.johannes.schindelin@gmx.de>
References: <cover.1472137582.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:35vVyMQprPtTpMAwxdS5XGtiYV+1uTI48uAlaJmdfLMnAbetnUf
 DG1abCctk07LCiZVTuIIn2zxVkTHZOXQjMC/SQo3cpqi+5t0PafIQUHFR8Ojc+bVx5tqgLq
 jBz7+Nf8PnPfZL59PpF6TfHTnSsSPUPuSRJSTE4dyIIuTe9eQhf6MnePjJQInZ7JdJMpAdK
 ZKv9N4LQOQ4k9aA96/wEA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fb6qr3gfpRA=:oIyJ9/LQBbnMSysoZVzxkz
 cJ1tre6hrJas4Da8c6xujaqNIolUprBafIm79uqBuLaUMVtwO06vjwGe42pIVB9s4DB7CPtDa
 R89fKVJpcgGY70f0weMNl2m/0urw3GXPjyWIE4CgifjwxHiSQvhefdwlLlQyfdWdCm33VzHAp
 t3U+JhUDIZgLTWk+sBzi1gWcB/KmXRltz9c6LDBVwOE7nW5wf7EcLRZsltYiBLJqjl1OdoURl
 V/T/ypQe3VOg5uLPZF/p7LUchJn6qvMCDNEA+o6P6hwkF9yLh/HK4rjsN2WuheZJ1xqRrDlks
 udC7WICK1Im7v1RzIWEOqisYB5jO2BEqyzI/F2yjHsF390Jx1gdHy/4TiHc9z1XXUL3jPOo7+
 cDkzxKBRLZBHV0UBkP+9/WyaghH8fRIbcAz6KMD3Si2b/R3UgvCcWphfXbqt7mxGeszwEYEyt
 64NwNA1MlXOn3K/BgIx/IoYztYFMq2vCZV2gbq76kPP/5+X+JxtaNQqzKVVw0N0nSTaPo52Wr
 aghjWnx+Cf9DTgahu0w6Iy0x7NmZ5CufFhcuFdcQ6zHujqFqcPK5cySY87Yn8szhAkTL+Bu3Y
 N/L6V/tEoslp46K6fNUmLO1jMxEJrjHMrb6fEwbDxiuOKUf8glNuvJht6J9RLm5simx473Idh
 7v3//GgF0ziPFd5RBMQlogkthIeZCnm/BmZb24QwUesY+kGEcun1MbNPOC/GV4LLS4+sfLxMw
 /kotqoN8M95xsOsprdYQf/A2VGKVmMpNsS1gkBXwzR3n10IaglCX6mOsaDUObsDKf9zFVAzo3
 bAZN/sF
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
index c35c6e8..843ff19 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -810,7 +810,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 
 		if (!autostash)
 			require_clean_work_tree("pull with rebase",
-				"Please commit or stash them.", 0);
+				"Please commit or stash them.", 1, 0);
 
 		if (get_rebase_fork_point(rebase_fork_point, repo, *refspecs))
 			hashclr(rebase_fork_point);
diff --git a/wt-status.c b/wt-status.c
index 1c3fabf..8ba0b4d 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1762,13 +1762,14 @@ void wt_porcelain_print(struct wt_status *s)
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
@@ -1778,7 +1779,7 @@ int has_unstaged_changes(void)
 /**
  * Returns 1 if there are uncommitted changes, 0 otherwise.
  */
-int has_uncommitted_changes(void)
+int has_uncommitted_changes(int ignore_submodules)
 {
 	struct rev_info rev_info;
 	int result;
@@ -1787,7 +1788,8 @@ int has_uncommitted_changes(void)
 		return 0;
 
 	init_revisions(&rev_info, NULL);
-	DIFF_OPT_SET(&rev_info.diffopt, IGNORE_SUBMODULES);
+	if (ignore_submodules)
+		DIFF_OPT_SET(&rev_info.diffopt, IGNORE_SUBMODULES);
 	DIFF_OPT_SET(&rev_info.diffopt, QUICK);
 	add_head_to_pending(&rev_info);
 	diff_setup_done(&rev_info.diffopt);
@@ -1799,7 +1801,7 @@ int has_uncommitted_changes(void)
  * If the work tree has unstaged or uncommitted changes, dies with the
  * appropriate message.
  */
-int require_clean_work_tree(const char *action, const char *hint, int gently)
+int require_clean_work_tree(const char *action, const char *hint, int ignore_submodules, int gently)
 {
 	struct lock_file *lock_file = xcalloc(1, sizeof(*lock_file));
 	int err = 0;
@@ -1816,12 +1818,12 @@ int require_clean_work_tree(const char *action, const char *hint, int gently)
 	update_index_if_able(&the_index, lock_file);
 	rollback_lock_file(lock_file);
 
-	if (has_unstaged_changes()) {
+	if (has_unstaged_changes(ignore_submodules)) {
 		error(_("Cannot %s: You have unstaged changes."), action);
 		err = 1;
 	}
 
-	if (has_uncommitted_changes()) {
+	if (has_uncommitted_changes(ignore_submodules)) {
 		if (err)
 			error(_("Additionally, your index contains uncommitted changes."));
 		else
diff --git a/wt-status.h b/wt-status.h
index 75833c1..ba56c01 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -115,8 +115,9 @@ void status_printf_ln(struct wt_status *s, const char *color, const char *fmt, .
 __attribute__((format (printf, 3, 4)))
 void status_printf(struct wt_status *s, const char *color, const char *fmt, ...);
 
-int has_unstaged_changes(void);
-int has_uncommitted_changes(void);
-int require_clean_work_tree(const char *action, const char *hint, int gently);
+int has_unstaged_changes(int ignore_submodules);
+int has_uncommitted_changes(int ignore_submodules);
+int require_clean_work_tree(const char *action, const char *hint,
+	int ignore_submodules, int gently);
 
 #endif /* STATUS_H */
-- 
2.10.0.rc1.99.gcd66998
