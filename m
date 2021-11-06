Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95AFCC433EF
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 21:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DC9E61027
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 21:47:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233921AbhKFVuB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Nov 2021 17:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234211AbhKFVt4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Nov 2021 17:49:56 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A038DC06120B
        for <git@vger.kernel.org>; Sat,  6 Nov 2021 14:47:13 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id i5so19646224wrb.2
        for <git@vger.kernel.org>; Sat, 06 Nov 2021 14:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SkAYpnila8VBQ1Jxlb2SWW+uUM6t37f/oTL3Bc8EYao=;
        b=dUX5uYaxXfT+5qlsHgjHCHJMMYMHGlrICvz+w7iGN2UHtsJ4pt7WOIKQwvnVA7Vwrc
         7aDD3uvfraFp3b3lCUq+TtEN+aL9VQcyV2JzfgD+0cLUGoh8G6m4Zb4wWEjOMFe8axOH
         t/FjR665iO/2GEstwime9N6NmeiXnbzqYervlBhjYx8we3J7yGP4gb6jfY2bCSd4czUg
         tSW/LhA/6eduWw8dIzUbQ4mhfU7SNGZzO75DcWcGVnxJhHBuC+wHP3bTJRU64usWBh9+
         BEsvcRCY+4orM1231/V76+Xb9MnFJr8H5UUnfuAPdjlEveZrcb3O2fLeXy6IYS4gODN6
         GFHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SkAYpnila8VBQ1Jxlb2SWW+uUM6t37f/oTL3Bc8EYao=;
        b=xYeEPt9CrGbVuM0FE6RrKxegpic+VFVQTJoqiFvegn2WpH2eGCgL5vyf7uIZ5s9X04
         z43j2StnwqiPhEhLWmbfx7/22uRin3HgQMLNwj8VqXWVL25jcYrspe+zZGZAWhoGbnVX
         wiCL/Ajt7fEc6d4t17EXDco8Nah/oxYqHgBgRLOIWXPr62AT8ge2tqeDjUzNFdHXZc4w
         Vh6L8RFYTSe3Cgm+5rf20bCGp+fl7chJ3vcMdG+hFN3dFNqRgRJh00qbehMFhw9DOBz8
         0lrJ/8K8tKOaBA3DPf/yrpGWMrX0VWqqHcZxEh+md8QiqauwuN6Fdwvj7i/JK22zzrT7
         nGNw==
X-Gm-Message-State: AOAM533ArZtMeCCbu2fCua2nECa8BixsK7Ti2hos5ozd2Wr1y1n1i1S0
        fOLDweApUCxebtpkZGqgfXtkngajI9NOAA==
X-Google-Smtp-Source: ABdhPJyUnTWuS3n0mZ2UEhAVj7gke/8Kt4qg3pUX8yksi4Qc/2FPHli/v4i+OfTPxYJe/MF7HLAEeA==
X-Received: by 2002:adf:fe8b:: with SMTP id l11mr82190081wrr.228.1636235232011;
        Sat, 06 Nov 2021 14:47:12 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f19sm12736630wmq.34.2021.11.06.14.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Nov 2021 14:47:11 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        John Cai <johncai86@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 10/10] cat-file: improve --(textconv|filters) disambiguation
Date:   Sat,  6 Nov 2021 22:47:02 +0100
Message-Id: <patch-10.10-3d61399aa78-20211106T214259Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc1.741.gab7bfd97031
In-Reply-To: <cover-00.10-00000000000-20211106T214259Z-avarab@gmail.com>
References: <xmqqlf33i36a.fsf@gitster.g> <cover-00.10-00000000000-20211106T214259Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Improve the errors emitted when an invalid <object> and/or <path> is
provided with either the --path option, or as an argument. We now use
the same logic in get_oid_with_context_1() that "git show" et al use.

To replace the "cat-file" use-case we need to introduce a new
"GET_OID_REQUIRE_PATH" flag, otherwise it would exit early as soon as
a valid "HEAD" was resolved, but in the "cat-file" case being changed
we always need a valid revision and path.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/cat-file.c           | 15 +++++----------
 cache.h                      |  1 +
 object-name.c                |  6 +++++-
 t/t8007-cat-file-textconv.sh |  6 +++---
 4 files changed, 14 insertions(+), 14 deletions(-)

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
index 45471cefe73..0b79750cf1e 100755
--- a/t/t8007-cat-file-textconv.sh
+++ b/t/t8007-cat-file-textconv.sh
@@ -27,19 +27,19 @@ test_expect_success 'usage' '
 	test_cmp expect actual &&
 
 	cat >expect <<-\EOF &&
-	fatal: Not a valid object name HEAD2:two.bin
+	fatal: invalid object name '\''HEAD2'\''.
 	EOF
 	test_must_fail git cat-file --textconv HEAD2:two.bin 2>actual &&
 	test_cmp expect actual &&
 
 	cat >expect <<-\EOF &&
-	fatal: git cat-file --textconv HEAD: <object> must be <sha1:path>
+	fatal: <object>:<path> required, only <object> '\''HEAD'\'' given
 	EOF
 	test_must_fail git cat-file --textconv HEAD 2>actual &&
 	test_cmp expect actual &&
 
 	cat >expect <<-\EOF &&
-	fatal: Not a valid object name HEAD:two.bin
+	fatal: path '\''two.bin'\'' does not exist in '\''HEAD'\''
 	EOF
 	test_must_fail git cat-file --textconv HEAD:two.bin 2>actual &&
 	test_cmp expect actual
-- 
2.34.0.rc1.741.gab7bfd97031

