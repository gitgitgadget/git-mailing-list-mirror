Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 386DB20966
	for <e@80x24.org>; Fri,  7 Apr 2017 12:04:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933529AbdDGMEn (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Apr 2017 08:04:43 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:36846 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933497AbdDGMEe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2017 08:04:34 -0400
Received: by mail-yw0-f195.google.com with SMTP id y207so1501784ywa.3
        for <git@vger.kernel.org>; Fri, 07 Apr 2017 05:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NKW9pOUQ0uJ5s6SGw6leruLUgRibZJqbykWCUudAUXs=;
        b=BgW471JUfckDlvGriAPt2IzWpK+wqvPt7n8cOes/hpEIAjwWo6EAaYJSxijXjSRZUJ
         8tWYdelJ65wskWHgaOZFaVJjdSrULO01caAGbt3spW9LlS4GBe+ztio+GgcKWLMm37RG
         T0/VVQ9T4egSOOYG5qPA7gVjMEvCpbXTpZYG1uW4dF+IPWb8LthKFUQcUMHczpEmEqKX
         n03xbetkXgSPcCD6xoDy1Rowq0S7nmgSVMDK7OZtysn27l28QH6BQmlVKNcAFDocvtUD
         IYKOqKeFA1wfkl7H8/6q+mIE2WzTVaD6v1omI5108VYNYVePNXEbVrWQ6zSxuJz/pkfr
         I8QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NKW9pOUQ0uJ5s6SGw6leruLUgRibZJqbykWCUudAUXs=;
        b=n/JgZvHj9JrvGiUo4ViKmHyIOUQvHxiYVXodPrgghd+zEcWiVa1eSbyqE9CYZXgUmY
         izJ1fLFWvysPPDsMLaFaIA7yAklmKDtlECNSBmIrv41RxRzWU2/mvFlJjLdZp8VjqSvJ
         PYGoUbDw4ecq/thnTWzN7ddEMtj4TZgKjEYobjoOvJQki3gTBBDlmffTBb7X6cgI76WS
         SqY85AB6+RHnOS2SsSD8ElY/FOedoQ0PINMIFjiNY+VsHh0HF2Yrf4x/rO5rxDWpIfzb
         tQ9mPCkrryb+zIW9gNdX4zaQDtFTEEaLRalRBjb/ECNFgv6KHVCAB3cyDTkAPc3lqT6M
         3dNA==
X-Gm-Message-State: AFeK/H0xW7uuSoRPPdTpn6Vbm6FKlnGtLkKYHq4gbaLU6W+pavaexCVBuHdlg4Cwei362w==
X-Received: by 10.129.182.34 with SMTP id u34mr26225951ywh.6.1491566668238;
        Fri, 07 Apr 2017 05:04:28 -0700 (PDT)
Received: from localhost.localdomain ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id z194sm1874038ywg.73.2017.04.07.05.04.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 07 Apr 2017 05:04:27 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
X-Google-Original-From: Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, benpeart@microsoft.com,
        christian.couder@gmail.com, larsxschneider@gmail.com
Subject: [PATCH v5 4/8] convert: Separate generic structures and variables from the filter specific ones
Date:   Fri,  7 Apr 2017 08:03:50 -0400
Message-Id: <20170407120354.17736-5-benpeart@microsoft.com>
X-Mailer: git-send-email 2.12.0.windows.1.33.g243d9b384c
In-Reply-To: <20170407120354.17736-1-benpeart@microsoft.com>
References: <20170407120354.17736-1-benpeart@microsoft.com>
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
2.12.0.windows.1.31.g1548525701.dirty

