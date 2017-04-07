Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9BF320966
	for <e@80x24.org>; Fri,  7 Apr 2017 12:04:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933536AbdDGMEs (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Apr 2017 08:04:48 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:33188 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933497AbdDGMEp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2017 08:04:45 -0400
Received: by mail-yw0-f194.google.com with SMTP id p77so4758754ywg.0
        for <git@vger.kernel.org>; Fri, 07 Apr 2017 05:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5bHNyTeyi06ITivoaBOscBoM5gnaTAYQPEXTexqsYMg=;
        b=A5l0IcWJlmcWeg/IZpcyW2So9AXeyAyil+U284HqpsYcn+D7OkN7Yzry1yponeWzmQ
         4WFNsvTyZm2uqJLsypJwEm2el1TmQNNNgkCi5/WSWyNBIAyIu1kBAXnwTCAXg9g1tf1/
         DeXIAwhki5Z2IhJPGv8xugDgwLRlt/eNz5j9L8qW5x4upKD1YAagqrCuWA6vLPc+dhk2
         mJQnVmk4166ea6D1XQRtxYugqKCNOqDpZmvOnHsyAQz3h3GOVE6XTmQvNV4GcbGB0HAi
         xK/MWwds5Nnd7i+V1F4NX0m6xbFr7jtbDy6KhaASUIgvIZR+M6wGcPxhlaFGM3A6FRlD
         uVhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5bHNyTeyi06ITivoaBOscBoM5gnaTAYQPEXTexqsYMg=;
        b=ZcxEpBGCDTobT9n2Dn6YBXznfJu2MVh/YmmFXTndotZE/dADw2K//OAa4xa5E5ajp7
         mn10D+UWqo0d/qmn6TJ7ointwByTMj3bJlbxz4Arpi3H2ElpinoSCS7uzKiDE2ycZz60
         lZ+QgJn/dkiOSbVezzMG5BC+0iKcpTzDx0ag8jaV5po/IqBYu0yvRc7Upi2ShMKU0FVR
         XnZXnwOLFhQqKjtqASOMSG88wt6JeQbyXuqrPMDgR/ljh9q2nqgSp9yIH4QEIjsuTDfz
         P/xk7gxKcWYZ3JkJa5xolUST52QcYc4qL2sOzFuzfH0hw1fPk8OWNQG9Wsjd2p4fZt6B
         IG2g==
X-Gm-Message-State: AFeK/H034xxqnnABDiM6ZHO3o/1NU8onZO8v329otqf4wZKlt3UzRncTbZ35KaA6VWXdLg==
X-Received: by 10.129.173.1 with SMTP id l1mr26566903ywh.311.1491566669258;
        Fri, 07 Apr 2017 05:04:29 -0700 (PDT)
Received: from localhost.localdomain ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id z194sm1874038ywg.73.2017.04.07.05.04.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 07 Apr 2017 05:04:28 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
X-Google-Original-From: Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, benpeart@microsoft.com,
        christian.couder@gmail.com, larsxschneider@gmail.com
Subject: [PATCH v5 5/8] convert: Update generic functions to only use generic data structures
Date:   Fri,  7 Apr 2017 08:03:51 -0400
Message-Id: <20170407120354.17736-6-benpeart@microsoft.com>
X-Mailer: git-send-email 2.12.0.windows.1.33.g243d9b384c
In-Reply-To: <20170407120354.17736-1-benpeart@microsoft.com>
References: <20170407120354.17736-1-benpeart@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Update all functions that are going to be moved into a reusable module
so that they only work with the reusable data structures.  Move code
that is specific to the filter out into the filter specific functions.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 convert.c | 46 ++++++++++++++++++++++++++++------------------
 1 file changed, 28 insertions(+), 18 deletions(-)

diff --git a/convert.c b/convert.c
index f569026511..747c0c363b 100644
--- a/convert.c
+++ b/convert.c
@@ -576,14 +576,15 @@ static void stop_multi_file_filter(struct child_process *process)
 	finish_command(process);
 }
 
-static int start_multi_file_filter_fn(struct cmd2process *entry)
+static int start_multi_file_filter_fn(struct subprocess_entry *subprocess)
 {
 	int err;
+	struct cmd2process *entry = (struct cmd2process *)subprocess;
 	struct string_list cap_list = STRING_LIST_INIT_NODUP;
 	char *cap_buf;
 	const char *cap_name;
-	struct child_process *process = &entry->subprocess.process;
-	const char *cmd = entry->subprocess.cmd;
+	struct child_process *process = &subprocess->process;
+	const char *cmd = subprocess->cmd;
 
 	sigchain_push(SIGPIPE, SIG_IGN);
 
@@ -638,17 +639,21 @@ static int start_multi_file_filter_fn(struct cmd2process *entry)
 	return err;
 }
 
-static struct cmd2process *start_multi_file_filter(const char *cmd)
+typedef int(*subprocess_start_fn)(struct subprocess_entry *entry);
+int start_multi_file_filter(struct subprocess_entry *entry, const char *cmd,
+	subprocess_start_fn startfn)
 {
 	int err;
-	struct cmd2process *entry;
 	struct child_process *process;
 	const char *argv[] = { cmd, NULL };
 
-	entry = xmalloc(sizeof(*entry));
-	entry->subprocess.cmd = cmd;
-	entry->supported_capabilities = 0;
-	process = &entry->subprocess.process;
+	if (!cmd_process_map_initialized) {
+		cmd_process_map_initialized = 1;
+		hashmap_init(&cmd_process_map, (hashmap_cmp_fn)cmd2process_cmp, 0);
+	}
+
+	entry->cmd = cmd;
+	process = &entry->process;
 
 	child_process_init(process);
 	process->argv = argv;
@@ -658,22 +663,23 @@ static struct cmd2process *start_multi_file_filter(const char *cmd)
 	process->clean_on_exit = 1;
 	process->clean_on_exit_handler = stop_multi_file_filter;
 
-	if (start_command(process)) {
+	err = start_command(process);
+	if (err) {
 		error("cannot fork to run external filter '%s'", cmd);
-		return NULL;
+		return err;
 	}
 
 	hashmap_entry_init(entry, strhash(cmd));
 
-	err = start_multi_file_filter_fn(entry);
+	err = startfn(entry);
 	if (err) {
 		error("initialization for external filter '%s' failed", cmd);
-		kill_multi_file_filter(&entry->subprocess);
-		return NULL;
+		kill_multi_file_filter(entry);
+		return err;
 	}
 
 	hashmap_add(&cmd_process_map, entry);
-	return entry;
+	return 0;
 }
 
 static int apply_multi_file_filter(const char *path, const char *src, size_t len,
@@ -692,9 +698,13 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
 	fflush(NULL);
 
 	if (!entry) {
-		entry = start_multi_file_filter(cmd);
-		if (!entry)
+		entry = xmalloc(sizeof(*entry));
+		entry->supported_capabilities = 0;
+
+		if (start_multi_file_filter(&entry->subprocess, cmd, start_multi_file_filter_fn)) {
+			free(entry);
 			return 0;
+		}
 	}
 	process = &entry->subprocess.process;
 
@@ -767,7 +777,7 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
 			 * Force shutdown and restart if another blob requires filtering.
 			 */
 			error("external filter '%s' failed", cmd);
-			kill_multi_file_filter(&entry->subprocess);
+			kill_multi_file_filter((struct subprocess_entry *)entry);
 		}
 	} else {
 		strbuf_swap(dst, &nbuf);
-- 
2.12.0.windows.1.31.g1548525701.dirty

