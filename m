Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86737207BC
	for <e@80x24.org>; Fri, 21 Apr 2017 18:19:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1041698AbdDUSTx (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Apr 2017 14:19:53 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:36412 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1041693AbdDUSTv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2017 14:19:51 -0400
Received: by mail-qk0-f196.google.com with SMTP id y63so3807078qkd.3
        for <git@vger.kernel.org>; Fri, 21 Apr 2017 11:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0zDLtbt5wVDbj/1q9l+Ndv9VaQe6TeY2yO4GIC2BfDI=;
        b=RObLEvVJy10pLevLoncSFc6aMabwgL8YQrbWS5bn745DmWJ9ZBtUuGfux6Gmd4crpT
         lqqTYeuGMRyOj6oSbq8mVQTsf4aayztK0su3aZwbp+ruTi/PZdTqvbfZG9du925U+zcH
         R27NxEc+c6fp9a+kpSx1jmehLB18PQjvkZHTD6UcB6kjQ5a06MN+q2HcJPx3ltVk5ZWL
         LvGCzuIvAWEYo5l3+EQcsjKFKSZrFsuViYjuaReLvZVCz971xtSnARyUy9Z0lyxILa4B
         LWtlAGVAdFeyiQvNuRGF3damEVG3RM6Lg1E2TSKxwchnrSeym+MZEudrf3WPszs/7Pzp
         bLMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0zDLtbt5wVDbj/1q9l+Ndv9VaQe6TeY2yO4GIC2BfDI=;
        b=Unlf3O71Sl2S1k0EXvgIKc902kWLKLmheViob2C1DhpvjeVk9n1uZGpeRLqSOPcFi0
         aMUypyHIwgNwAHJlxrCLAHAWm2mHfhE39qhjPMmR7qq3OWjXqa9WTuo89XiSYE0wr4uE
         YAMCq07fOv4RoSDWqExhoJBjUdE9zUkC+ahRG1u9y5Qt1n7BaJfQ/rEmVo4D+XOaC/J0
         Ig6L452iBWh0g4C9ruTD3mNwsmOVc1jT+bWpnY6Nq72MUvhShJQxEJ3DujZXQqv5icOF
         tlsAB/r/FoI9PaLgrARgM92hiQo2xalwEgcPx9uzJgBLdtk/6KA6I1ViiE+FJqsb8chB
         m/oQ==
X-Gm-Message-State: AN3rC/514XFK7FPr1mA4rLyyF+ASnFmyUTgRn5T07N88DFKSsvNuGjCf
        K88mALc3V1vW6aAYZMs=
X-Received: by 10.55.207.208 with SMTP id v77mr15497937qkl.189.1492795608833;
        Fri, 21 Apr 2017 10:26:48 -0700 (PDT)
Received: from localhost.localdomain ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id g66sm6700551qkb.55.2017.04.21.10.26.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 21 Apr 2017 10:26:48 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
X-Google-Original-From: Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, benpeart@microsoft.com,
        christian.couder@gmail.com, larsxschneider@gmail.com
Subject: [PATCH v6 3/8] convert: Split start_multi_file_filter into two separate functions
Date:   Fri, 21 Apr 2017 13:26:06 -0400
Message-Id: <20170421172611.12152-4-benpeart@microsoft.com>
X-Mailer: git-send-email 2.12.0.windows.1.33.g243d9b384c
In-Reply-To: <20170421172611.12152-1-benpeart@microsoft.com>
References: <20170421172611.12152-1-benpeart@microsoft.com>
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
 convert.c | 62 ++++++++++++++++++++++++++++++++++++--------------------------
 1 file changed, 36 insertions(+), 26 deletions(-)

diff --git a/convert.c b/convert.c
index 793c29ebfd..36401fe087 100644
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
 
@@ -642,7 +621,38 @@ static struct cmd2process *start_multi_file_filter(struct hashmap *hashmap, cons
 done:
 	sigchain_pop(SIGPIPE);
 
-	if (err || errno == EPIPE) {
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
@@ -733,7 +743,7 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
 done:
 	sigchain_pop(SIGPIPE);
 
-	if (err || errno == EPIPE) {
+	if (err) {
 		if (!strcmp(filter_status.buf, "error")) {
 			/* The filter signaled a problem with the file. */
 		} else if (!strcmp(filter_status.buf, "abort")) {
-- 
2.12.0.windows.1.33.g243d9b384c

