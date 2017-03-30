Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2936220966
	for <e@80x24.org>; Thu, 30 Mar 2017 15:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934221AbdC3Pyf (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 11:54:35 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:33022 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933482AbdC3Pyd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2017 11:54:33 -0400
Received: by mail-qk0-f194.google.com with SMTP id p22so6886035qka.0
        for <git@vger.kernel.org>; Thu, 30 Mar 2017 08:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jTDqAfFHTguoV1kLUyw0s26x8m1WR8FLrgfywZP2RmQ=;
        b=l51KaLC+MTQwl0q+ZMPhntQDbNh33gdQ5kfEwxYTV5z2dmgztIPR4WMk5Z6L3zUayK
         nEQtHqWKHdpqsOL6fO1/BrpDIy8FnHi9XfRygWVl3HTsQjFvtoQq6uZmm/8jR2Q/V74H
         XumerqRKAxMYgCfy64JLs1x26wJrLMzPTsu3uhouiX4VBUjGxWnkyul5Lv4jQkatuQm+
         qaIeXdCvQZffP9rptO+UJ89fjHMfjnOEYMIqZH5Lb6lWLeQfI6e/zS5/mh2KKQ9yqas4
         Qq+N9jaOEmbPO391mux5O9HeYmuA9M1jl6tPud2wHNA5rC45S2XYupd0KDHhvjhtjmel
         Op5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jTDqAfFHTguoV1kLUyw0s26x8m1WR8FLrgfywZP2RmQ=;
        b=XC2HU4TRkrfMRnQX5Mz4gDo0j7/8fJEpvGmzoV05OYOOdVS5EEUVFqu4IHjaHfHeSD
         9dDdCzKSOeOx0QVbZrnZZER3LzVqvfuBPRW8kv+sTkDnefnKjdceceV5VPibIQPVK2hq
         Ef0Cxl3s7EUzCm5p2MssORY/ETWmKOQaRYixSGnJkzvUbGipGnHRMl6MgeRankTy+6P3
         0BXoSL8PZcv+tfOENXCYXeh1ujosxf3uKmWL4wF5qG2dJ1Ox3zwggDR9y8foj14xznZ4
         VatmVxlgJjvbo810k7TqYtpJ/Q7sjlcG88S7ih18Ji73AGBdfaFfdkrNqRLj5kl78jUO
         IfQQ==
X-Gm-Message-State: AFeK/H2yRh+pTNW9v7dGP9sZbnu5DF++zfRf/QUZYoXhPr6q0vThzJfDWRWMMOWWDLHVAA==
X-Received: by 10.55.41.33 with SMTP id p33mr393917qkh.103.1490889271680;
        Thu, 30 Mar 2017 08:54:31 -0700 (PDT)
Received: from localhost.localdomain ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id k5sm1665671qtb.12.2017.03.30.08.54.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 30 Mar 2017 08:54:31 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
X-Google-Original-From: Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, benpeart@microsoft.com,
        christian.couder@gmail.com, larsxschneider@gmail.com
Subject: [PATCH v4 3/8] convert: Split start_multi_file_filter into two separate functions
Date:   Thu, 30 Mar 2017 11:54:12 -0400
Message-Id: <20170330155417.8928-5-benpeart@microsoft.com>
X-Mailer: git-send-email 2.12.1.gvfs.1.18.ge47db72
In-Reply-To: <20170330155417.8928-1-benpeart@microsoft.com>
References: <20170330155417.8928-1-benpeart@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To enable future reuse of the filter.<driver>.process infrastructure,
split start_multi_file_filter into two separate parts.

start_multi_file_filter will now only contain the generic logic to
manage the creation and tracking of the child process in a hashmap.

start_multi_file_filter_fn is a protocol specific initialization
function that will negotiate the multi-file-filter interface version
and capabilities.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 convert.c | 63 ++++++++++++++++++++++++++++++++++++++-------------------------
 1 file changed, 38 insertions(+), 25 deletions(-)

diff --git a/convert.c b/convert.c
index 793c29ebfd..404757eac9 100644
--- a/convert.c
+++ b/convert.c
@@ -565,35 +565,14 @@ static void stop_multi_file_filter(struct child_process *process)
 	finish_command(process);
 }
 
-static struct cmd2process *start_multi_file_filter(struct hashmap *hashmap, const char *cmd)
+static int start_multi_file_filter_fn(struct cmd2process *entry)
 {
 	int err;
-	struct cmd2process *entry;
-	struct child_process *process;
-	const char *argv[] = { cmd, NULL };
 	struct string_list cap_list = STRING_LIST_INIT_NODUP;
 	char *cap_buf;
 	const char *cap_name;
-
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
+	struct child_process *process = &entry->process;
+	const char *cmd = entry->cmd;
 
 	sigchain_push(SIGPIPE, SIG_IGN);
 
@@ -642,7 +621,41 @@ static struct cmd2process *start_multi_file_filter(struct hashmap *hashmap, cons
 done:
 	sigchain_pop(SIGPIPE);
 
-	if (err || errno == EPIPE) {
+	if (err || errno == EPIPE)
+		err = err ? err : errno;
+
+	return err;
+}
+
+static struct cmd2process *start_multi_file_filter(struct hashmap *hashmap, const char *cmd)
+{
+	int err;
+	struct cmd2process *entry;
+	struct child_process *process;
+	const char *argv[] = { cmd, NULL };
+
+	entry = xmalloc(sizeof(*entry));
+	entry->cmd = cmd;
+	entry->supported_capabilities = 0;
+	process = &entry->process;
+
+	child_process_init(process);
+	process->argv = argv;
+	process->use_shell = 1;
+	process->in = -1;
+	process->out = -1;
+	process->clean_on_exit = 1;
+	process->clean_on_exit_handler = stop_multi_file_filter;
+
+	if (start_command(process)) {
+		error("cannot fork to run external filter '%s'", cmd);
+		return NULL;
+	}
+
+	hashmap_entry_init(entry, strhash(cmd));
+
+	err = start_multi_file_filter_fn(entry);
+	if (err) {
 		error("initialization for external filter '%s' failed", cmd);
 		kill_multi_file_filter(hashmap, entry);
 		return NULL;
-- 
2.12.1.gvfs.1.18.ge47db72

