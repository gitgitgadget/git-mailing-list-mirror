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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F1FC433FE
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 10:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EE9960F6D
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 10:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344044AbhIGLAI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 07:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343861AbhIGK7u (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 06:59:50 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E88CC0612A7
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 03:58:43 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id y132so865164wmc.1
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 03:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aDLy6U5KSPfcD6GccCttA0W3sVX4odpy2+oNHvBuyWs=;
        b=MHFj1pVKRiCM7VP8Cy6MLlX4AzCxvKU5ja/CEUTRfT0zM7aTnwkMU3Zs/7UaFhL3z7
         atWhzzffPbajVndF7tNNdGAWAHbarMDadJb8E/XukFkANvUqUotHxa9qhqTgk6F5q0bP
         6Pnbc+UY8EmeRc7WuWACXycxyjpg0faqfcrEhzww1eBEkWWhoDY5mhxNAROe6kQnlF6A
         yAIdZT/Soc5HwlHfanbY3+OoJoVM4gNtM5gAnZJ4qac3N+OB5gWuT5IR9Bl2pvocCmfr
         q4hhzETt+5AcnyZaGwYvnsP7dHg1taCwOLRjR28wKzyhdIEUs7CUAexCuM78N0HtI2K2
         MSOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aDLy6U5KSPfcD6GccCttA0W3sVX4odpy2+oNHvBuyWs=;
        b=iwfO0dp7ZfuD9tZI0FIi78FCYt0+2C5LUdGc6h3XH+9qy472aP+u9TrwlTfMkKgISL
         oJ5ggl/C/memJRsZi9zQ/PdIvKkl5iW/kG4BvJtOuNIwe2yIFaUnuXYxIkiyzDKhXzE2
         aG7KTzKu3Fa4JTtVW6yy0eyKZaLh3SpYaVT+OOFGzaM4r+GATgUlFQ985Qq9+jdS16/M
         Vk9mcxqilLC7qxmgqYco3JafglujtMWjEkPs2pvc+8a9zQct6/gWjzMboAvBIdqAjkjB
         TA0ocpNUk7TPHK5zRa4gMrSCusgIZjpGgYNF6nlEBB8HYp+23ivDC/g42J/pJWC0GL5+
         v5Bw==
X-Gm-Message-State: AOAM533WtbdrbIl7M0RrZRPOZJakZMXdqQ4vk1ek+akIyJBbRkH8OIy6
        Et8NKtrT1I3DmsSTZR5nY1lEXcCrJ1m9IA==
X-Google-Smtp-Source: ABdhPJwT9OgapFW+YjPnAsoksr4zX6a/MAwMPZYq9bdTM0gYTCL74M066rGQwz273+MpPVEHpw83nw==
X-Received: by 2002:a1c:c911:: with SMTP id f17mr3266792wmb.190.1631012321812;
        Tue, 07 Sep 2021 03:58:41 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l16sm8255602wrh.44.2021.09.07.03.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 03:58:41 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 19/22] fsck: don't hard die on invalid object types
Date:   Tue,  7 Sep 2021 12:58:14 +0200
Message-Id: <patch-v6-19.22-ad1614dbb8d-20210907T104559Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.815.g21c7aaf6073
In-Reply-To: <cover-v6-00.22-00000000000-20210907T104558Z-avarab@gmail.com>
References: <cover-00.21-00000000000-20210710T133203Z-avarab@gmail.com> <cover-v6-00.22-00000000000-20210907T104558Z-avarab@gmail.com>
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
    error: hash mismatch for <OID_PATH> (expected <OID>)
    error: <OID>: object corrupt or missing: <OID_PATH>
    [ the rest of the fsck output here, i.e. it didn't hard die ]

We'll still exit with non-zero, but now we'll finish the rest of the
traversal. The tests that's being added here asserts that we'll still
complain about other fsck issues (e.g. an unrelated dangling blob).

To do this we need to pass down the "OBJECT_INFO_ALLOW_UNKNOWN_TYPE"
flag from read_loose_object() through to parse_loose_header(). Since
the read_loose_object() function is only used in builtin/fsck.c we can
simply change it. See f6371f92104 (sha1_file: add read_loose_object()
function, 2017-01-13) for the introduction of read_loose_object().

Why are we complaining about a "hash mismatch" for an object of a type
we don't know about? We shouldn't. This is the bare minimal change
needed to not make fsck hard die on a repository that's been corrupted
in this manner. In subsequent commits we'll teach fsck to recognize
this particular type of corruption and emit a better error message.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/fsck.c  |  3 ++-
 object-file.c   | 11 ++++++++---
 object-store.h  |  3 ++-
 t/t1450-fsck.sh | 14 +++++++-------
 4 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index b42b6fe21f7..082dadd5629 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -601,7 +601,8 @@ static int fsck_loose(const struct object_id *oid, const char *path, void *data)
 	void *contents;
 	int eaten;
 
-	if (read_loose_object(path, oid, &type, &size, &contents) < 0) {
+	if (read_loose_object(path, oid, &type, &size, &contents,
+			      OBJECT_INFO_ALLOW_UNKNOWN_TYPE) < 0) {
 		errors_found |= ERROR_OBJECT;
 		error(_("%s: object corrupt or missing: %s"),
 		      oid_to_hex(oid), path);
diff --git a/object-file.c b/object-file.c
index 9484c7ce2be..0e6937fad73 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2562,7 +2562,8 @@ int read_loose_object(const char *path,
 		      const struct object_id *expected_oid,
 		      enum object_type *type,
 		      unsigned long *size,
-		      void **contents)
+		      void **contents,
+		      unsigned int oi_flags)
 {
 	int ret = -1;
 	void *map = NULL;
@@ -2570,6 +2571,7 @@ int read_loose_object(const char *path,
 	git_zstream stream;
 	char hdr[MAX_HEADER_LEN];
 	struct object_info oi = OBJECT_INFO_INIT;
+	int allow_unknown = oi_flags & OBJECT_INFO_ALLOW_UNKNOWN_TYPE;
 	oi.typep = type;
 	oi.sizep = size;
 
@@ -2592,8 +2594,11 @@ int read_loose_object(const char *path,
 		git_inflate_end(&stream);
 		goto out;
 	}
-	if (*type < 0)
-		die(_("invalid object type"));
+	if (!allow_unknown && *type < 0) {
+		error(_("header for %s declares an unknown type"), path);
+		git_inflate_end(&stream);
+		goto out;
+	}
 
 	if (*type == OBJ_BLOB && *size > big_file_threshold) {
 		if (check_stream_oid(&stream, hdr, *size, path, expected_oid) < 0)
diff --git a/object-store.h b/object-store.h
index ac55b02f15a..c268662f5ba 100644
--- a/object-store.h
+++ b/object-store.h
@@ -253,7 +253,8 @@ int read_loose_object(const char *path,
 		      const struct object_id *expected_oid,
 		      enum object_type *type,
 		      unsigned long *size,
-		      void **contents);
+		      void **contents,
+		      unsigned int oi_flags);
 
 /* Retry packed storage after checking packed and loose storage */
 #define HAS_OBJECT_RECHECK_PACKED 1
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index f10d6f7b7e8..d8303db9709 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -863,16 +863,16 @@ test_expect_success 'detect corrupt index file in fsck' '
 	test_i18ngrep "bad index file" errors
 '
 
-test_expect_success 'fsck hard errors on an invalid object type' '
+test_expect_success 'fsck error and recovery on invalid object type' '
 	git init --bare garbage-type &&
 	empty_blob=$(git -C garbage-type hash-object --stdin -w -t blob </dev/null) &&
 	garbage_blob=$(git -C garbage-type hash-object --stdin -w -t garbage --literally </dev/null) &&
-	cat >err.expect <<-\EOF &&
-	fatal: invalid object type
-	EOF
-	test_must_fail git -C garbage-type fsck >out.actual 2>err.actual &&
-	test_cmp err.expect err.actual &&
-	test_must_be_empty out.actual
+	test_must_fail git -C garbage-type fsck >out 2>err &&
+	grep -e "^error" -e "^fatal" err >errors &&
+	test_line_count = 2 errors &&
+	grep "error: hash mismatch for" err &&
+	grep "$garbage_blob: object corrupt or missing:" err &&
+	grep "dangling blob $empty_blob" out
 '
 
 test_done
-- 
2.33.0.815.g21c7aaf6073

