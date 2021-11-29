Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DCF0C433F5
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 22:19:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbhK2WWu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 17:22:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbhK2WVJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 17:21:09 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BBDDC091D05
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 11:59:24 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id u1so39278618wru.13
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 11:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+WNKOxhoerSk4XcVulgFeWF+g27eWqisC1Zn7B4auUA=;
        b=osNLK5U99hoCVHXPsa5brfQXPzE8QmhLEIdKtiSW7OhATWOGXbHMVcA3IXQiii5HUU
         4cCTzTUvMagFcOAcQELKig4+7WlmxNQ3prJV56VJDKGIqM2lQs353gXwSp3uLhZtBO5k
         BiDXBsmVZwUpGxVvIKCRNZLDfqNHtUqn4AAPNxedP8iWvjZ6Fyor05Hy6/OjkmUGTrZG
         Elg1eE7heAL2py0ZhiMKCcaZYmu7L6tZetXwODdpWf6/4mqsmBzAB0JF073zP670r6Ob
         J3FhgXdV5PVHl9WWWZTmusaUYoGM5lOHI8U1rOMZOwMNzrSLR7y9/kWW8iGe8r8G/UOO
         oqGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+WNKOxhoerSk4XcVulgFeWF+g27eWqisC1Zn7B4auUA=;
        b=6zU7btgSuoF/kjF2DvUbTMqK2FqGBVILK0IbHH3ZWt4VSerxidDh7zqhlrQQzt0MYV
         LB2/XT9/WlDWrIZXBNjwVUxpCJZEFkDsFQlv9n/C92iZmfzpKmxQLRzenRhvdSbKY9iA
         1RRPgfHwu3OjjNDiiZWzTzUzEUOtQacHpiUVqVS+4XNwz1dWNjAwUdLxmd4OTbn8Ikgo
         BwG9fBziLl/MKAZTplBzYqh2cw5jOWFWgVgImDs/OL7CePQyzLhQHDGv4hhu2mbDUfqG
         lFX/uGSI1B0JLtUMTr7zb83eZokP3xODhYnKZJrR6s0vtXaOZJLWzrFQ3pZs2xAMQDvW
         W3pw==
X-Gm-Message-State: AOAM532SEHszw1RzIco2XF/hRAwdesgKzIZjVFL7HROaCPIvimi/lBMm
        6U7R+N4IMNycQQtrSvaob3jHaUi3J61HWA==
X-Google-Smtp-Source: ABdhPJzn4YTp6f04nC0AYQZqn/bx5zVjbhdJEYMTbbK+d03mxDjHXD9QubLchFVg13K/p59KQHdVUQ==
X-Received: by 2002:adf:f0c8:: with SMTP id x8mr37177135wro.290.1638215963005;
        Mon, 29 Nov 2021 11:59:23 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t8sm298200wmq.32.2021.11.29.11.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 11:59:22 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        John Cai <johncai86@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 10/10] cat-file: use GET_OID_ONLY_TO_DIE in --(textconv|filters)
Date:   Mon, 29 Nov 2021 20:57:50 +0100
Message-Id: <patch-v3-10.10-45a24f97c88-20211129T195357Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.841.gf15fb7e6f34
In-Reply-To: <cover-v3-00.10-00000000000-20211129T195357Z-avarab@gmail.com>
References: <cover-v2-00.10-00000000000-20211112T221506Z-avarab@gmail.com> <cover-v3-00.10-00000000000-20211129T195357Z-avarab@gmail.com>
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
 builtin/cat-file.c           | 15 +++++----------
 cache.h                      |  1 +
 object-name.c                |  6 +++++-
 t/t8007-cat-file-textconv.sh |  8 ++++----
 4 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 1d7f79184f0..b76f2a00046 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -73,14 +73,16 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 	struct object_info oi = OBJECT_INFO_INIT;
 	struct strbuf sb = STRBUF_INIT;
 	unsigned flags = OBJECT_INFO_LOOKUP_REPLACE;
+	unsigned get_oid_flags = GET_OID_RECORD_PATH | GET_OID_ONLY_TO_DIE;
 	const char *path = force_path;
+	if (!path && (opt == 'w' || opt == 'c'))
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
@@ -112,9 +114,6 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 		return !has_object_file(&oid);
 
 	case 'w':
-		if (!path)
-			die("git cat-file --filters %s: <object> must be "
-			    "<sha1:path>", obj_name);
 
 		if (filter_object(path, obj_context.mode,
 				  &oid, &buf, &size))
@@ -122,10 +121,6 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
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
index eba12487b99..788127a9869 100644
--- a/cache.h
+++ b/cache.h
@@ -1366,6 +1366,7 @@ struct object_context {
 #define GET_OID_FOLLOW_SYMLINKS 0100
 #define GET_OID_RECORD_PATH     0200
 #define GET_OID_ONLY_TO_DIE    04000
+#define GET_OID_REQUIRE_PATH  010000
 
 #define GET_OID_DISAMBIGUATORS \
 	(GET_OID_COMMIT | GET_OID_COMMITTISH | \
diff --git a/object-name.c b/object-name.c
index d44a8f3a7ca..e94ced3f170 100644
--- a/object-name.c
+++ b/object-name.c
@@ -1799,8 +1799,12 @@ static enum get_oid_result get_oid_with_context_1(struct repository *repo,
 	oc->mode = S_IFINVALID;
 	strbuf_init(&oc->symlink_path, 0);
 	ret = get_oid_1(repo, name, namelen, oid, flags);
-	if (!ret)
+	if (!ret) {
+		if (flags & GET_OID_REQUIRE_PATH)
+			die(_("<object>:<path> required, only <object> '%s' given"), name);
 		return ret;
+	}
+
 	/*
 	 * tree:path --> object name of path in tree
 	 * :path -> object name of absolute path in index
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
2.34.1.841.gf15fb7e6f34

