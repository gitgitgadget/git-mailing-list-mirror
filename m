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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07480C4361B
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 18:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C56C02342C
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 18:51:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732201AbgLPSvI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 13:51:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732193AbgLPSvI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 13:51:08 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 366CAC0617A6
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 10:50:27 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id u18so50979868lfd.9
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 10:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mntk2P1SMDCo0h3PhXVMco0wgD/MuotZY2jstjIzPvM=;
        b=rBBkqvaF3DhU9ozOaXuQLxa5dmVrQ7HybPwbf7TRh6zkNewtC1ZtHhsjA39bzGPB38
         ainrh2/TMNxiFkW5cwHB++DjPj7Tqlh298tRIty/b3YiEW8MzC8TCIbA+Fy5TzEHR3dA
         oZj0WkOF8/3Ph5cWNghIMz74kLyMQv53ROINU2EjxiUFZhbw0GDKg5t4H5/LBwLcG8FL
         oTQ3NHuCP8STtVbjxcvxSBEEYQC+OBRRpFjsEkTP2R4cKmpykVnD4kT+6ej4wK1ThyCh
         +OR/h0je/7njfafJsfXAPaX+eLqCXa6KYAAui6tClQp5jHjCqltD1WiMkJn0Yt16z5CI
         BFiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mntk2P1SMDCo0h3PhXVMco0wgD/MuotZY2jstjIzPvM=;
        b=qLsXNFL6AOgYiCDt6RSHDbLqwO8TeCsr00iyEzqBVZKiKd5uyY3jebsTPm2qP08iTH
         cW+Zfmxrejj4H8cYAvPDxAdbqxrrjMvY4/BFS+iDXQjPy8i87Y4xQPBNpcllW4KOpbm5
         PKWbOrh/lgkjJXhVeiC3XIgoFyJSDvFx/1YC5paILmg+Wum7DwsrS0B5GBQE5SDSmv5x
         sU02Mfa1dx1eBJX85DwUwwStsaBc+5xuaUVMbATZozkqzudX7pnfA41KIpyziopmOW2p
         jDhvslNGbl0hcjZUAbltILPO59SdV7uvauRA+WEsZiXpUQcNSQ3HnlBIeJrxvfkSZC4Q
         pf3Q==
X-Gm-Message-State: AOAM530pu+GM2rlVuFH0L0Pe/M1q+kjMdpOgAPKHMgj6F1OKHP0rGfsT
        0987fT8c6JwBFXqUb/JJId4=
X-Google-Smtp-Source: ABdhPJxcdNdYy6OZ1rVQqB2UZK6wOJSyodlr9xUdReXEn75xJ43TRTtVw+deklgIpKn6aXr/svEiGQ==
X-Received: by 2002:a19:ca5a:: with SMTP id h26mr10757438lfj.612.1608144624843;
        Wed, 16 Dec 2020 10:50:24 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id 197sm313871lfe.158.2020.12.16.10.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 10:50:23 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v2 02/33] revision: factor out setup of diff-merge related settings
Date:   Wed, 16 Dec 2020 21:48:58 +0300
Message-Id: <20201216184929.3924-3-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201216184929.3924-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
 <20201216184929.3924-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move all the setting code related to diffing merges into new
setup_diff_merge_revs() function.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 revision.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/revision.c b/revision.c
index 917b14e6ad5b..e4c75d9278c4 100644
--- a/revision.c
+++ b/revision.c
@@ -2191,6 +2191,16 @@ static int parse_diff_merge_opts(struct rev_info *revs, const char **argv) {
 	return argcount;
 }
 
+static void setup_diff_merges_revs(struct rev_info *revs)
+{
+	if (revs->combine_merges && revs->ignore_merges < 0)
+		revs->ignore_merges = 0;
+	if (revs->ignore_merges < 0)
+		revs->ignore_merges = 1;
+	if (revs->combined_all_paths && !revs->combine_merges)
+		die("--combined-all-paths makes no sense without -c or --cc");
+}
+
 static int handle_revision_opt(struct rev_info *revs, int argc, const char **argv,
 			       int *unkc, const char **unkv,
 			       const struct setup_revision_opt* opt)
@@ -2885,12 +2895,8 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 			copy_pathspec(&revs->diffopt.pathspec,
 				      &revs->prune_data);
 	}
-	if (revs->combine_merges && revs->ignore_merges < 0)
-		revs->ignore_merges = 0;
-	if (revs->ignore_merges < 0)
-		revs->ignore_merges = 1;
-	if (revs->combined_all_paths && !revs->combine_merges)
-		die("--combined-all-paths makes no sense without -c or --cc");
+
+	setup_diff_merges_revs(revs);
 
 	revs->diffopt.abbrev = revs->abbrev;
 
-- 
2.25.1

