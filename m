Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B9BC432BE
	for <git@archiver.kernel.org>; Sat, 28 Aug 2021 00:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38C0161002
	for <git@archiver.kernel.org>; Sat, 28 Aug 2021 00:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbhH1As1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Aug 2021 20:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232693AbhH1As0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Aug 2021 20:48:26 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B27DC061796
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 17:47:36 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id x6so4667494wrv.13
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 17:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=X72Y2JXlkRf06MadaeInEifKFENsLmUYZCAf8FbSmSA=;
        b=XJAvMfg0rsNlIY6S+2FBcPXPAz3Z98SgNC9xufuTSQE3uDdFAJOqiuhoi0oVftaNC0
         Y/maPFwxmq8ujmGI5ot0TgxkMfztA3G6y149/yYRkR8LSrBAGnYxB9MNcF2+mg+HFlZi
         y2HD4qp0TLNJmtD3kM7agM1+71gh08O9CHrP9uNW6or84pIaeciwaDf4NA4Yi4H4/c9x
         UuXJo/nh6YliHVJQ01oNeEogySIlO0VmFx3fxlHuMjHdVuWIZI5F9S9Nr1vxS4UF/L56
         vy8kb+1A62cUeK9QSME16GEwbRApEESAizG6aK/9ukuzdYniz6oZpylHdKQ3vjucC8Jv
         4LMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=X72Y2JXlkRf06MadaeInEifKFENsLmUYZCAf8FbSmSA=;
        b=dbGAkSlNGcSm9ZIpA6I4pfDMw8kDdpYRSOcVI9H7ON0Td/Fu3/fi/5xSUtMElzShkf
         OjUEVweD22e/sAOuw4OPPWSVmTkHApjuI+q3Z1sxibshXAWDKP3orZ4zZugla/ivuFjj
         D1E8oZFxLqk74cZKof3ouONHWinMqsdsUZmdFHeK0oT8IARCx8+WAXTi9mJqfobviB7d
         Parnr+UEBynkAWdNE3Gt+O5QiNiceOO2PboyzVWo8J+CLJ/jerste9TCh64kbCivS4Ia
         ShXS1wf1GCe6vkNTrhNvfKxmfq5XDPhjFPeTxlYx2MG+alsy+KT0O2I4Nys8CiQ3Z2ih
         BH+A==
X-Gm-Message-State: AOAM533QppctvZ4yrJ7itUDsY0m7XXz1DysSCQ5myUMY81nZUSPEkFCO
        k8ouNmQ7gUmB94klyUCfswX9Jj2s4vM=
X-Google-Smtp-Source: ABdhPJzn9zQOgMWNy372UOPNpmNZoa1ZjtYT9llmrBkqS8sJd/9MZo+I97/1i4GDLKKNPadjV40CTQ==
X-Received: by 2002:a05:6000:1808:: with SMTP id m8mr12936820wrh.272.1630111655036;
        Fri, 27 Aug 2021 17:47:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u5sm7679469wrr.94.2021.08.27.17.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 17:47:34 -0700 (PDT)
Message-Id: <2f566f330e01ed4249edad54671e98301dbeec5a.1630111653.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1022.v2.git.1630111653.gitgitgadget@gmail.com>
References: <pull.1022.git.1629393395.gitgitgadget@gmail.com>
        <pull.1022.v2.git.1630111653.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 28 Aug 2021 00:47:31 +0000
Subject: [PATCH v2 1/3] test-lib-functions: use 'TEST_SHELL_PATH' in
 'test_pause'
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Carlo Arenas <carenas@gmail.com>, Jeff King <peff@peff.net>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

3f824e91c8 (t/Makefile: introduce TEST_SHELL_PATH, 2017-12-08)
made it easy to use a different shell for the tests than 'SHELL_PATH'
used at compile time. But 'test_pause' still invokes 'SHELL_PATH'.

If TEST_SHELL_PATH is set, invoke that shell in 'test_pause' for
consistency.

Suggested-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 t/test-lib-functions.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index e28411bb75a..1884177e293 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -139,7 +139,7 @@ test_tick () {
 # Be sure to remove all invocations of this command before submitting.
 
 test_pause () {
-	"$SHELL_PATH" <&6 >&5 2>&7
+	"$TEST_SHELL_PATH" <&6 >&5 2>&7
 }
 
 # Wrap git with a debugger. Adding this to a command can make it easier
-- 
gitgitgadget

