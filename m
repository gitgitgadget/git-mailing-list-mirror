Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 823A71F403
	for <e@80x24.org>; Thu,  7 Jun 2018 14:04:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932900AbeFGOEs (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Jun 2018 10:04:48 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:40006 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932767AbeFGODu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jun 2018 10:03:50 -0400
Received: by mail-qt0-f196.google.com with SMTP id q6-v6so9926263qtn.7
        for <git@vger.kernel.org>; Thu, 07 Jun 2018 07:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4myJvcDybTc5AzZQzoTV+Z31++JibLVQ2sWnHuAnKmI=;
        b=QElNx+JGicKEjeqt92ljvy2lRYpCjqIDGyNZcOlRWkrHHXOxSb3Zvqw2f8XuNuV3Yt
         JJY4T61hyihb7DmTwlVK2LjpCQVvY5plL5l7kjjUb6JGT0sP9MifAYjpkHP2GPjhhg8H
         SAsmrd2zlCQeA29kXBVEnUNrTZLBKiEn2zw/zpls5l/fDUtZzbe0lR9BSMEMRxOPhnEX
         Ocpi1OZiIvLs429gAA3KeTQYxDKi4K0JxJQfBLcR/c21oGu+HnGBV8v4xW3iLJVO0khY
         8KKKKWeF2y69HAdvY/ioxi5ic5w7szipEwdmXj1gugXPpoAhbsv4K+9HXH8gpwavCtC2
         cvKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4myJvcDybTc5AzZQzoTV+Z31++JibLVQ2sWnHuAnKmI=;
        b=dwAk2F6kfrTpgEpi/yZ6b6l0ugaS+RUTMiXsOiqYuMtooSxLvLWctEvrva76QZTX6i
         vhgNxtsT7MVH0pudjvCmHTCNS5yN9A6mO/pTsU8eU+HuFeOKlQhwRNQcZKMrB7pgOjJC
         IGsEE4QYV5t7EoQPdxNm12HvY25Z7SmJN7VcMYKjaw056WU1gqgO4jsXA9wSxKUCqvD+
         64MYRRp7dr1YaIkDZEaljrf/3x5J9NL5VkJQFnnbw4iO6C8esarenV5A9Ng4caWIIna9
         aKkB29JUXd/XCAjXNfVY1ICCwi/VvsWlwmksXmI1vnMKdtIv2WZqdvzaM0FENLPw61Vo
         EJKQ==
X-Gm-Message-State: APt69E0EHizBwdJtmrhdPC4oo1D/pjZp1Y0UbZewBgI8/IeH/5DXdHh9
        xwi+msTW9YawHe4YE63IeYciERWK
X-Google-Smtp-Source: ADUXVKJjMlZeqAmYpoweCYksJIgI/Y8P/jv8nzP2PbeKjyKzDBrzPOLyQiErvxAw3xYPnJBbIHmF7Q==
X-Received: by 2002:a0c:d175:: with SMTP id c50-v6mr1746409qvh.1.1528380229771;
        Thu, 07 Jun 2018 07:03:49 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id u74-v6sm12532763qku.55.2018.06.07.07.03.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 07:03:49 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, dstolee@microsoft.com, avarab@gmail.com,
        jrnieder@gmail.com, jonathantanmy@google.com, mfick@codeaurora.org
Subject: [PATCH 06/23] midx: struct midxed_git and 'read' subcommand
Date:   Thu,  7 Jun 2018 10:03:21 -0400
Message-Id: <20180607140338.32440-7-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.rc1
In-Reply-To: <20180607140338.32440-1-dstolee@microsoft.com>
References: <20180607140338.32440-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As we build the multi-pack-index feature by adding chunks at a time,
we want to test that the data is being written correctly.

Create struct midxed_git to store an in-memory representation of a
multi-pack-index and a memory-map of the binary file. Initialize this
struct in load_midxed_git(object_dir).

Create the 'git midx read' subcommand to output basic information about
the multi-pack-index file. This will be expanded as more information is
written to the file.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-midx.txt | 11 +++++++
 builtin/midx.c             | 23 +++++++++++++-
 midx.c                     | 65 ++++++++++++++++++++++++++++++++++++++
 midx.h                     |  9 ++++++
 object-store.h             | 19 +++++++++++
 t/t5319-midx.sh            | 12 ++++++-
 6 files changed, 137 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-midx.txt b/Documentation/git-midx.txt
index dcaeb1a91b..919283fdd8 100644
--- a/Documentation/git-midx.txt
+++ b/Documentation/git-midx.txt
@@ -23,6 +23,11 @@ OPTIONS
 	<dir>/packs/multi-pack-index for the current MIDX file, and
 	<dir>/packs for the pack-files to index.
 
+read::
+	When given as the verb, read the current MIDX file and output
+	basic information about its contents. Used for debugging
+	purposes only.
+
 write::
 	When given as the verb, write a new MIDX file to
 	<dir>/packs/multi-pack-index.
@@ -43,6 +48,12 @@ $ git midx write
 $ git midx --object-dir <alt> write
 -------------------------------------------
 
+* Read the MIDX file in the .git/objects folder.
++
+-------------------------------------------
+$ git midx read
+-------------------------------------------
+
 
 GIT
 ---
diff --git a/builtin/midx.c b/builtin/midx.c
index dc0a5acd3f..c7002f664a 100644
--- a/builtin/midx.c
+++ b/builtin/midx.c
@@ -6,7 +6,7 @@
 #include "midx.h"
 
 static char const * const builtin_midx_usage[] ={
-	N_("git midx [--object-dir <dir>] [write]"),
+	N_("git midx [--object-dir <dir>] [read|write]"),
 	NULL
 };
 
@@ -14,6 +14,25 @@ static struct opts_midx {
 	const char *object_dir;
 } opts;
 
+static int read_midx_file(const char *object_dir)
+{
+	struct midxed_git *m = load_midxed_git(object_dir);
+
+	if (!m)
+		return 0;
+
+	printf("header: %08x %d %d %d %d\n",
+	       m->signature,
+	       m->version,
+	       m->hash_version,
+	       m->num_chunks,
+	       m->num_packs);
+
+	printf("object_dir: %s\n", m->object_dir);
+
+	return 0;
+}
+
 int cmd_midx(int argc, const char **argv, const char *prefix)
 {
 	static struct option builtin_midx_options[] = {
@@ -38,6 +57,8 @@ int cmd_midx(int argc, const char **argv, const char *prefix)
 	if (argc == 0)
 		return 0;
 
+	if (!strcmp(argv[0], "read"))
+		return read_midx_file(opts.object_dir);
 	if (!strcmp(argv[0], "write"))
 		return write_midx_file(opts.object_dir);
 
diff --git a/midx.c b/midx.c
index 3e55422a21..fa18770f1d 100644
--- a/midx.c
+++ b/midx.c
@@ -3,12 +3,15 @@
 #include "dir.h"
 #include "csum-file.h"
 #include "lockfile.h"
+#include "object-store.h"
 #include "midx.h"
 
 #define MIDX_SIGNATURE 0x4d494458 /* "MIDX" */
 #define MIDX_VERSION 1
 #define MIDX_HASH_VERSION 1 /* SHA-1 */
 #define MIDX_HEADER_SIZE 12
+#define MIDX_HASH_LEN 20
+#define MIDX_MIN_SIZE (MIDX_HEADER_SIZE + MIDX_HASH_LEN)
 
 static char *get_midx_filename(const char *object_dir)
 {
@@ -18,6 +21,68 @@ static char *get_midx_filename(const char *object_dir)
 	return strbuf_detach(&midx_name, NULL);
 }
 
+struct midxed_git *load_midxed_git(const char *object_dir)
+{
+	struct midxed_git *m;
+	int fd;
+	struct stat st;
+	size_t midx_size;
+	void *midx_map;
+	const char *midx_name = get_midx_filename(object_dir);
+
+	fd = git_open(midx_name);
+	if (fd < 0)
+		return NULL;
+	if (fstat(fd, &st)) {
+		close(fd);
+		return NULL;
+	}
+	midx_size = xsize_t(st.st_size);
+
+	if (midx_size < MIDX_MIN_SIZE) {
+		close(fd);
+		die("multi-pack-index file %s is too small", midx_name);
+	}
+
+	midx_map = xmmap(NULL, midx_size, PROT_READ, MAP_PRIVATE, fd, 0);
+
+	m = xcalloc(1, sizeof(*m) + strlen(object_dir) + 1);
+	strcpy(m->object_dir, object_dir);
+	m->data = midx_map;
+
+	m->signature = get_be32(m->data);
+	if (m->signature != MIDX_SIGNATURE) {
+		error("multi-pack-index signature %X does not match signature %X",
+		      m->signature, MIDX_SIGNATURE);
+		goto cleanup_fail;
+	}
+
+	m->version = *(m->data + 4);
+	if (m->version != MIDX_VERSION) {
+		error("multi-pack-index version %d not recognized",
+		      m->version);
+		goto cleanup_fail;
+	}
+
+	m->hash_version = *(m->data + 5);
+	if (m->hash_version != MIDX_HASH_VERSION) {
+		error("hash version %d not recognized", m->hash_version);
+		goto cleanup_fail;
+	}
+	m->hash_len = MIDX_HASH_LEN;
+
+	m->num_chunks = *(m->data + 6);
+	m->num_packs = get_be32(m->data + 8);
+
+	return m;
+
+cleanup_fail:
+	FREE_AND_NULL(m);
+	munmap(midx_map, midx_size);
+	close(fd);
+	exit(1);
+}
+
 static size_t write_midx_header(struct hashfile *f,
 				unsigned char num_chunks,
 				uint32_t num_packs)
diff --git a/midx.h b/midx.h
index 3a63673952..a1d18ed991 100644
--- a/midx.h
+++ b/midx.h
@@ -1,4 +1,13 @@
+#ifndef MIDX_H
+#define MIDX_H
+
+#include "git-compat-util.h"
 #include "cache.h"
+#include "object-store.h"
 #include "packfile.h"
 
+struct midxed_git *load_midxed_git(const char *object_dir);
+
 int write_midx_file(const char *object_dir);
+
+#endif
diff --git a/object-store.h b/object-store.h
index d683112fd7..77cb82621a 100644
--- a/object-store.h
+++ b/object-store.h
@@ -84,6 +84,25 @@ struct packed_git {
 	char pack_name[FLEX_ARRAY]; /* more */
 };
 
+struct midxed_git {
+	struct midxed_git *next;
+
+	int fd;
+
+	const unsigned char *data;
+	size_t data_len;
+
+	uint32_t signature;
+	unsigned char version;
+	unsigned char hash_version;
+	unsigned char hash_len;
+	unsigned char num_chunks;
+	uint32_t num_packs;
+	uint32_t num_objects;
+
+	char object_dir[FLEX_ARRAY];
+};
+
 struct raw_object_store {
 	/*
 	 * Path to the repository's object store.
diff --git a/t/t5319-midx.sh b/t/t5319-midx.sh
index 80f9389837..e78514d8e9 100755
--- a/t/t5319-midx.sh
+++ b/t/t5319-midx.sh
@@ -3,9 +3,19 @@
 test_description='multi-pack-indexes'
 . ./test-lib.sh
 
+midx_read_expect() {
+	cat >expect <<- EOF
+	header: 4d494458 1 1 0 0
+	object_dir: .
+	EOF
+	git midx read --object-dir=. >actual &&
+	test_cmp expect actual
+}
+
 test_expect_success 'write midx with no packs' '
 	git midx --object-dir=. write &&
-	test_path_is_file pack/multi-pack-index
+	test_path_is_file pack/multi-pack-index &&
+	midx_read_expect
 '
 
 test_done
-- 
2.18.0.rc1

