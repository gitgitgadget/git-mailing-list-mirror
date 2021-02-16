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
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACBC9C433DB
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 12:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E1FF64DEC
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 12:05:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbhBPMFV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 07:05:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbhBPMCS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 07:02:18 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B425DC06121F
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 03:58:31 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id g6so12554543wrs.11
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 03:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PMLwMttDyzOV/VladTE5mD5ZGr8Hhe4lxGWJPFdSRSM=;
        b=bxnjVTw5P5ULv8UAnLUK/cLnoVr5b41c1W5y8DmewVJBykhaqUSapVI1kJo/h5n3Qi
         i7bu9FHteeWAszws/nCG1HIV7SNjisrOhd8dN936vxgio9Cd0aGxHdzY7LVUcs9aZP+S
         ycw4v6tEW8zV+/2WT04FrisriV9Tm0x2MZqeJdx4dLLO2Ra/MNmZLOLzXsBlCW4GY0Xq
         gI/v2q4Ni+spmbX03OlAWcZ7h8vQx0X3DbZK1HmB4X5w3C7bM4TToS3npRKjPCksungW
         zCEEvLLs5CCSPCWHgA0Z7MzImgSAWu9ix7fQ6EIO5us5jgbCdSZOgo6/xqGQstJuq7Sm
         hkRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PMLwMttDyzOV/VladTE5mD5ZGr8Hhe4lxGWJPFdSRSM=;
        b=GY8ofK3ksoZu5AqzjjghHHnyYVOnPZihmU+8hB00D0+s/qjwVZObq79uKAroLWZ2pN
         98OD6lxEkLIYXnwWKoR6S2Z08HzCIALVhvSPTSA3HGvCzllcRKaVN20+zBUOyOQdJJ6x
         ZbtIx4VkdAeAyV6/KsPziFgxTTvN/YiXGD7FYkXkWP57lnIARNHuZhgdODTE8kLA9J0Z
         bbK8gnix/9GMv3Ob1SFke2Xji2cuF+8EYm6WpPKRUN1UWDG7nYGt8jeBef2W11lURwOB
         Eb0q5wwMvsO1QlmufxgF8VZxizH2HDB7hM5mJnb0XYG8MFchRpnYqv2g6aVTKcSziTuY
         Vsyg==
X-Gm-Message-State: AOAM532nmzmjsqDfDNtlL3yUtQ2JXqu83O/qCdLYWFT4dRqf5QgAdAA9
        x0+drkxrTN9AM9CCAmgjSc9rSjYVcHsJiA==
X-Google-Smtp-Source: ABdhPJzFDhkADxq2gm/ZJFmKt/4sDgaf8BQiwIlRwHXtUd3BccIPt64GHaDvUm9Dp88M/Rxnk+gqXw==
X-Received: by 2002:adf:ec89:: with SMTP id z9mr23311615wrn.410.1613476710205;
        Tue, 16 Feb 2021 03:58:30 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b2sm27968246wrv.73.2021.02.16.03.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 03:58:29 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 20/22] xdiff-interface: support early exit in xdiff_outf()
Date:   Tue, 16 Feb 2021 12:57:59 +0100
Message-Id: <20210216115801.4773-21-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210203032811.14979-1-avarab@gmail.com>
References: <20210203032811.14979-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bridge the gap between the preceding "xdiff-interface: allow early
return from xdiff_emit_{line,hunk}_fn" change and the public
interface.

This change was split off from the preceding commit as it wasn't a
purely mechanical addition of "return 0".

Here we want to be able to abort early, but do so in a way that
doesn't skip the appropriate strbuf_reset() invocations.

The use of -1 as a return value is consistent with the rest of the
xdiff codebase, where doing so signals an abort or error that'll
propagate up the stack.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 xdiff-interface.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/xdiff-interface.c b/xdiff-interface.c
index ef557dc4e63..d066442470f 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -39,7 +39,8 @@ static int consume_one(void *priv_, char *s, unsigned long size)
 		unsigned long this_size;
 		ep = memchr(s, '\n', size);
 		this_size = (ep == NULL) ? size : (ep - s + 1);
-		priv->line_fn(priv->consume_callback_data, s, this_size);
+		if (priv->line_fn(priv->consume_callback_data, s, this_size))
+			return -1;
 		size -= this_size;
 		s += this_size;
 	}
@@ -50,11 +51,14 @@ static int xdiff_outf(void *priv_, mmbuffer_t *mb, int nbuf)
 {
 	struct xdiff_emit_state *priv = priv_;
 	int i;
+	int stop = 0;
 
 	if (!priv->line_fn)
 		return 0;
 
 	for (i = 0; i < nbuf; i++) {
+		if (stop)
+			return -1;
 		if (mb[i].ptr[mb[i].size-1] != '\n') {
 			/* Incomplete line */
 			strbuf_add(&priv->remainder, mb[i].ptr, mb[i].size);
@@ -63,17 +67,21 @@ static int xdiff_outf(void *priv_, mmbuffer_t *mb, int nbuf)
 
 		/* we have a complete line */
 		if (!priv->remainder.len) {
-			consume_one(priv, mb[i].ptr, mb[i].size);
+			stop = consume_one(priv, mb[i].ptr, mb[i].size);
 			continue;
 		}
 		strbuf_add(&priv->remainder, mb[i].ptr, mb[i].size);
-		consume_one(priv, priv->remainder.buf, priv->remainder.len);
+		stop = consume_one(priv, priv->remainder.buf, priv->remainder.len);
 		strbuf_reset(&priv->remainder);
 	}
+	if (stop)
+		return -1;
 	if (priv->remainder.len) {
-		consume_one(priv, priv->remainder.buf, priv->remainder.len);
+		stop = consume_one(priv, priv->remainder.buf, priv->remainder.len);
 		strbuf_reset(&priv->remainder);
 	}
+	if (stop)
+		return -1;
 	return 0;
 }
 
-- 
2.30.0.284.gd98b1dd5eaa7

