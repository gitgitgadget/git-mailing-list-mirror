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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E5CBC4361B
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 18:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74B762342C
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 18:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732266AbgLPSwI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 13:52:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732254AbgLPSwG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 13:52:06 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53CE9C0619DB
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 10:50:59 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id h205so7475493lfd.5
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 10:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l44B7laDWj2kSc0FGsmo3vpcDiHWUHCsFGaPV/JtFto=;
        b=dwoRn2cNXfSHsAINQ6zJ9BuaSvmpX+HpZ274wz03LkEk1mP42d8Woe718HSP5P0mxF
         TdMvVjIuBJsp4QcTPPYRvieYdREZNJtTXgh+czwKH5DHYy27+bNltkLTsrjly3LVp5Y2
         YC1zm+bUTMPHAHy/i+ImBFdecXX/7AG3FQaoBIZM62rF4WpneJLGPaHrDAgdTSzvMNyG
         hQat1yFaJo24Y0s3Y7MpZftjZcQDWBh3sfm83zxIh5JlocipVjtwepFtkja5gMaU/9uP
         CxEGUHCMVe2GAF0FfLimvLSef19vAFjIe7oh7JWW0pgQBXD+tFE/vxEFtlNLdge28263
         9ZYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l44B7laDWj2kSc0FGsmo3vpcDiHWUHCsFGaPV/JtFto=;
        b=qDjM2QS1S3rTCoo2XMj4iZsTOg65WEbczVn4+ypQqgmgHplGVpbRJgcO70Xau5Sx+f
         aZLV1joUhNWx/TiTQQ5d7cw1BHVZV4FpeQgWlaLmsjS69sFVPqy67mYkvHj+bYE0lwbQ
         uA6JA5l7q7xAOC0Uy+REHR/a93RO/dIhJOFZgwrl3Vnu8141o5G3VmuUbysOtzaC8hSx
         xLOmr6ty3AHabpbQmv6K4tYoWWcvB0KLyoju4tav4mcxD+OPmuSRSmZtlzrs9kTTXnpx
         hnOCySHSBAf9LmD68b1nCjfriZ0t6E2vQp3JbhYKrbBnCEnR6KnmhH/kaVREykcLwlFm
         Reaw==
X-Gm-Message-State: AOAM530S5vwcX9lu0mvu+aDkCaxIEsIl2YS45VBSeSnxU7FuRxig9K02
        DDmWOCdFgrqIYIK/CGdiF+w=
X-Google-Smtp-Source: ABdhPJyMLS+8xW3BUYlA5T59C5IzpiKtSrX86h3LbV3mXZw1p3wXN0reXw1nABv1ayZC29WXi7aebQ==
X-Received: by 2002:a2e:2f17:: with SMTP id v23mr1169618ljv.222.1608144657063;
        Wed, 16 Dec 2020 10:50:57 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id 197sm313871lfe.158.2020.12.16.10.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 10:50:56 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v2 28/33] diff-merges: add '--diff-merges=1' as synonym for 'first-parent'
Date:   Wed, 16 Dec 2020 21:49:24 +0300
Message-Id: <20201216184929.3924-29-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201216184929.3924-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
 <20201216184929.3924-1-sorganov@gmail.com>
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
 diff-merges.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/diff-merges.c b/diff-merges.c
index 9492cd2b871d..63a0d78b7730 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -57,7 +57,8 @@ static void set_diff_merges(struct rev_info *revs, const char *optarg)
 		return;
 	}
 	if (0) ;
-	else if (!strcmp(optarg, "first") || !strcmp(optarg, "first-parent"))
+	else if (!strcmp(optarg, "first") || !strcmp(optarg, "first-parent") ||
+		 !strcmp(optarg, "1"))
 		set_first_parent(revs);
 	else if (!strcmp(optarg, "sep")   || !strcmp(optarg, "separate") ||
 		 !strcmp(optarg, "m"))
-- 
2.25.1

