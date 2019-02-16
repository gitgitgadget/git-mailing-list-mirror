Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE7ED1F453
	for <e@80x24.org>; Sat, 16 Feb 2019 11:38:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728563AbfBPLiT (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Feb 2019 06:38:19 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38911 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbfBPLiT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Feb 2019 06:38:19 -0500
Received: by mail-pf1-f194.google.com with SMTP id q1so6141339pfi.5
        for <git@vger.kernel.org>; Sat, 16 Feb 2019 03:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MVvmZkonIwnPcZzsX4G74xwzpv/hgyMEJNRcgCwHJ3M=;
        b=iyGb6AHF2eRIfMZbVvKhfVWMcWEdUDBjrcqIUvb1fO2C/18/SVCHn0cc2ApdJ1aowM
         UvlrwkrbH2CQM6FZfm+y7jzTMrochpquKGs7XLsmo2sV91uoixYgDAeL5o9VzM5Iy18k
         EN4MTA08kdMOJ3nV14TSErzsAdlNuOFuwYa521qxiAGhYqpLQ/L+G24crHd6S7H/rOqv
         u20T/OECUWd6pg4OJdOi5k5D5M3bskrdS+xTBmn3igDk4sS8l0V6fZ9xeXJjaEcaQxOE
         YEtgyYh5viRDWKvG2dlLiOJ9XHP38FP9gf68UtL3k8v5XLwwJMZCOppgXnybpdrhpxL1
         gu7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MVvmZkonIwnPcZzsX4G74xwzpv/hgyMEJNRcgCwHJ3M=;
        b=JWGztmiarttJSUdgw49jaDM/3NoMztO61VEhDRTP/v7d4U4Qw3YoQCiGmoErajZz4V
         Gn6LBdWq1et+dRTB0E3uPmJTXbJ9vJSEjqUJGrn01yA6QFhoPQer1iG727BwiI9QOcxv
         4oBwhkG5zP1g/73ybACbQW6oFkefSuVtBrOxElqR1pzkRPQpHfmso5utgCXSi5N1vMkY
         HrMEBgFkI+W/MnOKYaOhyY576yeJnsATJhOo8hObVJp0KgL6PkGmkZzx81gyqpO5sRiQ
         RNGbFkv0uxj4XOlbI0SIuaIIKvyiVmrTq/foG2nUhTDcWN/B2i5r0KmRqFJC7LqIK63Y
         itjQ==
X-Gm-Message-State: AHQUAuaZILgtOi2+svJvdd/3RYZ2bYWZy5/roS78sNOxusFunP4hNc7d
        dtJMS2yXhz7zqzoA0oUd+RI=
X-Google-Smtp-Source: AHgI3Ibc8ZcIQnwRIL2bNJRZAIB3APH8vELBdlzDk6lBIsrKAx/KmagYFeVda1myYE1oCLlA3fo/Yg==
X-Received: by 2002:a62:f201:: with SMTP id m1mr2793096pfh.97.1550317098385;
        Sat, 16 Feb 2019 03:38:18 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id 67sm22331020pfl.175.2019.02.16.03.38.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Feb 2019 03:38:17 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 16 Feb 2019 18:38:13 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 14/21] diff-parseopt: convert -M|--find-renames
Date:   Sat, 16 Feb 2019 18:36:48 +0700
Message-Id: <20190216113655.25728-15-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc0.328.g0e39304f8d
In-Reply-To: <20190216113655.25728-1-pclouds@gmail.com>
References: <20190207103326.10693-1-pclouds@gmail.com>
 <20190216113655.25728-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/diff.c b/diff.c
index d2139082b7..2c904e0526 100644
--- a/diff.c
+++ b/diff.c
@@ -4909,6 +4909,22 @@ static int diff_opt_dirstat(const struct option *opt,
 	return 0;
 }
 
+static int diff_opt_find_renames(const struct option *opt,
+				 const char *arg, int unset)
+{
+	struct diff_options *options = opt->value;
+
+	BUG_ON_OPT_NEG(unset);
+	if (!arg)
+		arg = "";
+	options->rename_score = parse_rename_score(&arg);
+	if (*arg != 0)
+		return error(_("invalid argument to %s"), opt->long_name);
+
+	options->detect_rename = DIFF_DETECT_RENAME;
+	return 0;
+}
+
 static enum parse_opt_result diff_opt_output(struct parse_opt_ctx_t *ctx,
 					     const struct option *opt,
 					     const char *arg, int unset)
@@ -5040,6 +5056,10 @@ static void prep_parse_options(struct diff_options *options)
 			       N_("break complete rewrite changes into pairs of delete and create"),
 			       PARSE_OPT_NONEG | PARSE_OPT_OPTARG,
 			       diff_opt_break_rewrites),
+		OPT_CALLBACK_F('M', "find-renames", options, N_("<n>"),
+			       N_("detect renames"),
+			       PARSE_OPT_NONEG | PARSE_OPT_OPTARG,
+			       diff_opt_find_renames),
 
 		OPT_GROUP(N_("Diff other options")),
 		{ OPTION_CALLBACK, 0, "output", options, N_("<file>"),
@@ -5074,13 +5094,7 @@ int diff_opt_parse(struct diff_options *options,
 		return ac;
 
 	/* renames options */
-	if (starts_with(arg, "-M") ||
-		 skip_to_optional_arg(arg, "--find-renames", NULL)) {
-		if ((options->rename_score = diff_scoreopt_parse(arg)) == -1)
-			return error("invalid argument to -M: %s", arg+2);
-		options->detect_rename = DIFF_DETECT_RENAME;
-	}
-	else if (!strcmp(arg, "-D") || !strcmp(arg, "--irreversible-delete")) {
+	if (!strcmp(arg, "-D") || !strcmp(arg, "--irreversible-delete")) {
 		options->irreversible_delete = 1;
 	}
 	else if (starts_with(arg, "-C") ||
@@ -5363,13 +5377,10 @@ static int diff_scoreopt_parse(const char *opt)
 		if (skip_prefix(opt, "find-copies", &opt)) {
 			if (*opt == 0 || *opt++ == '=')
 				cmd = 'C';
-		} else if (skip_prefix(opt, "find-renames", &opt)) {
-			if (*opt == 0 || *opt++ == '=')
-				cmd = 'M';
 		}
 	}
-	if (cmd != 'M' && cmd != 'C')
-		return -1; /* that is not a -M, or -C option */
+	if (cmd != 'C')
+		return -1; /* that is not a -M option */
 
 	opt1 = parse_rename_score(&opt);
 	if (*opt != 0)
-- 
2.21.0.rc0.328.g0e39304f8d

