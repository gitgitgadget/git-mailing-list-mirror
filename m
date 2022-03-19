Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A331AC433EF
	for <git@archiver.kernel.org>; Sat, 19 Mar 2022 00:23:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241657AbiCSAZC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Mar 2022 20:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233463AbiCSAY5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Mar 2022 20:24:57 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0741275AF
        for <git@vger.kernel.org>; Fri, 18 Mar 2022 17:23:37 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id u16so12699591wru.4
        for <git@vger.kernel.org>; Fri, 18 Mar 2022 17:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oIrXDEGzt/ZgsSuyaOAnFWczW6LDYtI13K0inrUj/YY=;
        b=Kdq7j1Hdw3c9DlYFB4olYA49XaicPF1Z17cy7GHd7cWnluf5lGiTrmDovuq+IujohI
         Aw926tuPB96cl7zAkVp8ERTNxVYc51kflDriGBEmrJu7w3z0gxGu7AxHmHSZZ3qJ1dBF
         QEI/ASs5tj6lHDTqGAFRy23nyZ1CYC2BJmDXYockKLqPPFqjAxMIEpAsP83HfOFxpduK
         fT3IWKoDrUlhvdeAbUoWmYEHtAnBfYz6F0Hs4tLYRGJxaqSrNtHaZAZ8k845ry79HYgg
         71INbjAXkppL0nn7erHtZ/CgNr6ceoRfNWCELLBO2Y+lYv7QkBf4pRRYwyB/3zSbIGBK
         mu9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oIrXDEGzt/ZgsSuyaOAnFWczW6LDYtI13K0inrUj/YY=;
        b=WBNu2EdqVv50r2LK42UU2zI88P4OvwN+g8xmLFyR4c2WPicMFROTvStjk639rDzhJq
         aJJVGuPig6vbiVxVcxZMMoXhkkap70YHI4qDmWuS8KBBBOG9aACVewSGYl3S5G9+dGVy
         Hknt7DPMtlcIidIUa51bRGYyAjMk1QWiQ41Ew5y5XqSHVzI+a8dBdQPw/NjS7gUKFd3R
         lPs6AWxQKvnRkyWddo+q26wh/HSt4Ze2crfpDEEsDMeE/Zv/vHGRQgLpcyCgyAYiLg7Y
         FSTO/2AEMQSTzK9SkzDpkXMVCuhxUimMRu7yD5JSeg7UMAqHo88hC3yPC08Qv8j2uxRQ
         un3Q==
X-Gm-Message-State: AOAM530ccYcQtLJ1lTTxbfMl9qZ+DpvrGW0U5h5QvMq6eBVfPYRh5aku
        e4rPGSNKFzJqEE0HWxigFRzHgewmfhvEEA==
X-Google-Smtp-Source: ABdhPJwLuxOOilUheS0C9uzv3cA6tPaTNz6vess0WZJvXq8jx/ohggLwgmbjUePSJYX1KoGTMdUwBQ==
X-Received: by 2002:a5d:64c1:0:b0:203:7aa3:5c14 with SMTP id f1-20020a5d64c1000000b002037aa35c14mr9659259wri.602.1647649415787;
        Fri, 18 Mar 2022 17:23:35 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u25-20020a05600c211900b00389d4bdb3d2sm14865519wml.36.2022.03.18.17.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 17:23:32 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han Xin <chiyutianyi@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Han Xin <hanxin.hx@alibaba-inc.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v11 1/8] unpack-objects: low memory footprint for get_data() in dry_run mode
Date:   Sat, 19 Mar 2022 01:23:18 +0100
Message-Id: <patch-v11-1.8-2103d5bfd96-20220319T001411Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1438.g8874c8eeb35
In-Reply-To: <cover-v11-0.8-00000000000-20220319T001411Z-avarab@gmail.com>
References: <cover-v10-0.6-00000000000-20220204T135538Z-avarab@gmail.com> <cover-v11-0.8-00000000000-20220319T001411Z-avarab@gmail.com>
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
index dbeb0680a58..e3d30025979 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -96,15 +96,26 @@ static void use(int bytes)
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
@@ -124,8 +135,15 @@ static void *get_data(unsigned long size)
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
 
@@ -325,10 +343,8 @@ static void unpack_non_delta_entry(enum object_type type, unsigned long size,
 {
 	void *buf = get_data(size);
 
-	if (!dry_run && buf)
+	if (buf)
 		write_object(nr, type, buf, size);
-	else
-		free(buf);
 }
 
 static int resolve_against_held(unsigned nr, const struct object_id *base,
@@ -358,10 +374,8 @@ static void unpack_delta_entry(enum object_type type, unsigned long delta_size,
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
@@ -397,10 +411,8 @@ static void unpack_delta_entry(enum object_type type, unsigned long delta_size,
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
2.35.1.1438.g8874c8eeb35

