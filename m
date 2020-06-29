Return-Path: <SRS0=sGv9=AK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C881C433E0
	for <git@archiver.kernel.org>; Mon, 29 Jun 2020 18:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47793204EC
	for <git@archiver.kernel.org>; Mon, 29 Jun 2020 18:57:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPqxrlob"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729600AbgF2S5M (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730081AbgF2S5J (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jun 2020 14:57:09 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3774AC031C40
        for <git@vger.kernel.org>; Mon, 29 Jun 2020 11:57:09 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id f18so9582584wrs.0
        for <git@vger.kernel.org>; Mon, 29 Jun 2020 11:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=B0Kd1zfccLGkd+yYLbuDtqct/aQ0oFxEAp509Zzarlg=;
        b=jPqxrlob0eVggdaanQWwMr/c4jIn1PodRYhFKHaVTHeVCYZeQQNW/SSiVEVg+V6DbW
         4J1Tri48SHI0jXKRawHpL1y7DF3icAtpW9g6t9AHFUV/MxRWZrxc8jn+l5LbBlaLvPSg
         Gbm3AmT+Urer5cHoidCJy9d6cs6ZLz3Lkrhs0+y2Q/QWPM7BUcjgZHoHTSQLjXKkjYai
         wTMvu/t3bbxLnZjCgbyMiPTjfbcKGxCuubvIrr81MYFLaXQ7J8/fo738BoeDoFtX9vuY
         Tsso1vG8MT1mNRL2olo7efzPobXNS75uy07UxL/oEJHlBVbMgJ3YUydu9bLla9RTwkIg
         BrUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=B0Kd1zfccLGkd+yYLbuDtqct/aQ0oFxEAp509Zzarlg=;
        b=oHGtg4gQ9MsV32Viy3L08o+SQPJeRLK3tsJzraOa3rSsjo4En663MT1Icvgz/GcGdN
         X3eX5AY2vxNITOrTJ4Tt3ccvOFSPoZu6OFKzVf4VGqxmyoREnXmTMosnLaqIHnNR3PDc
         5Eqp5SNThwdZ8y567I8NTckSHWjpM16XU/9LUCLz21gjJVmqsEV8oyc6/01qSork34ZN
         Pg/Kq67sQ9QqC86iVWhvfeIGntpv5pbQLQjY3CbINnFriRbu9sOyQ6DGU5kRIrUh3cmR
         o1apHhpGo5rVW47ppTZ/oDUkEDCXrbDTtiKY9HlIHxZiDhcMazPhLTHG7Xdr1On8LxgK
         ouaA==
X-Gm-Message-State: AOAM532tkpEotsUzs2A9dLoDgfv6coxfC1Uza0LjGGD0qfOrxjZSnyVI
        C/bj1bp+9ZcFimAGi/mf91Xe3ut+J3k=
X-Google-Smtp-Source: ABdhPJwuVOeoXkTnXy7Xq4Oe4S/BQwuYddjhG3c8oMfWabREs955cTB2mTin73r749LviqfJi2UHnw==
X-Received: by 2002:adf:8024:: with SMTP id 33mr19615690wrk.117.1593457027846;
        Mon, 29 Jun 2020 11:57:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q4sm765575wmc.1.2020.06.29.11.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 11:57:07 -0700 (PDT)
Message-Id: <9463ed9093c3ae9fab5c00accd3142ed6e8acf59.1593457018.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v19.git.1593457018.gitgitgadget@gmail.com>
References: <pull.539.v18.git.1592862920.gitgitgadget@gmail.com>
        <pull.539.v19.git.1593457018.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 29 Jun 2020 18:56:47 +0000
Subject: [PATCH v19 09/20] Move REF_LOG_ONLY to refs-internal.h
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
index df7553f4cc..141b6b0881 100644
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
index 59b053d53a..dc9e8d3a92 100644
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

