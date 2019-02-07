Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54E0C1F453
	for <e@80x24.org>; Thu,  7 Feb 2019 10:34:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726850AbfBGKeB (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 05:34:01 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45381 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbfBGKeA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 05:34:00 -0500
Received: by mail-pf1-f195.google.com with SMTP id j3so2438163pfi.12
        for <git@vger.kernel.org>; Thu, 07 Feb 2019 02:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kjW04yXQHuPYq+B9+zcShwijACedN+skmxNVkWIgkSc=;
        b=AcFsDBEyqUVde80koilcbskOHn5PRDAzvixaF8sEY9/VKQTpR/2j4PAQx6dVNdjBEn
         oDXyt3CWApSK7oiNrWIfNkTbTRtq65LUZ0JGQa+8mrkHfi5YtzHzEuj/OJXBS+0WsspD
         jPGqvrkm3764zw0S/5b3JBcXdGAcB/WFcYl+4PZ/m1d+f2UOq0wdiiSNCmligavRqo7A
         //VOi4tMuNZki4GsPpDwOUm8t+iPdLHDdsQRbKJYqAajbKYyRXINhzh2k2Dqqp0bhooK
         xsS5l/Gz3l5YuQNrV2gxbxaP09/G7Kay44e4a75xwLuZCnOmrnlkthSr8nHynobXnMIY
         fQ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kjW04yXQHuPYq+B9+zcShwijACedN+skmxNVkWIgkSc=;
        b=BHPmKUS8IDJ+LTt/M8ZHbSfnTYlOb60g0XA77xJ86SYMZe0HMcpP5Oyu7FVIL4mXaS
         bTjQ83BCGVLfQXqZsPRhloDLzL5bZMeaLZBaSAtASwx5p8u3YQUljMjSsKUMpwRYXEwm
         STFkxFpelqMqM7gcFGOK5CuyJNmf/d4I/6uGXu1GXqFU+AdPxBr4p7YlY4AgQceYELAp
         8tHq//Tbj5gHHmShQDsiycm0ZXuPCq19pz+LJPyf838INkpnehEzS8MNpN86Dgij2wEn
         gxMKqB+GKKx4YZpLq9Fzng/oMNiOUimpcstz9p5eq2Z+HcPXY0za/vyPc34e9rTmWZ5e
         ZdsA==
X-Gm-Message-State: AHQUAuZ+3UmRPw1gUSzlHP5U2SUfIRtcEysjPic/c8bzRihgfziGM6AG
        2GuDT7myWxwXPGCZHihEks/PYzoS
X-Google-Smtp-Source: AHgI3IalDmVEUNflst27WyvH1UPo6MkbH7jrijKuxM1aCuGimKtzVwylMWoLZlFbFTjtv5jUAsx8UQ==
X-Received: by 2002:a63:100c:: with SMTP id f12mr14169686pgl.324.1549535639196;
        Thu, 07 Feb 2019 02:33:59 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id b85sm6243765pfm.0.2019.02.07.02.33.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 02:33:58 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 07 Feb 2019 17:33:54 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 03/21] diff.c: convert --dirstat and friends
Date:   Thu,  7 Feb 2019 17:33:08 +0700
Message-Id: <20190207103326.10693-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.1.682.gd5861c6d90
In-Reply-To: <20190207103326.10693-1-pclouds@gmail.com>
References: <20190207103326.10693-1-pclouds@gmail.com>
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
2.20.1.682.gd5861c6d90

