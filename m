Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C98E1F453
	for <e@80x24.org>; Thu, 17 Jan 2019 13:12:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbfAQNMG (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 08:12:06 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44539 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbfAQNME (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 08:12:04 -0500
Received: by mail-pl1-f196.google.com with SMTP id e11so4723791plt.11
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 05:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oygQqoJcDfDmwuhKIdtBQIyavxxaVKLAiR4OyT284gs=;
        b=Zk7vVKiOnpHdXqXt5am/XH31yWSZGLqC0QqfxhtwbsRXaRBkytewOvBFSHY05C4/sv
         K/tinZf4UJXCZgnU5U982ZD56pqd+VjYzAMMFd8cKKLOtaddzZRwXvA7qdOtyB01UmcH
         JqiwtwnW28xrSx/eM4o8iZ4BmKxF58GtWnU+e+IOUPGngQYLxuFqWqBT1r1ybBkFr+Un
         +gC6Fo6NMjA2bvwru7rBi5gz/rjkmUjbtBbhgYTY0y7kDGEXV1giNzulHm9gomTTAG6v
         zfx0otwRmYhiBFON/vpoExZ4aRxRx0jFasOWQzNlKhUBpwEOTYDOcl7qyA/awGsEDxsd
         wd3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oygQqoJcDfDmwuhKIdtBQIyavxxaVKLAiR4OyT284gs=;
        b=VLnpBXArzp0/DmorBQcKTq+qCawfsZ08uaJZTtwZ8Db9EvCcyTbObqdAYjs6vIPt9l
         a15bvN/aGR8FFwAnbmjOusgfeZjf60RiTtcoFAa3ua6PSfDecEgFSNbcJ02ptmBqZIde
         +O4sB0d67DPnYuaN1J/xalybIaa1zByMDG88vLWrx3ubfLTrDtfZuouHg5ONupDa5vro
         klSs+oYIAckxCNEU6y0iXvM1a05oNVhGl2tnzSxyRalbVEvYSG2X/liXHADgSQVxYOGZ
         zpR86WPEPAKN9/VwAKra5KCw3zJcthUQ0mXVtTPEBytxV5URcneGGe91Z0h4SZaF+Gf+
         ujQw==
X-Gm-Message-State: AJcUukdbs1vNM20qfMzysdlirnAlPiwvBT0d+LQuCjR1lWtF6qAe67d4
        oi1OgmLL4BzJbzyVH9RoBpY9UdWU
X-Google-Smtp-Source: ALg8bN4GldN7g905PTsm4yEOFhq9v3r25C9RNNnwcPTT5pTpDOLWiwc/KrOdOZZw5BzwUpxqctlG7g==
X-Received: by 2002:a17:902:708b:: with SMTP id z11mr14996367plk.203.1547730723730;
        Thu, 17 Jan 2019 05:12:03 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id h129sm4689062pfb.110.2019.01.17.05.12.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 05:12:03 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 17 Jan 2019 20:11:59 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 67/76] diff.c: convert --[src|dst]-prefix
Date:   Thu, 17 Jan 2019 20:06:06 +0700
Message-Id: <20190117130615.18732-68-pclouds@gmail.com>
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
 diff.c          | 14 ++++++--------
 parse-options.h |  3 ++-
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/diff.c b/diff.c
index f137b7f442..0d66497851 100644
--- a/diff.c
+++ b/diff.c
@@ -5275,6 +5275,12 @@ static void prep_parse_options(struct diff_options *options)
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
@@ -5469,20 +5475,12 @@ int diff_opt_parse(struct diff_options *options,
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
2.20.0.482.g66447595a7

