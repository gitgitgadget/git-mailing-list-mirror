Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5181D2035A
	for <e@80x24.org>; Tue, 11 Jul 2017 19:48:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934177AbdGKTsn (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 15:48:43 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:33339 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752607AbdGKTsm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 15:48:42 -0400
Received: by mail-pf0-f177.google.com with SMTP id e7so1130504pfk.0
        for <git@vger.kernel.org>; Tue, 11 Jul 2017 12:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=7D4DV1y9Sq7J+JiHYoCfAayDXroWDzIdMWOOcHHT10I=;
        b=gYv8keVCBe+QNOcQFeJnRZekZm2eOHpIXeVzq6MfHChvTjZW6JK8arKazU5qSyoce7
         DxAkT1hHtdQe4xFDB/CQer7+QS2uKGAHgtMkQScLcyHMycuBjD/nD8jXL40jFawpP1sk
         iAolCoMpP80xXoVYRD39hkBQYMORkrDrt+HkNDN0V+T/atLTg//fcP/3hlIbRJun6TWf
         uNN7lS+4IfTSxdqs1OXM/roefTjl7kGiatEtoYdAdLdEr2DySkuAbCUI9SER03CUkfkN
         vBxYOgeOygzGC70L/rkOTybwvWF7GKNLXYfNb8h1utM3Wm8blCS+G+5Ya5Ka97EyWNn4
         FMQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=7D4DV1y9Sq7J+JiHYoCfAayDXroWDzIdMWOOcHHT10I=;
        b=rjHPmRKATQUsSmIRQcWuB6JvolAjnJMAQO9Zf7MaMvL3FdWnJMJu6Lg4HQkoE5xJxB
         C3gcgBV1od8XuJxSFHcwNsJvUXsFcCWXrZWznR1rtTp+fSXVNv4zSzYhYj4ydzBME38R
         Z+MG5SeUUPXiogox9h3oGK/n0Ch7lcaoGMZAu0iGkNomDyOesPZ5kHUf/EWAAMZ9s37j
         5I2KDSHSS077NDoALXaDRpdJEDy7xCUEHtvIy2JQP4W8XGh6hs+HWW35ckhtgkGTS7M/
         9ka2Xrbd3LTEiXn1a23w71k0m9YlW6EPlp9ESnVF9GVXZcE1c5G9wufuHStDf+ypClOA
         GTnQ==
X-Gm-Message-State: AIVw113nGDUCT7x2deyceEy0BWMYiwdrKyQIlP8ryb+NXqBjo7EF28lX
        uBPmRntQeQGMVqeQ0nY7lA==
X-Received: by 10.84.172.131 with SMTP id n3mr83201plb.14.1499802520928;
        Tue, 11 Jul 2017 12:48:40 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id 85sm227557pfr.90.2017.07.11.12.48.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Jul 2017 12:48:39 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [RFC PATCH 1/3] promised-blob, fsck: introduce promised blobs
Date:   Tue, 11 Jul 2017 12:48:30 -0700
Message-Id: <f9c7d4b3f800ea31e85e4897ee7048fec1e3c2f0.1499800530.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.13.2.932.g7449e964c-goog
In-Reply-To: <cover.1499800530.git.jonathantanmy@google.com>
References: <cover.1499800530.git.jonathantanmy@google.com>
In-Reply-To: <cover.1499800530.git.jonathantanmy@google.com>
References: <cover.1499800530.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, Git does not support repos with very large numbers of blobs
or repos that wish to minimize manipulation of certain blobs (for
example, because they are very large) very well, even if the user
operates mostly on part of the repo, because Git is designed on the
assumption that every blob referenced by a tree object is available
somewhere in the repo storage.

As a first step to reducing this problem, introduce the concept of
promised blobs. Each Git repo can contain a list of promised blobs and
their sizes at $GIT_DIR/objects/promisedblob. This patch contains
functions to query them; functions for creating and modifying that file
will be introduced in later patches.

A repository that is missing a blob but has that blob promised is not
considered to be in error, so also teach fsck this.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 Makefile                 |  1 +
 builtin/fsck.c           | 13 +++++++
 promised-blob.c          | 95 ++++++++++++++++++++++++++++++++++++++++++++++++
 promised-blob.h          | 14 +++++++
 t/t3907-promised-blob.sh | 29 +++++++++++++++
 t/test-lib-functions.sh  |  6 +++
 6 files changed, 158 insertions(+)
 create mode 100644 promised-blob.c
 create mode 100644 promised-blob.h
 create mode 100755 t/t3907-promised-blob.sh

diff --git a/Makefile b/Makefile
index 9c9c42f8f..e96163269 100644
--- a/Makefile
+++ b/Makefile
@@ -828,6 +828,7 @@ LIB_OBJS += preload-index.o
 LIB_OBJS += pretty.o
 LIB_OBJS += prio-queue.o
 LIB_OBJS += progress.o
+LIB_OBJS += promised-blob.o
 LIB_OBJS += prompt.o
 LIB_OBJS += quote.o
 LIB_OBJS += reachable.o
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 99dea7adf..7454be7f1 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -15,6 +15,7 @@
 #include "progress.h"
 #include "streaming.h"
 #include "decorate.h"
+#include "promised-blob.h"
 
 #define REACHABLE 0x0001
 #define SEEN      0x0002
@@ -223,6 +224,9 @@ static void check_reachable_object(struct object *obj)
 	if (!(obj->flags & HAS_OBJ)) {
 		if (has_sha1_pack(obj->oid.hash))
 			return; /* it is in pack - forget about it */
+		if (obj->type == OBJ_BLOB &&
+		    is_promised_blob(&obj->oid, NULL))
+			return;
 		printf("missing %s %s\n", printable_type(obj),
 			describe_object(obj));
 		errors_found |= ERROR_REACHABLE;
@@ -642,6 +646,13 @@ static int mark_packed_for_connectivity(const struct object_id *oid,
 	return 0;
 }
 
+static int mark_promised_blob_for_connectivity(const struct object_id *oid,
+					       void *data)
+{
+	mark_object_for_connectivity(oid);
+	return 0;
+}
+
 static char const * const fsck_usage[] = {
 	N_("git fsck [<options>] [<object>...]"),
 	NULL
@@ -701,6 +712,8 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 	if (connectivity_only) {
 		for_each_loose_object(mark_loose_for_connectivity, NULL, 0);
 		for_each_packed_object(mark_packed_for_connectivity, NULL, 0);
+		for_each_promised_blob(mark_promised_blob_for_connectivity,
+				       NULL);
 	} else {
 		fsck_object_dir(get_object_directory());
 
diff --git a/promised-blob.c b/promised-blob.c
new file mode 100644
index 000000000..493808ed2
--- /dev/null
+++ b/promised-blob.c
@@ -0,0 +1,95 @@
+#include "cache.h"
+#include "promised-blob.h"
+#include "sha1-lookup.h"
+#include "strbuf.h"
+
+#define ENTRY_SIZE (GIT_SHA1_RAWSZ + 8)
+/*
+ * A mmap-ed byte array of size (missing_blob_nr * ENTRY_SIZE). Each
+ * ENTRY_SIZE-sized entry consists of the SHA-1 of the promised blob and its
+ * 64-bit size in network byte order. The entries are sorted in ascending SHA-1
+ * order.
+ */
+static char *promised_blobs;
+static int64_t promised_blob_nr = -1;
+
+static void prepare_promised_blobs(void)
+{
+	char *filename;
+	int fd;
+	struct stat st;
+
+	if (promised_blob_nr >= 0)
+		return;
+
+	if (getenv("GIT_IGNORE_PROMISED_BLOBS")) {
+		promised_blob_nr = 0;
+		return;
+	}
+	
+	filename = xstrfmt("%s/promisedblob", get_object_directory());
+	fd = git_open(filename);
+	if (fd < 0) {
+		if (errno == ENOENT) {
+			promised_blob_nr = 0;
+			goto cleanup;
+		}
+		perror("prepare_promised_blobs");
+		die("Could not open %s", filename);
+	}
+	if (fstat(fd, &st)) {
+		perror("prepare_promised_blobs");
+		die("Could not stat %s", filename);
+	}
+	if (st.st_size == 0) {
+		promised_blob_nr = 0;
+		goto cleanup;
+	}
+	if (st.st_size % ENTRY_SIZE) {
+		die("Size of %s is not a multiple of %d", filename, ENTRY_SIZE);
+	}
+
+	promised_blobs = xmmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
+	promised_blob_nr = st.st_size / ENTRY_SIZE;
+
+cleanup:
+	free(filename);
+	if (fd >= 0)
+		close(fd);
+}
+
+int is_promised_blob(const struct object_id *oid, unsigned long *size)
+{
+	int result;
+
+	prepare_promised_blobs();
+	result = sha1_entry_pos(promised_blobs, ENTRY_SIZE, 0, 0,
+				promised_blob_nr, promised_blob_nr, oid->hash);
+	if (result >= 0) {
+		if (size) {
+			uint64_t size_nbo;
+			char *sizeptr = promised_blobs +
+					result * ENTRY_SIZE + GIT_SHA1_RAWSZ;
+			memcpy(&size_nbo, sizeptr, sizeof(size_nbo));
+			*size = ntohll(size_nbo);
+		}
+		return 1;
+	}
+	return 0;
+}
+
+int for_each_promised_blob(each_promised_blob_fn cb, void *data)
+{
+	struct object_id oid;
+	int i, r;
+
+	prepare_promised_blobs();
+	for (i = 0; i < promised_blob_nr; i++) {
+		memcpy(oid.hash, &promised_blobs[i * ENTRY_SIZE],
+		       GIT_SHA1_RAWSZ);
+		r = cb(&oid, data);
+		if (r)
+			return r;
+	}
+	return 0;
+}
diff --git a/promised-blob.h b/promised-blob.h
new file mode 100644
index 000000000..a303ea1ff
--- /dev/null
+++ b/promised-blob.h
@@ -0,0 +1,14 @@
+#ifndef PROMISED_BLOB_H
+#define PROMISED_BLOB_H
+
+/*
+ * Returns 1 if oid is the name of a promised blob. If size is not NULL, also
+ * returns its size.
+ */
+extern int is_promised_blob(const struct object_id *oid,
+			    unsigned long *size);
+
+typedef int each_promised_blob_fn(const struct object_id *oid, void *data);
+int for_each_promised_blob(each_promised_blob_fn, void *);
+
+#endif
diff --git a/t/t3907-promised-blob.sh b/t/t3907-promised-blob.sh
new file mode 100755
index 000000000..827072004
--- /dev/null
+++ b/t/t3907-promised-blob.sh
@@ -0,0 +1,29 @@
+#!/bin/sh
+
+test_description='promised blobs'
+
+. ./test-lib.sh
+
+test_expect_success 'fsck fails on missing blobs' '
+	rm -rf repo &&
+
+	git init repo &&
+	test_commit -C repo 1 &&
+	HASH=$(git hash-object repo/1.t) &&
+
+	rm repo/.git/objects/$(echo $HASH | cut -c1-2)/$(echo $HASH | cut -c3-40) &&
+	test_must_fail git -C repo fsck
+'
+
+test_expect_success '...but succeeds if it is a promised blob' '
+	printf "%s%016x" "$HASH" "$(wc -c <repo/1.t)" |
+		hex_pack >repo/.git/objects/promisedblob &&
+	git -C repo fsck
+'
+
+test_expect_success '...but fails again with GIT_IGNORE_PROMISED_BLOBS' '
+	GIT_IGNORE_PROMISED_BLOBS=1 test_must_fail git -C repo fsck &&
+	unset GIT_IGNORE_PROMISED_BLOBS
+'
+
+test_done
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index db622c355..1ebdd2d04 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1018,3 +1018,9 @@ nongit () {
 		"$@"
 	)
 }
+
+# Converts big-endian pairs of hexadecimal digits into bytes. For example,
+# "printf 61620d0a | hex_pack" results in "ab\r\n".
+hex_pack () {
+	perl -e '$/ = undef; $input = <>; print pack("H*", $input)'
+}
-- 
2.13.2.932.g7449e964c-goog

