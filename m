Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F09D1F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 14:16:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbfKOOQJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Nov 2019 09:16:09 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35969 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbfKOOQI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Nov 2019 09:16:08 -0500
Received: by mail-wr1-f65.google.com with SMTP id r10so11168931wrx.3
        for <git@vger.kernel.org>; Fri, 15 Nov 2019 06:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mRcPan6gwhuTjJc3zOP220A6CuVm8SCWShmN02+zsxc=;
        b=fJH07NsjnAFc0wvYT0Qumq0cA8shdOItBz0yk0fBotX2Y8Se/8v2Xt8eM9j5ob4Rr/
         8yz6FqUhpn9d6SNAMSZXm4sy6w5wETkn9XsabuqwJI3VztswooVKAhPIo5thzd/PzPBo
         /09HkQbotxlfPMxk3YfcT3xQgZjwHYlWyI3EmCYk8yKUciDk98LNAhZCsPjMC/YDGa3g
         WNMgD2QU/yDjp+uznQ5feD0Bz+D9BNXoumTonkmwNADrnboCOa3V8OUy5rByWeb3WR8Y
         siTALE9ND/JSWc+Og7WNOGHIZtnZntDdEIhczb9QW4nDr5iaO5usjbzAnn/RVSp7c1iK
         FAPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mRcPan6gwhuTjJc3zOP220A6CuVm8SCWShmN02+zsxc=;
        b=nPeTcz+GQw4ubG5T6LYUlwnRUz8YBeZwesx9+7LRqhCchH8E12SCt+qCEgOpEwjfDe
         Xe8GdaOn5RBjMdRY0mkQEsgbbqDVWnER0ecnSNigtphSHrjHiQwoCBzQ0uX8k7RuEa3A
         SfqiqjYVW/82Dqvv7cQDXN/DpqikJqSOiosW0dqMaEaOSx3eZJtP+3Dyg9vLyyFnvxD/
         nQqfTm/vC5WxUWWhSigA0Gq50nVESjCmUbUyYaxe/A18QU/zx8zRKDRw3PCb+bYRQSy8
         bSCleFNnLGC+x8WDN4pUxgbCiE2PHcYRMYNK4HxZYs3V3T5gOo2xWmNHS/MbJ9bMf1/+
         XorQ==
X-Gm-Message-State: APjAAAXqHtBOQr8rv8PsLRImtn7UecDZsc9a2j0sz9U3qi8n1eAegHsX
        Ff9m123yh0wDYFRwxdHbzI9TI3y/
X-Google-Smtp-Source: APXvYqwm5RhjrI324GVO6jOEY48yz0kHE151ROuK51APEMM9/mWGODoEBENKP0F17ytnQ7/H7jNMZQ==
X-Received: by 2002:adf:fd45:: with SMTP id h5mr16942336wrs.388.1573827365853;
        Fri, 15 Nov 2019 06:16:05 -0800 (PST)
Received: from localhost.localdomain ([2a04:cec0:1050:ac52:b4cd:f6a2:ba59:f1d4])
        by smtp.gmail.com with ESMTPSA id a2sm7907874wrt.79.2019.11.15.06.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 06:16:05 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH v3 6/9] csum-file: introduce hashfile_total()
Date:   Fri, 15 Nov 2019 15:15:38 +0100
Message-Id: <20191115141541.11149-7-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.24.0-rc1
In-Reply-To: <20191115141541.11149-1-chriscool@tuxfamily.org>
References: <20191115141541.11149-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

We will need this helper function in a following commit
to give us total number of bytes fed to the hashfile so far.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 csum-file.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/csum-file.h b/csum-file.h
index a98b1eee53..f9cbd317fb 100644
--- a/csum-file.h
+++ b/csum-file.h
@@ -42,6 +42,15 @@ void hashflush(struct hashfile *f);
 void crc32_begin(struct hashfile *);
 uint32_t crc32_end(struct hashfile *);
 
+/*
+ * Returns the total number of bytes fed to the hashfile so far (including ones
+ * that have not been written out to the descriptor yet).
+ */
+static inline off_t hashfile_total(struct hashfile *f)
+{
+	return f->total + f->offset;
+}
+
 static inline void hashwrite_u8(struct hashfile *f, uint8_t data)
 {
 	hashwrite(f, &data, sizeof(data));
-- 
2.24.0-rc1

