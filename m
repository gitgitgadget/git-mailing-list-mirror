Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 178012013E
	for <e@80x24.org>; Fri,  3 Mar 2017 02:04:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751618AbdCCCEd (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Mar 2017 21:04:33 -0500
Received: from mout.gmx.net ([212.227.15.18]:55629 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751610AbdCCCEc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2017 21:04:32 -0500
Received: from virtualbox ([89.204.153.4]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LbuCq-1c2cJV1Noq-00jGPA; Fri, 03
 Mar 2017 03:04:21 +0100
Date:   Fri, 3 Mar 2017 03:04:20 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>
Subject: [PATCH v2 5/9] Make read_early_config() reusable
In-Reply-To: <cover.1488506615.git.johannes.schindelin@gmx.de>
Message-ID: <64135c6df520c1ca6a6e667855ac03c14d2dd153.1488506615.git.johannes.schindelin@gmx.de>
References: <cover.1481211338.git.johannes.schindelin@gmx.de> <cover.1488506615.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:+sYbaDyOitur2MoWl2jkgkTOOyubkN/2UM98OzzOkHM52dCGXGl
 3SfE73XM2rTEXh4Kc9pvm5a3yFRZZEua4WQjXIHuBKzZ06xvBybs+TCZszZau6IWmHKJkCL
 BhWDuPHoaATo8kja7rfO0cXzdg/AzylTj6LqFypjEEeRzrsQI7KjeaCPN0mdCcZvy/SyOen
 RLfqH8F/BoBFRVu8ykI8A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:bFiySBtOiYw=:oOvBlXzCNWsSx3IJ/CwSYR
 0BK1F+0FZWG3uTz+Q0X1XFuxwL4l1Q6/xAtHB63pslP0Btpq82tJJ7F+JY6Rym8xqER3Kf82p
 OlY9OflBvbyN2nMu9NZKXeUsMWHtmIyUz/L8+BW8oDn9amzVd1eG5AD7i1HNTyh0A8D3gjKrt
 jLflzRNu/c6f8BExZCNfV5tYN4JrpceI+TJqfyo5eJKQByssg3etBFy/9oF+yjwJGfRTZmgz8
 spil8gMK5XS3/99Ec1I6U76OUXgoli6SBts6jUDBR5c2Q5MuYZsjECjeRNcGerxD/Q30alkBb
 RxK0cVCC+h+P/sY4Jov2SOqytmmleIqfHVNwrzU1aE8Wgl5Q0jLLdza/PCj4TwMtgTOjIM3NK
 LtHj4uEiZ8Wz6ju2984BFvSe3LtkX1MDJV3IO0JMrYKSVOA/QrnXGYXYuhMaf8lY822QEkPnL
 2AS8E4gUWS6fNnBFtppJbJiML7SuwdQ3mNCn3woMZIkumAD7bGGk2bzONQ0q6WnKxZjJXhnDX
 cEYbDQepVBdkiTIsFGjqBWxPs8XcS7SgjCJRnuGEfhhTS/QDRF2O2LbhR4I96LLMD0d2V5dsu
 t8L8GNLHBpGBqsk5VqXvimcUFORjrNwGB8F5GupIdViYodxSQNbQhY2bXv0mgkyyv/gNNTfdF
 5SN2j8cFw9s6TGdq4SXRhZLs2+zjPrdwgvhTEsJGnxOdbzWeqqOzbJp/+3bhG0HXyO3ab54lu
 9VD/ey6eHA4/Uf+BnhZ3NkTP1PpKcZxg0nH05qh9vfmDWrI5K+hNaTLuvbtSdVtExDnUH2A9A
 XUEWFdZ
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
index a104b76c02e..6b6780064f0 100644
--- a/cache.h
+++ b/cache.h
@@ -1798,6 +1798,7 @@ extern int git_config_from_blob_sha1(config_fn_t fn, const char *name,
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
2.12.0.windows.1.3.g8a117c48243


