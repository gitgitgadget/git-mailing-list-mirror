Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB4A020958
	for <e@80x24.org>; Wed, 29 Mar 2017 15:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932220AbdC2PyU (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Mar 2017 11:54:20 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:32841 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932172AbdC2PyT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2017 11:54:19 -0400
Received: by mail-qt0-f193.google.com with SMTP id r45so2545132qte.0
        for <git@vger.kernel.org>; Wed, 29 Mar 2017 08:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OWcEWIr6P8hJjgrFzOuxp/LGiIL0OU5srQGlOVXPeB0=;
        b=QB0rmcH101mpf3EQWz/nTr+qgJEWPyqAMYprofWqFaTUFCqUKvmXQye9TkzvbohOaC
         IOkjGYNYc9SJGBWfOwOekdo742D2pF+9lp4Ri0kcpsNN7//jGtRtjU5AjmdHOL+6E3mf
         Fy2CumawelxVCQDDZPT1NVEscUGREPTnjP8FA4aUr2D3rhyu2CaZ05SmoAh2mCNIJL7x
         Beer4ucqXqXKGVF5QzkSANmzBHpL/s0okt+gqfim/mrGhZKeYRRW911YBS6cLGIRt1NB
         KYkiMEhszSLbme3OVr2WVcgfeNZF1KuSuos2s5gimcjZQS47npB4to0ngBNDnG7fMpBn
         3F0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OWcEWIr6P8hJjgrFzOuxp/LGiIL0OU5srQGlOVXPeB0=;
        b=og393Ooj3xVgzQVfCRXZq+p332kMq1Uv0Z8mCeav21xsl7pRtK/MoZkZgG7S8oAje5
         bHmvocAL8gURML/ZT3JVAX4HK7gaOV+iwIr/060StVCw8qyVKEcoIl5hUdrLYfP0Uh2P
         Yk29SHTBLHA/3vXDneHzVQ9NhqABl+V1YyobgWRZ+ogQvutQvWJOm0ReSRXQxl1b8+Rd
         doYToQGsGoThIQve8U35AO1bslHhkQ3oWGSZDNIhblZ+nbtPIQDdP+8v+/AMRRbC/OQF
         /+oIiSyZTNU1ofCQjEUWQPc2+1/+/7cpEw3l6y+YfXP+JrcTMWrzK3fFu9WqfZCF4vCj
         Uvlw==
X-Gm-Message-State: AFeK/H252n92XgAh+LhmeJ/TKnD45uwYMXohunzlYpK66YFfAXnbXLOD6ZkM8YG0Ev0XVA==
X-Received: by 10.200.34.250 with SMTP id g55mr1316286qta.155.1490802852735;
        Wed, 29 Mar 2017 08:54:12 -0700 (PDT)
Received: from localhost.localdomain ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id o92sm5148566qkh.48.2017.03.29.08.54.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 29 Mar 2017 08:54:12 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
X-Google-Original-From: Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, benpeart@microsoft.com,
        christian.couder@gmail.com, larsxschneider@gmail.com
Subject: [PATCH v3 5/8] convert: Update generic functions to only use generic data structures
Date:   Wed, 29 Mar 2017 11:53:27 -0400
Message-Id: <20170329155330.12860-6-benpeart@microsoft.com>
X-Mailer: git-send-email 2.12.1.gvfs.1.18.ge47db72
In-Reply-To: <20170329155330.12860-1-benpeart@microsoft.com>
References: <20170329155330.12860-1-benpeart@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Update all functions that are going to be moved into a reusable module
so that they only work with the reusable data structures.  Move code
that is specific to the filter out into the filter functions.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 convert.c | 48 +++++++++++++++++++++++++++++-------------------
 1 file changed, 29 insertions(+), 19 deletions(-)

diff --git a/convert.c b/convert.c
index f569026511..77966e246b 100644
--- a/convert.c
+++ b/convert.c
@@ -562,7 +562,6 @@ static void kill_multi_file_filter(struct subprocess_entry *entry)
 	finish_command(&entry->process);
 
 	hashmap_remove(&cmd_process_map, entry, NULL);
-	free(entry);
 }
 
 static void stop_multi_file_filter(struct child_process *process)
@@ -576,14 +575,15 @@ static void stop_multi_file_filter(struct child_process *process)
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
 
@@ -638,17 +638,21 @@ static int start_multi_file_filter_fn(struct cmd2process *entry)
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
@@ -658,22 +662,23 @@ static struct cmd2process *start_multi_file_filter(const char *cmd)
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
@@ -692,9 +697,13 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
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
 
@@ -767,7 +776,8 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
 			 * Force shutdown and restart if another blob requires filtering.
 			 */
 			error("external filter '%s' failed", cmd);
-			kill_multi_file_filter(&entry->subprocess);
+			kill_multi_file_filter((struct subprocess_entry *)entry);
+			free(entry);
 		}
 	} else {
 		strbuf_swap(dst, &nbuf);
-- 
2.12.1.gvfs.1.18.ge47db72

