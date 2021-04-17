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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC546C433ED
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 12:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9AA5611C2
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 12:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236534AbhDQMyM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Apr 2021 08:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236533AbhDQMyJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Apr 2021 08:54:09 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79AE9C06175F
        for <git@vger.kernel.org>; Sat, 17 Apr 2021 05:53:43 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id e7so20273060wrs.11
        for <git@vger.kernel.org>; Sat, 17 Apr 2021 05:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DGAZwk8pHg2qlhXdfItmIVW2wqz9HK2/OknP1igIX9g=;
        b=BgoigwCwYIXkmTDTDtReHezyQ+mIsmLLx5ub8C8kjDCwbDIb4YJNgL3PPmIxrail19
         RWgygBAyoEfHemkMpqA89nzAPC51ZBsRU+y/iODwYOEU9KZ1e5VS+4sA6u5culT5prQr
         vZEmR1KI3TV9IRcPR6ZEikgNSrFF97kfh+A/IVIu3R80UTbdao+jHuhHB/0NR2vM75/h
         Pcl38pi2SbPYkdStVKS1fnjjFs82K3p1NLE+AQorsNiRAfjoG1CshAB4IdEL0xC3QPrv
         8z/uEFCBUm0MYLks+brVrhZnlvelFtO1Gxra6IOQo9o3J12HHnPW8Xma7eGceE2WXA2H
         viTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DGAZwk8pHg2qlhXdfItmIVW2wqz9HK2/OknP1igIX9g=;
        b=mNSIDDFyb4ZPT8XM/23/viA8OeP8I9oky4ePVzXFCIh9D2InKkjfr6ELG2Z6Bju/s3
         Im3V74Biwy4MeqLLh57KryeUFFIFHR3/s4kf60Dq3KWILMLiG1nxtaEOi4XLJ9RtG9mq
         PNB8QVoaCVufRaqcfyWkwcfp4dMXnFeywDdURZ7rNElKUNSH7PcwQw8T3QDYYTCNGkEq
         KntivS0jaLv6b0GyGx0AsXTvV1HZ8gLpK4RWguCCkBxI1eiFxOe/hv3d/Yp8r2hZ1ZOh
         cHvBo2Bssp6jH2IzrbYkkUQJM1Y+Md+m9YFFXhYwELQSV9QiuxVeC4DKTvBnvcZomEjE
         t1TA==
X-Gm-Message-State: AOAM531OJjttWH2Se/m9jQqzZI3th+0yKlqGv8UH7E0DsoZGsagRL3P0
        u860SpNSNB31ryme7iNMvr2SywFksMOhZQ==
X-Google-Smtp-Source: ABdhPJw827MMCfjHO5tREMd5lvTIyVyaY/E/zAR1UZrRlzV2fPpwtrYNm6+GPu1nXkXtfHxrIbXe7A==
X-Received: by 2002:a5d:5912:: with SMTP id v18mr4386982wrd.14.1618664022012;
        Sat, 17 Apr 2021 05:53:42 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v4sm11594529wme.14.2021.04.17.05.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Apr 2021 05:53:41 -0700 (PDT)
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
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 07/12] describe tests: convert setup to use test_commit
Date:   Sat, 17 Apr 2021 14:52:40 +0200
Message-Id: <patch-07.12-683b3ba3dd9-20210417T124424Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.722.g788886f50a2
In-Reply-To: <cover-00.12-00000000000-20210417T124424Z-avarab@gmail.com>
References: <cover-00.16-00000000000-20210412T110456Z-avarab@gmail.com> <cover-00.12-00000000000-20210417T124424Z-avarab@gmail.com>
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
2.31.1.722.g788886f50a2

