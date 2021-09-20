Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFC5C433EF
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 15:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4087661159
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 15:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237962AbhITPhz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 11:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbhITPhu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 11:37:50 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72671C061760
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 08:36:23 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id q11so30913202wrr.9
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 08:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=WhOw3Obe0gOgQO+AfU1jSOzrMAyzSWPdmF+5plxu8Aw=;
        b=V7M3jefCrOs6tgX3le0Ro9Db+jIPJGTtwCDQeC1g348MEF5/hpVo0WJdaS5BYa+ZWY
         KdAqSRJ5PTcQxf02u3vdeWO82p8oe9poh5VrrBSVh04iPPXjF1hThmu3gdms5QkdaQ0+
         UEO6VHFlPotowcFTHRHmLdj8TAMKl05B7BEvpSvjmwjzAOUFYc2JEII9u24LBSmF5vcl
         K9N7JDpoB8AfNjCyUKw8dmQ0rkxRUh5xLllbBtHG4nDBbCFAOZJVvN26jmqPaRjgGt+h
         4ZSaSG+lZ6VGriFXO6/ibdsq5EflCFTeSgdvZRHWhLu0O1BalrKuVeuGduZZ6908PzQe
         X/6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=WhOw3Obe0gOgQO+AfU1jSOzrMAyzSWPdmF+5plxu8Aw=;
        b=NhcgEoAfFyPLPrxsiypTd61XiWo0JQUmpHzT6/W3j0O7pFVySN2sf2K1gRTkC+Xzdd
         O0MRyNreScN1K3D+PNsYyo2Hgcv0BwmF0YFWd6pB2d59+FETXGcFYk63yYGoQP+/GgXU
         fW3KkFf9VkwIQRDg8rH+oopA+HNnSS7OcoT9WMotpQRKRGIq9MNEM08AR+MnAzbzkkeS
         XE64SI9gy3e+XHFbb9/g1R3sZ6KqmdWzj4apBgNekzdon7/KW93uZFwGu7QUH6z4o4IJ
         /EhTvf1H2UjDyZ8oGYsDCps1NaM/WvzYT9KYgIRNDh0fhuAVqvqJJYdyrPwdiIzqDjMy
         Mmbw==
X-Gm-Message-State: AOAM533iedoF1utWBITeMjuDT5nwU7VTdvJCFBve/oYY1fYswUymD8FF
        T+15UGZIpcjO0/rDKFyULwiSZl5xndA=
X-Google-Smtp-Source: ABdhPJwPhGruEBttD9XJ5KbCTukwB4plZsjXNHPNzinEN9UTS+f+a3v/gORcw+ba3kBazNFven9qeQ==
X-Received: by 2002:a5d:47ad:: with SMTP id 13mr4883238wrb.77.1632152182112;
        Mon, 20 Sep 2021 08:36:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o17sm16414526wrj.96.2021.09.20.08.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 08:36:21 -0700 (PDT)
Message-Id: <c94b4cbcbf2900ccf1c54873f926099b99e4d663.1632152178.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1040.v2.git.1632152178.gitgitgadget@gmail.com>
References: <pull.1040.git.1631738177.gitgitgadget@gmail.com>
        <pull.1040.v2.git.1632152178.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 20 Sep 2021 15:36:14 +0000
Subject: [PATCH v2 3/7] simple-ipc: move definition of ipc_active_state
 outside of ifdef
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Carlo Arenas <carenas@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

From: Carlo Marcelo Arenas Belón <carenas@gmail.com>

Move the declartion of the `enum ipc_active_state` type outside of
the SUPPORTS_SIMPLE_IPC ifdef.

A later commit will introduce the `fsmonitor_ipc__*()` API and stub in
a "mock" implementation that requires this enum in some function
signatures.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 simple-ipc.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/simple-ipc.h b/simple-ipc.h
index 9c7330fcda0..b396293bdfc 100644
--- a/simple-ipc.h
+++ b/simple-ipc.h
@@ -5,13 +5,6 @@
  * See Documentation/technical/api-simple-ipc.txt
  */
 
-#ifdef SUPPORTS_SIMPLE_IPC
-#include "pkt-line.h"
-
-/*
- * Simple IPC Client Side API.
- */
-
 enum ipc_active_state {
 	/*
 	 * The pipe/socket exists and the daemon is waiting for connections.
@@ -43,6 +36,13 @@ enum ipc_active_state {
 	IPC_STATE__OTHER_ERROR,
 };
 
+#ifdef SUPPORTS_SIMPLE_IPC
+#include "pkt-line.h"
+
+/*
+ * Simple IPC Client Side API.
+ */
+
 struct ipc_client_connect_options {
 	/*
 	 * Spin under timeout if the server is running but can't
-- 
gitgitgadget

