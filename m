Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CA1C433F5
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 11:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236514AbhKWLtr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 06:49:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236453AbhKWLtk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 06:49:40 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5799FC061761
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 03:46:28 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id l16so508396wrp.11
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 03:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r2KPCn8putcSw/APO9sbh7+Kz0gX2vznhcz7pHZj0/g=;
        b=L96MX+Ca/gvcO8RR3Trsw1f7fhFotjsS7za8vGG6S9STa72qH1gD/daazdySHgHd3+
         KvAiFC8fXfPJOAcWagTEVk/0cTMwH7xdmlUbO/B5R9gA6R6K7qaPBn+y5RRGMg1P5ZTo
         k8TDW/ZgYtZGNZ2Uxlg9anT0/Ydvf/tEcmvBsrnKIjtv3d+IzOh28b4HRe0X1DiuSSl8
         GNL7cLuPQsNobfSoXSME+qNCEWlKUGPIHFUBIT4U1nI2z9qCzwhpAy/pOY0Te+Hgnuh6
         HYH6cVPBbqVSZlE0UTijVBLIXqpmOZSEgAkDqFotJDwYOb8z+HBnaIEuJxN5yMyBiq7c
         JE1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r2KPCn8putcSw/APO9sbh7+Kz0gX2vznhcz7pHZj0/g=;
        b=LRuTAScuWF7PHAtzDcPaEsvPbK9mKNVKiC0C2OBYz3WOpTQC0LtLyj47UoCUF1LEyk
         8eFKoA1e5IqGTgSSXeA1PSOFESLZAO8sgjy4Gu3EXiMx559OTRV3FCT/4l1mR3Ylg0FM
         sTFoNZa5pMHkZQ+zw3WVrRxAuGkspIYhkxewWVQ4tF5AjdVt+JfzZWBOPci6zH/XUChn
         2D1eV/39UdSo1d6443z8+VdOsS9O2n1ybGR8HaDX4aMA5SJA8iR/G46Uq7f9eFWcKsBU
         iO26nV548sXlUPDlmrEOdjKugJZrVI58uhKs9rKL7Zy0dJxHQ6P4XuoGot6X0fELfDir
         /kZQ==
X-Gm-Message-State: AOAM531YCzEBMSepKlicuUoCiOoWbc6z0Cy/0/APfTHXkE3ahka3jU8i
        WJitpQI5bJw5fbVlzYRFETmCMktjhQImpw==
X-Google-Smtp-Source: ABdhPJwJjty+dETupOZrI2bhkzHKB1REDrP5iA7QKS9chmhzGYOo10tdmLXEvm4qwRMea95bAYbXTw==
X-Received: by 2002:a5d:4582:: with SMTP id p2mr6622004wrq.364.1637667986658;
        Tue, 23 Nov 2021 03:46:26 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c11sm1723145wmq.27.2021.11.23.03.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 03:46:26 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 07/17] am: convert applypatch-msg to use hook.h
Date:   Tue, 23 Nov 2021 12:46:06 +0100
Message-Id: <patch-v5-07.17-191fdad0165-20211123T114206Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.831.gd33babec0d1
In-Reply-To: <cover-v5-00.17-00000000000-20211123T114206Z-avarab@gmail.com>
References: <cover-v4-00.17-00000000000-20211101T184938Z-avarab@gmail.com> <cover-v5-00.17-00000000000-20211123T114206Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

Teach applypatch-msg to use the hook.h library instead of the
run-command.h library.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/am.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/am.c b/builtin/am.c
index 4b334cb7b12..ae0c484dcba 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -448,7 +448,7 @@ static int run_applypatch_msg_hook(struct am_state *state)
 	int ret;
 
 	assert(state->msg);
-	ret = run_hook_le(NULL, "applypatch-msg", am_path(state, "final-commit"), NULL);
+	ret = run_hooks_l("applypatch-msg", am_path(state, "final-commit"), NULL);
 
 	if (!ret) {
 		FREE_AND_NULL(state->msg);
-- 
2.34.0.831.gd33babec0d1

