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
	by dcvr.yhbt.net (Postfix) with ESMTP id A2CEE1F45C
	for <e@80x24.org>; Thu, 15 Aug 2019 21:41:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733045AbfHOVlk (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Aug 2019 17:41:40 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36961 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731539AbfHOVle (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Aug 2019 17:41:34 -0400
Received: by mail-pg1-f195.google.com with SMTP id d1so1278452pgp.4
        for <git@vger.kernel.org>; Thu, 15 Aug 2019 14:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SIRwq/7yFbUhhOK77hRe4Zugn34e7tyzstDr2kDgTcA=;
        b=Y7yhTtcp61CmK3Bo7DQwLQyQDyT9olOwCcMzO46P/biOkBDO5olR/ejNYtrTLStgNH
         yfc1xmngeJF3mQ4pVVqQnCJh432O65sxHT1/HzQIBJ1mXfCXKo5QJBOKNtpjzZVC9Ds4
         VmNgJkX6pVUhzRpD5moXIrN03gHZjr/Q7XODVPQUc6pCgSvOVT8UWqIwrRwo0xxAQvMV
         n4zhFj+DqOhbu1IGEVIv1jP+Md7lZoHKhgWVjHR3ZeCbe4EFaeaIhuvxEzOSeXwmqSdt
         Bja1UXNyHa5Mvp1QcNLwjWXTYqYRgjrAgT+MK50jAJykO7MC1WmEslglBvHcnyKp8IGR
         KHVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SIRwq/7yFbUhhOK77hRe4Zugn34e7tyzstDr2kDgTcA=;
        b=hnBx1MecJZcBGbuZ0D951EtwJS9gUDAkdsQfg2Em2jW+25N78ZMnpDaX+pO7kwEFy7
         gfoUpbpvAKpXrLtu/8ycQga5CNDPUBEuY6v6FDCz9mLc/FPUNIlxPtjjov1C1DBFiXJm
         yD/ktvX5ywDe8OOLyMUWgnsO4TTq9Fw1bXlMdHHwmz4E9/685xKr0cTGFx0K2yCjLeuk
         VDvBfsOKC3N2NohzSoV5NC0eRmU/lpCntem4T4cGWGguxschxJjhRPkkgzQDd/NtW5ui
         0RAkeoNASr78pQw9lSDgJH+Y8aO/5e6ow4hjxjxq/rhT/Tp4om2NA5Mbcm9RR19ofPXM
         qHIQ==
X-Gm-Message-State: APjAAAUbQ58nUKshiyNoVi/yAlqSdSFH4aznDC1GRV/J0e8CnkZGQy/l
        lzcBQ2t5HUWzpJ6qptbzE7sFGQ5v
X-Google-Smtp-Source: APXvYqzah8QnASgKjKYAfyI8K/U0i52cp+elztJ1YT8UvzRERaGUhvZu4KPogF5LvbhzPWzYd5dVwg==
X-Received: by 2002:a62:640c:: with SMTP id y12mr7355498pfb.166.1565905293110;
        Thu, 15 Aug 2019 14:41:33 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id i124sm4131966pfe.61.2019.08.15.14.41.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Aug 2019 14:41:32 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 18/24] merge-recursive: consolidate unnecessary fields in merge_options
Date:   Thu, 15 Aug 2019 14:40:47 -0700
Message-Id: <20190815214053.16594-19-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.rc2.32.g2123e9e4e4
In-Reply-To: <20190815214053.16594-1-newren@gmail.com>
References: <20190726155258.28561-1-newren@gmail.com>
 <20190815214053.16594-1-newren@gmail.com>
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
index e401114b8f..b846acf931 100644
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
@@ -1883,9 +1882,7 @@ static struct diff_queue_struct *get_diffpairs(struct merge_options *opt,
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
@@ -3732,14 +3729,14 @@ static void merge_recursive_config(struct merge_options *opt)
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
@@ -3765,11 +3762,9 @@ void init_merge_options(struct merge_options *opt,
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
@@ -3821,16 +3816,16 @@ int parse_merge_opt(struct merge_options *opt, const char *s)
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
2.23.0.rc2.32.g2123e9e4e4

