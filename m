Return-Path: <SRS0=KQVw=7S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC34C433E1
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 18:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 731BA206FA
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 18:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="giux7qzD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbgFESDf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Jun 2020 14:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgFESDa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jun 2020 14:03:30 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E417C08C5C2
        for <git@vger.kernel.org>; Fri,  5 Jun 2020 11:03:29 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id t18so10659114wru.6
        for <git@vger.kernel.org>; Fri, 05 Jun 2020 11:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=u1RHlxAFpwWBSV/HcKvyES6SzICWXlSchJDIeLwacbA=;
        b=giux7qzDfew05MVDcLxXl6AKfklt2ecAhCoYKdtCudoxtvOrEEXVFY6xQswgD//8Sd
         QhiIXPJvTLe9Ut2XF+gNvjwm0kgkUP6Hbe/Wsn9mCZTDb+IE4RrY6HFPW49o2iNZTF4t
         LiagxTGedOL8QYYY2ktfYMt56gux/PrAzbq2osbbfily56yMVJhdkwizNL1BY7YjHruP
         t1hXf7kWQcEkACTNdtCEXP25GOpp0NdrDFVfknRewVoI5aJpVMPCX+o+1UpU+D/6rifK
         jkkLbkX9t3wux9LqAr06GqEDBjBArBToCs9zjXP4gG0EKx/Qputb9Iy8yGQICd5x16Wq
         KYJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=u1RHlxAFpwWBSV/HcKvyES6SzICWXlSchJDIeLwacbA=;
        b=jmZ01/30g8BUTHf0GMdXE1/4i5dedJiHhyhDNfkvYW3DNMaqoVVulgSK4O7TZbPJWy
         tIo7IVHpZGIEl8RGKBWVMY+b1fk9gQ1OCzCjVtUjKZF1ZafA3MPcdZ/cd2G2qoL3b1Kz
         em+Ri3DQ7hzzw9Nk3yqza5jMq/YcLXbXuYd+oGNqnWHSqpnEvMy/7KuJW+T12/ujJaIQ
         TTWbq3pRCj41XXwMbeSOowhPUkKNEaaziIAfVHYwQVRaZ1tytAyAriiwQbBe3EQ+cuA2
         0wVvs48rHPq2+y7e/TP0dZ/VlKmpN1rfvQSitn93cQdhqj2w3iaKLAURd773KpwoHIR6
         +xvg==
X-Gm-Message-State: AOAM531TfXtxbU53+TQdMfEgI6TcOa8biGNFKMu5Be6USTstg1hmqhOr
        VvHQTIxE08waVCv92AdHZl472rSJ
X-Google-Smtp-Source: ABdhPJwzZIE20pZ1gEq64j84oANBhR59aU9GQzdf1X0TE/ZxjwdGnsH5zyfuEPOhd50L57hENrtYLQ==
X-Received: by 2002:adf:a350:: with SMTP id d16mr11167034wrb.237.1591380207988;
        Fri, 05 Jun 2020 11:03:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d18sm12812014wrn.34.2020.06.05.11.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 11:03:27 -0700 (PDT)
Message-Id: <d8801367f7d84720e264bfa64d0c6f58557cd518.1591380199.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v16.git.1591380199.gitgitgadget@gmail.com>
References: <pull.539.v15.git.1590695209.gitgitgadget@gmail.com>
        <pull.539.v16.git.1591380199.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 05 Jun 2020 18:03:10 +0000
Subject: [PATCH v16 06/14] Move REF_LOG_ONLY to refs-internal.h
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

REF_LOG_ONLY is used in the transaction preparation: if a symref is involved in
a transaction, the referent of the symref should be updated, and the symref
itself should only be updated in the reflog. Other ref backends will need to
duplicate this logic.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 refs/files-backend.c | 7 -------
 refs/refs-internal.h | 7 +++++++
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index df7553f4cc3..141b6b08816 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -38,13 +38,6 @@
  */
 #define REF_NEEDS_COMMIT (1 << 6)
 
-/*
- * Used as a flag in ref_update::flags when we want to log a ref
- * update but not actually perform it.  This is used when a symbolic
- * ref update is split up.
- */
-#define REF_LOG_ONLY (1 << 7)
-
 /*
  * Used as a flag in ref_update::flags when the ref_update was via an
  * update to HEAD.
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 59b053d53a2..dc9e8d3a92b 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -31,6 +31,13 @@ struct ref_transaction;
  */
 #define REF_HAVE_OLD (1 << 3)
 
+/*
+ * Used as a flag in ref_update::flags when we want to log a ref
+ * update but not actually perform it.  This is used when a symbolic
+ * ref update is split up.
+ */
+#define REF_LOG_ONLY (1 << 7)
+
 /*
  * Return the length of time to retry acquiring a loose reference lock
  * before giving up, in milliseconds:
-- 
gitgitgadget

