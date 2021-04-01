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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3130EC433ED
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 18:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B95261186
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 18:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238222AbhDASJU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Apr 2021 14:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234960AbhDASGo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Apr 2021 14:06:44 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA619C08EC90
        for <git@vger.kernel.org>; Thu,  1 Apr 2021 06:56:35 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id b9so1918890wrt.8
        for <git@vger.kernel.org>; Thu, 01 Apr 2021 06:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X6LRAe/NFnDQznHHcWrRAhRnUmxIIpQuChqg1yKj4u8=;
        b=vdhXU7pW6krTZg+RcwptFiekf6mdnpL6hDgFf7uwEswzG4n59ii2FtUNXHJY7l1MxG
         4dOuWOGIpQ3zY2pKaZ6U1NQHaZUFBCIsbsyciCNrcjUUHGWOJx0wiIE9pul06BQWB6dH
         UikCrXvzWeatluQvV22bVNANJ9z7g7oTqCpZI1zOnJ2hXfqbxhSJkWL42PpXnPlJe33M
         n9ptcWVjqoRtey0jBkN8qTyz/KNLO2aj7wZ3g/qjXHeszStvy+AY7yBwVeamwFbY05qY
         5OtdiFwamExMqc9N961SQIs5XvuaWjaDCX6fvvVIQ6PmB9RNNeJYTuUbIK1HqgULHUZQ
         2uJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X6LRAe/NFnDQznHHcWrRAhRnUmxIIpQuChqg1yKj4u8=;
        b=Kcylbgx4PbfCXYjvxvUXH1UqIUo/nOjFsSR6R7gZm8/CLa14PIaPkxE0T5/ZfI4KE1
         qNI1J3kJyGfzMGLgMkyJgiuPXrEZIKakD/Qs/uwzA6ZDtHu/GhD/+xlzkUBJX+RIPOYu
         zw1bwldtZ6/di7yOdrMk+cfNiMFUIYVpikHjL7svIeZWgApTgOtzMc1ks9fd1V24rPJN
         J9SF3uMMfIUx7A9SGkOmBtGW+bMRq/8pqKM+0x2nXJx5NKjbjolBRZ8gzN3eFYxIlDTZ
         U5QCy3+fKDofMPxuMTgBZqmnd6jfjAUKWGdXJKm7Aw2jX/ao6Xb0FOFHp68J4tcYUdsC
         XmxQ==
X-Gm-Message-State: AOAM5305RIdFZg3FY2l7WFQgXKa4ZjYC8mP/YrzwK0s7Vn4JLfzDo6Gu
        DAnoOA/c/JsplzUDXguZCy9qmDa+coWgPw==
X-Google-Smtp-Source: ABdhPJyYX63RTS/3TrMB9onanV+sMMSyU8K1EjTHiLJmsrabJnPHpuqsyxPwbxsuKcQJDgkynmUxgA==
X-Received: by 2002:a5d:526b:: with SMTP id l11mr9682472wrc.385.1617285394122;
        Thu, 01 Apr 2021 06:56:34 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n7sm10145770wrv.71.2021.04.01.06.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 06:56:33 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/5] mktag tests: parse out options in helper
Date:   Thu,  1 Apr 2021 15:56:26 +0200
Message-Id: <patch-1.6-45e0f100613-20210401T135419Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.474.g72d45d12706
In-Reply-To: <cover-0.6-00000000000-20210401T135419Z-avarab@gmail.com>
References: <YGWFGMdGcKeaqCQF@coredump.intra.peff.net> <cover-0.6-00000000000-20210401T135419Z-avarab@gmail.com>
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
2.31.1.474.g72d45d12706

