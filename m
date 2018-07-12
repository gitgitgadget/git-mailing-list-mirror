Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06B041F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 19:40:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732338AbeGLTvP (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 15:51:15 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:41647 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732284AbeGLTvO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 15:51:14 -0400
Received: by mail-qt0-f194.google.com with SMTP id e19-v6so10954058qtp.8
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 12:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XS+Ap3JGGDfZ79XlVqTKZ8+kwSjK/xQPxsWFVWBMoLQ=;
        b=XIe40JlV6zAsdeX7N3DbmlfoHxsbDAXU/UQsLNsU6O4PnAJCMEPU2aLNkesBcld+qx
         V7XM+lv7PE4vg57rLEDAoeVDxADah3l4ZbLp8jSXlojflCdcqjgAXfvTe17dBMMK9i/5
         5qnOeA4iY3S2pYJVEnxH+F9rksfBkGNDCasTKOt2KbrUZXz/ZXJRr5qC9mMTaDPFYrf/
         z0Dj8YYwDBNoUp3SdA1y6RxtTk9gVJf7y36i3IJzSndgepNz40gKcWrzGDmw92LRk/0L
         MsQkE1INeZMqk+TtyZTIuYNZ1BnqqOJME9OJQ7dnlwshRnnGDCH0oD9rFUeoSjT5Yj3f
         xLcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XS+Ap3JGGDfZ79XlVqTKZ8+kwSjK/xQPxsWFVWBMoLQ=;
        b=uNoJPTwg9ZQrWL9/JCSEgHbvFNWpKsQ9QrrREmZkR8AwXbtgc54/dFYxGU8tyrXVb+
         MErKNjNoYsA6OePY+n5AxNx6aHMMUXKhm/2M2/A/mHGH+qUW6Yoki8vuemcPGCtdc8xK
         b5pyml6+aqQs7VJixa6J1xw7hmgkxjIG6hfgMn06B2N0hf+miDdGZc1aeA+UlmB1pZiN
         GxtgqNTN8xfvoWUUgdBty8lLULX+OKZLqY4uKpGd3AnPyS2G/7+zY9QUoaEyklGoQErW
         UpCgzohgDRVRaGR2Miaj4jSEqpeLppYfzbfzs2Qd9SO/A8eB74bTK0IbuWEKjxQtG7Z4
         iDOg==
X-Gm-Message-State: AOUpUlEve0hSTGhw9ImB0VW1SV5mnjDrVBBK24C2tiRA/anJNyzw5iaV
        jdGBLuR2IcTz8ZaiGLTU4hVVoQUbRak=
X-Google-Smtp-Source: AAOMgpdrXSTIqdo6HaweQmiqiNpp5BS9LU4lsAAWmVSUBR/cDtKDjd4Nk7B3Q0m0Zzl+IwwbhNBjZQ==
X-Received: by 2002:aed:3c34:: with SMTP id t49-v6mr3004856qte.404.1531424414558;
        Thu, 12 Jul 2018 12:40:14 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id j5-v6sm14247756qte.57.2018.07.12.12.40.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 12:40:14 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org, dstolee@microsoft.com
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com,
        avarab@gmail.com, sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: [PATCH v4 06/23] multi-pack-index: load into memory
Date:   Thu, 12 Jul 2018 15:39:23 -0400
Message-Id: <20180712193940.21065-7-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.118.gd4f65b8d14
In-Reply-To: <20180712193940.21065-1-dstolee@microsoft.com>
References: <20180706005321.124643-1-dstolee@microsoft.com>
 <20180712193940.21065-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create a new multi_pack_index struct for loading multi-pack-indexes into
memory. Create a test-tool builtin for reading basic information about
that multi-pack-index to verify the correct data is written.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Makefile                    |  1 +
 midx.c                      | 79 +++++++++++++++++++++++++++++++++++++
 midx.h                      | 18 +++++++++
 object-store.h              |  2 +
 t/helper/test-read-midx.c   | 31 +++++++++++++++
 t/helper/test-tool.c        |  1 +
 t/helper/test-tool.h        |  1 +
 t/t5319-multi-pack-index.sh | 11 +++++-
 8 files changed, 143 insertions(+), 1 deletion(-)
 create mode 100644 t/helper/test-read-midx.c

diff --git a/Makefile b/Makefile
index f5636c711d..0b801d1b16 100644
--- a/Makefile
+++ b/Makefile
@@ -717,6 +717,7 @@ TEST_BUILTINS_OBJS += test-online-cpus.o
 TEST_BUILTINS_OBJS += test-path-utils.o
 TEST_BUILTINS_OBJS += test-prio-queue.o
 TEST_BUILTINS_OBJS += test-read-cache.o
+TEST_BUILTINS_OBJS += test-read-midx.o
 TEST_BUILTINS_OBJS += test-ref-store.o
 TEST_BUILTINS_OBJS += test-regex.o
 TEST_BUILTINS_OBJS += test-revision-walking.o
diff --git a/midx.c b/midx.c
index f85f2d334d..c1ff5acf85 100644
--- a/midx.c
+++ b/midx.c
@@ -1,18 +1,97 @@
 #include "cache.h"
 #include "csum-file.h"
 #include "lockfile.h"
+#include "object-store.h"
 #include "midx.h"
 
 #define MIDX_SIGNATURE 0x4d494458 /* "MIDX" */
 #define MIDX_VERSION 1
+#define MIDX_BYTE_FILE_VERSION 4
+#define MIDX_BYTE_HASH_VERSION 5
+#define MIDX_BYTE_NUM_CHUNKS 6
+#define MIDX_BYTE_NUM_PACKS 8
 #define MIDX_HASH_VERSION 1
 #define MIDX_HEADER_SIZE 12
+#define MIDX_HASH_LEN 20
+#define MIDX_MIN_SIZE (MIDX_HEADER_SIZE + MIDX_HASH_LEN)
 
 static char *get_midx_filename(const char *object_dir)
 {
 	return xstrfmt("%s/pack/multi-pack-index", object_dir);
 }
 
+struct multi_pack_index *load_multi_pack_index(const char *object_dir)
+{
+	struct multi_pack_index *m = NULL;
+	int fd;
+	struct stat st;
+	size_t midx_size;
+	void *midx_map = NULL;
+	uint32_t hash_version;
+	char *midx_name = get_midx_filename(object_dir);
+
+	fd = git_open(midx_name);
+
+	if (fd < 0)
+		goto cleanup_fail;
+	if (fstat(fd, &st)) {
+		error_errno(_("failed to read %s"), midx_name);
+		goto cleanup_fail;
+	}
+
+	midx_size = xsize_t(st.st_size);
+
+	if (midx_size < MIDX_MIN_SIZE) {
+		error(_("multi-pack-index file %s is too small"), midx_name);
+		goto cleanup_fail;
+	}
+
+	FREE_AND_NULL(midx_name);
+
+	midx_map = xmmap(NULL, midx_size, PROT_READ, MAP_PRIVATE, fd, 0);
+
+	FLEX_ALLOC_MEM(m, object_dir, object_dir, strlen(object_dir));
+	m->fd = fd;
+	m->data = midx_map;
+	m->data_len = midx_size;
+
+	m->signature = get_be32(m->data);
+	if (m->signature != MIDX_SIGNATURE) {
+		error(_("multi-pack-index signature 0x%08x does not match signature 0x%08x"),
+		      m->signature, MIDX_SIGNATURE);
+		goto cleanup_fail;
+	}
+
+	m->version = m->data[MIDX_BYTE_FILE_VERSION];
+	if (m->version != MIDX_VERSION) {
+		error(_("multi-pack-index version %d not recognized"),
+		      m->version);
+		goto cleanup_fail;
+	}
+
+	hash_version = m->data[MIDX_BYTE_HASH_VERSION];
+	if (hash_version != MIDX_HASH_VERSION) {
+		error(_("hash version %u does not match"), hash_version);
+		goto cleanup_fail;
+	}
+	m->hash_len = MIDX_HASH_LEN;
+
+	m->num_chunks = m->data[MIDX_BYTE_NUM_CHUNKS];
+
+	m->num_packs = get_be32(m->data + MIDX_BYTE_NUM_PACKS);
+
+	return m;
+
+cleanup_fail:
+	free(m);
+	free(midx_name);
+	if (midx_map)
+		munmap(midx_map, midx_size);
+	if (0 <= fd)
+		close(fd);
+	return NULL;
+}
+
 static size_t write_midx_header(struct hashfile *f,
 				unsigned char num_chunks,
 				uint32_t num_packs)
diff --git a/midx.h b/midx.h
index dbdbe9f873..0e05051bca 100644
--- a/midx.h
+++ b/midx.h
@@ -1,6 +1,24 @@
 #ifndef __MIDX_H__
 #define __MIDX_H__
 
+struct multi_pack_index {
+	int fd;
+
+	const unsigned char *data;
+	size_t data_len;
+
+	uint32_t signature;
+	unsigned char version;
+	unsigned char hash_len;
+	unsigned char num_chunks;
+	uint32_t num_packs;
+	uint32_t num_objects;
+
+	char object_dir[FLEX_ARRAY];
+};
+
+struct multi_pack_index *load_multi_pack_index(const char *object_dir);
+
 int write_midx_file(const char *object_dir);
 
 #endif
diff --git a/object-store.h b/object-store.h
index d683112fd7..13a766aea8 100644
--- a/object-store.h
+++ b/object-store.h
@@ -84,6 +84,8 @@ struct packed_git {
 	char pack_name[FLEX_ARRAY]; /* more */
 };
 
+struct multi_pack_index;
+
 struct raw_object_store {
 	/*
 	 * Path to the repository's object store.
diff --git a/t/helper/test-read-midx.c b/t/helper/test-read-midx.c
new file mode 100644
index 0000000000..988a487169
--- /dev/null
+++ b/t/helper/test-read-midx.c
@@ -0,0 +1,31 @@
+#include "test-tool.h"
+#include "cache.h"
+#include "midx.h"
+#include "repository.h"
+#include "object-store.h"
+
+static int read_midx_file(const char *object_dir)
+{
+	struct multi_pack_index *m = load_multi_pack_index(object_dir);
+
+	if (!m)
+		return 1;
+
+	printf("header: %08x %d %d %d\n",
+	       m->signature,
+	       m->version,
+	       m->num_chunks,
+	       m->num_packs);
+
+	printf("object-dir: %s\n", m->object_dir);
+
+	return 0;
+}
+
+int cmd__read_midx(int argc, const char **argv)
+{
+	if (argc != 2)
+		usage("read-midx <object-dir>");
+
+	return read_midx_file(argv[1]);
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 805a45de9c..1c3ab36e6c 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -27,6 +27,7 @@ static struct test_cmd cmds[] = {
 	{ "path-utils", cmd__path_utils },
 	{ "prio-queue", cmd__prio_queue },
 	{ "read-cache", cmd__read_cache },
+	{ "read-midx", cmd__read_midx },
 	{ "ref-store", cmd__ref_store },
 	{ "regex", cmd__regex },
 	{ "revision-walking", cmd__revision_walking },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 7116ddfb94..6af8c08a66 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -21,6 +21,7 @@ int cmd__online_cpus(int argc, const char **argv);
 int cmd__path_utils(int argc, const char **argv);
 int cmd__prio_queue(int argc, const char **argv);
 int cmd__read_cache(int argc, const char **argv);
+int cmd__read_midx(int argc, const char **argv);
 int cmd__ref_store(int argc, const char **argv);
 int cmd__regex(int argc, const char **argv);
 int cmd__revision_walking(int argc, const char **argv);
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 50e80f8f2c..506bd8abb8 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -3,10 +3,19 @@
 test_description='multi-pack-indexes'
 . ./test-lib.sh
 
+midx_read_expect () {
+	cat >expect <<-EOF
+	header: 4d494458 1 0 0
+	object-dir: .
+	EOF
+	test-tool read-midx . >actual &&
+	test_cmp expect actual
+}
+
 test_expect_success 'write midx with no packs' '
 	test_when_finished rm -f pack/multi-pack-index &&
 	git multi-pack-index --object-dir=. write &&
-	test_path_is_file pack/multi-pack-index
+	midx_read_expect
 '
 
 test_done
-- 
2.18.0.118.gd4f65b8d14

