Return-Path: <SRS0=RX4d=75=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 227EFC433E0
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 19:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDB1520776
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 19:21:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OvgHilg6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730951AbgFPTV1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Jun 2020 15:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730588AbgFPTUx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jun 2020 15:20:53 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1582DC0613F0
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 12:20:53 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id g10so3927153wmh.4
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 12:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=u1RHlxAFpwWBSV/HcKvyES6SzICWXlSchJDIeLwacbA=;
        b=OvgHilg6uFsSpVuP9Cw4NbR2SbuGXdxpfoXT707cV5dxWcOSPoSYSgH7Rt2wEKoqGs
         LlnRBhPtHJj6YSbQdDGbRDnvfCTj1ZQjJHuIc5UHnhP5+MYvganivHZiCqFrcGEh6KQt
         pxofrYL7CxR+w6KmTbf6fNZf5Ux97ZRpA/0GCtIi2q59Byafi7rESps34CxZ/pYEj10v
         RHDAC1ZdMp6pgtnihXQRZFUiR92tcotoi/rQITeEzhFawGYZWdJVbzDXN3qCkt/0xWRj
         nCixRo93GxJXjsYjy51X8hLQhEYzbQijIYn3t0fZ5fx1009BrkTIwy/8wz4uBWlr9IlM
         C0vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=u1RHlxAFpwWBSV/HcKvyES6SzICWXlSchJDIeLwacbA=;
        b=q3ZcnO8iDu0SxOWxM90bld9kSiimPxTeYJ4G6ft2CKnfixDSxeh9cuaSSaBU/sraSz
         ble/4dr621tH/jHXGwuw/VqGvy/GunfKS+xFCYc5p5886V5VAcRSVeBmUdk5d5l9O5qI
         vMemAg3pel4WrjnPaauk8ulvl57efSCJXe0oP263YIjuzeMhoeJNaznigNAveRhpZ21A
         +rhl/u8xYe9m9UoYMLKub4t7b9ZpTG4AmD0KbX3iVud6Vif0Pu7JxELDDjR8UhF6Jmwh
         od0M3wThi3MM98SXkgjbfxP0b2e7vrp2srTbYZKr6dGpGUbMVGgP3rXBl+uez0kmc0gr
         AcTg==
X-Gm-Message-State: AOAM533nDvkpUdGd22GCfek/PlDvWnn/FJxLCzDfYY2GWJstidFTm3Dz
        M4dj6X0/1L7OSa4zcT9ocyY7Z3rl
X-Google-Smtp-Source: ABdhPJxP+4Lgd9IocCEvy9DHtr0iWdXVydq9LLj+q8WfqKxnttu2luc5owrSzF1pTgrar9My78iz/g==
X-Received: by 2002:a7b:cbcc:: with SMTP id n12mr4502053wmi.127.1592335251667;
        Tue, 16 Jun 2020 12:20:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k17sm30980524wrl.54.2020.06.16.12.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 12:20:51 -0700 (PDT)
Message-Id: <4981e5395c64ec03abf217ddcea388a77ca86197.1592335243.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v17.git.1592335242.gitgitgadget@gmail.com>
References: <pull.539.v16.git.1591380199.gitgitgadget@gmail.com>
        <pull.539.v17.git.1592335242.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Jun 2020 19:20:33 +0000
Subject: [PATCH v17 08/17] Move REF_LOG_ONLY to refs-internal.h
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

