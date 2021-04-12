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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C6EC433ED
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 17:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F40161278
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 17:16:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244186AbhDLRQy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 13:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244001AbhDLRQV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 13:16:21 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F88FC061348
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 10:15:49 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id s7so13616664wru.6
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 10:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n/IfZCF0giRLvTuPUDrR6YZEi7J3wdh185UD+7m6gXI=;
        b=PWG2gTe9cc6zLO7xmF6w9nfFNKNP9Aa53WpK+r+PWklSHdgQnavCYsTTwShpd18Cap
         vaKRF3PyNVr3G0OUFY0y/DztN8FGA4LN/QDoWLHz8CgahZMQOH177F0txEvV2GUmF8Gp
         qvNNXUATwg1RFobMc7xbrgOIbr+QwyplHnLRsIYRL0ULI/TZRAdOI4NCK/fjicCn/u0C
         jwWmjLtCILqzMRuu0oxShHy9CN5gjFdG9zkW1KD7pQ46MaGerrHAyxpkzvBfCWFNp0um
         5X4VFFhrCg2aBTqvcoUxYdbuuKlp5r3f+ZZWSDYVvaH0QpU1VPCAeMw5z0FFod1QcRSS
         q+HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n/IfZCF0giRLvTuPUDrR6YZEi7J3wdh185UD+7m6gXI=;
        b=lf70Kssj7v+VRpBPAbMUqY5HkPQ5Di/zWJU7oG0V5/WlMOame6pKh547fp5J9uuwpf
         PNBUDLDky8U0rA09TrcKUdJjpjCzXp0VOqKYc+VeNQPxL1KLTXB/k7n8skMBnJpFb/BM
         jwQSUxZN3Lp6povM309h7R3CFHd2HeXya+o6TuV2oA/V98dp+CoYHNW/ZxorESUpe+r3
         RMYpfaTTPuKHIUsQ3iViurQyy6G39mPoBWRGI3CIB1pruYvakNcjN8gKC3fagPkELo5x
         p/xcxoYYYYJEzinEpV6PAniEJ0bDmy6tzjBg8purIhAMZ90VzzDc0HVAAMcviTEs8lAi
         xM0w==
X-Gm-Message-State: AOAM531hSjKFnZ9PsWYHxKm9hzht7eFCu5kjQCAV52fDuEq7nrQsxbPK
        Ryjz9JNIIVXy4P8tcL07dyMIYOH+S+ImGA==
X-Google-Smtp-Source: ABdhPJwBsFuBDB+fyuoPRGQCj9wlea20kC04iRXxElKG5tMOUjZG/rlut5rI2TmwzPXMe0FYlDbm9w==
X-Received: by 2002:adf:dd50:: with SMTP id u16mr2356391wrm.380.1618247747995;
        Mon, 12 Apr 2021 10:15:47 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j1sm7828625wrr.33.2021.04.12.10.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 10:15:47 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 13/22] pickaxe: assert that we must have a needle under -G or -S
Date:   Mon, 12 Apr 2021 19:15:20 +0200
Message-Id: <patch-13.22-115a369d067-20210412T170457Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.639.g3d04783866f
In-Reply-To: <cover-00.22-00000000000-20210412T170457Z-avarab@gmail.com>
References: <20210216115801.4773-1-avarab@gmail.com> <cover-00.22-00000000000-20210412T170457Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Assert early in diffcore_pickaxe() that we've got a needle to work
with under -G and -S.

This code is redundant to the check -G and -S get from
parse-options.c's get_arg(), which I'm adding a test for.

This check dates back to e1b161161d (diffcore-pickaxe: fix infinite
loop on zero-length needle, 2007-01-25) when "git log -S" could send
this code into an infinite loop.

It was then later refactored in 8fa4b09fb1 (pickaxe: hoist empty
needle check, 2012-10-28) into its current form, but it seemingly
wasn't noticed that in the meantime a move to the parse-options.c API
in dea007fb4c (diff: parse separate options like -S foo, 2010-08-05)
had made it redundant.

Let's retain some of the paranoia here with a BUG(), but there's no
need to be checking this in the pickaxe_match() inner loop.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 diffcore-pickaxe.c     | 6 +++---
 t/t4209-log-pickaxe.sh | 6 ++++++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index 953b6ec1b4a..88b6ca840f6 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -132,9 +132,6 @@ static int pickaxe_match(struct diff_filepair *p, struct diff_options *o,
 			 oidset_contains(o->objfind, &p->two->oid));
 	}
 
-	if (!o->pickaxe[0])
-		return 0;
-
 	if (o->flags.allow_textconv) {
 		textconv_one = get_textconv(o->repo, p->one);
 		textconv_two = get_textconv(o->repo, p->two);
@@ -230,6 +227,9 @@ void diffcore_pickaxe(struct diff_options *o)
 	kwset_t kws = NULL;
 	pickaxe_fn fn;
 
+	if (opts & ~DIFF_PICKAXE_KIND_OBJFIND &&
+	    (!needle || !*needle))
+		BUG("should have needle under -G or -S");
 	if (opts & (DIFF_PICKAXE_REGEX | DIFF_PICKAXE_KIND_G)) {
 		int cflags = REG_EXTENDED | REG_NEWLINE;
 		if (o->pickaxe_opts & DIFF_PICKAXE_IGNORE_CASE)
diff --git a/t/t4209-log-pickaxe.sh b/t/t4209-log-pickaxe.sh
index 16166ffd3e6..3f9aad0fdb0 100755
--- a/t/t4209-log-pickaxe.sh
+++ b/t/t4209-log-pickaxe.sh
@@ -56,6 +56,12 @@ test_expect_success setup '
 '
 
 test_expect_success 'usage' '
+	test_expect_code 129 git log -S 2>err &&
+	test_i18ngrep "switch.*requires a value" err &&
+
+	test_expect_code 129 git log -G 2>err &&
+	test_i18ngrep "switch.*requires a value" err &&
+
 	test_expect_code 128 git log -Gregex -Sstring 2>err &&
 	grep "mutually exclusive" err &&
 
-- 
2.31.1.639.g3d04783866f

