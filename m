Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB6D5C433F5
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 09:36:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351454AbhLCJjp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 04:39:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351442AbhLCJjn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 04:39:43 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92EBCC06174A
        for <git@vger.kernel.org>; Fri,  3 Dec 2021 01:36:19 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id gx15-20020a17090b124f00b001a695f3734aso2041077pjb.0
        for <git@vger.kernel.org>; Fri, 03 Dec 2021 01:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0dSsBDfdNiD6rL5vyx1WZfKIIRj9ckGU1BaVc94dGMA=;
        b=CZ1zePXrV152vtdTRNMmSE34lw/sRq1UgR/3oNxLLHMWyrncEXpqFX7QQSo24eh8tE
         4JJ+HHNUVKSXPJEZ4nyyn5T/+yObsOqHb4xDd53mli1xcpwgQxieEl5ChJ4+IvsNUhd2
         lCy+iUs0pUim9ipIjus5cDUpOO+am0uL8mz4IooI2BH7r2IhIQGLKz4UTMG3KwZaWMpc
         LPS5btJE5td0Plw6tgiWX0B42plyl16w2X8NXzJ1Pw2+vN9572zxLTohsfJUkoX2L69m
         0044UyMZcuNkFvT9tfFcB8Ut6IqL28/oxvqV3FmLuzO6E749H3qPPW3cgxCBJ7M0q6U2
         xwvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0dSsBDfdNiD6rL5vyx1WZfKIIRj9ckGU1BaVc94dGMA=;
        b=JIB+047F8NQS31fyIV8yo8ff/F9FaF2ykWciuiQu2qlcmF+l1JkRdjJV3ow1G8KOdE
         KULf8y6lgkW3zN+FX8DCcI/gVq6khMxY9KhV3wwzJW+9dip6lLKjDJClcnoTiYjQBLKh
         CFJHEgq2FCQTl1O0126ubyil0ncgxvww3BAWiOQl83TuGkCteF/zLBzPJTdh9UuYLKxO
         lI5v2O2tUVr98Fg8hzTa8KPJMtu5zOrxLlkoCkL/dug4Xzs964OSgWIq3BfvuZrYmVgr
         Djjpge0OSRU0RfQWqPn8q9SLZO3Ts7uOVlp8e/K/rCB+ZR+LOhF6DnJFYlcHeKySoTlT
         NRPw==
X-Gm-Message-State: AOAM530t6gJsnsRKF3kAPtUGsnMVaA6R7JZDLjAhXXYvs0C88gFmHvRt
        UyvVCceqtcvboxnKnYhA3ozvR2rTxcFj+npe
X-Google-Smtp-Source: ABdhPJwgxhBRwK9KKwkhNdy68edjr8475m/0QPwNpKxThj7rtn3R7H7JKMOFxshY2qTq5d2hZex0jg==
X-Received: by 2002:a17:90b:17c4:: with SMTP id me4mr12727912pjb.15.1638524179052;
        Fri, 03 Dec 2021 01:36:19 -0800 (PST)
Received: from localhost.localdomain ([205.204.117.99])
        by smtp.gmail.com with ESMTPSA id g9sm2708142pfj.160.2021.12.03.01.36.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Dec 2021 01:36:18 -0800 (PST)
From:   Han Xin <chiyutianyi@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Derrick Stolee <stolee@gmail.com>
Cc:     Han Xin <hanxin.hx@alibaba-inc.com>
Subject: [PATCH v4 5/5] unpack-objects: unpack_non_delta_entry() read data in a stream
Date:   Fri,  3 Dec 2021 17:35:30 +0800
Message-Id: <20211203093530.93589-6-chiyutianyi@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211122033220.32883-1-chiyutianyi@gmail.com>
References: <20211122033220.32883-1-chiyutianyi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han Xin <hanxin.hx@alibaba-inc.com>

We used to call "get_data()" in "unpack_non_delta_entry()" to read the
entire contents of a blob object, no matter how big it is. This
implementation may consume all the memory and cause OOM.

By implementing a zstream version of input_stream interface, we can use
a small fixed buffer for "unpack_non_delta_entry()".

However, unpack non-delta objects from a stream instead of from an entrie
buffer will have 10% performance penalty. Therefore, only unpack object
larger than the "big_file_threshold" in zstream. See the following
benchmarks:

    hyperfine \
      --setup \
      'if ! test -d scalar.git; then git clone --bare https://github.com/microsoft/scalar.git; cp scalar.git/objects/pack/*.pack small.pack; fi' \
      --prepare 'rm -rf dest.git && git init --bare dest.git' \
      -n 'old' 'git -C dest.git unpack-objects <small.pack' \
      -n 'new' 'new/git -C dest.git unpack-objects <small.pack' \
      -n 'new (small threshold)' \
      'new/git -c core.bigfilethreshold=16k -C dest.git unpack-objects <small.pack'
    Benchmark 1: old
      Time (mean ± σ):      6.075 s ±  0.069 s    [User: 5.047 s, System: 0.991 s]
      Range (min … max):    6.018 s …  6.189 s    10 runs

    Benchmark 2: new
      Time (mean ± σ):      6.090 s ±  0.033 s    [User: 5.075 s, System: 0.976 s]
      Range (min … max):    6.030 s …  6.142 s    10 runs

    Benchmark 3: new (small threshold)
      Time (mean ± σ):      6.755 s ±  0.029 s    [User: 5.150 s, System: 1.560 s]
      Range (min … max):    6.711 s …  6.809 s    10 runs

    Summary
      'old' ran
        1.00 ± 0.01 times faster than 'new'
        1.11 ± 0.01 times faster than 'new (small threshold)'

Helped-by: Derrick Stolee <stolee@gmail.com>
Helped-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
---
 builtin/unpack-objects.c            | 77 ++++++++++++++++++++++++++++-
 object-file.c                       |  6 +--
 object-store.h                      |  4 ++
 t/t5590-unpack-non-delta-objects.sh | 76 ++++++++++++++++++++++++++++
 4 files changed, 159 insertions(+), 4 deletions(-)
 create mode 100755 t/t5590-unpack-non-delta-objects.sh

diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 8d68acd662..bedc494e2d 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -326,11 +326,86 @@ static void added_object(unsigned nr, enum object_type type,
 	}
 }
 
+struct input_zstream_data {
+	git_zstream *zstream;
+	unsigned char buf[8192];
+	int status;
+};
+
+static const void *feed_input_zstream(struct input_stream *in_stream, unsigned long *readlen)
+{
+	struct input_zstream_data *data = in_stream->data;
+	git_zstream *zstream = data->zstream;
+	void *in = fill(1);
+
+	if (!len || data->status == Z_STREAM_END) {
+		*readlen = 0;
+		return NULL;
+	}
+
+	zstream->next_out = data->buf;
+	zstream->avail_out = sizeof(data->buf);
+	zstream->next_in = in;
+	zstream->avail_in = len;
+
+	data->status = git_inflate(zstream, 0);
+	use(len - zstream->avail_in);
+	*readlen = sizeof(data->buf) - zstream->avail_out;
+
+	return data->buf;
+}
+
+static void write_stream_blob(unsigned nr, unsigned long size)
+{
+	char hdr[32];
+	int hdrlen;
+	git_zstream zstream;
+	struct input_zstream_data data;
+	struct input_stream in_stream = {
+		.read = feed_input_zstream,
+		.data = &data,
+		.size = size,
+	};
+	struct object_id *oid = &obj_list[nr].oid;
+	int ret;
+
+	memset(&zstream, 0, sizeof(zstream));
+	memset(&data, 0, sizeof(data));
+	data.zstream = &zstream;
+	git_inflate_init(&zstream);
+
+	/* Generate the header */
+	hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %"PRIuMAX, type_name(OBJ_BLOB), (uintmax_t)size) + 1;
+
+	if ((ret = write_loose_object(oid, hdr, hdrlen, &in_stream, 0, 0)))
+		die(_("failed to write object in stream %d"), ret);
+
+	if (zstream.total_out != size || data.status != Z_STREAM_END)
+		die(_("inflate returned %d"), data.status);
+	git_inflate_end(&zstream);
+
+	if (strict && !dry_run) {
+		struct blob *blob = lookup_blob(the_repository, oid);
+		if (blob)
+			blob->object.flags |= FLAG_WRITTEN;
+		else
+			die("invalid blob object from stream");
+	}
+	obj_list[nr].obj = NULL;
+}
+
 static void unpack_non_delta_entry(enum object_type type, unsigned long size,
 				   unsigned nr)
 {
-	void *buf = get_data(size, dry_run);
+	void *buf;
+
+	/* Write large blob in stream without allocating full buffer. */
+	if (!dry_run && type == OBJ_BLOB && size > big_file_threshold) {
+		write_stream_blob(nr, size);
+		return;
+	}
 
+	buf = get_data(size, dry_run);
 	if (!dry_run && buf)
 		write_object(nr, type, buf, size);
 	else
diff --git a/object-file.c b/object-file.c
index fa54e39c2c..71d510614b 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1878,9 +1878,9 @@ static const void *feed_simple_input_stream(struct input_stream *in_stream, unsi
 	return data->buf;
 }
 
-static int write_loose_object(const struct object_id *oid, char *hdr,
-			      int hdrlen, struct input_stream *in_stream,
-			      time_t mtime, unsigned flags)
+int write_loose_object(const struct object_id *oid, char *hdr,
+		       int hdrlen, struct input_stream *in_stream,
+		       time_t mtime, unsigned flags)
 {
 	int fd, ret;
 	unsigned char compressed[4096];
diff --git a/object-store.h b/object-store.h
index a84d891d60..ac5b11ec16 100644
--- a/object-store.h
+++ b/object-store.h
@@ -229,6 +229,10 @@ int hash_object_file(const struct git_hash_algo *algo, const void *buf,
 		     unsigned long len, const char *type,
 		     struct object_id *oid);
 
+int write_loose_object(const struct object_id *oid, char *hdr,
+		       int hdrlen, struct input_stream *in_stream,
+		       time_t mtime, unsigned flags);
+
 int write_object_file_flags(const void *buf, unsigned long len,
 			    const char *type, struct object_id *oid,
 			    unsigned flags);
diff --git a/t/t5590-unpack-non-delta-objects.sh b/t/t5590-unpack-non-delta-objects.sh
new file mode 100755
index 0000000000..01d950d119
--- /dev/null
+++ b/t/t5590-unpack-non-delta-objects.sh
@@ -0,0 +1,76 @@
+#!/bin/sh
+#
+# Copyright (c) 2021 Han Xin
+#
+
+test_description='Test unpack-objects when receive pack'
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+
+test_expect_success "create commit with big blobs (1.5 MB)" '
+	test-tool genrandom foo 1500000 >big-blob &&
+	test_commit --append foo big-blob &&
+	test-tool genrandom bar 1500000 >big-blob &&
+	test_commit --append bar big-blob &&
+	(
+		cd .git &&
+		find objects/?? -type f | sort
+	) >expect &&
+	PACK=$(echo main | git pack-objects --progress --revs test)
+'
+
+test_expect_success 'setup GIT_ALLOC_LIMIT to 1MB' '
+	GIT_ALLOC_LIMIT=1m &&
+	export GIT_ALLOC_LIMIT
+'
+
+test_expect_success 'prepare dest repository' '
+	git init --bare dest.git &&
+	git -C dest.git config core.bigFileThreshold 2m &&
+	git -C dest.git config receive.unpacklimit 100
+'
+
+test_expect_success 'fail to unpack-objects: cannot allocate' '
+	test_must_fail git -C dest.git unpack-objects <test-$PACK.pack 2>err &&
+	test_i18ngrep "fatal: attempting to allocate" err &&
+	(
+		cd dest.git &&
+		find objects/?? -type f | sort
+	) >actual &&
+	! test_cmp expect actual
+'
+
+test_expect_success 'set a lower bigfile threshold' '
+	git -C dest.git config core.bigFileThreshold 1m
+'
+
+test_expect_success 'unpack big object in stream' '
+	git -C dest.git unpack-objects <test-$PACK.pack &&
+	git -C dest.git fsck &&
+	(
+		cd dest.git &&
+		find objects/?? -type f | sort
+	) >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'setup for unpack-objects dry-run test' '
+	git init --bare unpack-test.git
+'
+
+test_expect_success 'unpack-objects dry-run' '
+	(
+		cd unpack-test.git &&
+		git unpack-objects -n <../test-$PACK.pack
+	) &&
+	(
+		cd unpack-test.git &&
+		find objects/ -type f
+	) >actual &&
+	test_must_be_empty actual
+'
+
+test_done
-- 
2.34.0

