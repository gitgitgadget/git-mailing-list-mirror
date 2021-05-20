Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8757C433ED
	for <git@archiver.kernel.org>; Thu, 20 May 2021 12:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9924261261
	for <git@archiver.kernel.org>; Thu, 20 May 2021 12:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238455AbhETM1e (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 08:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233355AbhETM0x (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 08:26:53 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BBCBC0438DE
        for <git@vger.kernel.org>; Thu, 20 May 2021 04:23:28 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id s6so18884249edu.10
        for <git@vger.kernel.org>; Thu, 20 May 2021 04:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CuOTGCbbZ35BhMC7NR7yODtXyWRRxsJJ1v4Bf/Ynmjw=;
        b=tKAkqWxq81N5kJBi8N+jbTtPllNEyHY6hKkyaOTRmyOafVZL6hcyYeg0e0VgaX+phB
         GVPRiYjn7rQPYyceZQYmPq9yoTlKICvLq6kVsNz7O6elvJZ3dH2EjdSKmAdt72YPEBh4
         PsevXHamuWx36PbcX+7FNK3Lb/EH6AgdPdIJnyLU3a9ycm+R+lSkK4fjKSRmfkLBA8m4
         JN+cVyFN12pQa2vZG2Hu9a5WcoEtQZV5lnTjOYm+xUzG9JsnoOOkjYzRNzTaMgSqqMDU
         gt49cFArK9WlkOU+BnK2CKiZBrN0SidqRml2x+CYDt2wb1RzHFn7Jp23yGg5Te9X66dP
         2XJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CuOTGCbbZ35BhMC7NR7yODtXyWRRxsJJ1v4Bf/Ynmjw=;
        b=l8xGODlWxzLe3XpKyvhz+8/qaca7K3pUX/s7WUSfeK4NeTCrmzt7I4/VQXyDtbdpJ+
         DSVpbot2lUpOpBZkBiqQEObjz9wxObRhdo/ACx/jRnYvzmYID765G+MqklhtBZzGNbsl
         LfmR67BvCe53yKgnWAc1DWf1dW4PwXTG9zOCWOK31JOGkKOJsNo07ietwC70ksu6i+xb
         ReaJy4nRND6PdCMpNq0sZzPBlgT2lgT+aAa5iGSWQfyFeRVv2wHEqtrUgekXuIqqfiRw
         ace7ftbzGm85vAWBZj75K5ItQ0Xo2BirWdIlxnI5f4D14H+cu9GutCkoqSpQEmRl1Qr1
         JgKg==
X-Gm-Message-State: AOAM531mEKvIm+sfcCyA656M+UYGUbeGsD1iossg9W4FO2wz081QVjeG
        +qy/2HS/m/0UyNzJJmaR7FbqdZEs5nRU0w==
X-Google-Smtp-Source: ABdhPJyuOnQmf2BLDMPnXb0iO8N2khZxt0RQwC7GgV58sPKkq+M+7ulIuNwVlis/MzC78Z8dCFawXA==
X-Received: by 2002:a05:6402:3594:: with SMTP id y20mr4501327edc.63.1621509806511;
        Thu, 20 May 2021 04:23:26 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id jy21sm1243273ejc.13.2021.05.20.04.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 04:23:25 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 14/17] fsck: don't hard die on invalid object types
Date:   Thu, 20 May 2021 13:23:08 +0200
Message-Id: <patch-14.17-260e9888a3-20210520T111610Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0.406.g73369325f8d
In-Reply-To: <cover-00.17-0000000000-20210520T111610Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210328T025618Z-avarab@gmail.com> <cover-00.17-0000000000-20210520T111610Z-avarab@gmail.com>
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
index 87a99b0108..38b515deb6 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -600,7 +600,8 @@ static int fsck_loose(const struct object_id *oid, const char *path, void *data)
 	void *contents;
 	int eaten;
 
-	if (read_loose_object(path, oid, &type, &size, &contents) < 0) {
+	if (read_loose_object(path, oid, &type, &size, &contents,
+			      OBJECT_INFO_ALLOW_UNKNOWN_TYPE) < 0) {
 		errors_found |= ERROR_OBJECT;
 		error(_("%s: object corrupt or missing: %s"),
 		      oid_to_hex(oid), path);
diff --git a/object-file.c b/object-file.c
index 0de699de98..0e8a024eb3 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2522,7 +2522,8 @@ int read_loose_object(const char *path,
 		      const struct object_id *expected_oid,
 		      enum object_type *type,
 		      unsigned long *size,
-		      void **contents)
+		      void **contents,
+		      unsigned int oi_flags)
 {
 	int ret = -1;
 	void *map = NULL;
@@ -2530,6 +2531,7 @@ int read_loose_object(const char *path,
 	git_zstream stream;
 	char hdr[MAX_HEADER_LEN];
 	struct object_info oi = OBJECT_INFO_INIT;
+	int allow_unknown = oi_flags & OBJECT_INFO_ALLOW_UNKNOWN_TYPE;
 	oi.typep = type;
 	oi.sizep = size;
 
@@ -2552,8 +2554,11 @@ int read_loose_object(const char *path,
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
index 9accb614fc..790e8b1798 100644
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
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index f36ec1e2f4..e7e8decebb 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -863,16 +863,16 @@ test_expect_success 'detect corrupt index file in fsck' '
 	test_i18ngrep "bad index file" errors
 '
 
-test_expect_success 'fsck hard errors on an invalid object type' '
+test_expect_success 'fsck error and recovery on invalid object type' '
 	test_create_repo garbage-type &&
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
2.32.0.rc0.406.g73369325f8d

