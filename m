Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82F0D1F453
	for <e@80x24.org>; Thu, 17 Jan 2019 13:09:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbfAQNJH (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 08:09:07 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:32811 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfAQNJH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 08:09:07 -0500
Received: by mail-pf1-f195.google.com with SMTP id c123so4834405pfb.0
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 05:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9ECk5yIBjG0aKPUr4EJZd/3J72ESP3rsJJH/embdTxQ=;
        b=HoEgx92v1V4f9iigvO52+kDFcwPihR6VVbs9lbMPHB4E94o3YFL9LdZnmaqHaFyHoY
         Q9wvv1GjWGr61LxeONgDkh8N8THPbeeynmZPZYWzFFV09sT81NTX9YOLUoHjRIuo5Ey9
         0uH9VXhx7WY0Gupe25f2g8uRShY9e9JEvWhoqv3bLl7ivdlDU4Hcd7a22dlrHE3gHMOu
         B6y83lUvE8yL2Fme+5EM0aJ5K1mtSE1EHFHAGe622P5fIsbn28gzhGO57x1AKkz0+IZg
         y6LycXT/LCRgganGyPBLlb75+GOpVcIcZfkqdAr7ZslAZcBf+xbJ8adPvbKI0rvWTkGG
         PoYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9ECk5yIBjG0aKPUr4EJZd/3J72ESP3rsJJH/embdTxQ=;
        b=idVnsH/XVvwhobuqlwJDbVokJ51J+FybepYGF96eivhye3qDBv+tziXNYtapzvnAUQ
         1WtDVbHqm/FnEPtKt0zLrCV4Xb3wRqgbgxq4aupWbPlaGM0ix1dNF/2X23mupwXIQE5t
         jy49j94BlL7YLkLYyhS8RDlPiPJghiEXLVFavx59URuUlHFIAquBHDsZBh1VDwfhZAVA
         VK6wouyEPtUMthVWIKNZD/B3krPunJSBVqgGbdv+sz1a7sSN56etAnYbJTSayIJa1VP0
         FxoXEJ++qQJI6ZCZJMGnWYO0loFVua+SbPeSeesGkh7Q3//D+k1d8PlXKHXgrVtClVv3
         NALQ==
X-Gm-Message-State: AJcUukfjpj+/a8bgR2XGIjQWdv06+TZIQfrlZUvpw8lP8sBzRemXDHgr
        7Mh9hqMPyo/Q3w5IKv9G7fr1tvYo
X-Google-Smtp-Source: ALg8bN7kVtKN2nCtUT+efElF9TCErEp3+Vdg8vJgyuIAPo5xyHTJsXueDktCG8LF7Ts+dscYHO/s0A==
X-Received: by 2002:a62:5c41:: with SMTP id q62mr15106664pfb.171.1547730546167;
        Thu, 17 Jan 2019 05:09:06 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id v191sm2997417pgb.77.2019.01.17.05.09.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 05:09:05 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 17 Jan 2019 20:09:01 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 31/76] diff.c: convert -C|--find-copies
Date:   Thu, 17 Jan 2019 20:05:30 +0700
Message-Id: <20190117130615.18732-32-pclouds@gmail.com>
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
 diff.c | 59 +++++++++++++++++++++++++---------------------------------
 1 file changed, 25 insertions(+), 34 deletions(-)

diff --git a/diff.c b/diff.c
index e12b7ae101..3b05e03284 100644
--- a/diff.c
+++ b/diff.c
@@ -4621,8 +4621,6 @@ static int opt_arg(const char *arg, int arg_short, const char *arg_long, int *va
 	return 1;
 }
 
-static int diff_scoreopt_parse(const char *opt);
-
 static inline int short_opt(char opt, const char **argv,
 			    const char **optarg)
 {
@@ -4913,6 +4911,26 @@ static int diff_opt_dirstat(const struct option *opt,
 	return 0;
 }
 
+static int diff_opt_find_copies(const struct option *opt,
+				const char *arg, int unset)
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
+	if (options->detect_rename == DIFF_DETECT_COPY)
+		options->flags.find_copies_harder = 1;
+	else
+		options->detect_rename = DIFF_DETECT_COPY;
+
+	return 0;
+}
+
 static int diff_opt_find_renames(const struct option *opt,
 				 const char *arg, int unset)
 {
@@ -5067,6 +5085,10 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_SET_INT_F('D', "irreversible-delete", &options->irreversible_delete,
 			      N_("omit the preimage for deletes"),
 			      1, PARSE_OPT_NONEG),
+		OPT_CALLBACK_F('C', "find-copies", options, N_("<n>"),
+			       N_("detect copies"),
+			       PARSE_OPT_NONEG | PARSE_OPT_OPTARG,
+			       diff_opt_find_copies),
 
 		OPT_GROUP(N_("Diff other options")),
 		{ OPTION_CALLBACK, 0, "output", options, N_("<file>"),
@@ -5101,15 +5123,7 @@ int diff_opt_parse(struct diff_options *options,
 		return ac;
 
 	/* renames options */
-	if (starts_with(arg, "-C") ||
-		 skip_to_optional_arg(arg, "--find-copies", NULL)) {
-		if (options->detect_rename == DIFF_DETECT_COPY)
-			options->flags.find_copies_harder = 1;
-		if ((options->rename_score = diff_scoreopt_parse(arg)) == -1)
-			return error("invalid argument to -C: %s", arg+2);
-		options->detect_rename = DIFF_DETECT_COPY;
-	}
-	else if (!strcmp(arg, "--no-renames"))
+	if (!strcmp(arg, "--no-renames"))
 		options->detect_rename = 0;
 	else if (!strcmp(arg, "--rename-empty"))
 		options->flags.rename_empty = 1;
@@ -5369,29 +5383,6 @@ int parse_rename_score(const char **cp_p)
 	return (int)((num >= scale) ? MAX_SCORE : (MAX_SCORE * num / scale));
 }
 
-static int diff_scoreopt_parse(const char *opt)
-{
-	int opt1, cmd;
-
-	if (*opt++ != '-')
-		return -1;
-	cmd = *opt++;
-	if (cmd == '-') {
-		/* convert the long-form arguments into short-form versions */
-		if (skip_prefix(opt, "find-copies", &opt)) {
-			if (*opt == 0 || *opt++ == '=')
-				cmd = 'C';
-		}
-	}
-	if (cmd != 'C')
-		return -1; /* that is not a -M option */
-
-	opt1 = parse_rename_score(&opt);
-	if (*opt != 0)
-		return -1;
-	return opt1;
-}
-
 struct diff_queue_struct diff_queued_diff;
 
 void diff_q(struct diff_queue_struct *queue, struct diff_filepair *dp)
-- 
2.20.0.482.g66447595a7

