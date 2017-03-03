Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62D1720133
	for <e@80x24.org>; Fri,  3 Mar 2017 17:33:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752267AbdCCRdz (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 12:33:55 -0500
Received: from mout.gmx.net ([212.227.15.15]:54728 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752232AbdCCRdw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 12:33:52 -0500
Received: from virtualbox ([89.204.154.17]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MWCgz-1clp8K0zEX-00XLhr; Fri, 03
 Mar 2017 18:33:21 +0100
Date:   Fri, 3 Mar 2017 18:33:20 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>
Subject: [PATCH v3 6/9] Make read_early_config() reusable
In-Reply-To: <cover.1488562287.git.johannes.schindelin@gmx.de>
Message-ID: <e3819700196bba4916fd39c5354eb5135874b8c0.1488562287.git.johannes.schindelin@gmx.de>
References: <cover.1488506615.git.johannes.schindelin@gmx.de> <cover.1488562287.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:w/xaQlyZEVXH0opnslNBD8KF8vSuCGf1ZmDdioO8LsG4qJChV4G
 lho9Y6KNpg68tBCr/RavfnjTWwfYqp3z+bx0zeSAdIOhinhckWNc/hoWNDjvzEFInGmiAF8
 cVy3CRKFJ7jnqf7e73ljvyQjs1uVxJue0Ov48k6X/Dic6ZVhWwgc3fdWKqKrH6K00HV6owQ
 lghiRy1hJxID1PeRg+AzQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:g7l3yvmWzs4=:1/T2wcPHfcmS2kMpDJo+6S
 1PO1Hy+A/7DJEQf4P2RuxcT7zSirCZvC8nU++vCRRG4seE55KLSQfXgmd1Y1yx5teu1wjRv6X
 Tna8i/oHL2Cq1IGpAsMt11xHrdEA5b9oMUQeD3L/JiKHnYZNp8V7qLn8/naEtQus+dHwTHkoT
 R/Y01M2Ty3of3KSJanKhOCfBWCoaHnKF3O4HsONWP0ou1hB0fcOvAi7xMozkKseDI1++gP3eM
 6UkRmO3evhvaRFWQtALsWF5jFwK/aQw28Bt1Ze0vFt7QxfY+KqQpWmrU6U1XSp6NcuXzy4gIS
 SP0yop6ykGopUMQseJe3Vk4B29D6xIUf6fUe7WdoYK88wUrv1pCw42JrHP4p29uUJVw80YrCM
 L2WJKZKh8la0OiXzFdcgBRK9i1HKOmh9fCJa2zc2zunK2HlUIZ4q8q2rktt+iY/mNxa9HFKaq
 qScV3FoG0KdpD/lvcNPCsk9Ey9RjlaoqH7Yrom2SkeYsh2bixd77HaOlg/Jpq0aoTNojh5kD/
 uyf7wH39PKRfhNyw22IzYxs6s2UXdJG5EdJ9fbP52xX7/sFHS25v6F+LDnPjOdbZDzhXbUEb5
 9gtErHsw3R9AE+Q6TO3sW+1Mzt7RpSSXzE+ze/wdpEvLKJh9vlyCjG2WvJr0adyhU0iOvUM+N
 9RxS71+/163rUxIBZwD8VqGTfQvTidL0adXk7WymREMAxFeU03hlCWf3z/DB8BLNoLi1k6pz2
 s7dFfSoOtU4VQRxO/AAtbIS07Af290HKUm4OGMTxKXvEs6VRpBdz8BFzad1Rg5zojTawxaSLR
 /9xG7S2
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
index 4d8eb38de74..8a4580f921d 100644
--- a/cache.h
+++ b/cache.h
@@ -1799,6 +1799,7 @@ extern int git_config_from_blob_sha1(config_fn_t fn, const char *name,
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


