Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 643B720248
	for <e@80x24.org>; Sun, 24 Mar 2019 08:22:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbfCXIWq (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Mar 2019 04:22:46 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40395 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728029AbfCXIWq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Mar 2019 04:22:46 -0400
Received: by mail-pf1-f195.google.com with SMTP id c207so4295788pfc.7
        for <git@vger.kernel.org>; Sun, 24 Mar 2019 01:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TBATZcC9BN4zxj/mXAHdQlMKZmVPFPE1YF5xpIyEjjw=;
        b=ir3pvhQNU4wUeuRVTbLiJwZlFCtj3L/cBO1GLJiR6tHkYouHImd+7tzDtjyXYwz07E
         EBpQJor0UqcDoiwN5DU9oSG6U9GB0xPr7ixUI+Fsu/qVd9KK+0n7w56bWvX87zY5jhev
         ZN8AT9+RjyTzRlhRQfHfzPPvIJdSlF2Y9zHBV15MIlfoWy5mOpfPptr32bZuGD2rNilw
         +DVYcltQWLpX26mI+3eqjThm3WJrZt4rF4ixttTbBJS6KHvtwmdxT0iOEbV7lGBP6eWa
         gYjeE9Ubc2DjIKQXkBcyIOjymOa4zuLkf+TD+G/nAZBVg5nnonFVSaAf4RcbbNXo74Cc
         Xe9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TBATZcC9BN4zxj/mXAHdQlMKZmVPFPE1YF5xpIyEjjw=;
        b=Oi/zpCd2VsjNE1VSZ+LymWTNGNj5hbxpXVBXm3n9TDZoJW5mKs9tCa2PfV+QsRJj2p
         02OyaiTeocXWs4FKg77faH3AEPxvVLvvVGCzqg8WsY0vclWnjeqZNb95is7O88427fsM
         VUcGhwJ3bmUq4vMkSBzhgXKnChgEojX9M1tZ1iMBcPm3+XfdR4LNaTlO99MD6Fi4aJeE
         mKTZOp3bLSBHI4Je4z7XXCOrKy0KIxS/KUMtb0/2DnNyPNgKP4XjGPMEX0WXbxIWxuuc
         l2FMBkG8wbBQzvk+ChXqLeH2uw7X6iFQzwgthhKtE/73mjUpdyxnmPnMzYc9MqZfzsuH
         jiaQ==
X-Gm-Message-State: APjAAAWUhFyv5GlM523X1Qy8cnuVQ5tF1RplUHU5oTl2qfLvQ6agT+yt
        1HNEUlf0LV+p7NjJ4UXSJ+WsEPxU
X-Google-Smtp-Source: APXvYqxvUFqvHrqSjHIA27gR3rbDaCDktiqGeNq6a02CCAG8Sqe0YHUNE9xIVo8AEe9BICJ5BRYfEQ==
X-Received: by 2002:a63:2aca:: with SMTP id q193mr17633783pgq.269.1553415765425;
        Sun, 24 Mar 2019 01:22:45 -0700 (PDT)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id f65sm19264182pff.21.2019.03.24.01.22.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 01:22:44 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 24 Mar 2019 15:22:40 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v2 18/20] range-diff: use parse_options() instead of diff_opt_parse()
Date:   Sun, 24 Mar 2019 15:20:12 +0700
Message-Id: <20190324082014.2041-19-pclouds@gmail.com>
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
2.21.0.548.gd3c7d92dc2

