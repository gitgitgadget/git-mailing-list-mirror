Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D43C433FE
	for <git@archiver.kernel.org>; Fri, 20 May 2022 07:25:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346456AbiETHZD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 03:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346424AbiETHYx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 03:24:53 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F4514B660
        for <git@vger.kernel.org>; Fri, 20 May 2022 00:24:51 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id bd25-20020a05600c1f1900b0039485220e16so4586291wmb.0
        for <git@vger.kernel.org>; Fri, 20 May 2022 00:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IbxO1lzN8D26A83W3Nk5n8ww7bLpjPQ1xCub8i1mu5E=;
        b=eMrjnGmRTZrdRdytNM7NF+/Q62a9TAhnrU/s38nAIrZUnMeMQIt9BXAB7Lum365Eiw
         tqMmM0N3QN1wD2sy6mzlZW17Pvkr8PnGLk8PiCiRWbsYtathFkglD7ghl/rFaEEPIo2X
         EKDJmlyWXe/kz/uK0N5fuxC8/SHIzBEt2rsWg5JQ28ca6xPwvCok9o2JOd9ermGWlNFW
         kZ4R+IWtRSnY7WenE9DEyKxQSeKHOplyG25u0t7g8e/HAsFqJQjW5USx0G+CnlEoau9v
         jqLjEoXRV0bz4oWKzVvVuPjL26QfFmmO8IVAwvqdHnbB3uYFX/7Tbtm3avFvTIA5OfRZ
         G5Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IbxO1lzN8D26A83W3Nk5n8ww7bLpjPQ1xCub8i1mu5E=;
        b=K7TsjcDOw5MacaY5D0sl0YjbshqSnvANVJA2NBHUy0toAwNvMuXeN/SjDVBbP+9kUn
         ik+UGeDFqBBs5ndOISwrShf5L+CUY732tTUMubKBqJy/8mxy8lmEd4LxQ48EwXfS6Tok
         qJf/PlbfVjmUyXb23HAb5qPO+i4o+nEml4wQ0+YwHwmH75XS1mZIEsc+BDeuwu5VGATq
         OvzwswE32MyDURJq0M7vJvOUBCGyFwLC53XpY2CSQqSvowqzTr366lBToR15SL93CqLw
         d9jj13P60LcjjHzbfrZyPa8yMZZ3IExGOvr4+fMC59FE1htFzo4VWh4B8vKLmxUYLzhx
         GeyA==
X-Gm-Message-State: AOAM532dDf56uNLuLj5184r1zkXrQE+HvoIt9ZmbojqRudNPYK6KoO1O
        xbS2hwEIlwVjAOkacnnodlxl9IZnT7oz8Q==
X-Google-Smtp-Source: ABdhPJwYrTX9FzyTz++FEc6MDBh392af5CcPHdUGY/lvKfZu4+ILfvR3ieN+FBFxERKwEX4zi4Wtcw==
X-Received: by 2002:a05:600c:2242:b0:397:3490:9fda with SMTP id a2-20020a05600c224200b0039734909fdamr3379330wmm.85.1653031490125;
        Fri, 20 May 2022 00:24:50 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t16-20020adfa2d0000000b0020d0a070c80sm1668429wra.35.2022.05.20.00.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 00:24:48 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Enzo Matsumiya <ematsumiya@suse.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/4] cocci: add a rename of "struct child_process"'s "env_array" to "env"
Date:   Fri, 20 May 2022 09:24:39 +0200
Message-Id: <patch-v2-1.4-e3f33fce566-20220520T072122Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.957.g2c13267e09b
In-Reply-To: <cover-v2-0.4-00000000000-20220520T072122Z-avarab@gmail.com>
References: <cover-0.3-00000000000-20220406T104134Z-avarab@gmail.com> <cover-v2-0.4-00000000000-20220520T072122Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Start following-up on the rename mentioned in c7c4bdeccf3 (run-command
API: remove "env" member, always use "env_array", 2021-11-25) of
"env_array" to "env".

The "env_array" name was picked in 19a583dc39e (run-command: add
env_array, an optional argv_array for env, 2014-10-19) because "env"
was taken. Let's not forever keep the oddity of "*_array" for this
"struct strvec", but not for its "args" sibling.

This is added as a "pending" migration because it'll need a couple of
manual changes to go along with it, those will be performed in the
subsequent commit.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 contrib/coccinelle/run_command.pending.cocci | 11 +++++++++++
 1 file changed, 11 insertions(+)
 create mode 100644 contrib/coccinelle/run_command.pending.cocci

diff --git a/contrib/coccinelle/run_command.pending.cocci b/contrib/coccinelle/run_command.pending.cocci
new file mode 100644
index 00000000000..709fdfcf720
--- /dev/null
+++ b/contrib/coccinelle/run_command.pending.cocci
@@ -0,0 +1,11 @@
+@@
+struct child_process E;
+@@
+- E.env_array
++ E.env
+
+@@
+struct child_process *E;
+@@
+- E->env_array
++ E->env
-- 
2.36.1.957.g2c13267e09b

