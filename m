Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4326EC636D3
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 19:09:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjBFTJG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 14:09:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbjBFTI7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 14:08:59 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B272BF27
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 11:08:52 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id o36so9416543wms.1
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 11:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0u0DG9ekKTnC7dnAUsx1H6cOzDLAKEJT+uig94+QfqU=;
        b=CtXUVlAnLlbKvJd1AEFnVk1XgTdeGygIMSFpLE9fFh6dWwLq//GLCm1UhbZXFmvp99
         JziNtI0kbLQ43sekQeFeP6yMNb4WaixzqqD3R+Vy1QG4IRHJClMc1MhVViT5phhNJ2u8
         woUXjmiGKYHEKSSR009ntiS0tBzf7noLoE8wlqK9Ze7F1NknkV6ncV7mTPdvSmq8Xw8u
         zqu0TIDK7AZ2TwODDoBXN2vcy7I6L3lFTF8cDp9g60d8Q5pVbYwNBeooSFzk0FNE3Vph
         HLAd3Mfhs1gJX6Q141P5QWmHFv+tYlAXQlyCnk1ZmoKmQ+Bn+PAo286im8y2EAgGValM
         VB7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0u0DG9ekKTnC7dnAUsx1H6cOzDLAKEJT+uig94+QfqU=;
        b=2gtOLvBnMxDdY06M7CUlvpkKAOJP4u8hM3UacOAbil+Q6UpSG/hve0XNDvLT0e1YoA
         sdEFLabXcx+knKAtajucysTwDv/ulY/XlRUiZgVzlGii+6pWTrRr/W5eIIv8HC6ovyWs
         ECyhKCXKL3fBTLKYE+1PnNw4oM7ePNTxgvBPfGf4jvhLqPpf5nyGorcwCKIa+DPoZSvS
         D2JkHseJZYhZ0b9jyja7YfSH6Ya76NJAHfjhc/aWceuzzoFyAMf7Jnxj0th89FNN/qZ3
         UM1AD4u0ZonSWk1G12G5eMgevFC3XC/zZqboxaed9hM32VY9gwmQjv2BRZ8yAYT4U7Ha
         +egw==
X-Gm-Message-State: AO0yUKWf0AZSeOecsTX7qX/2FheKUWAVeZ0jn1IsoKRcP4Va5J53GHw2
        rOVePFKkCBQayqAyQ1wJhwqTMlKaQUtULwEj
X-Google-Smtp-Source: AK7set+MUIuRwkD8ExR2l5EZL0oukIlCQb34BKtwBlsNCFQ0V/0QVErh0f61DJ9FOj2PHtSkao55iw==
X-Received: by 2002:a05:600c:181d:b0:3db:9e3:3bf1 with SMTP id n29-20020a05600c181d00b003db09e33bf1mr695099wmp.31.1675710531736;
        Mon, 06 Feb 2023 11:08:51 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p2-20020a05600c358200b003dc4ecfc4d7sm12538595wmq.29.2023.02.06.11.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 11:08:50 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 7/8] builtin/rebase.c: free() "options.strategy_opts"
Date:   Mon,  6 Feb 2023 20:08:12 +0100
Message-Id: <patch-v4-7.8-07ab875c3e2-20230206T190346Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1425.ge02fe682bd8
In-Reply-To: <cover-v4-0.8-00000000000-20230206T190346Z-avarab@gmail.com>
References: <patch-v3-7.8-ee8262ab22a-20230118T160600Z-avarab@gmail.com> <cover-v4-0.8-00000000000-20230206T190346Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the "strategy_opts" member was added in ba1905a5fef (builtin
rebase: add support for custom merge strategies, 2018-09-04) the
corresponding free() for it at the end of cmd_rebase() wasn't added,
let's do so.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/rebase.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 41e96f0eb5a..6635f10d529 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1850,6 +1850,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	free(options.gpg_sign_opt);
 	string_list_clear(&options.exec, 0);
 	free(options.strategy);
+	free(options.strategy_opts);
 	strbuf_release(&options.git_format_patch_opt);
 	free(squash_onto_name);
 	free(keep_base_onto_name);
-- 
2.39.1.1425.ge02fe682bd8

