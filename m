Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 323B21F516
	for <e@80x24.org>; Wed, 27 Jun 2018 13:26:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965430AbeF0NZ7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 09:25:59 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:37379 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965431AbeF0NZd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 09:25:33 -0400
Received: by mail-qk0-f196.google.com with SMTP id t79-v6so994906qke.4
        for <git@vger.kernel.org>; Wed, 27 Jun 2018 06:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=534AvYRqgEJ7fzeKrAyI/rTfuq4cAObUQp5a8JtEuno=;
        b=RWFCJIle0Gae04KIhbXuTbbOb+pDjs2TmHGRIrULtfmE+L5hw7PJSdOSwFRoJHhuBC
         kNtfcQXfYOrrpUNEX0QhbE95ZZui1cmWQA+ze/vwu0mB/DxEpQlqC86XabDaZrGwUzkj
         VPDiN0+TibExgDMYDcaerlBcMaFmPd83Pa2hExQi2hxK2ZH3xihLhtAX/01Sr08GCXYq
         WnMQIiOQyheGZ9mGpcMmtIp7QubLd5yz4DHwTflZJBmP/PoN89G4rBW9fX9eXs0KpS78
         jswXQr+pz/ScOC+o4vMmMd7XBHmAKGP/wJHPcpjwHDhJUDO34MaLaDy0krp7SvlyLgs5
         sPaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=534AvYRqgEJ7fzeKrAyI/rTfuq4cAObUQp5a8JtEuno=;
        b=WlrFlKORhYaZLEWjgkJ+FwCHTbx5i94kAKVQpHBuK/2VNBdqQ54+P3gKoSvDIqiMS8
         ePeN5vVl90fI8aNwM4y3tCoLI7kzR29ANMzLXK2rjE+GVVIvnxVVh0Du5cYCo7TwV83+
         DcNfUEpfzdwKD7yFp16hCq/f0BMPpDwOAk2IhvgfG92E+sogjFbFF9vhyWfCflZgz+xo
         kV92M4jpLRSpherpNoWvjB3k485S2+e9oBs921q7QGPM6+VDELA++rC+Yj94GkSgztvr
         0GeU5PBQL0ztUhDIn78Lz9TrTpgBMty9h3Uz9wjCKdL7Ac/HIsDbV1yIKD43ADaSh+xi
         oJDQ==
X-Gm-Message-State: APt69E2jGqtZGDOkJUbxOM7jLevE8TnaTkann9YL4uqDSLAbrgMPOkkW
        se/SmFwLl83V3x5cEOZPSCK3k6lolo4=
X-Google-Smtp-Source: AAOMgpdL673Q15T5W5uWO98hIqv/UZl071DrwdNiH00VPXPIwtcjvkpam+iZQ4+n0tomVF0CPO7RiQ==
X-Received: by 2002:a37:9e17:: with SMTP id h23-v6mr4826198qke.269.1530105932879;
        Wed, 27 Jun 2018 06:25:32 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id 15-v6sm3761019qtv.56.2018.06.27.06.25.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 06:25:32 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com, sbeller@google.com,
        jnareb@gmail.com, marten.agren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v7 19/22] commit-graph: use string-list API for input
Date:   Wed, 27 Jun 2018 09:24:44 -0400
Message-Id: <20180627132447.142473-20-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.24.g1b579a2ee9
In-Reply-To: <20180627132447.142473-1-dstolee@microsoft.com>
References: <20180608135548.216405-1-dstolee@microsoft.com>
 <20180627132447.142473-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/commit-graph.c | 39 +++++++++++++--------------------------
 commit-graph.c         | 15 +++++++--------
 commit-graph.h         |  7 +++----
 3 files changed, 23 insertions(+), 38 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 9d108f43a9..ea28bc311a 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -119,13 +119,9 @@ static int graph_read(int argc, const char **argv)
 
 static int graph_write(int argc, const char **argv)
 {
-	const char **pack_indexes = NULL;
-	int packs_nr = 0;
-	const char **commit_hex = NULL;
-	int commits_nr = 0;
-	const char **lines = NULL;
-	int lines_nr = 0;
-	int lines_alloc = 0;
+	struct string_list *pack_indexes = NULL;
+	struct string_list *commit_hex = NULL;
+	struct string_list lines;
 
 	static struct option builtin_commit_graph_write_options[] = {
 		OPT_STRING(0, "object-dir", &opts.obj_dir,
@@ -149,34 +145,25 @@ static int graph_write(int argc, const char **argv)
 	if (!opts.obj_dir)
 		opts.obj_dir = get_object_directory();
 
+	string_list_init(&lines, 0);
 	if (opts.stdin_packs || opts.stdin_commits) {
 		struct strbuf buf = STRBUF_INIT;
-		lines_nr = 0;
-		lines_alloc = 128;
-		ALLOC_ARRAY(lines, lines_alloc);
-
-		while (strbuf_getline(&buf, stdin) != EOF) {
-			ALLOC_GROW(lines, lines_nr + 1, lines_alloc);
-			lines[lines_nr++] = strbuf_detach(&buf, NULL);
-		}
-
-		if (opts.stdin_packs) {
-			pack_indexes = lines;
-			packs_nr = lines_nr;
-		}
-		if (opts.stdin_commits) {
-			commit_hex = lines;
-			commits_nr = lines_nr;
-		}
+
+		while (strbuf_getline(&buf, stdin) != EOF)
+			string_list_append(&lines, strbuf_detach(&buf, NULL));
+
+		if (opts.stdin_packs)
+			pack_indexes = &lines;
+		if (opts.stdin_commits)
+			commit_hex = &lines;
 	}
 
 	write_commit_graph(opts.obj_dir,
 			   pack_indexes,
-			   packs_nr,
 			   commit_hex,
-			   commits_nr,
 			   opts.append);
 
+	string_list_clear(&lines, 0);
 	return 0;
 }
 
diff --git a/commit-graph.c b/commit-graph.c
index d926c4b59f..a06e7e9549 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -657,10 +657,8 @@ static void compute_generation_numbers(struct packed_commit_list* commits)
 }
 
 void write_commit_graph(const char *obj_dir,
-			const char **pack_indexes,
-			int nr_packs,
-			const char **commit_hex,
-			int nr_commits,
+			struct string_list *pack_indexes,
+			struct string_list *commit_hex,
 			int append)
 {
 	struct packed_oid_list oids;
@@ -701,10 +699,10 @@ void write_commit_graph(const char *obj_dir,
 		int dirlen;
 		strbuf_addf(&packname, "%s/pack/", obj_dir);
 		dirlen = packname.len;
-		for (i = 0; i < nr_packs; i++) {
+		for (i = 0; i < pack_indexes->nr; i++) {
 			struct packed_git *p;
 			strbuf_setlen(&packname, dirlen);
-			strbuf_addstr(&packname, pack_indexes[i]);
+			strbuf_addstr(&packname, pack_indexes->items[i].string);
 			p = add_packed_git(packname.buf, packname.len, 1);
 			if (!p)
 				die("error adding pack %s", packname.buf);
@@ -717,12 +715,13 @@ void write_commit_graph(const char *obj_dir,
 	}
 
 	if (commit_hex) {
-		for (i = 0; i < nr_commits; i++) {
+		for (i = 0; i < commit_hex->nr; i++) {
 			const char *end;
 			struct object_id oid;
 			struct commit *result;
 
-			if (commit_hex[i] && parse_oid_hex(commit_hex[i], &oid, &end))
+			if (commit_hex->items[i].string &&
+			    parse_oid_hex(commit_hex->items[i].string, &oid, &end))
 				continue;
 
 			result = lookup_commit_reference_gently(&oid, 1);
diff --git a/commit-graph.h b/commit-graph.h
index 4359812fb4..a79b854470 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -3,6 +3,7 @@
 
 #include "git-compat-util.h"
 #include "repository.h"
+#include "string-list.h"
 
 char *get_commit_graph_filename(const char *obj_dir);
 
@@ -48,10 +49,8 @@ struct commit_graph {
 struct commit_graph *load_commit_graph_one(const char *graph_file);
 
 void write_commit_graph(const char *obj_dir,
-			const char **pack_indexes,
-			int nr_packs,
-			const char **commit_hex,
-			int nr_commits,
+			struct string_list *pack_indexes,
+			struct string_list *commit_hex,
 			int append);
 
 int verify_commit_graph(struct repository *r, struct commit_graph *g);
-- 
2.18.0.24.g1b579a2ee9

