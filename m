Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6571C433EF
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 14:07:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359023AbiBDOHY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 09:07:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356488AbiBDOHX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Feb 2022 09:07:23 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD58AC061714
        for <git@vger.kernel.org>; Fri,  4 Feb 2022 06:07:22 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id s10so8982573wra.5
        for <git@vger.kernel.org>; Fri, 04 Feb 2022 06:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0NkROivKXACgrlFtijGLpeNLnwUqN0rhAIv5p40FFvw=;
        b=DRybEFDnvGwSsd/oRn3PQhlM93Bgz2REqarc3DwQdKdXyl0KGkanVoETDG91NMiJ5j
         1X1M8ImsNqRxgb14rUGwKwUjx7Z6xfx6go5CU3iif4OUOO98DmGDVuaE+uqWouxmX8cg
         Ghjtgt+c8VMHtpzKaVkgb5IJBmsFAbbNshFjwLTjdnjaZ0zIjNbs1bvZS9Ah/QTPjcTI
         cUZS/zPT5N+uDIyanQVBE0S2WStMrBw6fueFFHCGVbDMIBiW5NPkqAKdDbCevHVIcY9M
         CvlCUwUWr72NJTE+4CZ6wSlXGPypP7s9RYNwu05WfQl1kNPr0jZKMBP+nefPeWD4Hhic
         kqFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0NkROivKXACgrlFtijGLpeNLnwUqN0rhAIv5p40FFvw=;
        b=zTVgpHncdmbBX0WHqJiEUOYyUeibVopKKBYgop1/kaVxNAIBA/O9lhGnWBhUiSeYQ/
         AGv+LzcJF04GBOEK9oFDxBAWv31r0qO8ModH0v3WxRMKFDKRFM4iAa1JL8LLPO1FmwYK
         dLovx2JX81F3eJKkaocFb/53qIyFBHu08+UAj7dTy5onrGwwivV5LZgt35IBF+dMwjDO
         6O4OL07dl7YU797UqZamINKoj5IWV/qE8K3sKmZvFEiDEXwNRyrJDmto9famSrjVvtAL
         0QExNki2KJNs4oGs9CKYM3NBF/9NHXiivhvZF+mj5KSLaduc1No+TDfufpRhtCjRU5RF
         h3Qw==
X-Gm-Message-State: AOAM532DBeSR/pZtpnOamHKfmQc6kARTz1KvVe6zuO1Xvzv4tLrx8yir
        /cIN1whVhbutyBqKr7678qujY+WG9bGQ1g==
X-Google-Smtp-Source: ABdhPJycgAM6PS2pArxm/LBWD/ACCEaVc1Bon+QNuSexPdKxS9L4Kust3R3/FgYYZ488Ut+aXC7iUQ==
X-Received: by 2002:a5d:48c5:: with SMTP id p5mr2666608wrs.566.1643983641251;
        Fri, 04 Feb 2022 06:07:21 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u19sm618722wmm.0.2022.02.04.06.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 06:07:20 -0800 (PST)
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
Subject: [PATCH v10 1/6] unpack-objects: low memory footprint for get_data() in dry_run mode
Date:   Fri,  4 Feb 2022 15:07:07 +0100
Message-Id: <patch-v10-1.6-e46eb75b98f-20220204T135538Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.940.ge7a5b4b05f2
In-Reply-To: <cover-v10-0.6-00000000000-20220204T135538Z-avarab@gmail.com>
References: <20220120112114.47618-1-chiyutianyi@gmail.com> <cover-v10-0.6-00000000000-20220204T135538Z-avarab@gmail.com>
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
 builtin/unpack-objects.c        | 39 ++++++++++++++++++++--------
 t/t5328-unpack-large-objects.sh | 45 +++++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+), 11 deletions(-)
 create mode 100755 t/t5328-unpack-large-objects.sh

diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index dbeb0680a58..896ea8aceb4 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -96,15 +96,31 @@ static void use(int bytes)
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
+	unsigned long bufsize;
+	void *buf;
 
 	memset(&stream, 0, sizeof(stream));
+	if (dry_run && size > 8192)
+		bufsize = 8192;
+	else
+		bufsize = size;
+	buf = xmallocz(bufsize);
 
 	stream.next_out = buf;
-	stream.avail_out = size;
+	stream.avail_out = bufsize;
 	stream.next_in = fill(1);
 	stream.avail_in = len;
 	git_inflate_init(&stream);
@@ -124,8 +140,15 @@ static void *get_data(unsigned long size)
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
 
@@ -325,10 +348,8 @@ static void unpack_non_delta_entry(enum object_type type, unsigned long size,
 {
 	void *buf = get_data(size);
 
-	if (!dry_run && buf)
+	if (buf)
 		write_object(nr, type, buf, size);
-	else
-		free(buf);
 }
 
 static int resolve_against_held(unsigned nr, const struct object_id *base,
@@ -358,10 +379,8 @@ static void unpack_delta_entry(enum object_type type, unsigned long delta_size,
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
@@ -397,10 +416,8 @@ static void unpack_delta_entry(enum object_type type, unsigned long delta_size,
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
diff --git a/t/t5328-unpack-large-objects.sh b/t/t5328-unpack-large-objects.sh
new file mode 100755
index 00000000000..1432dfc8386
--- /dev/null
+++ b/t/t5328-unpack-large-objects.sh
@@ -0,0 +1,45 @@
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
+test_no_loose () {
+	test $(find dest.git/objects/?? -type f | wc -l) = 0
+}
+
+test_expect_success "create large objects (1.5 MB) and PACK" '
+	test-tool genrandom foo 1500000 >big-blob &&
+	test_commit --append foo big-blob &&
+	test-tool genrandom bar 1500000 >big-blob &&
+	test_commit --append bar big-blob &&
+	PACK=$(echo HEAD | git pack-objects --revs test)
+'
+
+test_expect_success 'set memory limitation to 1MB' '
+	GIT_ALLOC_LIMIT=1m &&
+	export GIT_ALLOC_LIMIT
+'
+
+test_expect_success 'unpack-objects failed under memory limitation' '
+	prepare_dest &&
+	test_must_fail git -C dest.git unpack-objects <test-$PACK.pack 2>err &&
+	grep "fatal: attempting to allocate" err
+'
+
+test_expect_success 'unpack-objects works with memory limitation in dry-run mode' '
+	prepare_dest &&
+	git -C dest.git unpack-objects -n <test-$PACK.pack &&
+	test_no_loose &&
+	test_dir_is_empty dest.git/objects/pack
+'
+
+test_done
-- 
2.35.1.940.ge7a5b4b05f2

