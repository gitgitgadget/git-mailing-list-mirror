Return-Path: <SRS0=Jtyc=AD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B14FC433E1
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 21:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72844206E2
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 21:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="apbOyxv+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730801AbgFVVzg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Jun 2020 17:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730754AbgFVVzc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jun 2020 17:55:32 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDAF1C061795
        for <git@vger.kernel.org>; Mon, 22 Jun 2020 14:55:31 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id z13so6566356wrw.5
        for <git@vger.kernel.org>; Mon, 22 Jun 2020 14:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=u1RHlxAFpwWBSV/HcKvyES6SzICWXlSchJDIeLwacbA=;
        b=apbOyxv+yvR1Y9q9xfJQEX6qwp+g0/JJE3GITeSGu4XrpmNIUkU6SqZ77aop5F8E/g
         8aJAQJful045P3hfeIGwwg2ipLphqOottuBcUZq+41GZrTG5oci9ClIKFs1V10UT0wzn
         HVAyq2x73+6Pj7LYruzPaXycwCVnP9pYgyoFloOYGXebyeMPRnahnynCyh/49l6/BsPO
         gHFcVTxlMbP3Mez73o6BX8GQKM/GsyeG2jkXzpsAGVOUlaHGQ47DehcL0bSQW0ElI3MZ
         L8GD3A3Y3m9pu37ZUy8XeIIQYdU3ohHqHqx6DKeTwZL2WIRrpPxMex7f6HQKbbafOXUD
         bvlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=u1RHlxAFpwWBSV/HcKvyES6SzICWXlSchJDIeLwacbA=;
        b=NOuV8V+bt33asDF7607GhvLRzLK8k3OJZlMRYuJMtMV/P8Clej7G2PJ7p+If/+mD8c
         iVdf2zyVMJSYyKoKaBydSCK0WwN1mF2nGYUJmU0k3JH3NfvS2cKn9TQkmupa8Ps0F+/e
         NL5rYsfLyMNkSEaL3WT0OSIoae0/XH8kxwIEJxQLnuvPKWWzAooDK+tIBo1bg4lmv+ZX
         W3nQiXm/Y40utqXOSYzRORsPyyJG/cAO8fLk9hcp0QM17ois4ozcOnmNKvoPI/ftokIg
         BykHACt6q2voC7Oht+2DSAbzKjF7sELYiWz6zbEZ9ddqEz1WZoBIZ7i71Tg+a5AoEIhg
         iOww==
X-Gm-Message-State: AOAM5307+vxJg8JZfTwAEIFqvwY+XnQ3ZTKX8l9p3uiofzjdpbCwXWAO
        DO9yZKdP3kvmmIKtvzpkdCP4aGAS
X-Google-Smtp-Source: ABdhPJz/WTNS4jPfNBZcTcSXUQuho/72ul1CR925Wmi4Jl3xEZxWB/3kb+Ze/zcAES2aJAhIvkJQ1Q==
X-Received: by 2002:a05:6000:47:: with SMTP id k7mr20358426wrx.233.1592862930351;
        Mon, 22 Jun 2020 14:55:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f14sm1726214wro.90.2020.06.22.14.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 14:55:29 -0700 (PDT)
Message-Id: <37e350af159ac8c492e3915df49a518a8e31b7a5.1592862921.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v18.git.1592862920.gitgitgadget@gmail.com>
References: <pull.539.v17.git.1592335242.gitgitgadget@gmail.com>
        <pull.539.v18.git.1592862920.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 22 Jun 2020 21:55:09 +0000
Subject: [PATCH v18 08/19] Move REF_LOG_ONLY to refs-internal.h
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

