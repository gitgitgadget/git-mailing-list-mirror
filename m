Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC9B6C433F5
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 14:47:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378327AbiBUOrk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 09:47:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378300AbiBUOrR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 09:47:17 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A692F5596
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 06:46:54 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id d3so11853219wrf.1
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 06:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=74RcGAtf/M5wljt+DWF/2V0kyvyrPbZpV5I45HW//EQ=;
        b=nKlVhZvYpZczDpyefRrWy10r0gzJ4GPwu8fEv1dtyav58Vie3gyr9KATb+/YPEgnDg
         JG7slw7zBzlGu75dkRJNA7aV+6akhyZEp0Yuupwnu+1OS5FmaY5zav7WJubwdzx0zjcR
         +b6CFk2eKYiYUiIHy9aSkEqd1RhgOru53X7zxkR6ITvfRALQACycU91U4zOf42ZhlzlG
         peIaZ13sIMj5Nd7aO1ot33XBp0IfFsc2RtC897RaYIRwBMP5zsbmfxYJhPfpHa/z3T67
         Ryfg36ir+XdDfZ/tnam2D5jlZm4I3nde5+xWXqb7wvKTrAIPWKVdVmHXLcC2cDf3GC/I
         2mug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=74RcGAtf/M5wljt+DWF/2V0kyvyrPbZpV5I45HW//EQ=;
        b=aRRGiEp101e551PkcP2pCJUlM8B7xxbqUjxRvz44u5iiJAoE1E5vTY6hWVAQ+JQKQG
         uAbsMQTBScBvEHTAIv94TXTaMooBEnTC73f/fDDU1ICVDWiTe1aX+r+BpPyVR5Yv74Ui
         D76saEJn5BG9PMws7pnK/P7HFFv2ASUrX/2iXbrXv1AvgmnJdm+PQz4DRN8vg+n8kPjJ
         mFYh9IE3XzxHqgZLU9vFJSj78c0nC8yqNOYKeEVjMfKK5XamEtIsrTdS1L8UH00Dbbn0
         +KRyqo/umyx2xd2gdkTUq7bOd7LI3SF38Sn7f7aTyUdD//h3lVZHmNfpVQvBbJMEJNe7
         REKw==
X-Gm-Message-State: AOAM5337jNs8hfGKytZo2tJZBvToEoYdeXtb5ZCPFxcrHLX+2869owxL
        hCW63CuiWBNtAxcQcV0TDioFO7rEQrMLQg==
X-Google-Smtp-Source: ABdhPJxZL0uiHEwrH2fu93Do+D1Zpw4o0hHA8UvkriFT1cz1BkeuC4L2KLAsHsQlrOzVsHwpvpJ8iw==
X-Received: by 2002:adf:fa0d:0:b0:1e3:f7b0:1037 with SMTP id m13-20020adffa0d000000b001e3f7b01037mr16323813wrr.188.1645454812990;
        Mon, 21 Feb 2022 06:46:52 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r14sm25071094wrz.84.2022.02.21.06.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 06:46:52 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Lars Schneider <larsxschneider@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 06/25] CI: don't have "git grep" invoke a pager in tree content check
Date:   Mon, 21 Feb 2022 15:46:18 +0100
Message-Id: <patch-06.25-59e4f41e86c-20220221T143936Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1132.ga1fe46f8690
In-Reply-To: <cover-00.25-00000000000-20220221T143936Z-avarab@gmail.com>
References: <cover-00.25-00000000000-20220221T143936Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix the omission of not adding "-P" (a.k.a. "--no-pager") to the "git"
invocation that spaws "git grep", added in 0e7696c64db (ci: disallow
directional formatting, 2021-11-04).

This didn't matter for the GitHub CI, but does when running the check
locally. A subsequent commit will start invoking it via a new check
from the top-level Makefile, and without this we'd visibly spawn a
pager when doing so.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 ci/check-directional-formatting.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ci/check-directional-formatting.bash b/ci/check-directional-formatting.bash
index e6211b141aa..de8e6e486f0 100755
--- a/ci/check-directional-formatting.bash
+++ b/ci/check-directional-formatting.bash
@@ -23,5 +23,5 @@
 # U+2066..U+2069: LRI, RLI, FSI and PDI
 regex='(\u202a|\u202b|\u202c|\u202d|\u202e|\u2066|\u2067|\u2068|\u2069)'
 
-! LC_CTYPE=C git grep -El "$(LC_CTYPE=C.UTF-8 printf "$regex")" \
+! LC_CTYPE=C git -P grep -El "$(LC_CTYPE=C.UTF-8 printf "$regex")" \
 	-- ':(exclude,attr:binary)' ':(exclude)*.po'
-- 
2.35.1.1132.ga1fe46f8690

