Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9FA2C61DA4
	for <git@archiver.kernel.org>; Thu, 16 Feb 2023 04:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjBPEZb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Feb 2023 23:25:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjBPEZa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2023 23:25:30 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2982384D
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 20:25:27 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id 16so668636pfo.8
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 20:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NO22M+77/h2DZzn3FEmrTUAlq09lucsqFT0mncagPMw=;
        b=JHsWg7MiscCwaSBbjENqUjdrwZtuXq7ihWdNFzePfIW2/aUaCewE/NQEgwXmqfMNN+
         2OhOg9H8CwvjeH1C+nPAQHwl3D0w1ogoo3XitCye9xvrugSiC+YO3S1BFlReObk+OZ+T
         LvE73ADslxh81PzOAcIFw7QIezjX4PVBZSLemwmXzYTB4PfJcjVuRFFBAdDIX+6XzAdi
         gxdLZutd+AeUICckVc3wAhLU/1pWik9bPqlH7jUO3LQ1FkXgvhHeQa8xhqUX3cVK0ONN
         +lT/f1y6Sk1hdvifrSUdNnRKQpH4meYnzn6m7qytHaFKWgabO2ljFDBW2MvEbDRvXCnG
         Cj1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NO22M+77/h2DZzn3FEmrTUAlq09lucsqFT0mncagPMw=;
        b=cRGKvxNFfDHf0dZpf47ylCc8xHB8sZ8crRza+SdrniFVDikGfgItA0HeRDEt+dGdRQ
         ZryHibF6i57g8Tb8L5lqk4N0PpVeomERjlryDHDOwWqHI1ZyI+Qup8cAVJSTdyh16mvq
         Nlo83q+vEmaAfm87nAFHBGBNqIGZiu73OIZm9eq+py04VElNEM2BdV0Jz4XOGbZNmZ1x
         grzVP9llonJXnFLSqg/+0tjNgiq9uTYleg2yhQgVDu/LET82EMvK6MGvpP7jzEEzCtNF
         hoN/gWmBdwoEZxB5KTA2rir0MEpRd1JgfAVTSQZBhEYJsB2Hi/vwbj1D6hG9l/xLnmhH
         j0zg==
X-Gm-Message-State: AO0yUKX3yYC2v3md60JsRXxICx7/wJFQ3uwMyPwv/iQ22H3M2t7vL6J2
        ENsw07d1pKOlT1PJ/24wt2KpLOf3mSw=
X-Google-Smtp-Source: AK7set8uTHRBjZXMUM3TRiKYp+UBGNgU7gLBUWWbhvt++9ZnYCCQU47ej6+8c8HRWd14Rz+2pYP69w==
X-Received: by 2002:aa7:9732:0:b0:5a8:4861:af7d with SMTP id k18-20020aa79732000000b005a84861af7dmr4359656pfg.20.1676521527062;
        Wed, 15 Feb 2023 20:25:27 -0800 (PST)
Received: from xavier.lan ([2607:fa18:92fe:92b::2a2])
        by smtp.gmail.com with ESMTPSA id g23-20020aa78197000000b005a861454970sm167733pfi.154.2023.02.15.20.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 20:25:26 -0800 (PST)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, karthik.188@gmail.com, gitster@pobox.com
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH] branch: introduce --(no-)has-upstream and --(no-)gone options
Date:   Wed, 15 Feb 2023 21:14:32 -0700
Message-Id: <20230216041432.1668365-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

GitHub and GitLab have features to create a branch using the web
interface, then delete the branch after it is merged. That results in a
lot of "gone" branches in my local clone, and I frequently find myself
typing `git branch -v | grep gone`. I don't want `git branch --merged`
because that would include branches that have been created for future
work but do not yet have any commits.

To avoid having to do error-prone string parsing, add options to filter
branches by tracking status. The --has-upstream option lists branches
that would be shown with a tracked branch in `git branch -vv` and the
--gone option further restricts the list to branches that would be shown
as [gone] in `git branch -v`. The --no-has-upstream and --no-gone
options are their inverses.

The new options could be used, for example, to create an alias for
deleting all branches that are both merged and gone:

git config alias.branch-prune '!git branch -d `git branch --gone --format="%(refname:short)"`'

In the future, an optional argument could be added to --has-upstream and
--no-has-upstream to show or hide branches that track branches on a
particular remote.

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 Documentation/git-branch.txt      | 15 ++++++
 builtin/branch.c                  | 11 ++++-
 ref-filter.c                      | 39 ++++++++++++++++
 ref-filter.h                      |  3 ++
 t/t3208-branch-tracking-filter.sh | 76 +++++++++++++++++++++++++++++++
 5 files changed, 143 insertions(+), 1 deletion(-)
 create mode 100755 t/t3208-branch-tracking-filter.sh

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index d382ac69f7..99cd0486dc 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -13,6 +13,8 @@ SYNOPSIS
 	[--column[=<options>] | --no-column] [--sort=<key>]
 	[--merged [<commit>]] [--no-merged [<commit>]]
 	[--contains [<commit>]] [--no-contains [<commit>]]
+	[--has-upstream | --no-has-upstream]
+	[--gone | --no-gone]
 	[--points-at <object>] [--format=<format>]
 	[(-r | --remotes) | (-a | --all)]
 	[--list] [<pattern>...]
@@ -325,6 +327,19 @@ superproject's "origin/main", but tracks the submodule's "origin/main".
 	detached HEAD (if present) first, then local branches and
 	finally remote-tracking branches. See linkgit:git-config[1].
 
+--has-upstream::
+	Only list branches that track an upstream branch. Implies `--list`.
+
+--no-has-upstream::
+	Only list branches that do not track an upstream branch. Implies `--list`.
+
+--gone::
+	Only list branches that track a gone upstream branch. Implies `--list` and
+	`--has-upstream`.
+
+--no-gone::
+	Only list branches that do not track a gone upstream branch. Implies
+	`--list`.
 
 --points-at <object>::
 	Only list branches of the given object.
diff --git a/builtin/branch.c b/builtin/branch.c
index f63fd45edb..5cac6dc3c6 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -680,6 +680,14 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT__FORCE(&force, N_("force creation, move/rename, deletion"), PARSE_OPT_NOCOMPLETE),
 		OPT_MERGED(&filter, N_("print only branches that are merged")),
 		OPT_NO_MERGED(&filter, N_("print only branches that are not merged")),
+		OPT_SET_INT_F(0, "has-upstream", &filter.has_upstream,
+			      N_("print only branches that track an upstream branch"), 1, PARSE_OPT_NONEG),
+		OPT_SET_INT_F(0, "no-has-upstream", &filter.has_upstream,
+			      N_("print only branches that do not track an upstream branch"), -1, PARSE_OPT_NONEG),
+		OPT_SET_INT_F(0, "gone", &filter.upstream_gone,
+			      N_("print only branches that track a gone upstream branch"), 1, PARSE_OPT_NONEG),
+		OPT_SET_INT_F(0, "no-gone", &filter.upstream_gone,
+			      N_("print only branches that do not track a gone upstream branch"), -1, PARSE_OPT_NONEG),
 		OPT_COLUMN(0, "column", &colopts, N_("list branches in columns")),
 		OPT_REF_SORT(&sorting_options),
 		OPT_CALLBACK(0, "points-at", &filter.points_at, N_("object"),
@@ -719,7 +727,8 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		list = 1;
 
 	if (filter.with_commit || filter.no_commit ||
-	    filter.reachable_from || filter.unreachable_from || filter.points_at.nr)
+	    filter.reachable_from || filter.unreachable_from ||
+	    filter.points_at.nr || filter.has_upstream || filter.upstream_gone)
 		list = 1;
 
 	noncreate_actions = !!delete + !!rename + !!copy + !!new_upstream +
diff --git a/ref-filter.c b/ref-filter.c
index f8203c6b05..a0f629bbf7 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2358,6 +2358,42 @@ void ref_array_clear(struct ref_array *array)
 	}
 }
 
+static void do_tracking_filter(struct ref_filter_cbdata *ref_cbdata)
+{
+	struct ref_filter *filter = ref_cbdata->filter;
+	struct ref_array *array = ref_cbdata->array;
+	int i, old_nr;
+
+	old_nr = array->nr;
+	array->nr = 0;
+
+	for (i = 0; i < old_nr; i++) {
+		struct ref_array_item *item = array->items[i];
+		const char *branch_name = item->refname;
+		struct branch *branch;
+		int num_ours, num_theirs, gone;
+		const char *base;
+
+		skip_prefix(branch_name, "refs/heads/", &branch_name);
+		branch = branch_get(branch_name);
+		gone = stat_tracking_info(branch, &num_ours, &num_theirs,
+					  &base, 0, AHEAD_BEHIND_QUICK) < 0;
+
+		if (filter->has_upstream == 1 && !base)
+			goto remove;
+		if (filter->has_upstream == -1 && base)
+			goto remove;
+		if (filter->upstream_gone == 1 && (!base || !gone))
+			goto remove;
+		if (filter->upstream_gone == -1 && base && gone)
+			goto remove;
+		array->items[array->nr++] = array->items[i];
+		continue;
+remove:
+		free_array_item(item);
+	}
+}
+
 #define EXCLUDE_REACHED 0
 #define INCLUDE_REACHED 1
 static void reach_filter(struct ref_array *array,
@@ -2466,6 +2502,9 @@ int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int
 	clear_contains_cache(&ref_cbdata.contains_cache);
 	clear_contains_cache(&ref_cbdata.no_contains_cache);
 
+	if (filter->has_upstream || filter->upstream_gone)
+		do_tracking_filter(&ref_cbdata);
+
 	/*  Filters that need revision walking */
 	reach_filter(array, filter->reachable_from, INCLUDE_REACHED);
 	reach_filter(array, filter->unreachable_from, EXCLUDE_REACHED);
diff --git a/ref-filter.h b/ref-filter.h
index aa0eea4ecf..3d0b321a16 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -57,6 +57,9 @@ struct ref_filter {
 	struct commit_list *reachable_from;
 	struct commit_list *unreachable_from;
 
+	int has_upstream;
+	int upstream_gone;
+
 	unsigned int with_commit_tag_algo : 1,
 		match_as_path : 1,
 		ignore_case : 1,
diff --git a/t/t3208-branch-tracking-filter.sh b/t/t3208-branch-tracking-filter.sh
new file mode 100755
index 0000000000..51e9453ffb
--- /dev/null
+++ b/t/t3208-branch-tracking-filter.sh
@@ -0,0 +1,76 @@
+#!/bin/sh
+
+test_description='branch tracking filter options'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	git init --initial-branch=tracked-present r1 &&
+	git -C r1 commit --allow-empty -m "Initial commit" &&
+	git -C r1 branch upstream-only &&
+	git -C r1 branch untracked &&
+	git clone r1 r2 &&
+	cd r2 &&
+	git checkout -b tracked-gone &&
+	git push --set-upstream origin tracked-gone &&
+	git push origin :tracked-gone &&
+	git branch --no-track untracked &&
+	git branch downstream-only
+'
+
+test_expect_success 'all local branches' '
+	git branch >actual &&
+	cat >expect <<-\EOF &&
+	  downstream-only
+	* tracked-gone
+	  tracked-present
+	  untracked
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'branch --has-upstream' '
+	git branch --has-upstream >actual &&
+	cat >expect <<-\EOF &&
+	* tracked-gone
+	  tracked-present
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'branch --no-has-upstream' '
+	git branch --no-has-upstream >actual &&
+	cat >expect <<-\EOF &&
+	  downstream-only
+	  untracked
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'branch --gone' '
+	git branch --gone >actual &&
+	cat >expect <<-\EOF &&
+	* tracked-gone
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'branch --no-gone' '
+	git branch --no-gone >actual &&
+	cat >expect <<-\EOF &&
+	  downstream-only
+	  tracked-present
+	  untracked
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'branch --has-upstream --no-gone' '
+	git branch --has-upstream --no-gone >actual &&
+	cat >expect <<-\EOF &&
+	  tracked-present
+	EOF
+	test_cmp expect actual
+'
+
+test_done
-- 
2.39.2

