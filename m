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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D07DFC49EA2
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABE56613BF
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:42:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbhFQKoT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 06:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbhFQKoQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 06:44:16 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27575C061760
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:42:08 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id c18-20020a05600c0ad2b02901cee262e45fso3390123wmr.4
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HXG0IimmgizI65s2PSt1MGlX3WA3s5FxZIYp9vwwb3c=;
        b=RNPg4oPtoQ3bfS8VJXDrNrF9gtyeLkC18P93WeTInpPmq7EPyUlSZVoV/SO3uXbGsV
         U372GM4/m7VD8ggnxiyI7OcRPPTcrONx4T9AGmqwwhjszBkNZv2kVMhuWBJhiU2K+ttb
         rDQq01vTMh2brTTyFe1rD0PtugHvcMQ+L511lEtbkufnJaNJu439m5CG8LXQn6kzjEEQ
         iUfQHQ9fNaffoAjgCtYIM2A5qU8jaO31c2wrtJB7mb0WiwonhmOAijhlNuJ/jMem7pHG
         /MXIK9EfOhhfO002TCfSKXfMFUx0rSFSmJPhu5HtdDLK4JWzvetdDldKA3D8KBJeC8lh
         OADQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HXG0IimmgizI65s2PSt1MGlX3WA3s5FxZIYp9vwwb3c=;
        b=Nw1cOv67jdlUkqRqiW7jz4al8eH8U2yEYIZ33S3ygd1ZJ8fMmAg32z17rePrYfxcys
         TmuMJMq4lZtAp9AobUt03AHNcnnvNRXDF0t/aG05hal/gEZXIm7mimG1PSNYPOhQ12lV
         jSlLSzY/6/cjZVBbKETBT1z6zZOsygRZ0Tj5rYDyaxWqNfvwt4R14n9if/7ex25kenQu
         nBlJP30hV/0Rl7XNMXVv5ywkUevQsL0Fd7qY71UvIVBn+yG3lk0U9xIcuLqUYQg2dqER
         iMqvi0BjNVk8d0CWBHYFkz++ocDV17iKeEB8RL1hCfrnHu108HpGAN3wBHUdx+QAYT17
         X7XQ==
X-Gm-Message-State: AOAM530B6pKBScyEVYSWHbs8L2gu/8536wQlVnbBT269mpHg9oTiyJb4
        +AZOKm1PkEITE/sBDp36nNWc7Y0HjVp5qQ==
X-Google-Smtp-Source: ABdhPJw4QOIY8W0MXVVG8KsbRnrvDcgub/NmGFP3xu+XJjLCUwLC9RwTl1zajKmj7PrtYpWZ3+PclA==
X-Received: by 2002:a05:600c:214c:: with SMTP id v12mr4239509wml.33.1623926526551;
        Thu, 17 Jun 2021 03:42:06 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p10sm4784607wrr.33.2021.06.17.03.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 03:42:06 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        Jeff King <peff@peff.net>, Andrei Rybak <rybak.a.v@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/6] mktag tests: test hash-object --literally and unreachable fsck
Date:   Thu, 17 Jun 2021 12:41:59 +0200
Message-Id: <patch-3.6-bab235d752-20210617T104011Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.571.gdba276db2c
In-Reply-To: <cover-0.6-0000000000-20210617T104011Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210614T172422Z-avarab@gmail.com> <cover-0.6-0000000000-20210617T104011Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extend the mktag tests to pass the tag we've created through both
hash-object --literally and fsck.

This checks that fsck itself will not complain about certain invalid
content if a reachable tip isn't involved. Due to how fsck works and
walks the graph the failure will be different if the object is
reachable, so we might succeed before we've created the ref.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3800-mktag.sh | 46 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 38 insertions(+), 8 deletions(-)

diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
index 951e6d39c2..78c6f64e36 100755
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
@@ -23,6 +25,9 @@ check_verify_failure () {
 		--no-strict)
 			no_strict=yes
 			;;
+		--fsck-obj-ok)
+			fsck_obj_ok=yes
+			;;
 		esac &&
 		shift
 	done &&
@@ -37,6 +42,23 @@ check_verify_failure () {
 			git mktag --no-strict <tag.sig
 		fi
 	'
+
+	test_expect_success "setup: $subject" '
+		# Reset any leftover state from the last $subject
+		rm -rf bad-tag &&
+
+		git init --bare bad-tag &&
+		git -C bad-tag hash-object -t tag -w --stdin --literally <tag.sig
+	'
+
+	test_expect_success "hash-object & fsck unreachable: $subject" '
+		if test -n "$fsck_obj_ok"
+		then
+			git -C bad-tag fsck
+		else
+			test_must_fail git -C bad-tag fsck
+		fi
+	'
 }
 
 test_expect_mktag_success() {
@@ -183,7 +205,8 @@ tagger . <> 0 +0000
 EOF
 
 check_verify_failure 'verify object (hash/type) check -- correct type, nonexisting object' \
-	'^fatal: could not read tagged object'
+	'^fatal: could not read tagged object' \
+	--fsck-obj-ok
 
 cat >tag.sig <<EOF
 object $head
@@ -216,7 +239,8 @@ tagger . <> 0 +0000
 EOF
 
 check_verify_failure 'verify object (hash/type) check -- mismatched type, valid object' \
-	'^fatal: object.*tagged as.*tree.*but is.*commit'
+	'^fatal: object.*tagged as.*tree.*but is.*commit' \
+	--fsck-obj-ok
 
 ############################################################
 #  9.5. verify object (hash/type) check -- replacement
@@ -245,7 +269,8 @@ tagger . <> 0 +0000
 EOF
 
 check_verify_failure 'verify object (hash/type) check -- mismatched type, valid object' \
-	'^fatal: object.*tagged as.*tree.*but is.*blob'
+	'^fatal: object.*tagged as.*tree.*but is.*blob' \
+	--fsck-obj-ok
 
 ############################################################
 # 10. verify tag-name check
@@ -260,7 +285,8 @@ EOF
 
 check_verify_failure 'verify tag-name check' \
 	'^error:.* badTagName:' \
-	--no-strict
+	--no-strict \
+	--fsck-obj-ok
 
 ############################################################
 # 11. tagger line label check #1
@@ -275,7 +301,8 @@ EOF
 
 check_verify_failure '"tagger" line label check #1' \
 	'^error:.* missingTaggerEntry:' \
-	--no-strict
+	--no-strict \
+	--fsck-obj-ok
 
 ############################################################
 # 12. tagger line label check #2
@@ -291,7 +318,8 @@ EOF
 
 check_verify_failure '"tagger" line label check #2' \
 	'^error:.* missingTaggerEntry:' \
-	--no-strict
+	--no-strict \
+	--fsck-obj-ok
 
 ############################################################
 # 13. allow missing tag author name like fsck
@@ -321,7 +349,8 @@ EOF
 
 check_verify_failure 'disallow malformed tagger' \
 	'^error:.* badEmail:' \
-	--no-strict
+	--no-strict \
+	--fsck-obj-ok
 
 ############################################################
 # 15. allow empty tag email
@@ -446,7 +475,8 @@ EOF
 
 check_verify_failure 'detect invalid header entry' \
 	'^error:.* extraHeaderEntry:' \
-	--no-strict
+	--no-strict \
+	--fsck-obj-ok
 
 test_expect_success 'invalid header entry config & fsck' '
 	test_must_fail git mktag <tag.sig &&
-- 
2.32.0.571.gdba276db2c

