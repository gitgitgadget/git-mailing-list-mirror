Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10A16201A7
	for <e@80x24.org>; Wed, 17 May 2017 21:32:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932071AbdEQVcD (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 17:32:03 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:33533 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752719AbdEQVb7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2017 17:31:59 -0400
Received: by mail-pg0-f51.google.com with SMTP id u187so12844241pgb.0
        for <git@vger.kernel.org>; Wed, 17 May 2017 14:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=g9cINtLfJsLF9j40mofUy5zx5hgeOrsjlWwx9hSkKfI=;
        b=NQqQ+X+sCP/g1mCehjr/W/vjd4TtXT+tvMRzNvA0MJ7XJxchkowBWnjrTcJUnLOTlD
         V+749VV2nM1BBDitIU1dLeq+Rasb+UPEEHjClMla2zEIhpPIe2mc6kyEVNO3h+R/DZYx
         S/HcQEZBUtjOT7GOPv7y7rtHUaxJeYP18TeqMhx5LuaO0LWubbWUhprkxw1bSV5WLHBr
         SIbMIrpBXAG7h41GdTXQZBBm/ZRTO1pwRpVEwzNKLl7Q+GcAibnEzTKmfXnSy4M514BT
         HYlBAb9KYv0cEQK3SYac/3BPW5Z6xb3OaLYzeOo24OvRS1cPz0brj/lX/izFqh+BPLOW
         n3Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=g9cINtLfJsLF9j40mofUy5zx5hgeOrsjlWwx9hSkKfI=;
        b=rWmFyFNh9gOHUh8Ig+ARoL2A6BmLCw6KBZdMSr5fZRtKMzNe7By+hUVrIREFeq44Ry
         aonmrIknDTPhhv98zXfnKgnX7+eGdVYMZ1n/M3qswyStyHBY9zbXkHfTPVahpO7Tf4UR
         W61V/nwrUp5pbXz8yRLyhKxb/XxkxgnsBLpwpKxefkO6eG0NahwKBs1OkcJku7g1gXzq
         l+DDfYl93XU/sZZ6GID6waP3g59w7cTRo89zzAWSri6Uc8eUlSdaLWH7PZ70txWvkAQf
         oRwsEqXOPJYv+uEnayRyERhIvzMLub4/th8z5WzDYSVWtaUkAkiYKg5xIoRqehDgvhUA
         GDbQ==
X-Gm-Message-State: AODbwcDLYrQVavcwP1aS/Sff8cUknotBmGKA8fRMEFe18wvhU6bsvP06
        sqlETBZFUcfmUnpNmjkhmw==
X-Received: by 10.98.34.203 with SMTP id p72mr877658pfj.118.1495056708164;
        Wed, 17 May 2017 14:31:48 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:f5dc:a4cd:fb33:e862])
        by smtp.gmail.com with ESMTPSA id l67sm6411573pfk.73.2017.05.17.14.31.47
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 17 May 2017 14:31:47 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 3/3] Introduce submodule.recurse option
Date:   Wed, 17 May 2017 14:31:35 -0700
Message-Id: <20170517213135.20988-4-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.18.g7d86cc8ba0
In-Reply-To: <20170517213135.20988-1-sbeller@google.com>
References: <20170517213135.20988-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Any command that understands the boolean --recurse-submodule=[true/false]
can have its default changed to true, by setting the submodule.recurse
option.

git-push takes a --recurse-submodule argument but it is not boolean,
hence it is not included (yet?).

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/config.txt    |  5 +++++
 builtin/checkout.c          |  8 +++-----
 submodule.c                 |  7 ++++++-
 t/lib-submodule-update.sh   | 12 ++++++++++++
 t/t5526-fetch-submodules.sh | 10 ++++++++++
 5 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 475e874d51..e367becf72 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -3063,6 +3063,11 @@ submodule.active::
 	submodule's path to determine if the submodule is of interest to git
 	commands.
 
+submodule.recurse::
+	Specifies if commands recurse into submodules by default. This
+	applies to all commands that have a `--recurse-submodules` option.
+	Defaults to false.
+
 submodule.fetchJobs::
 	Specifies how many submodules are fetched/cloned at the same time.
 	A positive integer allows up to that number of submodules fetched
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 2787b343b1..e4bd93c9cd 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1195,6 +1195,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	opts.show_progress = -1;
 
 	gitmodules_config();
+	load_submodule_config();
 	git_config(git_checkout_config, &opts);
 
 	opts.track = BRANCH_TRACK_UNSPECIFIED;
@@ -1214,11 +1215,8 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		git_xmerge_config("merge.conflictstyle", conflict_style, NULL);
 	}
 
-	if (recurse_submodules != RECURSE_SUBMODULES_OFF) {
-		load_submodule_config();
-		if (recurse_submodules != RECURSE_SUBMODULES_DEFAULT)
-			set_config_update_recurse_submodules(recurse_submodules);
-	}
+	if (recurse_submodules != RECURSE_SUBMODULES_DEFAULT)
+		set_config_update_recurse_submodules(recurse_submodules);
 
 	if ((!!opts.new_branch + !!opts.new_branch_force + !!opts.new_orphan_branch) > 1)
 		die(_("-b, -B and --orphan are mutually exclusive"));
diff --git a/submodule.c b/submodule.c
index 14ea405048..000060a253 100644
--- a/submodule.c
+++ b/submodule.c
@@ -91,7 +91,12 @@ int update_path_in_gitmodules(const char *oldpath, const char *newpath)
 
 static int submodule_config(const char *var, const char *value, void *cb)
 {
-	if (!strcmp(var, "submodule.fetchjobs")) {
+	if (!strcmp(var, "submodule.recurse")) {
+		int v = git_config_bool(var, value) ?
+			RECURSE_SUBMODULES_ON : RECURSE_SUBMODULES_OFF;
+		config_fetch_recurse_submodules = v;
+		config_update_recurse_submodules = v;
+	} else if (!strcmp(var, "submodule.fetchjobs")) {
 		submodule_config_reading = SUBMODULE_CONFIG_EXISTS;
 		parallel_jobs = git_config_int(var, value);
 		if (parallel_jobs < 0)
diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index 0f70b5ec7b..b30164339e 100755
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -990,6 +990,18 @@ test_submodule_switch_recursing () {
 		)
 	'
 
+	test_expect_success "git -c submodule.recurse=true $cmd_args --recurse-submodules: modified submodule updates submodule work tree" '
+		prolog &&
+		reset_work_tree_to_interested add_sub1 &&
+		(
+			cd submodule_update &&
+			git branch -t modify_sub1 origin/modify_sub1 &&
+			git -c submodule.recurse=true $cmd_args --recurse-submodules modify_sub1 &&
+			test_superproject_content origin/modify_sub1 &&
+			test_submodule_content sub1 origin/modify_sub1
+		)
+	'
+
 	# Updating a submodule to an invalid sha1 doesn't update the
 	# superproject nor the submodule's work tree.
 	test_expect_success "$command: updating to a missing submodule commit fails" '
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index f3b0a8d30a..162baf101f 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -71,6 +71,16 @@ test_expect_success "fetch --recurse-submodules recurses into submodules" '
 	test_i18ncmp expect.err actual.err
 '
 
+test_expect_success "submodule.recurse option triggers recursive fetch" '
+	add_upstream_commit &&
+	(
+		cd downstream &&
+		git -c submodule.recurse fetch >../actual.out 2>../actual.err
+	) &&
+	test_must_be_empty actual.out &&
+	test_i18ncmp expect.err actual.err
+'
+
 test_expect_success "fetch --recurse-submodules -j2 has the same output behaviour" '
 	add_upstream_commit &&
 	(
-- 
2.13.0.18.g7d86cc8ba0

