Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08FD0C433F5
	for <git@archiver.kernel.org>; Sat,  8 Jan 2022 08:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbiAHI4e (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Jan 2022 03:56:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbiAHI4c (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Jan 2022 03:56:32 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 310B5C061574
        for <git@vger.kernel.org>; Sat,  8 Jan 2022 00:56:32 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id a22so3489552pgd.6
        for <git@vger.kernel.org>; Sat, 08 Jan 2022 00:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ushZSffbUUFOEG9JLBU0NCvIS5tYyEI+Bs9jQ0a85hY=;
        b=HuERdGhN9Jx8FaQdnc0Pd1y1Gmq+RC9hLHL7yopohOwrbpsyO6ASZAxMH/8JO6zZC8
         fy3YJDG55OXC0YZtbuLrLXpT+vRbRXkeLt4zZ0QZAIHncAun32hvxpwdce82Ied3hpoH
         9+th3PcZtsvCy+FLMaeL8B7/Uco1UDoZgTQXwsaCt1R8smxQ1UhOcR1JX3MAUKcGAfIT
         vhHHYROLkgrA0JMjXP+F4ymw36WqB7RHtawiU9NTXvu4368foGDMHMmWeCuk6kTHRZ+C
         92F4eL+zFup8mE5Z+Nj1M/5xBxyl2jTr9CLBenDpnTNCgvSeZHS9818xUDuEpskh+MIK
         NKew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ushZSffbUUFOEG9JLBU0NCvIS5tYyEI+Bs9jQ0a85hY=;
        b=2gykZEs3GCejeIfpM+sayyputwZdWn9vVhTh8AmmObwRuc/dNzrLAGYJYjkJl4hMXv
         3/eewvWfPps9VlNUSs9owT0/gQVyZWoaCcEYP8gv6JznQxjMQGz8zIl1vSUGfjYgLYMr
         kYKKBAq6HWPwI9dOfYetZeAk8rMdkhvLgkPJD2tJ89sIPQI9gaPEHX6qHP8hit22x4qh
         5LUKXsSUw1Udqfg/01LBVI+vM+sFtfMOqxjz2FnAE8eeW6ejkbrQHvcUBwWbiDTMeUXL
         ZaDGc8+grB2lZ/fTJRb5V9nJ+5SWvnZfv3OlmVWtj751qCD+/c0q7bWw1cjQ49ByjEIH
         N/BA==
X-Gm-Message-State: AOAM5319fsn8RwtlNr15LXb4BNCIxXsmJEaCeb2aw/PwtVCJbPPKPzg+
        MDYDCPdXDdVWSOcxgn82MBw=
X-Google-Smtp-Source: ABdhPJzDExivl7rpWMOyX9aolOXAQh5j4kAhedPFfOZhkIwIHmZqDClwPu+ZundpLhq5+nas48pSlg==
X-Received: by 2002:a63:9544:: with SMTP id t4mr1913508pgn.175.1641632191655;
        Sat, 08 Jan 2022 00:56:31 -0800 (PST)
Received: from localhost.localdomain ([58.100.34.57])
        by smtp.gmail.com with ESMTPSA id x25sm1240990pfu.113.2022.01.08.00.56.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Jan 2022 00:56:31 -0800 (PST)
From:   Han Xin <chiyutianyi@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
Cc:     Han Xin <hanxin.hx@alibaba-inc.com>
Subject: [PATCH v8 1/6] unpack-objects: low memory footprint for get_data() in dry_run mode
Date:   Sat,  8 Jan 2022 16:54:14 +0800
Message-Id: <20220108085419.79682-2-chiyutianyi@gmail.com>
X-Mailer: git-send-email 2.34.1.52.gc288e771b4.agit.6.5.6
In-Reply-To: <20211217112629.12334-1-chiyutianyi@gmail.com>
References: <20211217112629.12334-1-chiyutianyi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han Xin <hanxin.hx@alibaba-inc.com>

As the name implies, "get_data(size)" will allocate and return a given
size of memory. Allocating memory for a large blob object may cause the
system to run out of memory. Before preparing to replace calling of
"get_data()" to unpack large blob objects in latter commits, refactor
"get_data()" to reduce memory footprint for dry_run mode.

Because in dry_run mode, "get_data()" is only used to check the
integrity of data, and the returned buffer is not used at all, we can
allocate a smaller buffer and reuse it as zstream output. Therefore,
in dry_run mode, "get_data()" will release the allocated buffer and
return NULL instead of returning garbage data.

Suggested-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
---
 builtin/unpack-objects.c        | 39 ++++++++++++++++++-------
 t/t5329-unpack-large-objects.sh | 52 +++++++++++++++++++++++++++++++++
 2 files changed, 80 insertions(+), 11 deletions(-)
 create mode 100755 t/t5329-unpack-large-objects.sh

diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 4a9466295b..c6d6c17072 100644
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
diff --git a/t/t5329-unpack-large-objects.sh b/t/t5329-unpack-large-objects.sh
new file mode 100755
index 0000000000..39c7a62d94
--- /dev/null
+++ b/t/t5329-unpack-large-objects.sh
@@ -0,0 +1,52 @@
+#!/bin/sh
+#
+# Copyright (c) 2021 Han Xin
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
+assert_no_loose () {
+	glob=dest.git/objects/?? &&
+	echo "$glob" >expect &&
+	eval "echo $glob" >actual &&
+	test_cmp expect actual
+}
+
+assert_no_pack () {
+	rmdir dest.git/objects/pack
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
+	assert_no_loose &&
+	assert_no_pack
+'
+
+test_done
-- 
2.34.1.52.gc288e771b4.agit.6.5.6

