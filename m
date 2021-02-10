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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CA5C433E0
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 11:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E2D864E40
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 11:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbhBJLmh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 06:42:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbhBJLkQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 06:40:16 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D2FC06178C
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 03:38:24 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id o7so1062237pgl.1
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 03:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zNL8g7U1+kOdX7W3rW7enYJEIT8uPDc4xfpItJ936bc=;
        b=bb2iMXnCi17y2i+IKk7ptcusSZNgmJCeEqyEmfLXsOX2pk1vSkQpZt9Hd5l5HJ2D4K
         VMmRAFSTETnP6YA3sqBsuMKNOFrdSpmDQfGf+14l2E4bKt6sDVSgNQeXpFuuuzY3IYM9
         ery5p2w3ZNX1Q7bTqRBv4XNIUtGZRKKc/qmVO6oOhCQvnnhK/SDtnNBq33Si4+0WSkKb
         1uXmnjol37v+KpiUD/j+Zg+yH0VsLK8P9LWrpPrIGchEnobJzVco0sOom45iQQjvI6XD
         +E6grEx0mTGt9ZX1xvth/rIKRjqjOE0wVmQfTokYSL9wTKsSjmA25Ez1l4ZmgsZEIJv6
         7ZMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zNL8g7U1+kOdX7W3rW7enYJEIT8uPDc4xfpItJ936bc=;
        b=imHWu0YmdiikCaEndEaoqOFqgk1lkVtLtKYinozGEvzA0pdVYgiiDuKgPO16aP4XQ7
         VyE06I7RiYXHKfQreRos254GgFrQGnhCdJir8hagsAcYEZct2tpTS2HPKNI8I9Z3SrVZ
         I+uzVtNEM72fNa/P+RRjIXzX5fJOIYYrq6XUuAYGCIjU5RsWfMo9reQW7EzWUwyTo8bs
         gcl+UKXpnCYpkkTVdJ5wr0V8I7CKL5mpWwgoDsAFaqDGldBoj+EYX8Aqdqc6ZzCuph0c
         lZUY/4rD2W8PidjrcfpaY/i57hjAfIgRaC0PDGtP6qBndnzqZNBc1x7nQ5lKOpVR55zA
         o/iw==
X-Gm-Message-State: AOAM530O2zOBeDP6xkBhPk9FU7zM/39HAInaK7hysRA0+3fnu33c344c
        IwDMuIsLZuok9EpA7aYdH4Yhj6nEIFcQbA==
X-Google-Smtp-Source: ABdhPJwY8wbyoEDyvmLUWdg3LGa4jga10eZtUp11tdYoMoGX7vOU3TxmkQp/ozNdSnokGyeI34VTBQ==
X-Received: by 2002:a62:b416:0:b029:1e4:fb5a:55bb with SMTP id h22-20020a62b4160000b02901e4fb5a55bbmr2836439pfn.80.1612957103688;
        Wed, 10 Feb 2021 03:38:23 -0800 (PST)
Received: from localhost.localdomain ([171.76.0.223])
        by smtp.googlemail.com with ESMTPSA id y3sm2123731pfr.125.2021.02.10.03.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 03:38:23 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sunshine@sunshineco.com,
        christian.couder@gmail.com, phillip.wood123@gmail.com,
        Charvi Mendiratta <charvi077@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v3 05/11] t/t3437: fixup here-docs in the 'setup' test
Date:   Wed, 10 Feb 2021 17:06:45 +0530
Message-Id: <20210210113650.19715-6-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210207181439.1178-1-charvi077@gmail.com>
References: <20210207181439.1178-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The most common way to format here-docs in Git test scripts is for the
body and EOF to be indented the same amount as the command which opened
the here-doc. Fix a few here-docs in this script to conform to that
standard and also remove the unnecessary curly braces.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
---
 t/t3437-rebase-fixup-options.sh | 62 ++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/t/t3437-rebase-fixup-options.sh b/t/t3437-rebase-fixup-options.sh
index 945df2555b..f599da3e08 100755
--- a/t/t3437-rebase-fixup-options.sh
+++ b/t/t3437-rebase-fixup-options.sh
@@ -38,13 +38,13 @@ get_author () {
 
 test_expect_success 'setup' '
 	cat >message <<-EOF &&
-		amend! B
-		${EMPTY}
-		new subject
-		${EMPTY}
-		new
-		body
-		EOF
+	amend! B
+	$EMPTY
+	new subject
+	$EMPTY
+	new
+	body
+	EOF
 
 	sed "1,2d" message >expected-message &&
 
@@ -70,38 +70,38 @@ test_expect_success 'setup' '
 	git commit --fixup=HEAD -a &&
 	test_tick &&
 	git commit --allow-empty -F - <<-EOF &&
-		amend! B
-		${EMPTY}
-		B
-		${EMPTY}
-		edited 1
-		EOF
+	amend! B
+	$EMPTY
+	B
+	$EMPTY
+	edited 1
+	EOF
 	test_tick &&
 	git commit --allow-empty -F - <<-EOF &&
-		amend! amend! B
-		${EMPTY}
-		B
-		${EMPTY}
-		edited 1
-		${EMPTY}
-		edited 2
-		EOF
+	amend! amend! B
+	$EMPTY
+	B
+	$EMPTY
+	edited 1
+	$EMPTY
+	edited 2
+	EOF
 	echo B2 >B &&
 	test_tick &&
 	FAKE_COMMIT_AMEND="edited squash" git commit --squash=HEAD -a &&
 	echo B3 >B &&
 	test_tick &&
 	git commit -a -F - <<-EOF &&
-		amend! amend! amend! B
-		${EMPTY}
-		B
-		${EMPTY}
-		edited 1
-		${EMPTY}
-		edited 2
-		${EMPTY}
-		edited 3
-		EOF
+	amend! amend! amend! B
+	$EMPTY
+	B
+	$EMPTY
+	edited 1
+	$EMPTY
+	edited 2
+	$EMPTY
+	edited 3
+	EOF
 
 	GIT_AUTHOR_NAME="Rebase Author" &&
 	GIT_AUTHOR_EMAIL="rebase.author@example.com" &&
-- 
2.29.0.rc1

