Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E0492013E
	for <e@80x24.org>; Fri,  3 Mar 2017 02:04:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751578AbdCCCEZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Mar 2017 21:04:25 -0500
Received: from mout.gmx.net ([212.227.15.15]:54749 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751529AbdCCCEX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2017 21:04:23 -0500
Received: from virtualbox ([89.204.153.4]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MPUlV-1cfVqa3OiX-004j7V; Fri, 03
 Mar 2017 03:04:17 +0100
Date:   Fri, 3 Mar 2017 03:04:15 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>
Subject: [PATCH v2 4/9] Export the discover_git_directory() function
In-Reply-To: <cover.1488506615.git.johannes.schindelin@gmx.de>
Message-ID: <0ca4cce042cc0b0f13f87363b70a3689057ae9b0.1488506615.git.johannes.schindelin@gmx.de>
References: <cover.1481211338.git.johannes.schindelin@gmx.de> <cover.1488506615.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Wjt99r/oicevpk4YVE9Sftwgdu9YlbQfQrug6yvhfJ94CoZmovM
 bRsAABXDMiMn8RJrYydmDCPGpSktRJNyv+Vb9XPaMe2CGl8dR9v6k9UPeERyHmekyZYvt+/
 XWK7IlAYay+hjwvnziW4O8H3hNN/epfeCZpIxVcIowqUqTu/Rv9oa8x28Che3QPpfDH7Ftm
 AyRrgJhDuka+ukNmYLJiw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8GyVMnRAzkQ=:NYZxzsyKwqK3lGnOyJYZli
 E51lOzWjBVB44/LVw/FcQY/PMQwDC8rZutUGD42DJ3wZfm3T+hj0xTaNcA2Go/ib9g/Dce+9f
 a3U3Fq5yBn2+lHG1dYb9O99sQn0bB2C6k5uKLXX/KZ1wMjVa+sJ+6mCYLmJNysh2gFNP6B9NJ
 GpQMSBDkLQejb3tlCDz8O/jySoxga735bw4bgbVCcGxHyiqXR35mzPxvqLe92Pp6r03+sYlu0
 hhOWIbalJ5cJ21G1xv1UbKpNNdoCFTjRYascv/wth+3JONSsUkcdPMrywtHk9KKF5Xhhz1hR2
 Y16DbMBnVGpPYBXuxGdXurK6IuHwmKJz0P0IGyQe4/Zvr3zc1KzguWW2KYA38nvV9OX+bkBh4
 uqlESh2Stm3hvFnYMItJJJVOW17Q6rng7797hxBEeG8HGycURN0gHMIKbJi+XFfuPyo9kNr5o
 qKm8XiVVf/AJ4KzK8VQ+blolgZSqwuahhqlj8kG/4kSlnFo23dSh4dBThxUhqiCe1syReRtk/
 vD18eGNiI/NR5Mc1UdSmWL6rpQMoRgqa66T6cgVEJfwDn4U6LRjT4S2lIF3ItFgM0MJcyywKW
 gtzVYUsyxSgi1VWxkl1A7Ip9SduO/liz2tfSYjGJ4xiTEfSsGIFXkOdeoY+L+F86Hh3jMthsk
 /YZsyAUBUOqB2ycbhhuw3Ghz4AG2vwDCjdRCx95KDKdrq5LiND+SCXUZY25OPzZxhRLvCa3G/
 cHxrEav68SoZ9k/T/Lv1wMtTwes5BmSTcztZj7QMt+o/vBdj5f+N/MTh989/72EWm7NSI2csr
 fksaxnz
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The function we introduced earlier needs to return both the path to the
.git/ directory as well as the "cd-up" path to allow
setup_git_directory() to retain its previous behavior as if it changed
the current working directory on its quest for the .git/ directory.

Let's rename it and export a function with an easier signature that
*just* discovers the .git/ directory.

We will use it in a subsequent patch to support early config reading
better.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 cache.h |  1 +
 setup.c | 29 ++++++++++++++++++++++++++---
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index 80b6372cf76..a104b76c02e 100644
--- a/cache.h
+++ b/cache.h
@@ -518,6 +518,7 @@ extern void set_git_work_tree(const char *tree);
 #define ALTERNATE_DB_ENVIRONMENT "GIT_ALTERNATE_OBJECT_DIRECTORIES"
 
 extern void setup_work_tree(void);
+extern const char *discover_git_directory(struct strbuf *gitdir);
 extern const char *setup_git_directory_gently(int *);
 extern const char *setup_git_directory(void);
 extern char *prefix_path(const char *prefix, int len, const char *path);
diff --git a/setup.c b/setup.c
index edac3c27dc1..7ceca6cc6ef 100644
--- a/setup.c
+++ b/setup.c
@@ -839,8 +839,8 @@ enum discovery_result {
  * the discovered .git/ directory, if any. This path may be relative against
  * `dir` (i.e. *not* necessarily the cwd).
  */
-static enum discovery_result discover_git_directory(struct strbuf *dir,
-						    struct strbuf *gitdir)
+static enum discovery_result discover_git_directory_1(struct strbuf *dir,
+						      struct strbuf *gitdir)
 {
 	const char *env_ceiling_dirs = getenv(CEILING_DIRECTORIES_ENVIRONMENT);
 	struct string_list ceiling_dirs = STRING_LIST_INIT_DUP;
@@ -921,6 +921,29 @@ static enum discovery_result discover_git_directory(struct strbuf *dir,
 	}
 }
 
+const char *discover_git_directory(struct strbuf *gitdir)
+{
+	struct strbuf dir = STRBUF_INIT;
+	int len;
+
+	if (strbuf_getcwd(&dir))
+		return NULL;
+
+	len = dir.len;
+	if (discover_git_directory_1(&dir, gitdir) < 0) {
+		strbuf_release(&dir);
+		return NULL;
+	}
+
+	if (dir.len < len && !is_absolute_path(gitdir->buf)) {
+		strbuf_addch(&dir, '/');
+		strbuf_insert(gitdir, 0, dir.buf, dir.len);
+	}
+	strbuf_release(&dir);
+
+	return gitdir->buf;
+}
+
 const char *setup_git_directory_gently(int *nongit_ok)
 {
 	struct strbuf cwd = STRBUF_INIT, dir = STRBUF_INIT, gitdir = STRBUF_INIT;
@@ -947,7 +970,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
 		die_errno(_("Unable to read current working directory"));
 	strbuf_addbuf(&dir, &cwd);
 
-	switch (discover_git_directory(&dir, &gitdir)) {
+	switch (discover_git_directory_1(&dir, &gitdir)) {
 	case GIT_DIR_NONE:
 		prefix = NULL;
 		break;
-- 
2.12.0.windows.1.3.g8a117c48243


