Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83FEB1F453
	for <e@80x24.org>; Thu, 17 Jan 2019 13:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728285AbfAQNMj (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 08:12:39 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43897 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727131AbfAQNMj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 08:12:39 -0500
Received: by mail-pf1-f194.google.com with SMTP id w73so4807709pfk.10
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 05:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bZHrnM16Gvmag53Ixw50qiqI8MjHL1pNMog/JTgGrTA=;
        b=jvy+EPIx3v3OmPsnYtiJwbHzh5sk6IhiUheK30WqzD0UjBtt1g3KB4X3DX5USU5YAG
         T5Z6UYCU32uBpBrXKdrLuBP1Xt42AVJkfNeZ3Ote+lKFHbuiesTQDfn+vtsRuYDbJt8O
         huKGcgepInTnBC79azvdSDTkrZ2iS17NSe49iUgoYsCTfc81fPIH0chSTrEif+nRZ/d1
         RdESMI4U3UyKzvOKmUHXuF3b32BEgWtAL5tASGC/d9Lt5GvtCk0JqFZ2ioDXC7NDMG3q
         R799iNTbIAwpxBQdpXCL3RhrlCM7DBDYWFwLOrS1Be90R1rgSWE0omVuGbd9CNBTkgtY
         F9oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bZHrnM16Gvmag53Ixw50qiqI8MjHL1pNMog/JTgGrTA=;
        b=sx0tIRwsFEZm+J3Vfn9UG/6qaj7+zTN9R3bCsM61RK6HOXNjiOjDJAjQw3iYPkM++6
         VRx680lNOWd5hA2T3BQidJ7/+/i7R8DD1T6nwpfPQDgEtGRPG79KUwVfAkM79vErEMlH
         QZzkX5M+PGDBJN0U+AzHiqNGa8wDTDuQsLMSdgZZ8AACy2nlral/PYQvwbT5gK49Xvm2
         FhWJoQYwxMb7e52KjluplkdEhUfPdWXUCs+hNAbFI2VyeACHyGWZEC50AR3BcYgd+m5K
         Bn8NoPhKNvd0f2wmOTbnF2jJ3ONyt1NcThWrW7njKR0/wdVVnyXRpK4qPrcPBrpalLke
         xTCQ==
X-Gm-Message-State: AJcUukdKdU7sI/LfAAjEam6FNbf7bi/pXjfVYsGztM4AYx8Q/Zy48f9i
        XiDnnpPYQgMRStAJWPoQTqwCpNVH
X-Google-Smtp-Source: ALg8bN4uenN+FyZGKQo4TvHrCKNlKZE76XtcrwHib6wctq3Zu6u9u3S+igoodGT/HUWyUHPinkgqoA==
X-Received: by 2002:a63:d104:: with SMTP id k4mr13087460pgg.227.1547730757995;
        Thu, 17 Jan 2019 05:12:37 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id 134sm1954833pgb.78.2019.01.17.05.12.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 05:12:37 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 17 Jan 2019 20:12:33 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 74/76] range-diff: use parse_options() instead of diff_opt_parse()
Date:   Thu, 17 Jan 2019 20:06:13 +0700
Message-Id: <20190117130615.18732-75-pclouds@gmail.com>
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

Diff's internal option parsing is now done with 'struct option', which
makes it possible to combine all diff options to range-diff and parse
everything all at once. Parsing code becomes simpler, and we get a
looong 'git range-diff -h'

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/range-diff.c | 26 ++++++--------------------
 1 file changed, 6 insertions(+), 20 deletions(-)

diff --git a/builtin/range-diff.c b/builtin/range-diff.c
index f01a0be851..784bd19321 100644
--- a/builtin/range-diff.c
+++ b/builtin/range-diff.c
@@ -16,42 +16,27 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
 	int creation_factor = RANGE_DIFF_CREATION_FACTOR_DEFAULT;
 	struct diff_options diffopt = { NULL };
 	int simple_color = -1;
-	struct option options[] = {
+	struct option range_diff_options[] = {
 		OPT_INTEGER(0, "creation-factor", &creation_factor,
 			    N_("Percentage by which creation is weighted")),
 		OPT_BOOL(0, "no-dual-color", &simple_color,
 			    N_("use simple diff colors")),
 		OPT_END()
 	};
-	int i, j, res = 0;
+	struct option *options;
+	int res = 0;
 	struct strbuf range1 = STRBUF_INIT, range2 = STRBUF_INIT;
 
 	git_config(git_diff_ui_config, NULL);
 
 	repo_diff_setup(the_repository, &diffopt);
 
+	options = parse_options_concat(range_diff_options, diffopt.parseopts);
 	argc = parse_options(argc, argv, NULL, options,
-			     builtin_range_diff_usage, PARSE_OPT_KEEP_UNKNOWN |
-			     PARSE_OPT_KEEP_DASHDASH | PARSE_OPT_KEEP_ARGV0);
-
-	for (i = j = 1; i < argc && strcmp("--", argv[i]); ) {
-		int c = diff_opt_parse(&diffopt, argv + i, argc - i, prefix);
+			     builtin_range_diff_usage, 0);
 
-		if (!c)
-			argv[j++] = argv[i++];
-		else
-			i += c;
-	}
-	while (i < argc)
-		argv[j++] = argv[i++];
-	argc = j;
 	diff_setup_done(&diffopt);
 
-	/* Make sure that there are no unparsed options */
-	argc = parse_options(argc, argv, NULL,
-			     options + ARRAY_SIZE(options) - 1, /* OPT_END */
-			     builtin_range_diff_usage, 0);
-
 	/* force color when --dual-color was used */
 	if (!simple_color)
 		diffopt.use_color = 1;
@@ -90,6 +75,7 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
 		error(_("need two commit ranges"));
 		usage_with_options(builtin_range_diff_usage, options);
 	}
+	FREE_AND_NULL(options);
 
 	res = show_range_diff(range1.buf, range2.buf, creation_factor,
 			      simple_color < 1, &diffopt);
-- 
2.20.0.482.g66447595a7

