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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A9FC433E6
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 12:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E530564E00
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 12:05:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbhBPMFF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 07:05:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbhBPMCH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 07:02:07 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B33C061356
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 03:58:28 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id v15so12588315wrx.4
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 03:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JRVXdrboUjE/EsVbannzrSaGrJr2YVWjENyy6LHMI5w=;
        b=aBgUtUIM6JKLTc4ZbCfJ1sZJ1wtWBvk5pxSGa13W2J3W4st4mG58y+kyXBMT/0nnD6
         OUyfl6QlLDDEGwxIaGyQNT385iEvFiU/93CGMAQ+iHYnlGQ778h38QsiPPWEz2/gtu46
         Ok+bLkCz1AH0Py7Mob5HUwrfoS9UHKkK+SQuqreOXWhnP4gUrdeGO//34vl4ZK/1OG2A
         vjg+VxaNo2SgyzCZiTk2AfO7sYoR6Vcegs1Xt9Ru0XMfH/5X/H3ugJJei6DG0c/ZHKCu
         kWGgMyPOeP8n8EAYCLOvbqOgEdNyALDHzq2lzUACuUlvpBSlBoXMb3EYz6/52WDPwRXw
         ucGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JRVXdrboUjE/EsVbannzrSaGrJr2YVWjENyy6LHMI5w=;
        b=UNFeEB5v6CMv+99ZLggAb3Urjwh8twz9Y53i5bjXKT2eJarEp/r9Gs927fECuF+4pb
         71Nbi8vBwUnRME9OkPHdrSSLyAAXl0y+Qk+iZSsfe3R+XdgY2EI7s1e8b7q40JAE17sU
         vU+jALqhVTnhaZM+uO/UdEQpjJsya51yVqoUdkqWFBCZpl4jNYFayVKk0aQSRCc6AkXZ
         zw2GO10jD0B/5+16zipr5KVWWJcywwGUGB53JygZhTejwlK8jGzyx+pWA/W+pNhiIi0P
         dM8Bni5Bva/ANR0E7xIpyDeKrc5FoVO2k9EJ3rS2OARvczydvb0Xalnm7SlJ+i8PF97u
         T4LA==
X-Gm-Message-State: AOAM533gS4szX2t9pye+SlOz/v0drBwNluhFyBFRNW/nY/89A90buNwt
        Husg3hlTyJtJj2i7oQemFgsxMR/G3wA9zg==
X-Google-Smtp-Source: ABdhPJyZJo54yYiV+YswS2hw0td6+ZfjIlab1tM+iHyaNz7w1bC/BwjZw0IwPI04ZhMtC+LrDWK1WA==
X-Received: by 2002:a5d:47a8:: with SMTP id 8mr22797147wrb.180.1613476706802;
        Tue, 16 Feb 2021 03:58:26 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b2sm27968246wrv.73.2021.02.16.03.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 03:58:26 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 16/22] pickaxe -S: support content with NULs under --pickaxe-regex
Date:   Tue, 16 Feb 2021 12:57:55 +0100
Message-Id: <20210216115801.4773-17-avarab@gmail.com>
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
index dd1b5c72332..0bf50a2f595 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -78,12 +78,12 @@ static unsigned int contains(mmfile_t *mf, regex_t *regexp, kwset_t kws)
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
index 4b65b89e7a5..6ea1f02d142 100755
--- a/t/t4209-log-pickaxe.sh
+++ b/t/t4209-log-pickaxe.sh
@@ -201,4 +201,12 @@ test_expect_success 'log -S looks into binary files' '
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

