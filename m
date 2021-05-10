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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E58C43461
	for <git@archiver.kernel.org>; Mon, 10 May 2021 15:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F94E6023E
	for <git@archiver.kernel.org>; Mon, 10 May 2021 15:15:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236242AbhEJPQG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 May 2021 11:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237161AbhEJPNo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 May 2021 11:13:44 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02FD4C0515EE
        for <git@vger.kernel.org>; Mon, 10 May 2021 07:32:20 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id n2so16926588wrm.0
        for <git@vger.kernel.org>; Mon, 10 May 2021 07:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/ZYoO5Y3QwItiLgL0Av77LseVacSPQez5LRTI4y2tOw=;
        b=jEq6lo8roY1sEKpe21AIe9Th9snI7myjVebVhAQgKEUfKblaYDvIvozioH2BuUz7BE
         a8r71DqgZgMsVhW3u/3waU3tQzo2r3ollpVx+ddK5DIi+Y9Sw69rLriOFFuZHHiA3eSD
         GfSbPfBA1ufEGpugyfdT3eVWVYbw6k+jtAgOygo7r9MEXB+TSwQScebzGMSmAgWhM9we
         dPaJNGVT8qpyPgo9BxKFRKAsp1pUFKdXdNRgTzDNoX/vcUFiRiSbbawPF8US4AFDfZo0
         yI+uSkKp6/M5w9CBJzwk5PX0jT/OjDeaaUL+I+m9YP9ifOW6gDAxxlAckOP02VYRVL28
         4VAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/ZYoO5Y3QwItiLgL0Av77LseVacSPQez5LRTI4y2tOw=;
        b=V1hl/ak/QOhFqmR6/h5LpwjtxdoVGf4NULYV3ZlVG2VTqTJIrwXWGEhRmVlkQSHZ8U
         4T7l+QebbWVssK9MGztdIgf9xiytNm60wdJIV44iR8LE1NHQwSU6mNq7geECmfSTDtDu
         JyENkc3U4Mm9X1OZSbPie+ALUT03s9VuO8P8TEQct9yNDgln5hDiJmM0nDw0P2TlUlYZ
         Zxov/I6siq4YbXpZRkDZ+lt9FtUFupYRyF0OGmli8Xr9hLo4eZaPKNxPBYj43w0PtmoR
         vOzmEiOMWBlEyqETLhlkvI7o0fYwfSAB7CgMPnsZpOa2aINkEgoEOZjJF5anr2qM1DZy
         HO1w==
X-Gm-Message-State: AOAM5335UnEtNvUZDYVA2/+6q9NI6HoPF1j5fvkpwuJWY3J01xGKpxDN
        essaEb+/a2BflAAa3OcJPiRAlp405vQmkQ==
X-Google-Smtp-Source: ABdhPJzATLW9jH0RmD+E67TDd//qGM9ssi6ZCDLulvH3LzSh6LKPvT4CUmYKEVtZKBHsg8VBUSTjFg==
X-Received: by 2002:a5d:610a:: with SMTP id v10mr30515580wrt.399.1620657139278;
        Mon, 10 May 2021 07:32:19 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q10sm22421839wre.92.2021.05.10.07.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 07:32:18 -0700 (PDT)
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
Subject: [PATCH v6 06/11] describe tests: convert setup to use test_commit
Date:   Mon, 10 May 2021 16:19:05 +0200
Message-Id: <patch-06.11-07e8b63596b-20210510T141055Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.838.g924d365b763
In-Reply-To: <cover-00.11-00000000000-20210510T141055Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20210423T072006Z-avarab@gmail.com> <cover-00.11-00000000000-20210510T141055Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert the setup of the describe tests to use test_commit when
possible. This makes use of the new --annotate option to test_commit.

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
2.31.1.838.g924d365b763

