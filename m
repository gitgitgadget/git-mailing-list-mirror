Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00582C433EF
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 11:54:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234118AbhLULyV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 06:54:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbhLULyU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 06:54:20 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24250C061574
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 03:54:20 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id a23so12126156pgm.4
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 03:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wko/UTdkqZqdjoCsc+Wmy6d9EL+WyoI9mYH4NOXx1TM=;
        b=P4uMSxVGhk5Sp9EbhYYdVUj5KxI/k3pEsJjSdUA4+0iHpo+1Sf4bE863DzK0++NsF2
         lwk08ElX5zBcssdEQvj1wGxeiGgQFTtdu+xavrUjB+6D9GHUo5U/DtvyTPczHmbynQRq
         tvIoxlK8he3V5/j/MI6vGKhATfPg1VCrLPT+vBUTelnOHy2YdUQ4dqbG7bPxflUchLFl
         P15mKzUDMEt5ofSfpiVLB2QQSL5SL9ZVW4JVTbtVlUL/rBCldQCXvzKKVsKanSIae1FD
         eQTNLWvkaNEcRn7ItnjLps9Th1KF0wyRRyJyVOOSJPmg2jozlI7GpMgYQKvXl6E5g8CM
         yBIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wko/UTdkqZqdjoCsc+Wmy6d9EL+WyoI9mYH4NOXx1TM=;
        b=ivrnMX49pTSzQipfPA1pSR58+lb/3Eg/c1+H8ztEtoAfyoL8BQCqpI6up7OF0P+uZq
         q5Q9hHa9Bvj5y4WyozDDN52kPEDutHO/Rte55CnAIHZqar47ESsdemtXjEOLE4Weomrj
         sALEQoe1Mzcwa8UQPlJStZ/jldAcbTPuiGz39kknH0O+DgjqWxRKzD+X/1F89sydMf7h
         Kfji8d1t9KJq22p6qmDVs45RNxCYcTATJ3AaRBiXOVpJSajjAdEgUcNvzSvkB64PBvYm
         fzU2C2OQftOP7vEu60BWBa2FIU174eLeXGcmRV/MQe/4DpaeHs6/OknsbFBHZk7pblPk
         l6tw==
X-Gm-Message-State: AOAM530EyzfT62Uh2mGw+qUSs99/RJPWiDUxmVe8eGepEKf2tYIx+SCb
        tT82w98N8edTQpz8nMRszpc=
X-Google-Smtp-Source: ABdhPJwvXjSp9+wwExUlJInVVX4kyI45Cz0jl15QOixd3S9ytTZvOsGC0f9QJi9QBEY0rA+bptIAiw==
X-Received: by 2002:a63:6c81:: with SMTP id h123mr2657966pgc.313.1640087659612;
        Tue, 21 Dec 2021 03:54:19 -0800 (PST)
Received: from localhost.localdomain ([205.204.117.103])
        by smtp.gmail.com with ESMTPSA id s30sm20513742pfw.57.2021.12.21.03.54.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Dec 2021 03:54:19 -0800 (PST)
From:   Han Xin <chiyutianyi@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
Cc:     Han Xin <hanxin.hx@alibaba-inc.com>
Subject: [PATCH v7 1/5] unpack-objects.c: add dry_run mode for get_data()
Date:   Tue, 21 Dec 2021 19:51:57 +0800
Message-Id: <20211221115201.12120-2-chiyutianyi@gmail.com>
X-Mailer: git-send-email 2.34.1.52.g80008efde6.agit.6.5.6
In-Reply-To: <20211217112629.12334-1-chiyutianyi@gmail.com>
References: <20211217112629.12334-1-chiyutianyi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han Xin <hanxin.hx@alibaba-inc.com>

In dry_run mode, "get_data()" is used to verify the inflation of data,
and the returned buffer will not be used at all and will be freed
immediately. Even in dry_run mode, it is dangerous to allocate a
full-size buffer for a large blob object. Therefore, only allocate a
low memory footprint when calling "get_data()" in dry_run mode.

Suggested-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
---
 builtin/unpack-objects.c            | 23 +++++++++---
 t/t5590-unpack-non-delta-objects.sh | 57 +++++++++++++++++++++++++++++
 2 files changed, 74 insertions(+), 6 deletions(-)
 create mode 100755 t/t5590-unpack-non-delta-objects.sh

diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 4a9466295b..9104eb48da 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -96,15 +96,21 @@ static void use(int bytes)
 	display_throughput(progress, consumed_bytes);
 }
 
-static void *get_data(unsigned long size)
+static void *get_data(size_t size, int dry_run)
 {
 	git_zstream stream;
-	void *buf = xmallocz(size);
+	size_t bufsize;
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
@@ -124,6 +130,11 @@ static void *get_data(unsigned long size)
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
 	return buf;
@@ -323,7 +334,7 @@ static void added_object(unsigned nr, enum object_type type,
 static void unpack_non_delta_entry(enum object_type type, unsigned long size,
 				   unsigned nr)
 {
-	void *buf = get_data(size);
+	void *buf = get_data(size, dry_run);
 
 	if (!dry_run && buf)
 		write_object(nr, type, buf, size);
@@ -357,7 +368,7 @@ static void unpack_delta_entry(enum object_type type, unsigned long delta_size,
 	if (type == OBJ_REF_DELTA) {
 		oidread(&base_oid, fill(the_hash_algo->rawsz));
 		use(the_hash_algo->rawsz);
-		delta_data = get_data(delta_size);
+		delta_data = get_data(delta_size, dry_run);
 		if (dry_run || !delta_data) {
 			free(delta_data);
 			return;
@@ -396,7 +407,7 @@ static void unpack_delta_entry(enum object_type type, unsigned long delta_size,
 		if (base_offset <= 0 || base_offset >= obj_list[nr].offset)
 			die("offset value out of bound for delta base object");
 
-		delta_data = get_data(delta_size);
+		delta_data = get_data(delta_size, dry_run);
 		if (dry_run || !delta_data) {
 			free(delta_data);
 			return;
diff --git a/t/t5590-unpack-non-delta-objects.sh b/t/t5590-unpack-non-delta-objects.sh
new file mode 100755
index 0000000000..48c4fb1ba3
--- /dev/null
+++ b/t/t5590-unpack-non-delta-objects.sh
@@ -0,0 +1,57 @@
+#!/bin/sh
+#
+# Copyright (c) 2021 Han Xin
+#
+
+test_description='Test unpack-objects with non-delta objects'
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+
+prepare_dest () {
+	test_when_finished "rm -rf dest.git" &&
+	git init --bare dest.git
+}
+
+test_expect_success "setup repo with big blobs (1.5 MB)" '
+	test-tool genrandom foo 1500000 >big-blob &&
+	test_commit --append foo big-blob &&
+	test-tool genrandom bar 1500000 >big-blob &&
+	test_commit --append bar big-blob &&
+	(
+		cd .git &&
+		find objects/?? -type f | sort
+	) >expect &&
+	PACK=$(echo main | git pack-objects --revs test)
+'
+
+test_expect_success 'setup env: GIT_ALLOC_LIMIT to 1MB' '
+	GIT_ALLOC_LIMIT=1m &&
+	export GIT_ALLOC_LIMIT
+'
+
+test_expect_success 'fail to unpack-objects: cannot allocate' '
+	prepare_dest &&
+	test_must_fail git -C dest.git unpack-objects <test-$PACK.pack 2>err &&
+	grep "fatal: attempting to allocate" err &&
+	(
+		cd dest.git &&
+		find objects/?? -type f | sort
+	) >actual &&
+	test_file_not_empty actual &&
+	! test_cmp expect actual
+'
+
+test_expect_success 'unpack-objects dry-run' '
+	prepare_dest &&
+	git -C dest.git unpack-objects -n <test-$PACK.pack &&
+	(
+		cd dest.git &&
+		find objects/ -type f
+	) >actual &&
+	test_must_be_empty actual
+'
+
+test_done
-- 
2.34.1.52.g80008efde6.agit.6.5.6

