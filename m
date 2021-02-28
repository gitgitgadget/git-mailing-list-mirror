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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09094C433DB
	for <git@archiver.kernel.org>; Sun, 28 Feb 2021 19:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF2F864E04
	for <git@archiver.kernel.org>; Sun, 28 Feb 2021 19:55:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbhB1Tz6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Feb 2021 14:55:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbhB1Tz5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Feb 2021 14:55:57 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90A6C06178B
        for <git@vger.kernel.org>; Sun, 28 Feb 2021 11:54:39 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id r17so24266897ejy.13
        for <git@vger.kernel.org>; Sun, 28 Feb 2021 11:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kEDHlpFEI6HfYPVYZS2kjnaIu5Ec4YGRWwMaWdRKf0c=;
        b=BdlSIqMDKe54faOh7cwpQqbsdb3WOmrspONeQ6GafDuVrDN5rJdLANLO7NacHXvws/
         gTiE/XasQsotUz877fitOJferHYX0he4G1f2GZZvK6xlXd6MgkVIUBbibpCWBTDplV8d
         TRX/bSeaPBl7HauE7A1tQpd8vekGrZKUiFwS/2CsepwWiiXQju3fN3mvS68me1f1fqIR
         fLod6ILQjhfJS9yi18JdmIIt5VGoCGQdlOQzmbqgrJ4cmLK03QsECb1+4eLP3ohS5CAm
         oe8b65yNgTZlCKA/JVY3H8X+0hUoXDsIriS4OhPlWUkC0CtvBrFICP8RjE8LSjxi5bYM
         8zRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kEDHlpFEI6HfYPVYZS2kjnaIu5Ec4YGRWwMaWdRKf0c=;
        b=ly5QDjSej3xZUtuKUvAMSpnem8tFTVo0T+4ux8EE7PB9+gepCbKW4YnPceZfKVD17x
         8CHhHK7+7wPIqW2tm+4AE2Kay3A1a0XN/v9Y2U3oCULhj6m659OppLxtEeUQnSct8wds
         eENYZpZX5yQySgziM2bXFo6S316UTAZ/PGDsrM2KkYzJPEQsT+AS/rRElZdBK+y2o6+3
         tbgEI/TFdqVSb7IM9M/cU9QF92zFma2RxdW1Qricp/O+tBuL06Vf9LJP0F3a0q4Nlg5b
         lnUSArKEo4jk+RZ/mU5qxJlk158v+di5kyyCmY1Uiw8sOONKNcwk5x8XY4NVufCoqIp9
         6eBA==
X-Gm-Message-State: AOAM5325exYvdPg0Kt5laG9XoW3aLAOqs72yAgeFePeU/JYiDCmMbbn7
        DG7ln12Uph2DQBhX3/XdLT/7UO+avmRtNw==
X-Google-Smtp-Source: ABdhPJxtQnnOnvb41jhidGiOHws6ng/Bb5Atr3ywNOfMLe4HpezycPps16737YY3GJbl0C2YcfbukQ==
X-Received: by 2002:a17:906:600f:: with SMTP id o15mr13114604ejj.76.1614542078286;
        Sun, 28 Feb 2021 11:54:38 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n2sm11295554ejl.1.2021.02.28.11.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Feb 2021 11:54:37 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        Benno Evers <benno@bmevers.de>, Jean Privat <jean@pryen.org>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 05/10] describe tests: convert setup to use test_commit
Date:   Sun, 28 Feb 2021 20:54:09 +0100
Message-Id: <20210228195414.21372-6-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc0.116.g45ec00aa00
In-Reply-To: <20200223125102.6697-1-benno@bmevers.de>
References: <20200223125102.6697-1-benno@bmevers.de>
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
index ef70c695be..8dc76f8e9e 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -30,64 +30,32 @@ check_describe () {
 }
 
 test_expect_success setup '
+	test_commit initial file one &&
+	test_commit second file two &&
+	test_commit third file three &&
+	test_commit --annotated-tag A file A &&
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
+	test_commit --annotated-tag B side B &&
 
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
 
 check_describe A-8-gHASH HEAD
-- 
2.31.0.rc0.116.g45ec00aa00

