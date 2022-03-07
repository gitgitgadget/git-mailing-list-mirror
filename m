Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F0E2C433EF
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 12:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242582AbiCGMu3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 07:50:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242581AbiCGMuX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 07:50:23 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6E24ECD7
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 04:49:28 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id n15so8976298wra.6
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 04:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GyW+lFTPs6L9WbrZTTODGlnLyCMi+GgrA39Fw8mDNl4=;
        b=Fj82iT3EdzJQHrf7roshSvxDg7dc8Sr6EaGi3fjCIhWjQRnlL/o8536w8ZPce5etc6
         2R5/S/itpfF3f+MuKl5xyljj6YphV1l07qyJ7jjvHumrmEyUyYN1q2Wreq6YeVVz6i/h
         C4wW+ioVQU+tErnAJMjcQ1t7FnE2NcmsSty3GMA/uYEdlfUGyKHgZItg8jCCA5Cs8FOl
         ZLwrjgzUj7/ACejDDXHrRhKX7ReEJhDTNZTqOnR4Z9UvhZ1qQ0z3BchKUZ4fkgkvAPqs
         QYUq+YZYN4mexvxJaAgGVE/cpkvCgF2zJZH2PVW1T80mZ5Xfbdq5NAqSl7LyPpoJU1Qo
         idKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GyW+lFTPs6L9WbrZTTODGlnLyCMi+GgrA39Fw8mDNl4=;
        b=yzcxHl9Yu6haQmWSWDJlYArU5Pfi8i14/PpzwTE/G8lQvBSxeQa9HWeQDhNnqNGMRd
         rjY3Zi/2j/62y7VDu1d1b0ved5kK/d2hKr7oEdxBnrY4H6vIYp9lvZcqClXu/a1y7u+u
         MW2Qv9l66n4OX1PuWYuJWw/VCCEvXFBXf8k4DJqJTokKxLUDNW58TNlX9FlWQ7fo4BG2
         AqBqDiO/6MnGdQs97xGrQh3OgKhwJfKumrx4wK9mW2d4sWZ6jTor3Q/X3FyINz5bJjyc
         ihfe7kinzrZ40qh9guHINfkCX2u4ZAwzIjLe2UZoDvX90aVbq2PloYTQmQoLE/M9Y1cz
         TCug==
X-Gm-Message-State: AOAM5307lzzuem/fQx66YQ/M0Hulo++JJmNJfaV6jtSghbrWqizY8t56
        6OryuphpJOV35ruLilFak7CMRVptoFZKkA==
X-Google-Smtp-Source: ABdhPJxC67ykHz0kkLmghOS9IsreHIa5Yckc2OAMX9f3SjlgsJwojgADvNtnmMwbjw0U3yHBrC0bHA==
X-Received: by 2002:a05:6000:381:b0:1ef:fad4:59c0 with SMTP id u1-20020a056000038100b001effad459c0mr8115458wrf.162.1646657366604;
        Mon, 07 Mar 2022 04:49:26 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o3-20020a1c7503000000b0038100e2a1adsm12729091wmc.47.2022.03.07.04.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 04:49:25 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Shubham Mishra <shivam828787@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 04/15] diff tests: don't ignore "git diff" exit code
Date:   Mon,  7 Mar 2022 13:48:55 +0100
Message-Id: <patch-v2-04.15-a425ced5609-20220307T124817Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1242.gfeba0eae32b
In-Reply-To: <cover-v2-00.15-00000000000-20220307T124817Z-avarab@gmail.com>
References: <cover-00.15-00000000000-20220302T171755Z-avarab@gmail.com> <cover-v2-00.15-00000000000-20220307T124817Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a test pattern that originated in f1af60bdba4 (Support 'diff=pgm'
attribute, 2007-04-22) so that we'll stop using "git diff" on the
left-hand-side of a pipe, and thus ignoring its exit code.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4020-diff-external.sh | 49 ++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 27 deletions(-)

diff --git a/t/t4020-diff-external.sh b/t/t4020-diff-external.sh
index 54bb8ef27e7..879ee04d291 100755
--- a/t/t4020-diff-external.sh
+++ b/t/t4020-diff-external.sh
@@ -37,17 +37,15 @@ test_expect_success 'GIT_EXTERNAL_DIFF environment' '
 
 '
 
-test_expect_success 'GIT_EXTERNAL_DIFF environment should apply only to diff' '
-
-	GIT_EXTERNAL_DIFF=echo git log -p -1 HEAD |
-	grep "^diff --git a/file b/file"
+test_expect_success !SANITIZE_LEAK 'GIT_EXTERNAL_DIFF environment should apply only to diff' '
+	GIT_EXTERNAL_DIFF=echo git log -p -1 HEAD >out &&
+	grep "^diff --git a/file b/file" out
 
 '
 
 test_expect_success 'GIT_EXTERNAL_DIFF environment and --no-ext-diff' '
-
-	GIT_EXTERNAL_DIFF=echo git diff --no-ext-diff |
-	grep "^diff --git a/file b/file"
+	GIT_EXTERNAL_DIFF=echo git diff --no-ext-diff >out &&
+	grep "^diff --git a/file b/file" out
 
 '
 
@@ -83,16 +81,16 @@ test_expect_success 'diff.external' '
 	}
 '
 
-test_expect_success 'diff.external should apply only to diff' '
+test_expect_success !SANITIZE_LEAK 'diff.external should apply only to diff' '
 	test_config diff.external echo &&
-	git log -p -1 HEAD |
-	grep "^diff --git a/file b/file"
+	git log -p -1 HEAD >out &&
+	grep "^diff --git a/file b/file" out
 '
 
 test_expect_success 'diff.external and --no-ext-diff' '
 	test_config diff.external echo &&
-	git diff --no-ext-diff |
-	grep "^diff --git a/file b/file"
+	git diff --no-ext-diff >out &&
+	grep "^diff --git a/file b/file" out
 '
 
 test_expect_success 'diff attribute' '
@@ -115,17 +113,15 @@ test_expect_success 'diff attribute' '
 
 '
 
-test_expect_success 'diff attribute should apply only to diff' '
-
-	git log -p -1 HEAD |
-	grep "^diff --git a/file b/file"
+test_expect_success !SANITIZE_LEAK 'diff attribute should apply only to diff' '
+	git log -p -1 HEAD >out &&
+	grep "^diff --git a/file b/file" out
 
 '
 
 test_expect_success 'diff attribute and --no-ext-diff' '
-
-	git diff --no-ext-diff |
-	grep "^diff --git a/file b/file"
+	git diff --no-ext-diff >out &&
+	grep "^diff --git a/file b/file" out
 
 '
 
@@ -148,17 +144,15 @@ test_expect_success 'diff attribute' '
 
 '
 
-test_expect_success 'diff attribute should apply only to diff' '
-
-	git log -p -1 HEAD |
-	grep "^diff --git a/file b/file"
+test_expect_success !SANITIZE_LEAK 'diff attribute should apply only to diff' '
+	git log -p -1 HEAD >out &&
+	grep "^diff --git a/file b/file" out
 
 '
 
 test_expect_success 'diff attribute and --no-ext-diff' '
-
-	git diff --no-ext-diff |
-	grep "^diff --git a/file b/file"
+	git diff --no-ext-diff >out &&
+	grep "^diff --git a/file b/file" out
 
 '
 
@@ -177,7 +171,8 @@ test_expect_success 'attributes trump GIT_EXTERNAL_DIFF and diff.external' '
 
 test_expect_success 'no diff with -diff' '
 	echo >.gitattributes "file -diff" &&
-	git diff | grep Binary
+	git diff >out &&
+	grep Binary out
 '
 
 echo NULZbetweenZwords | perl -pe 'y/Z/\000/' > file
-- 
2.35.1.1242.gfeba0eae32b

