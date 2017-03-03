Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BB9E2013E
	for <e@80x24.org>; Fri,  3 Mar 2017 02:04:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751649AbdCCCEm (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Mar 2017 21:04:42 -0500
Received: from mout.gmx.net ([212.227.15.18]:63830 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751639AbdCCCEl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2017 21:04:41 -0500
Received: from virtualbox ([89.204.153.4]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MZCUG-1d02T71tAC-00KzH0; Fri, 03
 Mar 2017 03:04:25 +0100
Date:   Fri, 3 Mar 2017 03:04:24 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>
Subject: [PATCH v2 6/9] read_early_config(): special-case builtins that create
 a repository
In-Reply-To: <cover.1488506615.git.johannes.schindelin@gmx.de>
Message-ID: <33e692918c8d41507de5ec2b2e2d55982678408e.1488506615.git.johannes.schindelin@gmx.de>
References: <cover.1481211338.git.johannes.schindelin@gmx.de> <cover.1488506615.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:a/tmeYod9XEAllMhwl8e1Kyi1MfNdQip6VA/R3emfwTAJja4Kac
 cM8l9sOrsUm7MG2X5uNGNNW4H87FqEnil99b7HVvar49oodJ8uKsR70s7jDItqkS2QxYZIX
 FG/Z/15salmjQp7kKKi6sVMWoQ4EqBGn3REOCXKinq622oaSX59WsFcAZ/DoaX+Pvf2nhUb
 e8GOMKcsVlU/m7cZMif+g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ea2DVLtyfp8=:6DzYvJN3EbLOUbqJ2yQ+hF
 3W+YwCBCOE8ycEAVTQUOoq5FTXcD2V7dLYTu3h7H+XD7eVn0RzKeCbqKegFw2g6sALn1A3x2k
 C31vCEm7fciwYRPRT2u7+OzDFKnEqZBqT/szu4rXRpzThh4D1amwI6XsdtwhE657XgGiC8kPb
 J+FaGKM78obb79JgWjz5kgLQfKk4Sm1MBkKibqEC6imJbvdsN9OhYFa98/NQeo4ci3+thvtGC
 AIikc2fGX7t9r9aHXbWPDdxIp4ai6Za1jscqUV7xhHHnhSWzlc4+QvH0lpr8jiRZ6iAeVLsya
 HJIXrqMoZi8c9AiOl2TOvzFa2w1kSa2LEAYsKVDx5QHf8vvZOE+oFVnXbJst2Al0M7G2uAgwu
 6Znx/ll6rH9JaxNRPmf7hKp02qYiAEiDf8qEGzTy0u5wh/iZfQ2gZbyc+R7lolEh0jj77n5KI
 5CZHlAgDN2HCNJ2W8z0VkoBSuoz/SsZpVu4nsw7nv4RoYZ7tBgISrLOo3Zk4S5y0fPv7di3CP
 75P+rtm1JOc9VtzdKRdvlTWy4xnqZG6v3TS1kcgmWBin2PZI3zTF57DD4jGn8Psqf1UQSjL6b
 4LhWnYZiARrJ3cFu709tUa3H7gBfi8k9/UEN1mTQjwR1vdF6KkjZRO1LKBvia+M2UvJmuP3Ex
 tBQO/ACZ6jNW1KON5iYWYCO0SHdMdwDG0vNgnNNE3Vk+pDZTJz3rZzkeshloCkjjjC/cLIxG/
 fqnME6Y8BnUF/wO/8itT0bK/v8vLkI57oGnE3W68o+md5b+BO1yOWUHKCNZQRD5AjN3rMkteT
 vHS4Nul
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the command we are about to execute wants to create a repository
(i.e. the command is `init` or `clone`), we *must not* look for a
repository config.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 cache.h  | 2 +-
 config.c | 3 ++-
 git.c    | 3 +++
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index 6b6780064f0..0af7141242f 100644
--- a/cache.h
+++ b/cache.h
@@ -2070,7 +2070,7 @@ const char *split_cmdline_strerror(int cmdline_errno);
 
 /* setup.c */
 struct startup_info {
-	int have_repository;
+	int have_repository, creating_repository;
 	const char *prefix;
 };
 extern struct startup_info *startup_info;
diff --git a/config.c b/config.c
index 9cfbeafd04c..980fcc6ff2e 100644
--- a/config.c
+++ b/config.c
@@ -1434,7 +1434,8 @@ void read_early_config(config_fn_t cb, void *data)
 	 * valid repository), and would rarely make things worse (i.e., you do
 	 * not generally have a .git/config file sitting around).
 	 */
-	if (!startup_info->have_repository) {
+	if (!startup_info->creating_repository &&
+	    !startup_info->have_repository) {
 		struct git_config_source repo_config;
 
 		memset(&repo_config, 0, sizeof(repo_config));
diff --git a/git.c b/git.c
index 33f52acbcc8..9fb9bb90a21 100644
--- a/git.c
+++ b/git.c
@@ -337,6 +337,9 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 	struct stat st;
 	const char *prefix;
 
+	if (p->fn == cmd_init_db || p->fn == cmd_clone)
+		startup_info->creating_repository = 1;
+
 	prefix = NULL;
 	help = argc == 2 && !strcmp(argv[1], "-h");
 	if (!help) {
-- 
2.12.0.windows.1.3.g8a117c48243


