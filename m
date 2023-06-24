Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9721EB64DA
	for <git@archiver.kernel.org>; Sat, 24 Jun 2023 07:21:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbjFXHVk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Jun 2023 03:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjFXHVi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Jun 2023 03:21:38 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BFA1272C
        for <git@vger.kernel.org>; Sat, 24 Jun 2023 00:21:37 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f8fcaa31c7so19711535e9.3
        for <git@vger.kernel.org>; Sat, 24 Jun 2023 00:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687591295; x=1690183295;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=97c7Kn77Tiok23FGM9VDTmvno88/yfIu+qCSm+N5ZKc=;
        b=rxT+b7E6stpPYgnd1vOENmnLeeG1G10iqKH4sICoTE4TuHAmSpKs0mPMAEsY2UKJOu
         W7ROOG9oFCoDm+Zkqs8o5RP2JuX2mfRHyYCGcZnxhsnByZQkbtdYPgSAhv/M6FwGw+O7
         e+rhnpNSwhxwvtAMt8Oa4TprsivkO6CDoeiBc935AVNqVGew1zQYuVF7r7hC+4Qdozbh
         264bkG2UO9eplN3Pt4/FJq6v9ATROwcsMo6jBWFfFLUpWDuY6br9l30iQGkpUhO4ax4M
         w0tDrAMWIys1DtrX6a39pTuNvrr61Iak1/rSBDz44DcWFsgIks5DoVK0Cu77Y3qptMmY
         o4LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687591295; x=1690183295;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=97c7Kn77Tiok23FGM9VDTmvno88/yfIu+qCSm+N5ZKc=;
        b=S5Qa24mb3sKPwjIAGluzW7CWZpmhCeeSI3YNUrrWLLiBNiNBFpScatoiuaBrolj/zM
         1W34owO2OX5VjAj2JJ3McIG0LpF+KeuRB7VA7K8u539qRBvMf6Rf37HR7fX5IWOFwSlG
         94w0ySTOHe+7XJKtbCzdGSiPEGl3BasUwUVwWc8vzjCxfv/7+Ff21W657J3c4WtLYkMu
         k7Fr+m5Ctxht8i+6iNu3PkD2ShwSrPrmfG0MM+0ekrp0U5Uf+waZdrAtVHcfeKF2TbtY
         2uzJWsU/QYWwIHFdJDNunFlie1hjaPRf4kQv45C57EiW3sZZAdVvds4cqKtVj6hJ83fK
         bZYw==
X-Gm-Message-State: AC+VfDwYjQnJ2ji6Px99yEUwQHcbpi4PlEAaKCmjBiDzrrfBXw8iqtnO
        jHe/NBLK/Ob1HhLYwYY6W2rXjeKwazw=
X-Google-Smtp-Source: ACHHUZ5/13LWb8k4yi7EDg7vVyjAI7YngFgKfCTUJ83PXAbkHYJ6Znv1wV1l0/vg5RfsseKVnM/c0Q==
X-Received: by 2002:a7b:c850:0:b0:3fa:838d:adbb with SMTP id c16-20020a7bc850000000b003fa838dadbbmr1433654wml.6.1687591295295;
        Sat, 24 Jun 2023 00:21:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 21-20020a05600c22d500b003f96d10eafbsm1377842wmg.12.2023.06.24.00.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jun 2023 00:21:34 -0700 (PDT)
Message-Id: <pull.1527.git.git.1687591293705.gitgitgadget@gmail.com>
From:   "M Hickford via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 24 Jun 2023 07:21:33 +0000
Subject: [PATCH] credential/libsecret: erase matching creds only
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        M Hickford <mirth.hickford@gmail.com>,
        M Hickford <mirth.hickford@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: M Hickford <mirth.hickford@gmail.com>

Fix test "helper ... does not erase a password distinct from input"
introduced in aeb21ce22e (credential: avoid erasing distinct password,
2023-06-13)

Signed-off-by: M Hickford <mirth.hickford@gmail.com>
---
    credential/libsecret: erase more carefully

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1527%2Fhickford%2Ffix-libsecret-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1527/hickford/fix-libsecret-v1
Pull-Request: https://github.com/git/git/pull/1527

 .../libsecret/git-credential-libsecret.c        | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/contrib/credential/libsecret/git-credential-libsecret.c b/contrib/credential/libsecret/git-credential-libsecret.c
index ef681f29d5b..9110714601e 100644
--- a/contrib/credential/libsecret/git-credential-libsecret.c
+++ b/contrib/credential/libsecret/git-credential-libsecret.c
@@ -52,6 +52,8 @@ struct credential_operation {
 
 #define CREDENTIAL_OP_END { NULL, NULL }
 
+static void credential_clear(struct credential *c);
+
 /* ----------------- Secret Service functions ----------------- */
 
 static char *make_label(struct credential *c)
@@ -185,6 +187,7 @@ static int keyring_erase(struct credential *c)
 {
 	GHashTable *attributes = NULL;
 	GError *error = NULL;
+	struct credential existing = CREDENTIAL_INIT;
 
 	/*
 	 * Sanity check that we actually have something to match
@@ -197,6 +200,20 @@ static int keyring_erase(struct credential *c)
 	if (!c->protocol && !c->host && !c->path && !c->username)
 		return EXIT_FAILURE;
 
+	if (c->password) {
+		existing.host = g_strdup(c->host);
+		existing.path = g_strdup(c->path);
+		existing.port = c->port;
+		existing.protocol = g_strdup(c->protocol);
+		existing.username = g_strdup(c->username);
+		keyring_get(&existing);
+		if (existing.password && strcmp(c->password, existing.password)) {
+			credential_clear(&existing);
+			return EXIT_SUCCESS;
+		}
+		credential_clear(&existing);
+	}
+
 	attributes = make_attr_list(c);
 	secret_password_clearv_sync(SECRET_SCHEMA_COMPAT_NETWORK,
 				    attributes,

base-commit: 6ff334181cfb6485d3ba50843038209a2a253907
-- 
gitgitgadget
