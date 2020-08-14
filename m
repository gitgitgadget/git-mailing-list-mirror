Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,LOTS_OF_MONEY,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9668BC433E3
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 18:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60E8D20771
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 18:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bvbYL7e+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbgHNSH2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 14:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728573AbgHNSH0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 14:07:26 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5030DC061385
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 11:07:26 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id c80so8190966wme.0
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 11:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=R1lpzHoI17H9whswaed9n1pKR8pPW59VuATeaYLob/o=;
        b=bvbYL7e+6DWwmw2KXecDgfQNuWX7nnRJgI3Zqj1+RBwigtUKvpptWyCG33gN5R9Dpf
         I1TR4IACHD4nY7IwrBSy09HejZek0BXrYUcN+pVu+Cs5SMY+tbmZOUiK8U8ZSb+npgKt
         H7yf/vhx7qzUtgHt0zzVS/cu3gU8ziQTfQERshAkirmWmD6h0Mht67jamzpbaz+TvKzh
         MFjEcZmQdqFn0zanYKIdMeLvE90ayZiHJNepkz6Jch7I5QPdhFU1OKBdGU4fBOtef3bb
         6b+VLXO1f5x/EEuSTDsWTllmPEmq9TbPPRYwtxdqFp831BAPObwBQuPzwxuktRuZY8rl
         oXYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=R1lpzHoI17H9whswaed9n1pKR8pPW59VuATeaYLob/o=;
        b=imAgmn5pEvQrgUuBW9EwiXMXOrHRIPPfZXP5OyMb5hV2jgjtEro3/kSZ3CFikbVLsY
         t4OZXSX8jUasY7k60m6j8BDVPMOlU9TzwbhcrIHpHE64yMYjchZ/jLaO/3gmU8c7ezkE
         p22+ZNj5/ZXN2paphxhg4U+O0EgbxfCXA58cSWONTxIX9cB600lsTsG7YOAHsxlohTbo
         Jke7tw/aFOOWCWb35aZpB5hvJXYr+XP2LwdxLehPBiUqNPtolYwJXJB/8IRt9NXyiqbl
         WZuoBR6AuPM6t4V/3MGlQ8/bww55SEu9CktaU/NWA9RZyDBdHuI0Jg3TGGQWS6nzuYu8
         kQGg==
X-Gm-Message-State: AOAM531wLRWu418pGTsJfp9R+alj88KakHJ3sJBsjMgKTvVvh3TseUH9
        X4EPfFB8DtSedxoxoO9sZE95XrfdiZ4=
X-Google-Smtp-Source: ABdhPJxRo+ltgVYikX7ikGcQOKA0BrXSzqWKbbJztCtSJSLlQE2NRIwYNanO/xh9AemC8SL2rTKBYA==
X-Received: by 2002:a1c:4944:: with SMTP id w65mr3401812wma.169.1597428444773;
        Fri, 14 Aug 2020 11:07:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d11sm17526372wrw.77.2020.08.14.11.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 11:07:24 -0700 (PDT)
Message-Id: <b4645789adf26e46cea721896867135941fb7654.1597428440.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.703.git.1597428440.gitgitgadget@gmail.com>
References: <pull.703.git.1597428440.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 14 Aug 2020 18:07:20 +0000
Subject: [PATCH 3/3] multi-pack-index: use hash version byte
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     martin.agren@gmail.com, sandals@crustytoothpaste.net,
        me@ttaylorr.com, abhishekkumar8222@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
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

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/technical/pack-format.txt |  7 +++-
 midx.c                                  | 32 ++++++++++++++----
 t/helper/test-read-midx.c               |  8 +++--
 t/t5319-multi-pack-index.sh             | 43 ++++++++++++++++++++++---
 4 files changed, 77 insertions(+), 13 deletions(-)

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
index a5fb797ede..0c165a40f5 100644
--- a/midx.c
+++ b/midx.c
@@ -17,7 +17,6 @@
 #define MIDX_BYTE_HASH_VERSION 5
 #define MIDX_BYTE_NUM_CHUNKS 6
 #define MIDX_BYTE_NUM_PACKS 8
-#define MIDX_HASH_VERSION 1
 #define MIDX_HEADER_SIZE 12
 #define MIDX_MIN_SIZE (MIDX_HEADER_SIZE + the_hash_algo->rawsz)
 
@@ -36,6 +35,15 @@
 
 #define PACK_EXPIRED UINT_MAX
 
+static uint8_t oid_version(void)
+{
+	if (the_hash_algo->rawsz == GIT_SHA1_RAWSZ)
+		return 1;
+	if (the_hash_algo->rawsz == GIT_SHA256_RAWSZ)
+		return 2;
+	die(_("invalid hash version"));
+}
+
 static char *get_midx_filename(const char *object_dir)
 {
 	return xstrfmt("%s/pack/multi-pack-index", object_dir);
@@ -90,8 +98,11 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir, int local
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
@@ -418,7 +429,7 @@ static size_t write_midx_header(struct hashfile *f,
 
 	hashwrite_be32(f, MIDX_SIGNATURE);
 	byte_values[0] = MIDX_VERSION;
-	byte_values[1] = MIDX_HASH_VERSION;
+	byte_values[1] = oid_version();
 	byte_values[2] = num_chunks;
 	byte_values[3] = 0; /* unused */
 	hashwrite(f, byte_values, sizeof(byte_values));
@@ -1105,8 +1116,17 @@ int verify_midx_file(struct repository *r, const char *object_dir, unsigned flag
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
