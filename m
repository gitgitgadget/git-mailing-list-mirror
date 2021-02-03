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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BEA6C433E0
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 03:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BF5C64F74
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 03:29:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232613AbhBCD3A (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 22:29:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbhBCD27 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 22:28:59 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A86C06174A
        for <git@vger.kernel.org>; Tue,  2 Feb 2021 19:28:18 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id d16so22535844wro.11
        for <git@vger.kernel.org>; Tue, 02 Feb 2021 19:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lvIlAfOHHtOQZigGlWc5Wn4OnlJxmSPn0fTJAV64jaI=;
        b=bM+nInFvAEPiWzbfJO3qaYh+T3OBEEyvZ94uhvqfsz2DvNQc8bkexHdBP/4B8tdGyQ
         rxbQO+3qIIscoCMF+9fPz4OJo6DXtpdGAdHfcK4CTK94wbr7u2Q40h/XBzvzf1V0ip/K
         Ga/qRIkpjLlf6jhVoUZi2x2UVMnq18ZkD3yFW0LUmvUaG+TGXxcb+2XL5QepTyt5UNXq
         0Evs9kb8AqH64VwHcYUqE2UAwo5vqTHkhbu8EKvxLV+PNh7wb8DuKuTugGW6UKbQEgql
         v0wsisFRfFAcKvZaKdG9Whve2W+XPfeRHczB3DV3I1hSmqVVSwNmqAga1b2VgqLXwBwD
         LSFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lvIlAfOHHtOQZigGlWc5Wn4OnlJxmSPn0fTJAV64jaI=;
        b=Bft0zK1bhpEQwHqu5sKXEm1bl+dXee+xeYjR6WCN2CWvHqQGr2o2XbGNA50R7HBAtm
         zr7pNmsTteKIO9F3RTQkijoEPI32ohCCgWF8deJDTFhS7BYl+Y3sT/CXK3w6kyUazFwg
         gnxIZ4C4bSHrYCdYX4J1W4HrJdDHzBIjMuj4pBsy/4DYYgKujUWiHYN65hyQc3DIemz8
         YutcKKdvKMznuvtu+b1FyXuHf7SxL//xXwN2PkAvoX/IJDvTGtREDVnIMy0ViO1Mc2jl
         566dhB+Xvs6McH2BpHJwSjaoY5t0jmf/5XxEQwU6nOIeN68INJ02dlLwI0SJI3bDiBIx
         Melg==
X-Gm-Message-State: AOAM532CMVO/1+DE/CkhHrBoWtmEXE2nAsfUD2LxndoQp67cxJs7rXlA
        JzbzfhpldzIZGCne55QfEsJCRsUvdwYdww==
X-Google-Smtp-Source: ABdhPJy9fsKjdBCXzvLotQnDwJAPJ5G0pmTZ79jr3AbLfdygN8mW1b9Z/IDYooyCfCU25xXH0zwbgQ==
X-Received: by 2002:adf:d085:: with SMTP id y5mr1088581wrh.41.1612322897359;
        Tue, 02 Feb 2021 19:28:17 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c5sm971089wrn.77.2021.02.02.19.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 19:28:16 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 01/25] grep/pcre2 tests: reword comments referring to kwset
Date:   Wed,  3 Feb 2021 04:27:47 +0100
Message-Id: <20210203032811.14979-2-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210203032811.14979-1-avarab@gmail.com>
References: <20210203032811.14979-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The kwset optimization has not been used by grep since
48de2a768cf (grep: remove the kwset optimization, 2019-07-01).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t7816-grep-binary-pattern.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t7816-grep-binary-pattern.sh b/t/t7816-grep-binary-pattern.sh
index 60bab291e4..9d67a5fc4c 100755
--- a/t/t7816-grep-binary-pattern.sh
+++ b/t/t7816-grep-binary-pattern.sh
@@ -59,7 +59,7 @@ test_expect_success 'setup' "
 	git commit -m.
 "
 
-# Simple fixed-string matching that can use kwset (no -i && non-ASCII)
+# Simple fixed-string matching
 nul_match P P P '-F' 'yQf'
 nul_match P P P '-F' 'yQx'
 nul_match P P P '-Fi' 'YQf'
@@ -78,7 +78,7 @@ nul_match P P P '-Fi' '[Y]QF'
 nul_match P P P '-F' 'æQ[ð]'
 nul_match P P P '-F' '[æ]Qð'
 
-# The -F kwset codepath can't handle -i && non-ASCII...
+# Matching pattern and subject case with -i
 nul_match P 1 1 '-i' '[æ]Qð'
 
 # ...PCRE v2 only matches non-ASCII with -i casefolding under UTF-8
-- 
2.30.0.284.gd98b1dd5eaa7

