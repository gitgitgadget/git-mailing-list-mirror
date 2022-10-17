Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A747BC4332F
	for <git@archiver.kernel.org>; Mon, 17 Oct 2022 17:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbiJQRtm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 13:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbiJQRtc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 13:49:32 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E22BCA6
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 10:49:31 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id fn7-20020a05600c688700b003b4fb113b86so10558603wmb.0
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 10:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aQmFvnekpMV6f3ZF1ugz1NHwlNEbxXsqFB1IIhRPS/g=;
        b=qqQeS4n47FHNKmpLX68H2IISod6U/xHg3KlGkTM2XB6I5Z3Pd+NIeMJ4Gkck7wlEKF
         +/XC7WRxVkRD8rLi3y1ELdYIEJaEhbOBIpcxYnpYzL9dRXoHMmSJ9rIzyCMMB9+0qrxm
         2FRF2B1z+nEa4eVD1ImTm1G+zZyq+DctENTslF+IRWabeBi7gM1fok7nHAl9HStVwbp6
         SKGvTYN1gNMeVR1xbIcunJXRVhlIJIP48sY+aDryqEITJve0ziobPnc7Bd62pNh6NVL0
         NSZoz4ePtlyE0g2K+Cn2JduOp5Uua3WxCeDOnTTGL/YKsheOzIC3uI7LJDD56a+WjYnC
         xhIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aQmFvnekpMV6f3ZF1ugz1NHwlNEbxXsqFB1IIhRPS/g=;
        b=mceDUKutVCEkjzjotMWb/VSw6Fok0b7GGhIkLSjR2cWY0jUqHItD/uIOUqlzlqitaC
         eZVx7i7/LCFj0/ulGnsY90pMvvTrRNdar3cvMfBSNhEJw/EhlNa/y+m/pWCgi2Gl0Pdi
         nUKkAI1lAX1N74YaHV5tS3VRCZka5tzlZczhVbAK81IMuZV5VUIuwGJH5I1XIIn0eEty
         VMpETqrP6IFDIwjnirxSaUrY6HaumZLCsJYy6lc5JKzV3iGatpPYwQ6IJ4iZePpIMPgD
         jCSBNcY1gKk5IwRtPdR94UI41C7NMgfeqZiGEZhXHvRds7syjmIH1D/eNb+wdzVOZUx7
         1nag==
X-Gm-Message-State: ACrzQf3pb1RMH9BOav6SZdLGrYvn9hxmqUQ3/yroDB8GEYm9/OZxLDhw
        NSRyZGy7yUYzvHC0ihdnu+cAK7v+Hn2K2g==
X-Google-Smtp-Source: AMsMyM41Fyudc6sW5jdBsL3NVOjC5UTNqoTNtTG8AHb7kvbT5HVjMX09X9nD9r4aB03ioUT4dfyX0A==
X-Received: by 2002:a05:600c:4f89:b0:3b4:a6fc:89e5 with SMTP id n9-20020a05600c4f8900b003b4a6fc89e5mr19426014wmq.149.1666028969238;
        Mon, 17 Oct 2022 10:49:29 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e26-20020a05600c4b9a00b003a5537bb2besm10676023wmp.25.2022.10.17.10.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 10:49:28 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 04/10] am: use run_command_l_opt() for show_patch()
Date:   Mon, 17 Oct 2022 19:49:15 +0200
Message-Id: <patch-v2-04.10-5cfd6a94ce3-20221017T170316Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1093.gcda8671d6c6
In-Reply-To: <cover-v2-00.10-00000000000-20221017T170316Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20221014T153426Z-avarab@gmail.com> <cover-v2-00.10-00000000000-20221017T170316Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "git show" invocation added in 66335298a47 (rebase: add
--show-current-patch, 2018-02-11) is one where we're not calling
oid_to_hex() twice. So we can rely on the static buffer that
oid_to_hex() points to, rather than xstrdup()-ing it. As a result we
can use the run_command_l_opt() function.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/am.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 39fea248330..1d298a91306 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -2186,16 +2186,10 @@ static int show_patch(struct am_state *state, enum show_patch_type sub_mode)
 	const char *patch_path;
 	int len;
 
-	if (!is_null_oid(&state->orig_commit)) {
-		const char *av[4] = { "show", NULL, "--", NULL };
-		char *new_oid_str;
-		int ret;
-
-		av[1] = new_oid_str = xstrdup(oid_to_hex(&state->orig_commit));
-		ret = run_command_v_opt(av, RUN_GIT_CMD);
-		free(new_oid_str);
-		return ret;
-	}
+	if (!is_null_oid(&state->orig_commit))
+		return run_command_l_opt(RUN_GIT_CMD, "show",
+					 oid_to_hex(&state->orig_commit),
+					 "--", NULL);
 
 	switch (sub_mode) {
 	case SHOW_PATCH_RAW:
-- 
2.38.0.1091.gf9d18265e59

