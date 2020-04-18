Return-Path: <SRS0=qItC=6C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA14C352BE
	for <git@archiver.kernel.org>; Sat, 18 Apr 2020 20:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C97AE221F7
	for <git@archiver.kernel.org>; Sat, 18 Apr 2020 20:19:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iD400bHW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbgDRUTI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Apr 2020 16:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727927AbgDRUTH (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 18 Apr 2020 16:19:07 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C39EC061A0C
        for <git@vger.kernel.org>; Sat, 18 Apr 2020 13:19:07 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id u6so5717091ljl.6
        for <git@vger.kernel.org>; Sat, 18 Apr 2020 13:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=akVZWZipRuuLvNi8D4x2KLm7slZlzXxgE2XA/Tdpt64=;
        b=iD400bHW6mvKG4xDkAZWXWAmnNIu9HF0Eib92scmcWO7S8mitsmBXIwgnDt15vKKd2
         FKalhbV5wIJFiFWSmRnFd2rVPKU60+8mZTXPNzTbqt3BZdgo7FfbVFNgZ2hWWwk2slim
         2Ffhwp4qg2NwnNY+yPMSh/YGuhPI2npy/AN5MAhZ3BslOV4C/GDsQW6cicC9vOwUPj3H
         c12dkeqUhL0mGmnfoQFPIG8gt5aYbbu+F4kOHMo2SJN60xKrmG/EeFY4RE4nbjsSoEIe
         jwlIwpY4hN2363tb34zwoTDob1tgaNJ79eipgrY3p/CcSiYsxqMxSWR/DgL+atq3o9B1
         3BMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=akVZWZipRuuLvNi8D4x2KLm7slZlzXxgE2XA/Tdpt64=;
        b=R1mBBi2K3+w5dYhZ94To8s7U2ZYz+T1hUj6N9mRsr2xkiGjrkwT7aJo6631sSXRhe7
         b+YUYtOPuFtSOouyz7VxpXpd3E7Fp6LSMVZplKsRc6m4e+ccanOcZKgpdFB1OnjiUNbd
         lzYgOQyqRt5Qq7KqOc9d6CsNVDeKxgg/3496Th3aJdQsxdA3Y9LT9olmKYv8R6hM6zB0
         c0XcLOSvwCRo6pIZyaio5bAjObmvZ1+nS3zYJKw/CKHdhZMXiZmc0chAZ0hBcTJiaXq9
         V65+YmxxrG3FzDAJ0g/XJEIHsh4xRv44keakfguoroZTDAXmfhWhTLAsRzd5KUzRl1+R
         pTSg==
X-Gm-Message-State: AGi0PuYwuzaU+NQCAzTY15gI4chW2vG3puBi43Wa2QgiNwKSc5j52lNF
        PDmVEF93Qnx9KKzqL8n0PtwLp+XE
X-Google-Smtp-Source: APiQypLPfyQZDUU4mf5zR4Fm7D95owvCgake33+/KRBoZhpR6r4Iqu+OgwYjE8P1RrtZarMcTyt1tQ==
X-Received: by 2002:a2e:7610:: with SMTP id r16mr1990818ljc.156.1587241145615;
        Sat, 18 Apr 2020 13:19:05 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id 73sm218713ljj.72.2020.04.18.13.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 13:19:05 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH 3/6] strbuf: use `strbuf_attach()` correctly
Date:   Sat, 18 Apr 2020 22:18:26 +0200
Message-Id: <c21fd9b168ae8248954bc94896d283e9857702ef.1587240635.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <cover.1587240635.git.martin.agren@gmail.com>
References: <CAN0heSppn6BBX4V1T1qgKc4XP+8i6qbcEqd1_3NqWQtZJLaJww@mail.gmail.com> <cover.1587240635.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Similar to earlier commits, don't pass in the same value for `len` and
`alloc` to `strbuf_attach()`. This string comes from
`reencode_string_iconv()` which ensures we have an extra byte at the
end.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 strbuf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/strbuf.c b/strbuf.c
index bb0065ccaf..deb338412e 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -152,7 +152,7 @@ int strbuf_reencode(struct strbuf *sb, const char *from, const char *to)
 	if (!out)
 		return -1;
 
-	strbuf_attach(sb, out, len, len);
+	strbuf_attach(sb, out, len, len + 1);
 	return 0;
 }
 
-- 
2.26.1

