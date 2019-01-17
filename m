Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5E8D1F453
	for <e@80x24.org>; Thu, 17 Jan 2019 13:08:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbfAQNIx (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 08:08:53 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44303 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbfAQNIw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 08:08:52 -0500
Received: by mail-pl1-f194.google.com with SMTP id e11so4720008plt.11
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 05:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jnNym05UjMJkv44/mX+gEhhAsVwm5/wFjLurEtt4WJI=;
        b=eNuGooCZ/sE+nx8slNnJYSoCwuvkPFDXvsl3BGzTcibuyUOPpyZtOk3eaocOpyYIAM
         96Jj+dN4ogELP3HJke2IREXnd7CBXl/68e0jD5wiHIbNQkxzknTp5BqAnpV8VxUGd4Ho
         oYKi26mmAVrGiOMIy41gfFxp/oS3A7304JdFA9/HHmyMasECDpf2nL1zqJwiuAlFVieo
         SZsyhDiBvPiSoAo3M229G9jpOMJb+LQ9+jX5Lv4e8zMDzgUe9tPaepwIBxexCgRZuAF0
         0FDT2FODGBqNuzN3HM1ZEKXb7pYu+QMAsWna+28G1naFepcqwzdI/C/S7Wied6Ss57G+
         jvEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jnNym05UjMJkv44/mX+gEhhAsVwm5/wFjLurEtt4WJI=;
        b=FBx0v7oZHiCUPzaCYtxkHKDJg/WCEp1EY4kduBY1m1y4Bt2ggn2xAWlgimDvVA5D30
         iOIxONdWZJP4+fQ6QCNEJpw5ORLPC63LKFsNRxplg86suZ25i9eamhFr4oA3eYvRdeWx
         0mYh6lgj8zrSksRWTn0jWJ+MWXJgfGn44FNpc8n+dVtM+Xait3wJ1DYRiZXzX3GNqTA9
         9xIuQ8PQZmfOoj5GSKywFbeFhwCcI8juyqTamHjnmDhonpzDxIGavy7PRlHYhKWfHT7F
         JKgU8Rpv1x2ivXm6e0Ru//vDcmv4NDyOkWmKlKP8gfup9w4gxoZmX4OvRLOwoGVvDGKO
         fUGA==
X-Gm-Message-State: AJcUukflojn29HH8JNyLreDYTGtnb0WLTHmsm0Ls1+ouO1wQ43TkEjp1
        Uy5bNQf9BsyDUK6fAXg1OhF97ZRi
X-Google-Smtp-Source: ALg8bN4yNLibTv35E9gzQHakxwQVhHhWGycYFwHObFf6IhEcO4XE0OI0qjAd4s7/i5UF7iS4oEjiew==
X-Received: by 2002:a17:902:720c:: with SMTP id ba12mr14951726plb.79.1547730531914;
        Thu, 17 Jan 2019 05:08:51 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id 6sm3151145pfv.30.2019.01.17.05.08.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 05:08:51 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 17 Jan 2019 20:08:47 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 28/76] diff.c: convert -B|--break-rewrites
Date:   Thu, 17 Jan 2019 20:05:27 +0700
Message-Id: <20190117130615.18732-29-pclouds@gmail.com>
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
 diff.c | 63 ++++++++++++++++++++++++++++++++++------------------------
 1 file changed, 37 insertions(+), 26 deletions(-)

diff --git a/diff.c b/diff.c
index c70de7f358..d4c378e836 100644
--- a/diff.c
+++ b/diff.c
@@ -4844,6 +4844,31 @@ static int parse_objfind_opt(struct diff_options *opt, const char *arg)
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
+	switch (*arg) {
+	case '\0':
+		opt2 = 0;
+		break;
+	case '/':
+		arg++;
+		opt2 = parse_rename_score(&arg);
+		break;
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
@@ -5014,6 +5039,12 @@ static void prep_parse_options(struct diff_options *options)
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
@@ -5047,12 +5078,7 @@ int diff_opt_parse(struct diff_options *options,
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
@@ -5331,17 +5357,14 @@ int parse_rename_score(const char **cp_p)
 
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
@@ -5349,25 +5372,13 @@ static int diff_scoreopt_parse(const char *opt)
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
2.20.0.482.g66447595a7

