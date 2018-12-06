Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17961211B3
	for <e@80x24.org>; Thu,  6 Dec 2018 20:21:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725992AbeLFUVC (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Dec 2018 15:21:02 -0500
Received: from mail-it1-f202.google.com ([209.85.166.202]:54966 "EHLO
        mail-it1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbeLFUVB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Dec 2018 15:21:01 -0500
Received: by mail-it1-f202.google.com with SMTP id v3so2085868itf.4
        for <git@vger.kernel.org>; Thu, 06 Dec 2018 12:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to;
        bh=gwZtDpoGnu21O01jfzVOUe1snbShvKUuZXtAmKAnEjk=;
        b=VeaoaeCvva3HBQwM24dgznE+acreCKopnPGUpG5V9k/9HHr0Xw7vLQR2ZJyMqHK+2E
         9YMDfJMru00m0dtUGMFzPjpG0UTCdCqMoVMnpW1EMDnMjT+cwlA0SqmtzIcQrCq5CQht
         Ckm8dwtxkWF28OmQzYh72akm1XUTOMUFLEuniTjHkZI8UtmSeFnrqpXrXSjAKmAuswyc
         0+PjcyWw6XGwTxvzQz3XmWiBr3Eisv1nAUd773kXEHHeWpbJVTlWwl/XfFkIQTg/ZTLs
         RCeCdHYJzW3OFNMpN0Xce66X+vCyTqEZ+DaK+Cvv+WUCySfmrKqnlHRIMaZKtov0Uija
         hcqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=gwZtDpoGnu21O01jfzVOUe1snbShvKUuZXtAmKAnEjk=;
        b=rsz8LK+zt76nKD2mrU3yw8wHK9YDua3mLvSya1h9m8VebMtd+ylOk1XFkUK5SZ9lt3
         ogWLquuizJEQIe2dHCziS2RojMaNo+sKqIVseimq9qVRSt6s66Xmiq6SUFCm2fph49tC
         ycaWvXHysA6J6lcngGI2xXkXP8X5X6RNmc2/Y2zzEjg3LxRUEPtr7WGIdQP9INXYD2Fj
         RosWpi22Yco5e3aDTqJf1+qA92ooX7BPMqnu6x6OY5GmzwMVzHAlN/OG4hSjsuq1rhEl
         +YjXL+EubniNz+2ZZYtWYszn9/LEbcN4SWlyiwR/JmXmwRnta4rjI0Lgg4qD6JwQZlLx
         deFw==
X-Gm-Message-State: AA+aEWb7PGzCbRHqC+u8CJwJ2Fx8jAznk9HeXKPqeH6MrhHpnG/XkKRJ
        f7jaRCy/Z8TaKG9M6EZqPkIn+vLzdswLx3e1sj1CgRoExFQliY2Jiff1he0JTjBUaoDal9n24jY
        cfaEjBzZlhXOJ5AJjtu8JkuLn6ZNTcI9E7+sXscCFetDlWuE/BF6Xrc9XSnlwswE=
X-Google-Smtp-Source: AFSGD/V82kai32sy5qAxQfDWhWobJEOYyXTHBjFbcIovERJxcCe9KIYWZ21kCx4kqmIPvsECaRNzDe4cEg3crQ==
X-Received: by 2002:a24:334e:: with SMTP id k75mr16256334itk.19.1544127660397;
 Thu, 06 Dec 2018 12:21:00 -0800 (PST)
Date:   Thu,  6 Dec 2018 12:20:53 -0800
In-Reply-To: <cover.1544127439.git.steadmon@google.com>
Message-Id: <0b57ecbe1b6c72d95311ba1bb30ea1ed9fd7e3e5.1544127439.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1544048946.git.steadmon@google.com> <cover.1544127439.git.steadmon@google.com>
X-Mailer: git-send-email 2.20.0.rc2.403.gdbc3b29805-goog
Subject: [PATCH v2 1/3] commit-graph, fuzz: Add fuzzer for commit-graph
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org, gitster@pobox.com, stolee@gmail.com,
        avarab@gmail.com
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
2.20.0.rc2.10.g7519fc76df

