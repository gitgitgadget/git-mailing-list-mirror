Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 017DE1F955
	for <e@80x24.org>; Fri, 29 Jul 2016 00:44:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752580AbcG2Aoe (ORCPT <rfc822;e@80x24.org>);
	Thu, 28 Jul 2016 20:44:34 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:34082 "EHLO
	mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752563AbcG2Aob (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2016 20:44:31 -0400
Received: by mail-pf0-f176.google.com with SMTP id p64so26869739pfb.1
        for <git@vger.kernel.org>; Thu, 28 Jul 2016 17:44:31 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=S+vtt8F+9kfDGvWrayQ5cygNwjV/XMfDusTQUA1N+sQ=;
        b=k3bTLsMN9LhEnO3WQCS72JGTsp2tuUK82//l5cwm32liBRtoFJPeiCNkeOPI5GPiQp
         f+zEuevHxgBbVJBS1FKY/7Fh0dgXpk5I42wSaiEs54hifEi4LEZ0g4Zg/4FxKHxhnZuu
         LCCPXisnNTzeU14S3CbFi2NgcqqflgECM9y//GhQogKS8rxHvpRVf7t0xWQYU2M265Og
         U1mUKpYD2bmD3/sMpR1NnjkKhmRRlssH2WjTPYuVv6ScqYIawGHvj+04RyDOGmvshQSI
         iNoUh7xyJnfnqVfHvETp8xnGutIa9BQzpmnk0IKH38tyhV4h+2MbzVbKJ9+4VNa96MJV
         JJFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=S+vtt8F+9kfDGvWrayQ5cygNwjV/XMfDusTQUA1N+sQ=;
        b=Drh0Tp1kvxYpNYeqhglmBJOe02lew481vAECrbqhjmLw974S+c2YZw5M2Kmgbm87Cr
         M+xUkSaVaoYhzFpc+H1lP/Xq3i8GXbU95DPlfqgCtE6xeEQLchiHPDL51vIMBcDI9W7s
         1Dp0EI19DEFmq575CDycpHke5HhT+LqEoltpFfTnAE7xUL3+HCuhk3A1UQtUEmcnefyb
         7bDDPg5+Dksp1s+KoeBQrQ7K/tYWZ4iwKe6QP8Apc4AhDq0vgOExWSn/lKUWKXO8YpWt
         xZ5KH2cR89S1SogbdYL1JRTQzxrX9OIskTd8R4pkVW80r/sccg8tCqZ2HOpiKpaYa0m5
         rJQA==
X-Gm-Message-State: AEkooutBeuAhCPo1WcJqU6rLCQ+DSWG4YD9HGy/ZY23AwTZLmi0lH79GI4Gves5zXl6lDONL
X-Received: by 10.98.106.65 with SMTP id f62mr63453697pfc.107.1469753065711;
        Thu, 28 Jul 2016 17:44:25 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:6dbf:17d9:7b5c:47ec])
        by smtp.gmail.com with ESMTPSA id h66sm19819456pfe.58.2016.07.28.17.44.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 28 Jul 2016 17:44:25 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org, Jens.Lehmann@web.de, apenwarr@gmail.com,
	jrnieder@gmail.com, Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 6/7] submodule--helper: add remote-branch helper
Date:	Thu, 28 Jul 2016 17:44:08 -0700
Message-Id: <20160729004409.2072-7-sbeller@google.com>
X-Mailer: git-send-email 2.9.2.472.g1ffb07c.dirty
In-Reply-To: <20160729004409.2072-1-sbeller@google.com>
References: <20160729004409.2072-1-sbeller@google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

In a later patch we want to enhance the logic for the branch selection.
Rewrite the current logic to be in C, so we can directly use C when
we enhance the logic.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c | 28 +++++++++++++++++++++++++++-
 git-submodule.sh            |  2 +-
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index fb90c64..710048f 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -899,6 +899,31 @@ static int resolve_relative_path(int argc, const char **argv, const char *prefix
 	return 0;
 }
 
+static const char *remote_submodule_branch(const char *path)
+{
+	const struct submodule *sub;
+	gitmodules_config();
+	git_config(submodule_config, NULL);
+
+	sub = submodule_from_path(null_sha1, path);
+	if (!sub->branch)
+		return "master";
+
+	return sub->branch;
+}
+
+static int resolve_remote_submodule_branch(int argc, const char **argv,
+		const char *prefix)
+{
+	struct strbuf sb = STRBUF_INIT;
+	if (argc != 2)
+		die("submodule--helper remote-branch takes exactly one arguments, got %d", argc);
+
+	printf("%s", remote_submodule_branch(argv[1]));
+	strbuf_release(&sb);
+	return 0;
+}
+
 struct cmd_struct {
 	const char *cmd;
 	int (*fn)(int, const char **, const char *);
@@ -912,7 +937,8 @@ static struct cmd_struct commands[] = {
 	{"relative-path", resolve_relative_path},
 	{"resolve-relative-url", resolve_relative_url},
 	{"resolve-relative-url-test", resolve_relative_url_test},
-	{"init", module_init}
+	{"init", module_init},
+	{"remote-branch", resolve_remote_submodule_branch}
 };
 
 int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
diff --git a/git-submodule.sh b/git-submodule.sh
index 0d4021f..1e493a8 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -616,7 +616,7 @@ cmd_update()
 
 		if test -n "$remote"
 		then
-			branch=$(get_submodule_config "$name" branch master)
+			branch=$(git submodule--helper remote-branch "$sm_path")
 			if test -z "$nofetch"
 			then
 				# Fetch remote before determining tracking $sha1
-- 
2.9.2.472.g1ffb07c.dirty

