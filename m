Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B28FC433E1
	for <git@archiver.kernel.org>; Thu, 28 May 2020 19:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FA4D207D3
	for <git@archiver.kernel.org>; Thu, 28 May 2020 19:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EKJ0RiQD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406680AbgE1Trk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 15:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406636AbgE1TrD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 15:47:03 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D12C08C5D1
        for <git@vger.kernel.org>; Thu, 28 May 2020 12:46:58 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id x14so549710wrp.2
        for <git@vger.kernel.org>; Thu, 28 May 2020 12:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ukVwadAARfKuHZOHLWuRGZXOJ+eigR/79cTpQxkBXFk=;
        b=EKJ0RiQDB9ZySh/WcsTLlqe1ZMEl838YTo3lDRRYAkSjWkR/nChOqM8ZRMtb/0dbkl
         D+L6lGPZIQtQcOQhg1snn41ZirUZiVMh9tcBaFMRLw/J4dkXc5URvQtMTOLnyxPmtl5F
         EllQmbbrzmcDGrrsfNokjUP9v2BmScJ4R5y7xDe60X6+fBlC30Vm9wO5tBkREarM506P
         CjJ7DQC8xh3CvCnAhZGitiPa36pRZOUzMe47yOsVKFy71knKDB3PeUcDOfGUryp+WEfz
         KJ/pcWguMWzv2O0V7PbY9n12P/C5BD+RyaTgGUzS0m7tkZCbF1Hi6jW6D3FV0hFzWvBh
         TG3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ukVwadAARfKuHZOHLWuRGZXOJ+eigR/79cTpQxkBXFk=;
        b=jX3hTIJVUT8wAW43YPhnYHh1ZVjai9PoFtwAODqkGPIXySZs4HoSXJ825NTECtCMQE
         A5LSPM/Q8l3BsTuAFkjCfW2+62nVrGEKjL1zcMIpoOWMERg33yuDWCXNeSz+mzmGXA/b
         6rw2cs/1xBf5psUeoCwhc8X0HClKRpNeDYcdo0nmwrndBLizd70Aiin8g3WNkLasyzmj
         Ei5C8tnSc4KN0xtLMUp8UxQuDJHk9wZzSJXOIjBD5M5sbqBqiiteUhAeEzCQMdP22Sc8
         FYzEfnf2EbPDFnXRxF4PvR59WJTgX0q7A14FshPbNXYuJjHXK0A+ZMRaYey5OifW5tb2
         NAjA==
X-Gm-Message-State: AOAM531ihpX4Q736kMfZsZpcaO5WnBp1RiSk6cJwFGtRwTCms8JeLhql
        pTmzLhT8QmQM+3dY86Lp/ofpGQEh
X-Google-Smtp-Source: ABdhPJwC18EIGKiMN378kX+VRKtj082XYB2CZtF+VfMjZffbr5LAp9AbBuhqTUdaJR/6tduoRST4Hg==
X-Received: by 2002:adf:f2cd:: with SMTP id d13mr4821142wrp.378.1590695217442;
        Thu, 28 May 2020 12:46:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v7sm3405385wme.46.2020.05.28.12.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 12:46:56 -0700 (PDT)
Message-Id: <e0e1e3a558d35821c46eacaaa5be4ff6bc739d55.1590695210.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v15.git.1590695209.gitgitgadget@gmail.com>
References: <pull.539.v14.git.1589833884.gitgitgadget@gmail.com>
        <pull.539.v15.git.1590695209.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 28 May 2020 19:46:42 +0000
Subject: [PATCH v15 06/13] Move REF_LOG_ONLY to refs-internal.h
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
index 4c6d77898aa..d1d00947990 100644
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

