Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CCADC48BE8
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 22:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E201161363
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 22:59:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232236AbhFMXCA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Jun 2021 19:02:00 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:42509 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232181AbhFMXB7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Jun 2021 19:01:59 -0400
Received: by mail-ot1-f49.google.com with SMTP id w23-20020a9d5a970000b02903d0ef989477so9076676oth.9
        for <git@vger.kernel.org>; Sun, 13 Jun 2021 15:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TsewPFur6US8iCogUp0fhQqt3tQPgXXXzcJV06V66uE=;
        b=Jo+ZwWo/0iImxd2aFDEQomNPMPeujSfZyrFAYtlP5om4vZAyQKzphy8EeHfT8jk9zB
         FnH2a99+p+Zy52BK7ZPFty5llN7TXQW3MFjDcNv/yGtDNdngLPwIwpjQKNIPTxBqw5Un
         jW41DgGVYGgwVxwfQRA35ikzJtBB2gXuSEe5Wa+mE0zdVxU5g0qklWqZQHlOtmtPPcZN
         oxzJ1PcS/z26ayTWqx5oaa8qQSF5kxmcC14wr9LPY0Z6GDPgoPTsIcWkwFNeqEe5f2fU
         PWMhk4kAZkNkvYkbI2BQ/oj66/quk8sZxpGENidpnM1x2ZgNuEHcShzN8eIEaMslhYK1
         nsyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TsewPFur6US8iCogUp0fhQqt3tQPgXXXzcJV06V66uE=;
        b=hF3pyIbysM6jSlrsrrFloUlG2osjMYPTt/bTLNbxLPKu7A5DLQC01rniqJtKeCWrIH
         kw2yepDtddvFnV0Dagv4nS+7tOwNGMawgDN0c5SdTCk8gOdPCiN5uuyqSEB6R4dkqHek
         dNmY+KlTD4daaeFrKApwiYqccXKM9olh7HT/VZpsrcWxusIhW0DZUdpirSZs0ctMfgWq
         SyF0lJpXndajHiEPCsmVYqcilKHhYAge18JqFeUSdg5VBU7NlvwMdFeKMVqz/Gj5u4hq
         LWf1Wf/qiCAZ4/O27P7kzd6m49WvAvi5+qXNFzUoaP5izEPP/k4NE/VW9Aq523KHTN9/
         1O0g==
X-Gm-Message-State: AOAM5320uLUoa+wI5pZonvnNfYc5uqstRZcMGWpe8s5DdkP08Q2Zqe77
        ceOnGHNI7EoF2QNlNXxeKsdUZmic3Z8c9w==
X-Google-Smtp-Source: ABdhPJxwtwS/N5rraMjRxVM9+PtiPZ2l6w0Z5yd9qUtfuJJZV2RfoY7PGyYuawEkJ71PC525CQuwcA==
X-Received: by 2002:a05:6830:16cd:: with SMTP id l13mr10998258otr.171.1623625122831;
        Sun, 13 Jun 2021 15:58:42 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id p9sm2868410otl.64.2021.06.13.15.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jun 2021 15:58:42 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 3/4] xdiff/xmerge: simplify xdl_recs_copy_0
Date:   Sun, 13 Jun 2021 17:58:35 -0500
Message-Id: <20210613225836.1009569-4-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210613225836.1009569-1-felipe.contreras@gmail.com>
References: <20210613225836.1009569-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove one unnecessary indentation level.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 xdiff/xmerge.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
index ab3448ca88..b5b3f56f92 100644
--- a/xdiff/xmerge.c
+++ b/xdiff/xmerge.c
@@ -122,19 +122,19 @@ static int xdl_recs_copy_0(int use_orig, xdfenv_t *xe, int i, int count, int nee
 	for (i = 0; i < count; size += recs[i++]->size)
 		if (dest)
 			memcpy(dest + size, recs[i]->ptr, recs[i]->size);
-	if (add_nl) {
-		i = recs[count - 1]->size;
-		if (i == 0 || recs[count - 1]->ptr[i - 1] != '\n') {
-			if (needs_cr) {
-				if (dest)
-					dest[size] = '\r';
-				size++;
-			}
-
+	if (!add_nl)
+		return size;
+	i = recs[count - 1]->size;
+	if (i == 0 || recs[count - 1]->ptr[i - 1] != '\n') {
+		if (needs_cr) {
 			if (dest)
-				dest[size] = '\n';
+				dest[size] = '\r';
 			size++;
 		}
+
+		if (dest)
+			dest[size] = '\n';
+		size++;
 	}
 	return size;
 }
-- 
2.32.0

