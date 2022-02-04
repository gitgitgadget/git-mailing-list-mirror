Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6BD1C433EF
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 14:07:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359237AbiBDOHg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 09:07:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359141AbiBDOH3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Feb 2022 09:07:29 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C131C061751
        for <git@vger.kernel.org>; Fri,  4 Feb 2022 06:07:27 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id k18so11538536wrg.11
        for <git@vger.kernel.org>; Fri, 04 Feb 2022 06:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l12/+mVW9DKgoV5o0LvaTdufJ1dJpdCdH1+4Z7LUKfI=;
        b=AZXC+NnVeZbNdtxU6ymvapJtSj5+sU/kE1fGmquWL3OxBSqynGw3ACQrF/pGwqLI74
         uuYmQjHKj6OGFf4X8ZtU7Kyopr87fq4mWHk41Lq8GU7TdVQEs+6hF4RcQA7HP+5mndQe
         6qaZ+7ecqaVrpF/IDM80zwr4VwL3FjiIRZqxZVFVycO5DMdjLDGoaNcq3BXLVR6Uwriy
         QLTbMpnORO3ahsQeem9fIcX0hXVM+RmJgC6kThG0XWJa9i9J+4R7kNaLRXIqMn5G3cl8
         lz40RgDDgGpYPuznYAAnp7F+9bJKz1Knrz6oT8mKpAN81OmMC1NaL7iz2SNAWWTMqSgb
         6euw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l12/+mVW9DKgoV5o0LvaTdufJ1dJpdCdH1+4Z7LUKfI=;
        b=qBrzNR7BmUWAoP8lF0nHLE1XD+1ld3iUKX00q51WeE8M/plrG1Gpaxb8aXbrKHnE0/
         4mKM+X0FEkmWePaH+M+TR4XA5Mp8a3+hAZLFZDqnEqnuAh3xGzI8KMhMneiJ4ksvYBKY
         P1L/n71hNjCjej0PYYhvrhYKVndzD2eQAYl4dphHgkDkH2xmVragT8OiJyd2saH5WzRz
         YeFIP6iGzyesACIe8xZwbZiV2+201+TyzzsPYoAxRh6A2A4KlMC72AwmDuVMG/EfIR3k
         AyZc3uwnxZ0XxWqOijsJ4YxXIcKIFYCmcGDPYI5rf3tYtdZWwwBqa1fC5Kx7OrnSdJyQ
         pQSw==
X-Gm-Message-State: AOAM532XjRNaLcfv/C2vrKOmz9QdFeRmRN7kUIpmihI4A+LihDb9/TcR
        G/UH24XYf1iHTeFcMoLzzjiusZpHUw0mBg==
X-Google-Smtp-Source: ABdhPJx/TCwSdzysLuJ1uEG1slBMbTLVh0eR2rYw/NwGtYyqWsMSLgNdWCXSubUn11XusF5cpIqDbg==
X-Received: by 2002:adf:f4d1:: with SMTP id h17mr2549465wrp.448.1643983645865;
        Fri, 04 Feb 2022 06:07:25 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u19sm618722wmm.0.2022.02.04.06.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 06:07:25 -0800 (PST)
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
Subject: [PATCH v10 6/6] unpack-objects: use stream_loose_object() to unpack large objects
Date:   Fri,  4 Feb 2022 15:07:12 +0100
Message-Id: <patch-v10-6.6-6a70e49a346-20220204T135538Z-avarab@gmail.com>
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

Make use of the stream_loose_object() function introduced in the
preceding commit to unpack large objects. Before this we'd need to
malloc() the size of the blob before unpacking it, which could cause
OOM with very large blobs.

We could use this new interface to unpack all blobs, but doing so
would result in a performance penalty of around 10%, as the below
"hyperfine" benchmark will show. We therefore limit this to files
larger than "core.bigFileThreshold":

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

1. https://lore.kernel.org/git/20211210103435.83656-1-chiyutianyi@gmail.com/
2. https://lore.kernel.org/git/20220120112114.47618-5-chiyutianyi@gmail.com/

Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Helped-by: Derrick Stolee <stolee@gmail.com>
Helped-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
---
 Documentation/config/core.txt   |  4 +-
 builtin/unpack-objects.c        | 71 ++++++++++++++++++++++++++++++++-
 t/t5328-unpack-large-objects.sh | 23 +++++++++--
 3 files changed, 92 insertions(+), 6 deletions(-)

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
index 896ea8aceb4..7ce3cb61086 100644
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
index 1432dfc8386..5c1042b4d91 100755
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
@@ -30,16 +34,29 @@ test_expect_success 'set memory limitation to 1MB' '
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
2.35.1.940.ge7a5b4b05f2

