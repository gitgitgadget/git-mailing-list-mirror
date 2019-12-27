Return-Path: <SRS0=DNff=2R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C46FCC2D0C6
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 13:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A09220882
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 13:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sntb6oKJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbfL0Nrk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Dec 2019 08:47:40 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:36754 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbfL0Nrj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Dec 2019 08:47:39 -0500
Received: by mail-qv1-f67.google.com with SMTP id m14so10070601qvl.3
        for <git@vger.kernel.org>; Fri, 27 Dec 2019 05:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=gDx4jk7LmV5Dr657wmr4gME5FAhHx6/hzJkxqQnqu98=;
        b=sntb6oKJjrsSgiGcxhPAUgKkmfqcaNxoA2+r/9qU56m5LW5VUg64B+Q4bB2I6ToA6T
         EnCk1qjXYxGsNyBSlWcN+mWMiNeOz05fnHXjBowtZoJH4m3W9iI1/C9UADprkGiTy8/S
         v2OLog9MKmoDbU9sq4XMZadqVt7jgKhfktYpQX14NhUHy/748xQsSz51b+ozE6qN0EfL
         7a1XAJq+GX6HfeY5uYDAs8toVZGuriJSisIkXk7uhbEVB/uNKSIGpNoHepklrG18jiBs
         60ompWh5QZJnL7Zi1PyBtNgC38fduu44nQwUBiRfDeqShF+6pEoj+etd/TIsB3wPe9eq
         PiMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gDx4jk7LmV5Dr657wmr4gME5FAhHx6/hzJkxqQnqu98=;
        b=h4TlfSL70wcHA4z5wZtUgGphbFFp7I8d8WchQYFE7yuyEEgHcZuGoc7eoGrZjN2dK7
         IGMTQe4QCa8VWJPfSGG+8E5kgbU1u9Djk8mODRIJDWIn+50H/oEdP8yYAn/kskO0o11k
         /yxbjaP8n9Y44d+jmrN5j1Xuv7tejUBLV1q5j2lt+/eceXRdpRycrQDSSehJwJd4onbN
         L1AEJWZ1AkHXtp2WfJ7MfqvbgGgpzdlWJShM/jMj8SFO2IV9S79j+0Tm33onf0b5sYtE
         QTleE47WJgemBBIriLroNkFgVNvDjA6SZ75/RFBVUEar+2nQfPJIkMG0uMYuee1Hwgv2
         I28A==
X-Gm-Message-State: APjAAAWdnV2P+f1rgJgRQRKo1mvSjUm8O9eR6ZddsS0jvYAXfyuHhjD/
        D8oVnjYWBVslv9zAFx2pMCmnlhKK
X-Google-Smtp-Source: APXvYqwQS98/ygI+Rl+gGBsgmaeJTTosM6Gf84G8m+9s/n4DSqet4DWD+CeIc8IML42It6h0L18cig==
X-Received: by 2002:a0c:904b:: with SMTP id o69mr39943860qvo.218.1577454458224;
        Fri, 27 Dec 2019 05:47:38 -0800 (PST)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id d9sm10510184qth.34.2019.12.27.05.47.37
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2019 05:47:37 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 03/16] t2018: use test_must_fail for failing git commands
Date:   Fri, 27 Dec 2019 08:47:12 -0500
Message-Id: <c584c9a52b492db2128846e86afb0aadddd6f2de.1577454401.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.24.1.810.g65a2f617f4
In-Reply-To: <cover.1577454401.git.liu.denton@gmail.com>
References: <cover.1577454401.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before, when we expected `git diff` to fail, we negated its status with
`!`. However, if git ever exits unexpectedly, say due to a segfault, we
would not be able to tell the difference between that and a controlled
failure. Use `test_must_fail git diff` instead so that if an unepxected
failure occurs, we can catch it.

We had some instances of `test_must_fail test_dirty_{un,}mergable`.
However, `test_must_fail` should only be used on git commands. Teach
test_dirty_{un,}mergable() to accept `!` as a potential first argument
which will run the git command without test_must_fail(). This prevents
the double-negation where we were effectively running
`test_must_fail test_must_fail git diff ...`.

While we're at it, remove redirections to /dev/null since output is
silenced when running without `-v` and debugging output is useful with
`-v`, remove redirections to /dev/null as it is not useful.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t2018-checkout-branch.sh | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/t/t2018-checkout-branch.sh b/t/t2018-checkout-branch.sh
index 79b16e4677..e6b852939c 100755
--- a/t/t2018-checkout-branch.sh
+++ b/t/t2018-checkout-branch.sh
@@ -33,7 +33,12 @@ do_checkout () {
 }
 
 test_dirty_unmergeable () {
-	! git diff --exit-code >/dev/null
+	should_fail="test_expect_code 1" &&
+	if test "x$1" = "x!"
+	then
+		should_fail=
+	fi &&
+	$should_fail git diff --exit-code
 }
 
 setup_dirty_unmergeable () {
@@ -41,7 +46,12 @@ setup_dirty_unmergeable () {
 }
 
 test_dirty_mergeable () {
-	! git diff --cached --exit-code >/dev/null
+	should_fail="test_expect_code 1"  &&
+	if test "x$1" = "x!"
+	then
+		should_fail=
+	fi &&
+	$should_fail git diff --cached --exit-code
 }
 
 setup_dirty_mergeable () {
@@ -93,7 +103,7 @@ test_expect_success 'checkout -f -b to a new branch with unmergeable changes dis
 
 	# still dirty and on branch1
 	do_checkout branch2 $HEAD1 "-f -b" &&
-	test_must_fail test_dirty_unmergeable
+	test_dirty_unmergeable !
 '
 
 test_expect_success 'checkout -b to a new branch preserves mergeable changes' '
@@ -111,7 +121,7 @@ test_expect_success 'checkout -f -b to a new branch with mergeable changes disca
 	test_when_finished git reset --hard HEAD &&
 	setup_dirty_mergeable &&
 	do_checkout branch2 $HEAD1 "-f -b" &&
-	test_must_fail test_dirty_mergeable
+	test_dirty_mergeable !
 '
 
 test_expect_success 'checkout -b to an existing branch fails' '
@@ -162,7 +172,7 @@ test_expect_success 'checkout -B to an existing branch with unmergeable changes
 test_expect_success 'checkout -f -B to an existing branch with unmergeable changes discards changes' '
 	# still dirty and on branch1
 	do_checkout branch2 $HEAD1 "-f -B" &&
-	test_must_fail test_dirty_unmergeable
+	test_dirty_unmergeable !
 '
 
 test_expect_success 'checkout -B to an existing branch preserves mergeable changes' '
@@ -179,7 +189,7 @@ test_expect_success 'checkout -f -B to an existing branch with mergeable changes
 
 	setup_dirty_mergeable &&
 	do_checkout branch2 $HEAD1 "-f -B" &&
-	test_must_fail test_dirty_mergeable
+	test_dirty_mergeable !
 '
 
 test_expect_success 'checkout -b <describe>' '
-- 
2.24.1.810.g65a2f617f4

