Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF1DC433E0
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 15:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B957208E4
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 15:27:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KhB0gum5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387481AbgGaP1j (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jul 2020 11:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732501AbgGaP13 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jul 2020 11:27:29 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9615AC061574
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 08:27:29 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id r4so25403404wrx.9
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 08:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yYdAemdSuc7l46QEN8JKCjqJ/eUU84+C3+boUmyUChI=;
        b=KhB0gum5UO/5VPQmiXr+WeSBM1YVgdFZFznEqsok4rVcoyLLebuPjj+m8ONHGnrK1P
         PNLnWF5F4KPiPEqqQ/6mykNbI0moB+Wq6QQmWQ0i6hz5Ky83LoaepvPafZW7edDHipfq
         nM6VA+Nnu8kKmMtDjpuX/qaGTXVZRFyUkAzWMl9QjzXLS+RW2NVeZNTLS4cZhylORcqe
         3F0WebDGBg+I4Bm4sXmCXyPZXz9omqu1O7bxHpHP6VpqE69z3/yTMPPNdUPUzoDVQbHC
         baAtGUot/5udbfik2lPtNMJF+uPx40lTsNHZtjH/BuKZdjHlqgHJ/h/DiASVgiC0iCpc
         vODg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yYdAemdSuc7l46QEN8JKCjqJ/eUU84+C3+boUmyUChI=;
        b=HmwR9x4VYPr/BTy9nWw3yB6o2czJkskgMxjgsUp6wJh7Mf51Dmg+RqkxMOrzYYk5xI
         CH2f7pClccmBzLvl0Hmq1Lzj7dtEVQNStesJyKWM/G3sTeyTi3CLpSXvbKzKrovGRsLX
         TpqiVx13106yOpO0jF74S9cgrD+VvhF6XhA2PknAAdIIiQKw24KVqnKhyijDN/LeAPZj
         2WDsBJIdQfz4txJpXEDP+IKSz44ydEDSxV+Bk7U+UfsvTeCooxnPRfu61skPEauianb9
         ALDF65qzR3xIqhWSnwWkk9Ox/cTr1gPbPyoGj4inc0E3q+V1r+sUuSeEt39SH6MzDfv+
         16Rg==
X-Gm-Message-State: AOAM5332qi8yyssAv++JMGGRzNR05YEbccBjDarZ4LSK5RIhF6bYOwpD
        +LqIi/H9uyV6ZgNeoDeNqIEAaSPf
X-Google-Smtp-Source: ABdhPJwvufQkgusOdOl3PgklXnCplVSPAxw6w4iw5rTYgIxSpkcz70sIVSsZbbrNJt8ZpoBKrG+USQ==
X-Received: by 2002:a5d:4dc2:: with SMTP id f2mr4010701wru.399.1596209248253;
        Fri, 31 Jul 2020 08:27:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o7sm13307482wrv.50.2020.07.31.08.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 08:27:27 -0700 (PDT)
Message-Id: <4b601b545ca6e0498fa610ac21cd5be1f088fb66.1596209238.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v20.git.1596209237.gitgitgadget@gmail.com>
References: <pull.539.v19.git.1593457018.gitgitgadget@gmail.com>
        <pull.539.v20.git.1596209237.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 31 Jul 2020 15:27:05 +0000
Subject: [PATCH v20 09/21] Move REF_LOG_ONLY to refs-internal.h
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
index 3a3573986f..5829d5f8f7 100644
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
index 24d79fb5c1..61fd2e661f 100644
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

