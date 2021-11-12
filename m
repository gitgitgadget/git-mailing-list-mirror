Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13EAEC433F5
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 22:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2298603E5
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 22:21:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235987AbhKLWYC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Nov 2021 17:24:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235466AbhKLWXx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Nov 2021 17:23:53 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 971F3C061208
        for <git@vger.kernel.org>; Fri, 12 Nov 2021 14:21:01 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id p3-20020a05600c1d8300b003334fab53afso8098859wms.3
        for <git@vger.kernel.org>; Fri, 12 Nov 2021 14:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WYeo7VMpXVCFrCRUGT5Ld5l/NVbmmiDuRIx8rCT1+ag=;
        b=Mb9PEqiGhnHnVhg514q9Wh2iyyejIehtOO8ohBUwDlSteb2UNzLygiH/zRZQxDklJG
         KARFJGMEzcAjRdO0qTTxH3FnpHuz3RkZpK5aA0H0ua2dwcNQhy82ofmc9Er2YiDNCe/s
         JSY7OpGqjQFJRC7vojwzkoopGv45KPF5Aqk65MGSc26L3UtFJ4wjroQUtTJHQ4cNbndY
         VwRSZhVd/zSD4sz0iIjXxvajygQVTQ4y2tHBHLiODMOE4OVoMoAErL+tsYJuFpQx5HWi
         MBTD0RXtn/9rQse8pd/qyQY0K3y6BMUCAooy0XCUJiQKD9ca2KpCszWT2Cp4BdxpCpFy
         4opQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WYeo7VMpXVCFrCRUGT5Ld5l/NVbmmiDuRIx8rCT1+ag=;
        b=3NLO3tEjkEfg84BPCLmkwUMGVoWkx3MAmdKeeXJE69EYImmSk9duBt5hrHttQ3ayDM
         GPnfqF2Kv9sj+wFKXVjUPkdQiLqcsDgcI6yPmaOW4UWyU6m/I/lQSRKobejoJvhLFHh9
         2Eicfso1vbUnEIICm9EhO8uPm404EH/AqPvLK8TUIBEL2Cnu4973ABWqB1cge5pIor9+
         uYin+lHOv/nmHtWBC93vCjFQgpRBAB+r/cMu5sRbqkVM9uZWXR+OLpeIJpbUXyXyyiK7
         SMf0cxV0hRD7bTtdLn0AT7k4rDoxOh28eoRW6ZkeBzS9mRdIcqYDODQzg/zoR+GWIDcm
         DLMA==
X-Gm-Message-State: AOAM530i5TLHzxIaq3XjoeifT82HtkfH8BHD5vhwh1pzRtBvcTJPtAz0
        T/rf47WTS2glu1duJoZwbmpQ6yggroWRVw==
X-Google-Smtp-Source: ABdhPJzgwMSY+xKiQZ3Xfpj5Wf6NOVIJvi47Lii4+Ks8Tbc1sfaZS6H7K9xEAE+SvhHLukAAqq/tdg==
X-Received: by 2002:a7b:c94e:: with SMTP id i14mr20176950wml.85.1636755659964;
        Fri, 12 Nov 2021 14:20:59 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f7sm7896985wri.74.2021.11.12.14.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 14:20:59 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        John Cai <johncai86@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 10/10] cat-file: improve --(textconv|filters) disambiguation
Date:   Fri, 12 Nov 2021 23:20:08 +0100
Message-Id: <patch-v2-10.10-177f16ba856-20211112T221506Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc2.795.g926201d1cc8
In-Reply-To: <cover-v2-00.10-00000000000-20211112T221506Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20211106T214259Z-avarab@gmail.com> <cover-v2-00.10-00000000000-20211112T221506Z-avarab@gmail.com>
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
2.34.0.rc2.795.g926201d1cc8

