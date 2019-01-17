Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07FE91F453
	for <e@80x24.org>; Thu, 17 Jan 2019 13:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbfAQNIF (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 08:08:05 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36822 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbfAQNIE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 08:08:04 -0500
Received: by mail-pf1-f196.google.com with SMTP id b85so4817340pfc.3
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 05:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oZk41hInI6gFtUtJZ+eGt6KS4pp2DO1rm/eUodgQ78I=;
        b=d5wDrNcxGcdewGJgVV8MbT/mJEzRrMcd0HmYjvY0iPqJ0Y8xjQlydeFtRKwo9gsKm3
         6KKvglSGPdvaNNjFDM+k2XpAFZ1v8YbEs20QR/IBVzrjpJj+KxBhiRp9lq0NXL4HrQsY
         2MC1kfRYeLAqK3SU3opyrthN/Tk8pStV348MgDhzzfdlLlG+fiy/C1bCJrXgxIplm6nL
         OU5BzVKlZ6E8jZcEWqFv5otgS6gCd1S1k0BgYKc6/ECEeO/L12cU8yf9ckJ91IeLaXgk
         3rgHkfrTIEMuTb7im1LBv+s23CCBLLDWY2eYAFygky70Y+t0xd7jWIEDNrCt93iFut3g
         wLGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oZk41hInI6gFtUtJZ+eGt6KS4pp2DO1rm/eUodgQ78I=;
        b=tEa9/0GSWa8PvLZGcpBDf7LPLqQwCRJGBQl4d0wV89GxbTPlcJSGB9deLtM60v81Ha
         ksezrKZLcCxFnSgjLRQ55JwqjHnCEeiV8HI66K1iQ6ydlmIRaJSdNpK24PACJVh/56ne
         v+5nVdu0RV6dMzgyJ0BpoitypGkPNwTjNOapM7UUgnRKcg9KTQLR1mv47RaxfbgWw3WM
         Kl1FeGyKLBzr0ly8VFtJWVHS4NSiu171JMRi4t4hcv3kj69KiYTRo/OUICAilBxGAuA/
         6eQwe2x+5WyAl2EteGdu2ZUPeP980sHtj9MsPUYdd89fQeEX1w/Fggqi1VaFlqLEhxfM
         9FJA==
X-Gm-Message-State: AJcUukel5EdP2g1p/+sgok/m0QB0gstsAqYxoYsAf2q9MkNpkqOWQCBy
        +5mziGtwWpwDIAbrKhMfgqny6ezY
X-Google-Smtp-Source: ALg8bN5CW6ayFvnSrpCmVk/aLuyMNMV0cajXesEDxS6c3lPzNzXCGpITggMlXnvKJUAv7c3gu79gAA==
X-Received: by 2002:a63:61c8:: with SMTP id v191mr13527690pgb.242.1547730483746;
        Thu, 17 Jan 2019 05:08:03 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id x7sm2709122pga.68.2019.01.17.05.08.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 05:08:03 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 17 Jan 2019 20:07:58 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 18/76] diff.c: convert --dirstat and friends
Date:   Thu, 17 Jan 2019 20:05:17 +0700
Message-Id: <20190117130615.18732-19-pclouds@gmail.com>
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
 Documentation/diff-options.txt |  7 ++++++
 diff.c                         | 39 +++++++++++++++++++++++++---------
 2 files changed, 36 insertions(+), 10 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 0711734b12..058d93ec4f 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -148,6 +148,7 @@ These parameters can also be set individually with `--stat-width=<width>`,
 	number of modified files, as well as number of added and deleted
 	lines.
 
+-X<param1,param2,...>::
 --dirstat[=<param1,param2,...>]::
 	Output the distribution of relative amount of changes for each
 	sub-directory. The behavior of `--dirstat` can be customized by
@@ -192,6 +193,12 @@ directories with less than 10% of the total amount of changed files,
 and accumulating child directory counts in the parent directories:
 `--dirstat=files,10,cumulative`.
 
+--cumulative::
+	Synonym for --dirstat=cumulative
+
+--dirstat-by-file[=<param1,param2>...]::
+	Synonym for --dirstat=files,param1,param2...
+
 --summary::
 	Output a condensed summary of extended header information
 	such as creations, renames and mode changes.
diff --git a/diff.c b/diff.c
index 69a4d55e38..1cb410ed3a 100644
--- a/diff.c
+++ b/diff.c
@@ -4865,6 +4865,22 @@ static int parse_objfind_opt(struct diff_options *opt, const char *arg)
 	return 1;
 }
 
+static int diff_opt_dirstat(const struct option *opt,
+			    const char *arg, int unset)
+{
+	struct diff_options *options = opt->value;
+
+	BUG_ON_OPT_NEG(unset);
+	if (!strcmp(opt->long_name, "cumulative")) {
+		if (arg)
+			BUG("how come --cumulative take a value?");
+		arg = "cumulative";
+	} else if (!strcmp(opt->long_name, "dirstat-by-file"))
+		parse_dirstat_opt(options, "files");
+	parse_dirstat_opt(options, arg ? arg : "");
+	return 0;
+}
+
 static int diff_opt_unified(const struct option *opt,
 			    const char *arg, int unset)
 {
@@ -4909,6 +4925,18 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_BIT_F(0, "shortstat", &options->output_format,
 			  N_("output only the last line of --stat"),
 			  DIFF_FORMAT_SHORTSTAT, PARSE_OPT_NONEG),
+		OPT_CALLBACK_F('X', "dirstat", options, N_("<param1,param2>..."),
+			       N_("output the distribution of relative amount of changes for each sub-directory"),
+			       PARSE_OPT_NONEG | PARSE_OPT_OPTARG,
+			       diff_opt_dirstat),
+		OPT_CALLBACK_F(0, "cumulative", options, NULL,
+			       N_("synonym for --dirstat=cumulative"),
+			       PARSE_OPT_NONEG | PARSE_OPT_NOARG,
+			       diff_opt_dirstat),
+		OPT_CALLBACK_F(0, "dirstat-by-file", options, N_("<param1,param2>..."),
+			       N_("synonym for --dirstat=files,param1,param2..."),
+			       PARSE_OPT_NONEG | PARSE_OPT_OPTARG,
+			       diff_opt_dirstat),
 		OPT_END()
 	};
 
@@ -4937,16 +4965,7 @@ int diff_opt_parse(struct diff_options *options,
 		return ac;
 
 	/* Output format options */
-	if (skip_prefix(arg, "-X", &arg) ||
-		 skip_to_optional_arg(arg, "--dirstat", &arg))
-		return parse_dirstat_opt(options, arg);
-	else if (!strcmp(arg, "--cumulative"))
-		return parse_dirstat_opt(options, "cumulative");
-	else if (skip_to_optional_arg(arg, "--dirstat-by-file", &arg)) {
-		parse_dirstat_opt(options, "files");
-		return parse_dirstat_opt(options, arg);
-	}
-	else if (!strcmp(arg, "--check"))
+	if (!strcmp(arg, "--check"))
 		options->output_format |= DIFF_FORMAT_CHECKDIFF;
 	else if (!strcmp(arg, "--summary"))
 		options->output_format |= DIFF_FORMAT_SUMMARY;
-- 
2.20.0.482.g66447595a7

