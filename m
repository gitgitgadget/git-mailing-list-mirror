Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32418207B3
	for <e@80x24.org>; Fri,  5 May 2017 15:29:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754349AbdEEP3C (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 11:29:02 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:36546 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754004AbdEEP2o (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 11:28:44 -0400
Received: by mail-qt0-f194.google.com with SMTP id j13so1229744qta.3
        for <git@vger.kernel.org>; Fri, 05 May 2017 08:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PG32zkRJhp1CSWLSojhGgo96btBaU6F+ouAh7yxs1Hk=;
        b=soWNn9lVWdyhE4x7dkAmwnXOZPLxM21tcDWn5xiAn34So8IR+XMZ3/7XIxFFifDEth
         wXu/vVgmO7MyD8KQhHZazsNcdmBnxCkBCYFbDiS4cIk/Zik11bE6h67WsKYKzE/jOQ6I
         zULpoAS3kN4d22+PvM0pv+wgtW3BXOGI28ucEsHAX2/z70OGsVqp+vMAExhPRRAtYKXn
         hB3AGZ8U0UcbZ7i/zSXv6nkpH1s+1hsdVJDdKy6/HjjF5EeyslWUDvKX8XaXjdeUfX+J
         mW1Lg0f78hUeJf0Mj9ClKlz0iS6khYecV1IuVXkJXBmRizQus8GmqdkO+6txqrqTBnVT
         bppA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PG32zkRJhp1CSWLSojhGgo96btBaU6F+ouAh7yxs1Hk=;
        b=K9gtcZ8KtxIVDjtaNiDAXhma7GJ7tGDt3HH4DnuwektI8VgqneggE5oM29AOZerjxv
         UMSbApm6A0lTz7Qth9gQGG084sbVGgQKmss5cPbg8zYIw/iEh49WZOzbNsOegqYlEbP7
         rwh+GP6A/oLM7PfUYCUaqRPXBE4nUFIoMuR2yBfMwNA5ZyMdyUpFwIPnmpQhWWckhsPB
         OG4ggOgAnS0eWKsf4Q4VAH3/Bo2zlJsaMAHu3dEdHnvdAHF1/XANQm8izdVTq6+18J9H
         xpgw+aE/OgSTBGwIdAzFNRRks8aSxWD9jB6uc7lKi7UtO+sJ55QivVwvMAmet3KiXy13
         rxVQ==
X-Gm-Message-State: AN3rC/5TO9id+qPrNNelZdaZjTMcF7tOwaoqQibvcuDQZL4IBUGhVGN4
        k8cPLBslDpRlYA==
X-Received: by 10.200.36.131 with SMTP id s3mr47165236qts.289.1493998123804;
        Fri, 05 May 2017 08:28:43 -0700 (PDT)
Received: from localhost.localdomain ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id t68sm3392792qkc.44.2017.05.05.08.28.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 May 2017 08:28:42 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
X-Google-Original-From: Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, benpeart@microsoft.com,
        christian.couder@gmail.com, larsxschneider@gmail.com, peff@peff.net
Subject: [PATCH v7 06/10] convert: Separate generic structures and variables from the filter specific ones
Date:   Fri,  5 May 2017 11:27:58 -0400
Message-Id: <20170505152802.6724-7-benpeart@microsoft.com>
X-Mailer: git-send-email 2.12.2.gvfs.2.20.g3624a68d62.dirty
In-Reply-To: <20170505152802.6724-1-benpeart@microsoft.com>
References: <20170505152802.6724-1-benpeart@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To enable future reuse of the filter.<driver>.process infrastructure,
split the cmd2process structure into two separate parts.

subprocess_entry will now contain the generic data required to manage
the creation and tracking of the child process in a hashmap.

cmd2process is a filter protocol specific structure that is used to
track the negotiated capabilities of the filter.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 convert.c | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/convert.c b/convert.c
index 4e1d018577..5876218347 100644
--- a/convert.c
+++ b/convert.c
@@ -496,26 +496,31 @@ static int apply_single_file_filter(const char *path, const char *src, size_t le
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
+static struct subprocess_entry *find_multi_file_filter_entry(struct hashmap *hashmap, const char *cmd)
 {
-	struct cmd2process key;
+	struct subprocess_entry key;
+
 	hashmap_entry_init(&key, strhash(cmd));
 	key.cmd = cmd;
 	return hashmap_get(hashmap, &key, NULL);
@@ -541,7 +546,7 @@ static void read_multi_file_filter_status(int fd, struct strbuf *status)
 	}
 }
 
-static void kill_multi_file_filter(struct hashmap *hashmap, struct cmd2process *entry)
+static void kill_multi_file_filter(struct hashmap *hashmap, struct subprocess_entry *entry)
 {
 	if (!entry)
 		return;
@@ -571,8 +576,8 @@ static int start_multi_file_filter_fn(struct cmd2process *entry)
 	struct string_list cap_list = STRING_LIST_INIT_NODUP;
 	char *cap_buf;
 	const char *cap_name;
-	struct child_process *process = &entry->process;
-	const char *cmd = entry->cmd;
+	struct child_process *process = &entry->subprocess.process;
+	const char *cmd = entry->subprocess.cmd;
 
 	sigchain_push(SIGPIPE, SIG_IGN);
 
@@ -632,9 +637,9 @@ static struct cmd2process *start_multi_file_filter(struct hashmap *hashmap, cons
 	const char *argv[] = { cmd, NULL };
 
 	entry = xmalloc(sizeof(*entry));
-	entry->cmd = cmd;
+	entry->subprocess.cmd = cmd;
 	entry->supported_capabilities = 0;
-	process = &entry->process;
+	process = &entry->subprocess.process;
 
 	child_process_init(process);
 	process->argv = argv;
@@ -654,7 +659,7 @@ static struct cmd2process *start_multi_file_filter(struct hashmap *hashmap, cons
 	err = start_multi_file_filter_fn(entry);
 	if (err) {
 		error("initialization for external filter '%s' failed", cmd);
-		kill_multi_file_filter(hashmap, entry);
+		kill_multi_file_filter(hashmap, &entry->subprocess);
 		return NULL;
 	}
 
@@ -678,7 +683,7 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
 		hashmap_init(&cmd_process_map, (hashmap_cmp_fn) cmd2process_cmp, 0);
 		entry = NULL;
 	} else {
-		entry = find_multi_file_filter_entry(&cmd_process_map, cmd);
+		entry = (struct cmd2process *)find_multi_file_filter_entry(&cmd_process_map, cmd);
 	}
 
 	fflush(NULL);
@@ -688,7 +693,7 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
 		if (!entry)
 			return 0;
 	}
-	process = &entry->process;
+	process = &entry->subprocess.process;
 
 	if (!(wanted_capability & entry->supported_capabilities))
 		return 0;
@@ -759,7 +764,7 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
 			 * Force shutdown and restart if another blob requires filtering.
 			 */
 			error("external filter '%s' failed", cmd);
-			kill_multi_file_filter(&cmd_process_map, entry);
+			kill_multi_file_filter(&cmd_process_map, &entry->subprocess);
 		}
 	} else {
 		strbuf_swap(dst, &nbuf);
-- 
2.12.2.gvfs.2.20.g3624a68d62.dirty

