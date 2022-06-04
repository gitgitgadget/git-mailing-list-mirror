Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F21AC433EF
	for <git@archiver.kernel.org>; Sat,  4 Jun 2022 10:11:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234731AbiFDKK7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Jun 2022 06:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234583AbiFDKKo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Jun 2022 06:10:44 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1820F26543
        for <git@vger.kernel.org>; Sat,  4 Jun 2022 03:10:42 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id k16so13271931wrg.7
        for <git@vger.kernel.org>; Sat, 04 Jun 2022 03:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZgwYQP7R0EbztF0iFcf71xyIwwJ38Lwu8n2R5fgZH+4=;
        b=enDzjt1QGapFpAquz7hL7yvAjfwmSA36FOFzbgLUfZakvcAUOxDfqUteuZ03ZiocKR
         yszO/5KM/NQbFtv/TYgGaH1W5WjSGVuXYYpViK3GpbEcbke1JWGlGg4t4RjbsMGRi5kX
         cH0D3pi6uQqixRyOg8fPVLFjSk7Ki/kQdrgQ7Oa7kmB8NSr2uqCdszsCVjJTQPQQRIef
         u9ngPIPSeX3JL12PP8l92QfGBUQVCW7TOqDdxQ7Sdg7TzT4fOc9e2wsPR34IvQl9CyrT
         wxOVmFVcdF7BCT16INB+YPDDOBDudKjJg3Y1mXMMqnCTYJFdhNs/JWN14zl8EyGdOhLi
         t1IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZgwYQP7R0EbztF0iFcf71xyIwwJ38Lwu8n2R5fgZH+4=;
        b=j268QVn+SEw6ftVV7M8epOivVTIGVwNqXOtBJdbbPHTVKVxMWn1R6okB2XwsWvui2t
         zsvq11w/KJYJ3/FMDeaGS63QdWVr5VrtbMrKSvEM/z0t9jnviyn9IKKkiWaGN3HwxgAW
         PYaWoVCBOmY0h0BAHlFqV3sNn6y8nHrYWy3BxDtYxQvDCi1foJVl+MYoDHuuzNe0IDWi
         t+xdJPD/hza/b230IruRpHB7bBoybzoSnBTc7DbxgRXXxJ0+h6qxkNNaplZxllbYwrVr
         N/DuIWtECvOjae6ed2LsiCR1aeVMVHnsgM7pfccctYjCpcuIo+S7YTKOPuxcPARUsQne
         1XRg==
X-Gm-Message-State: AOAM531xyk6uxWiy3kqR9bEg3nrr0Q9ZFER4fasy7IkqMsdpjPLZWIou
        gavdstuKYs0aTDgjs/tp2XTFjcYE1Gs2Rw==
X-Google-Smtp-Source: ABdhPJwKffhPv6d3p79KzI/Rc7EHXJJwb8hPQkWP4F8sW3el1JPz9aXdHREaXMOJiPI7JA7igwFfXA==
X-Received: by 2002:a05:6000:1acc:b0:20f:f12a:a535 with SMTP id i12-20020a0560001acc00b0020ff12aa535mr12688368wry.375.1654337440092;
        Sat, 04 Jun 2022 03:10:40 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i12-20020a05600c354c00b0039765a7add4sm15069631wmq.29.2022.06.04.03.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jun 2022 03:10:39 -0700 (PDT)
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
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v13 7/7] unpack-objects: use stream_loose_object() to unpack large objects
Date:   Sat,  4 Jun 2022 12:10:28 +0200
Message-Id: <patch-v13-7.7-5bc8fa9bc8d-20220604T095113Z-avarab@gmail.com>
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

Make use of the stream_loose_object() function introduced in the
preceding commit to unpack large objects. Before this we'd need to
malloc() the size of the blob before unpacking it, which could cause
OOM with very large blobs.

We could use the new streaming interface to unpack all blobs, but
doing so would be much slower, as demonstrated e.g. with this
benchmark using git-hyperfine[0]:

	rm -rf /tmp/scalar.git &&
	git clone --bare https://github.com/Microsoft/scalar.git /tmp/scalar.git &&
	mv /tmp/scalar.git/objects/pack/*.pack /tmp/scalar.git/my.pack &&
	git hyperfine \
		-r 2 --warmup 1 \
		-L rev origin/master,HEAD -L v "10,512,1k,1m" \
		-s 'make' \
		-p 'git init --bare dest.git' \
		-c 'rm -rf dest.git' \
		'./git -C dest.git -c core.bigFileThreshold={v} unpack-objects </tmp/scalar.git/my.pack'

Here we'll perform worse with lower core.bigFileThreshold settings
with this change in terms of speed, but we're getting lower memory use
in return:

	Summary
	  './git -C dest.git -c core.bigFileThreshold=10 unpack-objects </tmp/scalar.git/my.pack' in 'origin/master' ran
	    1.01 ± 0.01 times faster than './git -C dest.git -c core.bigFileThreshold=1k unpack-objects </tmp/scalar.git/my.pack' in 'origin/master'
	    1.01 ± 0.01 times faster than './git -C dest.git -c core.bigFileThreshold=1m unpack-objects </tmp/scalar.git/my.pack' in 'origin/master'
	    1.01 ± 0.02 times faster than './git -C dest.git -c core.bigFileThreshold=1m unpack-objects </tmp/scalar.git/my.pack' in 'HEAD'
	    1.02 ± 0.00 times faster than './git -C dest.git -c core.bigFileThreshold=512 unpack-objects </tmp/scalar.git/my.pack' in 'origin/master'
	    1.09 ± 0.01 times faster than './git -C dest.git -c core.bigFileThreshold=1k unpack-objects </tmp/scalar.git/my.pack' in 'HEAD'
	    1.10 ± 0.00 times faster than './git -C dest.git -c core.bigFileThreshold=512 unpack-objects </tmp/scalar.git/my.pack' in 'HEAD'
	    1.11 ± 0.00 times faster than './git -C dest.git -c core.bigFileThreshold=10 unpack-objects </tmp/scalar.git/my.pack' in 'HEAD'

A better benchmark to demonstrate the benefits of that this one, which
creates an artificial repo with a 1, 25, 50, 75 and 100MB blob:

	rm -rf /tmp/repo &&
	git init /tmp/repo &&
	(
		cd /tmp/repo &&
		for i in 1 25 50 75 100
		do
			dd if=/dev/urandom of=blob.$i count=$(($i*1024)) bs=1024
		done &&
		git add blob.* &&
		git commit -mblobs &&
		git gc &&
		PACK=$(echo .git/objects/pack/pack-*.pack) &&
		cp "$PACK" my.pack
	) &&
	git hyperfine \
		--show-output \
		-L rev origin/master,HEAD -L v "512,50m,100m" \
		-s 'make' \
		-p 'git init --bare dest.git' \
		-c 'rm -rf dest.git' \
		'/usr/bin/time -v ./git -C dest.git -c core.bigFileThreshold={v} unpack-objects </tmp/repo/my.pack 2>&1 | grep Maximum'

Using this test we'll always use >100MB of memory on
origin/master (around ~105MB), but max out at e.g. ~55MB if we set
core.bigFileThreshold=50m.

The relevant "Maximum resident set size" lines were manually added
below the relevant benchmark:

  '/usr/bin/time -v ./git -C dest.git -c core.bigFileThreshold=50m unpack-objects </tmp/repo/my.pack 2>&1 | grep Maximum' in 'origin/master' ran
        Maximum resident set size (kbytes): 107080
    1.02 ± 0.78 times faster than '/usr/bin/time -v ./git -C dest.git -c core.bigFileThreshold=512 unpack-objects </tmp/repo/my.pack 2>&1 | grep Maximum' in 'origin/master'
        Maximum resident set size (kbytes): 106968
    1.09 ± 0.79 times faster than '/usr/bin/time -v ./git -C dest.git -c core.bigFileThreshold=100m unpack-objects </tmp/repo/my.pack 2>&1 | grep Maximum' in 'origin/master'
        Maximum resident set size (kbytes): 107032
    1.42 ± 1.07 times faster than '/usr/bin/time -v ./git -C dest.git -c core.bigFileThreshold=100m unpack-objects </tmp/repo/my.pack 2>&1 | grep Maximum' in 'HEAD'
        Maximum resident set size (kbytes): 107072
    1.83 ± 1.02 times faster than '/usr/bin/time -v ./git -C dest.git -c core.bigFileThreshold=50m unpack-objects </tmp/repo/my.pack 2>&1 | grep Maximum' in 'HEAD'
        Maximum resident set size (kbytes): 55704
    2.16 ± 1.19 times faster than '/usr/bin/time -v ./git -C dest.git -c core.bigFileThreshold=512 unpack-objects </tmp/repo/my.pack 2>&1 | grep Maximum' in 'HEAD'
        Maximum resident set size (kbytes): 4564

This shows that if you have enough memory this new streaming method is
slower the lower you set the streaming threshold, but the benefit is
more bounded memory use.

An earlier version of this patch introduced a new
"core.bigFileStreamingThreshold" instead of re-using the existing
"core.bigFileThreshold" variable[1]. As noted in a detailed overview
of its users in [2] using it has several different meanings.

Still, we consider it good enough to simply re-use it. While it's
possible that someone might want to e.g. consider objects "small" for
the purposes of diffing but "big" for the purposes of writing them
such use-cases are probably too obscure to worry about. We can always
split up "core.bigFileThreshold" in the future if there's a need for
that.

0. https://github.com/avar/git-hyperfine/
1. https://lore.kernel.org/git/20211210103435.83656-1-chiyutianyi@gmail.com/
2. https://lore.kernel.org/git/20220120112114.47618-5-chiyutianyi@gmail.com/

Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Helped-by: Derrick Stolee <stolee@gmail.com>
Helped-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config/core.txt   |  4 +-
 builtin/unpack-objects.c        | 69 ++++++++++++++++++++++++++++++++-
 t/t5351-unpack-large-objects.sh | 26 +++++++++++--
 3 files changed, 93 insertions(+), 6 deletions(-)

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index ff6ae6bb647..b97bc7e3e55 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -468,8 +468,8 @@ usage, at the slight expense of increased disk usage.
 * Will be generally be streamed when written, which avoids excessive
 memory usage, at the cost of some fixed overhead. Commands that make
 use of this include linkgit:git-archive[1],
-linkgit:git-fast-import[1], linkgit:git-index-pack[1] and
-linkgit:git-fsck[1].
+linkgit:git-fast-import[1], linkgit:git-index-pack[1],
+linkgit:git-unpack-objects[1] and linkgit:git-fsck[1].
 
 core.excludesFile::
 	Specifies the pathname to the file that contains patterns to
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 64abba8dbac..d3124202f54 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -348,6 +348,68 @@ static void unpack_non_delta_entry(enum object_type type, unsigned long size,
 		write_object(nr, type, buf, size);
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
+static void stream_blob(unsigned long size, unsigned nr)
+{
+	git_zstream zstream = { 0 };
+	struct input_zstream_data data = { 0 };
+	struct input_stream in_stream = {
+		.read = feed_input_zstream,
+		.data = &data,
+	};
+	struct obj_info *info = &obj_list[nr];
+
+	data.zstream = &zstream;
+	git_inflate_init(&zstream);
+
+	if (stream_loose_object(&in_stream, size, &info->oid))
+		die(_("failed to write object in stream"));
+
+	if (data.status != Z_STREAM_END)
+		die(_("inflate returned (%d)"), data.status);
+	git_inflate_end(&zstream);
+
+	if (strict) {
+		struct blob *blob = lookup_blob(the_repository, &info->oid);
+
+		if (!blob)
+			die(_("invalid blob object from stream"));
+		blob->object.flags |= FLAG_WRITTEN;
+	}
+	info->obj = NULL;
+}
+
 static int resolve_against_held(unsigned nr, const struct object_id *base,
 				void *delta_data, unsigned long delta_size)
 {
@@ -480,9 +542,14 @@ static void unpack_one(unsigned nr)
 	}
 
 	switch (type) {
+	case OBJ_BLOB:
+		if (!dry_run && size > big_file_threshold) {
+			stream_blob(size, nr);
+			return;
+		}
+		/* fallthrough */
 	case OBJ_COMMIT:
 	case OBJ_TREE:
-	case OBJ_BLOB:
 	case OBJ_TAG:
 		unpack_non_delta_entry(type, size, nr);
 		return;
diff --git a/t/t5351-unpack-large-objects.sh b/t/t5351-unpack-large-objects.sh
index 8d84313221c..461ca060b2b 100755
--- a/t/t5351-unpack-large-objects.sh
+++ b/t/t5351-unpack-large-objects.sh
@@ -9,7 +9,8 @@ test_description='git unpack-objects with large objects'
 
 prepare_dest () {
 	test_when_finished "rm -rf dest.git" &&
-	git init --bare dest.git
+	git init --bare dest.git &&
+	git -C dest.git config core.bigFileThreshold "$1"
 }
 
 test_expect_success "create large objects (1.5 MB) and PACK" '
@@ -26,16 +27,35 @@ test_expect_success 'set memory limitation to 1MB' '
 '
 
 test_expect_success 'unpack-objects failed under memory limitation' '
-	prepare_dest &&
+	prepare_dest 2m &&
 	test_must_fail git -C dest.git unpack-objects <pack-$PACK.pack 2>err &&
 	grep "fatal: attempting to allocate" err
 '
 
 test_expect_success 'unpack-objects works with memory limitation in dry-run mode' '
-	prepare_dest &&
+	prepare_dest 2m &&
 	git -C dest.git unpack-objects -n <pack-$PACK.pack &&
 	test_stdout_line_count = 0 find dest.git/objects -type f &&
 	test_dir_is_empty dest.git/objects/pack
 '
 
+test_expect_success 'unpack big object in stream' '
+	prepare_dest 1m &&
+	git -C dest.git unpack-objects <pack-$PACK.pack &&
+	test_dir_is_empty dest.git/objects/pack
+'
+
+test_expect_success 'do not unpack existing large objects' '
+	prepare_dest 1m &&
+	git -C dest.git index-pack --stdin <pack-$PACK.pack &&
+	git -C dest.git unpack-objects <pack-$PACK.pack &&
+
+	# The destination came up with the exact same pack...
+	DEST_PACK=$(echo dest.git/objects/pack/pack-*.pack) &&
+	test_cmp pack-$PACK.pack $DEST_PACK &&
+
+	# ...and wrote no loose objects
+	test_stdout_line_count = 0 find dest.git/objects -type f ! -name "pack-*"
+'
+
 test_done
-- 
2.36.1.1124.g52838f02905

