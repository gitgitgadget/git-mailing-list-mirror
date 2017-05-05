Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83C0D207B3
	for <e@80x24.org>; Fri,  5 May 2017 15:28:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754816AbdEEP2q (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 11:28:46 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:36540 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752410AbdEEP2n (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 11:28:43 -0400
Received: by mail-qt0-f195.google.com with SMTP id j13so1229671qta.3
        for <git@vger.kernel.org>; Fri, 05 May 2017 08:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Gv7t0QZ4Eo5OJQiLTRKWb93a1siKOZ78Cr4hM4EJdbU=;
        b=XOdKWrQOzAw4j9fK73NQUi8bwfteC5F+VDbEWpn67cHa5NQd0ldQhoVJnw+rZBbyHu
         elWx/MhU5DGzOERvdjQwpFd3IxpFLNGzbOsMoIgym9eeYvT2qzXde7ps6vq8NMPcLLem
         VfagzavdUzM44XJDv7Y9OcUVZpAtUOpPqg4tm51wt2AD3/JiWdwj9GbX5FPWaHreAdcG
         C/Bh71E2dUm2RVS1DrAgYf9BGJuj7zTBqnMLEPnXfNV7u1gHXFYTpHBubw/gV9YPUUIY
         5wbHytWN/gz+KLV5FbrPt/cwGvUqZImxWsbeOUs4OSJtsjB9aNNGziPzTtnF3mJNr+bj
         Tapg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Gv7t0QZ4Eo5OJQiLTRKWb93a1siKOZ78Cr4hM4EJdbU=;
        b=bNch9MVoU3YohY8M4SnDlroOX2ts8CzjEhzhq5S/43FCUHjCVuA8bmqVRmEAe74Cxh
         dfXOMS+RVicj34yb+O6WvRJAtrcI2grFEAcU20gyOdu0ZJyGlRHffa6EakgfcjI/FMxI
         5C7a2EZL09CE3tfumkNpob/OJ+Ys2e15Sgikf6ndD0c9XDO0XEgWpFYjve4fnaNZEc19
         UlEG9btU52keUMwK5Qdj8hq6CvDWfJMkeFCXWEwvSOSMx+KbrHr5ruSXc/D5CVGW6pjG
         J9sOrTm7cVzEOIF8jY+1f44PdtZ+THQa0CD2VhaJT4/FPwWlL+g2xJQ28Cs7R/cEPu0C
         xl2w==
X-Gm-Message-State: AN3rC/7G4J00zN6061ON53XImn8SnSKTG7fUv+mVhJdNPwxN61WEF4j9
        Avbr0zz53LrGaQ==
X-Received: by 10.237.62.200 with SMTP id o8mr11407154qtf.152.1493998122307;
        Fri, 05 May 2017 08:28:42 -0700 (PDT)
Received: from localhost.localdomain ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id t68sm3392792qkc.44.2017.05.05.08.28.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 May 2017 08:28:41 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
X-Google-Original-From: Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, benpeart@microsoft.com,
        christian.couder@gmail.com, larsxschneider@gmail.com, peff@peff.net
Subject: [PATCH v7 05/10] convert: split start_multi_file_filter() into two separate functions
Date:   Fri,  5 May 2017 11:27:57 -0400
Message-Id: <20170505152802.6724-6-benpeart@microsoft.com>
X-Mailer: git-send-email 2.12.2.gvfs.2.20.g3624a68d62.dirty
In-Reply-To: <20170505152802.6724-1-benpeart@microsoft.com>
References: <20170505152802.6724-1-benpeart@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To enable future reuse of the filter.<driver>.process infrastructure,
split start_multi_file_filter() into two separate parts.

start_multi_file_filter() will now only contain the generic logic to
manage the creation and tracking of the child process in a hashmap.

start_multi_file_filter_fn() is a protocol specific initialization
function that will negotiate the multi-file-filter interface version
and capabilities.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 convert.c | 58 ++++++++++++++++++++++++++++++++++------------------------
 1 file changed, 34 insertions(+), 24 deletions(-)

diff --git a/convert.c b/convert.c
index 1f18d947b9..4e1d018577 100644
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
 
@@ -642,6 +621,37 @@ static struct cmd2process *start_multi_file_filter(struct hashmap *hashmap, cons
 done:
 	sigchain_pop(SIGPIPE);
 
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
 	if (err) {
 		error("initialization for external filter '%s' failed", cmd);
 		kill_multi_file_filter(hashmap, entry);
-- 
2.12.2.gvfs.2.20.g3624a68d62.dirty

