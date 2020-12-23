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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E68B8C433DB
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 01:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE83D22583
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 01:39:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbgLWBjG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Dec 2020 20:39:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727100AbgLWBjF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Dec 2020 20:39:05 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD32C061248
        for <git@vger.kernel.org>; Tue, 22 Dec 2020 17:37:49 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id n16so530797wmc.0
        for <git@vger.kernel.org>; Tue, 22 Dec 2020 17:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jKEoAH4nxOfVWKbRAq3p/SCp0ZPbcwdiqm78pFlNpec=;
        b=o5XQ5NLQPrkJ52Dw8yCRU31IatxE0cP5LLbsiYaOnJKKICNBZuhqmFXDjcyqVkASOo
         sjHYVTG46k5VvOgbPCGO8CoeqlDHnnnwNpJOLuJ69T5U3Eqe7xC4az5XmT6wAE8/w28h
         VQxq8XUBXmHJOayp8zOp5kwZPt/DcfPRlZz5Hmpr+3/g0W1LrAScbHimQPEogaAp5nVS
         /cSI1nmtM6xCF81RnaUGtieWaT4zFkYFZskVHo3l/aiYOR+xUDGPcj2NkSiwfZc3LHry
         PuBe4FTEyY99327WMgbTUDkkEGvBTWqITrsD750P5EwLgy2CSASFQpB6ANmipsQDnx7r
         66IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jKEoAH4nxOfVWKbRAq3p/SCp0ZPbcwdiqm78pFlNpec=;
        b=CQKwGB5UFXhRLzO6BV6mZKwjVYCdjAFqk8HoS0CP3ie9IbpjoEpWnEHK/Fm0b8DsbN
         A86k3EyHAnwgRpueiKVnO4WuHIS0KDIWtdZ0Y65T+2YYH9EbXcqzmtpk1FBtpJEEPdsx
         1pV8xF3IoxSZtnXmZ5cGbL25hpKdBEtbsB3sSjHO8B4YA0qI4ot/3sKtVZUoHGoV1Rp0
         gCdpQih2QX675n/MiYK+hCIk74xqsvxXqyOKxcYO9mQ6mposW1b8mO0XDu2M5aHGdn5Z
         h05ouejwVLdDqYI/VAzRd319ERKT9NNTNWq5d1BXc5+fNbfmS8t1fWA1dTCZIbKCZutJ
         lNLw==
X-Gm-Message-State: AOAM531Br0m0wA7N3Rybs3UhOrRvNLuLl4yrilhrsa0AsY9KB/YVRwIe
        yYKZzsPg9P433bJwfalgWO/8i9X6bGY7wg==
X-Google-Smtp-Source: ABdhPJzQZNCG9QdsXNZcgAF5u+QkoaI0YtF+Y06qz8ICkwF7Cs2ZI7eM3sNxAuFG/zyqtw1pucRjSQ==
X-Received: by 2002:a05:600c:cc:: with SMTP id u12mr24934686wmm.42.1608687468387;
        Tue, 22 Dec 2020 17:37:48 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d191sm28492563wmd.24.2020.12.22.17.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 17:37:47 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 06/20] mktag tests: improve verify_object() test coverage
Date:   Wed, 23 Dec 2020 02:35:51 +0100
Message-Id: <20201223013606.7972-7-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20201209200140.29425-1-avarab@gmail.com>
References: <20201209200140.29425-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The verify_object() function in "mktag.c" is tasked with ensuring that
our tag refers to a valid object.

The existing test for this might fail because it was also testing that
"type taggg" didn't refer to a valid object type (it should be "type
tag"), or because we referred to a valid object but got the type
wrong.

Let's split these tests up, so we're testing all combinations of a
non-existing object and in invalid/wrong "type" lines.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3800-mktag.sh | 37 +++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
index a22a0954d5..9ae1b0bb0a 100755
--- a/t/t3800-mktag.sh
+++ b/t/t3800-mktag.sh
@@ -125,19 +125,52 @@ check_verify_failure '"type" line type-name length check' \
 	'^error: char.*: type too long$'
 
 ############################################################
-#  9. verify object (SHA1/type) check
+#  9. verify object (hash/type) check
 
 cat >tag.sig <<EOF
 object $(test_oid deadbeef)
+type tag
+tag mytag
+tagger . <> 0 +0000
+
+EOF
+
+check_verify_failure 'verify object (hash/type) check -- correct type, nonexisting object' \
+	'^error: char7: could not verify object.*$'
+
+cat >tag.sig <<EOF
+object $head
 type tagggg
 tag mytag
 tagger . <> 0 +0000
 
 EOF
 
-check_verify_failure 'verify object (SHA1/type) check' \
+check_verify_failure 'verify object (hash/type) check -- made-up type, nonexisting object' \
+	'^fatal: invalid object type'
+
+cat >tag.sig <<EOF
+object $(test_oid deadbeef)
+type tagggg
+tag mytag
+tagger . <> 0 +0000
+
+EOF
+
+check_verify_failure 'verify object (hash/type) check -- incorrect type, valid object' \
 	'^error: char7: could not verify object.*$'
 
+cat >tag.sig <<EOF
+object $head
+type tree
+tag mytag
+tagger . <> 0 +0000
+
+EOF
+
+check_verify_failure 'verify object (hash/type) check -- incorrect type, valid object' \
+	'^error: char7: could not verify object'
+
 ############################################################
 # 10. verify tag-name check
 
-- 
2.29.2.222.g5d2a92d10f8

