Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC5271F453
	for <e@80x24.org>; Sat, 16 Feb 2019 11:37:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbfBPLh0 (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Feb 2019 06:37:26 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39617 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbfBPLh0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Feb 2019 06:37:26 -0500
Received: by mail-pg1-f193.google.com with SMTP id r11so6078323pgp.6
        for <git@vger.kernel.org>; Sat, 16 Feb 2019 03:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JnyrUaL/kZL6vPDg/HP2kg0btx0wRK4SlqgkVv2Eras=;
        b=gMWCx2JPEGAFjuDwbqh/ON/XH8JS6N95B7GkH/1gxDHFFSkHG0NFzlVM8INtN8c/VH
         ZafR8NVcPlvNYY41wpWy90/bNUkrDqm48yYZff32ZGKNVN8SGi+FLKAsyD6n0SJEgBDw
         SRenpNTvzinBJjM0MXdXPw4XYAwxPYLa0BqnDwWf8oAXHKdFOkOfen2tWHuHECoL1AtR
         DolFGR2XQWIS8UMG3oj9UwMXrh+uDVTYJ7Bnzdv5fOllWO4DFYwexztovbAa4PtMV6fK
         x9m8/WttKT93cmbmyMsN65XTr78YIPte54EyCCwNxJF9F+jrI6NY9bFaw4HRPpxM6kNq
         s57g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JnyrUaL/kZL6vPDg/HP2kg0btx0wRK4SlqgkVv2Eras=;
        b=Icyx/JrO9cCRWnsf+0lHNOwluKpIFKxKGUy7LVuRYQohZgnhkpqVn1JKrC4s6z633D
         BhZ82huLtg8JPgpICZOiIvcyrcbzRRJxP9FkZsmjLVGmuwa8iVO4JhLLzN7MOX5Y/t41
         Ysz4w06F7TT5V9FDHlRPi+XIMdl67QpX/GyWqhRJFpb49xvNmtY1MB4wys5149Bh1KN6
         tci1RmvRINev1pKWcNdWdgeVQtlCa1+6cVi2xEefUYrJNTi9v9Hz7ZEDg/2OHTg3dnV0
         aGOMWLfv1kW098/T5b2oDT2FxdaGXrzIh1/3ihU4JshsQ7QH4Ncn3LSoazVTPTrr9h93
         9mgQ==
X-Gm-Message-State: AHQUAuZCD7g8mEsfVevTd/be3L6ZoP5P1T8ZTHLTfZoCRdHjuWQDbX5I
        eck9CTh+OASBlK/A1mwpFko=
X-Google-Smtp-Source: AHgI3IaGpI0HB2rHOCPrXkDtdw+rEQ/X747cvWS8IcRNEcxk/JrdTEfq8nVfC3LgK8L6bzVyypXkCw==
X-Received: by 2002:a62:fb07:: with SMTP id x7mr14361148pfm.71.1550317045777;
        Sat, 16 Feb 2019 03:37:25 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id f67sm10987278pff.29.2019.02.16.03.37.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Feb 2019 03:37:24 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 16 Feb 2019 18:37:20 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 03/21] diff-parseopt: convert --dirstat and friends
Date:   Sat, 16 Feb 2019 18:36:37 +0700
Message-Id: <20190216113655.25728-4-pclouds@gmail.com>
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
index 419b6ac4ae..1cdbe8e688 100644
--- a/diff.c
+++ b/diff.c
@@ -4867,6 +4867,22 @@ static int parse_objfind_opt(struct diff_options *opt, const char *arg)
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
@@ -4911,6 +4927,18 @@ static void prep_parse_options(struct diff_options *options)
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
 
@@ -4939,16 +4967,7 @@ int diff_opt_parse(struct diff_options *options,
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
2.21.0.rc0.328.g0e39304f8d

