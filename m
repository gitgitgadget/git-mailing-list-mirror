Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 271931F453
	for <e@80x24.org>; Sat, 16 Feb 2019 11:38:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728653AbfBPLiY (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Feb 2019 06:38:24 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37984 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbfBPLiX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Feb 2019 06:38:23 -0500
Received: by mail-pg1-f195.google.com with SMTP id m2so3820704pgl.5
        for <git@vger.kernel.org>; Sat, 16 Feb 2019 03:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2fS6qKe7ncj36/kWfSsq6miHtCaj5G8Mn1SO3NOZXUU=;
        b=K0bJWGnQulV/UvdLmUk352RnY7nEXVByQ+/GNFktMQNCl9Hb7JefI5AZ1JCWj2rhXo
         1NfdM+gK42eoGVI0OEH8E7Xm7XEzap2YpyXx0mwZo6TVA87e2mdISkYzTUVGfrwtPTtg
         5fF+fl5wY5CN6QWAP4I54j4qQb4ebVb5TcHOztxP5yYKChw9EcT4/0SDFuJK4nvgPIo6
         lCpuGVEb1zo7yV1qavyVW/+RRibEBU7g0me+grlVuuA65scA/OnaG8TmVSsw/EbjjjAw
         qSGH+38jjQ/h+AP8CnFRGhdClFVhicXEuK9EMQioO5lH+hVcUeVumxxCtOGBLbM586mY
         +ivA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2fS6qKe7ncj36/kWfSsq6miHtCaj5G8Mn1SO3NOZXUU=;
        b=qZG3Vwk8HjDggVKO6g/2U5iUJ39wK/1IMnoatCAfwTTRiRd7jHptnxcGbTwGXcblZv
         EvYbrGMu/gFGbW1+Y5USbMDQhkK1Bh6asg8I9XGy24Ng6iFqsHR+en9OoFmZTQZzi4PE
         WyM5/5jImLDO4+m0N+XSOzKCp+2FwMGXGBcqfQoOoSVMExJ4UrgfehdS+8vhFbL2HXV2
         qlndF2k30wxkRFzXn8IOB4xQukhTJt6E4Ku6CxQAZsgcMq1TFIKq4Iut+YFCEO61VpV+
         Ox1BpPkHkxya7ymBpsAwyOmddJxxUvEugSboIhmv8g46ezTC88hlhBHEtzmMNhfYW1Xv
         6Vdw==
X-Gm-Message-State: AHQUAuYPI8R07I7UbLD0cEpPCK4sp0pNSoEfcgcrwGhio1J1P605I67I
        KtBlF0YACRfBQf7U3hVf+V8=
X-Google-Smtp-Source: AHgI3IZfxFCS78OvMK3h5oPlNqJatpQsjUOtmJhTh7a8BPdGGMo8Kx+BQl0gChaSDDoluw9Rdzh6nw==
X-Received: by 2002:a65:63d3:: with SMTP id n19mr9876653pgv.179.1550317103013;
        Sat, 16 Feb 2019 03:38:23 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id l22sm13813426pfj.179.2019.02.16.03.38.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Feb 2019 03:38:22 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 16 Feb 2019 18:38:18 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 15/21] diff-parseopt: convert -D|--irreversible-delete
Date:   Sat, 16 Feb 2019 18:36:49 +0700
Message-Id: <20190216113655.25728-16-pclouds@gmail.com>
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
 diff.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/diff.c b/diff.c
index 2c904e0526..e51f6b3005 100644
--- a/diff.c
+++ b/diff.c
@@ -5060,6 +5060,9 @@ static void prep_parse_options(struct diff_options *options)
 			       N_("detect renames"),
 			       PARSE_OPT_NONEG | PARSE_OPT_OPTARG,
 			       diff_opt_find_renames),
+		OPT_SET_INT_F('D', "irreversible-delete", &options->irreversible_delete,
+			      N_("omit the preimage for deletes"),
+			      1, PARSE_OPT_NONEG),
 
 		OPT_GROUP(N_("Diff other options")),
 		{ OPTION_CALLBACK, 0, "output", options, N_("<file>"),
@@ -5094,10 +5097,7 @@ int diff_opt_parse(struct diff_options *options,
 		return ac;
 
 	/* renames options */
-	if (!strcmp(arg, "-D") || !strcmp(arg, "--irreversible-delete")) {
-		options->irreversible_delete = 1;
-	}
-	else if (starts_with(arg, "-C") ||
+	if (starts_with(arg, "-C") ||
 		 skip_to_optional_arg(arg, "--find-copies", NULL)) {
 		if (options->detect_rename == DIFF_DETECT_COPY)
 			options->flags.find_copies_harder = 1;
-- 
2.21.0.rc0.328.g0e39304f8d

