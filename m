Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB5A3C12002
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 14:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92B3E613E8
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 14:13:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240470AbhGPOQW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 10:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240428AbhGPOQS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 10:16:18 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305FAC06175F
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 07:13:22 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id u1so12324950wrs.1
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 07:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3o5d+dcP1XSl9ZdYR/rF9iU6xQoZcztCXTEGCd2oFiA=;
        b=lDQoSj/vf+WZy+ijBq5uBcBJ1oc8ykPecQoJDuO4vS/f3A9VLvuSnZneKB49sNIWgf
         6OZOmDEnU7yb57hiPOv7WXXUy35vzXT+5W7bWHEnsNoOdr9njNftKpu7alVwub4MqK/X
         +ZBY8szeutU4dnggKd0RMrF6pfwDtyeT//r9JA8PQ27IRDQFLtbbTmdd5iyO8NxgrD+/
         9EFRHAUCyM4er7RayffdI4/ecUUbOpcuP6cuFoPaFXApkMZe7028qxtlrMDYxZoFs9Om
         U7xZbD2/aYXTT95Gsrn+Y3M9TYA2jLwzfVaCV/swm8q1tmrAgU8PGLFUiEqukrJn89Zp
         fu2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3o5d+dcP1XSl9ZdYR/rF9iU6xQoZcztCXTEGCd2oFiA=;
        b=GEw+M++GoQvzrmFUz4JXkKb1zi8FpCS3JjxFZ6BivOPiutqJTtZWsyap4e8K9UGGpV
         lZvRyT14lz3XlS8cyWWWbAg28yLer0VvpNO/KE7KSxI0dlDhmrdJBWWb/qKdTQYCS4yd
         vTULeh6wp6jScLqm7mZZCMsMLVL8b/SDjKoLp8iqXNK7MtqQu28YIUu6SHaRXcQzIEdU
         l9YBOvL8zPBLd3xflWB7ExP0Aedl+kjIvPr7TqBP33sEmJ1YGG7ntGYLZSqic86nVkzs
         rHmTw96WlcNNuyVknB9sI4wHec0N7DdK5QdcW578FX5ust7VCSHV/6XrUEJv+pdlhsf9
         TW6Q==
X-Gm-Message-State: AOAM5307gL616sre9v1pwOMZ/SBgfNZm3yTvLbrkD6AGAs58xDEoR6o2
        pyPKovWaZ0f5vPkIj3CitmNBW+mH7NAhqQ==
X-Google-Smtp-Source: ABdhPJyqgdUoBZZm02XmeR+M4LcWy4qC3IMTDLJ8QnO+GRvBrRAj+MCoBviGbGSvvN7gMhLMhAR8wg==
X-Received: by 2002:a5d:4fc6:: with SMTP id h6mr12782410wrw.112.1626444800596;
        Fri, 16 Jul 2021 07:13:20 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a9sm10101363wrv.37.2021.07.16.07.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 07:13:20 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 05/11] refs/debug: re-indent argument list for "prepare"
Date:   Fri, 16 Jul 2021 16:13:01 +0200
Message-Id: <patch-05.11-95101c322b7-20210716T140631Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.874.gfa1990a4f10
In-Reply-To: <cover-00.11-00000000000-20210716T140631Z-avarab@gmail.com>
References: <patch-1.1-de0838fe99-20210714T111351Z-avarab@gmail.com> <cover-00.11-00000000000-20210716T140631Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Re-indent this argument list that's been mis-indented since it was
added in 34c319970d1 (refs/debug: trace into reflog expiry too,
2021-04-23). This makes a subsequent change smaller.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs/debug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/refs/debug.c b/refs/debug.c
index 7db4abccc34..449ac3e6cc8 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -364,8 +364,8 @@ struct debug_reflog_expiry_should_prune {
 };
 
 static void debug_reflog_expiry_prepare(const char *refname,
-				    const struct object_id *oid,
-				    void *cb_data)
+					const struct object_id *oid,
+					void *cb_data)
 {
 	struct debug_reflog_expiry_should_prune *prune = cb_data;
 	trace_printf_key(&trace_refs, "reflog_expire_prepare: %s\n", refname);
-- 
2.32.0.873.gb6f2f696497

