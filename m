Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9789C433E6
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 18:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 701FE2311A
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 18:39:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgLUSjf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 13:39:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbgLUSjf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 13:39:35 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF61C0613D6
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 10:38:55 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id q22so14844113eja.2
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 10:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uqNVrukPiv98OEYmpOc+TgCMU7evmtQo4VRyCVyU6uc=;
        b=DCeCscJlO3aHjWRSISB+S3IClvKxGGGbWdF1sSVQ1vUA1ronYLjqJmjdK4HlkZfh7l
         Kwz/MKYycn7CdX/Ix2k4MHnhKdu7ZrcyY11g4i7jhRKTw2gBPw/mjJ8fsx2w7MqLUGAl
         HBENBuGOvykYYVFHiFntejmn272fmQJmth6CtU7izXixcP6pQBEQ5LVk8Ew3mKq7whdI
         uXatDba6qiYcFb9GOyEu3odxvwUQeq97bcvAA+MwIASi0vu3r9YfqdD2wogID3WtuqAd
         j9FETlGiwz1n61BO2nISp+AB93LkN7EwzhLqxVmCJYSInxa+pURrSndMC0vdcAcKuSrG
         KVMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uqNVrukPiv98OEYmpOc+TgCMU7evmtQo4VRyCVyU6uc=;
        b=XKYgM8iW3blotP2APwCdYzH/Pnf19nA9ia6ek1NoCEGfkbUOI+XGQeR876sFg6ja9l
         VNiTsRKsCH2O0jc7dhf7ke3h2Lm587tEitP8uMPCI4hZ1ofn/ggG7/DSZ+ELtjfbxdK2
         j+X2f4SS7CQxPz6Upv3wyTJ5wI1AWMjnkqKGw5+F3/TCb3XQHFuohMThiAUVXMFKAWaN
         5nkIE/0wMV5ujVF9n+B9QX1OhEexA7DW+nmQB9dQs6ZWUN6q4Rel9ROScVazmTBXa3/6
         WDiMR5Grt4pqpuxY0pZiHepQ3RJVfMe3Aog1AVSItQJ3I2trY5Gj4pvXFwA+nrX1KCnK
         EUwQ==
X-Gm-Message-State: AOAM533TLeJcgSlMXeDCxYD2zZaMfej5fyaOwjoJwCt4XUvNziVQMNbJ
        flQEoMBVR3VIoK+Z4Fbl/QV5yLmijKs=
X-Google-Smtp-Source: ABdhPJyuVo7modspCX5W8NffMj71i7SXMeHtgsNTUhHaC/KapriA36zcQc/xthpro5EnJ7W3hE4WYA==
X-Received: by 2002:ac2:5f06:: with SMTP id 6mr6964074lfq.135.1608564064047;
        Mon, 21 Dec 2020 07:21:04 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id c5sm2220085ljj.67.2020.12.21.07.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 07:21:03 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v3 27/32] diff-merges: add '--diff-merges=1' as synonym for 'first-parent'
Date:   Mon, 21 Dec 2020 18:19:55 +0300
Message-Id: <20201221152000.13134-28-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201221152000.13134-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
 <20201221152000.13134-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As we now have --diff-merges={m|c|cc}, add --diff-merges=1 as synonym
for --diff-merges=first-parent, to have shorter mnemonics for it as
well.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 diff-merges.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/diff-merges.c b/diff-merges.c
index 011bfff1f135..146bb50316a6 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -58,7 +58,7 @@ static void set_diff_merges(struct rev_info *revs, const char *optarg)
 		return;
 	}
 
-	if (!strcmp(optarg, "first-parent"))
+	if (!strcmp(optarg, "1") || !strcmp(optarg, "first-parent"))
 		set_first_parent(revs);
 	else if (!strcmp(optarg, "m") || !strcmp(optarg, "separate"))
 		set_separate(revs);
-- 
2.25.1

