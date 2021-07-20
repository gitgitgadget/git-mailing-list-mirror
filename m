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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B776AC6377A
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 10:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AADAD610D2
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 10:31:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237821AbhGTJtt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 05:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237670AbhGTJqO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 05:46:14 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE16C0613B2
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 03:24:24 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id o30-20020a05600c511eb029022e0571d1a0so1710135wms.5
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 03:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FmQRw4ks+TUjlGp4POlzZ3ZiYws7aD0O20w2NCTieT8=;
        b=bTQsmtkGvhVdv7+MK3960zm1NuvrKjgpxgxlzr6z3pthg3MGERhX1WZCg6sUykHyUD
         4gE7YxusJCKGHGMSLxRKgYlRBN3SH2RS7jNqE6Kx4aaVSf74y4bB1CJeylrsr5Y3bWt5
         kBFmXv58pmJI3gEzNmXymjjuLv1DOyEJaF64zaSW+nM1aZnvJvhFxGd8HnBwxL9kB89U
         +hjzWaWaod2uLykCXh3aPcXZ4uYG6ZCVNoFSO7yqqSa2t5UnSmI68qk7KIA25pjhXXsY
         FhmXYXCtbeZGnXZN2zMQhr6KmQDW9W2LJyGG+gg2ul1BDF3qI/dUaV907I9TQquyEVgV
         ACxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FmQRw4ks+TUjlGp4POlzZ3ZiYws7aD0O20w2NCTieT8=;
        b=PE/F7eXhZo00PdiTM6CDi8x4INj2yk8XFm134+IOtlRiM2e2E2buxOE12upvMkOfew
         8EGJD5izFWHdqMWER2IpyeLV8mquASZCSBSyVk2rqhUbwi5cU3Strn5HdF3QNigrJFn7
         wvxyGJA1I01yp9OgwHaiBcK4f0R2nIm9EMwQtcJzG6SiNBYpI1BQrraG3o5J0+wF3yGO
         H9zDd/saWcwdO8Qb4rdlJhVo/P+51ef4jfnYTlXNM5zNT6fHytXh3SQ8ANXadKQTwjof
         eULCbZwa0MIQhgUWaLaUnWI39PEqeOTfPwyYf1piN9LSI0Vt91ez5dUXg8tw/xsgaVGK
         pJDg==
X-Gm-Message-State: AOAM5324nBmpO4Wm1dKWDunCEDNXXGYnT7HeVmTCLBeaRnTqr1Dpl048
        AB5pJcbVURpzN+/axa6kuRqWZJ5nPidr8A==
X-Google-Smtp-Source: ABdhPJy+UG1doA93oZQhdQbxZMTL/JL+IpNToYvgwmIMDf8gyqUMmOKnY1YbdXrWn1sf+wIkblvOLw==
X-Received: by 2002:a1c:9a12:: with SMTP id c18mr31895491wme.48.1626776663323;
        Tue, 20 Jul 2021 03:24:23 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l23sm9684536wme.22.2021.07.20.03.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 03:24:22 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 01/12] refs/packet: add missing BUG() invocations to reflog callbacks
Date:   Tue, 20 Jul 2021 12:24:06 +0200
Message-Id: <patch-01.12-737d2d8c3d1-20210720T102051Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.874.ge7a9d58bfcf
In-Reply-To: <cover-00.12-00000000000-20210720T102051Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20210716T140631Z-avarab@gmail.com> <cover-00.12-00000000000-20210720T102051Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In e0cc8ac8202 (packed_ref_store: make class into a subclass of
`ref_store`, 2017-06-23) a die() was added to packed_create_reflog(),
but not to any of the other reflog callbacks, let's do that.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs/packed-backend.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index f8aa97d7998..24a360b719f 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1600,6 +1600,7 @@ static int packed_for_each_reflog_ent(struct ref_store *ref_store,
 				      const char *refname,
 				      each_reflog_ent_fn fn, void *cb_data)
 {
+	BUG("packed reference store does not support reflogs");
 	return 0;
 }
 
@@ -1608,12 +1609,14 @@ static int packed_for_each_reflog_ent_reverse(struct ref_store *ref_store,
 					      each_reflog_ent_fn fn,
 					      void *cb_data)
 {
+	BUG("packed reference store does not support reflogs");
 	return 0;
 }
 
 static int packed_reflog_exists(struct ref_store *ref_store,
 			       const char *refname)
 {
+	BUG("packed reference store does not support reflogs");
 	return 0;
 }
 
@@ -1627,6 +1630,7 @@ static int packed_create_reflog(struct ref_store *ref_store,
 static int packed_delete_reflog(struct ref_store *ref_store,
 			       const char *refname)
 {
+	BUG("packed reference store does not support reflogs");
 	return 0;
 }
 
@@ -1638,6 +1642,7 @@ static int packed_reflog_expire(struct ref_store *ref_store,
 				reflog_expiry_cleanup_fn cleanup_fn,
 				void *policy_cb_data)
 {
+	BUG("packed reference store does not support reflogs");
 	return 0;
 }
 
-- 
2.32.0.874.ge7a9d58bfcf

