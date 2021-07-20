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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D771C636C8
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 10:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57750610D2
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 10:31:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237227AbhGTJst (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 05:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237649AbhGTJqO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 05:46:14 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FAC7C0613B8
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 03:24:28 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id a13so25383927wrf.10
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 03:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ALo8N8Qtn6qP605t6tU9H4g7oH+29n59122nn552CxA=;
        b=AeQG+XsiaQ/kqOiCag5U2wqutfjQ6Rkj8zUefSJhWS3Sz5n65Rdvxzt3YeUFawE7Z2
         BpOjhHqlcv5c4vlK1BYWL8Nd8hJHgxsmmC27asPZBt65+5VJnjjJZA/mBf6okmH/4DdZ
         L2Jh7T1VpVIjJdCheIEZMyaSBIyQYQzoQdy3Xpuf8A5Z4ugEC59HOQ/uY2+qzC4P9mZJ
         hHUfJukb3iSECspNDDPWTsziQh0uSWWy8n3EDTQameOReaPNqcmitlWlmeWkYQ8926bu
         vAp1JehShCBXPB3Iu/9qO9AzGHUwzjZNVqUFdRd0tZIIEnjhF4h257aPhUq/eyej/cxc
         VxZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ALo8N8Qtn6qP605t6tU9H4g7oH+29n59122nn552CxA=;
        b=jgC3LMe2Gk9JzOgTYpbQcq9y7PpQA/IXEeaT5KJ6iyEEgMMQHOQ6V8FKgVyhIWCVWW
         W40VHoQW+FYjCED4T8A+jaZaZtGPJMhBwuOxjd0y10hkAX++mpKgh5Y7cmUuExrlhN93
         AJoVWTNdGsTI9AX5FqtewmiIK9UuJc03/5roYJTmNRicsqrBTcoD+5QcAXAsoeQfqQ5M
         wuAezB+69rAxTthfc79h+36n9F9MuAd8/qYb+WUtAetHOVVbfGyIEDU0Ag9gcPdLcIb/
         MOX3VlTfxk9Ya4EYLMkMR9m9LXomNxMQX4/kRd6weOub65EftgjQAqbkBHWvmiovFFoM
         JJrQ==
X-Gm-Message-State: AOAM532cNtiFFkexTigtvxJBMKI8bhdbWH4Ga03mL6UUtHm8DJ/0heeZ
        NZnVpgUI43UBMHhxkLuzvPcwVNiwJcrq7w==
X-Google-Smtp-Source: ABdhPJxergGrmMNiFdldl+bwG2NPJs+83o98fBtHOhqmi2ywmV32Gs6drBPOF6Fte6bn1LKbCYZzbg==
X-Received: by 2002:a5d:6dac:: with SMTP id u12mr34632504wrs.153.1626776666938;
        Tue, 20 Jul 2021 03:24:26 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l23sm9684536wme.22.2021.07.20.03.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 03:24:26 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 05/12] refs/debug: re-indent argument list for "prepare"
Date:   Tue, 20 Jul 2021 12:24:10 +0200
Message-Id: <patch-05.12-4e526c34aaa-20210720T102051Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.874.ge7a9d58bfcf
In-Reply-To: <cover-00.12-00000000000-20210720T102051Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20210716T140631Z-avarab@gmail.com> <cover-00.12-00000000000-20210720T102051Z-avarab@gmail.com>
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
2.32.0.874.ge7a9d58bfcf

