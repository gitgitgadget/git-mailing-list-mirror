Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 680BA211BC
	for <e@80x24.org>; Thu, 27 Dec 2018 16:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731104AbeL0Q0L (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Dec 2018 11:26:11 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36163 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729448AbeL0Q0B (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Dec 2018 11:26:01 -0500
Received: by mail-lf1-f66.google.com with SMTP id a16so13003656lfg.3
        for <git@vger.kernel.org>; Thu, 27 Dec 2018 08:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HnpwCGzGdUAAp1yUvgXRSiL9TZARNU+OvCtdXABJFPI=;
        b=JVq4fqL3ujy7L1HqyK9J+Mo6RH9t3lwuOTrh8NDZcieexjaLjC30+YTb845kNo9NHb
         LBI8ly3jdKzf2KdV/XJwp6hYEene5Fc+eZpJ/4IVEjrXp/uJY5KO6RiUE8twhoIr00Qk
         Dj3HVbC/t1ph2wDOgwMKwZbHH5Xj5ZJjDUqekbDVyQe3lnZiTc2bTS+VFmdppkeXPmqj
         2gEcO0Ru6A4enfPfS5LV49X7IxJWfCvzy7w0rLEa12UEzDe9KmFiPbt1go1oeAv/H7c1
         FA8sj626Fb0foUOWgGyXa3eYHJvxl++EbhKxIZe8Rpumk4xqsMYbLPqUc4SYl8iZJbCP
         cUHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HnpwCGzGdUAAp1yUvgXRSiL9TZARNU+OvCtdXABJFPI=;
        b=Nf4tBlX4nEPX2ZRgLE2IIwWhlc+pCAtVsgGdMAPoaUCF4Iu7H2rKvMxTAzrvgZgWPa
         MPkikhoNxJcDtkXcg+RwlX5wu+c0SBADoac6r/2f63GFh/RvzI5tpgwht+yCWx7titcT
         8RPAZ4FqI/4edaYgT4+XNCFXd1JIvT0puhIMDDpbdIlTiAra3rG/k74w6cOfOATx7CaH
         p9ePbRrw+ylrDf6tUgeGYDkFPrKoTqV8Z3jjM26a+1kRRYsrqZ54lZLrpGUeIuV5hq80
         FoMMoojem2EhiFMW90GnUUtZHa6bdo2uVqBZO9efllDl4Xa8tzYUSPX+wNnukRM7t+4W
         FrEQ==
X-Gm-Message-State: AA+aEWax6DwejRNyCxTCsvAXXck0bpHEJdzhx0Qs03B9RaL+OJVvMl1x
        y6MsOFoPmfX9ccZiaPZR/HZdF2gb
X-Google-Smtp-Source: AFSGD/UjJOLXGpqDDesI/QwWLwrQ3rkhtMmdy2hzQvWMa2Vt6hFd7ESakmOrbZPboiivaG1Gbqziiw==
X-Received: by 2002:a19:9508:: with SMTP id x8mr12728753lfd.112.1545927959094;
        Thu, 27 Dec 2018 08:25:59 -0800 (PST)
Received: from localhost.localdomain (c80-216-2-165.bredband.comhem.se. [80.216.2.165])
        by smtp.gmail.com with ESMTPSA id a127sm7643106lfe.73.2018.12.27.08.25.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Dec 2018 08:25:58 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 12/75] diff.c: convert -u|-p|--patch
Date:   Thu, 27 Dec 2018 17:25:33 +0100
Message-Id: <20181227162536.15895-13-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.482.g66447595a7
In-Reply-To: <20181227162536.15895-1-pclouds@gmail.com>
References: <20181227162536.15895-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 diff.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index a866f13c76..59132ceaff 100644
--- a/diff.c
+++ b/diff.c
@@ -4868,6 +4868,13 @@ static int parse_objfind_opt(struct diff_options *opt, const char *arg)
 static void prep_parse_options(struct diff_options *options)
 {
 	struct option parseopts[] = {
+		OPT_GROUP(N_("Diff output format options")),
+		OPT_BITOP('p', "patch", &options->output_format,
+			  N_("generate patch"),
+			  DIFF_FORMAT_PATCH, DIFF_FORMAT_NO_OUTPUT),
+		OPT_BITOP('u', NULL, &options->output_format,
+			  N_("generate patch"),
+			  DIFF_FORMAT_PATCH, DIFF_FORMAT_NO_OUTPUT),
 		OPT_END()
 	};
 
@@ -4896,8 +4903,7 @@ int diff_opt_parse(struct diff_options *options,
 		return ac;
 
 	/* Output format options */
-	if (!strcmp(arg, "-p") || !strcmp(arg, "-u") || !strcmp(arg, "--patch")
-	    || opt_arg(arg, 'U', "unified", &options->context))
+	if (opt_arg(arg, 'U', "unified", &options->context))
 		enable_patch_output(&options->output_format);
 	else if (!strcmp(arg, "--raw"))
 		options->output_format |= DIFF_FORMAT_RAW;
-- 
2.20.0.482.g66447595a7

