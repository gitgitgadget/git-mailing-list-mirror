Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84354C433E1
	for <git@archiver.kernel.org>; Mon, 18 May 2020 20:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CF5620829
	for <git@archiver.kernel.org>; Mon, 18 May 2020 20:31:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rEsK5f1H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgERUba (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 16:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbgERUba (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 16:31:30 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB02C05BD09
        for <git@vger.kernel.org>; Mon, 18 May 2020 13:31:29 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id h4so802833wmb.4
        for <git@vger.kernel.org>; Mon, 18 May 2020 13:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TFpFDxlBb1OSM2D+QSBk1Pp9T9Cuq+rovqf6Inwe0Qc=;
        b=rEsK5f1HjCexoYchPF4d8YoYVsx554YxwlABWYAqg60M5Ue7IktmT6mbc7wRFoBWq8
         QYgeEmarJi0MbbWoI62OQE5Ie3qCMK3g0Bk4K+uhvKYm/DhW0EB2Vkq/x6VPhHARoHfy
         VZYxOXWhhs0YSW5Q/M5O73edPTWglFIiyRs2LtYTU++rBTRVhu+awch8+aQt3wVKsBzK
         6FWm3hUR73itEhDKhB7PzvOLOLbgymjqdhfJmfWWGTR8QbUoQFtx2yUIk0D8pBVbv3G7
         Ndflc8x9LcQc2R0IgHk0S0h9sPS4YJiUC0le2gVQDje00bN/0XTSIOT/G/snAmX+R++4
         Yo3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=TFpFDxlBb1OSM2D+QSBk1Pp9T9Cuq+rovqf6Inwe0Qc=;
        b=hcq7A/ZxmaCck2bJqzcztH0CnzLjugqFjwFCFXDxtebXgSgo7oMrfz2UMUDkKB4S8B
         Gu7lXulW9J2DkXSd4TnT+pHzze9NykDTqS5aiucxJf1Zr3AVlO/f4wvI64SIAwDdRJda
         1bO21tX4Ms3gtzRDZoYliePr1+0q3a40pnA8dJ7UMdlsB310ao6ub7OujiNzq/qr+Qix
         XPcsw7Of+mF8VM7+PrsjOqRlQJX2lJWj0+e6eSkiO689HTgr7grrG1NBplk+TjAGftc6
         xP9VzjSx9i5BjKjkPaeuE/+pMQyUdY1xh1KGRgGhJYjXpXA2kvDA/p4/94Z3DKgKfoyk
         rYFg==
X-Gm-Message-State: AOAM5339U2mPeGiTz80dW1K0bt+ChaOPBuWjHqjuhuth+Bf2fpph/nq7
        /tsmTIj+8WYZNMt2ZMU5MHeNvSL9
X-Google-Smtp-Source: ABdhPJwuG6I5PG5PvSHr+bLom+vT7ugE5Ea08U+rid6m5sQbYUeqreMLztDTya1iyUGnRWJFhjxDjQ==
X-Received: by 2002:a1c:bad6:: with SMTP id k205mr31453wmf.53.1589833888054;
        Mon, 18 May 2020 13:31:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j1sm17782540wrm.40.2020.05.18.13.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 13:31:27 -0700 (PDT)
Message-Id: <c650f7e4345aa58b5710310acea2193f0fd8cfc3.1589833884.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v14.git.1589833884.gitgitgadget@gmail.com>
References: <pull.539.v13.git.1589226388.gitgitgadget@gmail.com>
        <pull.539.v14.git.1589833884.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 18 May 2020 20:31:17 +0000
Subject: [PATCH v14 2/9] Move REF_LOG_ONLY to refs-internal.h
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
index dabe18baea1..51c96ebd485 100644
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

