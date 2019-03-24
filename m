Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBD1220248
	for <e@80x24.org>; Sun, 24 Mar 2019 08:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbfCXIWK (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Mar 2019 04:22:10 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46063 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727727AbfCXIWK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Mar 2019 04:22:10 -0400
Received: by mail-pg1-f193.google.com with SMTP id y3so4328826pgk.12
        for <git@vger.kernel.org>; Sun, 24 Mar 2019 01:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qb+Rp+f17CiNbmRmHci80PJN7cSdyo678ROTIJah4gY=;
        b=FAWKkCXo22l06UTlShHydT+ROv/NhTg2qMdTI2x9TDQzgULP9/BMHp0O3Lx9GdLhUE
         xcSeh4uFSOhCvU6qFKexPZrR/l3ddW0B628hueuzCDlNABeuRUSRasywFaB3NiHscfSb
         nWZ2BgWUHEErk0Rsvk4eauO77zua8rV9XynZOerZ7i2PV8UMcGI9+y6nq4hF4uld753G
         kse+a1igoWbBCuTNCdu2T6MOtRk8bDM2tVViLoVznpxGlHba7QH6evIXKqAiblSPUTIM
         2JLz90FsgHPac82SseLNA9y9eXZ5yt6a4gCMux0fRVvzib/EninT28MixC5xhTXcGNiC
         2cIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qb+Rp+f17CiNbmRmHci80PJN7cSdyo678ROTIJah4gY=;
        b=FNZCpTl+Gsh5wuUvMUAHcMolBeFq1lSqVhiGnKlcPZH7Oq7U/RFcGbEskzWKDP4k4a
         8lzYOrfFeJI3WJ+B0deDrecUECwrbnSiRRgix5b985E9YrwbM/PrVtAAbsTgg2GbHUJ9
         wFfkIWy80NpzvpLcnjRqyPCGJ7xHXUiA2QIt/g0KzG0o0we7sjtqOLtO7NF96w/KAr0M
         tijnNg2CCjJHdmvECOk2w7MWrTQyRvaKEn+Ln4Stcbfc7xENTT5R25bUK80GI8YzTQuW
         arJ46P1mX9Y7R0He4DZ0N2KAgXl7FCrg8PhWDytQZ126+r3n/gSg/yEO01yjPsay6hCN
         RZvw==
X-Gm-Message-State: APjAAAXOP1gdA6enLaSfIDpS1IgkupnONcdm2Odd+PwCRLSgicVyXTRv
        8DcBVdZmnQJECqdI9rY5XW0=
X-Google-Smtp-Source: APXvYqxL0iB+91wRTKAr41K8ogdQBAgbgcTwYm/J87Ue7/yp/5zjmDFkdr+Ng9snrHMEb+8DGo7uGA==
X-Received: by 2002:a62:2e07:: with SMTP id u7mr17705206pfu.176.1553415729416;
        Sun, 24 Mar 2019 01:22:09 -0700 (PDT)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id o3sm14484133pgv.50.2019.03.24.01.22.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 01:22:08 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 24 Mar 2019 15:22:04 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v2 11/20] diff-parseopt: convert --[src|dst]-prefix
Date:   Sun, 24 Mar 2019 15:20:05 +0700
Message-Id: <20190324082014.2041-12-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.548.gd3c7d92dc2
In-Reply-To: <20190324082014.2041-1-pclouds@gmail.com>
References: <20190320114703.18659-1-pclouds@gmail.com>
 <20190324082014.2041-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 diff.c          | 14 ++++++--------
 parse-options.h |  3 ++-
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/diff.c b/diff.c
index 8d387280a4..574fc511ff 100644
--- a/diff.c
+++ b/diff.c
@@ -5255,6 +5255,12 @@ static void prep_parse_options(struct diff_options *options)
 			    N_("do not munge pathnames and use NULs as output field terminators in --raw or --numstat"),
 			    0),
 		OPT__ABBREV(&options->abbrev),
+		OPT_STRING_F(0, "src-prefix", &options->a_prefix, N_("<prefix>"),
+			     N_("show the given source prefix instead of \"a/\""),
+			     PARSE_OPT_NONEG),
+		OPT_STRING_F(0, "dst-prefix", &options->b_prefix, N_("<prefix>"),
+			     N_("show the given source prefix instead of \"b/\""),
+			     PARSE_OPT_NONEG),
 		OPT_CALLBACK_F(0, "output-indicator-new",
 			       &options->output_indicators[OUTPUT_INDICATOR_NEW],
 			       N_("<char>"),
@@ -5449,20 +5455,12 @@ int diff_opt_parse(struct diff_options *options,
 	}
 
 	/* misc options */
-	else if ((argcount = parse_long_opt("src-prefix", av, &optarg))) {
-		options->a_prefix = optarg;
-		return argcount;
-	}
 	else if ((argcount = parse_long_opt("line-prefix", av, &optarg))) {
 		options->line_prefix = optarg;
 		options->line_prefix_length = strlen(options->line_prefix);
 		graph_setup_line_prefix(options);
 		return argcount;
 	}
-	else if ((argcount = parse_long_opt("dst-prefix", av, &optarg))) {
-		options->b_prefix = optarg;
-		return argcount;
-	}
 	else if (!strcmp(arg, "--no-prefix"))
 		options->a_prefix = options->b_prefix = "";
 	else if (opt_arg(arg, '\0', "inter-hunk-context",
diff --git a/parse-options.h b/parse-options.h
index 7d83e2971d..c95cbe26f0 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -136,6 +136,7 @@ struct option {
 #define OPT_BOOL_F(s, l, v, h, f)   OPT_SET_INT_F(s, l, v, h, 1, f)
 #define OPT_CALLBACK_F(s, l, v, a, h, f, cb)			\
 	{ OPTION_CALLBACK, (s), (l), (v), (a), (h), (f), (cb) }
+#define OPT_STRING_F(s, l, v, a, h, f)   { OPTION_STRING,  (s), (l), (v), (a), (h), (f) }
 
 #define OPT_END()                   { OPTION_END }
 #define OPT_ARGUMENT(l, h)          { OPTION_ARGUMENT, 0, (l), NULL, NULL, \
@@ -157,7 +158,7 @@ struct option {
 #define OPT_INTEGER(s, l, v, h)     { OPTION_INTEGER, (s), (l), (v), N_("n"), (h) }
 #define OPT_MAGNITUDE(s, l, v, h)   { OPTION_MAGNITUDE, (s), (l), (v), \
 				      N_("n"), (h), PARSE_OPT_NONEG }
-#define OPT_STRING(s, l, v, a, h)   { OPTION_STRING,  (s), (l), (v), (a), (h) }
+#define OPT_STRING(s, l, v, a, h)   OPT_STRING_F(s, l, v, a, h, 0)
 #define OPT_STRING_LIST(s, l, v, a, h) \
 				    { OPTION_CALLBACK, (s), (l), (v), (a), \
 				      (h), 0, &parse_opt_string_list }
-- 
2.21.0.548.gd3c7d92dc2

