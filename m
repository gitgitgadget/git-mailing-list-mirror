Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C82481F454
	for <e@80x24.org>; Thu, 17 Jan 2019 13:07:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbfAQNH2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 08:07:28 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37111 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727038AbfAQNH2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 08:07:28 -0500
Received: by mail-pg1-f193.google.com with SMTP id c25so4437819pgb.4
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 05:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dIJ4oIW5UUuINEkZUNdWHChk64PqMpW63eta+amkDRA=;
        b=CH/HNiX+pmCS4uIYmul1adgzR6oj9nptK1lPthVHBH4jlet45f/o14HOasneCsvH7w
         ng2u4tqRMlb28Tf9WpEGudnUyfBKsZXzIyCVIV25LxDnX+ZiIFHP1v4Bai/6jUI5+klh
         SE5LsnDhaOhCqxNsNugN6tDr7DN6lVyX22p+biPgkf2qIFJB7sLeWK72O6pYIa6Dr2NX
         SUaUE2vW75SSeP4DoJjGT13qsfekgdG3waVHeTP3ZKGlFctdp3Nz7wtYTns440FYg2k4
         5FdWpwGr1R+sEhCkBYu59WxPTBkekNMLXekIcJglG+wJubeQGaTc95K6wJB4MKRRqL3j
         rj9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dIJ4oIW5UUuINEkZUNdWHChk64PqMpW63eta+amkDRA=;
        b=kKSidUxuFhbGqwXgMoANi4dC/6twv7MTHme9HIQ5v5X7597lZMxXd6cM38p5Zf/EPC
         6ftQKxuTWdr68iNx5ldcMPSm95F3xbAEDDVUaOUPZTfMZX9GBx16TNrJPDsedtEz5AI9
         /8KB9ASPvyiBfeKW5tlohYuIOl/jWCD1dRhd0AS1AIaF/GAfFANw6CwYOAItNmULTjDn
         XpQC4w4An8fgLyW+hsDKQ6O1CToEQMrPfGhWCjO+yygEMBMPhq/1nlPOQ4ftygkJEtQU
         rYnBlg8oqDKmsJ8q7rR0PfeAGRZQn8UGqfmrfZOtMz923G5MN9hoqhfafyArYw2foyft
         YCZw==
X-Gm-Message-State: AJcUukctfOpeAn1bOH3K+0KrtJFJskmdAf4u8Kw3uYZZeKlk6nONTTp/
        vCNYO435Ofp1MrVq6YDHFH7ebyzx
X-Google-Smtp-Source: ALg8bN6Nq5QSrKvVM4+hPkDSb2mbUih68dClCscPs1mSyHARdLMmXDgw3weFWTSAetTd4seUsxTQnQ==
X-Received: by 2002:a62:4c5:: with SMTP id 188mr15026667pfe.130.1547730447394;
        Thu, 17 Jan 2019 05:07:27 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id b4sm2005950pgq.65.2019.01.17.05.07.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 05:07:26 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 17 Jan 2019 20:07:22 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 11/76] diff.c: prepare to use parse_options() for parsing
Date:   Thu, 17 Jan 2019 20:05:10 +0700
Message-Id: <20190117130615.18732-12-pclouds@gmail.com>
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

This is a preparation step to start using parse_options() to parse
diff/revision options instead of what we have now. There are a couple
of good things from using parse_options():

- better help usage
- easier to add new options
- better completion support
- help usage generation
- better integration with main command option parser. We can just
  concat the main command's option array and diffopt's together and
  parse all in one go.
- detect colidding options (e.g. --reverse is used by revision code,
  so diff code can't use it as long name for -R)
- consistent syntax, e.g. option that takes mandatory argument will
  now accept both "--option=value" and "--option value".

The plan is migrate all diff/rev options to parse_options(). Then we
could get rid of diff_opt_parse() and expose parseopts[] directly to
the caller.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 diff.c | 27 +++++++++++++++++++++++++++
 diff.h |  2 ++
 2 files changed, 29 insertions(+)

diff --git a/diff.c b/diff.c
index f1e901a5fc..60f46052a4 100644
--- a/diff.c
+++ b/diff.c
@@ -23,6 +23,7 @@
 #include "argv-array.h"
 #include "graph.h"
 #include "packfile.h"
+#include "parse-options.h"
 #include "help.h"
 
 #ifdef NO_FAST_WORKING_DIRECTORY
@@ -4424,6 +4425,8 @@ static void run_checkdiff(struct diff_filepair *p, struct diff_options *o)
 	builtin_checkdiff(name, other, attr_path, p->one, p->two, o);
 }
 
+static void prep_parse_options(struct diff_options *options);
+
 void repo_diff_setup(struct repository *r, struct diff_options *options)
 {
 	memcpy(options, &default_diff_options, sizeof(*options));
@@ -4465,6 +4468,8 @@ void repo_diff_setup(struct repository *r, struct diff_options *options)
 
 	options->color_moved = diff_color_moved_default;
 	options->color_moved_ws_handling = diff_color_moved_ws_default;
+
+	prep_parse_options(options);
 }
 
 void diff_setup_done(struct diff_options *options)
@@ -4568,6 +4573,8 @@ void diff_setup_done(struct diff_options *options)
 
 	if (!options->use_color || external_diff())
 		options->color_moved = 0;
+
+	FREE_AND_NULL(options->parseopts);
 }
 
 static int opt_arg(const char *arg, int arg_short, const char *arg_long, int *val)
@@ -4858,6 +4865,16 @@ static int parse_objfind_opt(struct diff_options *opt, const char *arg)
 	return 1;
 }
 
+static void prep_parse_options(struct diff_options *options)
+{
+	struct option parseopts[] = {
+		OPT_END()
+	};
+
+	ALLOC_ARRAY(options->parseopts, ARRAY_SIZE(parseopts));
+	memcpy(options->parseopts, parseopts, sizeof(parseopts));
+}
+
 int diff_opt_parse(struct diff_options *options,
 		   const char **av, int ac, const char *prefix)
 {
@@ -4868,6 +4885,16 @@ int diff_opt_parse(struct diff_options *options,
 	if (!prefix)
 		prefix = "";
 
+	ac = parse_options(ac, av, prefix, options->parseopts, NULL,
+			   PARSE_OPT_KEEP_DASHDASH |
+			   PARSE_OPT_KEEP_UNKNOWN |
+			   PARSE_OPT_NO_INTERNAL_HELP |
+			   PARSE_OPT_ONE_SHOT |
+			   PARSE_OPT_STOP_AT_NON_OPTION);
+
+	if (ac)
+		return ac;
+
 	/* Output format options */
 	if (!strcmp(arg, "-p") || !strcmp(arg, "-u") || !strcmp(arg, "--patch")
 	    || opt_arg(arg, 'U', "unified", &options->context))
diff --git a/diff.h b/diff.h
index 8abe1649d0..d9ad73f0e1 100644
--- a/diff.h
+++ b/diff.h
@@ -15,6 +15,7 @@ struct diff_filespec;
 struct diff_options;
 struct diff_queue_struct;
 struct oid_array;
+struct option;
 struct repository;
 struct rev_info;
 struct strbuf;
@@ -229,6 +230,7 @@ struct diff_options {
 	unsigned color_moved_ws_handling;
 
 	struct repository *repo;
+	struct option *parseopts;
 };
 
 void diff_emit_submodule_del(struct diff_options *o, const char *line);
-- 
2.20.0.482.g66447595a7

