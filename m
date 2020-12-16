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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8131C4361B
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 18:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B64A22342C
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 18:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732271AbgLPSwK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 13:52:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732260AbgLPSwG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 13:52:06 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A51FC0619DD
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 10:51:02 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id m25so50938099lfc.11
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 10:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F7skkKHM5R05UGdkMu1617woWQOZ5h6BpD7foIYbeG8=;
        b=DUD5SnLTAzGR5KYNFqM4o6EZd7xSq2lJSWAXMfZ7+Zy1Km/ShFXwe8Epq0xF2z9av7
         zTq+0qnFT8tasNK4mvjzv2y6XYLQsXHBA2zWKYBkrrvfJ8CIt6YLHwHfJ99drXXCwFfm
         fFJCBAncT7JMgJtxohx8+aGGuqTRbJu9mmUDZOzvzEvIOhk2LGZ4rP0NbVpcMQl2fRj1
         ufYPA/NwUE0Ot1b3Wl4U/5TAFpAlPF0S/CpLRtNLyO9r6x6ubD8fk+c0nJveBatVM576
         YEFYBi6PUg+4tdSZBRxHMT88ewjSPIP3napqu/TekCXLKnMQfm36yt6bfOpxLjoGOrTO
         W/Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F7skkKHM5R05UGdkMu1617woWQOZ5h6BpD7foIYbeG8=;
        b=YjxwBVanPfZMl9FRlUhXKcd5IHXGcBCgiOHrdZ5D8DHpnAsDDeWacy0wIU2L7HyzwH
         nsELx8m7ylM2kPcZDxSb7qnipJpu37gpUOQoBuyLdYbATOcutY5I3kBIFdeDx7fgRYsq
         IVTQq9WWqJsSk0EYIgXareb3pGxGug4vszbKWG+f4JVqmOOpKqVnoNOlfkWL3X/kTEEq
         wN3jByph/htg/TjLFSA9++HLDTVftnZG4+NI9ZYzmGEAF6DVI4YzlS46xmFeSCsDD3aw
         Czos102Xq1GSxjNu4WCEgALLfTUDH+7nc2uhFi76S0an4VelOW4nOkxQ+/BDi1T1hlsl
         rW7A==
X-Gm-Message-State: AOAM530BEFQzv0/GNEvoTEplAd+62Jk6JzgQ4Cgzim4dYtciGlN81P+R
        B19qS1nSh/SY2e4ieTa7da0=
X-Google-Smtp-Source: ABdhPJya9kQPg/zFX94g+NdE8TrAneCk1T9oGgZueiapSijnPrSFM7U7LAvNauIrLm9uSkUiRURNbQ==
X-Received: by 2002:a2e:2a86:: with SMTP id q128mr15013825ljq.158.1608144660033;
        Wed, 16 Dec 2020 10:51:00 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id 197sm313871lfe.158.2020.12.16.10.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 10:50:59 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v2 30/33] doc/diff-generate-patch: mention new --diff-merges option
Date:   Wed, 16 Dec 2020 21:49:26 +0300
Message-Id: <20201216184929.3924-31-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201216184929.3924-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
 <20201216184929.3924-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mention --diff-merges instead of -m in a note to merge formats to aid
discoverability, as -m is now described among --diff-merges options
anyway.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 Documentation/diff-generate-patch.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/diff-generate-patch.txt b/Documentation/diff-generate-patch.txt
index b10ff4caa6c5..2db8eacc3ec7 100644
--- a/Documentation/diff-generate-patch.txt
+++ b/Documentation/diff-generate-patch.txt
@@ -81,9 +81,9 @@ Combined diff format
 Any diff-generating command can take the `-c` or `--cc` option to
 produce a 'combined diff' when showing a merge. This is the default
 format when showing merges with linkgit:git-diff[1] or
-linkgit:git-show[1]. Note also that you can give the `-m` option to any
-of these commands to force generation of diffs with individual parents
-of a merge.
+linkgit:git-show[1]. Note also that you can give suitable
+`--diff-merges` option to any of these commands to force generation of
+diffs in specific format.
 
 A "combined diff" format looks like this:
 
-- 
2.25.1

