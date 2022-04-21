Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB72C433F5
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 18:24:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391340AbiDUS1D (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 14:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391271AbiDUS0g (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 14:26:36 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0ACE4B42F
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 11:23:42 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id r19so3721936wmq.0
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 11:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0YLmAHuYAq0v4BJ6eaPK9P1vsJBoYJl0pC8kgGRrJyM=;
        b=GoAXAyDGC0UyM/IglPiNJwmOmcLptRC4cd1WefBAye743Z9rzSsbgVfRmYVDUmrRci
         U09OVvfMduhrG7fWzSOrHcWB1ewEXhLNoQV+vL9Ue4U0cRw8oBmwOT2IPr87no2jYBmG
         Dl/ARCb3PgaX2AhzT0KJPde0QYc11+5E2vjk2I+h6D+qnH5sMSxBL+pkZjTSjtCENLys
         m6Ks+U9ctCzQmxQdZ9Runt/17L+AgMq2h6ivM1RHdGMeZAmBDmNxwSBLjOUP0C9j2Qk4
         xeJliXsvqamfYAIUsIQJAFnBGrTPlYh+xe4IPnbYGcb6IvjoRNXjtvlX7Etklrdq9j34
         pFrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0YLmAHuYAq0v4BJ6eaPK9P1vsJBoYJl0pC8kgGRrJyM=;
        b=gY4Gpumy9wKPkFGcHJ9caP+cPrZ95NOqGuD2enJGtplJ8M//D7EL6d8v7Oiuu3si6J
         Mkmg3zuH1a9crIdYwau0VhKQ62jjY9PROeUayMvClKEEpoa/MBgsQ3G3Ngcugqfx7yeP
         D+Wz2GjFFpiLYFjttVpbQrho59rjoUOMqo3xuIzQw5h1eByU9efIUL9M0T/F9+IWHHYZ
         2XLrSHP44hdiZvnLtJwjFnCYtleY2D5FFB792uLT6296u4H7PiUx7lmq23zGIWP5Z73m
         ezibJy/rPzYRe696r1avLXLGtgN1yW3C9t9/vipaQtntaNHEpn9esQEPRb6j0+E9pMKi
         OayA==
X-Gm-Message-State: AOAM5316OQFK9ENxI1NH5IMqlJIXb10QNu3pBy1EGxxRO0hscRTn1asp
        +LwpZkp+kpUGjCFzSCk5LkGEb9s9TBxpSA==
X-Google-Smtp-Source: ABdhPJxT3Xa3t0KXj9YwBHdTLR2RH4oz1PZIuA0qi2Ab/AGSAw7DrCCF+WQDHMzf6C9Pa+Ua5MfKNA==
X-Received: by 2002:a7b:c310:0:b0:38c:f07a:e10d with SMTP id k16-20020a7bc310000000b0038cf07ae10dmr610006wmj.110.1650565421241;
        Thu, 21 Apr 2022 11:23:41 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k11-20020a5d6d4b000000b0020599079f68sm2909090wri.106.2022.04.21.11.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 11:23:40 -0700 (PDT)
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
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 07/29] CI: don't have "git grep" invoke a pager in tree content check
Date:   Thu, 21 Apr 2022 20:23:02 +0200
Message-Id: <patch-v5-07.29-a264b40ba0d-20220421T181526Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.879.g3659959fcca
In-Reply-To: <cover-v5-00.29-00000000000-20220421T181526Z-avarab@gmail.com>
References: <cover-v4-00.31-00000000000-20220418T132809Z-avarab@gmail.com> <cover-v5-00.29-00000000000-20220421T181526Z-avarab@gmail.com>
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
2.36.0.879.g3659959fcca

