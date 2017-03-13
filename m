Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B930920373
	for <e@80x24.org>; Mon, 13 Mar 2017 20:11:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753562AbdCMULd (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 16:11:33 -0400
Received: from mout.gmx.net ([212.227.15.19]:49598 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753507AbdCMUL1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 16:11:27 -0400
Received: from virtualbox ([95.208.58.29]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MX1hk-1chtan0cvE-00W0pw; Mon, 13
 Mar 2017 21:11:05 +0100
Date:   Mon, 13 Mar 2017 21:11:04 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v6 06/12] Make read_early_config() reusable
In-Reply-To: <cover.1489435755.git.johannes.schindelin@gmx.de>
Message-ID: <2418decf16a0e2b4dda66f8dce8ae47b75417a34.1489435755.git.johannes.schindelin@gmx.de>
References: <cover.1489098170.git.johannes.schindelin@gmx.de> <cover.1489435755.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:uYR1gbz6TLoPL7AgG/NnReT86cgIGgHb9Rt//n/Flgkyb0IqaRD
 p8Ud8VMzM5ID4ENRwuQjlfG+UQmjSlk89FA4Vi6cmDb91qMWZNa+9pxt/59LPEXB2vBST1t
 XI1Tw8xvZrCt4Kw8xh7g1FP9voD3VEW+34h0ksZBQzRnK/CsLdeqycsD1fEm90InEyAqaAc
 fMnkpR02eX50AdBf7mcKg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Y0eVjv+Z7P4=:icywUE7ih521qcIYXw/jbz
 AYyyXgStrxqeT8iwYnoGO6lkma/u1ici8Ss3EDPLvANyXxH0ecz1scZK3TEL0/gJ3tg3Jk3yf
 3R5s359IKD3yhWhU/qu4+OsXYuCNLUvMS4btx0q+dSM07NJc3UuD4oC7+924NJHdAWF81p/IM
 BNKKVIrl/pyUNORQRiomM5rVHZ7Q/wdwyQE8PJUr0W05gMNDu8aV/nbr4a5C8GZsjgR50qtsZ
 E0d3/6P7GIc5Q8GbZjXLqSENFyl8PCPYOTd7MZpAkIp98dh7T0DaDoFuCfpU6O7BxVXO5uUHP
 3PlnR8NKRD8k+sAzbbkb8AY0EkGQJpQ9oCfy9JzXLhjTh2/09x18bBUn/PxACwcpPWhnmMa42
 1yu7Q6lxHqJ6ZKnWpySwfJySLy4eNnppWzMcTQ+d5QAjTttQkZ1tQjbJNDv2Sl+aXCDhV2ysl
 eDtZNJLHd8b1SkcxvvbwduNkIAA/li2jtwRoXO5g0C/33c4FZ3m6i/0bToSJ+NY6WYjJ+o+MH
 NyJPJQDY6eDgzJ7nipCj5siOZ5r7Du8Jd4zKXobCG6FKQiqe3MhOOuaHQ6NGxAzi/IyCPErJX
 UAL18yOFLD7FuZaTt9OdHh7ZjwWpV2FU+I5ONFS0ZXVZ+nZwAac2+vHnTExsWN0xLwgW+C7ID
 2cvytXXsa8M0lGVXo9VCGFXOqdsw/kv4R5MlvQVQHGq0oi8AITiDmWU/EexQgw5GCbujuobRM
 M23Jdy26nW9OhnGylrYPZ3DdNbDyRhJkFaCT8D5Fo4OZ/6L7btcpQ4jKYXYeFoXRHz9YYngLB
 EsxFskR
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The pager configuration needs to be read early, possibly before
discovering any .git/ directory.

Let's not hide this function in pager.c, but make it available to other
callers.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 cache.h  |  1 +
 config.c | 31 +++++++++++++++++++++++++++++++
 pager.c  | 31 -------------------------------
 3 files changed, 32 insertions(+), 31 deletions(-)

diff --git a/cache.h b/cache.h
index 086bd9fa433..973cc23d6d4 100644
--- a/cache.h
+++ b/cache.h
@@ -1801,6 +1801,7 @@ extern int git_config_from_blob_sha1(config_fn_t fn, const char *name,
 				     const unsigned char *sha1, void *data);
 extern void git_config_push_parameter(const char *text);
 extern int git_config_from_parameters(config_fn_t fn, void *data);
+extern void read_early_config(config_fn_t cb, void *data);
 extern void git_config(config_fn_t fn, void *);
 extern int git_config_with_options(config_fn_t fn, void *,
 				   struct git_config_source *config_source,
diff --git a/config.c b/config.c
index 0e9e1ebefc0..8808b132761 100644
--- a/config.c
+++ b/config.c
@@ -1503,6 +1503,37 @@ static void configset_iter(struct config_set *cs, config_fn_t fn, void *data)
 	}
 }
 
+void read_early_config(config_fn_t cb, void *data)
+{
+	git_config_with_options(cb, data, NULL, 1);
+
+	/*
+	 * Note that this is a really dirty hack that does the wrong thing in
+	 * many cases. The crux of the problem is that we cannot run
+	 * setup_git_directory() early on in git's setup, so we have no idea if
+	 * we are in a repository or not, and therefore are not sure whether
+	 * and how to read repository-local config.
+	 *
+	 * So if we _aren't_ in a repository (or we are but we would reject its
+	 * core.repositoryformatversion), we'll read whatever is in .git/config
+	 * blindly. Similarly, if we _are_ in a repository, but not at the
+	 * root, we'll fail to find .git/config (because it's really
+	 * ../.git/config, etc). See t7006 for a complete set of failures.
+	 *
+	 * However, we have historically provided this hack because it does
+	 * work some of the time (namely when you are at the top-level of a
+	 * valid repository), and would rarely make things worse (i.e., you do
+	 * not generally have a .git/config file sitting around).
+	 */
+	if (!startup_info->have_repository) {
+		struct git_config_source repo_config;
+
+		memset(&repo_config, 0, sizeof(repo_config));
+		repo_config.file = ".git/config";
+		git_config_with_options(cb, data, &repo_config, 1);
+	}
+}
+
 static void git_config_check_init(void);
 
 void git_config(config_fn_t fn, void *data)
diff --git a/pager.c b/pager.c
index ae796433630..73ca8bc3b17 100644
--- a/pager.c
+++ b/pager.c
@@ -43,37 +43,6 @@ static int core_pager_config(const char *var, const char *value, void *data)
 	return 0;
 }
 
-static void read_early_config(config_fn_t cb, void *data)
-{
-	git_config_with_options(cb, data, NULL, 1);
-
-	/*
-	 * Note that this is a really dirty hack that does the wrong thing in
-	 * many cases. The crux of the problem is that we cannot run
-	 * setup_git_directory() early on in git's setup, so we have no idea if
-	 * we are in a repository or not, and therefore are not sure whether
-	 * and how to read repository-local config.
-	 *
-	 * So if we _aren't_ in a repository (or we are but we would reject its
-	 * core.repositoryformatversion), we'll read whatever is in .git/config
-	 * blindly. Similarly, if we _are_ in a repository, but not at the
-	 * root, we'll fail to find .git/config (because it's really
-	 * ../.git/config, etc). See t7006 for a complete set of failures.
-	 *
-	 * However, we have historically provided this hack because it does
-	 * work some of the time (namely when you are at the top-level of a
-	 * valid repository), and would rarely make things worse (i.e., you do
-	 * not generally have a .git/config file sitting around).
-	 */
-	if (!startup_info->have_repository) {
-		struct git_config_source repo_config;
-
-		memset(&repo_config, 0, sizeof(repo_config));
-		repo_config.file = ".git/config";
-		git_config_with_options(cb, data, &repo_config, 1);
-	}
-}
-
 const char *git_pager(int stdout_is_tty)
 {
 	const char *pager;
-- 
2.12.0.windows.1.7.g94dafc3b124


