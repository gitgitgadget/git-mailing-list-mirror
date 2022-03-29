Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EBABC433EF
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 13:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235227AbiC2N6b (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Mar 2022 09:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237633AbiC2N6V (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Mar 2022 09:58:21 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AEA32274CB
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 06:56:28 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id w25so20787108edi.11
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 06:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vngh4Fxou6rwEF8RDt4p4btz9ytXiOaeMZ8l2sI30dw=;
        b=Akq81DgH3n8KLZDQsuLhmW+qCBwHcwQ/+iWNyNGLJY+Ubw1C21xzVNgDyCzg7bYJx2
         OAIWjzPG5Jn6j14QTpdQPoDHwlTKhV0elf3hTwqqR76M7YIgpVD9AZeRSZKBUOpChT68
         0icHhM4HwJ7Q90pGKwCqVZ537Fb6HZAIO3Bv4jz/cwRNgAEs+QAYZsnGYTAZLE4clUAe
         2auGdW9afGUmkOfEQLz4ApDTf+TekX/97zSMNEeIYABcdYyuIFUn0Zaj4v2Pv0zyAMMD
         MB9gH0tsW6FJE2ZMeH3rp+iMHGbSxnfFAe/Gghai+Sua6TldHpwr5799h7YYW9Up/wfJ
         rDqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vngh4Fxou6rwEF8RDt4p4btz9ytXiOaeMZ8l2sI30dw=;
        b=yviBWTgGMWPuAqutsmc1jGrFw6OJySs7ra1C60UlgYTWRr4akXjAJNm4C81CdQanzX
         RdpoyJ5KXNMTPUnCi0ezABcgpDJYhCjDBy8tO69TNJDE+rCD+CSa3sAwhsy5yQbCkRQn
         uxlzCebxxqlO9QMZxwjDwv7Z1U/It74FajrzzP1QGsNJNimBshroq7fm2xANLIHjNBHA
         rbNVh63/i6rQeXfUT0mpLDFq7vE2pQGP4IgiuG02LtzBvkkFlRmHm11zjJ5JOJ4XLjch
         ShU9iWGCoY8yUIuqUf7uuZr6jXGqUrYAzXUrwooYBvrZ1csReaNEaLNJ1U2bSqOJlS6B
         LDuA==
X-Gm-Message-State: AOAM531j2oKZcbNh53LVnq3RpCkzqRXqAEnPu/+JiWQemwNTe8Jwd3UC
        eu5eHwCbbW5UXbieGc7goseY0uxrF7tt7Q==
X-Google-Smtp-Source: ABdhPJwlrKbykxF6nQKzeXqEGbah8kzUNrxUn7n6hH+IcxyJcbWdbBG163gji0JDUYG+uwfYvjpYCA==
X-Received: by 2002:a50:c3c6:0:b0:416:293f:1f42 with SMTP id i6-20020a50c3c6000000b00416293f1f42mr4680144edf.187.1648562186735;
        Tue, 29 Mar 2022 06:56:26 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id ds5-20020a170907724500b006df8f39dadesm7006601ejc.218.2022.03.29.06.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 06:56:26 -0700 (PDT)
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
Subject: [PATCH v12 8/8] unpack-objects: use stream_loose_object() to unpack large objects
Date:   Tue, 29 Mar 2022 15:56:13 +0200
Message-Id: <patch-v12-8.8-34ee6a28a54-20220329T135446Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1548.g36973b18e52
In-Reply-To: <cover-v12-0.8-00000000000-20220329T135446Z-avarab@gmail.com>
References: <cover-v11-0.8-00000000000-20220319T001411Z-avarab@gmail.com> <cover-v12-0.8-00000000000-20220329T135446Z-avarab@gmail.com>
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
 builtin/unpack-objects.c        | 67 +++++++++++++++++++++++++++++++++
 t/t5351-unpack-large-objects.sh | 26 +++++++++++--
 3 files changed, 92 insertions(+), 5 deletions(-)

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index 5fccbd56995..716259b6762 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -436,8 +436,8 @@ usage, at the slight expense of increased disk usage.
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
index d374599d544..9d7b325c23b 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -338,6 +338,68 @@ static void added_object(unsigned nr, enum object_type type,
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
@@ -471,6 +533,11 @@ static void unpack_one(unsigned nr)
 
 	switch (type) {
 	case OBJ_BLOB:
+		if (!dry_run && size > big_file_threshold) {
+			stream_blob(size, nr);
+			return;
+		}
+		/* fallthrough */
 	case OBJ_COMMIT:
 	case OBJ_TREE:
 	case OBJ_TAG:
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
2.35.1.1548.g36973b18e52

