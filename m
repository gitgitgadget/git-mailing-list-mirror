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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 906F6C433E0
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 19:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64CD322D6F
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 19:44:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730934AbhAEToz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jan 2021 14:44:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730921AbhAETox (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jan 2021 14:44:53 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40010C0617A4
        for <git@vger.kernel.org>; Tue,  5 Jan 2021 11:43:40 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id d26so308537wrb.12
        for <git@vger.kernel.org>; Tue, 05 Jan 2021 11:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Lm7xPXJUT0TSQKgC++uSxgFf2YALDhEz263zAZuMUA4=;
        b=k1vnx4Yi5VUHuGfxjIO+GM26z86J/1nPE1FMKlyiP95qhHjtIymzqUseRtXeCciIjb
         TaUa9/6a75oBaE5ZNu3+9ciYO/6pXFxTEN9yiDQL27caE6aaJ5Jjl7JnzTehi626waDq
         enn+3P1JE//9Jc37x3L18sh5AWs+gW3Xl8sivB7qhCd5dU+gHpw37R/iKNtJG9qz+6Ce
         9Ua32V8ZX7eS72CIMmQ1IdG5E3D5c+BLPNAbNL5G5d6Wuy01qBYTuyjw275kyY4yUnbq
         hnFVbCztlEziSKqDhJFQt2OUkR75YqWzm+qzP1sZQWGSfOginU+mkypGbzX/QxZgtLFD
         8AkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lm7xPXJUT0TSQKgC++uSxgFf2YALDhEz263zAZuMUA4=;
        b=emWeyeivEolNYjkMlL4inusgz9wvisSSmZw8fS+EDRs5G0AAfJqb5v0gOtTNJJ0fha
         RgVTSPiAOAcZAzn7cHmxsY4ScAKBIEf+8kTRZocxgMgyIbo8czVFRKtLNjIdRqIOWwUU
         IA2jYbk8/QE9rDXqSCE0C+2tmUBt2kR9KU8368ceV4rjjAWg4H0Kq2Dm2qOue0qdp3Qz
         TtQSoVkut78gz9kzZt7pVsrkpIn4B7igC4Iwk/Dw9ozOpBu5JMsTwacn8f3CcP02dX9t
         3JWpnKVrmL32TTZdu+lEfIIMej/9vF4nTpRvi2xFiD2yOyMqtzMa0C+unvy+1ZOZrywx
         j2hA==
X-Gm-Message-State: AOAM531QDsXDIj8JnjT6Hng66UWZdTd3ss1plOhiWhzEYic2A+zEmj9H
        T0r/PmHLec8TePUC65tffTiSgypLBASmbA==
X-Google-Smtp-Source: ABdhPJy9p2GxHhB01YpLVdxTfxo/9sFpth8PR+muchp7SCGng18t3lXlQuj4aLNdqmxHBzz0poQ6iQ==
X-Received: by 2002:adf:f3c8:: with SMTP id g8mr1018722wrp.405.1609875818718;
        Tue, 05 Jan 2021 11:43:38 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s6sm151113wro.79.2021.01.05.11.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 11:43:37 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 11/23] mktag tests: test "hash-object" compatibility
Date:   Tue,  5 Jan 2021 20:42:40 +0100
Message-Id: <20210105194252.627-12-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20201223013606.7972-1-avarab@gmail.com>
References: <20201223013606.7972-1-avarab@gmail.com>
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

Since we're doing an "fsck --strict" here at the end let's incorporate
the creation of the "mytag" name into this test, removing the
special-case at the end of the file.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3800-mktag.sh | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
index 661b62f0912..47380292223 100755
--- a/t/t3800-mktag.sh
+++ b/t/t3800-mktag.sh
@@ -19,6 +19,19 @@ check_verify_failure () {
 	'
 }
 
+test_expect_mktag_success() {
+	test_expect_success "$1" '
+		git hash-object -t tag -w --stdin <tag.sig >expected &&
+		git fsck --strict &&
+
+		git mktag <tag.sig >hash &&
+		test_cmp expected hash &&
+		test_when_finished "git update-ref -d refs/tags/mytag $(cat hash)" &&
+		git update-ref refs/tags/mytag $(cat hash) $(test_oid zero) &&
+		git fsck --strict	
+	'
+}
+
 ###########################################################
 # first create a commit, so we have a valid object/type
 # for the tag.
@@ -220,9 +233,7 @@ tagger T A Gger <> 0 +0000
 
 EOF
 
-test_expect_success \
-    'allow empty tag email' \
-    'git mktag <tag.sig'
+test_expect_mktag_success 'allow empty tag email'
 
 ############################################################
 # 16. disallow spaces in tag email
@@ -347,9 +358,7 @@ tagger T A Gger <tagger@example.com> 1206478233 -0500
 this line comes after an extra newline
 EOF
 
-test_expect_success 'allow extra newlines at start of body' '
-	git mktag <tag.sig
-'
+test_expect_mktag_success 'allow extra newlines at start of body'
 
 cat >tag.sig <<EOF
 object $head
@@ -359,9 +368,7 @@ tagger T A Gger <tagger@example.com> 1206478233 -0500
 
 EOF
 
-test_expect_success 'require a blank line before an empty body (1)' '
-	git mktag <tag.sig
-'
+test_expect_mktag_success 'require a blank line before an empty body (1)'
 
 cat >tag.sig <<EOF
 object $head
@@ -384,10 +391,6 @@ tagger T A Gger <tagger@example.com> 1206478233 -0500
 
 EOF
 
-test_expect_success 'create valid tag' '
-	git mktag <tag.sig >hash &&
-	git update-ref refs/tags/mytag $(cat hash) $(test_oid zero) &&
-	git fsck --strict
-'
+test_expect_mktag_success 'create valid tag object'
 
 test_done
-- 
2.29.2.222.g5d2a92d10f8

