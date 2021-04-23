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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E316CC433ED
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 07:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 959EC613D7
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 07:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241093AbhDWHWK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 03:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241122AbhDWHWF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 03:22:05 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17BAC061574
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 00:21:28 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id l4so72407682ejc.10
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 00:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JyTvO720VkeLR2TGP2Iq4F9eggtM9ekpwCalzYbDvMQ=;
        b=b3+HeGij3n+nrtqiQLgfBf6dl5XPIMHMq6DO5Gfm3DnfKz/ji2x76lxcrp7iOipODA
         tZ1U6y+uop+7bp4wDs9Sa8vqp8jG814VvJ4dKfWfqoLhJxuLSStdyHYBdOIm8wX2DuWw
         P0ssKdCq9Ft4riBTgl+VlrdLC+EcF+zL2F0A2a/sENFH8LvI5mTVlhOYVJBRoTWBxele
         /zVxQrRTcVM2x+J9rL8W9uUtlSr2wlI0XSe69XQ5wST/1k4ARhsYVX+oewZF2OGo3nhS
         RQ2wwRxhJ528jk37fpeL60kX2gCwyUXLcc34bR6dbU8uRFzW11Q2gd+RXvRBQ8kp+GSo
         ZBNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JyTvO720VkeLR2TGP2Iq4F9eggtM9ekpwCalzYbDvMQ=;
        b=eiDAmYku/Bkbg6Ir9w9jLEbI1i/CGHyKPyQex9Tq2BEU2TfN3sSKFDq+ByMZI6jrZV
         wHnnRgnHQjuZwI+6laSAcHCdJWM5vnSJr4FXQX6S3/S3YTvXQTe4DhjXgJP+Ps0PbxVi
         yEXLIbZbdLD8EyCmyWdSWXZgNYFIUj2O7x9Hic7V0Ywx81Oaq0bCgIj2+4eG2A61iVHu
         /ClypRS0jG5WSqpdpHjqiZrnSefZGcUbytrp5eggoRMj7ATuc+M1ycZQOORWaxTwb4Bx
         vzw6ZOZWRdUvjUXyEiHTGDUkNPFmsiItNj+odsr2vykkyzHGqSvyR8+zQ3v/ckpC6RnQ
         2Sww==
X-Gm-Message-State: AOAM530dt0IhAFvlBfc04xTnrSK2PyCzKClC3z7cDTc25gfFXkiN50zT
        PXhm5zPIG1pKQdu15fvu9g+1AbnlLr1KoA==
X-Google-Smtp-Source: ABdhPJwohRGSE0+bE6P9hlSNBhqtPlJlBus1w93XrL4tRF+a2qv1oHQGYtYmPo/j+G33EVWMVSuaMQ==
X-Received: by 2002:a17:907:2d89:: with SMTP id gt9mr2726725ejc.122.1619162487357;
        Fri, 23 Apr 2021 00:21:27 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e5sm3328892ejq.85.2021.04.23.00.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 00:21:26 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 06/11] describe tests: convert setup to use test_commit
Date:   Fri, 23 Apr 2021 09:21:10 +0200
Message-Id: <patch-06.11-589eaf7a078-20210423T072006Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.737.g98b508eba36
In-Reply-To: <cover-00.11-00000000000-20210423T072006Z-avarab@gmail.com>
References: <cover-00.11-0000000000-20210421T101156Z-avarab@gmail.com> <cover-00.11-00000000000-20210423T072006Z-avarab@gmail.com>
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
2.31.1.737.g98b508eba36

