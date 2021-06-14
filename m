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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 851E0C48BE6
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 17:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 675D7613B9
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 17:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235546AbhFNRah (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 13:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234839AbhFNRae (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 13:30:34 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FBA1C061767
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 10:28:30 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id my49so17956260ejc.7
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 10:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MLaUInATMj+gzAUHV58V7yRLadc9EO/n7LpCd+CYVVs=;
        b=D/8b8Mee40UX9HHnJi6v0DcBoqbZlZiEtJ2PFwGWbq3X6+TeDWY8rW2L5TGkChbCAi
         XI+I/ZEthXc+m7UlWNjH6sIzOYGDWB+DqYWbmmnvWsMIjirNCKSzge11Yub3+ih1Wu0E
         86nQL0gn4ZVTD+e6aNy72FOjO/UMZfdoC9+Y8SqNPGoE9OpSRZLS1q85U/U5rPDWxed9
         0jOZw5gK11U/LUSHS9nmxAISGj7OsKh8IMNRXGnFRV7vHFnn3fzvhizvvnCcZODBK/ng
         h3Z87sHu9GLJTeq0t85wZ76fZuaUisMe17S3RdtLj+9pq+t8DLyJoVkNPa9amepuF1UE
         xFHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MLaUInATMj+gzAUHV58V7yRLadc9EO/n7LpCd+CYVVs=;
        b=B/+wUqpEqBxDuiXTNxBZFH506jPmXrFJ0NHrX13T+/uIRxk+H2acWsFTJEhGHhthCi
         WQ9nBM3KbJdZ9Xc99qNIttV+fb7Mi5ueyZNAdVQM4nfz4LGBm4z762fdtYWhQPT08DW1
         18yDXulELZ1qy81JDRzdH+tSfYfsDf3M9MWeMsNlAVUdjCHGOLRV6xsWSlLDvYZDOfsM
         VBt0t2nyCPFnLEaS/VLL77pgMovxyZhnyuMACVaMPihQs3MG6w5om9gZFVs61qSEb82o
         Xi5cA5Mhk6TUgg8+IxN87c6dUysvzwAswexKJYcoLbNkY2icEP8P/hZHclkik7JP2hdV
         qHmg==
X-Gm-Message-State: AOAM533dNfKB38+xJv4CR49aDN5xhJ9aCDzuGcMUk3yUNp70qu52yR5K
        5y3RU97yJUS3ghJkNc5jf3IZDS1M+YARCA==
X-Google-Smtp-Source: ABdhPJyk2fkBSMYzJamE8aoLMejodTSX+mt7ZKX9MfTi25VJXMAI+1F6AUzP4gpjKjYuwo3hK3jpvg==
X-Received: by 2002:a17:906:d1d1:: with SMTP id bs17mr16419978ejb.492.1623691708429;
        Mon, 14 Jun 2021 10:28:28 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a24sm9376233edt.96.2021.06.14.10.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 10:28:27 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/6] mktag tests: test hash-object --literally and unreachable fsck
Date:   Mon, 14 Jun 2021 19:28:20 +0200
Message-Id: <patch-3.6-96520b3e89a-20210614T172422Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.555.g0268d380f7b
In-Reply-To: <cover-0.6-00000000000-20210614T172422Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210614T172422Z-avarab@gmail.com>
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
 t/t3800-mktag.sh | 48 +++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 39 insertions(+), 9 deletions(-)

diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
index 951e6d39c2a..43b67a149f8 100755
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
+			test_must_fail git -C bad-tag fsck >out 2>err
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
2.32.0.555.g0268d380f7b

