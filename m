Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E8F220966
	for <e@80x24.org>; Thu, 30 Mar 2017 15:54:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934223AbdC3Pyi (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 11:54:38 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:33487 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933723AbdC3Pye (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2017 11:54:34 -0400
Received: by mail-qt0-f194.google.com with SMTP id r45so6767825qte.0
        for <git@vger.kernel.org>; Thu, 30 Mar 2017 08:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vLQrIeKfRIcqm3HDYf1h/fEK6CZp4blIcWZ4mNrBfeo=;
        b=qM1qTP3XxoltinpWilvFNLiSkLtnCAOPAgHJBpMTPds2FMAcha1sa388er5pv1O33R
         oZPt8Hc2jNeAe7e+/XJaXAYs418xXeq15nb/d5udmSS/L6AAKDDL2ldlE2aKlxl44piL
         4Yqq/lOQZfdvR3oI+YoGydPt9b1o8/CaoKqSlay4cTMhJEOT7iWTzWW5szFZPhgrGeN4
         Qz3qI/VcftxMsHYKXQjvzlCKF62xQApRnReQJerO7aCrk2Bx/YG51T54bQA0v2/aXSMx
         s+phDNKl/Q4XJ1HTBRrf2kLRetjxvD7V62gW1ZjMZOOjDvH+rgXDgVnqPklmUDj5Qxas
         oosQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vLQrIeKfRIcqm3HDYf1h/fEK6CZp4blIcWZ4mNrBfeo=;
        b=da+AMpeiGPisYn3YwV7orK/La+aZ42mIU694ln7aklqllsGm/kBTO+o6GGaxRRapQL
         0AKh2pcHb7be2mKipdwxyIRtfTYyVX4ncZ67j7IbDhX6g4cRk/uhmpoh3L7MJ4ysyVod
         V1TGJBPXdeHlJM3unQ3aPVM/6dpNrdEdmcg9EdkqncmUMxOPCqGdDqKcJD0NuOWQxlkE
         uxGAIykbRgvGYMwmqzeg8jUgV92vXkQel1QzgYBN0Aj9VVbu+ywmzu8/zbPk2bt+4U5n
         /iKdfj004ehvtPnYROdwUJob1fKZ6V5djScNxfVNtDD7DOlcS2gKYvga3Bj6vXNn65Ou
         CtqA==
X-Gm-Message-State: AFeK/H3CJBwHVy2Ep70FdEojwii+qJM2QNzeEtKQAMmw0tM3+Dk8BqHYKR7IwDkkmf7d1Q==
X-Received: by 10.200.40.86 with SMTP id 22mr448082qtr.245.1490889272456;
        Thu, 30 Mar 2017 08:54:32 -0700 (PDT)
Received: from localhost.localdomain ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id k5sm1665671qtb.12.2017.03.30.08.54.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 30 Mar 2017 08:54:32 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
X-Google-Original-From: Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, benpeart@microsoft.com,
        christian.couder@gmail.com, larsxschneider@gmail.com
Subject: [PATCH v4 4/8] convert: Separate generic structures and variables from the filter specific ones
Date:   Thu, 30 Mar 2017 11:54:13 -0400
Message-Id: <20170330155417.8928-6-benpeart@microsoft.com>
X-Mailer: git-send-email 2.12.1.gvfs.1.18.ge47db72
In-Reply-To: <20170330155417.8928-1-benpeart@microsoft.com>
References: <20170330155417.8928-1-benpeart@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To enable future reuse of the filter.<driver>.process infrastructure,
split the cmd2process structure into two separate parts.

subprocess_entry will now contain the generic data required to manage
the creation and tracking of the child process in a hashmap. Also move
all knowledge of the hashmap into the generic functions.

cmd2process is a filter protocol specific structure that is used to
track the negotiated capabilities of the filter.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 convert.c | 57 +++++++++++++++++++++++++++++++--------------------------
 1 file changed, 31 insertions(+), 26 deletions(-)

diff --git a/convert.c b/convert.c
index 404757eac9..f569026511 100644
--- a/convert.c
+++ b/convert.c
@@ -496,29 +496,40 @@ static int apply_single_file_filter(const char *path, const char *src, size_t le
 #define CAP_CLEAN    (1u<<0)
 #define CAP_SMUDGE   (1u<<1)
 
-struct cmd2process {
+struct subprocess_entry {
 	struct hashmap_entry ent; /* must be the first member! */
-	unsigned int supported_capabilities;
 	const char *cmd;
 	struct child_process process;
 };
 
+struct cmd2process {
+	struct subprocess_entry subprocess; /* must be the first member! */
+	unsigned int supported_capabilities;
+};
+
 static int cmd_process_map_initialized;
 static struct hashmap cmd_process_map;
 
-static int cmd2process_cmp(const struct cmd2process *e1,
-			   const struct cmd2process *e2,
+static int cmd2process_cmp(const struct subprocess_entry *e1,
+			   const struct subprocess_entry *e2,
 			   const void *unused)
 {
 	return strcmp(e1->cmd, e2->cmd);
 }
 
-static struct cmd2process *find_multi_file_filter_entry(struct hashmap *hashmap, const char *cmd)
+static struct subprocess_entry *find_multi_file_filter_entry(const char *cmd)
 {
-	struct cmd2process key;
+	struct subprocess_entry key;
+
+	if (!cmd_process_map_initialized) {
+		cmd_process_map_initialized = 1;
+		hashmap_init(&cmd_process_map, (hashmap_cmp_fn)cmd2process_cmp, 0);
+		return NULL;
+	}
+
 	hashmap_entry_init(&key, strhash(cmd));
 	key.cmd = cmd;
-	return hashmap_get(hashmap, &key, NULL);
+	return hashmap_get(&cmd_process_map, &key, NULL);
 }
 
 static void read_multi_file_filter_status(int fd, struct strbuf *status)
@@ -541,7 +552,7 @@ static void read_multi_file_filter_status(int fd, struct strbuf *status)
 	}
 }
 
-static void kill_multi_file_filter(struct hashmap *hashmap, struct cmd2process *entry)
+static void kill_multi_file_filter(struct subprocess_entry *entry)
 {
 	if (!entry)
 		return;
@@ -550,7 +561,7 @@ static void kill_multi_file_filter(struct hashmap *hashmap, struct cmd2process *
 	kill(entry->process.pid, SIGTERM);
 	finish_command(&entry->process);
 
-	hashmap_remove(hashmap, entry, NULL);
+	hashmap_remove(&cmd_process_map, entry, NULL);
 	free(entry);
 }
 
@@ -571,8 +582,8 @@ static int start_multi_file_filter_fn(struct cmd2process *entry)
 	struct string_list cap_list = STRING_LIST_INIT_NODUP;
 	char *cap_buf;
 	const char *cap_name;
-	struct child_process *process = &entry->process;
-	const char *cmd = entry->cmd;
+	struct child_process *process = &entry->subprocess.process;
+	const char *cmd = entry->subprocess.cmd;
 
 	sigchain_push(SIGPIPE, SIG_IGN);
 
@@ -627,7 +638,7 @@ static int start_multi_file_filter_fn(struct cmd2process *entry)
 	return err;
 }
 
-static struct cmd2process *start_multi_file_filter(struct hashmap *hashmap, const char *cmd)
+static struct cmd2process *start_multi_file_filter(const char *cmd)
 {
 	int err;
 	struct cmd2process *entry;
@@ -635,9 +646,9 @@ static struct cmd2process *start_multi_file_filter(struct hashmap *hashmap, cons
 	const char *argv[] = { cmd, NULL };
 
 	entry = xmalloc(sizeof(*entry));
-	entry->cmd = cmd;
+	entry->subprocess.cmd = cmd;
 	entry->supported_capabilities = 0;
-	process = &entry->process;
+	process = &entry->subprocess.process;
 
 	child_process_init(process);
 	process->argv = argv;
@@ -657,11 +668,11 @@ static struct cmd2process *start_multi_file_filter(struct hashmap *hashmap, cons
 	err = start_multi_file_filter_fn(entry);
 	if (err) {
 		error("initialization for external filter '%s' failed", cmd);
-		kill_multi_file_filter(hashmap, entry);
+		kill_multi_file_filter(&entry->subprocess);
 		return NULL;
 	}
 
-	hashmap_add(hashmap, entry);
+	hashmap_add(&cmd_process_map, entry);
 	return entry;
 }
 
@@ -676,22 +687,16 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
 	struct strbuf filter_status = STRBUF_INIT;
 	const char *filter_type;
 
-	if (!cmd_process_map_initialized) {
-		cmd_process_map_initialized = 1;
-		hashmap_init(&cmd_process_map, (hashmap_cmp_fn) cmd2process_cmp, 0);
-		entry = NULL;
-	} else {
-		entry = find_multi_file_filter_entry(&cmd_process_map, cmd);
-	}
+	entry = (struct cmd2process *)find_multi_file_filter_entry(cmd);
 
 	fflush(NULL);
 
 	if (!entry) {
-		entry = start_multi_file_filter(&cmd_process_map, cmd);
+		entry = start_multi_file_filter(cmd);
 		if (!entry)
 			return 0;
 	}
-	process = &entry->process;
+	process = &entry->subprocess.process;
 
 	if (!(wanted_capability & entry->supported_capabilities))
 		return 0;
@@ -762,7 +767,7 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
 			 * Force shutdown and restart if another blob requires filtering.
 			 */
 			error("external filter '%s' failed", cmd);
-			kill_multi_file_filter(&cmd_process_map, entry);
+			kill_multi_file_filter(&entry->subprocess);
 		}
 	} else {
 		strbuf_swap(dst, &nbuf);
-- 
2.12.1.gvfs.1.18.ge47db72

