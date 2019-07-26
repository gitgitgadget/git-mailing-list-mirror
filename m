Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68D821F462
	for <e@80x24.org>; Fri, 26 Jul 2019 15:53:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387474AbfGZPxW (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jul 2019 11:53:22 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34323 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbfGZPxU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jul 2019 11:53:20 -0400
Received: by mail-pf1-f196.google.com with SMTP id b13so24718239pfo.1
        for <git@vger.kernel.org>; Fri, 26 Jul 2019 08:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k7S5o87maWG1/vTSvmmlzbacnkYN6ikr5gM9cNEzbGU=;
        b=SvG/Y3qNMPKnRSzD6B+vXy20snD9IG0rZVmGN9B9UK2HXEFcxq2sKwQDtHfqpQi5wF
         gyjQx/AcLYha/f4fAZOu/mav7uG1dwJdOwn5jiic9odlZ2KfNFVLudgzRXVlFAJUI8WZ
         Dr1vXnKiqg6qdCzx8ZX+IlXvrpL0ZWwG3wwBBmq80Wv4OXA3Gw1zaxq6nLJCnpXlxMNB
         H34RFOwigpZOWhstQ540oM7d0QkZ9csqNhDQZoCIV3bYVXVkOg/dm03IztSVNwZXW78q
         VEFa7iMVd1/dyoDn7RJRZHqnWfJpGwRRK1wxSVSeVXhOLyGuw9jR2k/FgnmnkzTYDCW5
         R7PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k7S5o87maWG1/vTSvmmlzbacnkYN6ikr5gM9cNEzbGU=;
        b=iTgzmAGnxO0FXo56hwWu6agvhxVhG2D3nHl89vci0wDalqsDjNCBhgT27PkRu0NQv6
         ilqm6/EEA9ySqlV36oGs3YKCqGg3/HpJbG12fo9tsWP0Y647zWJT9tl5ilgjSGq01Ez8
         T2mJLpQG1gEM6ycU/Jqfa2MS1fnF5exqgD7pU4Ho9u5VPLVs2p5XokLQfcksY+NynMx1
         ETI5l459WLcPUDKJYvK2pj5ZsjoW3YOO06cTJ1Bt2eKEfPA0uavPLFLQtGOop9+f/A0/
         eIitzjuZjRxNS6Y4hQyDpbKbV/9++NfKtRZcBLfFpxambIgaleLzS7P007gkNg1OXMIL
         bTaA==
X-Gm-Message-State: APjAAAV685AR3CgbWq4ov2pqqh1eDMz6Qz8umYujUTC5g+ha2tQWHqst
        hbZj92Ujrdybj43ZXKfLNmrPWQSK
X-Google-Smtp-Source: APXvYqxndJ8dEUkKP9sD52AiJM/OW4yPjIU5mSHeB+c5+WxiSTyqdB7V+ViHTVnm2oVh2BPgufifyg==
X-Received: by 2002:a17:90a:b394:: with SMTP id e20mr97857068pjr.76.1564156399459;
        Fri, 26 Jul 2019 08:53:19 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id f27sm36669638pgm.60.2019.07.26.08.53.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Jul 2019 08:53:18 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 13/20] merge-recursive: consolidate unnecessary fields in merge_options
Date:   Fri, 26 Jul 2019 08:52:51 -0700
Message-Id: <20190726155258.28561-14-newren@gmail.com>
X-Mailer: git-send-email 2.22.0.550.g71c37a0928.dirty
In-Reply-To: <20190726155258.28561-1-newren@gmail.com>
References: <20190725174611.14802-1-newren@gmail.com>
 <20190726155258.28561-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We provided users with the ability to state whether they wanted rename
detection, and to put a limit on how much CPU would be spent.  Both of
these fields had multiple configuration parameters for setting them,
with one being a fallback and the other being an override.  However,
instead of implementing the logic for how to combine the multiple
source locations into the appropriate setting at config loading time,
we loaded and tracked both values and then made the code combine them
every time it wanted to check the overall value.  This had a few
minor drawbacks:
  * it seems more complicated than necessary
  * it runs the risk of people using the independent settings in the
    future and breaking the intent of how the options are used
    together
  * it makes merge_options more complicated than necessary for other
    potential users of the API

Fix these problems by moving the logic for combining the pairs of
options into a single value; make it apply at time-of-config-loading
instead of each-time-of-use.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 27 +++++++++++----------------
 merge-recursive.h |  6 ++----
 2 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 6820578258..bafac63c45 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -385,8 +385,7 @@ static int add_cacheinfo(struct merge_options *opt,
 
 static inline int merge_detect_rename(struct merge_options *opt)
 {
-	return opt->merge_detect_rename >= 0 ? opt->merge_detect_rename :
-		opt->diff_detect_rename >= 0 ? opt->diff_detect_rename : 1;
+	return (opt->detect_renames != -1) ? opt->detect_renames : 1;
 }
 
 static void init_tree_desc_from_tree(struct tree_desc *desc, struct tree *tree)
@@ -1885,9 +1884,7 @@ static struct diff_queue_struct *get_diffpairs(struct merge_options *opt,
 	 */
 	if (opts.detect_rename > DIFF_DETECT_RENAME)
 		opts.detect_rename = DIFF_DETECT_RENAME;
-	opts.rename_limit = opt->merge_rename_limit >= 0 ? opt->merge_rename_limit :
-			    opt->diff_rename_limit >= 0 ? opt->diff_rename_limit :
-			    1000;
+	opts.rename_limit = (opt->rename_limit != -1) ? opt->rename_limit : 1000;
 	opts.rename_score = opt->rename_score;
 	opts.show_rename_progress = opt->show_rename_progress;
 	opts.output_format = DIFF_FORMAT_NO_OUTPUT;
@@ -3719,14 +3716,14 @@ static void merge_recursive_config(struct merge_options *opt)
 {
 	char *value = NULL;
 	git_config_get_int("merge.verbosity", &opt->verbosity);
-	git_config_get_int("diff.renamelimit", &opt->diff_rename_limit);
-	git_config_get_int("merge.renamelimit", &opt->merge_rename_limit);
+	git_config_get_int("diff.renamelimit", &opt->rename_limit);
+	git_config_get_int("merge.renamelimit", &opt->rename_limit);
 	if (!git_config_get_string("diff.renames", &value)) {
-		opt->diff_detect_rename = git_config_rename("diff.renames", value);
+		opt->detect_renames = git_config_rename("diff.renames", value);
 		free(value);
 	}
 	if (!git_config_get_string("merge.renames", &value)) {
-		opt->merge_detect_rename = git_config_rename("merge.renames", value);
+		opt->detect_renames = git_config_rename("merge.renames", value);
 		free(value);
 	}
 	if (!git_config_get_string("merge.directoryrenames", &value)) {
@@ -3749,11 +3746,9 @@ void init_merge_options(struct merge_options *opt,
 	opt->repo = repo;
 	opt->verbosity = 2;
 	opt->buffer_output = 1;
-	opt->diff_rename_limit = -1;
-	opt->merge_rename_limit = -1;
+	opt->rename_limit = -1;
 	opt->renormalize = 0;
-	opt->diff_detect_rename = -1;
-	opt->merge_detect_rename = -1;
+	opt->detect_renames = -1;
 	opt->detect_directory_renames = 1;
 	merge_recursive_config(opt);
 	merge_verbosity = getenv("GIT_MERGE_VERBOSITY");
@@ -3805,16 +3800,16 @@ int parse_merge_opt(struct merge_options *opt, const char *s)
 	else if (!strcmp(s, "no-renormalize"))
 		opt->renormalize = 0;
 	else if (!strcmp(s, "no-renames"))
-		opt->merge_detect_rename = 0;
+		opt->detect_renames = 0;
 	else if (!strcmp(s, "find-renames")) {
-		opt->merge_detect_rename = 1;
+		opt->detect_renames = 1;
 		opt->rename_score = 0;
 	}
 	else if (skip_prefix(s, "find-renames=", &arg) ||
 		 skip_prefix(s, "rename-threshold=", &arg)) {
 		if ((opt->rename_score = parse_rename_score(&arg)) == -1 || *arg != 0)
 			return -1;
-		opt->merge_detect_rename = 1;
+		opt->detect_renames = 1;
 	}
 	/*
 	 * Please update $__git_merge_strategy_options in
diff --git a/merge-recursive.h b/merge-recursive.h
index ebec855a65..b92a9ebce7 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -23,10 +23,8 @@ struct merge_options {
 	long xdl_opts;
 	int verbosity;
 	int detect_directory_renames;
-	int diff_detect_rename;
-	int merge_detect_rename;
-	int diff_rename_limit;
-	int merge_rename_limit;
+	int detect_renames;
+	int rename_limit;
 	int rename_score;
 	int needed_rename_limit;
 	int show_rename_progress;
-- 
2.22.0.550.g71c37a0928.dirty

