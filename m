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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD50C433E0
	for <git@archiver.kernel.org>; Sun, 28 Feb 2021 19:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB07F64E83
	for <git@archiver.kernel.org>; Sun, 28 Feb 2021 19:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbhB1Tz7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Feb 2021 14:55:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbhB1Tz5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Feb 2021 14:55:57 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78140C06178C
        for <git@vger.kernel.org>; Sun, 28 Feb 2021 11:54:40 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id bm21so5471323ejb.4
        for <git@vger.kernel.org>; Sun, 28 Feb 2021 11:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ODtayxdMVi79Vt1iO5w7cyNJZqgk9ZDp8pX6KUeeKAM=;
        b=PtwppVOGPYDgnnzLsbu/dZt7eZyRYbhwHa4J9L9YYyzzNj6ALDXU/h4Wdt6rD1OEF+
         QZGuch6L2fn82OinR5RdAe/OOT3tUHvgYNwh7mxhyW0vUm74m4F0Ju76SpF1hd+8v5Mf
         Rshxzk2naTbCgLJxk3k9R1jkDBKn7GEF+i+dC10hMT4rPHDEAveq7S1D52tWkosJfM/Q
         SyxTwEKqIvRHk2/Ndh+liR4nFAEwOEhWA3nc7fOLRrw7n+PzaM3AogEyUCqvTkdojmmX
         w53djqYXxEUVzd7hra5ees+dWQkswPQBof8DOAb98uxzpeR7bIe3sFpVVpo3koKTb6nJ
         qSug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ODtayxdMVi79Vt1iO5w7cyNJZqgk9ZDp8pX6KUeeKAM=;
        b=uFHOStIyeYXvC3C/BCaKoB6lCZQVGP+wrm5pXev7TOQH6mS2XrkZRcMRcaORTi8ekO
         hZNRE2DJiRsbEhS5fmHuz4G2cNNhJ8ib3ZKivwogKMTG/gXjAusm2fnQelV5iDbsz9y+
         K282cuALN+vlr+NqvQ6o2Q3DzbkPs0dKhXZym6kgK4TTfK4cKmBnXrswK1FdZD/3PKFI
         kPuGrEovjVX/tlIb4kqn0NVMjtHHFEqYczYqzNrYkyfT9QkUo3M4faMeVEL9ghm8kTCX
         rvjmurX9OZneej/aEWqJ5MFsCyBlh4GxPXuDY6s4TO/rF0nqO0u13tcYt6SA+tIuUVrH
         TiSQ==
X-Gm-Message-State: AOAM5313Ugv5k/JRiEW2KSFf+EH67ENjtc8nwBbe99/Fby1pIClckyuf
        mvnYXg471L/ccl60ndiLCbFXdFZnsONOdQ==
X-Google-Smtp-Source: ABdhPJx91RxqHpZq4Ysb4hhdlPzWu/J+xiGZO4Z5FOtnB8yvC84BpaIegRv/fpc+BLYCosZe2m+rSw==
X-Received: by 2002:a17:906:f88a:: with SMTP id lg10mr12972896ejb.39.1614542078931;
        Sun, 28 Feb 2021 11:54:38 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n2sm11295554ejl.1.2021.02.28.11.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Feb 2021 11:54:38 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        Benno Evers <benno@bmevers.de>, Jean Privat <jean@pryen.org>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 06/10] describe tests: fix nested "test_expect_success" call
Date:   Sun, 28 Feb 2021 20:54:10 +0100
Message-Id: <20210228195414.21372-7-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc0.116.g45ec00aa00
In-Reply-To: <20200223125102.6697-1-benno@bmevers.de>
References: <20200223125102.6697-1-benno@bmevers.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a nested invocation of "test_expect_success", the
"check_describe()" function is a wrapper for calling
test_expect_success, and therefore needs to be called outside the body
of another "test_expect_success".

The two tests added in 30b1c7ad9d6 (describe: don't abort too early
when searching tags, 2020-02-26) were not testing for anything due to
this logic error. Without this fix reverting the C code changes in
that commit still has all tests passing, with this fix we're actually
testing the "describe" output. This is because "test_expect_success"
calls "test_finish_", whose last statement happens to be true.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t6120-describe.sh | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 8dc76f8e9e..ae801c740b 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -470,7 +470,7 @@ test_expect_success 'name-rev covers all conditions while looking at parents' '
 #  o-----o---o----x
 #        A
 #
-test_expect_success 'describe commits with disjoint bases' '
+test_expect_success 'setup: describe commits with disjoint bases' '
 	git init disjoint1 &&
 	(
 		cd disjoint1 &&
@@ -483,19 +483,22 @@ test_expect_success 'describe commits with disjoint bases' '
 		git checkout --orphan branch && rm file &&
 		echo B > file2 && git add file2 && git commit -m B &&
 		git tag B -a -m B &&
-		git merge --no-ff --allow-unrelated-histories main -m x &&
-
-		check_describe "A-3-gHASH" HEAD
+		git merge --no-ff --allow-unrelated-histories main -m x
 	)
 '
 
+(
+	cd disjoint1 &&
+	check_describe "A-3-gHASH" HEAD
+)
+
 #           B
 #   o---o---o------------.
 #                         \
 #                  o---o---x
 #                  A
 #
-test_expect_success 'describe commits with disjoint bases 2' '
+test_expect_success 'setup: describe commits with disjoint bases 2' '
 	git init disjoint2 &&
 	(
 		cd disjoint2 &&
@@ -509,10 +512,13 @@ test_expect_success 'describe commits with disjoint bases 2' '
 		echo o >> file2 && git add file2 && GIT_COMMITTER_DATE="2020-01-01 15:01" git commit -m o &&
 		echo B >> file2 && git add file2 && GIT_COMMITTER_DATE="2020-01-01 15:02" git commit -m B &&
 		git tag B -a -m B &&
-		git merge --no-ff --allow-unrelated-histories main -m x &&
-
-		check_describe "B-3-gHASH" HEAD
+		git merge --no-ff --allow-unrelated-histories main -m x
 	)
 '
 
+(
+	cd disjoint2 &&
+	check_describe "B-3-gHASH" HEAD
+)
+
 test_done
-- 
2.31.0.rc0.116.g45ec00aa00

