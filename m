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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D91DFC433EF
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 11:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B43B1611BD
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 11:04:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232561AbhIJLFx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 07:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232513AbhIJLFu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 07:05:50 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B756AC061574
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 04:04:39 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id v20-20020a1cf714000000b002e71f4d2026so839509wmh.1
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 04:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3VW+2sa9oywdjcwB84CgGbewQl/O724gubn5nEyVTik=;
        b=gMPkqQdfhvKHSDq3nonPzcTI3ncZ24Uwz1QXYWD/PFFpOqxIpJuAq7VlahxRKsmRsw
         d3MESVElEQhOygb8cfiX4Ptro553tbA3kEM7Y7ltzX6OfbP1KfhbAyvvuL7WjAloe5Yj
         Y9e/IojgvbjJG1uUE/71jh+1RVtJoHlSfLW+BdQ6ma6MqnLSTpe4FgxsRPcTUU1j+kWB
         4rHh70FqL14dJhQhM3rLHMS3v1na7KIk6LDY1zRNX7Qegvwl+vA+rDeTBRMwWMFJMgEX
         SyvIElofvPvsX1x176N/5PDj8t/EhZXLr2zM/q9LtNPKCQnu8SVN9ijL38uLxuiLb8nf
         1zRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3VW+2sa9oywdjcwB84CgGbewQl/O724gubn5nEyVTik=;
        b=Ob4haOpTd45Nnsfvv+e+/JApsRQryi22U2Or/3RL3VwW/W7Afpxht5fmmse2Lqiipc
         1WZCU9qnTsgEsG/8YKtyymMU1odOhnKDXGH66WuR3p68Sgc9R4/PsxkzwxYHe72gqxaS
         LlVu0FxnM5xa46G1dkOgJS/lLUJYOHplOKvwFL/6XWN8+Cxh5d5bP3EMSQdFsJISXdFk
         +EhDxESp6XsmnGmE1L6Dy6E9gUijcETKYliyfoE6tHRRio+AySzsXoEgvG0cl1KctZD4
         QtxT1D4ra1bV/YClXhWgyndM/MWk5Lxg4or1Uc2UdlsRSlVmsM+hubF6KfVnfBY383N0
         o9tA==
X-Gm-Message-State: AOAM532N3di/9m3PMwyUsUIloIQ62y/wuG+Nhf93HQzl3MT9lmvAu+Y3
        v/Qs8WjEvE2HorlSo/fgk9uLylIiBiGECg==
X-Google-Smtp-Source: ABdhPJz3ZbdAblGg/zRpsOxWsQH/tAEBO+kD6vHj3DYkh2qfScS+W5uSr88GpLps8YVQKEo+kkuBQA==
X-Received: by 2002:a1c:488:: with SMTP id 130mr7593456wme.156.1631271878108;
        Fri, 10 Sep 2021 04:04:38 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q201sm1013631wme.2.2021.09.10.04.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 04:04:37 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/8] INSTALL: mention that we need libcurl 7.19.4 or newer to build
Date:   Fri, 10 Sep 2021 13:04:27 +0200
Message-Id: <patch-v2-2.8-4b653cee2d3-20210910T105523Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.873.g125ff7b9940
In-Reply-To: <cover-v2-0.8-00000000000-20210910T105523Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210908T152807Z-avarab@gmail.com> <cover-v2-0.8-00000000000-20210910T105523Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Without NO_CURL=Y we require at least version "7.19.4" of libcurl, see
644de29e220 (http: drop support for curl < 7.19.4, 2021-07-30). Let's
document this in the "INSTALL" document.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 INSTALL | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/INSTALL b/INSTALL
index 5c6ecf03c27..81f3a6cf018 100644
--- a/INSTALL
+++ b/INSTALL
@@ -141,6 +141,9 @@ Issues of note:
 	- "libcurl" library is used by git-http-fetch, git-fetch, and, if
 	  the curl version >= 7.34.0, for git-imap-send.
 
+	  Git version "7.19.4" of "libcurl" or later to build. This
+	  version requirement may be bumped in the future.
+
 	  If you do not use http:// or https:// repositories, and do
 	  not want to put patches into an IMAP mailbox, you do not
 	  have to have them (use NO_CURL).
-- 
2.33.0.873.g125ff7b9940

