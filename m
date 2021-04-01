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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2711CC43460
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 18:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB1FA60201
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 18:22:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236809AbhDASWK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Apr 2021 14:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235563AbhDASNM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Apr 2021 14:13:12 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58644C08EC92
        for <git@vger.kernel.org>; Thu,  1 Apr 2021 06:56:37 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id x13so1912068wrs.9
        for <git@vger.kernel.org>; Thu, 01 Apr 2021 06:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Iyj3LgzfoH/ASqvzqur2oqOZjxZfg3A4nuQ1Yp2REhU=;
        b=jpyyE8xq9RxLawAcuhhVKoi/E6yKs72m3rDeF4RtNrjheFi5ljezSUQVjb5QTH3UqZ
         KT0GLaHtWQqx/UTQ7EPBZtWKKJWl3vNa7KDmmeMhEnacYFFofZnr0vUgS/DD119m/zxM
         A0jXYUU0E77y8ewu4sQyO9n48kZdSOYQEhrFNb8w9chcbkiWOgIrkBhijOMEroC1AV5k
         X0ALaqWUsmEPYPKPvof59+TQtFSdzWUZTe5aDlrjKQpRAsZFjTBIAl3CJvIdN5nQ0wsy
         caHAO7ySahEI6GjMi+WAqF3x3WlGdvdY/S4HIkjWZX7hhFldt13sXvyR6epEjVSbRz/d
         g98A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Iyj3LgzfoH/ASqvzqur2oqOZjxZfg3A4nuQ1Yp2REhU=;
        b=soOhkNxyx4IdAjfPfXGLG3A7PHhXpi4Ly3j4Vew8GMoqIygmfwxC2pO3D4mBBQGIy3
         6xSoOPvdhMs8MTMlJRvEYu33UyEzIWyuJkrFL9NiqvYlUqhIaan9UdYEKvNAskJX8Lc+
         p+JTQaH+0pFQ15f55OBKGHJ3zTmVycwb2yqBABP73Eno8YsFjMEiH7LzxviWI2IpR1az
         0XRU7B67gUCT3t5E+uSCtei1co/WvhDTbFRWTprJCZwwBUCHoUjiR5C+jtmVaAR+dF5l
         AsXBVHU/A3T/OGkX++JekRQTgcF8KPIZ4CxR5HREXm0lEAc43n/lHD4hGOofA4ckJhB/
         cnQA==
X-Gm-Message-State: AOAM530fNdBKWySmVAaBXH/Gf/omWKWzrj7rGVqvFbdaHsFdqmf2Tjui
        L+h2EzhYlzfEvK2F5l9yj1FXDq54PbNG5Q==
X-Google-Smtp-Source: ABdhPJx5dCnrsAkZ+Ar1yWm5QCAd5Ab2blTvcoxH2jtb1giwg0pZQOuGy3TdQMF4xR46x5TT5qv4Ig==
X-Received: by 2002:a5d:4d01:: with SMTP id z1mr9749629wrt.133.1617285395864;
        Thu, 01 Apr 2021 06:56:35 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n7sm10145770wrv.71.2021.04.01.06.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 06:56:35 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/5] mktag tests: do fsck on failure
Date:   Thu,  1 Apr 2021 15:56:28 +0200
Message-Id: <patch-3.6-688d7456843-20210401T135419Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.474.g72d45d12706
In-Reply-To: <cover-0.6-00000000000-20210401T135419Z-avarab@gmail.com>
References: <YGWFGMdGcKeaqCQF@coredump.intra.peff.net> <cover-0.6-00000000000-20210401T135419Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the check_verify_failure() function to do an fsck of the bad
object on failure.

Due to how fsck works and walks the graph the failure will be
different if the object is reachable, so we might succeed before we've
created the ref, let's make sure we always fail after it's created.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3800-mktag.sh | 51 ++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 41 insertions(+), 10 deletions(-)

diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
index 951e6d39c2a..4673235b1fd 100755
--- a/t/t3800-mktag.sh
+++ b/t/t3800-mktag.sh
@@ -16,6 +16,8 @@ check_verify_failure () {
 	message=$2 &&
 	shift 2 &&
 
+	no_strict= &&
+	fsck_obj_ok= &&
 	no_strict= &&
 	while test $# != 0
 	do
@@ -23,7 +25,10 @@ check_verify_failure () {
 		--no-strict)
 			no_strict=yes
 			;;
-		esac &&
+		--fsck-obj-ok)
+			fsck_obj_ok=yes
+			;;
+		esac
 		shift
 	done &&
 
@@ -35,7 +40,25 @@ check_verify_failure () {
 			test_cmp err err2
 		else
 			git mktag --no-strict <tag.sig
-		fi
+		fi &&
+
+		test_when_finished "rm -rf bad-tag" &&
+		test_create_repo bad-tag &&
+		bad_tag=$(git -C bad-tag hash-object -t tag -w --stdin --literally <tag.sig) &&
+		if test -n "$fsck_obj_ok"
+		then
+			git -C bad-tag fsck
+		else
+			test_must_fail git -C bad-tag fsck >out 2>err
+		fi &&
+
+		# Do update-ref anyway to see if it segfaults
+		tag_ref=refs/tags/bad_tag &&
+		test_might_fail git -C bad-tag update-ref "$tag_ref" "$bad_tag" &&
+		# The update-ref command itself might fail, but we are
+		# not testing that
+		echo "$bad_tag" >"bad-tag/.git/$tag_ref" &&
+		test_must_fail git -C bad-tag fsck
 	'
 }
 
@@ -183,7 +206,8 @@ tagger . <> 0 +0000
 EOF
 
 check_verify_failure 'verify object (hash/type) check -- correct type, nonexisting object' \
-	'^fatal: could not read tagged object'
+	'^fatal: could not read tagged object' \
+	--fsck-obj-ok
 
 cat >tag.sig <<EOF
 object $head
@@ -216,7 +240,8 @@ tagger . <> 0 +0000
 EOF
 
 check_verify_failure 'verify object (hash/type) check -- mismatched type, valid object' \
-	'^fatal: object.*tagged as.*tree.*but is.*commit'
+	'^fatal: object.*tagged as.*tree.*but is.*commit' \
+	--fsck-obj-ok
 
 ############################################################
 #  9.5. verify object (hash/type) check -- replacement
@@ -245,7 +270,8 @@ tagger . <> 0 +0000
 EOF
 
 check_verify_failure 'verify object (hash/type) check -- mismatched type, valid object' \
-	'^fatal: object.*tagged as.*tree.*but is.*blob'
+	'^fatal: object.*tagged as.*tree.*but is.*blob' \
+	--fsck-obj-ok
 
 ############################################################
 # 10. verify tag-name check
@@ -260,7 +286,8 @@ EOF
 
 check_verify_failure 'verify tag-name check' \
 	'^error:.* badTagName:' \
-	--no-strict
+	--no-strict \
+	--fsck-obj-ok
 
 ############################################################
 # 11. tagger line label check #1
@@ -275,7 +302,8 @@ EOF
 
 check_verify_failure '"tagger" line label check #1' \
 	'^error:.* missingTaggerEntry:' \
-	--no-strict
+	--no-strict \
+	--fsck-obj-ok
 
 ############################################################
 # 12. tagger line label check #2
@@ -291,7 +319,8 @@ EOF
 
 check_verify_failure '"tagger" line label check #2' \
 	'^error:.* missingTaggerEntry:' \
-	--no-strict
+	--no-strict \
+	--fsck-obj-ok
 
 ############################################################
 # 13. allow missing tag author name like fsck
@@ -321,7 +350,8 @@ EOF
 
 check_verify_failure 'disallow malformed tagger' \
 	'^error:.* badEmail:' \
-	--no-strict
+	--no-strict \
+	--fsck-obj-ok
 
 ############################################################
 # 15. allow empty tag email
@@ -446,7 +476,8 @@ EOF
 
 check_verify_failure 'detect invalid header entry' \
 	'^error:.* extraHeaderEntry:' \
-	--no-strict
+	--no-strict \
+	--fsck-obj-ok
 
 test_expect_success 'invalid header entry config & fsck' '
 	test_must_fail git mktag <tag.sig &&
-- 
2.31.1.474.g72d45d12706

