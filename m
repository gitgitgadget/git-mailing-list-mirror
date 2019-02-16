Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E1C41F453
	for <e@80x24.org>; Sat, 16 Feb 2019 11:38:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728517AbfBPLiO (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Feb 2019 06:38:14 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33304 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbfBPLiO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Feb 2019 06:38:14 -0500
Received: by mail-pl1-f193.google.com with SMTP id y10so6314026plp.0
        for <git@vger.kernel.org>; Sat, 16 Feb 2019 03:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QR3StLo68L3DcTI6VH3Zla5jIJPXUw7zsQh6HluvRV0=;
        b=tz/RWw5EPvIQdOwCziagqz8wfa4d6+wGnPVkIBJO3EIyH+mXvBi1n26800s4wPcYTH
         eC/KuZTRYaDKNH12rI6J/a4X0sWBsQALQI59pL5wq1jl9klT1Oy7QrrRfUWJbEgb9M45
         ZwAVxe3icmm/9Dh8CKF8RkW3BmoSOc2EgnYqBNFvApxs5eV0BpknJunMD50epXeVS3SK
         M1cvL0LvFFtZ0+tc7zAlm+8EbDWJ7/ggNXThetCnuZuCYrSPgCYrTSNfa2r7Vb7NciCp
         uuLM/qwAckC92L5ocIDUq1tl+KvolI9g7CNuOPOlIE1up1E6wxXrofAX6laMLQOX5UdO
         7YFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QR3StLo68L3DcTI6VH3Zla5jIJPXUw7zsQh6HluvRV0=;
        b=mmpZawaJ7jqohxB6JyvtpBh3DJ0vSi//8HiMW1bmy42tVw1v54f18ShX/G5CFQhCM0
         pMwWZve5KuyDHFRZdTwwxC7vn1SQWJznOW43PfbTcWS2TwxfoFmI/4RC7NrqzMn+6iiy
         LSwM3BEEXCtq/XurNxEDSvyx4ZugDBpijuHfPg0gJrXPpg0Jp+lZYhqxb/6qHiAVn30G
         JgG+PCvQUJoQs2wt4iju/q9EMwjMLd5i7qvgu4Yzt/C7V8CRdX70N2Aw7Az/3nVGPybx
         04nlszmPL5GfDth8RnmHfogklpqn/PqjlYh8Vwnhrnzzn95Bv3GCy7Rftu712r7ffVQu
         JL2g==
X-Gm-Message-State: AHQUAuYXs0oW/9+0UjCAecqEsHizKnCB18s/Q7le2VpNCTBIPLlLm9NN
        o+oqNBlS6Jwb7vi7o6q4OmA=
X-Google-Smtp-Source: AHgI3IbJByfD5AV4U54Cnyw3pwiQ/k3EWioVRiGTEdL3JaK2wSjs7MgYZYpeuY1DFhdA/3tq7cE8Mg==
X-Received: by 2002:a17:902:584:: with SMTP id f4mr15536252plf.28.1550317093380;
        Sat, 16 Feb 2019 03:38:13 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id 86sm18347938pfk.157.2019.02.16.03.38.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Feb 2019 03:38:12 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 16 Feb 2019 18:38:08 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 13/21] diff-parseopt: convert -B|--break-rewrites
Date:   Sat, 16 Feb 2019 18:36:47 +0700
Message-Id: <20190216113655.25728-14-pclouds@gmail.com>
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
---
 diff.c | 62 ++++++++++++++++++++++++++++++++++------------------------
 1 file changed, 36 insertions(+), 26 deletions(-)

diff --git a/diff.c b/diff.c
index 8df396cb9a..d2139082b7 100644
--- a/diff.c
+++ b/diff.c
@@ -4841,6 +4841,30 @@ static int parse_objfind_opt(struct diff_options *opt, const char *arg)
 	return 1;
 }
 
+static int diff_opt_break_rewrites(const struct option *opt,
+				   const char *arg, int unset)
+{
+	int *break_opt = opt->value;
+	int opt1, opt2;
+
+	BUG_ON_OPT_NEG(unset);
+	if (!arg)
+		arg = "";
+	opt1 = parse_rename_score(&arg);
+	if (*arg == 0)
+		opt2 = 0;
+	else if (*arg != '/')
+		return error(_("%s expects <n>/<m> form"), opt->long_name);
+	else {
+		arg++;
+		opt2 = parse_rename_score(&arg);
+	}
+	if (*arg != 0)
+		return error(_("%s expects <n>/<m> form"), opt->long_name);
+	*break_opt = opt1 | (opt2 << 16);
+	return 0;
+}
+
 static int diff_opt_char(const struct option *opt,
 			 const char *arg, int unset)
 {
@@ -5011,6 +5035,12 @@ static void prep_parse_options(struct diff_options *options)
 			       N_("specify the character to indicate a context instead of ' '"),
 			       PARSE_OPT_NONEG, diff_opt_char),
 
+		OPT_GROUP(N_("Diff rename options")),
+		OPT_CALLBACK_F('B', "break-rewrites", &options->break_opt, N_("<n>[/<m>]"),
+			       N_("break complete rewrite changes into pairs of delete and create"),
+			       PARSE_OPT_NONEG | PARSE_OPT_OPTARG,
+			       diff_opt_break_rewrites),
+
 		OPT_GROUP(N_("Diff other options")),
 		{ OPTION_CALLBACK, 0, "output", options, N_("<file>"),
 		  N_("Output to a specific file"),
@@ -5044,12 +5074,7 @@ int diff_opt_parse(struct diff_options *options,
 		return ac;
 
 	/* renames options */
-	if (starts_with(arg, "-B") ||
-		 skip_to_optional_arg(arg, "--break-rewrites", NULL)) {
-		if ((options->break_opt = diff_scoreopt_parse(arg)) == -1)
-			return error("invalid argument to -B: %s", arg+2);
-	}
-	else if (starts_with(arg, "-M") ||
+	if (starts_with(arg, "-M") ||
 		 skip_to_optional_arg(arg, "--find-renames", NULL)) {
 		if ((options->rename_score = diff_scoreopt_parse(arg)) == -1)
 			return error("invalid argument to -M: %s", arg+2);
@@ -5328,17 +5353,14 @@ int parse_rename_score(const char **cp_p)
 
 static int diff_scoreopt_parse(const char *opt)
 {
-	int opt1, opt2, cmd;
+	int opt1, cmd;
 
 	if (*opt++ != '-')
 		return -1;
 	cmd = *opt++;
 	if (cmd == '-') {
 		/* convert the long-form arguments into short-form versions */
-		if (skip_prefix(opt, "break-rewrites", &opt)) {
-			if (*opt == 0 || *opt++ == '=')
-				cmd = 'B';
-		} else if (skip_prefix(opt, "find-copies", &opt)) {
+		if (skip_prefix(opt, "find-copies", &opt)) {
 			if (*opt == 0 || *opt++ == '=')
 				cmd = 'C';
 		} else if (skip_prefix(opt, "find-renames", &opt)) {
@@ -5346,25 +5368,13 @@ static int diff_scoreopt_parse(const char *opt)
 				cmd = 'M';
 		}
 	}
-	if (cmd != 'M' && cmd != 'C' && cmd != 'B')
-		return -1; /* that is not a -M, -C, or -B option */
+	if (cmd != 'M' && cmd != 'C')
+		return -1; /* that is not a -M, or -C option */
 
 	opt1 = parse_rename_score(&opt);
-	if (cmd != 'B')
-		opt2 = 0;
-	else {
-		if (*opt == 0)
-			opt2 = 0;
-		else if (*opt != '/')
-			return -1; /* we expect -B80/99 or -B80 */
-		else {
-			opt++;
-			opt2 = parse_rename_score(&opt);
-		}
-	}
 	if (*opt != 0)
 		return -1;
-	return opt1 | (opt2 << 16);
+	return opt1;
 }
 
 struct diff_queue_struct diff_queued_diff;
-- 
2.21.0.rc0.328.g0e39304f8d

