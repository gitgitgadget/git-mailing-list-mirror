Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C188C1FEAA
	for <e@80x24.org>; Sat, 25 Jun 2016 05:24:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751525AbcFYFYX (ORCPT <rfc822;e@80x24.org>);
	Sat, 25 Jun 2016 01:24:23 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35384 "EHLO
	mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751026AbcFYFYV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jun 2016 01:24:21 -0400
Received: by mail-lf0-f66.google.com with SMTP id w130so23688239lfd.2
        for <git@vger.kernel.org>; Fri, 24 Jun 2016 22:24:20 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NC877EJMSrwcoIvf04Y6X/U/FcQJ7SsmHcSINQEAg7M=;
        b=Elh1Oe6hSOp3/6IeoBZK6bDzhelwbZFTAT44jl24FGbjUf/x/mwpkVidZJlxLWUInq
         3HWscMvGoFZNuH8Uu2ENVM/Xt2d1pzolM6E2C9kQEbviDSKsSapnwUYIWoYm7Tx9uytY
         FC2f4FRNAKDwkd/GUtFWYAq6rbl1zv7Yt23GwQHQYuiniVKVdj4WYmCveIXiIN8Vd9JI
         LNXA375fW4EN0G6K1A63WD1pYr177NjkDoUYemyRuvNxkAwlizVwK+m9w+J1l0/pjEO/
         +GBQNMKiHVCDsiSBgbC5IS3lbRx3Ez8DDWMycO3zCAJkVTc6SAFfRk33JZAM+g+wBiLm
         F1Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NC877EJMSrwcoIvf04Y6X/U/FcQJ7SsmHcSINQEAg7M=;
        b=kLurK6qEgi8t/P+6ePDLGstB8QKGiiM23UIVlV8c4YbIurvJd9ET+LMTdmW5R6A/dh
         a9IypRUdDI7yO4i2GMep4FahFD7FYlZL7HbBNN43uYs33+dapyyRTVfCqIz/hmbKIdbP
         LtIq13BhcAoSDDG/hvM7g9A8eS4uwEcBDOHMJvxMv1Rkj4Z/mHuAYwTSPwOzgY4XE99V
         nfqLOpp8Hnu9AMmfJKOUcGrwi9FGGeaQCxjMMITw6CWR/jx+rfJNv9us0BeCzf0tGLed
         4ErIBDJbWC96L6bxt5QpJUO2ITca7u5QqSQyIx0oo7dACezu0llp0LGKXW9hDYmLF6yi
         Thaw==
X-Gm-Message-State: ALyK8tK4JKxvnfX1n6VWEEnb8ZAUK22RNcr0MR343TTeJ+gKyPODbhrS3vx3a9TAMZw/RQ==
X-Received: by 10.46.32.223 with SMTP id g92mr2300126lji.32.1466832254564;
        Fri, 24 Jun 2016 22:24:14 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id s87sm1450921lfg.46.2016.06.24.22.24.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 24 Jun 2016 22:24:13 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 10/12] diffcore-pickaxe: Add regcomp_or_die()
Date:	Sat, 25 Jun 2016 07:22:36 +0200
Message-Id: <20160625052238.13615-11-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.526.g02eed6d
In-Reply-To: <20160625052238.13615-1-pclouds@gmail.com>
References: <20160623162907.23295-1-pclouds@gmail.com>
 <20160625052238.13615-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

There's another regcomp code block coming in this function that needs
the same error handling. This function can help avoid duplicating
error handling code.

Helped-by: Jeff King <peff@peff.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 diffcore-pickaxe.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index 7715c13..2093b6a 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -198,6 +198,18 @@ static void pickaxe(struct diff_queue_struct *q, struct diff_options *o,
 	*q = outq;
 }
 
+static void regcomp_or_die(regex_t *regex, const char *needle, int cflags)
+{
+	int err = regcomp(regex, needle, cflags);
+	if (err) {
+		/* The POSIX.2 people are surely sick */
+		char errbuf[1024];
+		regerror(err, regex, errbuf, 1024);
+		regfree(regex);
+		die("invalid regex: %s", errbuf);
+	}
+}
+
 void diffcore_pickaxe(struct diff_options *o)
 {
 	const char *needle = o->pickaxe;
@@ -206,18 +218,10 @@ void diffcore_pickaxe(struct diff_options *o)
 	kwset_t kws = NULL;
 
 	if (opts & (DIFF_PICKAXE_REGEX | DIFF_PICKAXE_KIND_G)) {
-		int err;
 		int cflags = REG_EXTENDED | REG_NEWLINE;
 		if (DIFF_OPT_TST(o, PICKAXE_IGNORE_CASE))
 			cflags |= REG_ICASE;
-		err = regcomp(&regex, needle, cflags);
-		if (err) {
-			/* The POSIX.2 people are surely sick */
-			char errbuf[1024];
-			regerror(err, &regex, errbuf, 1024);
-			regfree(&regex);
-			die("invalid regex: %s", errbuf);
-		}
+		regcomp_or_die(&regex, needle, cflags);
 		regexp = &regex;
 	} else {
 		kws = kwsalloc(DIFF_OPT_TST(o, PICKAXE_IGNORE_CASE)
-- 
2.8.2.526.g02eed6d

