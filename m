Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DFB6C433E3
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 03:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4A6361984
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 03:00:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbhC1C6z (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Mar 2021 22:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbhC1C6k (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Mar 2021 22:58:40 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2390DC0613B1
        for <git@vger.kernel.org>; Sat, 27 Mar 2021 19:58:40 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id j20-20020a05600c1914b029010f31e15a7fso6809674wmq.1
        for <git@vger.kernel.org>; Sat, 27 Mar 2021 19:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZQvvAf4hAh3OSh9QIRsfg6G/aODRc7uFR4p6kBlfiDk=;
        b=hxLPugfeSc4w2vnOOzAHEzfRn8sIVCASZU3XwWiN0Vzhk445bK2LL521lbCblWMRkQ
         lrkm2pb9/iWNmpa2WINxyugwPJ6WtXUI7AJGe9rTUZueDVeCdIxMHFJcYPU92HFLx6ak
         FY0qnT+UbNvoKIeDZWBPBIW6HiFxhwumSaqv5VkQM9yec36UeA0yoor3H5TJEqk5oNtI
         VlT8c9G2sy3EesyBkEy9f7LOxJn9FlG1AyODQzRjtsttD5cue3+tlfBq9ElMms1S/JVe
         mHa+jt9j3Mq54s7s/uS2o4xssFNDsw8H0DAxuvuCqLwbz24RGD2vg+vlyqlbMqrmQZAq
         uqxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZQvvAf4hAh3OSh9QIRsfg6G/aODRc7uFR4p6kBlfiDk=;
        b=saxoRHEQcJtFdnB2NZsXRwPmeSGKLaBtTqV6aSAdI6cWVpEeZ1T8THpAry5ZQvUmeK
         aWNpEXbMCl7xSoMfH2PxCd5pvoDU49/guvZn1/tQE9Qb2WXuiZktveEZn+iK88yNHZra
         zXcnlm+4lmDyawLcJjWe1NVgJPoYfS/XIhs6Di14CnHNCOh/DD8EITVGu1YL1+z/6rbb
         /bzhs4U/zXRXScgnuZjp5Q6xsD/1sDMBiAA3fsN2WYxy0DOe9Judxm4p+RYCBj9spNIP
         8CDd+97hImfyNkAIi77/zn/2pKZGlMJPoDZ8mSQUqFoCVcjX6StGY50Qnz/DOpOdFpY7
         w3xQ==
X-Gm-Message-State: AOAM531vBm3496BQvixgKPsrK6+ry18xMQC0tzcRzG/TbESBVIoc3DFO
        1O6/5NPQHWoI6XOlB6rhbObN+YkdoiaIzQ==
X-Google-Smtp-Source: ABdhPJwPfqhzMgLj48JCG+fsTPoMAHh3r9auCvqOHMHMAxa8B8vsH+XPS24quSoXMUWgGsx09uSdEg==
X-Received: by 2002:a7b:cf2f:: with SMTP id m15mr19019890wmg.177.1616900318583;
        Sat, 27 Mar 2021 19:58:38 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y1sm17629421wmq.29.2021.03.27.19.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 19:58:38 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/5] fsck: don't hard die on invalid object types
Date:   Sun, 28 Mar 2021 04:58:31 +0200
Message-Id: <patch-3.6-74654a01ba3-20210328T025618Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.445.g91d8e479b0a
In-Reply-To: <cover-0.6-00000000000-20210328T025618Z-avarab@gmail.com>
References: <patch-4.5-515d146cac8-20210328T022343Z-avarab@gmail.com> <cover-0.6-00000000000-20210328T025618Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change builtin/fsck.c to pass down a
OBJECT_INFO_ALLOW_UNKNOWN_TYPE. This changes this very ungraceful
error:

    $ git hash-object --stdin -w -t garbage --literally </dev/null
    <OID>
    $ git fsck
    fatal: invalid object type
    $

Into:

    $ git fsck
    error: hash mismatch for <OID_PATH> (expected <OID>)
    error: <OID>: object corrupt or missing: <OID_PATH>
    [ the rest of the fsck output here, i.e. it didn't hard die ]

We'll still exit with non-zero, but now we'll finish the rest of the
traversal. The tests that's being added here asserts that we'll still
complain about other fsck issues (e.g. an unrelated dangling blob).

But why are we complaining about a "hash mismatch" for an object of a
type we don't know about? We shouldn't. This is the bare minimal
change needed to not make fsck hard die on a repository that's been
corrupted in this manner. In subsequent commits we'll teach fsck to
recognize this particular type of corruption and emit a better error
message.

The parse_loose_header() function being changed here is only used in
builtin/fsck.c, see f6371f92104 (sha1_file: add read_loose_object()
function, 2017-01-13) for its introduction.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/fsck.c  |  3 ++-
 object-file.c   | 24 ++++++++++--------------
 object-store.h  |  6 ++++--
 streaming.c     |  5 ++++-
 t/t1450-fsck.sh |  9 +++++++++
 5 files changed, 29 insertions(+), 18 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 821e7798c70..d92c530863d 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -602,7 +602,8 @@ static int fsck_loose(const struct object_id *oid, const char *path, void *data)
 	void *contents;
 	int eaten;
 
-	if (read_loose_object(path, oid, &type, &size, &contents) < 0) {
+	if (read_loose_object(path, oid, &type, &size, &contents,
+			      OBJECT_INFO_ALLOW_UNKNOWN_TYPE) < 0) {
 		errors_found |= ERROR_OBJECT;
 		error(_("%s: object corrupt or missing: %s"),
 		      oid_to_hex(oid), path);
diff --git a/object-file.c b/object-file.c
index 624af408cdc..26560a6281c 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1294,8 +1294,9 @@ static void *unpack_loose_rest(git_zstream *stream,
  * too permissive for what we want to check. So do an anal
  * object header parse by hand.
  */
-static int parse_loose_header_extended(const char *hdr, struct object_info *oi,
-				       unsigned int flags)
+int parse_loose_header(const char *hdr,
+		       struct object_info *oi,
+		       unsigned int flags)
 {
 	const char *type_buf = hdr;
 	unsigned long size;
@@ -1355,14 +1356,6 @@ static int parse_loose_header_extended(const char *hdr, struct object_info *oi,
 	return *hdr ? -1 : type;
 }
 
-int parse_loose_header(const char *hdr, unsigned long *sizep)
-{
-	struct object_info oi = OBJECT_INFO_INIT;
-
-	oi.sizep = sizep;
-	return parse_loose_header_extended(hdr, &oi, 0);
-}
-
 static int loose_object_info(struct repository *r,
 			     const struct object_id *oid,
 			     struct object_info *oi, int flags)
@@ -1417,10 +1410,10 @@ static int loose_object_info(struct repository *r,
 	if (status < 0)
 		; /* Do nothing */
 	else if (hdrbuf.len) {
-		if ((status = parse_loose_header_extended(hdrbuf.buf, oi, flags)) < 0)
+		if ((status = parse_loose_header(hdrbuf.buf, oi, flags)) < 0)
 			status = error(_("unable to parse %s header with --allow-unknown-type"),
 				       oid_to_hex(oid));
-	} else if ((status = parse_loose_header_extended(hdr, oi, flags)) < 0)
+	} else if ((status = parse_loose_header(hdr, oi, flags)) < 0)
 		status = error(_("unable to parse %s header"), oid_to_hex(oid));
 
 	if (status >= 0 && oi->contentp) {
@@ -2497,13 +2490,16 @@ int read_loose_object(const char *path,
 		      const struct object_id *expected_oid,
 		      enum object_type *type,
 		      unsigned long *size,
-		      void **contents)
+		      void **contents,
+		      unsigned int oi_flags)
 {
 	int ret = -1;
 	void *map = NULL;
 	unsigned long mapsize;
 	git_zstream stream;
 	char hdr[MAX_HEADER_LEN];
+	struct object_info oi = OBJECT_INFO_INIT;
+	oi.sizep = size;
 
 	*contents = NULL;
 
@@ -2518,7 +2514,7 @@ int read_loose_object(const char *path,
 		goto out;
 	}
 
-	*type = parse_loose_header(hdr, size);
+	*type = parse_loose_header(hdr, &oi, oi_flags);
 	if (*type < 0) {
 		error(_("unable to parse header of %s"), path);
 		git_inflate_end(&stream);
diff --git a/object-store.h b/object-store.h
index 9117115a50c..ab86c8bf32c 100644
--- a/object-store.h
+++ b/object-store.h
@@ -245,7 +245,8 @@ int read_loose_object(const char *path,
 		      const struct object_id *expected_oid,
 		      enum object_type *type,
 		      unsigned long *size,
-		      void **contents);
+		      void **contents,
+		      unsigned int oi_flags);
 
 /* Retry packed storage after checking packed and loose storage */
 #define HAS_OBJECT_RECHECK_PACKED 1
@@ -480,7 +481,8 @@ int for_each_packed_object(each_packed_object_fn, void *,
 int unpack_loose_header(git_zstream *stream, unsigned char *map,
 			unsigned long mapsize, void *buffer,
 			unsigned long bufsiz);
-int parse_loose_header(const char *hdr, unsigned long *sizep);
+int parse_loose_header(const char *hdr, struct object_info *oi,
+		       unsigned int flags);
 int check_object_signature(struct repository *r, const struct object_id *oid,
 			   void *buf, unsigned long size, const char *type);
 int finalize_object_file(const char *tmpfile, const char *filename);
diff --git a/streaming.c b/streaming.c
index 800f07a52cc..e5d4dd2f654 100644
--- a/streaming.c
+++ b/streaming.c
@@ -341,6 +341,9 @@ static struct stream_vtbl loose_vtbl = {
 
 static open_method_decl(loose)
 {
+	struct object_info oi2 = OBJECT_INFO_INIT;
+	oi2.sizep = &st->size;
+
 	st->u.loose.mapped = map_loose_object(r, oid, &st->u.loose.mapsize);
 	if (!st->u.loose.mapped)
 		return -1;
@@ -349,7 +352,7 @@ static open_method_decl(loose)
 				 st->u.loose.mapsize,
 				 st->u.loose.hdr,
 				 sizeof(st->u.loose.hdr)) < 0) ||
-	    (parse_loose_header(st->u.loose.hdr, &st->size) < 0)) {
+	    (parse_loose_header(st->u.loose.hdr, &oi2, 0) < 0)) {
 		git_inflate_end(&st->z);
 		munmap(st->u.loose.mapped, st->u.loose.mapsize);
 		return -1;
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 1563b35f88c..025dd1b491a 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -863,4 +863,13 @@ test_expect_success 'detect corrupt index file in fsck' '
 	test_i18ngrep "bad index file" errors
 '
 
+test_expect_success 'fsck error and recovery on invalid object type' '
+	test_create_repo garbage-type &&
+	empty_blob=$(git -C garbage-type hash-object --stdin -w -t blob </dev/null) &&
+	garbage_blob=$(git -C garbage-type hash-object --stdin -w -t garbage --literally </dev/null) &&
+	test_must_fail git -C garbage-type fsck >out 2>err &&
+	grep "$garbage_blob: object corrupt or missing:" err &&
+	grep "dangling blob $empty_blob" out
+'
+
 test_done
-- 
2.31.1.445.g91d8e479b0a

