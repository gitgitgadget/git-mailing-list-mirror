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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A51C2BBCA
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 18:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A70B2342C
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 18:53:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732310AbgLPSwh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 13:52:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732287AbgLPSw1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 13:52:27 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED755C0619D5
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 10:50:51 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id x20so31451011lfe.12
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 10:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XNZYNV+1JUMPyUPIvJoRxGWB0n+bQOA318/2sPShQWk=;
        b=qeDdJCYTqbfUMq/JLUH2lb3l2KzRA6ZYKvnItmBHF86mWR2yOTL2JxJDcQ8GiDP+z6
         mPGkOL0TuUUoDHUjzq8j32v30IfHm7i7Gk97SBN9iVTgN0cA44h/Sr62t1Y6HNGPV3A/
         5HdZkcmZlYElDg2rnGOWyrTfYrzc95nf6dFC7U7HxjXUHRQRCPYOswEOPM7t/8Wt0hGS
         M45pE10beZ0wguouIKkvfxWw3JoAsKyEkdhzQB+TGxCBW40RC3N1scOEsnNkSC+T039R
         DF9iB0C+0IJH+MLuRVKX0rnlcoptArnUtHyBfvFmiJ7buuKJFcbhHtkHcGC7kQsicJm0
         C0Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XNZYNV+1JUMPyUPIvJoRxGWB0n+bQOA318/2sPShQWk=;
        b=ddQd70aZyjsKDP5rOZCdehcyh6ZSc+ndJIz9+f4sSsPdx8LrqpgKU0eZ4IcG9MalZL
         u/VEKjP8lB4gCI86krV8PBHT0SCPaTo/NzZR5ceHZfAyn6JFdHFU+hivyWeea9iF7qop
         WZiVCEnZRO4FHMP6qWcyrln5Csm5GgyNhLH6Mp428VGJxgyz6pxFc3jvr/38D0eL2c0G
         181KZGLVrDik/vSTnR3YL/1JEBop3V/X0n7aou3C3L4/OH1gdmJJHHSK9jUGDA4wVisk
         qHIIYeFSXxpYfI0cB5mZm47LuSeoh5g4+cbTA9IabBhoXG9pc1lnGUNacLEQyhrC/XzX
         3ksA==
X-Gm-Message-State: AOAM532tYn5YD1OG2F1fK2lCCDSOv46N1fhqkPFF7gFYsWxHqZa17qL4
        ngGiHMMlf/52NEUOUCqiY3o=
X-Google-Smtp-Source: ABdhPJyfaL3KrnPjMClsTJh7gID/HqHk/Yl7quzN/0ICLl7kJ3AYIxzdPl2J9k0Vnz6Oh6VuCTMSpA==
X-Received: by 2002:a2e:a58e:: with SMTP id m14mr15616153ljp.1.1608144649700;
        Wed, 16 Dec 2020 10:50:49 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id 197sm313871lfe.158.2020.12.16.10.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 10:50:49 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v2 22/33] diff-merges: implement new values for --diff-merges
Date:   Wed, 16 Dec 2020 21:49:18 +0300
Message-Id: <20201216184929.3924-23-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201216184929.3924-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
 <20201216184929.3924-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We first implement new options as exact synonyms for their original
counterparts, to get all the infrastructure right, and keep functional
improvements for later commits.

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
index 6446e2093661..cba391604ac7 100644
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

