Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83AC120133
	for <e@80x24.org>; Fri,  3 Mar 2017 17:33:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752261AbdCCRdv (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 12:33:51 -0500
Received: from mout.gmx.net ([212.227.17.21]:63814 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752243AbdCCRdu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 12:33:50 -0500
Received: from virtualbox ([89.204.154.17]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LaaVn-1c0rMA1Ush-00mMc7; Fri, 03
 Mar 2017 18:33:17 +0100
Date:   Fri, 3 Mar 2017 18:33:16 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>
Subject: [PATCH v3 5/9] Export the discover_git_directory() function
In-Reply-To: <cover.1488562287.git.johannes.schindelin@gmx.de>
Message-ID: <f84bac1f6c3138347360ec9a8045cec2e979a48e.1488562287.git.johannes.schindelin@gmx.de>
References: <cover.1488506615.git.johannes.schindelin@gmx.de> <cover.1488562287.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:EbVNDadW8l+WJ99Gts0NFUGtgMxtdKKe/+QD10fkk9ythfDJXXL
 KAJV5uuNAqxR66905AtLYD7CG3OHnbOi5SjTxJiwpa1csdiooN+VkCGrlEkDxlnMfREj2HL
 jsVT536MmZr6erzfCdRvRSyBBXByUQv5mK9OenmNVKeaHwgmC4VWHRXclulDzqH8dPqcvVR
 p+TV7SLuXzxyPl1IImIYw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JvGPl71IhzI=:CU//IwYQp4B+75KvGu7kvy
 /LQPMBdOQtNgJYSHK9P/WLY4AKWhmz97oSgjlSPI4p0chVYxhNw8ipL12DSZexRZJjVDBniHV
 beA3FyZiTXIq2CFy47k6zrq/MfuAzcqi3+oiyp8qy0VjEQ7Yvx0TCT831rF27m7Ba8G+xLb6r
 hF5lVeg5Znn8PGhO+rt3xU3CAWyicuR52JDA5fKwzIqh4lIgWDRvKMLjvWmojKEtnOq1XzA37
 OH9SdkB0sPBlg7DJwRLjDYoWS5bg/a1pFOnHfXXT4c00lwhASsC8ljkhn2P49JT7vR6IzEXb4
 afzHs0lcFjEa5d/+5RwTfFBvih94HYTHvdjsaLr+Q4GsCs66lSsU4cSFQUHEEYGW5Z7XKPnp4
 koYjJngMdcxSZ1Nfs961CQgl3Iuvh+Us12So+VEddm/uDRj8zzo8vAT5jWWfnSyMa7HTvZIvc
 XrQhY8IBk4CwEQyxml+k2fFGf2LslTiZCQMjJIKpNfLOZwYJVSnaEnNiAAJtTbNMrlGOiYN+c
 VhlgC/08RuNCF8OqzYNVj67yrHgSs8bFUlF1yjnrSfKAWi86n6ENk4+/51YF/89NxZlHyR/Rw
 9Yr5aeb7evSAtMEvCfvhGwhaW+wiXZz8F13wp/JMStfvHmbbOomKDz+iE3e/mwv7KHiasxY+M
 rF9N9Ik1MP7XaExiUZsnPon4jRPdCEUKeAWz8aCc76kuvvYL2oTd/MRO9eFZ6eiFhb9YfnhC2
 /64FiCr0Q/ysCsW2SHB6z6rVx1WX7KKGh/HNMVJL3ot1YdqtxQIXwQmNS/5VXTicA340a6zJk
 1w7uWix
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The setup_git_directory_gently_1() function we modified earlier still
needs to return both the path to the .git/ directory as well as the
"cd-up" path to allow setup_git_directory() to retain its previous
behavior as if it changed the current working directory on its quest for
the .git/ directory.

This is a bit cumbersome to use if you only need to figure out the
(possibly absolute) path of the .git/ directory. Let's just provide
a convenient wrapper function with an easier signature that *just*
discovers the .git/ directory.

We will use it in a subsequent patch to support early config reading
better.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 cache.h |  2 ++
 setup.c | 31 +++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/cache.h b/cache.h
index 80b6372cf76..4d8eb38de74 100644
--- a/cache.h
+++ b/cache.h
@@ -518,6 +518,8 @@ extern void set_git_work_tree(const char *tree);
 #define ALTERNATE_DB_ENVIRONMENT "GIT_ALTERNATE_OBJECT_DIRECTORIES"
 
 extern void setup_work_tree(void);
+/* Find GIT_DIR without changing the working directory or other global state */
+extern const char *discover_git_directory(struct strbuf *gitdir);
 extern const char *setup_git_directory_gently(int *);
 extern const char *setup_git_directory(void);
 extern char *prefix_path(const char *prefix, int len, const char *path);
diff --git a/setup.c b/setup.c
index 9a09bb41ab5..32ce023638a 100644
--- a/setup.c
+++ b/setup.c
@@ -923,6 +923,37 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
 	}
 }
 
+const char *discover_git_directory(struct strbuf *gitdir)
+{
+	struct strbuf dir = STRBUF_INIT;
+	size_t gitdir_offset = gitdir->len, cwd_len;
+
+	if (strbuf_getcwd(&dir))
+		return NULL;
+
+	cwd_len = dir.len;
+	if (setup_git_directory_gently_1(&dir, gitdir) < 0) {
+		strbuf_release(&dir);
+		return NULL;
+	}
+
+	/*
+	 * The returned gitdir is relative to dir, and if dir does not reflect
+	 * the current working directory, we simply make the gitdir absolute.
+	 */
+	if (dir.len < cwd_len && !is_absolute_path(gitdir->buf + gitdir_offset)) {
+		/* Avoid a trailing "/." */
+		if (!strcmp(".", gitdir->buf + gitdir_offset))
+			strbuf_setlen(gitdir, gitdir_offset);
+		else
+			strbuf_addch(&dir, '/');
+		strbuf_insert(gitdir, gitdir_offset, dir.buf, dir.len);
+	}
+	strbuf_release(&dir);
+
+	return gitdir->buf;
+}
+
 const char *setup_git_directory_gently(int *nongit_ok)
 {
 	struct strbuf cwd = STRBUF_INIT, dir = STRBUF_INIT, gitdir = STRBUF_INIT;
-- 
2.12.0.windows.1.7.g94dafc3b124


