Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F8411F405
	for <e@80x24.org>; Wed,  8 Aug 2018 18:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730770AbeHHVUi (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 17:20:38 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:39611 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730552AbeHHVUi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 17:20:38 -0400
Received: by mail-wr1-f42.google.com with SMTP id h10-v6so2926441wre.6
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 11:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=L6Fc307A3jRliiCnByAV70tDdvrq+fdImSwp8T3c1bM=;
        b=EEccGBDf1z7kFWOeoeYktCLJZzg5QShstq/WWe5eozvA1Asjy69PHGMWccZED8R90K
         89pNHV08s6xn44ql2rgTdZnX8deinkXYRaw9ifl/xvUxPZIMeQQONv5u3WZ9CP+1H7MJ
         6QeMiy5D8Ksxt8ol6f2P7pj3+wBRq6VsefT4oa6kSu62m2ThdzEJjIkvTiY4ALPBZV0Q
         UbUg9E76zw+I/TjQPHEt2OI4zdLlk2zOvLlhx6X6MOppP4ngYZcwx5mb7L1vAE0rNItr
         0eMFgZ9cG6ldK7oBDaVMmVOUyVHzDWAAEya5z6J2sVR7XMKEmw2vlsyfCtR0XZMZJcci
         IoCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L6Fc307A3jRliiCnByAV70tDdvrq+fdImSwp8T3c1bM=;
        b=QpdwdbIjZbg/VeoJQneZKlkeS5ZyL2NNdAhiQcSwe5mlb2yxI9bIuvzeK2ubXG3KyQ
         dAX5yCZfHpL8lNOclqv/zijqYX7KMZqH+TGoW7t8pdjjHphUjXCjZdhijThlNzdXbBwa
         x+l8k5sk4MxN0HzINQtlXwq6V+R4QvELlNHa+tICUHsKh/9VOZKPwBdlVY2ScfZX/DEI
         rQbG92R+XuYcJtyZr3VTEw3cQT8Bup/H127ON0HhIieruavBSIwAArKadEvLUhhVnp3l
         JnOvboD5A9U2PIUUb2eOfz4pGRiadObxC96Qfy7Zv3HMueryUqa6/n8YJ1UATFRZ72vi
         +C/g==
X-Gm-Message-State: AOUpUlGF4QFwZHboJTDCnnYWg07G8HXIioM4PPmKyiB0lK2VZBXhnJfw
        UtxuOeQNYynu35gZfBvDq9j8oghh
X-Google-Smtp-Source: AA+uWPyt/K0Bp8yCW/1D0yS2bcdQK7OWVZ6b1w3xas7l2nRelK1hY9b+6yDJMqMNaDTiYmgp3Y6ipw==
X-Received: by 2002:adf:f507:: with SMTP id q7-v6mr2539757wro.241.1533754776062;
        Wed, 08 Aug 2018 11:59:36 -0700 (PDT)
Received: from sebi-laptop.tendawifi.com ([86.127.74.86])
        by smtp.gmail.com with ESMTPSA id p5-v6sm4238879wre.32.2018.08.08.11.59.35
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 11:59:35 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Subject: [GSoC][PATCH v7 21/26] stash: replace spawning `git ls-files` child process
Date:   Wed,  8 Aug 2018 21:59:00 +0300
Message-Id: <3286e8443ed1c8f9560aa6bef01aa18ed78266df.1533753605.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.18.0.573.g56500d98f
In-Reply-To: <cover.1533753605.git.ungureanupaulsebastian@gmail.com>
References: <cover.1533753605.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This commit replaces spawning `git ls-files` child process with
API calls to get the untracked files.
---
 builtin/stash--helper.c | 49 +++++++++++++++++++++++++++--------------
 1 file changed, 32 insertions(+), 17 deletions(-)

diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
index 4fd79532c..5c27f5dcf 100644
--- a/builtin/stash--helper.c
+++ b/builtin/stash--helper.c
@@ -813,27 +813,42 @@ static int store_stash(int argc, const char **argv, const char *prefix)
 /*
  * `out` will be filled with the names of untracked files. The return value is:
  *
- * < 0 if there was a bug (any arg given outside the repo will be detected
- *     by `setup_revision()`)
  * = 0 if there are not any untracked files
  * > 0 if there are untracked files
  */
-static int get_untracked_files(const char **argv, int line_term,
+static int get_untracked_files(const char **argv, const char *prefix,
 			       int include_untracked, struct strbuf *out)
 {
-	struct child_process cp = CHILD_PROCESS_INIT;
-	cp.git_cmd = 1;
-	argv_array_pushl(&cp.args, "ls-files", "-o", NULL);
-	if (line_term)
-		argv_array_push(&cp.args, "-z");
+	int max_len;
+	int i;
+	char *seen;
+	struct dir_struct dir;
+	struct pathspec pathspec;
+
+	memset(&dir, 0, sizeof(dir));
 	if (include_untracked != 2)
-		argv_array_push(&cp.args, "--exclude-standard");
-	argv_array_push(&cp.args, "--");
-	if (argv)
-		argv_array_pushv(&cp.args, argv);
+		setup_standard_excludes(&dir);
 
-	if (pipe_command(&cp, NULL, 0, out, 0, NULL, 0))
-		return -1;
+	parse_pathspec(&pathspec, 0,
+		       PATHSPEC_PREFER_FULL,
+		       prefix, argv);
+	seen = xcalloc(pathspec.nr, 1);
+
+	max_len = fill_directory(&dir, the_repository->index, &pathspec);
+	for (i = 0; i < dir.nr; i++) {
+		struct dir_entry *ent = dir.entries[i];
+		if (!dir_path_match(ent, &pathspec, max_len, seen)) {
+			free(ent);
+			continue;
+		}
+		strbuf_addf(out, "%s\n", ent->name);
+		free(ent);
+	}
+
+	free(dir.entries);
+	free(dir.ignored);
+	clear_directory(&dir);
+	free(seen);
 	return out->len;
 }
 
@@ -888,7 +903,7 @@ static int check_changes(const char **argv, int include_untracked,
 		goto done;
 	}
 
-	if (include_untracked && get_untracked_files(argv, 0,
+	if (include_untracked && get_untracked_files(argv, prefix,
 						     include_untracked, &out))
 		ret = 1;
 
@@ -908,7 +923,7 @@ static int save_untracked_files(struct stash_info *info, struct strbuf *msg,
 	struct child_process cp2 = CHILD_PROCESS_INIT;
 
 	cp.git_cmd = 1;
-	argv_array_pushl(&cp.args, "update-index", "-z", "--add",
+	argv_array_pushl(&cp.args, "update-index", "--add",
 			 "--remove", "--stdin", NULL);
 	argv_array_pushf(&cp.env_array, "GIT_INDEX_FILE=%s",
 			 stash_index_path.buf);
@@ -1134,7 +1149,7 @@ static int do_create_stash(int argc, const char **argv, const char *prefix,
 		goto done;
 	}
 
-	if (include_untracked && get_untracked_files(argv, 1,
+	if (include_untracked && get_untracked_files(argv, prefix,
 						     include_untracked, &out)) {
 		if (save_untracked_files(info, &msg, &out)) {
 			if (!quiet)
-- 
2.18.0.573.g56500d98f

