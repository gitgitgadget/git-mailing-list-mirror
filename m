Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53885C43334
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 18:00:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236153AbiF3SAv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 14:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236445AbiF3SAh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 14:00:37 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0003F2A712
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 11:00:35 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 205-20020a1c02d6000000b003a03567d5e9so1798130wmc.1
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 11:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zhXF3WFp5fDSkUzKnUVky/oIPtkOTTpID2QAPA/5eCI=;
        b=kUpMjEbrcfXNUK1G3JaLugmynbR9sGUZnHpr+eJB9FQy+wowJmnvqa8FX39X6g4+hY
         99Gq6Fqz95FniN09Q5GXO53I67a8lYiKHrCvOO2T4eTewU6L2LNZeSa8/hqbUHcwKFNV
         mPrzLk1mqj3ZqV1JMGNKKocainlJK8Bne9Apb/cbNL88UKYkfFV/8MUt/E0fE9q6M1VP
         3Qd8g9xMa5/c+8r96GZzSXYFyiqs+f/xidHFQcn951CBaSiXaAm7iXVCKxL+Km7racsd
         smkmX7Sr6RbCX8oub6OZbKwuEUdQKUBscWbzhf3R2YA1gdnLgxZOpx4/XzuRkQufNNZy
         axgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zhXF3WFp5fDSkUzKnUVky/oIPtkOTTpID2QAPA/5eCI=;
        b=FXefuFRO/Iun2uvoI7chgFxeq6VHgMEornr9TNtL35wO29+Yeg0tJ0lPsYk6WqWRIT
         xaF6TyB1QQU5urTBz7IIMNmBg0hSxZ51SpuHML6XNZhSSaHOMlXE+Bes4CLbL0s8L36E
         VO8OB1NESz8KgG6KHUFBjn/VlH76g27q025TbbtEUDQ0Q4/G3wxKhgSfuhwmUZOvaWHo
         qVb5M0pq5iw2eICyzXar2HbDMH6EJ9xMCA+L7ri4XuhkJJNyPD9wB7Y1lxRkocWINykh
         f0Uu6Cydpw/E8zF5FXd+C9OlEYWL6VBLGk5sG65RLKwRhD20RURJ3reOPrh4UiUjZuIA
         GP8Q==
X-Gm-Message-State: AJIora9r8OgRAkyRTMFORjL6lukg7bwq4jJHwE4BjQak+0d5pV2136Sm
        3LHEwxk0iCKGxvAok2QTKqtccMUujabcaw==
X-Google-Smtp-Source: AGRyM1ujkjH5laIzS/dT/qOOwG81Rbog4km+I6TRDV9Zf05hL0SXn664W6+RmWkXQXCROL4iKj/DJQ==
X-Received: by 2002:a05:600c:2189:b0:3a1:887d:fe0e with SMTP id e9-20020a05600c218900b003a1887dfe0emr1092597wme.116.1656612033964;
        Thu, 30 Jun 2022 11:00:33 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v13-20020a1cf70d000000b0039747cf8354sm7363985wmh.39.2022.06.30.11.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 11:00:33 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 10/11] cat-file: fix a common "struct object_context" memory leak
Date:   Thu, 30 Jun 2022 20:00:20 +0200
Message-Id: <patch-10.11-9474e2bcf93-20220630T175714Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.874.g7d3439f13c4
In-Reply-To: <cover-00.11-00000000000-20220630T175714Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20220630T175714Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak where "cat-file" will leak the "path" member. See
e5fba602e59 (textconv: support for cat_file, 2010-06-15) for the code
that introduced the offending get_oid_with_context() call (called
get_sha1_with_context() at the time).

As a result we can mark several tests as passing with SANITIZE=leak
using "TEST_PASSES_SANITIZE_LEAK=true".

As noted in dc944b65f1d (get_sha1_with_context: dynamically allocate
oc->path, 2017-05-19) callers must free the "path" member. That same
commit added the relevant free() to this function, but we weren't
catching cases where we'd return early.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/cat-file.c                   | 32 +++++++++++++++++++---------
 t/t0028-working-tree-encoding.sh     |  1 +
 t/t1051-large-conversion.sh          |  2 ++
 t/t3304-notes-mixed.sh               |  1 +
 t/t4044-diff-index-unique-abbrev.sh  |  2 ++
 t/t4140-apply-ita.sh                 |  1 +
 t/t5314-pack-cycle-detection.sh      |  4 ++--
 t/t6422-merge-rename-corner-cases.sh |  1 +
 t/t8007-cat-file-textconv.sh         |  2 ++
 t/t8010-cat-file-filters.sh          |  2 ++
 t/t9104-git-svn-follow-parent.sh     |  1 -
 t/t9132-git-svn-broken-symlink.sh    |  1 -
 t/t9301-fast-import-notes.sh         |  1 +
 13 files changed, 37 insertions(+), 14 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index ac0459f96be..f42782e955f 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -71,6 +71,7 @@ static int stream_blob(const struct object_id *oid)
 static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 			int unknown_type)
 {
+	int ret;
 	struct object_id oid;
 	enum object_type type;
 	char *buf;
@@ -106,7 +107,8 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 		if (sb.len) {
 			printf("%s\n", sb.buf);
 			strbuf_release(&sb);
-			return 0;
+			ret = 0;
+			goto cleanup;
 		}
 		break;
 
@@ -115,7 +117,8 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 		if (oid_object_info_extended(the_repository, &oid, &oi, flags) < 0)
 			die("git cat-file: could not get object info");
 		printf("%"PRIuMAX"\n", (uintmax_t)size);
-		return 0;
+		ret = 0;
+		goto cleanup;
 
 	case 'e':
 		return !has_object_file(&oid);
@@ -123,8 +126,10 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 	case 'w':
 
 		if (filter_object(path, obj_context.mode,
-				  &oid, &buf, &size))
-			return -1;
+				  &oid, &buf, &size)) {
+			ret = -1;
+			goto cleanup;
+		}
 		break;
 
 	case 'c':
@@ -143,11 +148,14 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 			const char *ls_args[3] = { NULL };
 			ls_args[0] =  "ls-tree";
 			ls_args[1] =  obj_name;
-			return cmd_ls_tree(2, ls_args, NULL);
+			ret = cmd_ls_tree(2, ls_args, NULL);
+			goto cleanup;
 		}
 
-		if (type == OBJ_BLOB)
-			return stream_blob(&oid);
+		if (type == OBJ_BLOB) {
+			ret = stream_blob(&oid);
+			goto cleanup;
+		}
 		buf = read_object_file(&oid, &type, &size);
 		if (!buf)
 			die("Cannot read object %s", obj_name);
@@ -172,8 +180,10 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 			} else
 				oidcpy(&blob_oid, &oid);
 
-			if (oid_object_info(the_repository, &blob_oid, NULL) == OBJ_BLOB)
-				return stream_blob(&blob_oid);
+			if (oid_object_info(the_repository, &blob_oid, NULL) == OBJ_BLOB) {
+				ret = stream_blob(&blob_oid);
+				goto cleanup;
+			}
 			/*
 			 * we attempted to dereference a tag to a blob
 			 * and failed; there may be new dereference
@@ -193,9 +203,11 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 		die("git cat-file %s: bad file", obj_name);
 
 	write_or_die(1, buf, size);
+	ret = 0;
+cleanup:
 	free(buf);
 	free(obj_context.path);
-	return 0;
+	return ret;
 }
 
 struct expand_data {
diff --git a/t/t0028-working-tree-encoding.sh b/t/t0028-working-tree-encoding.sh
index 82905a2156f..416eeabdb94 100755
--- a/t/t0028-working-tree-encoding.sh
+++ b/t/t0028-working-tree-encoding.sh
@@ -5,6 +5,7 @@ test_description='working-tree-encoding conversion via gitattributes'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-encoding.sh"
 
diff --git a/t/t1051-large-conversion.sh b/t/t1051-large-conversion.sh
index 042b0e44292..f6709c9f569 100755
--- a/t/t1051-large-conversion.sh
+++ b/t/t1051-large-conversion.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='test conversion filters on large files'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 set_attr() {
diff --git a/t/t3304-notes-mixed.sh b/t/t3304-notes-mixed.sh
index 03dfcd3954c..2c3a2452668 100755
--- a/t/t3304-notes-mixed.sh
+++ b/t/t3304-notes-mixed.sh
@@ -5,6 +5,7 @@ test_description='Test notes trees that also contain non-notes'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 number_of_commits=100
diff --git a/t/t4044-diff-index-unique-abbrev.sh b/t/t4044-diff-index-unique-abbrev.sh
index 4701796d10e..29e49d22902 100755
--- a/t/t4044-diff-index-unique-abbrev.sh
+++ b/t/t4044-diff-index-unique-abbrev.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='test unique sha1 abbreviation on "index from..to" line'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t4140-apply-ita.sh b/t/t4140-apply-ita.sh
index c614eaf04cc..b375aca0d74 100755
--- a/t/t4140-apply-ita.sh
+++ b/t/t4140-apply-ita.sh
@@ -2,6 +2,7 @@
 
 test_description='git apply of i-t-a file'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t5314-pack-cycle-detection.sh b/t/t5314-pack-cycle-detection.sh
index 0aec8619e22..73a241743aa 100755
--- a/t/t5314-pack-cycle-detection.sh
+++ b/t/t5314-pack-cycle-detection.sh
@@ -49,9 +49,9 @@ Then no matter which order we start looking at the packs in, we know that we
 will always find a delta for "file", because its lookup will always come
 immediately after the lookup for "dummy".
 '
-. ./test-lib.sh
-
 
+TEST_PASSES_SANITIZE_LEAK=true
+. ./test-lib.sh
 
 # Create a pack containing the tree $1 and blob $1:file, with
 # the latter stored as a delta against $2:file.
diff --git a/t/t6422-merge-rename-corner-cases.sh b/t/t6422-merge-rename-corner-cases.sh
index bf4ce3c63d4..9b65768aed6 100755
--- a/t/t6422-merge-rename-corner-cases.sh
+++ b/t/t6422-merge-rename-corner-cases.sh
@@ -6,6 +6,7 @@ test_description="recursive merge corner cases w/ renames but not criss-crosses"
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-merge.sh
 
diff --git a/t/t8007-cat-file-textconv.sh b/t/t8007-cat-file-textconv.sh
index b067983ba1c..c8266f17f14 100755
--- a/t/t8007-cat-file-textconv.sh
+++ b/t/t8007-cat-file-textconv.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='git cat-file textconv support'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 cat >helper <<'EOF'
diff --git a/t/t8010-cat-file-filters.sh b/t/t8010-cat-file-filters.sh
index 31de4b64dc0..ca04242ca01 100755
--- a/t/t8010-cat-file-filters.sh
+++ b/t/t8010-cat-file-filters.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='git cat-file filters support'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup ' '
diff --git a/t/t9104-git-svn-follow-parent.sh b/t/t9104-git-svn-follow-parent.sh
index 5cf2ef4b8b0..85d735861fc 100755
--- a/t/t9104-git-svn-follow-parent.sh
+++ b/t/t9104-git-svn-follow-parent.sh
@@ -5,7 +5,6 @@
 
 test_description='git svn fetching'
 
-TEST_FAILS_SANITIZE_LEAK=true
 . ./lib-git-svn.sh
 
 test_expect_success 'initialize repo' '
diff --git a/t/t9132-git-svn-broken-symlink.sh b/t/t9132-git-svn-broken-symlink.sh
index 4d8d0584b79..aeceffaf7b0 100755
--- a/t/t9132-git-svn-broken-symlink.sh
+++ b/t/t9132-git-svn-broken-symlink.sh
@@ -2,7 +2,6 @@
 
 test_description='test that git handles an svn repository with empty symlinks'
 
-TEST_FAILS_SANITIZE_LEAK=true
 . ./lib-git-svn.sh
 test_expect_success 'load svn dumpfile' '
 	svnadmin load "$rawsvnrepo" <<EOF
diff --git a/t/t9301-fast-import-notes.sh b/t/t9301-fast-import-notes.sh
index 1ae4d7c0d37..58413221e6a 100755
--- a/t/t9301-fast-import-notes.sh
+++ b/t/t9301-fast-import-notes.sh
@@ -7,6 +7,7 @@ test_description='test git fast-import of notes objects'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 
-- 
2.37.0.874.g7d3439f13c4

