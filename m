Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C940C433F5
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 10:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237845AbhLJKiv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 05:38:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237753AbhLJKit (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 05:38:49 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7600C0617A2
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 02:35:14 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id m24so5975340pls.10
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 02:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PaJSC6y27DwFRXMb67RMHi84rf/+02Jm+aUFCi7CmuM=;
        b=BJUkamN4ri9KBkQDznZWAEQy06QRAdNFu7YaxdM1maT5fTcd1VUe+fyOusU2VCPR/3
         EGepREHAwX+0tskXFC5uWQXD+61cc/XrL3IO/rA30I66GHF0A1K0v8Xp7110przmoA8Q
         4uA5Q6LR0A/5i18WbKXc3xVTJ/xlnC4bINb+0VX221o8pPm2xb/RCeOkFTSBOtMvGNdC
         0psiNylsh6t54Wa39L1EfDedYzNwE4caJXL/n/H1gp/JrtwPtZA0uqNRup4ENrDUIXao
         oRElxxHfotkKzMaYQ7BcYOqyiW5Z91cOMwMVjd4APYwZ2BskWvInjd7afFOH+V5o6S9X
         7j+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PaJSC6y27DwFRXMb67RMHi84rf/+02Jm+aUFCi7CmuM=;
        b=sLPFIPfaG4gnFHgoGR5pNMM6wPsoUCoKK1V5s47lIoRY3hktN7Xw77BhF62+CeY6c/
         3l5fNN5MpATuPMH25q2aAwFCjL2nXltHImcN1++DKKDxCsPrO1uElcgJXpuLzrGQr3bO
         g/DEmVAWl/ef58kNkj2DVIhFn38Qp5sbHfBtkKU5HO7C6CCcsVq5+dpAcEIxfDwQKIcT
         CboaAcnZ2eltb/ML8998HDf/IJVpf/J/yP1RtiaIP75YCqJFsLWbJT9/SXQ35mISrMjb
         Y/E7ypXML4cUGf+2YR28o2AixmX09t6Ll0hn6SUArkndDn/bbeDJNl7irudjsiETqr6G
         2wwA==
X-Gm-Message-State: AOAM5305fqhsAqWJg8P07JCgokHQKGPJGMvncS8Qx6PIRL54AwnV91Tx
        28nE57zpgR7x+6XPZV4v4Ys=
X-Google-Smtp-Source: ABdhPJwXxidNeLnwkVAkd6xSsE6e3eXTQUn5HKdCitS1Dt5GSlbMd1As1T4Rl8vDjlv5z7o+c6cz1w==
X-Received: by 2002:a17:902:dad2:b0:141:fbea:178d with SMTP id q18-20020a170902dad200b00141fbea178dmr74661519plx.78.1639132514256;
        Fri, 10 Dec 2021 02:35:14 -0800 (PST)
Received: from localhost.localdomain ([205.204.117.96])
        by smtp.gmail.com with ESMTPSA id 204sm2396250pgb.63.2021.12.10.02.35.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Dec 2021 02:35:13 -0800 (PST)
From:   Han Xin <chiyutianyi@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Derrick Stolee <stolee@gmail.com>
Cc:     Han Xin <hanxin.hx@alibaba-inc.com>
Subject: [PATCH v5 6/6] unpack-objects: unpack_non_delta_entry() read data in a stream
Date:   Fri, 10 Dec 2021 18:34:35 +0800
Message-Id: <20211210103435.83656-7-chiyutianyi@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211203093530.93589-1-chiyutianyi@gmail.com>
References: <20211203093530.93589-1-chiyutianyi@gmail.com>
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
larger than the "core.BigFileStreamingThreshold" in zstream. See the following
benchmarks:

    hyperfine \
      --setup \
      'if ! test -d scalar.git; then git clone --bare https://github.com/microsoft/scalar.git; cp scalar.git/objects/pack/*.pack small.pack; fi' \
      --prepare 'rm -rf dest.git && git init --bare dest.git'

    Summary
      './git -C dest.git -c core.bigfilethreshold=512m unpack-objects <small.pack' in 'origin/master'
        1.01 ± 0.04 times faster than './git -C dest.git -c core.bigfilethreshold=512m unpack-objects <small.pack' in 'HEAD~1'
        1.01 ± 0.04 times faster than './git -C dest.git -c core.bigfilethreshold=512m unpack-objects <small.pack' in 'HEAD~0'
        1.03 ± 0.10 times faster than './git -C dest.git -c core.bigfilethreshold=16k unpack-objects <small.pack' in 'origin/master'
        1.02 ± 0.07 times faster than './git -C dest.git -c core.bigfilethreshold=16k unpack-objects <small.pack' in 'HEAD~0'
        1.10 ± 0.04 times faster than './git -C dest.git -c core.bigfilethreshold=16k unpack-objects <small.pack' in 'HEAD~1'

Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Helped-by: Derrick Stolee <stolee@gmail.com>
Helped-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
---
 Documentation/config/core.txt       | 11 +++++
 builtin/unpack-objects.c            | 70 ++++++++++++++++++++++++++++-
 cache.h                             |  1 +
 config.c                            |  5 +++
 environment.c                       |  1 +
 t/t5590-unpack-non-delta-objects.sh | 70 +++++++++++++++++++++++++++++
 6 files changed, 157 insertions(+), 1 deletion(-)
 create mode 100755 t/t5590-unpack-non-delta-objects.sh

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index c04f62a54a..601b7a2418 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -424,6 +424,17 @@ be delta compressed, but larger binary media files won't be.
 +
 Common unit suffixes of 'k', 'm', or 'g' are supported.
 
+core.bigFileStreamingThreshold::
+	Files larger than this will be streamed out to a temporary
+	object file while being hashed, which will when be renamed
+	in-place to a loose object, particularly if the
+	`core.bigFileThreshold' setting dictates that they're always
+	written out as loose objects.
++
+Default is 128 MiB on all platforms.
++
+Common unit suffixes of 'k', 'm', or 'g' are supported.
+
 core.excludesFile::
 	Specifies the pathname to the file that contains patterns to
 	describe paths that are not meant to be tracked, in addition
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index d878e2f8b4..0df115ab0d 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -326,11 +326,79 @@ static void added_object(unsigned nr, enum object_type type,
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
+	git_zstream zstream;
+	struct input_zstream_data data;
+	struct input_stream in_stream = {
+		.read = feed_input_zstream,
+		.data = &data,
+	};
+	int ret;
+
+	memset(&zstream, 0, sizeof(zstream));
+	memset(&data, 0, sizeof(data));
+	data.zstream = &zstream;
+	git_inflate_init(&zstream);
+
+	if ((ret = write_object_file_flags(&in_stream, size, type_name(OBJ_BLOB) ,&obj_list[nr].oid, HASH_STREAM)))
+		die(_("failed to write object in stream %d"), ret);
+
+	if (zstream.total_out != size || data.status != Z_STREAM_END)
+		die(_("inflate returned %d"), data.status);
+	git_inflate_end(&zstream);
+
+	if (strict && !dry_run) {
+		struct blob *blob = lookup_blob(the_repository, &obj_list[nr].oid);
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
+	if (!dry_run && type == OBJ_BLOB && size > big_file_streaming_threshold) {
+		write_stream_blob(nr, size);
+		return;
+	}
 
+	buf = get_data(size, dry_run);
 	if (!dry_run && buf)
 		write_object(nr, type, buf, size);
 	else
diff --git a/cache.h b/cache.h
index 51bd435dea..78548cd67a 100644
--- a/cache.h
+++ b/cache.h
@@ -965,6 +965,7 @@ extern size_t packed_git_window_size;
 extern size_t packed_git_limit;
 extern size_t delta_base_cache_limit;
 extern unsigned long big_file_threshold;
+extern unsigned long big_file_streaming_threshold;
 extern unsigned long pack_size_limit_cfg;
 
 /*
diff --git a/config.c b/config.c
index c5873f3a70..7b122a142a 100644
--- a/config.c
+++ b/config.c
@@ -1408,6 +1408,11 @@ static int git_default_core_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.bigfilestreamingthreshold")) {
+		big_file_streaming_threshold = git_config_ulong(var, value);
+		return 0;
+	}
+
 	if (!strcmp(var, "core.packedgitlimit")) {
 		packed_git_limit = git_config_ulong(var, value);
 		return 0;
diff --git a/environment.c b/environment.c
index 9da7f3c1a1..4fcc3de741 100644
--- a/environment.c
+++ b/environment.c
@@ -46,6 +46,7 @@ size_t packed_git_window_size = DEFAULT_PACKED_GIT_WINDOW_SIZE;
 size_t packed_git_limit = DEFAULT_PACKED_GIT_LIMIT;
 size_t delta_base_cache_limit = 96 * 1024 * 1024;
 unsigned long big_file_threshold = 512 * 1024 * 1024;
+unsigned long big_file_streaming_threshold = 128 * 1024 * 1024;
 int pager_use_color = 1;
 const char *editor_program;
 const char *askpass_program;
diff --git a/t/t5590-unpack-non-delta-objects.sh b/t/t5590-unpack-non-delta-objects.sh
new file mode 100755
index 0000000000..ff4c78900b
--- /dev/null
+++ b/t/t5590-unpack-non-delta-objects.sh
@@ -0,0 +1,70 @@
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
+prepare_dest () {
+	test_when_finished "rm -rf dest.git" &&
+	git init --bare dest.git &&
+	git -C dest.git config core.bigFileStreamingThreshold $1
+	git -C dest.git config core.bigFileThreshold $1
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
+	prepare_dest 2m &&
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
+test_expect_success 'unpack big object in stream' '
+	prepare_dest 1m &&
+	git -C dest.git unpack-objects <test-$PACK.pack &&
+	git -C dest.git fsck &&
+	(
+		cd dest.git &&
+		find objects/?? -type f | sort
+	) >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'unpack-objects dry-run' '
+	prepare_dest 1m &&
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
2.34.0

