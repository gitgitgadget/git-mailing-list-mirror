Return-Path: <SRS0=1y/A=EO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F44C56201
	for <git@archiver.kernel.org>; Sun,  8 Nov 2020 21:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71998206ED
	for <git@archiver.kernel.org>; Sun,  8 Nov 2020 21:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HkSHmh1I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729028AbgKHVls (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Nov 2020 16:41:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729000AbgKHVln (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Nov 2020 16:41:43 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BCAFC0613CF
        for <git@vger.kernel.org>; Sun,  8 Nov 2020 13:41:42 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id 11so7847689ljf.2
        for <git@vger.kernel.org>; Sun, 08 Nov 2020 13:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vcV0vglRx9nmDckBNMq7BEzj7qmvg5JGZ1EvcOSq/Uw=;
        b=HkSHmh1IxET3bBNYBKn5ns3ZMXv1BMAR7JCf+e56LART5uLnlIOYmOB8N6knJ1k4tn
         Dse48pn9cKJTTd4EkGwuZel9lBlor7rToRNH5k5QMitsoN++zOWYCwUUtzBpyFeS3R1P
         wBDaaQ2u7EOHvj2OhRWRTNSxPaBlMtdzXpsXLO4YVVIu73gyGgKdULtOSlmZtGO9JkL9
         XfmPk0XaxpKeSzG2o1stfTNTJ6R/2QnHAIMXc2byUI2juXvOx+FVLZnEVffIo2ypZ/6t
         8tnd+sx54k3tdJ9EdlNBPBL5/kI01jLME1pzIaZ+ef9O/3ootcIysDSZcSxKAmcyimcU
         mQCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vcV0vglRx9nmDckBNMq7BEzj7qmvg5JGZ1EvcOSq/Uw=;
        b=ax3QmrJcE/b1ShOKLPIixRD4pSEDK6qnayGeGXflYYxWz2zddSXYoMCKuONrySqeHw
         dDri+/uBmsa3rw4mQrrs1GhOnvzC+uWO/eBZnchyvyNUx9dmo0up6Ff9lYNH7sRjMJ/P
         WZ9RHzzQSPjsqJa/2uBZy5XhiM9SiXpMVGh2FEdmV4iQ2jc7fnFdhkBQ5C0kWXgzJrDJ
         XwsvAz2VI3nMkE/hqkvQXH9ZIgOlBrAgYJuQztUJczvOVVaCEoEADWJ4GAJay7eoPi4m
         8NbG8+OvGb/GvMRDdr23/AdNHVj25IwC15uJcRIwWcspKRL7afKZA6JtDHUDeC4ZwLZd
         RktA==
X-Gm-Message-State: AOAM531S08pjziUm0nyEdRjtbNGY5xFdlGP7Y9x24Ejlv/SlHgKhrAby
        i5XX9XN84Mf50JZqX+6yvck=
X-Google-Smtp-Source: ABdhPJxgLsNeoS2KWDW2S15UolOodbpkXnjdybj7NRkSJPNmWBeh5R1TAJKAg4ueK0nRJSkAGt7Avg==
X-Received: by 2002:a2e:998b:: with SMTP id w11mr4871366lji.146.1604871700673;
        Sun, 08 Nov 2020 13:41:40 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id k21sm1937392ljb.43.2020.11.08.13.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2020 13:41:40 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v1 22/27] diff-merges: implement new values for --diff-merges
Date:   Mon,  9 Nov 2020 00:38:33 +0300
Message-Id: <20201108213838.4880-23-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201108213838.4880-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
 <20201108213838.4880-1-sorganov@gmail.com>
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

