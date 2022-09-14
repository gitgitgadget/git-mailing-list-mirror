Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E34ECAAD3
	for <git@archiver.kernel.org>; Wed, 14 Sep 2022 19:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiINTbU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Sep 2022 15:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiINTbS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Sep 2022 15:31:18 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F37443327
        for <git@vger.kernel.org>; Wed, 14 Sep 2022 12:31:16 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id s6so15587845lfo.7
        for <git@vger.kernel.org>; Wed, 14 Sep 2022 12:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=tUlvv27B7qEZlXTXrnTfEI27f0yt1Pxq7vxRgkjzM2g=;
        b=TY2432IdInNXWhFcuZwUj1pQXbJHXxCpZpNipxZO7etc7CdX+ArsiiMzgioHCaPFiS
         aKOj7/cggjOFfPHrzi8/qlVmtf5sNGQqig/uVQbHPCzugDxnRRpaN5nrFAnxgagqUjKK
         rHxzCeFZOn5oppcrbDYxQjK+Eywm0UYEGKpAWgDYhHUX1pFf0jcPiPwf60XnU2MO5EGS
         IT9kOPDpSGexdNkFT0y6F7G8IbUO7t/yOr6uPlqdtiIye+nDBNp1AbmKaYQzkhRbaG6W
         yaGL4Utc2bNHsF0DSpUDzpZkThX4cTqhB4k/nhKJqE4NmaSdMXg2zu0YhBsZji4KJKWt
         v1Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=tUlvv27B7qEZlXTXrnTfEI27f0yt1Pxq7vxRgkjzM2g=;
        b=Hnf0YyHZfSCr5uBBIrxriFLv4tfAJRR6J5b7A7FYZ5MMmllmd6YSIE5IJOutW7hblX
         kk/ImNVwv6MO93NvI3kqbIi9eBHd8JJaAWBYNR/o886iPfI0ThPprep12/im3XK4I4ZC
         X0FOacSMseBSmioJJ/I0r7Z8+JSa+zfr0WJcxRnndIBtWZc/XcuQRLWUbpzkq9ZDGyQD
         qIf1knKVuoZk9k8FdmFRA4HkCg/DF135s0Hd0uKbQQnu9DZdxNpAngP4ChZgl7Kvm9+w
         /vltQC0uLty8kRipuY20l2qBv6XPbo72tgd0wsNS8o0ryWumyAgzwCHaYlxphn5JQkG0
         qUdw==
X-Gm-Message-State: ACgBeo1ojUkcytDlWZV+RdrJLZ9SsQe6l0nrgIHI9t08u8tvxCZLTvtP
        agLVIWJ7WtJYZBGkhAP38ohM6g5O4NM=
X-Google-Smtp-Source: AA6agR7Lo6DKteFV242XRleVJJQUkVx1auHJAi8qnXCOW7kv+YNr5G/xHrUEnBYEtHTTPPduS3pNHg==
X-Received: by 2002:a05:6512:681:b0:489:d509:e076 with SMTP id t1-20020a056512068100b00489d509e076mr13937149lfe.618.1663183874586;
        Wed, 14 Sep 2022 12:31:14 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id u3-20020a05651220c300b0048ad4c718f3sm2522305lfr.30.2022.09.14.12.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 12:31:14 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH 1/3] diff-merges: cleanup func_by_opt()
Date:   Wed, 14 Sep 2022 22:31:00 +0300
Message-Id: <20220914193102.5275-2-sorganov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220914193102.5275-1-sorganov@gmail.com>
References: <20220914193102.5275-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Get rid of unneeded "else" statements in func_by_opt().

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 diff-merges.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/diff-merges.c b/diff-merges.c
index 7f64156b8bfe..780ed08fc87f 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -60,15 +60,15 @@ static diff_merges_setup_func_t func_by_opt(const char *optarg)
 		return suppress;
 	if (!strcmp(optarg, "1") || !strcmp(optarg, "first-parent"))
 		return set_first_parent;
-	else if (!strcmp(optarg, "separate"))
+	if (!strcmp(optarg, "separate"))
 		return set_separate;
-	else if (!strcmp(optarg, "c") || !strcmp(optarg, "combined"))
+	if (!strcmp(optarg, "c") || !strcmp(optarg, "combined"))
 		return set_combined;
-	else if (!strcmp(optarg, "cc") || !strcmp(optarg, "dense-combined"))
+	if (!strcmp(optarg, "cc") || !strcmp(optarg, "dense-combined"))
 		return set_dense_combined;
-	else if (!strcmp(optarg, "r") || !strcmp(optarg, "remerge"))
+	if (!strcmp(optarg, "r") || !strcmp(optarg, "remerge"))
 		return set_remerge_diff;
-	else if (!strcmp(optarg, "m") || !strcmp(optarg, "on"))
+	if (!strcmp(optarg, "m") || !strcmp(optarg, "on"))
 		return set_to_default;
 	return NULL;
 }
-- 
2.25.1

