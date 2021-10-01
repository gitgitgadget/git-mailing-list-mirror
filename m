Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE254C433F5
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 09:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 938DE61A51
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 09:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352945AbhJAJTU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 05:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352939AbhJAJS6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 05:18:58 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01925C0613E6
        for <git@vger.kernel.org>; Fri,  1 Oct 2021 02:17:14 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id v25so3782537wra.2
        for <git@vger.kernel.org>; Fri, 01 Oct 2021 02:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wxlNVP/mZQHw4yS0Kse8QeakZcyuqxu4Ldvsu7oML4M=;
        b=QjOIQdLzrB0awR350yJyJ+ggEzQJlC/KQ6l5G8dfxiorQF5ljruO/t3skDNHL2bKiz
         IX4uynaunhuUo5TQmkkEtrPI/I5PUGgpI8PvMBeoQMMQZlyiLPjuMDn1KFptJ+L5xCN0
         7ovtU1blyzHQJxGeOdbgO5zGks2/okLmGBhu7WYlBHgbXQ9ji8VMdwkc//zwhZErXsKn
         A06dmuSm5YlS55eBovGgSiAv622AgGnPS02S0e3hd/tDhU3IeuMfivLiZtltuStXZxyl
         QSv7zhntCsKV2iWpfN4FRKQ+M6ezGQtEfw8MBcYUT4oMgQJpqrG3r6fAhebYdU+l08zW
         dpzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wxlNVP/mZQHw4yS0Kse8QeakZcyuqxu4Ldvsu7oML4M=;
        b=o8A48e4udAJxoSOfBWIYdmynI2ht5JVgQcU0zGkKbSN1ThpyTQ0w6gRhodtigj9obQ
         xOfDqs2mkmkwsB/QkVj8FPGsBOC61Cn5kOl1JaOJo0ntYyG4/WCEIc6V7+c1KWJQ1VPs
         Kf72pAU5MGxBE6Ps0BIJUBTa/fciNfFujNslBb3cSkxzAd3UTgPSeS17XjfUTbFZxaV1
         ua12D6bn0qUw7rQ0LQ/Az7QSKeX6CiJkM6+UcNd1mBsdj/z6F5Ci3QlFNMh3KDT3nhLF
         9BjKQ5axGGAKnblRxHM8rII4e9/KZzGpMWVohhjJNdCOL4wgSoY9iy3pXz9Fb0h7BoGR
         1DqQ==
X-Gm-Message-State: AOAM530mjy1895yLRreR3CWslhUWpnodsMB12HVW59ivsVmNMUXsYpza
        x6PUsbzZlZOGHlbWRryV0JDJk5UDjqnn3Q==
X-Google-Smtp-Source: ABdhPJzY3COfzGWXpa5pDocM+2ZPAiGmhhsuY/OhX4qGleLCPGa0hDB5YiXFLbIyjf/NYGSmGW6L5Q==
X-Received: by 2002:adf:b355:: with SMTP id k21mr2039818wrd.380.1633079832243;
        Fri, 01 Oct 2021 02:17:12 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j4sm5301346wrt.67.2021.10.01.02.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 02:17:11 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v10 16/17] fsck: don't hard die on invalid object types
Date:   Fri,  1 Oct 2021 11:16:52 +0200
Message-Id: <patch-v10-16.17-9b75ac7c8ed-20211001T091051Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1375.g5eed55aa1b5
In-Reply-To: <cover-v10-00.17-00000000000-20211001T091051Z-avarab@gmail.com>
References: <cover-v9-00.17-00000000000-20210930T133300Z-avarab@gmail.com> <cover-v10-00.17-00000000000-20211001T091051Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the error fsck emits on invalid object types, such as:

    $ git hash-object --stdin -w -t garbage --literally </dev/null
    <OID>

From the very ungraceful error of:

    $ git fsck
    fatal: invalid object type
    $

To:

    $ git fsck
    error: <OID>: object is of unknown type 'garbage': <OID_PATH>
    [ other fsck output ]

We'll still exit with non-zero, but now we'll finish the rest of the
traversal. The tests that's being added here asserts that we'll still
complain about other fsck issues (e.g. an unrelated dangling blob).

To do this we need to pass down the "OBJECT_INFO_ALLOW_UNKNOWN_TYPE"
flag from read_loose_object() through to parse_loose_header(). Since
the read_loose_object() function is only used in builtin/fsck.c we can
simply change it to accept a "struct object_info" (which contains the
OBJECT_INFO_ALLOW_UNKNOWN_TYPE in its flags). See
f6371f92104 (sha1_file: add read_loose_object() function, 2017-01-13)
for the introduction of read_loose_object().

Since we'll need a "struct strbuf" to hold the "type_name" let's pass
it to the for_each_loose_file_in_objdir() callback to avoid allocating
a new one for each loose object in the iteration. It also makes the
memory management simpler than sticking it in fsck_loose() itself, as
we'll only need to strbuf_reset() it, with no need to do a
strbuf_release() before each "return".

Before this commit we'd never check the "type" if read_loose_object()
failed, but now we do. We therefore need to initialize it to OBJ_NONE
to be able to tell the difference between e.g. its
unpack_loose_header() having failed, and us getting past that and into
parse_loose_header().

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/fsck.c  | 37 +++++++++++++++++++++++++++++++------
 object-file.c   | 18 ++++++------------
 object-store.h  |  6 +++---
 t/t1450-fsck.sh | 18 +++++++++---------
 4 files changed, 49 insertions(+), 30 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index b42b6fe21f7..260210bf8a1 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -593,18 +593,36 @@ static void get_default_heads(void)
 	}
 }
 
+struct for_each_loose_cb
+{
+	struct progress *progress;
+	struct strbuf obj_type;
+};
+
 static int fsck_loose(const struct object_id *oid, const char *path, void *data)
 {
+	struct for_each_loose_cb *cb_data = data;
 	struct object *obj;
-	enum object_type type;
+	enum object_type type = OBJ_NONE;
 	unsigned long size;
 	void *contents;
 	int eaten;
+	struct object_info oi = OBJECT_INFO_INIT;
+	int err = 0;
 
-	if (read_loose_object(path, oid, &type, &size, &contents) < 0) {
+	strbuf_reset(&cb_data->obj_type);
+	oi.type_name = &cb_data->obj_type;
+	oi.sizep = &size;
+	oi.typep = &type;
+
+	if (read_loose_object(path, oid, &contents, &oi) < 0)
+		err = error(_("%s: object corrupt or missing: %s"),
+			    oid_to_hex(oid), path);
+	if (type != OBJ_NONE && type < 0)
+		err = error(_("%s: object is of unknown type '%s': %s"),
+			    oid_to_hex(oid), cb_data->obj_type.buf, path);
+	if (err < 0) {
 		errors_found |= ERROR_OBJECT;
-		error(_("%s: object corrupt or missing: %s"),
-		      oid_to_hex(oid), path);
 		return 0; /* keep checking other objects */
 	}
 
@@ -640,8 +658,10 @@ static int fsck_cruft(const char *basename, const char *path, void *data)
 	return 0;
 }
 
-static int fsck_subdir(unsigned int nr, const char *path, void *progress)
+static int fsck_subdir(unsigned int nr, const char *path, void *data)
 {
+	struct for_each_loose_cb *cb_data = data;
+	struct progress *progress = cb_data->progress;
 	display_progress(progress, nr + 1);
 	return 0;
 }
@@ -649,6 +669,10 @@ static int fsck_subdir(unsigned int nr, const char *path, void *progress)
 static void fsck_object_dir(const char *path)
 {
 	struct progress *progress = NULL;
+	struct for_each_loose_cb cb_data = {
+		.obj_type = STRBUF_INIT,
+		.progress = progress,
+	};
 
 	if (verbose)
 		fprintf_ln(stderr, _("Checking object directory"));
@@ -657,9 +681,10 @@ static void fsck_object_dir(const char *path)
 		progress = start_progress(_("Checking object directories"), 256);
 
 	for_each_loose_file_in_objdir(path, fsck_loose, fsck_cruft, fsck_subdir,
-				      progress);
+				      &cb_data);
 	display_progress(progress, 256);
 	stop_progress(&progress);
+	strbuf_release(&cb_data.obj_type);
 }
 
 static int fsck_head_link(const char *head_ref_name,
diff --git a/object-file.c b/object-file.c
index a70669700d0..fe95285f405 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2572,18 +2572,15 @@ static int check_stream_oid(git_zstream *stream,
 
 int read_loose_object(const char *path,
 		      const struct object_id *expected_oid,
-		      enum object_type *type,
-		      unsigned long *size,
-		      void **contents)
+		      void **contents,
+		      struct object_info *oi)
 {
 	int ret = -1;
 	void *map = NULL;
 	unsigned long mapsize;
 	git_zstream stream;
 	char hdr[MAX_HEADER_LEN];
-	struct object_info oi = OBJECT_INFO_INIT;
-	oi.typep = type;
-	oi.sizep = size;
+	unsigned long *size = oi->sizep;
 
 	*contents = NULL;
 
@@ -2599,15 +2596,13 @@ int read_loose_object(const char *path,
 		goto out;
 	}
 
-	if (parse_loose_header(hdr, &oi) < 0) {
+	if (parse_loose_header(hdr, oi) < 0) {
 		error(_("unable to parse header of %s"), path);
 		git_inflate_end(&stream);
 		goto out;
 	}
-	if (*type < 0)
-		die(_("invalid object type"));
 
-	if (*type == OBJ_BLOB && *size > big_file_threshold) {
+	if (*oi->typep == OBJ_BLOB && *size > big_file_threshold) {
 		if (check_stream_oid(&stream, hdr, *size, path, expected_oid) < 0)
 			goto out;
 	} else {
@@ -2618,8 +2613,7 @@ int read_loose_object(const char *path,
 			goto out;
 		}
 		if (check_object_signature(the_repository, expected_oid,
-					   *contents, *size,
-					   type_name(*type))) {
+					   *contents, *size, oi->type_name->buf)) {
 			error(_("hash mismatch for %s (expected %s)"), path,
 			      oid_to_hex(expected_oid));
 			free(*contents);
diff --git a/object-store.h b/object-store.h
index c5130d8baea..c90c41a07f7 100644
--- a/object-store.h
+++ b/object-store.h
@@ -245,6 +245,7 @@ int force_object_loose(const struct object_id *oid, time_t mtime);
 
 /*
  * Open the loose object at path, check its hash, and return the contents,
+ * use the "oi" argument to assert things about the object, or e.g. populate its
  * type, and size. If the object is a blob, then "contents" may return NULL,
  * to allow streaming of large blobs.
  *
@@ -252,9 +253,8 @@ int force_object_loose(const struct object_id *oid, time_t mtime);
  */
 int read_loose_object(const char *path,
 		      const struct object_id *expected_oid,
-		      enum object_type *type,
-		      unsigned long *size,
-		      void **contents);
+		      void **contents,
+		      struct object_info *oi);
 
 /* Retry packed storage after checking packed and loose storage */
 #define HAS_OBJECT_RECHECK_PACKED 1
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 281ff8bdd8e..faf0e98847b 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -85,11 +85,10 @@ test_expect_success 'object with hash and type mismatch' '
 		cmt=$(echo bogus | git commit-tree $tree) &&
 		git update-ref refs/heads/bogus $cmt &&
 
-		cat >expect <<-\EOF &&
-		fatal: invalid object type
-		EOF
-		test_must_fail git fsck 2>actual &&
-		test_cmp expect actual
+
+		test_must_fail git fsck 2>out &&
+		grep "^error: hash mismatch for " out &&
+		grep "^error: $oid: object is of unknown type '"'"'garbage'"'"'" out
 	)
 '
 
@@ -910,19 +909,20 @@ test_expect_success 'detect corrupt index file in fsck' '
 	test_i18ngrep "bad index file" errors
 '
 
-test_expect_success 'fsck hard errors on an invalid object type' '
+test_expect_success 'fsck error and recovery on invalid object type' '
 	git init --bare garbage-type &&
 	(
 		cd garbage-type &&
 
-		git hash-object --stdin -w -t garbage --literally </dev/null &&
+		garbage_blob=$(git hash-object --stdin -w -t garbage --literally </dev/null) &&
 
 		cat >err.expect <<-\EOF &&
 		fatal: invalid object type
 		EOF
 		test_must_fail git fsck >out 2>err &&
-		test_cmp err.expect err &&
-		test_must_be_empty out
+		grep -e "^error" -e "^fatal" err >errors &&
+		test_line_count = 1 errors &&
+		grep "$garbage_blob: object is of unknown type '"'"'garbage'"'"':" err
 	)
 '
 
-- 
2.33.0.1375.g5eed55aa1b5

