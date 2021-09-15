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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0135C433F5
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 20:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D189061131
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 20:36:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbhIOUht (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 16:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbhIOUho (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 16:37:44 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19722C061766
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 13:36:22 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id t18so5925828wrb.0
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 13:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=WhOw3Obe0gOgQO+AfU1jSOzrMAyzSWPdmF+5plxu8Aw=;
        b=KxHrVsQVyeB95GG/Lx7VQURI6X7alBOnUTrA1q445BJqFtGiKWyaxpWOXlvz/mad1M
         0x/fIopEyj0ngzHPQZgfGtwZwu/aSd2/e+WobQgMzVup1jnGK5uHWiiQcURnc/X+3qM1
         CIqVBYNIvTfqAzciiDBVyFrs+t9zNkCEnyeK+sZe03JbQ8iugQie5DJf5k7nrCNleXWo
         HXgUr4NKxxUkNfx6BHHIztIIe1RwDB1sMANjBXb5PJNfSFGkwUTDKh+LUeyqtcbJgwyR
         d1pBYaQfyBaT/KazVmpmUn6FqNYNafLLdipZA99N7kR/79rgm6WzoIAaC9anBWt45jab
         iNcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=WhOw3Obe0gOgQO+AfU1jSOzrMAyzSWPdmF+5plxu8Aw=;
        b=f6bqGxUrr/1/sVYQsX9Ycellovw1vRpC2uGXKsoSq1pVEVeKSiL5oPJAyj/frN65sV
         RRNb+5LS5Zq3G/NUrEluh7Nhjg8HxlFn9u7LorSnrLOTRcSDrV8NAAhpLpr4h6xSpdk7
         N0exaY85Vg9/AOH+/loACnJ7bzl6+TKtV3DTD+mLq1OV5kWxu+0nNLANL1AeNMONQ90q
         qW53L9kABY6FjNDwub/D/84qyqtWkI4kvkcFlbHcW5JfV1qmKvNcQVaLJOmW0fmmUEkG
         JS9tPZ8s8uFT2QsysPC2Evu644U4USVAYetxsM7Gm9LLSf/V6UoqI3FmJDe/jUIFOwBS
         CTmw==
X-Gm-Message-State: AOAM532T1O2oTBtcVsUOMj8GcWe96P82/7qopFwtPPwEglIzsMmNuwEG
        Lr4JGgoJaNPOa1AoHApVktVXoCa445g=
X-Google-Smtp-Source: ABdhPJxfHiNaQ/z6xkbHYmxrlS56OCYaRtUTEisRJJkFrJloDqN2d/vlGCkz1DSjw66CJQgYzmSvuA==
X-Received: by 2002:adf:f683:: with SMTP id v3mr2116048wrp.423.1631738180803;
        Wed, 15 Sep 2021 13:36:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j2sm1017550wrq.35.2021.09.15.13.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 13:36:20 -0700 (PDT)
Message-Id: <7de207828caa9e50906f39b955e39e9de2c1768f.1631738177.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1040.git.1631738177.gitgitgadget@gmail.com>
References: <pull.1040.git.1631738177.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 15 Sep 2021 20:36:13 +0000
Subject: [PATCH 3/7] simple-ipc: move definition of ipc_active_state outside
 of ifdef
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
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

