Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A292A1F62E
	for <e@80x24.org>; Tue, 15 Jan 2019 20:00:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389583AbfAOUAE (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Jan 2019 15:00:04 -0500
Received: from mail-qk1-f202.google.com ([209.85.222.202]:36356 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389574AbfAOUAE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jan 2019 15:00:04 -0500
Received: by mail-qk1-f202.google.com with SMTP id b185so3295542qkc.3
        for <git@vger.kernel.org>; Tue, 15 Jan 2019 12:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=fpFAdNMUSS3fKkeXvKGp/lQ4r5eDqqye8TnYQc5cnwM=;
        b=kMNC9PfEMNHjFlQDZkni7p8GXLiE7+A5uLF2P5Stl1jGEjxi85TQul1FPQrEuljBAo
         HkMY13/RGq7f10c5Ua0sJz4OGnkgYyHxIy8HUUiWSHKTOo/B8iPtRKw3zSkIXn1epsLa
         3HgBzftBTSCgbn9NMyi09QwqcYnER3hc/FAUlZDTlzYl/folQhCNqJOb16wmnoR2Q+pk
         1D8f/pzhH4GMGkgDHg0BG3RjKWSzUWl118YkXzpYtnnebUU1LLddWxZJexq28riuIgrs
         4T8qzi7QgjX2OS6Xkr+h8icnxTR9EPtClxNtP1se/qRu7rw7ElwyKCrJqm6rfzLmaf63
         /bPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fpFAdNMUSS3fKkeXvKGp/lQ4r5eDqqye8TnYQc5cnwM=;
        b=Y9s3K4FGxf5L5QdwUO5THHLcxhjC1o24zeOix5HQF6m7OnQruZtNg75GKugsByw8xF
         AwOoVnyLgmfyZy9BGaodZegRzmd/a05O9hop4ymRChbpjMtj5CeUOI1LI6/PrUH2T6QA
         RNT3frseT8C02oOTULtPpcMvR6pPBaTvctqH+s34/JdrliE+aj2QVpJj8/F7WTOAY1w6
         WWzpbYxHITlB5PpEdlL12G/9auES6JpoHsxsTEmcY+MEfpRInWwZ6rOFw1BpPkTp9Ng7
         ebWfp80XTQCtGlSDHv40+Kl+LgbljFUCg8Fs0SEcsbAyM0E/eNxNE8XkCzcp2OjPm/En
         Ngsg==
X-Gm-Message-State: AJcUukeZ2F3RSgqSOfsyhIAXXmoHDwFy/hfSErI+5qCMj+UyHLfzLnPD
        13G7Bb79Wil6gFYHs5da10grGYJlY9PdM2691EloTGccgcXJOOywUHGMfk08mlJe23dBXll7Y0Y
        VqhCYpamZuDFhDYy5JgzsSPwt9gl67gNTcPdc3/gUsTDUJ/MvhUejw/ZvaS66FRc=
X-Google-Smtp-Source: ALg8bN4wICCuP7ZVUQYD7AsVm9APH5GtZrBCCoOSbbY6S+hbh+2T0sU5Qj3HJo/KJM7+qbxXf6kxIfzaU+QJIA==
X-Received: by 2002:ac8:32d6:: with SMTP id a22mr2971001qtb.58.1547582402722;
 Tue, 15 Jan 2019 12:00:02 -0800 (PST)
Date:   Tue, 15 Jan 2019 11:59:53 -0800
In-Reply-To: <cover.1547582104.git.steadmon@google.com>
Message-Id: <0b57ecbe1b6c72d95311ba1bb30ea1ed9fd7e3e5.1547582104.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1544048946.git.steadmon@google.com> <cover.1547582104.git.steadmon@google.com>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
Subject: [PATCH v5 1/3] commit-graph, fuzz: Add fuzzer for commit-graph
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, stolee@gmail.com, avarab@gmail.com,
        peff@peff.net, szeder.dev@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Breaks load_commit_graph_one() into a new function,
parse_commit_graph(). The latter function operates on arbitrary buffers,
which makes it suitable as a fuzzing target. Since parse_commit_graph()
is only called by load_commit_graph_one() (and the fuzzer described
below), we omit error messages that would be duplicated by the caller.

Adds fuzz-commit-graph.c, which provides a fuzzing entry point
compatible with libFuzzer (and possibly other fuzzing engines).

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 .gitignore          |  1 +
 Makefile            |  1 +
 commit-graph.c      | 53 ++++++++++++++++++++++++++++++---------------
 commit-graph.h      |  3 +++
 fuzz-commit-graph.c | 16 ++++++++++++++
 5 files changed, 57 insertions(+), 17 deletions(-)
 create mode 100644 fuzz-commit-graph.c

diff --git a/.gitignore b/.gitignore
index 0d77ea5894..8bcf153ed9 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1,3 +1,4 @@
+/fuzz-commit-graph
 /fuzz_corpora
 /fuzz-pack-headers
 /fuzz-pack-idx
diff --git a/Makefile b/Makefile
index 1a44c811aa..6b72f37c29 100644
--- a/Makefile
+++ b/Makefile
@@ -684,6 +684,7 @@ SCRIPTS = $(SCRIPT_SH_INS) \
 
 ETAGS_TARGET = TAGS
 
+FUZZ_OBJS += fuzz-commit-graph.o
 FUZZ_OBJS += fuzz-pack-headers.o
 FUZZ_OBJS += fuzz-pack-idx.o
 
diff --git a/commit-graph.c b/commit-graph.c
index 40c855f185..07dd410f3c 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -84,16 +84,10 @@ static int commit_graph_compatible(struct repository *r)
 struct commit_graph *load_commit_graph_one(const char *graph_file)
 {
 	void *graph_map;
-	const unsigned char *data, *chunk_lookup;
 	size_t graph_size;
 	struct stat st;
-	uint32_t i;
-	struct commit_graph *graph;
+	struct commit_graph *ret;
 	int fd = git_open(graph_file);
-	uint64_t last_chunk_offset;
-	uint32_t last_chunk_id;
-	uint32_t graph_signature;
-	unsigned char graph_version, hash_version;
 
 	if (fd < 0)
 		return NULL;
@@ -108,27 +102,55 @@ struct commit_graph *load_commit_graph_one(const char *graph_file)
 		die(_("graph file %s is too small"), graph_file);
 	}
 	graph_map = xmmap(NULL, graph_size, PROT_READ, MAP_PRIVATE, fd, 0);
+	ret = parse_commit_graph(graph_map, fd, graph_size);
+
+	if (!ret) {
+		munmap(graph_map, graph_size);
+		close(fd);
+		exit(1);
+	}
+
+	return ret;
+}
+
+struct commit_graph *parse_commit_graph(void *graph_map, int fd,
+					size_t graph_size)
+{
+	const unsigned char *data, *chunk_lookup;
+	uint32_t i;
+	struct commit_graph *graph;
+	uint64_t last_chunk_offset;
+	uint32_t last_chunk_id;
+	uint32_t graph_signature;
+	unsigned char graph_version, hash_version;
+
+	if (!graph_map)
+		return NULL;
+
+	if (graph_size < GRAPH_MIN_SIZE)
+		return NULL;
+
 	data = (const unsigned char *)graph_map;
 
 	graph_signature = get_be32(data);
 	if (graph_signature != GRAPH_SIGNATURE) {
 		error(_("graph signature %X does not match signature %X"),
 		      graph_signature, GRAPH_SIGNATURE);
-		goto cleanup_fail;
+		return NULL;
 	}
 
 	graph_version = *(unsigned char*)(data + 4);
 	if (graph_version != GRAPH_VERSION) {
 		error(_("graph version %X does not match version %X"),
 		      graph_version, GRAPH_VERSION);
-		goto cleanup_fail;
+		return NULL;
 	}
 
 	hash_version = *(unsigned char*)(data + 5);
 	if (hash_version != GRAPH_OID_VERSION) {
 		error(_("hash version %X does not match version %X"),
 		      hash_version, GRAPH_OID_VERSION);
-		goto cleanup_fail;
+		return NULL;
 	}
 
 	graph = alloc_commit_graph();
@@ -152,7 +174,8 @@ struct commit_graph *load_commit_graph_one(const char *graph_file)
 		if (chunk_offset > graph_size - GIT_MAX_RAWSZ) {
 			error(_("improper chunk offset %08x%08x"), (uint32_t)(chunk_offset >> 32),
 			      (uint32_t)chunk_offset);
-			goto cleanup_fail;
+			free(graph);
+			return NULL;
 		}
 
 		switch (chunk_id) {
@@ -187,7 +210,8 @@ struct commit_graph *load_commit_graph_one(const char *graph_file)
 
 		if (chunk_repeated) {
 			error(_("chunk id %08x appears multiple times"), chunk_id);
-			goto cleanup_fail;
+			free(graph);
+			return NULL;
 		}
 
 		if (last_chunk_id == GRAPH_CHUNKID_OIDLOOKUP)
@@ -201,11 +225,6 @@ struct commit_graph *load_commit_graph_one(const char *graph_file)
 	}
 
 	return graph;
-
-cleanup_fail:
-	munmap(graph_map, graph_size);
-	close(fd);
-	exit(1);
 }
 
 static void prepare_commit_graph_one(struct repository *r, const char *obj_dir)
diff --git a/commit-graph.h b/commit-graph.h
index 9db40b4d3a..813e7c19f1 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -54,6 +54,9 @@ struct commit_graph {
 
 struct commit_graph *load_commit_graph_one(const char *graph_file);
 
+struct commit_graph *parse_commit_graph(void *graph_map, int fd,
+					size_t graph_size);
+
 /*
  * Return 1 if and only if the repository has a commit-graph
  * file and generation numbers are computed in that file.
diff --git a/fuzz-commit-graph.c b/fuzz-commit-graph.c
new file mode 100644
index 0000000000..cf790c9d04
--- /dev/null
+++ b/fuzz-commit-graph.c
@@ -0,0 +1,16 @@
+#include "commit-graph.h"
+
+struct commit_graph *parse_commit_graph(void *graph_map, int fd,
+					size_t graph_size);
+
+int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size);
+
+int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
+{
+	struct commit_graph *g;
+
+	g = parse_commit_graph((void *)data, -1, size);
+	free(g);
+
+	return 0;
+}
-- 
2.20.1.97.g81188d93c3-goog

