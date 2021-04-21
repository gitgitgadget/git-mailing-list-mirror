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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A6C3C433ED
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 10:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AB0E61427
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 10:15:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239174AbhDUKQJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 06:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239112AbhDUKQA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 06:16:00 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD828C06174A
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 03:15:25 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id g9so24737888wrx.0
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 03:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=buGRongDfK7k5Jr5C0xH8xke+/6m3NX0wsRug/SUJyg=;
        b=OUbBx5s8Wy++4Xn51qXHuKKHTlBHghEpHWQmgZrruwUjRswLUgGQPLNEcZL3yqj6Pk
         DulzLoaCOYqBo3Kvap/J3AVAKIjLZzGB/BDhnysj3fwhZrL6vHbbeaLeygZv1fij5+T1
         v1kqkIiapcAhK9xxrWRkEHQMHyKZKIFLudjF6WFODguBYWHSYcG0eBo4qOsGYchWbteO
         gQaezv9JUELjUwEOhugg47RQpsdDcAk5E6mIhbj6AxryL4cjwi8e+3gVZ5ilkbaSFS39
         FlUq5b3LQ9NJ2BHXA99buYZzeu7BBVZDbjnDZSyh0NQWqkJ8/WiQ7K5XpSkrUzjHlUQp
         pFiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=buGRongDfK7k5Jr5C0xH8xke+/6m3NX0wsRug/SUJyg=;
        b=pSX4z0Ypz+ijBbE2IMV+Ion7Tj/SZqdR6z9nn/hno7MjuyTK0MiLXt6OmxJuMo2oN2
         9jOqYeT/DZoRbQ6VL4hA42zRPVYKSD2bLrfRzp8S/IH9Z62jTeuNow58i1vpTM6bvrNc
         kxptwtIAHRJ1/DM8VrbUYN8bfZxM2HYhYLulYbfWTbTGK2x3dSY1Jou4G0u+5fz+OD0M
         AuLTaF5nd5dM6TQO43QGkzwdWZfKp2uZdKKVelf3U6wPutiWT4gayiUpGH3Ot86B4PYV
         9JVF7/KjBeW4L+WRYD8VhH5CQzPo1NXT7Ieto6xjCLL/3BZesublqxhoj0HvFmtmxV6x
         y5dA==
X-Gm-Message-State: AOAM530isM7i+5xsEASIM/ZxEIcnCxK1MNtumOXRkj6S5S0BQIIW7KH8
        sCucnrqVw0oGAA+FQERtmbfTVnN0QVFr4w==
X-Google-Smtp-Source: ABdhPJxwziGYxyC8a1NALsPpPJEHZg5/2qsZhRnAf+bEQgklXa/Z0cTMhp1cDVPuolivOEBj2MtkbQ==
X-Received: by 2002:a5d:63c9:: with SMTP id c9mr26524170wrw.425.1619000124343;
        Wed, 21 Apr 2021 03:15:24 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i9sm1843084wmg.2.2021.04.21.03.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 03:15:23 -0700 (PDT)
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
Subject: [PATCH v4 06/11] describe tests: convert setup to use test_commit
Date:   Wed, 21 Apr 2021 12:15:11 +0200
Message-Id: <patch-06.11-981fc43ee6-20210421T101156Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.721.gbeb6a21927
In-Reply-To: <cover-00.11-0000000000-20210421T101156Z-avarab@gmail.com>
References: <cover-00.12-0000000000-20210420T121833Z-avarab@gmail.com> <cover-00.11-0000000000-20210421T101156Z-avarab@gmail.com>
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
index e89b6747be..88fddc9142 100755
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
2.31.1.721.gbeb6a21927

