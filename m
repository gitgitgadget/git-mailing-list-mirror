Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E14E720323
	for <e@80x24.org>; Wed, 22 Mar 2017 17:02:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761010AbdCVRB7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 13:01:59 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:34660 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760984AbdCVRBS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 13:01:18 -0400
Received: by mail-qk0-f194.google.com with SMTP id v127so26858015qkb.1
        for <git@vger.kernel.org>; Wed, 22 Mar 2017 10:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3SwImuXz9RuDTianXEVr6vAqxRC6HuvLBMaDNEVmI38=;
        b=pwTOS8lNXwWODlvnf8PxGYtcBHOA+UW4JkQwMJhxFHX1gNfHoAEyIcyrW247AQfmwf
         3Ltra/b1iQ6P+2avqmvFkNymAmK20cQxw2tYJwq5iA+gK2x4rL0hXHUnrHO6+ffJHdI5
         rQj1O4kdPCBay8kDwxTZLjI1hnZ7ICoQG1ZkJHxrZqu1ZXMGyc2xTW4Wrj8UW2Ks0zvl
         /sQsW7m0VPiuZ6bN/UG6izF7NcjD7xOswx5s5BkMIZ+FzeZNnDCrCv6Az9COw5bnB7Q2
         +AEX6COm38X6Ui1Z1kP3Oe4WXMPPng1O6J05ewo81VvqDOvvlkNUG6MxRtN015LJhY0I
         bj2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3SwImuXz9RuDTianXEVr6vAqxRC6HuvLBMaDNEVmI38=;
        b=dvEoMUxLfLm3mzezM62VT+o1MmtQjrJr6iDxGZoRESpabsULVI6PBmkBtU8+vpAu/B
         biBiezzt8lKdb1n/L+6DD1ki9j3kZJNqJ6Uhc0tnofGu0SWwI2psEzS5XrOvdPyvBbKQ
         xC/sGd4mCjxxZSFAnTOz3HsAtf1YkoLOtubqwU99J0y8Mzc9K1MJTHs1pXxDVIOnN4Ue
         64oZfz8CEArq4Bvk3qhbgHutZfGhKPmaibb/SBYl2AK/GN49XjRQfVzOv2sYDYX2jlCU
         QD4R1zJi4DF8mgiXJg+PSXnGDdum2JEkAn1qZcvecrF2rnI6OV/KpvbjTX4OHAgZd+T1
         20HA==
X-Gm-Message-State: AFeK/H0dU1D8lypMe38mclzdZ+nc8SN9QAGBk85+6XMAIP22ZvW9wIO5h0HgaV3C+ExD/A==
X-Received: by 10.233.232.6 with SMTP id a6mr374881qkg.53.1490201638603;
        Wed, 22 Mar 2017 09:53:58 -0700 (PDT)
Received: from localhost.localdomain ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id t47sm1334588qte.45.2017.03.22.09.53.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 22 Mar 2017 09:53:58 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
X-Google-Original-From: Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     benpeart@microsoft.com, christian.couder@gmail.com,
        larsxschneider@gmail.com
Subject: [PATCH v1 3/3] convert: use new sub-process module for filter processes
Date:   Wed, 22 Mar 2017 12:52:20 -0400
Message-Id: <20170322165220.5660-4-benpeart@microsoft.com>
X-Mailer: git-send-email 2.12.0.gvfs.1.42.g0b7328eac2
In-Reply-To: <20170322165220.5660-1-benpeart@microsoft.com>
References: <20170322165220.5660-1-benpeart@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The filter.<driver>.process code was refactored into a separate
sub-process module to facilitate reuse in future patch series. This
centralizes the logic in a single place to simplify maintenance. As a
side benefit, it also improves the readability of convert.c.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 convert.c | 154 ++++++++++----------------------------------------------------
 1 file changed, 24 insertions(+), 130 deletions(-)

diff --git a/convert.c b/convert.c
index 8d652bf27c..ca8e0d26c0 100644
--- a/convert.c
+++ b/convert.c
@@ -4,6 +4,7 @@
 #include "quote.h"
 #include "sigchain.h"
 #include "pkt-line.h"
+#include "sub-process.h"
 
 /*
  * convert.c - convert a file when checking it out and checking it in.
@@ -497,132 +498,30 @@ static int apply_single_file_filter(const char *path, const char *src, size_t le
 #define CAP_SMUDGE   (1u<<1)
 
 struct cmd2process {
-	struct hashmap_entry ent; /* must be the first member! */
+	struct subprocess_entry subprocess;
 	unsigned int supported_capabilities;
-	const char *cmd;
-	struct child_process process;
 };
 
-static int cmd_process_map_initialized;
-static struct hashmap cmd_process_map;
-
-static int cmd2process_cmp(const struct cmd2process *e1,
-			   const struct cmd2process *e2,
-			   const void *unused)
-{
-	return strcmp(e1->cmd, e2->cmd);
-}
-
-static struct cmd2process *find_multi_file_filter_entry(struct hashmap *hashmap, const char *cmd)
-{
-	struct cmd2process key;
-	hashmap_entry_init(&key, strhash(cmd));
-	key.cmd = cmd;
-	return hashmap_get(hashmap, &key, NULL);
-}
-
-static int packet_write_list(int fd, const char *line, ...)
+static int start_multi_file_filter_fn(struct subprocess_entry *subprocess)
 {
-	va_list args;
 	int err;
-	va_start(args, line);
-	for (;;) {
-		if (!line)
-			break;
-		if (strlen(line) > LARGE_PACKET_DATA_MAX)
-			return -1;
-		err = packet_write_fmt_gently(fd, "%s\n", line);
-		if (err)
-			return err;
-		line = va_arg(args, const char*);
-	}
-	va_end(args);
-	return packet_flush_gently(fd);
-}
-
-static void read_multi_file_filter_status(int fd, struct strbuf *status)
-{
-	struct strbuf **pair;
-	char *line;
-	for (;;) {
-		line = packet_read_line(fd, NULL);
-		if (!line)
-			break;
-		pair = strbuf_split_str(line, '=', 2);
-		if (pair[0] && pair[0]->len && pair[1]) {
-			/* the last "status=<foo>" line wins */
-			if (!strcmp(pair[0]->buf, "status=")) {
-				strbuf_reset(status);
-				strbuf_addbuf(status, pair[1]);
-			}
-		}
-		strbuf_list_free(pair);
-	}
-}
-
-static void kill_multi_file_filter(struct hashmap *hashmap, struct cmd2process *entry)
-{
-	if (!entry)
-		return;
-
-	entry->process.clean_on_exit = 0;
-	kill(entry->process.pid, SIGTERM);
-	finish_command(&entry->process);
-
-	hashmap_remove(hashmap, entry, NULL);
-	free(entry);
-}
-
-static void stop_multi_file_filter(struct child_process *process)
-{
-	sigchain_push(SIGPIPE, SIG_IGN);
-	/* Closing the pipe signals the filter to initiate a shutdown. */
-	close(process->in);
-	close(process->out);
-	sigchain_pop(SIGPIPE);
-	/* Finish command will wait until the shutdown is complete. */
-	finish_command(process);
-}
-
-static struct cmd2process *start_multi_file_filter(struct hashmap *hashmap, const char *cmd)
-{
-	int err;
-	struct cmd2process *entry;
+	struct cmd2process *entry = (struct cmd2process *)subprocess;
 	struct child_process *process;
-	const char *argv[] = { cmd, NULL };
 	struct string_list cap_list = STRING_LIST_INIT_NODUP;
 	char *cap_buf;
 	const char *cap_name;
 
-	entry = xmalloc(sizeof(*entry));
-	entry->cmd = cmd;
-	entry->supported_capabilities = 0;
-	process = &entry->process;
-
-	child_process_init(process);
-	process->argv = argv;
-	process->use_shell = 1;
-	process->in = -1;
-	process->out = -1;
-	process->clean_on_exit = 1;
-	process->clean_on_exit_handler = stop_multi_file_filter;
-
-	if (start_command(process)) {
-		error("cannot fork to run external filter '%s'", cmd);
-		return NULL;
-	}
-
-	hashmap_entry_init(entry, strhash(cmd));
+	process = subprocess_get_child_process(&entry->subprocess);
 
 	sigchain_push(SIGPIPE, SIG_IGN);
 
-	err = packet_write_list(process->in, "git-filter-client", "version=2", NULL);
+	err = packet_write_list_gently(process->in, "git-filter-client", "version=2", NULL);
 	if (err)
 		goto done;
 
 	err = strcmp(packet_read_line(process->out, NULL), "git-filter-server");
 	if (err) {
-		error("external filter '%s' does not support filter protocol version 2", cmd);
+		error("external filter '%s' does not support filter protocol version 2", subprocess->cmd);
 		goto done;
 	}
 	err = strcmp(packet_read_line(process->out, NULL), "version=2");
@@ -632,7 +531,7 @@ static struct cmd2process *start_multi_file_filter(struct hashmap *hashmap, cons
 	if (err)
 		goto done;
 
-	err = packet_write_list(process->in, "capability=clean", "capability=smudge", NULL);
+	err = packet_write_list_gently(process->in, "capability=clean", "capability=smudge", NULL);
 
 	for (;;) {
 		cap_buf = packet_read_line(process->out, NULL);
@@ -651,7 +550,7 @@ static struct cmd2process *start_multi_file_filter(struct hashmap *hashmap, cons
 		} else {
 			warning(
 				"external filter '%s' requested unsupported filter capability '%s'",
-				cmd, cap_name
+				subprocess->cmd, cap_name
 			);
 		}
 
@@ -661,14 +560,10 @@ static struct cmd2process *start_multi_file_filter(struct hashmap *hashmap, cons
 done:
 	sigchain_pop(SIGPIPE);
 
-	if (err || errno == EPIPE) {
-		error("initialization for external filter '%s' failed", cmd);
-		kill_multi_file_filter(hashmap, entry);
-		return NULL;
-	}
+	if (err || errno == EPIPE)
+		err = err ? err : errno;
 
-	hashmap_add(hashmap, entry);
-	return entry;
+	return err;
 }
 
 static int apply_multi_file_filter(const char *path, const char *src, size_t len,
@@ -682,22 +577,20 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
 	struct strbuf filter_status = STRBUF_INIT;
 	const char *filter_type;
 
-	if (!cmd_process_map_initialized) {
-		cmd_process_map_initialized = 1;
-		hashmap_init(&cmd_process_map, (hashmap_cmp_fn) cmd2process_cmp, 0);
-		entry = NULL;
-	} else {
-		entry = find_multi_file_filter_entry(&cmd_process_map, cmd);
-	}
+	entry = (struct cmd2process *)subprocess_find_entry(cmd);
 
 	fflush(NULL);
 
 	if (!entry) {
-		entry = start_multi_file_filter(&cmd_process_map, cmd);
-		if (!entry)
+		entry = xmalloc(sizeof(*entry));
+		entry->supported_capabilities = 0;
+
+		if (subprocess_start(&entry->subprocess, cmd, start_multi_file_filter_fn)) {
+			free(entry);
 			return 0;
+		}
 	}
-	process = &entry->process;
+	process = subprocess_get_child_process(&entry->subprocess);
 
 	if (!(wanted_capability & entry->supported_capabilities))
 		return 0;
@@ -737,7 +630,7 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
 	if (err)
 		goto done;
 
-	read_multi_file_filter_status(process->out, &filter_status);
+	subprocess_read_status(process->out, &filter_status);
 	err = strcmp(filter_status.buf, "success");
 	if (err)
 		goto done;
@@ -746,7 +639,7 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
 	if (err)
 		goto done;
 
-	read_multi_file_filter_status(process->out, &filter_status);
+	subprocess_read_status(process->out, &filter_status);
 	err = strcmp(filter_status.buf, "success");
 
 done:
@@ -768,7 +661,8 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
 			 * Force shutdown and restart if another blob requires filtering.
 			 */
 			error("external filter '%s' failed", cmd);
-			kill_multi_file_filter(&cmd_process_map, entry);
+			subprocess_stop((struct subprocess_entry *)entry);
+			free(entry);
 		}
 	} else {
 		strbuf_swap(dst, &nbuf);
-- 
2.12.0.gvfs.1.42.g0b7328eac2

