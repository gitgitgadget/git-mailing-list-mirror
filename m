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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8FE7C433B4
	for <git@archiver.kernel.org>; Thu, 20 May 2021 21:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A63646135C
	for <git@archiver.kernel.org>; Thu, 20 May 2021 21:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbhETVst (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 17:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbhETVss (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 17:48:48 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59AFC061761
        for <git@vger.kernel.org>; Thu, 20 May 2021 14:47:26 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id b26so10630849lfq.4
        for <git@vger.kernel.org>; Thu, 20 May 2021 14:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v7LjQ1nCHmH3DD5i6uodYrBsR+g7A7XW0vpjyrg6Y0E=;
        b=XDCiG78FAz9tCq04kZ3tiJtaDrP0Hul3TN8Shm1q+uiX2BiFRXewpZqGUpXMbp3mT8
         asMiU2DW278mUIPc7dHzVS6evH7d0mn74FIdCO8oZmNpD0egE3P1+oaSxENNtMpPnTRD
         YGi8v/BfY/42LdTMKwMP458zbQwfA32eocRdHc3VJ63a+XfX+GSRni8d0WPg51CBlLzF
         EZf89N27cB3iQ5kqFDyuGXLlkmItjb3zPJVQ33wk0Yb236SdBUsi7Hj8k15VlC8EC9VQ
         i5cwgRs10jE+yjCqc96sNXeU29w2BVx3FQVqHPkiksEyzwCBNC8t8iIFOB6udn6Zrurn
         fh+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v7LjQ1nCHmH3DD5i6uodYrBsR+g7A7XW0vpjyrg6Y0E=;
        b=M8uK1vxZLR1+sO8ld+0uL+leMrqs5hRr0//+ee67bU9g8nZERyOha/DiU4G1OYwqFz
         JmiTybSK2S9+jxVqEQv2Dvv4n1qKdPQ/5Ql77W9OfIYK4bjkiX7ZXBvpMQPtL8rWl9CA
         ZaVgw2yPyrC8s4qLuNH7Ai3sWet0kiMqDFoT6b8QSa4w8FyLoM12jXWaaD4LQDijtanv
         U3x5e3z/CnEsSivaW5aFFoz2fYJV3hg7u5/KVZ0BOWknV6G8Wu2poJsQ11QBtMkxOt36
         UtlFKm8JvSoHV1HezfcrtMpOWJYaKQOHO8EgRmtoMS/OUIshW3L9jtowlwf0J+NuvlwK
         JA4A==
X-Gm-Message-State: AOAM531PYv5Nv4AbnazUsBV/PmNAAjiE+B51qW0owGPrFJo+TJYgvLic
        BKVI1nJqfDWuWNDimMqxNeM=
X-Google-Smtp-Source: ABdhPJzED25w4kwpOFNRF2GUdkAxUqssM9XYcRR5F4/7kgyCFKEE9xCp0toiKbKL+m1wehBjSml1Tg==
X-Received: by 2002:ac2:4919:: with SMTP id n25mr4471117lfi.646.1621547245062;
        Thu, 20 May 2021 14:47:25 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id p2sm408414lfh.31.2021.05.20.14.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 14:47:24 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Alex Henrie <alexhenrie24@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        huang guanlong <gl041188@gmail.com>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v3 09/10] diff-merges: rename "combined_imply_patch" to "merges_imply_patch"
Date:   Fri, 21 May 2021 00:47:02 +0300
Message-Id: <20210520214703.27323-10-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210520214703.27323-1-sorganov@gmail.com>
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
 <20210520214703.27323-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is refactoring change in preparation for the next commit that
will let -m imply -p.

The old name doesn't match the intention to let not only -c/-cc imply
-p, but also -m, that is not a "combined" format, so we rename the
flag accordingly.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 diff-merges.c | 10 +++++-----
 revision.h    |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/diff-merges.c b/diff-merges.c
index 9ca00cdd0cc6..d897fd8a2933 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -15,7 +15,7 @@ static void suppress(struct rev_info *revs)
 	revs->combine_merges = 0;
 	revs->dense_combined_merges = 0;
 	revs->combined_all_paths = 0;
-	revs->combined_imply_patch = 0;
+	revs->merges_imply_patch = 0;
 	revs->merges_need_diff = 0;
 }
 
@@ -109,10 +109,10 @@ int diff_merges_parse_opts(struct rev_info *revs, const char **argv)
 		set_to_default(revs);
 	} else if (!strcmp(arg, "-c")) {
 		set_combined(revs);
-		revs->combined_imply_patch = 1;
+		revs->merges_imply_patch = 1;
 	} else if (!strcmp(arg, "--cc")) {
 		set_dense_combined(revs);
-		revs->combined_imply_patch = 1;
+		revs->merges_imply_patch = 1;
 	} else if (!strcmp(arg, "--no-diff-merges")) {
 		suppress(revs);
 	} else if (!strcmp(arg, "--combined-all-paths")) {
@@ -162,9 +162,9 @@ void diff_merges_setup_revs(struct rev_info *revs)
 		revs->first_parent_merges = 0;
 	if (revs->combined_all_paths && !revs->combine_merges)
 		die("--combined-all-paths makes no sense without -c or --cc");
-	if (revs->combined_imply_patch)
+	if (revs->merges_imply_patch)
 		revs->diff = 1;
-	if (revs->combined_imply_patch || revs->merges_need_diff) {
+	if (revs->merges_imply_patch || revs->merges_need_diff) {
 		if (!revs->diffopt.output_format)
 			revs->diffopt.output_format = DIFF_FORMAT_PATCH;
 	}
diff --git a/revision.h b/revision.h
index 93aa012f518e..17698cb51aca 100644
--- a/revision.h
+++ b/revision.h
@@ -193,10 +193,10 @@ struct rev_info {
 			/* Diff-merge flags */
 			explicit_diff_merges: 1,
 			merges_need_diff: 1,
+			merges_imply_patch:1,
 			separate_merges: 1,
 			combine_merges:1,
 			combined_all_paths:1,
-			combined_imply_patch:1,
 			dense_combined_merges:1,
 			first_parent_merges:1;
 
-- 
2.25.1

