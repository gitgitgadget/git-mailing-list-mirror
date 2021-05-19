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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D65CC433ED
	for <git@archiver.kernel.org>; Wed, 19 May 2021 11:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83AA761004
	for <git@archiver.kernel.org>; Wed, 19 May 2021 11:48:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352480AbhESLuF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 07:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349331AbhESLuC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 07:50:02 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9FA6C061760
        for <git@vger.kernel.org>; Wed, 19 May 2021 04:48:41 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id b26so2651430lfq.4
        for <git@vger.kernel.org>; Wed, 19 May 2021 04:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v7LjQ1nCHmH3DD5i6uodYrBsR+g7A7XW0vpjyrg6Y0E=;
        b=NqmOIRuntpga9l7PIz/C6whuV8J52U2dx2+A6xnehNrGYax9rXaAG9uClmZ02IMRs8
         4v2zVZyuhOHEJCFAcPCoMGxr+D3S0OgWc0KKvqU2Q4sMGEEWS13sUhuTyMufaB4Sykvq
         mSnLB9v72Mhq3RaEkgtQDwKoqvvyorbnq0MJRcbLNo24q9Yuejp7BnB+HqY8Afr0G8aI
         HOcSMNqRBSQY0GXf7Qus1E42xEW3G6DRbWin3HTb5kgdF4fViWJ4Vved03AYjDZo7MUM
         pVmr99rmLqsjRHRq84u5YVWLRec8GexAV8V3gmpWE8RHy08n0ICZowmm1JMsfgQwX7Tw
         CT/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v7LjQ1nCHmH3DD5i6uodYrBsR+g7A7XW0vpjyrg6Y0E=;
        b=fxlEV4HtgHFNZexkt68Rr5t5zw7lEs324EbQ+aELjnNO/zKwXmEzsBEitqNMeeV8tU
         KfV6KqzGrsj3Ry0ETdX9bOf4UMfdUdUDfiJPgx+SlFv5sj0roZo5izen7ob+++OWlN/r
         A9zR1KdVIHEkNMBNZwqObr23AAbOPvlHfOfgA6K0LRXcdoODX2Nc++tbrmCbjr6x610f
         hxvy1t7INuN3DxNU9Lc2am82QjcJpNyVrajP4OqGqW6n1iEAjjKe8ik5yuK5tfL0yFli
         FipKo5c+s7V1fyXPCzuji0YCLiCWLfxgwQ3caJAXxgy/fm0zq9dQG3FwnrHmTksedU/9
         5MKA==
X-Gm-Message-State: AOAM533H4KT2Gj73+BOTcxZKzShkDYcVKpp0yCOAMHkmZe4+4MWWgHpn
        bqWwRJmib9CaaIdYFE8benc=
X-Google-Smtp-Source: ABdhPJxD6l7MZDuGgikrT3nl3nF+BJsbZoenF6o5Vd/+oegKE5HPLLB56IzkV9OmEvl7N37S5sXX7Q==
X-Received: by 2002:a05:6512:3d1c:: with SMTP id d28mr8074044lfv.21.1621424920187;
        Wed, 19 May 2021 04:48:40 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id o2sm1846470ljp.60.2021.05.19.04.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 04:48:39 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Alex Henrie <alexhenrie24@gmail.com>,
        git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v2 8/9] diff-merges: rename "combined_imply_patch" to "merges_imply_patch"
Date:   Wed, 19 May 2021 14:45:51 +0300
Message-Id: <20210519114552.4180-9-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210519114552.4180-1-sorganov@gmail.com>
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
 <20210519114552.4180-1-sorganov@gmail.com>
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

