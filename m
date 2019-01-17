Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 957951F453
	for <e@80x24.org>; Thu, 17 Jan 2019 13:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbfAQNJk (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 08:09:40 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35483 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfAQNJk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 08:09:40 -0500
Received: by mail-pg1-f195.google.com with SMTP id s198so4448490pgs.2
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 05:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3k9NstZTg5LUv0SY2zQo3T0H8uHon8m6LVbIx+cKj2Y=;
        b=nEyekfzqA38u3qEqQavNajNo5bQG/8zxFEJMB566I/fpZc6Ov+w1LPwGgSCchHw6hW
         xJmdfzVyQusnDYbj+GFyUYHc9vdquvPux1F18YRlHovuTs+0XVchCLdHf9AHkybOyQD4
         b/4KySvgVwt5Wv7qfdUJ4E3dlKAA3zkYT7bS3X91e8ZHb3mey/c49RqN7b5uNm7knQR/
         2JHVUhSiwQb4nTaPPms4zuBYMgOMc5p2IkthH+uBU8STcSQEJSCh5HgZ7T2zxTCTaUBp
         bMiJ3dGtPUofWNylDppzIwTe2pFk9IkBCYDYlzBlWQxJW/unsq4f3dLlq+pEi2YmQkgu
         RM1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3k9NstZTg5LUv0SY2zQo3T0H8uHon8m6LVbIx+cKj2Y=;
        b=ToMpu8KGiTlEQckDnnqoPze+lotmmHccD6TWVKMJSUuAty4Pb5eFhRD2Vjh5DHEyfL
         3i04xQnqdnIUjAmkmYq/aZ0nJkBOLgqO8RgH4shky7tQ50I3lnGddZHoZE3TCmjpnwVX
         mivWQhxf9e2q47i7EeJEPj4EkMh8m1aKq+BYUYzgUC3Xv5ug2HV5JeAn7pGoxPqlFUHm
         I0oaJfTo/PWsuRUb9TggA9pPtBTim1pbjvezHuhf1zHPwgh65cCdgwHCcENcOHLygK79
         GXmm34I4BrStr/q5FHf++tsOudY1dM0ylSnM3AnMOpO/j9laWm7qbnkg1+wEmmszcGA9
         0uOg==
X-Gm-Message-State: AJcUukdSluOiXRh5SAZb17FKNkUTCjrYnzhkSgrfi/sOzCRGUjg9sUAb
        gAlPmUz8jth8SQo4+KZPYzalBSkv
X-Google-Smtp-Source: ALg8bN5HGnyL0s+yV5w3vhl2eAx7n2nv3YADJZYfelt1PQwJXo5F/rAMnCS5iGKGBIfi8J77Cqmrcg==
X-Received: by 2002:aa7:8286:: with SMTP id s6mr14616277pfm.63.1547730579674;
        Thu, 17 Jan 2019 05:09:39 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id p67sm2745194pfg.44.2019.01.17.05.09.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 05:09:39 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 17 Jan 2019 20:09:35 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 38/76] diff.c: convert --patience
Date:   Thu, 17 Jan 2019 20:05:37 +0700
Message-Id: <20190117130615.18732-39-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.482.g66447595a7
In-Reply-To: <20190117130615.18732-1-pclouds@gmail.com>
References: <20190117130615.18732-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 diff.c | 37 +++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/diff.c b/diff.c
index 166ac8b6e5..67a88dcbd1 100644
--- a/diff.c
+++ b/diff.c
@@ -4964,6 +4964,26 @@ static enum parse_opt_result diff_opt_output(struct parse_opt_ctx_t *ctx,
 	return 0;
 }
 
+static int diff_opt_patience(const struct option *opt,
+			     const char *arg, int unset)
+{
+	struct diff_options *options = opt->value;
+	int i;
+
+	BUG_ON_OPT_NEG(unset);
+	BUG_ON_OPT_ARG(arg);
+	options->xdl_opts = DIFF_WITH_ALG(options, PATIENCE_DIFF);
+	/*
+	 * Both --patience and --anchored use PATIENCE_DIFF
+	 * internally, so remove any anchors previously
+	 * specified.
+	 */
+	for (i = 0; i < options->anchors_nr; i++)
+		free(options->anchors[i]);
+	options->anchors_nr = 0;
+	return 0;
+}
+
 static int diff_opt_relative(const struct option *opt,
 			     const char *arg, int unset)
 {
@@ -5131,6 +5151,10 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_BIT(0, "indent-heuristic", &options->xdl_opts,
 			N_("heuristic to shift diff hunk boundaries for easy reading"),
 			XDF_INDENT_HEURISTIC),
+		OPT_CALLBACK_F(0, "patience", options, NULL,
+			       N_("generate diff using the \"patience diff\" algorithm"),
+			       PARSE_OPT_NONEG | PARSE_OPT_NOARG,
+			       diff_opt_patience),
 
 		OPT_GROUP(N_("Diff other options")),
 		OPT_CALLBACK_F(0, "relative", options, N_("<prefix>"),
@@ -5169,18 +5193,7 @@ int diff_opt_parse(struct diff_options *options,
 		return ac;
 
 	/* xdiff options */
-	if (!strcmp(arg, "--patience")) {
-		int i;
-		options->xdl_opts = DIFF_WITH_ALG(options, PATIENCE_DIFF);
-		/*
-		 * Both --patience and --anchored use PATIENCE_DIFF
-		 * internally, so remove any anchors previously
-		 * specified.
-		 */
-		for (i = 0; i < options->anchors_nr; i++)
-			free(options->anchors[i]);
-		options->anchors_nr = 0;
-	} else if (!strcmp(arg, "--histogram"))
+	if (!strcmp(arg, "--histogram"))
 		options->xdl_opts = DIFF_WITH_ALG(options, HISTOGRAM_DIFF);
 	else if ((argcount = parse_long_opt("diff-algorithm", av, &optarg))) {
 		long value = parse_algorithm_value(optarg);
-- 
2.20.0.482.g66447595a7

