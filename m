Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F6BBC43334
	for <git@archiver.kernel.org>; Sat, 11 Jun 2022 02:44:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238847AbiFKCor (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jun 2022 22:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346449AbiFKCol (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jun 2022 22:44:41 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13783F4A33
        for <git@vger.kernel.org>; Fri, 10 Jun 2022 19:44:40 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 184so762231pga.12
        for <git@vger.kernel.org>; Fri, 10 Jun 2022 19:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4utz62g3dKi9uT+B+uL6sJEH6c/3c+FIBPvOJkIxnqI=;
        b=edcQRZZ/l5Df6tT6SuzvfPQ/Xmy4BBLiuOpjfMHZZM8yLavLRHiVpVNYO7BB+9sjoM
         xeZJpZ05Ft5kD6ZEYJRyyyzCSn42v8VAqz5s2aydoN0ZKp6UHvUgAMAQztumyKc9m02P
         w3ZdJI/mCsniTsFo2alL5tKpBkkbsd/ekGFA5Vd062jxPucWE16UMnmbSnVesDgV+zZz
         xoctvMdsp0P7yPm0n/QiM7GFdHDXm9umy/92vFJKd+0vvuEh9g3llTDB1D2l7BD/ZRIg
         6SeBS0FmPPqEGZ+6XG/poGDZwVFDh3/hogf5W2cL+rNLWbjGiUKVS9wZbCV/fyORzTf+
         F47w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4utz62g3dKi9uT+B+uL6sJEH6c/3c+FIBPvOJkIxnqI=;
        b=ZEcQImXOpbbR9MjTEoLqIPFeTw+tpWkuL6xMN7C5aDbiAXlFFIoKWP4S0lSB8rwxSu
         SptH6LxQkKA1Kv4SbpjTkqoDhr0P0HO18O4oW4r+RyOAVkH3x0ebeSF6QK1S/rtW9mHF
         Qh9Phal5rZm6ZKr4tLh6MXBy4MKQ+z4lIbi0WHL8loCikoGC5Q92KNKSYW29obT4bdx9
         y58h4l8O2nRoKtf2CTYCYHQy2Qk6A6dBKS6wiON3By3JCUTHZU8nB+kHKfUHrvfrzVaN
         BArPXOx3b4vsFvHqSH+d/8iq+QTPw8WZbqQGbEgx7ncul5KYRezqu9smSEyuaoPUt9SH
         8XNg==
X-Gm-Message-State: AOAM533qtUTXDUcQLZzKnlDP2yMgCqJfHfRhAb25eDbB763trkacVsLv
        pChAnxLg+BpMCYwt9+cgwXbMhqzHMgtuhiat
X-Google-Smtp-Source: ABdhPJzwXaWTpnsoXkpT9PXWJKcVGp00GvL8cUrX/w1n1aUxW5bK9Spe+kww1kYB5ab9j02YUepETA==
X-Received: by 2002:a05:6a00:140b:b0:4e1:2cbd:30ba with SMTP id l11-20020a056a00140b00b004e12cbd30bamr49021722pfu.46.1654915480185;
        Fri, 10 Jun 2022 19:44:40 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a28:80c:ca60:6957:cd88:1852:9438])
        by smtp.gmail.com with ESMTPSA id l13-20020a62be0d000000b0051ba90d55acsm257077pff.207.2022.06.10.19.44.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 Jun 2022 19:44:39 -0700 (PDT)
From:   Han Xin <chiyutianyi@gmail.com>
To:     avarab@gmail.com
Cc:     Han Xin <hanxin.hx@alibaba-inc.com>, chiyutianyi@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, l.s.r@web.de,
        neerajsi@microsoft.com, newren@gmail.com, philipoakley@iee.email,
        stolee@gmail.com, worldhello.net@gmail.com,
        Neeraj Singh <nksingh85@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v15 1/6] unpack-objects: low memory footprint for get_data() in dry_run mode
Date:   Sat, 11 Jun 2022 10:44:16 +0800
Message-Id: <9a776f717d512dc63888a9334074bbf1728395c5.1654914555.git.chiyutianyi@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1654914555.git.chiyutianyi@gmail.com>
References: <cover.1654871915.git.chiyutianyi@gmail.com> <cover.1654914555.git.chiyutianyi@gmail.com>
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
allocate a smaller buffer and use it as zstream output. Make the function
return NULL in the dry-run mode, as no callers use the returned buffer.

The "find [...]objects/?? -type f | wc -l" test idiom being used here
is adapted from the same "find" use added to another test in
d9545c7f465 (fast-import: implement unpack limit, 2016-04-25).

Suggested-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Signed-off-by: Han Xin <chiyutianyi@gmail.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/unpack-objects.c        | 37 ++++++++++++++++++++---------
 t/t5351-unpack-large-objects.sh | 41 +++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+), 11 deletions(-)
 create mode 100755 t/t5351-unpack-large-objects.sh

diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 56d05e2725..32e8b47059 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -97,15 +97,27 @@ static void use(int bytes)
 	display_throughput(progress, consumed_bytes);
 }
 
+/*
+ * Decompress zstream from the standard input into a newly
+ * allocated buffer of specified size and return the buffer.
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
@@ -125,8 +137,17 @@ static void *get_data(unsigned long size)
 		}
 		stream.next_in = fill(1);
 		stream.avail_in = len;
+		if (dry_run) {
+			/* reuse the buffer in dry_run mode */
+			stream.next_out = buf;
+			stream.avail_out = bufsize > size - stream.total_out ?
+						   size - stream.total_out :
+						   bufsize;
+		}
 	}
 	git_inflate_end(&stream);
+	if (dry_run)
+		FREE_AND_NULL(buf);
 	return buf;
 }
 
@@ -326,10 +347,8 @@ static void unpack_non_delta_entry(enum object_type type, unsigned long size,
 {
 	void *buf = get_data(size);
 
-	if (!dry_run && buf)
+	if (buf)
 		write_object(nr, type, buf, size);
-	else
-		free(buf);
 }
 
 static int resolve_against_held(unsigned nr, const struct object_id *base,
@@ -359,10 +378,8 @@ static void unpack_delta_entry(enum object_type type, unsigned long delta_size,
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
@@ -398,10 +415,8 @@ static void unpack_delta_entry(enum object_type type, unsigned long delta_size,
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

