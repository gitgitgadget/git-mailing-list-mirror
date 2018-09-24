Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D4161F453
	for <e@80x24.org>; Mon, 24 Sep 2018 10:06:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbeIXQHk (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Sep 2018 12:07:40 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:15147 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728212AbeIXQHk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Sep 2018 12:07:40 -0400
Received: from lindisfarne.localdomain ([92.28.142.68])
        by smtp.talktalk.net with SMTP
        id 4NkrgLWW7VlGZ4NkygJ4sn; Mon, 24 Sep 2018 11:06:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1537783581;
        bh=RpqTxiuLb5a3jiGq6vyqtswjvdvBb2oWy7fK7XoZyOI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=i5kvGGwaNdg2BRI8pIXA+BNpfyr/RPi7pvWXoX7mozmpaJy8IFdy1TNPhOk745YdC
         6+wy9kLGEZZ45hoUwdr8bRz+Y/emChfOpYz94+Ps28jA1SkFDo5tyRsPLauNif/+oS
         /7ZLynwSD9xyrAVRXQIY8r9xgsJQ8ljq5ZWYnEhY=
X-Originating-IP: [92.28.142.68]
X-Spam: 0
X-OAuthority: v=2.3 cv=JcuSU3CV c=1 sm=1 tr=0 a=UGDAwvN9cmeZh0o4udnnNw==:117
 a=UGDAwvN9cmeZh0o4udnnNw==:17 a=evINK-nbAAAA:8 a=UXsM_k0DTXzUqNaiiZIA:9
 a=LkKtLPdKtb9Niahs:21 a=hA-f583o6LWtlw6A:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Stefan Beller <sbeller@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [RFC PATCH 1/3] xdiff-interface: make xdl_blankline() available
Date:   Mon, 24 Sep 2018 11:06:02 +0100
Message-Id: <20180924100604.32208-2-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924100604.32208-1-phillip.wood@talktalk.net>
References: <20180924100604.32208-1-phillip.wood@talktalk.net>
MIME-Version: 1.0
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfD2h4nL0QDmanxvgtjCll/2XbCboPOSAyycYvTLa6H33PJpj0qPrJWz7ZdN0Ckb0xHhEFCTBgda7Ngl+50vTnFkDfgWzeIcj1Teim1/lBsvOwhLjPa1i
 oKLbckB4Ki+m/aXAWnrPSUjANWtxEmTYZooasf05idBNEcYviURZe3T6hlW/S5H6G9UrbaCmGuKgRvcrXNRdc+j0lBI3QP3nzqid/5KbG//18O+FzKmFyviJ
 wJPSZ/CdCik0lDHHMd/4HA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

This will be used by the move detection code.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 xdiff-interface.c | 5 +++++
 xdiff-interface.h | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/xdiff-interface.c b/xdiff-interface.c
index 9315bc0ede..eceabfa72d 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -308,6 +308,11 @@ int xdiff_compare_lines(const char *l1, long s1,
 	return xdl_recmatch(l1, s1, l2, s2, flags);
 }
 
+int xdiff_is_blankline(const char *l1, long s1, long flags)
+{
+	return xdl_blankline(l1, s1, flags);
+}
+
 int git_xmerge_style = -1;
 
 int git_xmerge_config(const char *var, const char *value, void *cb)
diff --git a/xdiff-interface.h b/xdiff-interface.h
index 135fc05d72..d0008b016f 100644
--- a/xdiff-interface.h
+++ b/xdiff-interface.h
@@ -45,4 +45,9 @@ extern int xdiff_compare_lines(const char *l1, long s1,
  */
 extern unsigned long xdiff_hash_string(const char *s, size_t len, long flags);
 
+/*
+ * Returns 1 if the line is blank, taking XDF_WHITESPACE_FLAGS into account
+ */
+extern int xdiff_is_blankline(const char *s, long len, long flags);
+
 #endif
-- 
2.19.0

