Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B264020966
	for <e@80x24.org>; Fri,  7 Apr 2017 12:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933487AbdDGMEc (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Apr 2017 08:04:32 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:33988 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933147AbdDGME2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2017 08:04:28 -0400
Received: by mail-yw0-f193.google.com with SMTP id d191so4764129ywe.1
        for <git@vger.kernel.org>; Fri, 07 Apr 2017 05:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5DdjtB3AewQVkGgqfu40qfeiZUj4x+xk4wJchZ5B8Q4=;
        b=u+pO4P6LlWsd8dH6RlZIDd+72i1WcOkDJ2rcGNFxveygHohLoIGcFg6DW35RrpyNxb
         SytFbr20AM/ZT+WCiWDf2jj1WIExuvwyBNoxh0r9Q9XxJLgevRIrGPJRs6Svn88U6+Wn
         NmH0hU3n1aV8NvIEekaA04PJdadtjZ6ZMBK35fM43WfR0h7W24YmNHLiRmcBFJ147xCW
         SLTMPeF2DjWY+VtSIulodD2PiQQsuLMB5CQGwVBHiipY5n4+uuTkB4y0CToOCH/XZE3a
         eQbY3RnKY46EqVmoGeIjtLWwZAFIuTS9rE6Ed7L5Uu9sQJOlMnkDkbmpZoG7gj8+9Pwr
         ybHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5DdjtB3AewQVkGgqfu40qfeiZUj4x+xk4wJchZ5B8Q4=;
        b=VYrucaU3I6dvx4fnw0G2W9Mb0fdPPQaijeqP57Mw5oMcS+sWLhMWEiMP1H+ansFM+V
         bJi64qHc7xunflEr0h62GSWoVh+lQg+kpHpj9joBn6czby1AO+vQhSUA1dByw7BUjn/O
         N1BdWz3a8iHg5z6j5ywoPiGHSc95F6E3YAFKfQAoTHfJK5UGtUKqDh3NvTdnWdCv55oA
         KTKJP8jBCSffmem/bXV29uix0+8VsLrkgl+63OIvvDTjbiQZQ5VrQKjXDUc8VeVfWiMN
         rhZBmFiNMrEyuN0VYzDR1pxz9ilQy8t4I+fruPqs3qBt/ny8x6qpAzLWwnOBBV7fitd5
         12ag==
X-Gm-Message-State: AN3rC/5z1orPoijOCAmU8QFOgF26cgihflClDeyroYV3tA4c6WatLZhr5q7OsojBS7j12g==
X-Received: by 10.129.112.194 with SMTP id l185mr1177230ywc.236.1491566666949;
        Fri, 07 Apr 2017 05:04:26 -0700 (PDT)
Received: from localhost.localdomain ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id z194sm1874038ywg.73.2017.04.07.05.04.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 07 Apr 2017 05:04:26 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
X-Google-Original-From: Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, benpeart@microsoft.com,
        christian.couder@gmail.com, larsxschneider@gmail.com
Subject: [PATCH v5 3/8] convert: Split start_multi_file_filter into two separate functions
Date:   Fri,  7 Apr 2017 08:03:49 -0400
Message-Id: <20170407120354.17736-4-benpeart@microsoft.com>
X-Mailer: git-send-email 2.12.0.windows.1.33.g243d9b384c
In-Reply-To: <20170407120354.17736-1-benpeart@microsoft.com>
References: <20170407120354.17736-1-benpeart@microsoft.com>
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
2.12.0.windows.1.31.g1548525701.dirty

