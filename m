Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 582BE1F461
	for <e@80x24.org>; Sat, 17 Aug 2019 18:42:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbfHQSm2 (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Aug 2019 14:42:28 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37851 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbfHQSmU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Aug 2019 14:42:20 -0400
Received: by mail-pg1-f193.google.com with SMTP id d1so3995653pgp.4
        for <git@vger.kernel.org>; Sat, 17 Aug 2019 11:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y7mnXMhjArvZX+slKut5E+j3BeiYKO20yPJjbPgTK8o=;
        b=tpw141HAfwVQn23+c6EEuCtO7uByP8etKJlWw5JboAb5zBgdixeLEaVuz94QPDnITw
         Io6eV34G9sx18ZGnGZ8Bu56rPvQJPef3hqtxDfeygn7hYodT9+pjpctuTkVj0yIK0TGN
         Ehu3ZvVIooFrSRbfeWtbeoEgJTlje70tQHLVhkClSO4Q3e6fC1Lszo10IjwTQdt4S5jJ
         rCUEawHQuyK3m45qHGBmNElAEpSY2JKWq2kZkjNnJe0Td70tiJSrWdPoLaE0TgS/g2Fn
         QUObHoJ4NR6P3ivNHxwstHdqzpZi1cJnueMH0xwZKqBJyKSSDGaSE6iTrR0wZXUvPuDt
         wKMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y7mnXMhjArvZX+slKut5E+j3BeiYKO20yPJjbPgTK8o=;
        b=cidEIrkZl96RF6QLB84PQJq8FAg8MtuLEScBcZePemjfmyV8VgBErK7GxQXkC6PDSv
         LrW5EnaNg0xW+8LBTwQRWizl5yTD+lIvtmoKReyYao3eMOvhpnv++/M9skHK9bFgnTUS
         i5s7GlqvGMgSBKy+AwtWZj8ehsYhzW2uLsxOfvl5wh4GRLnZz9vZCSsn3OBWsw2VYbcy
         JluIGY80u0j/KLZ5u6L/EGVlVOt/r8Y4lBct09/J++CG12c7YYl4+DAL3Y+1FwCWiJCH
         w2SOkZ6CPUUrGZH72MARphAc1FUQFa8ssnvyXX1w6KGb2meiuQJ5XZoZRX6CRth52vo/
         9IXA==
X-Gm-Message-State: APjAAAVQhT6vPGNbOZH2sz97SX5UDsyZQlunWkT1GYOQH8ALPYofzh6y
        8JfpzNY057kbwSwSDbmWg97kQA09
X-Google-Smtp-Source: APXvYqyDFiNwL/oRBcgKIVNv8wCGy+u0yAVe7rfGnxuIuVv6kau/tzWwV8pqHxH80hl/KfmV+X4a5g==
X-Received: by 2002:a63:29c4:: with SMTP id p187mr13212544pgp.330.1566067338585;
        Sat, 17 Aug 2019 11:42:18 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id j15sm9990422pfr.146.2019.08.17.11.42.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 17 Aug 2019 11:42:17 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v4 18/24] merge-recursive: consolidate unnecessary fields in merge_options
Date:   Sat, 17 Aug 2019 11:41:38 -0700
Message-Id: <20190817184144.32179-19-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.rc2.28.g5f89f15d7b.dirty
In-Reply-To: <20190817184144.32179-1-newren@gmail.com>
References: <20190815214053.16594-1-newren@gmail.com>
 <20190817184144.32179-1-newren@gmail.com>
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
index 9807b24c65..0f0b952c04 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -385,8 +385,7 @@ static int add_cacheinfo(struct merge_options *opt,
 
 static inline int merge_detect_rename(struct merge_options *opt)
 {
-	return opt->merge_detect_rename >= 0 ? opt->merge_detect_rename :
-		opt->diff_detect_rename >= 0 ? opt->diff_detect_rename : 1;
+	return (opt->detect_renames >= 0) ? opt->detect_renames : 1;
 }
 
 static void init_tree_desc_from_tree(struct tree_desc *desc, struct tree *tree)
@@ -1883,9 +1882,7 @@ static struct diff_queue_struct *get_diffpairs(struct merge_options *opt,
 	 */
 	if (opts.detect_rename > DIFF_DETECT_RENAME)
 		opts.detect_rename = DIFF_DETECT_RENAME;
-	opts.rename_limit = opt->merge_rename_limit >= 0 ? opt->merge_rename_limit :
-			    opt->diff_rename_limit >= 0 ? opt->diff_rename_limit :
-			    1000;
+	opts.rename_limit = (opt->rename_limit >= 0) ? opt->rename_limit : 1000;
 	opts.rename_score = opt->rename_score;
 	opts.show_rename_progress = opt->show_rename_progress;
 	opts.output_format = DIFF_FORMAT_NO_OUTPUT;
@@ -3727,14 +3724,14 @@ static void merge_recursive_config(struct merge_options *opt)
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
@@ -3760,11 +3757,9 @@ void init_merge_options(struct merge_options *opt,
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
 	opt->detect_directory_renames = MERGE_DIRECTORY_RENAMES_CONFLICT;
 	merge_recursive_config(opt);
 	merge_verbosity = getenv("GIT_MERGE_VERBOSITY");
@@ -3816,16 +3811,16 @@ int parse_merge_opt(struct merge_options *opt, const char *s)
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
index 0fdae904dd..f4bdfbc897 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -27,10 +27,8 @@ struct merge_options {
 		MERGE_DIRECTORY_RENAMES_CONFLICT = 1,
 		MERGE_DIRECTORY_RENAMES_TRUE = 2
 	} detect_directory_renames;
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
2.23.0.rc2.28.g5f89f15d7b.dirty

