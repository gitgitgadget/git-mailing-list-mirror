Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B5411F453
	for <e@80x24.org>; Thu, 17 Jan 2019 13:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbfAQNI6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 08:08:58 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39105 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfAQNI6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 08:08:58 -0500
Received: by mail-pg1-f195.google.com with SMTP id w6so4434138pgl.6
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 05:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8w3AJFV1CoFG5QDS/DH8MSJK2Tx/vcQhHKq+FBjOAxA=;
        b=XmCXwnt9fyL3e6oj9bpW4qod29kus6XntF/57DGSptzFDkzGjET7LcEJJOt4TPqFOG
         Ht6gMAAgBnFXFKDrFDWQIzxPqRbQcYBfcoY6jT3blFAgcxeXHACm7pP8PnyJeemExSrt
         y3MuGezeROiJOd/1+OpKYhPreF0WezRm+S0sjEd1Wb5EozZ2Pdh1+7laA25XRKEn9Iuq
         oNdQdjEXgRKlGEMgfV244winCOaqI75BXGAJKoTAFLfj3LArJQ++AgAUQIwJZJZ95Ab0
         Mpu5+JNJf2KrkQ/AyQKf9iYCA5qT0ZbUNgP+NRgxAJq7+crqdLl25Se5+b/USq91bHyx
         bGNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8w3AJFV1CoFG5QDS/DH8MSJK2Tx/vcQhHKq+FBjOAxA=;
        b=ZY7FDHlfm3tPLaZRDrHbbDyJ6gakUthZoiboj8DxwmPE4UA2T3szZ38u+gMXn6bL+X
         5++O80z9vyR65kXT3qPT9dzDEScoqHCR1aA1F3jQY1zkslpWEPm+2d8MHv+VIEdA1HzQ
         7ZoUJTUu+eFy+nCqYip1UbULpG29/b5c9uFknKJrjtUL7Q52NusJY6ft/wQZtprBWbK5
         XL9ROfVEv+IzPnwSkl1tTQzmfEi7RlqPMbULGlNG0yrCKTN/uK9U+groK+IapgCi0U6f
         oVBJvT1AhgOCNjwvRCsi5czLGzfxT3BaIMe/RCAhpYgSaqSEtgcbc4zIyul7UZURi3W+
         2zdw==
X-Gm-Message-State: AJcUuke13LT1JoeBpMdvaaY9JTAqHiydgLcWH5507ywW+R1omcYzx9f1
        8k/mjivIrbTN3IhRWrEwoJOvr74l
X-Google-Smtp-Source: ALg8bN4CUYdAI2FJZss8S7iV7gYWasrrmVMLg+SAw7FScCHmctyELPxYS9hUP4e15Th9atygCLCS5A==
X-Received: by 2002:a63:ee4c:: with SMTP id n12mr13071747pgk.21.1547730536782;
        Thu, 17 Jan 2019 05:08:56 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id m3sm4927092pff.173.2019.01.17.05.08.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 05:08:56 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 17 Jan 2019 20:08:52 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 29/76] diff.c: convert -M|--find-renames
Date:   Thu, 17 Jan 2019 20:05:28 +0700
Message-Id: <20190117130615.18732-30-pclouds@gmail.com>
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
 diff.c | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/diff.c b/diff.c
index d4c378e836..6397d7a606 100644
--- a/diff.c
+++ b/diff.c
@@ -4913,6 +4913,22 @@ static int diff_opt_dirstat(const struct option *opt,
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
@@ -5044,6 +5060,10 @@ static void prep_parse_options(struct diff_options *options)
 			       N_("break complete rewrite changes into pairs of delete and create"),
 			       PARSE_OPT_NONEG | PARSE_OPT_OPTARG,
 			       diff_opt_break_rewrites),
+		OPT_CALLBACK_F('M', "find-renames", options, N_("<n>"),
+			       N_("detect renames"),
+			       PARSE_OPT_NONEG | PARSE_OPT_OPTARG,
+			       diff_opt_find_renames),
 
 		OPT_GROUP(N_("Diff other options")),
 		{ OPTION_CALLBACK, 0, "output", options, N_("<file>"),
@@ -5078,13 +5098,7 @@ int diff_opt_parse(struct diff_options *options,
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
@@ -5367,13 +5381,10 @@ static int diff_scoreopt_parse(const char *opt)
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
2.20.0.482.g66447595a7

