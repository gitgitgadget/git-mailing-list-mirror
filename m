Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F2BC43217
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 13:29:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233449AbhL1N3p (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 08:29:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232912AbhL1N3D (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 08:29:03 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE806C06175A
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 05:29:01 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id r17so38422963wrc.3
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 05:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=47qAugx8KKRzpyNTS2H80yNIUF/F9a1Q5q1zbWyCW8Y=;
        b=OaCcXdj9cqibsIownSDCdaCXhQHgc0aRWK9KVGtHj21bVkk6r631sxOfM7kJsdCrKV
         tv8EJ99+UhZURIzsfOXyIA5jlN8J5dwqfwhJp+x2Jw7tDjXaj9iq2/Fw+0blVJGRwuKz
         J2isMrBsV1lEVj86ynRYq9cXa6MS6De+Jz1MxxEtxXHuc0ixNBvowYFi6ENzfdWtef3R
         TyLDvCJglS8mBaXlux+wjsdssnXxmiYaWC8mLsltMImFpQuqLO6ul9cdjfHGXAcmvnNB
         bT/9a6CGCGmSxpkvUKu6t+NA8OTRCpyMRz2spenQo3yoAHVV8WnrnY2o1uODkWCeLc6K
         IZzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=47qAugx8KKRzpyNTS2H80yNIUF/F9a1Q5q1zbWyCW8Y=;
        b=6SrDOgY4n2wHVVtopXTUMPII/C2FUCJfjgrMy26lurtRWTI7ile4zQQ6Y15dOfX3Uv
         94fHc9J7isiHD6ZUTNkwF+mhv5if841FMkaVmkgB5/ZsilgaGT0bGazXe3iZYo+spX3e
         oTuULq77ibShZuGIY3O1M0dI7kHrjIoVqJRdoi5c1VscUf/1EXPbEKhTuMGtomgZVnFh
         iMlI7I7HX+VFmyhPRrpulPHn7oszd6dgrZ8MmQpobiq046bpR0QulLso+VL3PHCTONVr
         uk9Zra1kShOGyySvXRH15NBTds2+bP28IxD7IJBk4MGSbPWhgejFIJx/+Wzt4fHypyqD
         qJ0w==
X-Gm-Message-State: AOAM532IwAhDY/SYVE++1qwEHuxqKNhSpaqVg7smW70b4XYnGKl4awgJ
        5yfACalmzIV6IwGsoLuOB8qbno/f4B1PMTlV
X-Google-Smtp-Source: ABdhPJwRZHRfkYHk4S8PX8h/tk4uDhM/o6rBG+j4PDPOpQRYlX/0tbz1PC86N91LgYeOm01ObRnhMw==
X-Received: by 2002:adf:ee0d:: with SMTP id y13mr16849395wrn.427.1640698140217;
        Tue, 28 Dec 2021 05:29:00 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d11sm19695868wri.101.2021.12.28.05.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 05:28:59 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        John Cai <johncai86@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 10/10] cat-file: use GET_OID_ONLY_TO_DIE in --(textconv|filters)
Date:   Tue, 28 Dec 2021 14:28:50 +0100
Message-Id: <patch-v6-10.10-56826ac73e6-20211228T132637Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1257.g2af47340c7b
In-Reply-To: <cover-v6-00.10-00000000000-20211228T132637Z-avarab@gmail.com>
References: <cover-v5-00.10-00000000000-20211222T041050Z-avarab@gmail.com> <cover-v6-00.10-00000000000-20211228T132637Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the cat_one_file() logic that calls get_oid_with_context()
under --textconv and --filters to use the GET_OID_ONLY_TO_DIE flag,
thus improving the error messaging emitted when e.g. <path> is missing
but <rev> is not.

To service the "cat-file" use-case we need to introduce a new
"GET_OID_REQUIRE_PATH" flag, otherwise it would exit early as soon as
a valid "HEAD" was resolved, but in the "cat-file" case being changed
we always need a valid revision and path.

This arguably makes the "<bad rev>:<bad path>" and "<bad
rev>:<good (in HEAD) path>" use cases worse, as we won't quote the
<path> component at the user anymore, but let's just use the existing
logic "git log" et al use for now. We can improve the messaging for
those cases as a follow-up for all callers.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/cat-file.c           | 16 ++++++----------
 cache.h                      |  1 +
 object-name.c                |  3 +++
 t/t8007-cat-file-textconv.sh |  8 ++++----
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index b5b130d79c1..ad9b3eef4f4 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -73,14 +73,17 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 	struct object_info oi = OBJECT_INFO_INIT;
 	struct strbuf sb = STRBUF_INIT;
 	unsigned flags = OBJECT_INFO_LOOKUP_REPLACE;
+	unsigned get_oid_flags = GET_OID_RECORD_PATH | GET_OID_ONLY_TO_DIE;
 	const char *path = force_path;
+	const int opt_cw = (opt == 'c' || opt == 'w');
+	if (!path && opt_cw)
+		get_oid_flags |= GET_OID_REQUIRE_PATH;
 
 	if (unknown_type)
 		flags |= OBJECT_INFO_ALLOW_UNKNOWN_TYPE;
 
-	if (get_oid_with_context(the_repository, obj_name,
-				 GET_OID_RECORD_PATH,
-				 &oid, &obj_context))
+	if (get_oid_with_context(the_repository, obj_name, get_oid_flags, &oid,
+				 &obj_context))
 		die("Not a valid object name %s", obj_name);
 
 	if (!path)
@@ -112,9 +115,6 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 		return !has_object_file(&oid);
 
 	case 'w':
-		if (!path)
-			die("git cat-file --filters %s: <object> must be "
-			    "<sha1:path>", obj_name);
 
 		if (filter_object(path, obj_context.mode,
 				  &oid, &buf, &size))
@@ -122,10 +122,6 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 		break;
 
 	case 'c':
-		if (!path)
-			die("git cat-file --textconv %s: <object> must be <sha1:path>",
-			    obj_name);
-
 		if (textconv_object(the_repository, path, obj_context.mode,
 				    &oid, 1, &buf, &size))
 			break;
diff --git a/cache.h b/cache.h
index cfba463aa97..fae55cfcb33 100644
--- a/cache.h
+++ b/cache.h
@@ -1377,6 +1377,7 @@ struct object_context {
 #define GET_OID_FOLLOW_SYMLINKS 0100
 #define GET_OID_RECORD_PATH     0200
 #define GET_OID_ONLY_TO_DIE    04000
+#define GET_OID_REQUIRE_PATH  010000
 
 #define GET_OID_DISAMBIGUATORS \
 	(GET_OID_COMMIT | GET_OID_COMMITTISH | \
diff --git a/object-name.c b/object-name.c
index d44a8f3a7ca..92862eeb1ac 100644
--- a/object-name.c
+++ b/object-name.c
@@ -1799,6 +1799,9 @@ static enum get_oid_result get_oid_with_context_1(struct repository *repo,
 	oc->mode = S_IFINVALID;
 	strbuf_init(&oc->symlink_path, 0);
 	ret = get_oid_1(repo, name, namelen, oid, flags);
+	if (!ret && flags & GET_OID_REQUIRE_PATH)
+		die(_("<object>:<path> required, only <object> '%s' given"),
+		    name);
 	if (!ret)
 		return ret;
 	/*
diff --git a/t/t8007-cat-file-textconv.sh b/t/t8007-cat-file-textconv.sh
index 71ea2ac987e..b067983ba1c 100755
--- a/t/t8007-cat-file-textconv.sh
+++ b/t/t8007-cat-file-textconv.sh
@@ -29,7 +29,7 @@ test_expect_success 'usage: <bad rev>' '
 
 test_expect_success 'usage: <bad rev>:<bad path>' '
 	cat >expect <<-\EOF &&
-	fatal: Not a valid object name HEAD2:two.bin
+	fatal: invalid object name '\''HEAD2'\''.
 	EOF
 	test_must_fail git cat-file --textconv HEAD2:two.bin 2>actual &&
 	test_cmp expect actual
@@ -37,7 +37,7 @@ test_expect_success 'usage: <bad rev>:<bad path>' '
 
 test_expect_success 'usage: <rev>:<bad path>' '
 	cat >expect <<-\EOF &&
-	fatal: Not a valid object name HEAD:two.bin
+	fatal: path '\''two.bin'\'' does not exist in '\''HEAD'\''
 	EOF
 	test_must_fail git cat-file --textconv HEAD:two.bin 2>actual &&
 	test_cmp expect actual
@@ -46,7 +46,7 @@ test_expect_success 'usage: <rev>:<bad path>' '
 
 test_expect_success 'usage: <rev> with no <path>' '
 	cat >expect <<-\EOF &&
-	fatal: git cat-file --textconv HEAD: <object> must be <sha1:path>
+	fatal: <object>:<path> required, only <object> '\''HEAD'\'' given
 	EOF
 	test_must_fail git cat-file --textconv HEAD 2>actual &&
 	test_cmp expect actual
@@ -55,7 +55,7 @@ test_expect_success 'usage: <rev> with no <path>' '
 
 test_expect_success 'usage: <bad rev>:<good (in HEAD) path>' '
 	cat >expect <<-\EOF &&
-	fatal: Not a valid object name HEAD2:one.bin
+	fatal: invalid object name '\''HEAD2'\''.
 	EOF
 	test_must_fail git cat-file --textconv HEAD2:one.bin 2>actual &&
 	test_cmp expect actual
-- 
2.34.1.1257.g2af47340c7b

