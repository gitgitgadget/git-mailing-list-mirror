Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95670C433B4
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 09:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58A3161396
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 09:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241732AbhDWJLT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 05:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241184AbhDWJLS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 05:11:18 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A294BC061574
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 02:10:42 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id g9so31589265wrx.0
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 02:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=OQNkk9iCfi4KFpgS51KzbtiZ4mo+oOo5uIERURGS6r0=;
        b=ITFAS3fplC8MpZYPOY4A3ke8oyOh/VT/yB0txyQy5JCLpak06WcQB9q8JjeN5wDFlX
         e3mp82tK25ltTTLkZ7R9kiA0e4A+JShwYlcl+ydLMy5JZxlT1N6/ZkKX0Epxz3zYYQ88
         e06TVNc9Cyl2AQWZaKNUT9mailjKl1ib6+/A/2j+gLXxwBgMot91fU7lH5clm05bOhcm
         nVYLMWzW8OXAPryT2ONROw5wWKeQJDj+cnTmr4Jj/dxH6D7fmpQCN3i/za8O8AdfLUFB
         KEc9Zz3fcgWZCGX15nuhrY9mtMuvmPwrZagyCJndFb3gf/QHOZTyxMquQ6qVAZgtfEHY
         sIuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OQNkk9iCfi4KFpgS51KzbtiZ4mo+oOo5uIERURGS6r0=;
        b=WFEw0V5QB0zVTexm+MTLTLcOCongbUMZ5t0rdHfygYN6Mohp5K/QP3gIm/ISDrdINW
         DhsZwWzu1jwokbfSkzX9I0kEWiAIPzyt0LvCPblXNsvf7VcMOqQR1s6zq9bjIIQuRDiV
         S9VLj8H0xOno+CvL9oblpFSWfO2wIZxaBMBs90r8yQCSOg1tmD4Qbs9zmodnniTxHADc
         d/ADFKxr/U0pupmKPbFQ/1Smq8jc1Czpl2SICRcZa5eDMDUNn8MAMTcgnBRQnEp3VEmW
         2MoXzXEjzsjNjeFUo2oYQ2knEs7QPLeBek/jzqcYTaS+2F54+vzmDMwn/H+SbwsQDRiG
         NE7g==
X-Gm-Message-State: AOAM533yTO4mOEr4VY34YAlnUaI0njnaoCvYQlIQQRT0adMKhnFb2u90
        GBDGTijyjCKcfiDIM7hRAlBevPX1lgk=
X-Google-Smtp-Source: ABdhPJwT3XZ+eabUgxSnyFaGwxtlEbT9TH4TeLGdzEvpnkqU+9m8Yq8x7ahBa95k6PhtIGnhNLNx7Q==
X-Received: by 2002:a05:6000:1816:: with SMTP id m22mr3465725wrh.260.1619169041364;
        Fri, 23 Apr 2021 02:10:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f25sm8424184wrd.43.2021.04.23.02.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 02:10:40 -0700 (PDT)
Message-Id: <pull.1010.git.git.1619169039954.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 23 Apr 2021 09:10:39 +0000
Subject: [PATCH] refs/debug: trace into reflog expiry too
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
    refs/debug: trace into reflog expiry too
    
    this is split out from my larger reftable series. It improves debug
    output, so it's both not crucial to the reftable series, and should be
    uncontroversial to merge into next.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1010%2Fhanwen%2Fdebug-expiry-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1010/hanwen/debug-expiry-v1
Pull-Request: https://github.com/git/git/pull/1010

 refs/debug.c | 47 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 44 insertions(+), 3 deletions(-)

diff --git a/refs/debug.c b/refs/debug.c
index 922e64fa6ad9..3b25e3aeb1ba 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -353,6 +353,40 @@ static int debug_delete_reflog(struct ref_store *ref_store, const char *refname)
 	return res;
 }
 
+struct debug_reflog_expiry_should_prune {
+	reflog_expiry_prepare_fn *prepare;
+	reflog_expiry_should_prune_fn *should_prune;
+	reflog_expiry_cleanup_fn *cleanup;
+	void *cb_data;
+};
+
+static void debug_reflog_expiry_prepare(const char *refname,
+				    const struct object_id *oid,
+				    void *cb_data)
+{
+	struct debug_reflog_expiry_should_prune *prune = cb_data;
+	trace_printf_key(&trace_refs, "reflog_expire_prepare: %s\n", refname);
+	prune->prepare(refname, oid, prune->cb_data);
+}
+
+static int debug_reflog_expiry_should_prune_fn(struct object_id *ooid,
+					       struct object_id *noid,
+					       const char *email,
+					       timestamp_t timestamp, int tz,
+					       const char *message, void *cb_data) {
+	struct debug_reflog_expiry_should_prune *prune = cb_data;
+
+	int result = prune->should_prune(ooid, noid, email, timestamp, tz, message, prune->cb_data);
+	trace_printf_key(&trace_refs, "reflog_expire_should_prune: %s %ld: %d\n", message, (long int) timestamp, result);
+	return result;
+}
+
+static void debug_reflog_expiry_cleanup(void *cb_data)
+{
+	struct debug_reflog_expiry_should_prune *prune = cb_data;
+	prune->cleanup(prune->cb_data);
+}
+
 static int debug_reflog_expire(struct ref_store *ref_store, const char *refname,
 			       const struct object_id *oid, unsigned int flags,
 			       reflog_expiry_prepare_fn prepare_fn,
@@ -361,10 +395,17 @@ static int debug_reflog_expire(struct ref_store *ref_store, const char *refname,
 			       void *policy_cb_data)
 {
 	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
+	struct debug_reflog_expiry_should_prune prune = {
+		.prepare = prepare_fn,
+		.cleanup = cleanup_fn,
+		.should_prune = should_prune_fn,
+		.cb_data = policy_cb_data,
+	};
 	int res = drefs->refs->be->reflog_expire(drefs->refs, refname, oid,
-						 flags, prepare_fn,
-						 should_prune_fn, cleanup_fn,
-						 policy_cb_data);
+						 flags, &debug_reflog_expiry_prepare,
+						 &debug_reflog_expiry_should_prune_fn,
+						 &debug_reflog_expiry_cleanup,
+						 &prune);
 	trace_printf_key(&trace_refs, "reflog_expire: %s: %d\n", refname, res);
 	return res;
 }

base-commit: 311531c9de557d25ac087c1637818bd2aad6eb3a
-- 
gitgitgadget
