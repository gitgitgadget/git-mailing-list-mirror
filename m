Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1ED9C433F5
	for <git@archiver.kernel.org>; Fri, 20 May 2022 03:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345034AbiETDGR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 May 2022 23:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345042AbiETDGA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 May 2022 23:06:00 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE3AFD23
        for <git@vger.kernel.org>; Thu, 19 May 2022 20:05:58 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id h186so6649092pgc.3
        for <git@vger.kernel.org>; Thu, 19 May 2022 20:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T50l2/6X8yaioqoqF9qd1JpSOLTUsCu5Mx1IYm7V1u8=;
        b=byM5hIRdZsgqwMsM44tGWd4ayIOUAhDNKfoVgY3LLaB7SZhMxEm0gwdrqTawUC66ZO
         nYVH4QWpGSIo2pIT+iOgRna2YeFL3e68xdH84pGxp9IhqbtB8iOjRCGiygYo5K05AM4Z
         EG7TFAjJiPucE7RKXBIYC+6QwJaLHbJXBkCMLqKJBR4ykzMgTfbVoRN+BGgupMp2tbd7
         G20tykW14kBwlx5SVBgZFAnR4cuIMWJbin1lKg+CMz6rWKQ/pzyL+gaBGBBB/AbKAEG5
         6gmIwH3twxjK2OX3q3CZcW+t9ZcFc+HWseVLjPR1z5DP9se6ca8nnBa5oIVNdpExiygL
         Kjvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T50l2/6X8yaioqoqF9qd1JpSOLTUsCu5Mx1IYm7V1u8=;
        b=0Yve6YmiRTDY6Jq9y1M6wa4yRP6za3M5SFJMmt4V+E+QcHNXS118lxyQ/v/Z9g10N2
         zxugAo2J3EUKwsPyOkOrU2nr9M9uqxK2i/4wKn9NkCeE5IOPse4fzcDcHBjAVgSPrMQj
         7qAdPXm0u6+zNBu/BPnDRna8soaAYF7cxoLQIaYbpHxKAydcEMJiM7uiJ8muL58W6hGS
         OsCL8QjPHUjfSuzSM+PUIQK8IOw4+zSRezvmGbzlXYkkNFHdX8penurRVIaCMlEN3SGx
         SUBe8WrfJLSIKSkourXcVnKftJPR6MWfc8rd0AWQD0kiWxEm6yZsHQIUiPpsHPrx0/3H
         KXOw==
X-Gm-Message-State: AOAM531Iyo20LM/CfyaJDUOPZopzot3rEn4yODmnIKkNOV1+BARRcAwM
        aA8t6QomGdFx3wP5l/NXnMM7LyEvL3M=
X-Google-Smtp-Source: ABdhPJxvXcQ3OPG93wczV1wOQLq2yVBLUlfUdP64DRDTePaXIJArxPo/8NKE42o8Ua8az1yJBDxaAg==
X-Received: by 2002:a63:6bc6:0:b0:3c6:b38b:a84 with SMTP id g189-20020a636bc6000000b003c6b38b0a84mr6607868pgc.422.1653015957593;
        Thu, 19 May 2022 20:05:57 -0700 (PDT)
Received: from JMHNXMC7VH.bytedance.net ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id z5-20020a63e105000000b003c14af505f6sm4294471pgh.14.2022.05.19.20.05.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 May 2022 20:05:57 -0700 (PDT)
From:   Han Xin <chiyutianyi@gmail.com>
To:     git@vger.kernel.org
Cc:     Han Xin <hanxin.hx@alibaba-inc.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH 1/1] unpack-objects: low memory footprint for get_data() in dry_run mode
Date:   Fri, 20 May 2022 11:05:14 +0800
Message-Id: <354ec53826f6af0977387a99e2204c0dd4e96b20.1653015534.git.chiyutianyi@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1653015534.git.chiyutianyi@gmail.com>
References: <cover-v11-0.8-00000000000-20220319T001411Z-avarab@gmail.com> <cover.1653015534.git.chiyutianyi@gmail.com>
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
index dbeb0680a5..e3d3002597 100644
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
index 0000000000..8d84313221
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
2.36.1

