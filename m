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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25461C2B9F4
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 17:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB04361378
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 17:28:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233843AbhFNRac (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 13:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234839AbhFNRab (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 13:30:31 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6423DC061574
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 10:28:28 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id g20so18030442ejt.0
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 10:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S4b2YQDz/oiGc74XgQsSAA7G7tWcpNJyWQLp7Z+UZvw=;
        b=idmI/Y1MMGSTmv3aWYWRGD5sed/Nky8W/GaUP65Go5OsStBm8kJxVs9yIMc2MJTAyB
         trray/EypXdBXq4yDcjsX8d4lRMXGLt00wm94GmmBJhwrJt7KoAspKWKeZO2XthXx+eg
         HBlmSj87odipEkg3a5feKBx7C5coWHYm/4RbkWmcUXGlhynUfO4Km5VWTqa3KBH1wniH
         v25jalw5mk0SUYG0km+cRWnV8PmqfLtqxibWLgWH4SW1kfGYoUAH41p9Q63HIQ3m3xGB
         8xaSQnlFvx/vtvq4E/dSFUqXvxyT72H+T+hI6jcjRaMK2cz7jqfu87qEbp1jwvYiBn0v
         zD5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S4b2YQDz/oiGc74XgQsSAA7G7tWcpNJyWQLp7Z+UZvw=;
        b=op4BF4+aTrPDP7GGP8rLIpf1JO5cbwkc0gJbZhDbuNcjp8t7F78Yx07C3v9tcSANKE
         KeWukslQgvrMfxGKI5AYncMJl0PMpJhWh/xp3VqjEDneCVMBw7tifHJXNZGOLs0jVU7q
         LnVT0fcmHHlchUyzwR/o29hoql1lJas9eezWWP/11C4SRbC4Ju+hmoQzt+g3jresxOQE
         YpfZ/WdyybNUF2CLjTwdjybGDFwpGAxmP/mSw0IdK1MhN4OqjErxGGRkS2zSyFNnNvq5
         mjPybKnMLULu1uxl+TudtfyVFN6M4Z0PL9/Enqg6XJ9PrnQRvJ79yWIBJIFEDv7lukk3
         UMPg==
X-Gm-Message-State: AOAM532nTjRoOxJVZRB6IwbFPOUcP71qnFGJ1a3Do8F9pAuUPZN7qDVC
        0t895T8M1igsaDhGcwwufp0d4GUHHjFWHQ==
X-Google-Smtp-Source: ABdhPJxluJSfBFuIBDb9RQbjFFom9SIxLVJSg2wO+BkTNzeo9eTulJldStunFVBed/L1nI3eRVQPLQ==
X-Received: by 2002:a17:906:a0a:: with SMTP id w10mr16371751ejf.416.1623691706813;
        Mon, 14 Jun 2021 10:28:26 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a24sm9376233edt.96.2021.06.14.10.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 10:28:26 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/6] mktag tests: parse out options in helper
Date:   Mon, 14 Jun 2021 19:28:18 +0200
Message-Id: <patch-1.6-d49549973d3-20210614T172422Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.555.g0268d380f7b
In-Reply-To: <cover-0.6-00000000000-20210614T172422Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210614T172422Z-avarab@gmail.com>
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
index 6275c98523f..e9008744e3d 100755
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
2.32.0.555.g0268d380f7b

