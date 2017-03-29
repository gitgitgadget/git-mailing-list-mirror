Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB06520958
	for <e@80x24.org>; Wed, 29 Mar 2017 15:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932201AbdC2PyM (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Mar 2017 11:54:12 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:34147 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932160AbdC2PyK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2017 11:54:10 -0400
Received: by mail-qt0-f193.google.com with SMTP id x35so2532492qtc.1
        for <git@vger.kernel.org>; Wed, 29 Mar 2017 08:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jTDqAfFHTguoV1kLUyw0s26x8m1WR8FLrgfywZP2RmQ=;
        b=mBr+s5ilWQbUUnaQkX+uqwvPylwrXj6wgskos2lOAIpCthD6I8+yDcm3AL3uRKzNW0
         Hs8wpFgGRwHP6NrND9+UjEs/obeU5MpVVaDjlndr258i1TqGlAF4/GShBFjICSwnr/ll
         +4+qdNnPoW2GV8hwjMoJqX3XE4M2HIiOKG95JJmOfrnoBbiyDZD6DuMc9WmYgq+uQuC2
         cs8ijfkZwoVDFloJNo0jZPlyuIE4CAPbrkICndMV+mk0vv7B4USVXxId0CH2pj9XuK1p
         +vnZ7FI+D082os/M7ywDj2jTnEg+rOvPDlcAWh4fv6luASnPpBPB/VnNOhUsHuA0euF7
         qmbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jTDqAfFHTguoV1kLUyw0s26x8m1WR8FLrgfywZP2RmQ=;
        b=Bx5hzebZWLYyqQ88uhes6p/jdFcNJJNnt7dH2ZrQlN78kMg/kJ3GDyoIITNm92YJfI
         2M7xJgX8BB4OsMk7j1qjFFG+0mGjZS9OrnbkjOay1c2QLIyzlv2t0VFLX6L8TrtNwgpW
         fj3/YaN0XDCjKZ2Ism1rh61DyvbGlDntputNWdk9bY8atRPEKd7foR5ngRSX5nB6/ClD
         3i3oPa63zcs/R8xAEhwUc5Okymg/wqFy7s4lvA0u8Bkh6fC+ZQvngSQF2aTztxxn0VlG
         wdhScWWm5SOAD9cBMk/z6M0mIAjn9e/0Jz0cQajNZO7RVlDZo5F8/JVNShMc0aXnquet
         hTmA==
X-Gm-Message-State: AFeK/H2PhNomL1N0yHW0Ye5w1blqEMhVnGyvRUbW+htx6k7zb2o4slZEIfMhzmxHtfpgAA==
X-Received: by 10.200.2.175 with SMTP id p47mr1344232qtg.35.1490802849020;
        Wed, 29 Mar 2017 08:54:09 -0700 (PDT)
Received: from localhost.localdomain ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id o92sm5148566qkh.48.2017.03.29.08.54.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 29 Mar 2017 08:54:08 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
X-Google-Original-From: Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, benpeart@microsoft.com,
        christian.couder@gmail.com, larsxschneider@gmail.com
Subject: [PATCH v3 3/8] convert: Split start_multi_file_filter into two separate functions
Date:   Wed, 29 Mar 2017 11:53:25 -0400
Message-Id: <20170329155330.12860-4-benpeart@microsoft.com>
X-Mailer: git-send-email 2.12.1.gvfs.1.18.ge47db72
In-Reply-To: <20170329155330.12860-1-benpeart@microsoft.com>
References: <20170329155330.12860-1-benpeart@microsoft.com>
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

