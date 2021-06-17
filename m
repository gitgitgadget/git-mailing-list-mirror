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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 058CFC2B9F4
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D071460FDA
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbhFQKoR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 06:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbhFQKoP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 06:44:15 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D89C061574
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:42:06 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id u5-20020a7bc0450000b02901480e40338bso4654270wmc.1
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BJWZYvbtEs3IWF7Ur+1fzpKJdq1aVEfGTE2+4EodpcA=;
        b=Twqk6LL0owcXWm8HFCRhSiPdr9SpvIpFxiGMC3UqKUl0Z/ys8/z5XkWtq9ndUnkYDn
         eMOTI1AyB9OOMUWDSLcZo6h5PZEd9llaOsBxLmVNiPBZMTfusYLSp40fLx8szwLoj/OO
         ao4YC0iX4i8eSIDrUEOQGTRetCQS5qoUf6YgLxaJG0ZNm0dgqXMF6AQrEdFVE2Vglg+t
         0Keunat1PNytP/FGWm2yWa7sV554bb6cwt6cC+mqdswAt7Lma5hGcTzRXZK8+HH2Ajfl
         IHn+wa33CmZ5VOqyWRPLopFlCAKRVig4eDFEWOQGzqcLYzjahyPg4BB1qostjuJj4Uo2
         aofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BJWZYvbtEs3IWF7Ur+1fzpKJdq1aVEfGTE2+4EodpcA=;
        b=H3/2fsbMsEeBuIToXHeBi/+krAFr1CkXamlK2jEXEwU1L5KJ6lBa61PSnJyvXyIdTR
         B+0dYc9iyLkmSLdZmw5phwChw86tiaPkPz4fVBNcWNgSBCUbUxyQFq6kcs+wJDvhnf9g
         Lftfny+Kp+Fc4A3ksqgFTsuz4nLF+3t49gSNNfmwjv4ZeHCjkOTfXGWmR+EXxICO7vK9
         f31XU4RRZUZ4UO0ptfUb5orCHw0zJ3EoH9BvoOymS8ZvBixN6ACJ2pVUnxYD4mjCUvp1
         9MlJmlZmRSLZO8/9ipPBtQ0Rjn0yykIZ7ltIozYZDzT/q5na2RPW0y7XUhtAUcDknLKV
         yoYw==
X-Gm-Message-State: AOAM531CjZyDuuNLeqDHxyOBUmAo9NvIKCeDCJhWOYQxdCEZjLbmKjDc
        7Ebe9vxuyAJ1g01v/J8iyUzG6ewMLw3FFw==
X-Google-Smtp-Source: ABdhPJwIXwWJrjfJgHpXILUJdTAvG395BGbAqZ5t34EVGlNUxpgX3Pu3Mra6qvgTKKNiZ606oDEQiQ==
X-Received: by 2002:a05:600c:1d1a:: with SMTP id l26mr4351855wms.189.1623926524932;
        Thu, 17 Jun 2021 03:42:04 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p10sm4784607wrr.33.2021.06.17.03.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 03:42:04 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        Jeff King <peff@peff.net>, Andrei Rybak <rybak.a.v@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/6] mktag tests: parse out options in helper
Date:   Thu, 17 Jun 2021 12:41:57 +0200
Message-Id: <patch-1.6-d49549973d-20210617T104011Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.571.gdba276db2c
In-Reply-To: <cover-0.6-0000000000-20210617T104011Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210614T172422Z-avarab@gmail.com> <cover-0.6-0000000000-20210617T104011Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change check_verify_failure() helper to parse out options from
$@. This makes it easier to add new options in the future. See
06ce79152be (mktag: add a --[no-]strict option, 2021-01-06) for the
initial implementation.

Let's also replace "" quotes with '' for the test body, the varables
we need are eval'd into the body, so there's no need for the quoting
confusion.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3800-mktag.sh | 43 +++++++++++++++++++++++++++++++------------
 1 file changed, 31 insertions(+), 12 deletions(-)

diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
index 6275c98523..e9008744e3 100755
--- a/t/t3800-mktag.sh
+++ b/t/t3800-mktag.sh
@@ -12,15 +12,29 @@ test_description='git mktag: tag object verify test'
 # given in the expect.pat file.
 
 check_verify_failure () {
-	test_expect_success "$1" "
-		test_must_fail git mktag <tag.sig 2>message &&
-		grep '$2' message &&
-		if test '$3' != '--no-strict'
+	subject=$1 &&
+	message=$2 &&
+	shift 2 &&
+
+	no_strict= &&
+	while test $# != 0
+	do
+		case "$1" in
+		--no-strict)
+			no_strict=yes
+			;;
+		esac &&
+		shift
+	done &&
+
+	test_expect_success "fail with [--[no-]strict]: $subject" '
+		test_must_fail git mktag <tag.sig 2>err &&
+		if test -z "$no_strict"
 		then
-			test_must_fail git mktag --no-strict <tag.sig 2>message.no-strict &&
-			grep '$2' message.no-strict
+			test_must_fail git mktag <tag.sig 2>err2 &&
+			test_cmp err err2
 		fi
-	"
+	'
 }
 
 test_expect_mktag_success() {
@@ -243,7 +257,8 @@ tagger . <> 0 +0000
 EOF
 
 check_verify_failure 'verify tag-name check' \
-	'^error:.* badTagName:' '--no-strict'
+	'^error:.* badTagName:' \
+	--no-strict
 
 ############################################################
 # 11. tagger line label check #1
@@ -257,7 +272,8 @@ This is filler
 EOF
 
 check_verify_failure '"tagger" line label check #1' \
-	'^error:.* missingTaggerEntry:' '--no-strict'
+	'^error:.* missingTaggerEntry:' \
+	--no-strict
 
 ############################################################
 # 12. tagger line label check #2
@@ -272,7 +288,8 @@ This is filler
 EOF
 
 check_verify_failure '"tagger" line label check #2' \
-	'^error:.* missingTaggerEntry:' '--no-strict'
+	'^error:.* missingTaggerEntry:' \
+	--no-strict
 
 ############################################################
 # 13. allow missing tag author name like fsck
@@ -301,7 +318,8 @@ tagger T A Gger <
 EOF
 
 check_verify_failure 'disallow malformed tagger' \
-	'^error:.* badEmail:' '--no-strict'
+	'^error:.* badEmail:' \
+	--no-strict
 
 ############################################################
 # 15. allow empty tag email
@@ -425,7 +443,8 @@ this line should not be here
 EOF
 
 check_verify_failure 'detect invalid header entry' \
-	'^error:.* extraHeaderEntry:' '--no-strict'
+	'^error:.* extraHeaderEntry:' \
+	--no-strict
 
 test_expect_success 'invalid header entry config & fsck' '
 	test_must_fail git mktag <tag.sig &&
-- 
2.32.0.571.gdba276db2c

