Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B58B9C6FD1D
	for <git@archiver.kernel.org>; Mon, 20 Mar 2023 16:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbjCTQUW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Mar 2023 12:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232503AbjCTQTv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2023 12:19:51 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC131D937
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 09:11:36 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id o7so10903579wrg.5
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 09:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679328694;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6Da4/9quimr1em+Jj4mu6ix2DgXerzJLUD5PFT4B+4Y=;
        b=Yk7WvFnPG+8+bi48wiLrLRVkzXHzfCeb37zrRXpYCMvno9qzxXbLdrUHWdN2guZ5N+
         DXeSfweiy6c4eUlbTYkK/GzOetFUP7WhJFESDuZpcgBwnpU4U5e2+GvvM2GIsUD0W7GC
         BD1EgSY4CkYWm+YXAClGHAhV+L2Jyuu0Uqvl7rhR7qwokzclhG5sh7rZ6LbzAgqxiyLi
         OrCzdYUBhHZEMTZDSyh1jQsqs04k5vS/twBfkGxNzlF+WxR6+F0KUyUSoAvSy1JLjgUh
         4G2r0Lb7PzkLoYDN5/d7kENBzMPcB1oEiH5TpidIGb0RSvn+mxeAl63eILgzjqx7zhyf
         mloQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679328694;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6Da4/9quimr1em+Jj4mu6ix2DgXerzJLUD5PFT4B+4Y=;
        b=NK1Uxb41wPaMHwVzBm2OxygT/z+mED1H/YYO3vRZoSSOAnuyMx7Y/kn5XDwOe6eUWr
         L5VmUCy/9f35QepDwRUqFHsvy4Rj3OYWy9aYFc8qiPvl5CRCUAw/1X9EhZ66HQl8CZZR
         uKFCpPPcsUiw5xgSeLl5enb0ZlNRG7/vrQe2TUH4uYduFiMl8ZSr8ocE5AjVbZwro1v2
         rUSlaV5JtCl2gLmCIGNNAwmIeVbUCUgopmC/cGXbRWDbjQF3UqVESGQX9S6s52AUQpHf
         OIZCBb43oySogoIcOYVe398e6cex71ie/uEXMd4MnmE/VOx/MgGFCbJF1eIVuWeRoy23
         4Dvw==
X-Gm-Message-State: AO0yUKXle02RP/LOap+TvcnYif3/tB9djkF5Kb1ZQ1lNQAIAaKyXLvA1
        E8hiKhp3FadGeGsbTBwf5g7GG/sKUfU=
X-Google-Smtp-Source: AK7set+yTMosstXTXrNXvwp6oLDP0gyhB+T/PRDkMdEW3c6oSV4Mvz60t7F8WiMdm7fakHaxS+tbBg==
X-Received: by 2002:adf:ff85:0:b0:2cd:bc79:5444 with SMTP id j5-20020adfff85000000b002cdbc795444mr14079529wrr.2.1679328694540;
        Mon, 20 Mar 2023 09:11:34 -0700 (PDT)
Received: from localhost.localdomain ([90.253.29.198])
        by smtp.gmail.com with ESMTPSA id n12-20020a5d484c000000b002c59f18674asm9279628wrs.22.2023.03.20.09.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 09:11:34 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 3/3] wildmatch: hide internal return values
Date:   Mon, 20 Mar 2023 16:10:02 +0000
Message-Id: <a74ab7138be28db54bd26d352f0eaecc54978c1f.1679328580.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1679328580.git.phillip.wood@dunelm.org.uk>
References: <cover.1679328580.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

WM_ABORT_ALL and WM_ABORT_TO_STARSTAR are used internally to limit
backtracking when a match fails, they are not of interest to the caller
and so should not be public.

Suggested-by: Derrick Stolee <derrickstolee@github.com>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 wildmatch.c | 7 ++++++-
 wildmatch.h | 2 --
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/wildmatch.c b/wildmatch.c
index 694d2f8e40..372aa6ea54 100644
--- a/wildmatch.c
+++ b/wildmatch.c
@@ -14,6 +14,10 @@
 
 typedef unsigned char uchar;
 
+/* Internal return values */
+#define WM_ABORT_ALL -1
+#define WM_ABORT_TO_STARSTAR -2
+
 /* What character marks an inverted character class? */
 #define NEGATE_CLASS	'!'
 #define NEGATE_CLASS2	'^'
@@ -278,5 +282,6 @@ static int dowild(const uchar *p, const uchar *text, unsigned int flags)
 /* Match the "pattern" against the "text" string. */
 int wildmatch(const char *pattern, const char *text, unsigned int flags)
 {
-	return dowild((const uchar*)pattern, (const uchar*)text, flags);
+	int res = dowild((const uchar*)pattern, (const uchar*)text, flags);
+	return res == WM_MATCH ? WM_MATCH : WM_NOMATCH;
 }
diff --git a/wildmatch.h b/wildmatch.h
index 5993696298..0c890cb56b 100644
--- a/wildmatch.h
+++ b/wildmatch.h
@@ -6,8 +6,6 @@
 
 #define WM_NOMATCH 1
 #define WM_MATCH 0
-#define WM_ABORT_ALL -1
-#define WM_ABORT_TO_STARSTAR -2
 
 int wildmatch(const char *pattern, const char *text, unsigned int flags);
 #endif
-- 
2.39.2

