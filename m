Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B0BC433EF
	for <git@archiver.kernel.org>; Sat,  4 Jun 2022 10:10:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234675AbiFDKKo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Jun 2022 06:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234570AbiFDKKh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Jun 2022 06:10:37 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27BAD183A5
        for <git@vger.kernel.org>; Sat,  4 Jun 2022 03:10:36 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id h5so13311804wrb.0
        for <git@vger.kernel.org>; Sat, 04 Jun 2022 03:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YIipOVqNs4XRxWtuvCtRHPSGFkRlbwRvm8XBuiXDkgo=;
        b=OFtOXvREDbZWbAzwCg2ZqWJQbW93jzjMZUsT4imOVFmI+jRhH1Rr7bwT2Zm01e2MDx
         zE8l8B+8dRMv+Ve/4dpgfjoZKSXVKN0o6EQ2dsonZXtb8sKNfzVp6AbrtfOPwgmB/aTm
         UEu3PYWxVKvSM4aaNDtHRn+FUh1SUl1we4SbzLvQ2U5pYFFhnbFqMABPx2kmP4gEHLP6
         b5QQU8UVcyKgPOjzAxSdp8I364XgZxd0G6ShSvo4HBne8bIXc/slXeT2p+pmMuB5f5l+
         whUzCcMcJKeFy+cAsHlBcGYscV8w0oJUVD75P52J1JC/2h2OMxhlK3/rFE3SIX9+DSzg
         Mo0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YIipOVqNs4XRxWtuvCtRHPSGFkRlbwRvm8XBuiXDkgo=;
        b=zVscLfZ3D/gFWnskvtTHIc2Om84ThjeHY8fcpz4M8Bb3scfbueFn9IJa9rUyihhahS
         3aJDMtko1twv4fflKH+gzBNr4bRyTi7eRzoPZAkBpePcmpjIpO6V+5Aibkg7H7LuT6ES
         rGCAfJer1eoDo5ze1XI1ckwno3USkzWf5FNlmQbE13sbqHJILXCL1tHvHXQ7UQUVJED+
         vEIT/5hlm8/+jueyE9/eJfgFK61AQHHURp1B/IHQFm/0J/3/4+QJIAcAZUpbL+696hUK
         Q/4q4gwKYerjzV4m1wiga5rEDAj2mWtdYBkkkJwg2ftorCmTewMFNf3etf9vjJhvmIT6
         /ohQ==
X-Gm-Message-State: AOAM530RkMrqILzNbbgytfHn0wJ0+WRj75wH1DgU6uSRD4xEVwGvmdGb
        FvZuHTqsmpelS7ILy77+r8VRD1bR7vXehQ==
X-Google-Smtp-Source: ABdhPJyay2wjfaSXAZwRkl67eSNrKICsPpGI9+d9Tnu87LFXSiyCE4cyf+ON1nDXl5FKdriaNl/H1w==
X-Received: by 2002:a5d:4dc9:0:b0:215:c611:db73 with SMTP id f9-20020a5d4dc9000000b00215c611db73mr4036058wru.551.1654337434384;
        Sat, 04 Jun 2022 03:10:34 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i12-20020a05600c354c00b0039765a7add4sm15069631wmq.29.2022.06.04.03.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jun 2022 03:10:33 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han Xin <chiyutianyi@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Neeraj Singh <neerajsi@microsoft.com>,
        Elijah Newren <newren@gmail.com>,
        Han Xin <hanxin.hx@alibaba-inc.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v13 1/7] unpack-objects: low memory footprint for get_data() in dry_run mode
Date:   Sat,  4 Jun 2022 12:10:22 +0200
Message-Id: <patch-v13-1.7-12873fc9915-20220604T095113Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1124.g52838f02905
In-Reply-To: <cover-v13-0.7-00000000000-20220604T095113Z-avarab@gmail.com>
References: <cover-v12-0.8-00000000000-20220329T135446Z-avarab@gmail.com> <cover-v13-0.7-00000000000-20220604T095113Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han Xin <hanxin.hx@alibaba-inc.com>

As the name implies, "get_data(size)" will allocate and return a given
amount of memory. Allocating memory for a large blob object may cause the
system to run out of memory. Before preparing to replace calling of
"get_data()" to unpack large blob objects in latter commits, refactor
"get_data()" to reduce memory footprint for dry_run mode.

Because in dry_run mode, "get_data()" is only used to check the
integrity of data, and the returned buffer is not used at all, we can
allocate a smaller buffer and reuse it as zstream output. Therefore,
in dry_run mode, "get_data()" will release the allocated buffer and
return NULL instead of returning garbage data.

The "find [...]objects/?? -type f | wc -l" test idiom being used here
is adapted from the same "find" use added to another test in
d9545c7f465 (fast-import: implement unpack limit, 2016-04-25).

Suggested-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/unpack-objects.c        | 34 ++++++++++++++++++---------
 t/t5351-unpack-large-objects.sh | 41 +++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+), 11 deletions(-)
 create mode 100755 t/t5351-unpack-large-objects.sh

diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 56d05e2725d..64abba8dbac 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -97,15 +97,26 @@ static void use(int bytes)
 	display_throughput(progress, consumed_bytes);
 }
 
+/*
+ * Decompress zstream from stdin and return specific size of data.
+ * The caller is responsible to free the returned buffer.
+ *
+ * But for dry_run mode, "get_data()" is only used to check the
+ * integrity of data, and the returned buffer is not used at all.
+ * Therefore, in dry_run mode, "get_data()" will release the small
+ * allocated buffer which is reused to hold temporary zstream output
+ * and return NULL instead of returning garbage data.
+ */
 static void *get_data(unsigned long size)
 {
 	git_zstream stream;
-	void *buf = xmallocz(size);
+	unsigned long bufsize = dry_run && size > 8192 ? 8192 : size;
+	void *buf = xmallocz(bufsize);
 
 	memset(&stream, 0, sizeof(stream));
 
 	stream.next_out = buf;
-	stream.avail_out = size;
+	stream.avail_out = bufsize;
 	stream.next_in = fill(1);
 	stream.avail_in = len;
 	git_inflate_init(&stream);
@@ -125,8 +136,15 @@ static void *get_data(unsigned long size)
 		}
 		stream.next_in = fill(1);
 		stream.avail_in = len;
+		if (dry_run) {
+			/* reuse the buffer in dry_run mode */
+			stream.next_out = buf;
+			stream.avail_out = bufsize;
+		}
 	}
 	git_inflate_end(&stream);
+	if (dry_run)
+		FREE_AND_NULL(buf);
 	return buf;
 }
 
@@ -326,10 +344,8 @@ static void unpack_non_delta_entry(enum object_type type, unsigned long size,
 {
 	void *buf = get_data(size);
 
-	if (!dry_run && buf)
+	if (buf)
 		write_object(nr, type, buf, size);
-	else
-		free(buf);
 }
 
 static int resolve_against_held(unsigned nr, const struct object_id *base,
@@ -359,10 +375,8 @@ static void unpack_delta_entry(enum object_type type, unsigned long delta_size,
 		oidread(&base_oid, fill(the_hash_algo->rawsz));
 		use(the_hash_algo->rawsz);
 		delta_data = get_data(delta_size);
-		if (dry_run || !delta_data) {
-			free(delta_data);
+		if (!delta_data)
 			return;
-		}
 		if (has_object_file(&base_oid))
 			; /* Ok we have this one */
 		else if (resolve_against_held(nr, &base_oid,
@@ -398,10 +412,8 @@ static void unpack_delta_entry(enum object_type type, unsigned long delta_size,
 			die("offset value out of bound for delta base object");
 
 		delta_data = get_data(delta_size);
-		if (dry_run || !delta_data) {
-			free(delta_data);
+		if (!delta_data)
 			return;
-		}
 		lo = 0;
 		hi = nr;
 		while (lo < hi) {
diff --git a/t/t5351-unpack-large-objects.sh b/t/t5351-unpack-large-objects.sh
new file mode 100755
index 00000000000..8d84313221c
--- /dev/null
+++ b/t/t5351-unpack-large-objects.sh
@@ -0,0 +1,41 @@
+#!/bin/sh
+#
+# Copyright (c) 2022 Han Xin
+#
+
+test_description='git unpack-objects with large objects'
+
+. ./test-lib.sh
+
+prepare_dest () {
+	test_when_finished "rm -rf dest.git" &&
+	git init --bare dest.git
+}
+
+test_expect_success "create large objects (1.5 MB) and PACK" '
+	test-tool genrandom foo 1500000 >big-blob &&
+	test_commit --append foo big-blob &&
+	test-tool genrandom bar 1500000 >big-blob &&
+	test_commit --append bar big-blob &&
+	PACK=$(echo HEAD | git pack-objects --revs pack)
+'
+
+test_expect_success 'set memory limitation to 1MB' '
+	GIT_ALLOC_LIMIT=1m &&
+	export GIT_ALLOC_LIMIT
+'
+
+test_expect_success 'unpack-objects failed under memory limitation' '
+	prepare_dest &&
+	test_must_fail git -C dest.git unpack-objects <pack-$PACK.pack 2>err &&
+	grep "fatal: attempting to allocate" err
+'
+
+test_expect_success 'unpack-objects works with memory limitation in dry-run mode' '
+	prepare_dest &&
+	git -C dest.git unpack-objects -n <pack-$PACK.pack &&
+	test_stdout_line_count = 0 find dest.git/objects -type f &&
+	test_dir_is_empty dest.git/objects/pack
+'
+
+test_done
-- 
2.36.1.1124.g52838f02905

