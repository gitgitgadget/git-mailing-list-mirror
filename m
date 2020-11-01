Return-Path: <SRS0=MFMM=EH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 979D8C388F9
	for <git@archiver.kernel.org>; Sun,  1 Nov 2020 19:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59A0120B1F
	for <git@archiver.kernel.org>; Sun,  1 Nov 2020 19:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JLt63/uO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbgKATeb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Nov 2020 14:34:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727334AbgKATe1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Nov 2020 14:34:27 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72928C061A04
        for <git@vger.kernel.org>; Sun,  1 Nov 2020 11:34:25 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id 23so12637700ljv.7
        for <git@vger.kernel.org>; Sun, 01 Nov 2020 11:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vcV0vglRx9nmDckBNMq7BEzj7qmvg5JGZ1EvcOSq/Uw=;
        b=JLt63/uO+emlMpP54GFdTr71rMJq3bAUAAXG4bIrWuS54EG246nYrKO+nPcuVHVpwU
         ZO9NDqf3c+UmUTu0dOOJpaeSceF+f45CObUikhGf1bCSaxTzXaxnOFLSCYJYBcFFv+ng
         A/A6+GCYkpr64HnfXF38bjSOobBsGT6gH7T8DuSF7TQYKylGWOD5ww0jx7Ah+d6Y1uGE
         Bnj5sj2lc37m1cGU3RX5D+3GA6hwAkcWK/m5ztxIoC8HPncLfStsW8DgBTgUhFqINyB0
         nBv4tdxjKRVaiVL4jSJQnENDsbGb/v2Fj2+e0Z4ZGBa6ohESHcA+SpBnGjAkUqEc0eta
         wqGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vcV0vglRx9nmDckBNMq7BEzj7qmvg5JGZ1EvcOSq/Uw=;
        b=nKMV53P8zABu7qLUHKumj1prcKb5Ms5lmPwESTASJI9GyL9wsCRS6rEuKr3t7VGbkr
         fyFLBH2Kc5od3bQ/FpXp9iX82yAU1ywGU1PTsSSZv5TngP4C7fhsdXOVxNbOzwuF9GhJ
         RoqU9RdEHQvM10O5Z1G2JiEyj96UR3qO0zEcyANY3fW8Rpz1n1fbJDGvdX2S4Tw1OltJ
         FJ5wzZ3EPAyeVJlu/ybj9JWdY+BjA2w1lYkuh+AnQVBdZlG0vBxkqzrphRDeCaJ6Plj7
         lCObdpY9lLNGj1DI2KfQdR4Ep/P0s7yLzQ3ExSbzAWFjpbhQ6BMvU0b5ufAsvaA7NUlQ
         O5kA==
X-Gm-Message-State: AOAM532r5BvB72cijnSvaAjrbHYFH4ZtNnYsgYEB6qpH5T7jbS4NbFws
        y3dtpug87nPUznLI7+xnkkQ=
X-Google-Smtp-Source: ABdhPJxCaEubufK1O3WJGf4lIKewIOjfzu2DGoYc+kwkhGSAlDPkO+TfnmCrvsr9dYM51nS1jrwdBQ==
X-Received: by 2002:a2e:351a:: with SMTP id z26mr5343464ljz.3.1604259264025;
        Sun, 01 Nov 2020 11:34:24 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id m12sm1766526ljc.88.2020.11.01.11.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2020 11:34:23 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH 22/26] diff-merges: implement new values for --diff-merges
Date:   Sun,  1 Nov 2020 22:33:26 +0300
Message-Id: <20201101193330.24775-23-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201101193330.24775-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The following values are implemented:

--diff-merges=	        old equivalent
first|first-parent    = --first-parent (only format implications)
sep|separate          = -m
comb|combined         = -c
dense| dense-combined = --cc

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 diff-merges.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/diff-merges.c b/diff-merges.c
index db2217171442..5c35369f7a8c 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -15,6 +15,11 @@ static void set_separate(struct rev_info *revs) {
 	revs->separate_merges = 1;
 }
 
+static void set_first_parent(struct rev_info *revs) {
+	set_separate(revs);
+	revs->first_parent_merges = 1;
+}
+
 static void set_m(struct rev_info *revs) {
 	/*
 	 * To "diff-index", "-m" means "match missing", and to the "log"
@@ -38,11 +43,19 @@ static void set_dense_combined(struct rev_info *revs) {
 }
 
 static void set_diff_merges(struct rev_info *revs, const char *optarg) {
-	if (!strcmp(optarg, "off")) {
+	if (0) ;
+	else if (!strcmp(optarg, "off")   || !strcmp(optarg, "none"))
 		suppress(revs);
-	} else {
+	else if (!strcmp(optarg, "first") || !strcmp(optarg, "first-parent"))
+		set_first_parent(revs);
+	else if (!strcmp(optarg, "sep")   || !strcmp(optarg, "separate"))
+		set_separate(revs);
+	else if (!strcmp(optarg, "comb")  || !strcmp(optarg, "combined"))
+		set_combined(revs);
+	else if (!strcmp(optarg, "dense") || !strcmp(optarg, "dense-combined"))
+		set_dense_combined(revs);
+	else
 		die(_("unknown value for --diff-merges: %s"), optarg);
-	}
 }
 
 /*
-- 
2.25.1

