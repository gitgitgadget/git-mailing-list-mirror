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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D0F3C43381
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 01:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0734822517
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 01:39:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbgLWBjH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Dec 2020 20:39:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbgLWBjG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Dec 2020 20:39:06 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D21C0611CA
        for <git@vger.kernel.org>; Tue, 22 Dec 2020 17:37:53 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id w5so16955374wrm.11
        for <git@vger.kernel.org>; Tue, 22 Dec 2020 17:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/zblMyOa79J2Y02i2MnEbT2m+z0uirS9AYteQcdBLY8=;
        b=FqfL7z1cCtOC5jEZHBXgKPveZJr9n+cUVT5AhX2D4bbELr5DU4QR2/eRIc4Yj+xY73
         lHSQKrOCc3pIFREK6tNJVTkPNz7Hyka/q4n1S9ob9k1EziAc5MvR/qYIf74WG0MH3Y1/
         vqYbUWEsv21glSeqN9OKlx4CxYFLkHxeY8GeoBqY1+Q5aJTaZD6YNK3HeTMa8ik4Sjqu
         zdhIod7u1XawQINk2Fq6DQDte2ZvWE3xVJ1Ljv4TED6o1wP0WinWzOliR1I8hULCO6Ws
         6XP44uneh6i6v17XGRjFaBseQYYKq0/ZJwBYPv0Ak0slAOKyffwMmKxDCsqFpDKI31Wa
         ciyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/zblMyOa79J2Y02i2MnEbT2m+z0uirS9AYteQcdBLY8=;
        b=udjjdKUnJh74C+5zYAo4WWY0XgF04xRw38yAuqcNGZppCVATHGbgP4FayF6JRoW47D
         ZSd3pReo93OmMMoF0sXpvS27Qre/zu5B7F9ouH2zXm7A8ZNKxC9aUueaYN0Jp0al3RRw
         QP3imhpGAlGmB3Hut0mjRDET8GbCydPvr+G3ypK1FEV291GDaioiBKFbyDgJSmYlEw7+
         y+lzJpox58QKZjIil+UgoNooKiahK1xoAfLy/5LP2JGfJcZsoG3qgVtMv8Yt4J83u3+K
         y3sTJgHHjVyMWTnqfeb3rtXzOw5EuFcaSIOWb7D8BfWPw1MCTQM7N5/YuFIoXFxnKjsK
         nB2w==
X-Gm-Message-State: AOAM533CBgr8Vg7X5YvylRy08Ekbgs5xoOV7qVJOpIWGIhWKkbdwqV1U
        pckrKzKtKRROMs2VwkMTxkenWI49YywlAA==
X-Google-Smtp-Source: ABdhPJy0YxIvLX9dTMxxXof3FlxBemY2hTiqr63v7e4sp4TtxyDqeUs9WsavqyimMjFOeA6BnJnXkA==
X-Received: by 2002:adf:fdcc:: with SMTP id i12mr26566291wrs.317.1608687472387;
        Tue, 22 Dec 2020 17:37:52 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d191sm28492563wmd.24.2020.12.22.17.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 17:37:51 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 10/20] mktag tests: test "hash-object" compatibility
Date:   Wed, 23 Dec 2020 02:35:55 +0100
Message-Id: <20201223013606.7972-11-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20201209200140.29425-1-avarab@gmail.com>
References: <20201209200140.29425-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change all the successful "mktag" tests to test that "hash-object"
produces the same hash for the input, and that fsck passes for
both.

This tests e.g. that "mktag" doesn't trim its input or otherwise munge
it in a way that "hash-object" doesn't.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3800-mktag.sh | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
index f339321be8..c6826762d9 100755
--- a/t/t3800-mktag.sh
+++ b/t/t3800-mktag.sh
@@ -19,6 +19,16 @@ check_verify_failure () {
 	'
 }
 
+test_expect_mktag_success() {
+	test_expect_success "$1" '
+		git hash-object -t tag -w --stdin <tag.sig >expected &&
+		git fsck --strict &&
+		git mktag <tag.sig >hash &&
+		git fsck --strict &&
+		test_cmp expected hash
+	'
+}
+
 ###########################################################
 # first create a commit, so we have a valid object/type
 # for the tag.
@@ -255,9 +265,7 @@ tagger T A Gger <> 0 +0000
 
 EOF
 
-test_expect_success \
-    'allow empty tag email' \
-    'git mktag <tag.sig'
+test_expect_mktag_success 'allow empty tag email'
 
 ############################################################
 # 16. disallow spaces in tag email
@@ -382,9 +390,7 @@ tagger T A Gger <tagger@example.com> 1206478233 -0500
 this line comes after an extra newline
 EOF
 
-test_expect_success 'allow extra newlines at start of body' '
-	git mktag <tag.sig
-'
+test_expect_mktag_success 'allow extra newlines at start of body'
 
 cat >tag.sig <<EOF
 object $head
@@ -394,9 +400,7 @@ tagger T A Gger <tagger@example.com> 1206478233 -0500
 
 EOF
 
-test_expect_success 'allow extra newlines at end of headers' '
-	git mktag <tag.sig
-'
+test_expect_mktag_success 'allow extra newlines at end of headers'
 
 space=' '
 cat >tag.sig <<EOF
@@ -431,8 +435,8 @@ tagger T A Gger <tagger@example.com> 1206478233 -0500
 
 EOF
 
-test_expect_success 'create valid tag' '
-	git mktag <tag.sig >hash &&
+test_expect_mktag_success 'create valid tag object'
+test_expect_success 'create valid tag name' '
 	git update-ref refs/tags/mytag $(cat hash) $(test_oid zero)
 '
 
-- 
2.29.2.222.g5d2a92d10f8

