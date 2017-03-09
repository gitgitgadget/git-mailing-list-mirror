Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3E31202F8
	for <e@80x24.org>; Thu,  9 Mar 2017 22:25:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753846AbdCIWZI (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 17:25:08 -0500
Received: from mout.gmx.net ([212.227.17.22]:60186 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752823AbdCIWZH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 17:25:07 -0500
Received: from virtualbox ([37.201.193.18]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M1RHp-1bx2Ir25W5-00tPqs; Thu, 09
 Mar 2017 23:24:56 +0100
Date:   Thu, 9 Mar 2017 23:24:55 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v5 06/11] Make read_early_config() reusable
In-Reply-To: <cover.1489098170.git.johannes.schindelin@gmx.de>
Message-ID: <79d52d2a0ba5a120fa5f2e4cc973513a75b2679d.1489098170.git.johannes.schindelin@gmx.de>
References: <cover.1488897111.git.johannes.schindelin@gmx.de> <cover.1489098170.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:IkAcVIOSKkuoFwwypsjJgYMQUWX2xumUOcMwbZnqSxUqInqDBdG
 2OE1RegEIIMpxkK01qrDg8zANxQq5aS/p1W+rmW9Mwx+c2XC3rjWcT3I6LwSCqf0A2MDqEk
 RIIWnwpkiPKezdXVjYu5Bbm48SPRnxnYKVFVI5iiCImo8dXjg0TEPQycegWy2QC2Z3WL3zu
 wJc1AS/xvMwtX3RsOJHEA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QsIq+Yy62Kw=:nEyZDIM+4jAAFRwyt5ydrh
 Cg261O78LFUKtWQ1+x9B6GmEyC9yzAponge0zJ1zv/kqh2T+MsUW+APLuRtSMMtdRaPt2jPZ7
 gJbWg/OuCXUZaAQW/l1zA7ZczQdAslaKqD4FwhZWO16egt7heIIB0PKyY4cbtaYTQ2rfN8qFr
 341/xu8lFscHLVUJnIFOYqospebCGSYQJCUCH68AJB0TdAFtbQrPoZ9Mt3Cu+T2WTwXUHk4Nr
 MyKwvagF+xSQ299CkNhXYaA7gWbHQG7iRy2bSYwGZn1b2po/YTCidZ1et8zYxp3PH1GCYLwgi
 U+5kk5RovCaqawd6K4X4BRhS03KlsVtGZnctJ2FcH8HzYJsXm2tQBFNmM3p60P5gwctYdX9pu
 HbQ9Xqoi1GAOlAkmJUPl3HmsRXJyhrt8HLKEGg8Sh8worAMA2OqsuFPda1K3fjGdFyTARKfkZ
 of9kHrbvbcR1+FRIleY2Axcj6tAQpUurkbgYmtKzoreUoQYwb9I2BJFJ+s4esJy811V1lNA2G
 k/gR5XBIcM2J8VJRsUG35Zi4tBBI98xR5mTy0bMpl27Bh7W3AVCyBKy/yuaozLLGmNYYuvly3
 PdIojgTBnfU58UXQ4P33N/V7Qldk0YX9xzaWGCepcr+V/kVFnDsymaOYyLhT/VbDn/N2zl0DO
 YuDrmobYv1iU31upIAb16Wte6MjAWalA32cORZPo0ov4DBYYdKkZGXUaGKr9/L/Mc3VnHEzgD
 /pYYbbCuiss2Qa2RPAAyDCG5+VEUVtrxBfR1e9BwS9h6TyM55ogMzxbhpKBQt/WopTLTjFU11
 A6nYGvf
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
index 5218726cf88..e7b57457e73 100644
--- a/cache.h
+++ b/cache.h
@@ -1804,6 +1804,7 @@ extern int git_config_from_blob_sha1(config_fn_t fn, const char *name,
 				     const unsigned char *sha1, void *data);
 extern void git_config_push_parameter(const char *text);
 extern int git_config_from_parameters(config_fn_t fn, void *data);
+extern void read_early_config(config_fn_t cb, void *data);
 extern void git_config(config_fn_t fn, void *);
 extern int git_config_with_options(config_fn_t fn, void *,
 				   struct git_config_source *config_source,
diff --git a/config.c b/config.c
index c6b874a7bf7..9cfbeafd04c 100644
--- a/config.c
+++ b/config.c
@@ -1412,6 +1412,37 @@ static void configset_iter(struct config_set *cs, config_fn_t fn, void *data)
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


