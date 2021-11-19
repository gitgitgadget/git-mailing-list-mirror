Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA2B2C433FE
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 12:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B199F61AF0
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 12:46:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235385AbhKSMth (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 07:49:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232894AbhKSMtg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 07:49:36 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B88C061574
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 04:46:34 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id u1so17933006wru.13
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 04:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mrSYwqvt8MJY+oS14i10WfYkd+VMzWVs1n/RM30uzsQ=;
        b=cDv5qOpE6eBZJa0kfIuvuelnwj1tfvP4z7y/IlYYjABhTM0HPbVUij134ndO+raHrF
         VnOeKWjVzwfaQID2VEDsftzr3LN74u49HYgAz9nyt9WoXLa7EMoMmjqwJvn6OyFaqnzn
         fvPVyGSC8WvpZJFhy85k+/pv3muff/eFrGSihurvuiN0tgOx+Ivey8Bwpcn76m1fqWrV
         B0fr7mt+xGwUGvnYK9GHzaZwxNZFrMGah2Me6XeStecfi2ygFhjQT8C6H/oLOkhCgHqf
         dly/ycL3880Sl4L0V103xKb9mnDIK2FP2W7PZl6sBnvpqV8JO5USPq67LMSfLxHB3LCv
         u9yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mrSYwqvt8MJY+oS14i10WfYkd+VMzWVs1n/RM30uzsQ=;
        b=EI3xH/F8Zxb4qLpDCyvt74JGMPnou5w5lqE9EkY07a9ByAUgc9JnZ5U673TTDCmeFW
         R+um1gUYtuIRNS2wvoPiT57V9ofrJENKe8hleKSwcRqCpUuAuycUkGAEHArohzl8touD
         3nIaBvSwVhl/FGh/xabdQbgOqgzzyXTMqmXqJmxJEFWk5PM+FZlwtA7iGNXa4ZEXaRNx
         qArFCkbvPCkdeiFPoSDkSdgqlJk4x6D8AtUH+4e+Ng9kcNkE1OGjXoIBtp26E2sUi+GS
         Arqg+kE5PAeNaNMjdVYFGC3KKIz5c4hgI9ciEDIz1ezMcKBSYydM6HXn9e/R+yGmxkw2
         U43g==
X-Gm-Message-State: AOAM531Xqq5vCX8s82r8XvvzpDYQHlKI6v5jdfoUbLqweePWTOHqXypn
        AXiItEqqdbWdAl8Z3k6oNHzibww5zbK7LA==
X-Google-Smtp-Source: ABdhPJyLJNA8+EAZbsJ7v/EBg0IAWO/nTtvLLDB3Ok90CquCd3IT+WIZWZ67GQDndfG5++DYZz0ohQ==
X-Received: by 2002:adf:ef4f:: with SMTP id c15mr7140994wrp.226.1637325992967;
        Fri, 19 Nov 2021 04:46:32 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w7sm2857567wru.51.2021.11.19.04.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 04:46:32 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/6] xdiff/xmacros.h: remove unused XDL_PTRFREE
Date:   Fri, 19 Nov 2021 13:46:21 +0100
Message-Id: <patch-1.6-32bb8ad4de0-20211119T124420Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.817.gb03b3d32691
In-Reply-To: <cover-0.6-00000000000-20211119T124420Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20211119T124420Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This macro was added in 3443546f6ef (Use a *real* built-in diff
generator, 2006-03-24), but none of the xdiff code uses it, it uses
xdl_free() directly.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 xdiff/xmacros.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/xdiff/xmacros.h b/xdiff/xmacros.h
index 2809a28ca96..ae4636c2477 100644
--- a/xdiff/xmacros.h
+++ b/xdiff/xmacros.h
@@ -34,7 +34,6 @@
 #define XDL_ADDBITS(v,b)	((v) + ((v) >> (b)))
 #define XDL_MASKBITS(b)		((1UL << (b)) - 1)
 #define XDL_HASHLONG(v,b)	(XDL_ADDBITS((unsigned long)(v), b) & XDL_MASKBITS(b))
-#define XDL_PTRFREE(p) do { if (p) { xdl_free(p); (p) = NULL; } } while (0)
 #define XDL_LE32_PUT(p, v) \
 do { \
 	unsigned char *__p = (unsigned char *) (p); \
-- 
2.34.0.817.gb03b3d32691

