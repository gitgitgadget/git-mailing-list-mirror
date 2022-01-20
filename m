Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE2BC433F5
	for <git@archiver.kernel.org>; Thu, 20 Jan 2022 11:22:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbiATLWy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jan 2022 06:22:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbiATLWp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jan 2022 06:22:45 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5A7C061768
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 03:22:39 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id p37so5256923pfh.4
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 03:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=en7Q0c0xF0HZ+3SJvVOwNMeMZlISONwk0XR0TjrgUSk=;
        b=SsrNfk4paBhd9TBfK69u2r71iMEyzGe95X/hjXVYoHPNbw6/F3Mlx909r4KmsWxTlm
         YB8GBSiqAox2dYmndmPLCfxfaA0cXx/OqMyoNpLYJM//uy16mydUVN+BQVT3RZjH256A
         aVrMXzQ4C4uTnMbpzr8MXpMvdsHDjIMCHt9hEHQ7ghsXmxgJrkXDL7tBrCdmcX0NOclB
         EsXejZcLVyWWbD4XleTjKztGRFgNOFY4EP5BE17pkKU0fBZcocE3kvVlPupiE2wHo39T
         SGsDnQgrDdYbqSalQf+hmOuXyX/duv+dumV5fQtQfKXfftU3YCO/BbyI6BH00zA6rrDz
         4ujw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=en7Q0c0xF0HZ+3SJvVOwNMeMZlISONwk0XR0TjrgUSk=;
        b=TzXdvHUkit2ne6FNRNTxB47ZlG7ZObPFGRbx0xJvjZ/uKvkneBUcSkRbIfdrfw40mP
         iG0c1ANTsozR7wxk/q3pv/GpHB77N9zuS2NJfr1DSr5pw2QMCskPl8Ck0Teupy2Gm6sO
         /UP4O3GaiG2RQ0kyyH5UwlqVredXkMuYhHQVoZgLGh4pEl8ZkZR6OG6um+vTgo0+DiRq
         whOvQSdlMQVAvxV33Bg8sOdaHqV3tD29dMQR3bNxVfqH0/7YZwmK+XTjw4tq34k9tINh
         nPsQddjw29gudKiHibqHsPi5i1yUi/g5kKi7SrJxW0aiiIaDHw7+AaAMAbmZI4YDRQwC
         PHHw==
X-Gm-Message-State: AOAM533GFhx+uSt//rhFcoiD5oB1VJCtweZJCxAzf4ULn4O9WM3LcBwc
        aUHMgGshjUq6Bou/ekZcWZ0=
X-Google-Smtp-Source: ABdhPJxQbhBKVAhNKYEiBgAKWMoreiynz+ypJ0Buy5Jer+ibXigKZBMTE/FUU+d4NEHPVtHPsInk7Q==
X-Received: by 2002:a63:1a20:: with SMTP id a32mr842320pga.150.1642677759090;
        Thu, 20 Jan 2022 03:22:39 -0800 (PST)
Received: from localhost.localdomain ([58.100.34.57])
        by smtp.gmail.com with ESMTPSA id x18sm2998989pfh.192.2022.01.20.03.22.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jan 2022 03:22:38 -0800 (PST)
From:   Han Xin <chiyutianyi@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Jiang Xin <worldhello.net@gmail.com>
Cc:     Han Xin <hanxin.hx@alibaba-inc.com>
Subject: [PATCH v9 4/5] unpack-objects: unpack_non_delta_entry() read data in a stream
Date:   Thu, 20 Jan 2022 19:21:13 +0800
Message-Id: <20220120112114.47618-5-chiyutianyi@gmail.com>
X-Mailer: git-send-email 2.34.1.52.gc288e771b4.agit.6.5.6
In-Reply-To: <20220108085419.79682-1-chiyutianyi@gmail.com>
References: <20220108085419.79682-1-chiyutianyi@gmail.com>
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
a small fixed buffer for "unpack_non_delta_entry()". However, unpack
non-delta objects from a stream instead of from an entrie buffer will
have 10% performance penalty.

    $ hyperfine \
      --setup \
      'if ! test -d scalar.git; then git clone --bare
       https://github.com/microsoft/scalar.git;
       cp scalar.git/objects/pack/*.pack small.pack; fi' \
      --prepare 'rm -rf dest.git && git init --bare dest.git' \
      ...

    Summary
      './git -C dest.git -c core.bigFileThreshold=512m
      unpack-objects <small.pack' in 'origin/master'
        1.01 ± 0.04 times faster than './git -C dest.git
                -c core.bigFileThreshold=512m unpack-objects
                <small.pack' in 'HEAD~1'
        1.01 ± 0.04 times faster than './git -C dest.git
                -c core.bigFileThreshold=512m unpack-objects
                <small.pack' in 'HEAD~0'
        1.03 ± 0.10 times faster than './git -C dest.git
                -c core.bigFileThreshold=16k unpack-objects
                <small.pack' in 'origin/master'
        1.02 ± 0.07 times faster than './git -C dest.git
                -c core.bigFileThreshold=16k unpack-objects
                <small.pack' in 'HEAD~0'
        1.10 ± 0.04 times faster than './git -C dest.git
                -c core.bigFileThreshold=16k unpack-objects
                <small.pack' in 'HEAD~1'

Therefore, only unpack objects larger than the "core.bigFileThreshold"
in zstream. Until now, the config variable has been used in the
following cases, and our new case belongs to the packfile category.

 * Archive:

   + archive.c: write_entry(): write large blob entries to archive in
     stream.

 * Loose objects:

   + object-file.c: index_fd(): when hashing large files in worktree,
     read files in a stream, and create one packfile per large blob if
     want to save files to git object store.

   + object-file.c: read_loose_object(): when checking loose objects
     using "git-fsck", do not read full content of large loose objects.

 * Packfile:

   + fast-import.c: parse_and_store_blob(): streaming large blob from
     foreign source to packfile.

   + index-pack.c: check_collison(): read and check large blob in stream.

   + index-pack.c: unpack_entry_data(): do not return the entire
     contents of the big blob from packfile, but uses a fixed buf to
     perform some integrity checks on the object.

   + pack-check.c: verify_packfile(): used by "git-fsck" and will call
     check_object_signature() to check large blob in pack with the
     streaming interface.

   + pack-objects.c: get_object_details(): set "no_try_delta" for large
     blobs when counting objects.

   + pack-objects.c: write_no_reuse_object(): streaming large blob to
     pack.

   + unpack-objects.c: unpack_non_delta_entry(): unpack large blob in
     stream from packfile.

 * Others:

   + diff.c: diff_populate_filespec(): treat large blob file as binary.

   + streaming.c: istream_source(): as a helper of "open_istream()" to
     select proper streaming interface to read large blob from packfile.

Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Helped-by: Derrick Stolee <stolee@gmail.com>
Helped-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
---
 builtin/unpack-objects.c        | 71 ++++++++++++++++++++++++++++++++-
 t/t5328-unpack-large-objects.sh | 23 +++++++++--
 2 files changed, 90 insertions(+), 4 deletions(-)

diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index c6d6c17072..e9ec2b349d 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -343,11 +343,80 @@ static void added_object(unsigned nr, enum object_type type,
 	}
 }
 
+struct input_zstream_data {
+	git_zstream *zstream;
+	unsigned char buf[8192];
+	int status;
+};
+
+static const void *feed_input_zstream(struct input_stream *in_stream,
+				      unsigned long *readlen)
+{
+	struct input_zstream_data *data = in_stream->data;
+	git_zstream *zstream = data->zstream;
+	void *in = fill(1);
+
+	if (in_stream->is_finished) {
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
+
+	in_stream->is_finished = data->status != Z_OK;
+	use(len - zstream->avail_in);
+	*readlen = sizeof(data->buf) - zstream->avail_out;
+
+	return data->buf;
+}
+
+static void write_stream_blob(unsigned nr, size_t size)
+{
+	git_zstream zstream = { 0 };
+	struct input_zstream_data data = { 0 };
+	struct input_stream in_stream = {
+		.read = feed_input_zstream,
+		.data = &data,
+	};
+
+	data.zstream = &zstream;
+	git_inflate_init(&zstream);
+
+	if (stream_loose_object(&in_stream, size, &obj_list[nr].oid))
+		die(_("failed to write object in stream"));
+
+	if (data.status != Z_STREAM_END)
+		die(_("inflate returned (%d)"), data.status);
+	git_inflate_end(&zstream);
+
+	if (strict) {
+		struct blob *blob =
+			lookup_blob(the_repository, &obj_list[nr].oid);
+		if (blob)
+			blob->object.flags |= FLAG_WRITTEN;
+		else
+			die(_("invalid blob object from stream"));
+	}
+	obj_list[nr].obj = NULL;
+}
+
 static void unpack_non_delta_entry(enum object_type type, unsigned long size,
 				   unsigned nr)
 {
-	void *buf = get_data(size);
+	void *buf;
+
+	/* Write large blob in stream without allocating full buffer. */
+	if (!dry_run && type == OBJ_BLOB && size > big_file_threshold) {
+		write_stream_blob(nr, size);
+		return;
+	}
 
+	buf = get_data(size);
 	if (buf)
 		write_object(nr, type, buf, size);
 }
diff --git a/t/t5328-unpack-large-objects.sh b/t/t5328-unpack-large-objects.sh
index 45a3316e06..f4129979f9 100755
--- a/t/t5328-unpack-large-objects.sh
+++ b/t/t5328-unpack-large-objects.sh
@@ -9,7 +9,11 @@ test_description='git unpack-objects with large objects'
 
 prepare_dest () {
 	test_when_finished "rm -rf dest.git" &&
-	git init --bare dest.git
+	git init --bare dest.git &&
+	if test -n "$1"
+	then
+		git -C dest.git config core.bigFileThreshold $1
+	fi
 }
 
 test_no_loose () {
@@ -33,16 +37,29 @@ test_expect_success 'set memory limitation to 1MB' '
 '
 
 test_expect_success 'unpack-objects failed under memory limitation' '
-	prepare_dest &&
+	prepare_dest 2m &&
 	test_must_fail git -C dest.git unpack-objects <test-$PACK.pack 2>err &&
 	grep "fatal: attempting to allocate" err
 '
 
 test_expect_success 'unpack-objects works with memory limitation in dry-run mode' '
-	prepare_dest &&
+	prepare_dest 2m &&
 	git -C dest.git unpack-objects -n <test-$PACK.pack &&
 	test_no_loose &&
 	test_dir_is_empty dest.git/objects/pack
 '
 
+test_expect_success 'unpack big object in stream' '
+	prepare_dest 1m &&
+	git -C dest.git unpack-objects <test-$PACK.pack &&
+	test_dir_is_empty dest.git/objects/pack
+'
+
+test_expect_success 'do not unpack existing large objects' '
+	prepare_dest 1m &&
+	git -C dest.git index-pack --stdin <test-$PACK.pack &&
+	git -C dest.git unpack-objects <test-$PACK.pack &&
+	test_no_loose
+'
+
 test_done
-- 
2.34.1.52.gc288e771b4.agit.6.5.6

