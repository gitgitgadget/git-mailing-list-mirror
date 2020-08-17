Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,LOTS_OF_MONEY,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DCDFC433E1
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 14:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4ADF32065D
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 14:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tTE/r9Z8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbgHQOFC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 10:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728651AbgHQOE4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 10:04:56 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D9CC061342
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 07:04:56 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id a15so15113096wrh.10
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 07:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vRwFjaGRukVyApVGz6nU0+Z0qaP5aR9+ftI+QcAT6NY=;
        b=tTE/r9Z8WosjqQYHSkOvnawj3kcLgwpRhoPMO+RgUAlEyIYIoghChCxd72dFbEQKFQ
         rCBXsR7SNtYQFcS2GfwbpzO8f34Q4gr//DZ0zpOENwUICRKT9GRAtYe6uykaAKjdV74c
         FN56lpqL2fyjMcZPz30NFeOLR2v9Gmi1NrInKm5vWOsvflg8yHTIsei3ScqqOViRpg0E
         Nj/Il8/vdiTF6OhJ5B4iLawyA/TrHTNK7hUW8+O15PxLNUsoIVL3cPO5IWynrdhqTtbf
         g5l9sIrnoE71KohsK75SBlLRKJmMGa2HGhsvzAHc1v0uH2PbE6U5IvOjpb7/K665TMuL
         wKWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=vRwFjaGRukVyApVGz6nU0+Z0qaP5aR9+ftI+QcAT6NY=;
        b=kSWMiw6uKeMS3VvQ9VMKBZEz474aw+kjbQ8OHHm/nc83mSIF3dNcMLaeElerIvR9Bm
         xTIXB2aDQWuad0d8cMTksu1wk3fhhFspK/+lJhroV7y5BeWgDOLDl2M/1IXMlOt4RCHi
         owJBQ5jisuNcdbAq4ZHMSoxpgdDUdIKjDqceVRFjyrtXpw4Ad7ZmZ575ZXu7sKppHicT
         udW7Dq/fLNJBfHC9Bhq5OY0gbSzbS9SjJK1tgn2rAbsE2SH4Uwsj+mgDEI5JxpUIhSR8
         2P3W4Xat/7EXfoMvlKdPQ/cq6AQt+LnwjlhdHAkQAZlQZ0qRxbfqLHZjrnn9QJRdVCiw
         DSEA==
X-Gm-Message-State: AOAM531OHPfmUYe4ulEuyPUQaSYFbvckLovt8hTnp+TfUzSsdY/6LPhJ
        M9CZtG8+G75P28P6PrTE5AoXd/BN6Io=
X-Google-Smtp-Source: ABdhPJw5cO0bsQyIU0SQn7vBSZwe4+ke+EbuGlDn3QeN4HoIU1Z+7zT6+a3qjcDlvj8zEi/2/rGfyg==
X-Received: by 2002:adf:812a:: with SMTP id 39mr15168258wrm.137.1597673094394;
        Mon, 17 Aug 2020 07:04:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m8sm29881874wro.75.2020.08.17.07.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 07:04:53 -0700 (PDT)
Message-Id: <822e46868f52e5518681b6fe433eac0b2072b130.1597673089.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.703.v2.git.1597673089.gitgitgadget@gmail.com>
References: <pull.703.git.1597428440.gitgitgadget@gmail.com>
        <pull.703.v2.git.1597673089.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 17 Aug 2020 14:04:48 +0000
Subject: [PATCH v2 3/3] multi-pack-index: use hash version byte
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     martin.agren@gmail.com, sandals@crustytoothpaste.net,
        me@ttaylorr.com, abhishekkumar8222@gmail.com,
        sunshine@sunshineco.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Similar to the commit-graph format, the multi-pack-index format has a
byte in the header intended to track the hash version used to write the
file. This allows one to interpret the hash length without having the
context of the repository config specifying the hash length. This was
not modified as part of the SHA-256 work because the hash length was
automatically up-shifted due to that config.

Since we have this byte available, we can make the file formats more
obviously incompatible instead of relying on other context from the
repository.

Add a new oid_version() method in midx.c similar to the one in
commit-graph.c. This is specifically made separate from that
implementation to avoid artificially linking the formats.

The test impact requires a few more things than the corresponding change
in the commit-graph format. Specifically, 'test-tool read-midx' was not
writing anything about this header value to output. Since the value
available in 'struct multi_pack_index' is hash_len instead of a version
value, we output "20" or "32" instead of "1" or "2".

Since we want a user to not have their Git commands fail if their
multi-pack-index has the incorrect hash version compared to the
repository's hash version, we relax the die() to an error() in
load_multi_pack_index(). This has some effect on 'git multi-pack-index
verify' as we need to check that a failed parse of a file that exists is
actually a verify error. For that test that checks the hash version
matches, we change the corrupted byte from "2" to "3" to ensure the test
fails for both hash algorithms.

Helped-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/technical/pack-format.txt |  7 +++-
 midx.c                                  | 35 ++++++++++++++++----
 t/helper/test-read-midx.c               |  8 +++--
 t/t5319-multi-pack-index.sh             | 43 ++++++++++++++++++++++---
 4 files changed, 80 insertions(+), 13 deletions(-)

diff --git a/Documentation/technical/pack-format.txt b/Documentation/technical/pack-format.txt
index d3a142c652..16cf7e83aa 100644
--- a/Documentation/technical/pack-format.txt
+++ b/Documentation/technical/pack-format.txt
@@ -273,7 +273,12 @@ HEADER:
 	    Git only writes or recognizes version 1.
 
 	1-byte Object Id Version
-	    Git only writes or recognizes version 1 (SHA1).
+	    We infer the length of object IDs (OIDs) from this value:
+		1 => SHA-1
+		2 => SHA-256
+	    If the hash type does not match the repository's hash algorithm,
+	    the multi-pack-index file should be ignored with a warning
+	    presented to the user.
 
 	1-byte number of "chunks"
 
diff --git a/midx.c b/midx.c
index a5fb797ede..551a30b907 100644
--- a/midx.c
+++ b/midx.c
@@ -17,7 +17,6 @@
 #define MIDX_BYTE_HASH_VERSION 5
 #define MIDX_BYTE_NUM_CHUNKS 6
 #define MIDX_BYTE_NUM_PACKS 8
-#define MIDX_HASH_VERSION 1
 #define MIDX_HEADER_SIZE 12
 #define MIDX_MIN_SIZE (MIDX_HEADER_SIZE + the_hash_algo->rawsz)
 
@@ -36,6 +35,18 @@
 
 #define PACK_EXPIRED UINT_MAX
 
+static uint8_t oid_version(void)
+{
+	switch (hash_algo_by_ptr(the_hash_algo)) {
+	case GIT_HASH_SHA1:
+		return 1;
+	case GIT_HASH_SHA256:
+		return 2;
+	default:
+		die(_("invalid hash version"));
+	}
+}
+
 static char *get_midx_filename(const char *object_dir)
 {
 	return xstrfmt("%s/pack/multi-pack-index", object_dir);
@@ -90,8 +101,11 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir, int local
 		      m->version);
 
 	hash_version = m->data[MIDX_BYTE_HASH_VERSION];
-	if (hash_version != MIDX_HASH_VERSION)
-		die(_("hash version %u does not match"), hash_version);
+	if (hash_version != oid_version()) {
+		error(_("multi-pack-index hash version %u does not match version %u"),
+		      hash_version, oid_version());
+		goto cleanup_fail;
+	}
 	m->hash_len = the_hash_algo->rawsz;
 
 	m->num_chunks = m->data[MIDX_BYTE_NUM_CHUNKS];
@@ -418,7 +432,7 @@ static size_t write_midx_header(struct hashfile *f,
 
 	hashwrite_be32(f, MIDX_SIGNATURE);
 	byte_values[0] = MIDX_VERSION;
-	byte_values[1] = MIDX_HASH_VERSION;
+	byte_values[1] = oid_version();
 	byte_values[2] = num_chunks;
 	byte_values[3] = 0; /* unused */
 	hashwrite(f, byte_values, sizeof(byte_values));
@@ -1105,8 +1119,17 @@ int verify_midx_file(struct repository *r, const char *object_dir, unsigned flag
 	struct multi_pack_index *m = load_multi_pack_index(object_dir, 1);
 	verify_midx_error = 0;
 
-	if (!m)
-		return 0;
+	if (!m) {
+		int result = 0;
+		struct stat sb;
+		char *filename = get_midx_filename(object_dir);
+		if (!stat(filename, &sb)) {
+			error(_("multi-pack-index file exists, but failed to parse"));
+			result = 1;
+		}
+		free(filename);
+		return result;
+	}
 
 	if (flags & MIDX_PROGRESS)
 		progress = start_progress(_("Looking for referenced packfiles"),
diff --git a/t/helper/test-read-midx.c b/t/helper/test-read-midx.c
index 831b586d02..2430880f78 100644
--- a/t/helper/test-read-midx.c
+++ b/t/helper/test-read-midx.c
@@ -7,14 +7,18 @@
 static int read_midx_file(const char *object_dir)
 {
 	uint32_t i;
-	struct multi_pack_index *m = load_multi_pack_index(object_dir, 1);
+	struct multi_pack_index *m;
+
+	setup_git_directory();
+	m = load_multi_pack_index(object_dir, 1);
 
 	if (!m)
 		return 1;
 
-	printf("header: %08x %d %d %d\n",
+	printf("header: %08x %d %d %d %d\n",
 	       m->signature,
 	       m->version,
+	       m->hash_len,
 	       m->num_chunks,
 	       m->num_packs);
 
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 7dfff0f8f4..09cbca4949 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -5,6 +5,8 @@ test_description='multi-pack-indexes'
 
 objdir=.git/objects
 
+HASH_LEN=$(test_oid rawsz)
+
 midx_read_expect () {
 	NUM_PACKS=$1
 	NUM_OBJECTS=$2
@@ -13,7 +15,7 @@ midx_read_expect () {
 	EXTRA_CHUNKS="$5"
 	{
 		cat <<-EOF &&
-		header: 4d494458 1 $NUM_CHUNKS $NUM_PACKS
+		header: 4d494458 1 $HASH_LEN $NUM_CHUNKS $NUM_PACKS
 		chunks: pack-names oid-fanout oid-lookup object-offsets$EXTRA_CHUNKS
 		num_objects: $NUM_OBJECTS
 		packs:
@@ -46,7 +48,7 @@ test_expect_success "don't write midx with no packs" '
 	test_path_is_missing pack/multi-pack-index
 '
 
-test_expect_success "Warn if a midx contains no oid" '
+test_expect_success SHA1 'warn if a midx contains no oid' '
 	cp "$TEST_DIRECTORY"/t5319/no-objects.midx $objdir/pack/multi-pack-index &&
 	test_must_fail git multi-pack-index verify &&
 	rm $objdir/pack/multi-pack-index
@@ -198,6 +200,40 @@ test_expect_success 'write midx with twelve packs' '
 
 compare_results_with_midx "twelve packs"
 
+test_expect_success 'warn on improper hash version' '
+	git init --object-format=sha1 sha1 &&
+	(
+		cd sha1 &&
+		git config core.multiPackIndex true &&
+		test_commit 1 &&
+		git repack -a &&
+		git multi-pack-index write &&
+		mv .git/objects/pack/multi-pack-index ../mpi-sha1
+	) &&
+	git init --object-format=sha256 sha256 &&
+	(
+		cd sha256 &&
+		git config core.multiPackIndex true &&
+		test_commit 1 &&
+		git repack -a &&
+		git multi-pack-index write &&
+		mv .git/objects/pack/multi-pack-index ../mpi-sha256
+	) &&
+	(
+		cd sha1 &&
+		mv ../mpi-sha256 .git/objects/pack/multi-pack-index &&
+		git log -1 2>err &&
+		test_i18ngrep "multi-pack-index hash version 2 does not match version 1" err
+	) &&
+	(
+		cd sha256 &&
+		mv ../mpi-sha1 .git/objects/pack/multi-pack-index &&
+		git log -1 2>err &&
+		test_i18ngrep "multi-pack-index hash version 1 does not match version 2" err
+	)
+'
+
+
 test_expect_success 'verify multi-pack-index success' '
 	git multi-pack-index verify --object-dir=$objdir
 '
@@ -243,7 +279,6 @@ test_expect_success 'verify bad signature' '
 		"multi-pack-index signature"
 '
 
-HASH_LEN=$(test_oid rawsz)
 NUM_OBJECTS=74
 MIDX_BYTE_VERSION=4
 MIDX_BYTE_OID_VERSION=5
@@ -272,7 +307,7 @@ test_expect_success 'verify bad version' '
 '
 
 test_expect_success 'verify bad OID version' '
-	corrupt_midx_and_verify $MIDX_BYTE_OID_VERSION "\02" $objdir \
+	corrupt_midx_and_verify $MIDX_BYTE_OID_VERSION "\03" $objdir \
 		"hash version"
 '
 
-- 
gitgitgadget
