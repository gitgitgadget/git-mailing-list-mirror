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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B14E6C433E0
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 03:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FC8864F74
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 03:31:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232897AbhBCDa4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 22:30:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232821AbhBCD35 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 22:29:57 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF8BC06121E
        for <git@vger.kernel.org>; Tue,  2 Feb 2021 19:28:43 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id i9so3962535wmq.1
        for <git@vger.kernel.org>; Tue, 02 Feb 2021 19:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PpmAxMajR5Fe2IP18vjdQ8nz+92oklv9O7UGVSAlQZ8=;
        b=trgttQYv4Oj62MD6fYyCmcFBtASiXNcTD7E6/TkvnWBD7vXnLwTL10uDWzQ7nyc4a/
         7mSrc+xxCFQ5jPBs+cBtoYm97H7Nc4YO/Gx7k+CXULMgbb24q3wLgd4iL/T2B2+fUtqQ
         e0u+u5oPzPL8yBxV0SUQW6mL9oN4kCZxPLvaG/LIiVQf++OE3jHhZJke73cqgveDQXED
         kyAoZYD9mFjWv/nC/0LOiQg3blClwOGSaHwZjWU59eMSBbnYp+5Vsq1X0i5IY6kfoExF
         aonUc5QlmGzX0sLRiPNGPyKYjXi2ubjumtLtupDSpaWKyGlmqPxQS7TkbWhO81OAOd3w
         2poQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PpmAxMajR5Fe2IP18vjdQ8nz+92oklv9O7UGVSAlQZ8=;
        b=DJWSRbssz8BokpNz/GGBZYTEvK+ANJPZS+ekIHCGBSKnFh21HLegv5V6HbmJ/U9HE9
         jKgAJ8FUrYhszOeIq4/6In5V4+5/qB7rkWGlwBio+x5Gw/rZZKayQS77Qe3SbF7qu/HS
         4cZTf2UMDwk8yOwCdI7OyhEQdUIHNy5OetQyLw4XljcBxtcRpkNspEIeCPvvM1zrhM/W
         XQg9mw85vPGpG5v9u29QxzSza9UthWFop/h3A+k3/uSaP8Tu+Xn+mAWL4ppCr1aSsO+2
         GJx0UArb/5Bz3SMqtv9ozS6I0oCtxJ01PuXsfU25XUt5ZMHrA48OJfH7DBABZj2kEZMw
         lLQw==
X-Gm-Message-State: AOAM531+6IHsxwPLp8WoNURj5/rK8WBwzFCYrhI//CWPzVhdOfM0if+G
        cAAsxF4y+oE/oTmGkW0t7jR6mEiLhbGGFg==
X-Google-Smtp-Source: ABdhPJzU7DJj3jQnQufLuCJirk1/74ZPBO48C4njvGNLTUNhh1oT5ihxhPDJqPzS1eaJ4dBlzSlRCQ==
X-Received: by 2002:a1c:2e04:: with SMTP id u4mr845333wmu.79.1612322921911;
        Tue, 02 Feb 2021 19:28:41 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c5sm971089wrn.77.2021.02.02.19.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 19:28:41 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 24/25] xdiff-interface: support early exit in xdiff_outf()
Date:   Wed,  3 Feb 2021 04:28:10 +0100
Message-Id: <20210203032811.14979-25-avarab@gmail.com>
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
interface. This change was split off from the rest as it wasn't a
purely mechanical addition of "return 0".

Here we want to be able to abort early, but do so in a way that
doesn't skip the appropriate strbuf_reset() invocations.

The use of -1 as a return value in the xdiff codebase for early
return, as we'll see more of in subsequent commits.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 xdiff-interface.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/xdiff-interface.c b/xdiff-interface.c
index ef557dc4e6..d066442470 100644
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

