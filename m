Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B000120966
	for <e@80x24.org>; Thu, 30 Mar 2017 15:54:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934291AbdC3Pyo (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 11:54:44 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:34613 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934235AbdC3Pyk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2017 11:54:40 -0400
Received: by mail-qt0-f194.google.com with SMTP id x35so6746243qtc.1
        for <git@vger.kernel.org>; Thu, 30 Mar 2017 08:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vrtp92IiO6HvZcBG04DCdYQ7S15jEyEibLTl3CQK80Q=;
        b=tHFIED0gz5EpgIZXwccMSQTk9ficZDRnZPGHVswqVn+eyTnDjh8Q2VKEbY9mqtVzbl
         ge2AJobPDJJLKZm3JJdNykHd7PzjkCOFR0ipk8uhZ5ARM3Wo7VQ6bCxTLLCBnQc1KmCu
         5CkDwutaJktmhHmlffqdBOxEoOXxwUp6EsGgRxq+Lk4vY2lXb4Y6UBFqZOBQS4jU1Coz
         3Pq0hdI/b82hHmwxszWIeyLtel+HfswaB0Tdylv1HSBjWi2F2AFGd179/L6b3j+anKS2
         rcsKTLcmrCxPmjwHqkK6eMJrq2HH+G5rD+2huToDG08BwDf50uGn2R5BXMDsqTkSifmt
         XX4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vrtp92IiO6HvZcBG04DCdYQ7S15jEyEibLTl3CQK80Q=;
        b=iJP7LBMRL4JBo7Bk97YfF88loRH1YtKlKu2A7nk58DGh1aRLy6DuKEHeZBlC4tGAwb
         /MMslzEGhZ7bMjvdu24FRIdMypAjJCnppfXzw28/P41SHBTKVU/xHzybhqhw+/5yVgTE
         FvocBPh9EqGDiT8XvxfXj7P3qQ3xZgaSMfNJ9fzyhZISxMYvZ5TIv50QAAKYKfumtI+y
         GeT3O5EQ9npycmy0jgBjwJ9m96qejnCcDLiAXsq2zcExakaHlZZmf18qOCzsu4WJiNJ7
         D6X6zI90mGr8WhOHLx7xKX/v5cZh+APdjxGvfNxfkdE51clnnwLN4kGr/tSPkNQubVhP
         Eryw==
X-Gm-Message-State: AFeK/H13XmGQO9PvgBg/dEzMxo4Yav7MucLnAD4NgmhPh5qJ/Ju8M0yBxNg+30OrVgYchw==
X-Received: by 10.237.33.137 with SMTP id l9mr452426qtc.157.1490889273604;
        Thu, 30 Mar 2017 08:54:33 -0700 (PDT)
Received: from localhost.localdomain ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id k5sm1665671qtb.12.2017.03.30.08.54.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 30 Mar 2017 08:54:33 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
X-Google-Original-From: Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, benpeart@microsoft.com,
        christian.couder@gmail.com, larsxschneider@gmail.com
Subject: [PATCH v4 5/8] convert: Update generic functions to only use generic data structures
Date:   Thu, 30 Mar 2017 11:54:14 -0400
Message-Id: <20170330155417.8928-7-benpeart@microsoft.com>
X-Mailer: git-send-email 2.12.1.gvfs.1.18.ge47db72
In-Reply-To: <20170330155417.8928-1-benpeart@microsoft.com>
References: <20170330155417.8928-1-benpeart@microsoft.com>
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
2.12.1.gvfs.1.18.ge47db72

