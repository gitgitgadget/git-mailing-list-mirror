Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BDCCC43460
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 11:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33BA761249
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 11:09:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240053AbhDLLJk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 07:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240017AbhDLLJf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 07:09:35 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D17C061574
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 04:09:17 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id c15so3525737wro.13
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 04:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uTxmY/erkaUGs0q9PprtI8ErQl0/SxKCaUdgamir83s=;
        b=gEFdlMlIWIuXTueTixDTMCPPwDGPcgNHrH1m7fjsa2iFgv6Ik8VS2aGTQE3bXEA7GL
         8ZyFsld6AVZlGJNzzgqrasbh8W/57W6XySqPUF/xhJbyDEIB2L2RJcZyQ6cWG+LIGVxY
         BGT+WT4DVUatcUGiBt0j+FI234GGw+ofDx3CFu1mQuxibHHPFibmOKVqJ+ppJ48raLt7
         +u+9GcTv5vwc7LO7QhtXqX9XUfa357qAMhTr1jN4rrca091gThq5k+kqb22R2KX/kVi5
         iD8A519ZTMqZjq/ED3bYVYpRcZQZ/EY82GWRyfmEF4sT2tDf6zlW2XoRtdNLJgLKCyJ+
         WtKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uTxmY/erkaUGs0q9PprtI8ErQl0/SxKCaUdgamir83s=;
        b=Z46iuhndC6GF4ztj90M+Up5DQH6GCTmY6y/EZjj2kAygv21dxpNGb8LG/Hn3wTE3OC
         wLJo/rv6N1A5DdpFVUyVDxRfrM2Z9Gx2fMsNU0B2QQRFvMeVo3KP5hDeBQdz0Gqi53Np
         0Z7ENv8eKHdAajp/GktP+KzVA4J17bsCHui8kUexuUMBoLB4tQyv6VHPMyXDTzqj+pGY
         nYgEXBhEyGYySHYVshs/Is/yQg+NyYQTMSDJwJkaTwtjdTjFKZeskLUMtYur+fgO1mRs
         IiziWbr1bLJtiXPq4YPlGjFc3KklQEnGQm4jg4Eej7UO2YDbUfXLYgYaTeDRgV5A5tYe
         TRCA==
X-Gm-Message-State: AOAM532L8rA0DPC37qBDleXP2aMnuAUnjkZWwPyd78eBhz8912n5+L00
        24emx4SKWYCO03XpohODHN3AcxJrRVxv4w==
X-Google-Smtp-Source: ABdhPJzfeiNB4Da68YZGk556AL8GHobQVGzqqJzckqjUuosqtLh0pcGjiiuRhQTIStX7KXBbdaEGwA==
X-Received: by 2002:adf:fb0b:: with SMTP id c11mr31223969wrr.425.1618225755797;
        Mon, 12 Apr 2021 04:09:15 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a8sm18158744wrh.91.2021.04.12.04.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 04:09:15 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 07/16] describe tests: convert setup to use test_commit
Date:   Mon, 12 Apr 2021 13:08:56 +0200
Message-Id: <patch-07.16-ec4809e7466-20210412T110456Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.634.gb41287a30b0
In-Reply-To: <cover-00.16-00000000000-20210412T110456Z-avarab@gmail.com>
References: <cover-00.16-00000000000-20210412T110456Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert the setup of the describe tests to use test_commit when
possible. This makes use of the new --annotated-tag option to
test_commit.

Some of the setup here could simply be removed since the data being
created wasn't important to any of the subsequent tests, so I've done
so. E.g. assigning to the "one" variable was always useless, and just
checking that we can describe HEAD after the first commit wasn't
useful.

In the case of the "two" variable we could instead use the tag we just
created. See 5312ab11fbf (Add describe test., 2007-01-13) for the
initial version of this code. There's other cases here like redundant
"test_tick" invocations, or the simplification of not echoing "X" to a
file we're about to tag as "x", now we just use "x" in both cases.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t6120-describe.sh | 58 ++++++++++-----------------------------------
 1 file changed, 13 insertions(+), 45 deletions(-)

diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index e89b6747bee..88fddc91424 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -31,64 +31,32 @@ check_describe () {
 }
 
 test_expect_success setup '
+	test_commit initial file one &&
+	test_commit second file two &&
+	test_commit third file three &&
+	test_commit --annotate A file A &&
+	test_commit c file c &&
 
-	test_tick &&
-	echo one >file && git add file && git commit -m initial &&
-	one=$(git rev-parse HEAD) &&
-
-	git describe --always HEAD &&
-
-	test_tick &&
-	echo two >file && git add file && git commit -m second &&
-	two=$(git rev-parse HEAD) &&
-
-	test_tick &&
-	echo three >file && git add file && git commit -m third &&
-
-	test_tick &&
-	echo A >file && git add file && git commit -m A &&
-	test_tick &&
-	git tag -a -m A A &&
-
-	test_tick &&
-	echo c >file && git add file && git commit -m c &&
-	test_tick &&
-	git tag c &&
-
-	git reset --hard $two &&
-	test_tick &&
-	echo B >side && git add side && git commit -m B &&
-	test_tick &&
-	git tag -a -m B B &&
+	git reset --hard second &&
+	test_commit --annotate B side B &&
 
 	test_tick &&
 	git merge -m Merged c &&
 	merged=$(git rev-parse HEAD) &&
 
-	git reset --hard $two &&
-	test_tick &&
-	echo D >another && git add another && git commit -m D &&
-	test_tick &&
-	git tag -a -m D D &&
-	test_tick &&
-	git tag -a -m R R &&
-
-	test_tick &&
-	echo DD >another && git commit -a -m another &&
+	git reset --hard second &&
+	test_commit --no-tag D another D &&
 
 	test_tick &&
-	git tag e &&
+	git tag -a -m R R &&
 
-	test_tick &&
-	echo DDD >another && git commit -a -m "yet another" &&
+	test_commit e another DD &&
+	test_commit --no-tag "yet another" another DDD &&
 
 	test_tick &&
 	git merge -m Merged $merged &&
 
-	test_tick &&
-	echo X >file && echo X >side && git add file side &&
-	git commit -m x
-
+	test_commit --no-tag x file
 '
 
 check_describe A-* HEAD
-- 
2.31.1.634.gb41287a30b0

