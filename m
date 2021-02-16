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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F47C433E0
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 12:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B45064DA1
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 12:03:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbhBPMDf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 07:03:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbhBPMBm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 07:01:42 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7A2C0617AB
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 03:58:27 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id l17so8932138wmq.2
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 03:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RFo3ss8OWr5JLVp0LAYkvhjQUYHWtwVratxZZNBA5Ro=;
        b=OhYrhNXTbzH4+2cGkD8Jhvyovo8jbxfXd17KR0XVM0J5Mk/gDgFqnr4sqLcTevfG5c
         ND5bHpRC1F0rhk69B8KBIpFS1m+epdHR0NpFG2mj90SghobeZI0JG+uCQUkG86ma48bK
         40uXWb8oB7nGr4P9TJtsjvkf+pJW0SKI7zIITYojEO52Zz+xjIOKNB2RcSKwNJ3YXg/n
         CVa7W//KxLGU67k/YdL/TKb9e4uxpruiP/GpiNTVLkvsC4biK0A/TTo6k8qxTRRlo+gG
         ZCu/NvE+QKvvWVsirClhSx20d+pmhQzZlDPc04+oYRxjcm7bVg0uf0LN2JiQEfjJ+P3o
         2Pxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RFo3ss8OWr5JLVp0LAYkvhjQUYHWtwVratxZZNBA5Ro=;
        b=I2vmcuj3iTNkuoJFfQem3AEgjidh5rb2cxQ1q5fgXrF3RacRAGZxVVCOKBI8wqdZw8
         spKk3h1xvoSAKnGXOWqBORdvAx8W3nB2StLQieRl2llLTxGBhAe9gCKD073OQrLSUw79
         1p8UFeNgJmPxw307zIcndPHbcgxc34o5dCAdPPht+GDg/vnkOlAEjSlpyM083/6PCla5
         yUoq0sD08WwDcI7N1fNMap7Xd8m6OpscfYhlnfA16rM1HANNnOhZfADQ2yNJ5Li1YJpN
         cu6pDSPzIhNqxq8DuN0Kocs7jicCDOU2ZsemTHyq2+lSzc0xwYtqXuSnRU0hK2HMG71R
         ZyZg==
X-Gm-Message-State: AOAM531iPtXND3HsZQCA5IRRmU5dQzi5XYFJ/6iMTKofTPiBuoCo1M/I
        fA2U3qkpAU6GvAmHE6GX5IGvJ8UULtet1w==
X-Google-Smtp-Source: ABdhPJxVC8ZUzT5YZ6nm9YlTCUYoTbdxZAnHBS6d+2D1JjJDGoGl6QkRgDmYK+AP0PRdAj/YHyA0kQ==
X-Received: by 2002:a1c:9a12:: with SMTP id c18mr3072448wme.146.1613476705837;
        Tue, 16 Feb 2021 03:58:25 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b2sm27968246wrv.73.2021.02.16.03.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 03:58:25 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 15/22] pickaxe: assert that we must have a needle under -G or -S
Date:   Tue, 16 Feb 2021 12:57:54 +0100
Message-Id: <20210216115801.4773-16-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210203032811.14979-1-avarab@gmail.com>
References: <20210203032811.14979-1-avarab@gmail.com>
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
 diffcore-pickaxe.c     | 5 ++---
 t/t4209-log-pickaxe.sh | 6 ++++++
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index cff46f9f8f7..dd1b5c72332 100644
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
@@ -230,6 +227,8 @@ void diffcore_pickaxe(struct diff_options *o)
 	kwset_t kws = NULL;
 	pickaxe_fn fn;
 
+	if (opts & ~DIFF_PICKAXE_KIND_OBJFIND && !needle)
+		BUG("should have needle under -G or -S");
 	if (opts & (DIFF_PICKAXE_REGEX | DIFF_PICKAXE_KIND_G)) {
 		int cflags = REG_EXTENDED | REG_NEWLINE;
 		if (o->pickaxe_opts & DIFF_PICKAXE_IGNORE_CASE)
diff --git a/t/t4209-log-pickaxe.sh b/t/t4209-log-pickaxe.sh
index bcaca7e882c..4b65b89e7a5 100755
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
 	test_i18ngrep "mutually exclusive" err &&
 
-- 
2.30.0.284.gd98b1dd5eaa7

