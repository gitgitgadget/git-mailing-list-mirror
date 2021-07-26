Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29556C4338F
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 23:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 057B660F6D
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 23:44:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233945AbhGZXEH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 19:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233380AbhGZXEF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 19:04:05 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1B6C061757
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 16:44:32 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id f14-20020a05600c154eb02902519e4abe10so550998wmg.4
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 16:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cY/y8TYhmPLeR+YdJaOeuX7fgyn4tlFjsF/3VIH9OEQ=;
        b=KzRdaBX7E2FJdcyeLJ+uWDk17bnzjoktBldURr86mLvA10GkkJoS6uRyiVZeB6SoY+
         gAfrUhNjdbhmDOK7+4Z5DcZTX2943mCc7hN0tDyq7tccXq8i/4605eUoQDpuvpAN1t8y
         7P1pnHxpi1Nhknn5WBu73pKERmvg5a7DC9Z0o9slcVZNFTrSLKrURMRQlt+7gipv/ld9
         e8ncDwiFd/2HIFIl0NDBTR6jssrfRVWl5MdhvCGqhtKeuAPdSdHcB6P+PlnMgjkXhCnA
         JHIRFHZ91DaER8T715rWVRPXZG1xd3LSeLtiqrbuBBY7fUNuzLu93+qIkUwr0CxK/PpK
         thKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cY/y8TYhmPLeR+YdJaOeuX7fgyn4tlFjsF/3VIH9OEQ=;
        b=my3FqHhi0SeHe7ZXOt4aPCPvQAEu2V/neDdmTUuX+XX7u4jrygg+DVG4QJmovbTN9q
         GlmRTstn4/62zhE98w32cQctf/uzuDRylL60+O+RLwAqZQDOrdNzR1VqcT1THnbex4RI
         fAnvFhg3ihlg8ZWORiwvMIOwDaKteuBA7yrGpSOddL/THcJZPSEPJF7+ojE+IpFzvLUa
         GSE7bwxMkbyqwpe+f5NrWEJQsq3axQAmjDlgNPyv0MdBJo0dFffcixq7BkhHDi5AdNov
         O/0XU9lxCNkpCexsyaGEilCh243FhJg58lDBJqA11B7FVtAaQqknbvSfRFO7G/y5EmFu
         QMJA==
X-Gm-Message-State: AOAM532nJ8D0Ife9l0Rbp/Rgg7r80sKENDfAtBRXKefFoBxhM//aDCMe
        QSg4EbTWy5QnvVFuBSatIsnYkz600TUxcg==
X-Google-Smtp-Source: ABdhPJyilt2QanuUZ1e1eWuixZGDlulEXOBXBmP4ud10kuRVHpHsF4hbGbcDTSzLY3odiHK/46Ohww==
X-Received: by 2002:a1c:f613:: with SMTP id w19mr18989999wmc.141.1627343070660;
        Mon, 26 Jul 2021 16:44:30 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n18sm1214545wrt.89.2021.07.26.16.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 16:44:29 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 01/11] refs/packet: add missing BUG() invocations to reflog callbacks
Date:   Tue, 27 Jul 2021 01:44:17 +0200
Message-Id: <patch-01.11-92fc3af072-20210726T234237Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.988.g1a6a4b2c5f
In-Reply-To: <cover-00.11-0000000000-20210726T234237Z-avarab@gmail.com>
References: <cover-00.12-00000000000-20210720T102051Z-avarab@gmail.com> <cover-00.11-0000000000-20210726T234237Z-avarab@gmail.com>
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
index f8aa97d799..24a360b719 100644
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
2.32.0.956.g6b0c84ceda8

