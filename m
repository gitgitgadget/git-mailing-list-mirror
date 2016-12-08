Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E53C1FBB0
	for <e@80x24.org>; Thu,  8 Dec 2016 15:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932351AbcLHPgY (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 10:36:24 -0500
Received: from mout.gmx.net ([212.227.15.15]:60122 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753779AbcLHPgW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 10:36:22 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MCcja-1cOKOd1UJO-009PJw; Thu, 08
 Dec 2016 16:36:05 +0100
Date:   Thu, 8 Dec 2016 16:36:03 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH/RFC 1/7] Make read_early_config() reusable
In-Reply-To: <cover.1481211338.git.johannes.schindelin@gmx.de>
Message-ID: <fc498e3720358b918977d693eef05132bce00116.1481211338.git.johannes.schindelin@gmx.de>
References: <cover.1481211338.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:ccoZSRfx7/KPSCDB6V/cK3Sq9riDQxpllNmZYBXsSbp7wy+BFp2
 hzOTzYI5Rr8opkf8eN/prg/nMo/MsU/MURLTujB/nrjYfIi5lmKuiqzP9akf+SRmW6oqVR9
 iyLIJvkAqAL7T1lkzET0GgDhun0cCO9fk4DV/7NIplINIufsdB8QzFNAbRbMohUoVX5iNz2
 A7zznG0VJbSti3me0K0pA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:TGue/4twwzE=:0xxivki9dmqJrJ1FpPom1J
 gsccs9HN+Frm5IOZfuBxN1euWLfBxJB1+R/IBKXDToYhnmTvCEBK6J+1dz6nhsuJ7Ygcc6Ow1
 QpWeRjCDVf7fGv3JMV5l5mgUonbWoxdyBZxtP5YI7XFV6nJnl+s8TMEksJcejqiRm0dlDa8R8
 VnGBxFu27RlZhHlbYNy9Wml/Z4my6+jvRs0YcLJRn50MuJihwG4KYB5QQnQacpyuHpHKX1R3h
 jmcqOK6sbzLxGaDT1DyVxWzy+dSDGAAb05EM0BzuV9xDETE+b8GV2+6nh5l4HNXMs1KUfyheS
 cSyhYUoKUUFoq9UYhOFm6P7I6blES0Lry+ZaM/sdTUvoOemLhlJi/xUNYAm1Tp+UXyPS+t8eY
 otWl/sXa7R4MnKYh0ej+DsYPqcMtvaJBhcXeR6c6cXlSEwYJGjjwlnaDiolhqUuyKc7Gq5N7I
 7Qtvv3TrrZInkJSfFCl/7wk74SsGrH3q3qfWKayI1gBpxDpvUazk/Uidw8IlkAohOP1d8jDIE
 nzTJsElnMw8lfKCgAwNi2TC5dKqT6Wn7bdJ6z+zQpskHZNnlmxie2z40KLPDAcz5cW7xDFDBR
 VfyY/k2MN4lZoRh8p9IzZ0ieCTVYQbns2vWF6V7WTVN0o1iBXQJXtqv2B8duVhSst5TcijbF+
 QnpU2swWUDKLUmjJAJcSa5sqBaaK/kDEXBIa9C5waHx9amcmoTzPwZO6pB3S4lAavzH43y1sQ
 +zG+laPDRTts0Z5FaKPRd47TrKEzQCamcM3vfbmnUCrHIJc4zHCiMKdYBcNDgUgAQknK6nVJb
 oePfLvs
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
index a50a61a197..96e0cb2523 100644
--- a/cache.h
+++ b/cache.h
@@ -1692,6 +1692,7 @@ extern int git_config_from_mem(config_fn_t fn, const enum config_origin_type,
 					const char *name, const char *buf, size_t len, void *data);
 extern void git_config_push_parameter(const char *text);
 extern int git_config_from_parameters(config_fn_t fn, void *data);
+extern void read_early_config(config_fn_t cb, void *data);
 extern void git_config(config_fn_t fn, void *);
 extern int git_config_with_options(config_fn_t fn, void *,
 				   struct git_config_source *config_source,
diff --git a/config.c b/config.c
index 83fdecb1bc..7dcd8d8622 100644
--- a/config.c
+++ b/config.c
@@ -1385,6 +1385,37 @@ static void configset_iter(struct config_set *cs, config_fn_t fn, void *data)
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
index ae79643363..73ca8bc3b1 100644
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
2.11.0.rc3.windows.1


