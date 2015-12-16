From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 7/7] submodules: allow parallel fetching, add tests and documentation
Date: Tue, 15 Dec 2015 16:04:12 -0800
Message-ID: <1450224252-16833-8-git-send-email-sbeller@google.com>
References: <1450224252-16833-1-git-send-email-sbeller@google.com>
Cc: peff@peff.net, jrnieder@gmail.com, johannes.schindelin@gmail.com,
	Jens.Lehmann@web.de, ericsunshine@gmail.com, j6t@kdbg.org,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Dec 16 01:04:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8zaA-0005zR-1Y
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 01:04:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965540AbbLPAEf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Dec 2015 19:04:35 -0500
Received: from mail-pa0-f42.google.com ([209.85.220.42]:34790 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932608AbbLPAEa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2015 19:04:30 -0500
Received: by mail-pa0-f42.google.com with SMTP id wq6so13372029pac.1
        for <git@vger.kernel.org>; Tue, 15 Dec 2015 16:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TvBt9AxZqvmvwgb/FbWyaxSpd2X1bk3/P8i7rNz3SnI=;
        b=Mx4PWWhswMEWXoaVgkik8fTLBbbFk3Zz7MnTTKb1/sK5Qkz6iIY1ymyw7Vs0dLP+XS
         E5E0nCWN+6T4BmQagDZW3W15fYXXG1uE9AooH0iZ5/0iEoalI9rWAMHRg2gCRlgQ9zG+
         5hOo5FaKf62kKomYNUNMuGEA5rnxx3Mbq9WpoJye5Grp6eMCv/72DLdCQBwfOMf9Iae1
         bzbH2wevn5R6jnTGA7SgkbR+UXJbiLKbDmBf8Q844ywQIUJl6cvKNjeClLCt3jQe/lXN
         3RCAMIr9+TA0j7ozAHdfWfjPYoN/33tJnqLvPpSjAqaOj8Fe/WB4mfRx/f8F7Bq4Obh9
         vcSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TvBt9AxZqvmvwgb/FbWyaxSpd2X1bk3/P8i7rNz3SnI=;
        b=TF1O3AYiag3DTdDfIipa4E1cgbWNQXWKgCEEzD0aGtGv0HyoG5c13zOAgyZ9/Iz27M
         rPGpT9O8+JX4S/7Kp1wLt4uYnB8SDvcr39zUHyI4Ht/xj8lFHwGXMcVIYd4g2WhFvldw
         L7zjX3/JLL0OBwjlCszeF7C6tkAUPTzgsT2HjwuHO91nhSyPd2InHdFxZEUjZTNsniih
         rBNV2YZNxDEtOdyS+X4OMo6aSrOceYT5ciKcShMpnLPOvCGlTrj8Ay8vKfqkXHNSfbCI
         LtGnY/+ZjJ08z88O7P8GaI9j1PBsbkOeDeedFrTAOoXtS7h4UbIt5zWhg/2PfgsupgDt
         JTOg==
X-Gm-Message-State: ALoCoQn8MW6ej5rAPjGuARP+EOz1BQ7e2HnQr/XrDroKK7QWfRt0xrV1AF2PixiKTGxXndV977LDzqHeyHDzZS83kGruanQ0Ng==
X-Received: by 10.66.219.194 with SMTP id pq2mr59014124pac.107.1450224269284;
        Tue, 15 Dec 2015 16:04:29 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:a171:258:4778:14b4])
        by smtp.gmail.com with ESMTPSA id 26sm398992pfn.61.2015.12.15.16.04.28
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 15 Dec 2015 16:04:28 -0800 (PST)
X-Mailer: git-send-email 2.6.4.443.ge094245.dirty
In-Reply-To: <1450224252-16833-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282520>

This enables the work of the previous patches.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/fetch-options.txt |  7 +++++++
 builtin/fetch.c                 |  6 +++++-
 builtin/pull.c                  |  6 ++++++
 submodule.c                     |  3 +--
 submodule.h                     |  2 +-
 t/t5526-fetch-submodules.sh     | 20 ++++++++++++++++++++
 6 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 45583d8..6b109f6 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -100,6 +100,13 @@ ifndef::git-pull[]
 	reference to a commit that isn't already in the local submodule
 	clone.
 
+-j::
+--jobs=<n>::
+	Number of parallel children to be used for fetching submodules.
+	Each will fetch from different submodules, such that fetching many
+	submodules will be faster. By default submodules will be fetched
+	one at a time.
+
 --no-recurse-submodules::
 	Disable recursive fetching of submodules (this has the same effect as
 	using the '--recurse-submodules=no' option).
diff --git a/builtin/fetch.c b/builtin/fetch.c
index c85f347..586840d 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -37,6 +37,7 @@ static int prune = -1; /* unspecified */
 static int all, append, dry_run, force, keep, multiple, update_head_ok, verbosity;
 static int progress = -1, recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
 static int tags = TAGS_DEFAULT, unshallow, update_shallow;
+static int max_children = 1;
 static const char *depth;
 static const char *upload_pack;
 static struct strbuf default_rla = STRBUF_INIT;
@@ -99,6 +100,8 @@ static struct option builtin_fetch_options[] = {
 		    N_("fetch all tags and associated objects"), TAGS_SET),
 	OPT_SET_INT('n', NULL, &tags,
 		    N_("do not fetch all tags (--no-tags)"), TAGS_UNSET),
+	OPT_INTEGER('j', "jobs", &max_children,
+		    N_("number of submodules fetched in parallel")),
 	OPT_BOOL('p', "prune", &prune,
 		 N_("prune remote-tracking branches no longer on remote")),
 	{ OPTION_CALLBACK, 0, "recurse-submodules", NULL, N_("on-demand"),
@@ -1213,7 +1216,8 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 		result = fetch_populated_submodules(&options,
 						    submodule_prefix,
 						    recurse_submodules,
-						    verbosity < 0);
+						    verbosity < 0,
+						    max_children);
 		argv_array_clear(&options);
 	}
 
diff --git a/builtin/pull.c b/builtin/pull.c
index 5145fc6..9e3c738 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -95,6 +95,7 @@ static int opt_force;
 static char *opt_tags;
 static char *opt_prune;
 static char *opt_recurse_submodules;
+static char *max_children;
 static int opt_dry_run;
 static char *opt_keep;
 static char *opt_depth;
@@ -178,6 +179,9 @@ static struct option pull_options[] = {
 		N_("on-demand"),
 		N_("control recursive fetching of submodules"),
 		PARSE_OPT_OPTARG),
+	OPT_PASSTHRU('j', "jobs", &max_children, N_("n"),
+		N_("number of submodules pulled in parallel"),
+		PARSE_OPT_OPTARG),
 	OPT_BOOL(0, "dry-run", &opt_dry_run,
 		N_("dry run")),
 	OPT_PASSTHRU('k', "keep", &opt_keep, NULL,
@@ -525,6 +529,8 @@ static int run_fetch(const char *repo, const char **refspecs)
 		argv_array_push(&args, opt_prune);
 	if (opt_recurse_submodules)
 		argv_array_push(&args, opt_recurse_submodules);
+	if (max_children)
+		argv_array_push(&args, max_children);
 	if (opt_dry_run)
 		argv_array_push(&args, "--dry-run");
 	if (opt_keep)
diff --git a/submodule.c b/submodule.c
index 6a2d786..0b48734 100644
--- a/submodule.c
+++ b/submodule.c
@@ -729,10 +729,9 @@ static int fetch_finish(int retvalue, struct child_process *cp,
 
 int fetch_populated_submodules(const struct argv_array *options,
 			       const char *prefix, int command_line_option,
-			       int quiet)
+			       int quiet, int max_parallel_jobs)
 {
 	int i;
-	int max_parallel_jobs = 1;
 	struct submodule_parallel_fetch spf = SPF_INIT;
 
 	spf.work_tree = get_git_work_tree();
diff --git a/submodule.h b/submodule.h
index 5507c3d..cbc0003 100644
--- a/submodule.h
+++ b/submodule.h
@@ -31,7 +31,7 @@ void set_config_fetch_recurse_submodules(int value);
 void check_for_new_submodule_commits(unsigned char new_sha1[20]);
 int fetch_populated_submodules(const struct argv_array *options,
 			       const char *prefix, int command_line_option,
-			       int quiet);
+			       int quiet, int max_parallel_jobs);
 unsigned is_submodule_modified(const char *path, int ignore_untracked);
 int submodule_uses_gitfile(const char *path);
 int ok_to_remove_submodule(const char *path);
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index 17759b14..1241146 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -71,6 +71,17 @@ test_expect_success "fetch --recurse-submodules recurses into submodules" '
 	test_i18ncmp expect.err actual.err
 '
 
+test_expect_success "fetch --recurse-submodules -j2 has the same output behaviour" '
+	add_upstream_commit &&
+	(
+		cd downstream &&
+		GIT_TRACE=$(pwd)/../trace.out git fetch --recurse-submodules -j2 2>../actual.err
+	) &&
+	test_must_be_empty actual.out &&
+	test_i18ncmp expect.err actual.err &&
+	grep "2 tasks" trace.out
+'
+
 test_expect_success "fetch alone only fetches superproject" '
 	add_upstream_commit &&
 	(
@@ -140,6 +151,15 @@ test_expect_success "--quiet propagates to submodules" '
 	! test -s actual.err
 '
 
+test_expect_success "--quiet propagates to parallel submodules" '
+	(
+		cd downstream &&
+		git fetch --recurse-submodules -j 2 --quiet  >../actual.out 2>../actual.err
+	) &&
+	! test -s actual.out &&
+	! test -s actual.err
+'
+
 test_expect_success "--dry-run propagates to submodules" '
 	add_upstream_commit &&
 	(
-- 
2.6.4.443.ge094245.dirty
