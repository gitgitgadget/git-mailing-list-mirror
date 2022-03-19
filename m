Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E5EC433F5
	for <git@archiver.kernel.org>; Sat, 19 Mar 2022 00:24:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241068AbiCSAZf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Mar 2022 20:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241664AbiCSAZa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Mar 2022 20:25:30 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B3713665B
        for <git@vger.kernel.org>; Fri, 18 Mar 2022 17:23:44 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id u10so13691139wra.9
        for <git@vger.kernel.org>; Fri, 18 Mar 2022 17:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AOeNIRp44Mv2o6ue+ZHw19CaEV4VWuq394+OG/scwCc=;
        b=by0iMjvAuFtbLLA5VdHZpWhqVUjZvjyp4gfy8ZBkQxdO9Z0om0UcRk/r2Q7M8llRjr
         A7tOD+O+EE3+aRGjgw8GLwabprLt6m2kyoC+08XVjRCRdfqrQbwUzm+16RY8voWb/xto
         xJxYGYMxSbuu5gWEDbydywsn04GgUot40MSLLwa5a1XepP+khkvuig8xfpibvvEDZGKB
         brRkjeedAvxlBxoxawjX4n4NG5uHKhu2//kAeQELuICe3HKgPnTDduej3UnLFpoBQ7Lj
         uJ+/jGqpy5XZdtjQqbCq7DbIGCpjgIr7c22JxRov/bO5B/78Uqzik+rmC71jv6/usgIU
         96lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AOeNIRp44Mv2o6ue+ZHw19CaEV4VWuq394+OG/scwCc=;
        b=Cy9/ij0vo8WxlMrJKFqmzWklL/LkUWP3Nmz8xNlD5unlHNr7Lw7UtqZISOyClYs7af
         JPloWod8PT7Pou5vkATCtDVzP9Z9LRvgIE6yYlRqh8bsLJO3CPp3fCWzZDIwRWbMyCJN
         rmFutkRQLJvKvunb9bSC8g9Sv+8x47wO3WvU0UB/2TH8WG3rCicHgrcBwisV7u6lzpBg
         +USUws4szSFAeu02jrOiOzqDBodmQa9Gig6rtCgbs/1UZHIe3vHm7kLPZ1o4UDzuLA4h
         h8frX3ny4uG3RIRe/eyTCk57EJm/mN+IjOzKQfjU1qf2VDTVxgzUQT1eYKf29eKzGvfA
         /dEg==
X-Gm-Message-State: AOAM531cql+rwoDFOEQkyDnr7EpeevPaJyb1DXtH6MdQrnrJHIeWYeIU
        g84cHanbB9zG0rIsRTN+1q0Nyoj3DaHUQw==
X-Google-Smtp-Source: ABdhPJx2jhhZsVI37YThExjW8b00uCYTI6nwGmHMvIycwbLA7/B6iJNzQt+Ob/Iu0mpMAkPi9dbI6A==
X-Received: by 2002:adf:f192:0:b0:203:e38f:afa1 with SMTP id h18-20020adff192000000b00203e38fafa1mr9571114wro.120.1647649422267;
        Fri, 18 Mar 2022 17:23:42 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u25-20020a05600c211900b00389d4bdb3d2sm14865519wml.36.2022.03.18.17.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 17:23:41 -0700 (PDT)
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
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v11 8/8] unpack-objects: use stream_loose_object() to unpack large objects
Date:   Sat, 19 Mar 2022 01:23:25 +0100
Message-Id: <patch-v11-8.8-5eded902496-20220319T001411Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1438.g8874c8eeb35
In-Reply-To: <cover-v11-0.8-00000000000-20220319T001411Z-avarab@gmail.com>
References: <cover-v10-0.6-00000000000-20220204T135538Z-avarab@gmail.com> <cover-v11-0.8-00000000000-20220319T001411Z-avarab@gmail.com>
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
index b6a12218665..5aca987632c 100644
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
2.35.1.1438.g8874c8eeb35

