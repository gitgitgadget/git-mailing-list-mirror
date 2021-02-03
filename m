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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB37C433E0
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 03:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA10B64F74
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 03:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232901AbhBCDaP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 22:30:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232774AbhBCD3r (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 22:29:47 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9235C0617AA
        for <git@vger.kernel.org>; Tue,  2 Feb 2021 19:28:31 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id m13so22583616wro.12
        for <git@vger.kernel.org>; Tue, 02 Feb 2021 19:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D8+JZQXqQka/CJgMN3EaC0muUWsOTtNJFtBD/B+IqQg=;
        b=Df6Sg/6P7yDdXbgORagdbEDYqc7TyosYxiXTLQWmP/tmvNOR6lP3U6kOrgSCT1AJ0z
         sgwGdxybSFUhD5hrc6lIziiWNb6t41upcV1yp2azXrpYUXfq35WLWcPaGNwCOgP6Niv/
         qGobsBRkliNpknew/1aYjGIw7o3iWbL/B7rVjnQIjrOXCaOZnztOurG6mFUGnscDdfRg
         xxy/LVNnDWYXfQOsvwQiq2LZ1JU4oqx3tPhrjjiRaEH4MyJaWvQwXsFeL/JGt512i1H/
         GufupY7yeH+Yu/YBiERb9X69aPHTNhr08GZ6Yq1U9tvSdHd6QtGG4hG3vefoR1lvaSWE
         Qy1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D8+JZQXqQka/CJgMN3EaC0muUWsOTtNJFtBD/B+IqQg=;
        b=e8Bp2fZhToMfJ4VhKKPQi7fPy9zc2isU1RgBcU66/76t8n67WHSfHL+S9dr7rFYuuy
         0eOH45VZLNL679O74X85adw4WiSxSDotTG8gLBQoqeTmysxpu/z33KJZreR77ezo8hl3
         aN3p7IFL4trCJoaF6cEXP42xOw6jSjlIu50Ag+Xn3D7RT6+yyGe60lKl2appGrfRuqH+
         Im/aOd2xcPH8YEJVaEPpf5IRlVOcoXDEm8ErYHShcmDk3MwhNV95tU7mFEQdMqd0Mk/I
         aO/D1G8RWPx8Sr6PcL3oXUg4+a0ijc/LEblyrkS07zVYMeVY/TC2EXcgI4yfFprY512b
         aA2A==
X-Gm-Message-State: AOAM531HuYtjsY9YkzdNRbLikIALK63+BUaTXxqi8srgo2YxqN4Wwj9B
        UwGqL+4115vtGDQrcgBwku81tsCFY9AkQA==
X-Google-Smtp-Source: ABdhPJxdu9+Xi7EZduw2SRrCTHmsB8bAzNo16GlJ1XCKJD4iw3Egjx5fIlwz0TVKKpvOz6Isk1zZPQ==
X-Received: by 2002:a5d:4c4f:: with SMTP id n15mr1092494wrt.124.1612322910367;
        Tue, 02 Feb 2021 19:28:30 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c5sm971089wrn.77.2021.02.02.19.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 19:28:29 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 13/25] pickaxe -S: support content with NULs under --pickaxe-regex
Date:   Wed,  3 Feb 2021 04:27:59 +0100
Message-Id: <20210203032811.14979-14-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210203032811.14979-1-avarab@gmail.com>
References: <20210203032811.14979-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a bug in the matching routine powering -S<rx> --pickaxe-regex so
that we won't abort early on content that has NULs in it.

We've had a hard requirement on REG_STARTEND since 2f8952250a8 (regex:
add regexec_buf() that can work on a non NUL-terminated string,
2016-09-21), but this sanity check dates back to d01d8c67828 (Support
for pickaxe matching regular expressions, 2006-03-29).

It wasn't needed anymore, and as the now-passing test shows, actively
getting in our way.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 diffcore-pickaxe.c     | 4 ++--
 t/t4209-log-pickaxe.sh | 8 ++++++++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index a9c6d60df2..208177bb40 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -82,12 +82,12 @@ static unsigned int contains(mmfile_t *mf, regex_t *regexp, kwset_t kws)
 		regmatch_t regmatch;
 		int flags = 0;
 
-		while (sz && *data &&
+		while (sz &&
 		       !regexec_buf(regexp, data, sz, 1, &regmatch, flags)) {
 			flags |= REG_NOTBOL;
 			data += regmatch.rm_eo;
 			sz -= regmatch.rm_eo;
-			if (sz && *data && regmatch.rm_so == regmatch.rm_eo) {
+			if (sz && regmatch.rm_so == regmatch.rm_eo) {
 				data++;
 				sz--;
 			}
diff --git a/t/t4209-log-pickaxe.sh b/t/t4209-log-pickaxe.sh
index 21d22b2a18..bd42848871 100755
--- a/t/t4209-log-pickaxe.sh
+++ b/t/t4209-log-pickaxe.sh
@@ -139,4 +139,12 @@ test_expect_success 'log -S looks into binary files' '
 	test_cmp log full-log
 '
 
+test_expect_success 'log -S --pickaxe-regex looks into binary files' '
+	git -C GS-bin-txt log --pickaxe-regex -Sa >log &&
+	test_cmp log full-log &&
+
+	git -C GS-bin-txt log --pickaxe-regex -S[a] >log &&
+	test_cmp log full-log
+'
+
 test_done
-- 
2.30.0.284.gd98b1dd5eaa7

