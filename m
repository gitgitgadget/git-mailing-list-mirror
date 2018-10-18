Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B66731F453
	for <e@80x24.org>; Thu, 18 Oct 2018 18:38:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728569AbeJSClG (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Oct 2018 22:41:06 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:40656 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbeJSClG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Oct 2018 22:41:06 -0400
Received: by mail-pf1-f201.google.com with SMTP id l1-v6so30024179pfb.7
        for <git@vger.kernel.org>; Thu, 18 Oct 2018 11:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=LugnInQedrMjFJfLv+/TgWYNu5YSothsN6trdeve0lQ=;
        b=A3BeLkzRDdqHr4cUGG8292qj3Gpl4oeF5P1m3Kv+rjckLobgpI3zmMNgQUJWPuvb40
         BjT+aNhxAS0kh2mRmtBDvphJYQ8I/8nUQI62CsfCFwxQYWGc6xwkD6Hr5SqqKT0ktf7W
         G9MmosX/zGyjoQmgnQ0soQ9W1wehM4XoJabb3f8lPOpEW4CJvfcGG0YYjACPZ/XFYbDO
         gA1s1S/UWFsl181HaaWNFFFbu7xvSfv/aFvMw91qPVRz4/BNC5W5Y/fARf1K8BnpPsb2
         52KYxgDrNQf0oYX7HD8uKlxByPqiIhV8XMldn95KECTzPYXxVunRVqVAq/MFu668gUKz
         DkKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LugnInQedrMjFJfLv+/TgWYNu5YSothsN6trdeve0lQ=;
        b=S42feXcJNrhvAtp7f5SfBcoM1AeJHmmxAa/drlnRZWtgNuFXrM+JIegeO84J0RPpbP
         e9JqgWNz0htJgU0Qra+4DnJm65ARy6Mv6DS/WlPt6E2ZSMqAr48c3J/3Fd/JsYVqHTRw
         2nia1gJTyZ1ZbWuC5Gp7eXg3IRN+ABl+YDRaBo2ZSDvdr1X0VjnB55uDYpZYY0A4wbN2
         ao4LMEubyrPeb0ZVokMTYHNYG7gVFWeBA9jEeuxQ2Cwn4ZUfji/JiZAoFtOA9xu4K8LM
         L1BgR4cNS27EMjJo7FOiBWkQIOLvb+ZBmamU3xsOaVVhsDVyLbn6Gqxf5LrRdAivPwSb
         QVaQ==
X-Gm-Message-State: ABuFfoh69lDPdvZypvdDf3mXEyssRwGmLvSKE4ZNeC/GVHNXidIuvF7H
        TYzd4suClHDcwasfK5qgcVF8CE7vLzwl
X-Google-Smtp-Source: ACcGV60mtsC+cetNKdkUIkiq+0PNT/W97Et5JArtC+2sJuOO2bKrTUtkZSWnT062YHBvTYPe37nCXSjx+miV
X-Received: by 2002:a63:4924:: with SMTP id w36-v6mr14607572pga.77.1539887928193;
 Thu, 18 Oct 2018 11:38:48 -0700 (PDT)
Date:   Thu, 18 Oct 2018 11:37:58 -0700
In-Reply-To: <20181018183758.81186-1-sbeller@google.com>
Message-Id: <20181018183758.81186-3-sbeller@google.com>
Mime-Version: 1.0
References: <CAGZ79kbpXQURMsZY15_k3rJ-dyH0i4qAGDv8umM8Hmx10ZdMMA@mail.gmail.com>
 <20181018183758.81186-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0
Subject: [RFC PATCH 2/2 (BREAKS BUILD)] builtin/merge-base.c: do not rely on
 the_repository any more
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com, stolee@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To avoid creeping in the dependency of the_repository,
use GIT_NO_THE_REPOSITORY in the test to prove it still works.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

This doesn't work yet, as we have not converted get_oid, yet.
It proves that GIT_NO_THE_REPOSITORY works, though.

Stefan

 builtin/merge-base.c  | 67 ++++++++++++++++++++++++++-----------------
 t/t6010-merge-base.sh |  3 +-
 2 files changed, 43 insertions(+), 27 deletions(-)

diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index 1c92099070..29341f8839 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -1,3 +1,4 @@
+#define NO_THE_REPOSITORY_COMPATIBILITY_MACROS
 #include "builtin.h"
 #include "cache.h"
 #include "config.h"
@@ -37,27 +38,28 @@ static const char * const merge_base_usage[] = {
 	NULL
 };
 
-static struct commit *get_commit_reference(const char *arg)
+static struct commit *get_commit_reference(struct repository *r,
+					   const char *arg)
 {
 	struct object_id revkey;
-	struct commit *r;
+	struct commit *ref;
 
 	if (get_oid(arg, &revkey))
 		die("Not a valid object name %s", arg);
-	r = lookup_commit_reference(the_repository, &revkey);
-	if (!r)
+	ref = lookup_commit_reference(r, &revkey);
+	if (!ref)
 		die("Not a valid commit name %s", arg);
 
-	return r;
+	return ref;
 }
 
-static int handle_independent(int count, const char **args)
+static int handle_independent(struct repository *r, int count, const char **args)
 {
 	struct commit_list *revs = NULL, *rev;
 	int i;
 
 	for (i = count - 1; i >= 0; i--)
-		commit_list_insert(get_commit_reference(args[i]), &revs);
+		commit_list_insert(get_commit_reference(r, args[i]), &revs);
 
 	reduce_heads_replace(&revs);
 
@@ -71,14 +73,16 @@ static int handle_independent(int count, const char **args)
 	return 0;
 }
 
-static int handle_octopus(int count, const char **args, int show_all)
+static int handle_octopus(struct repository *r,
+			  int count, const char **args,
+			  int show_all)
 {
 	struct commit_list *revs = NULL;
 	struct commit_list *result, *rev;
 	int i;
 
 	for (i = count - 1; i >= 0; i--)
-		commit_list_insert(get_commit_reference(args[i]), &revs);
+		commit_list_insert(get_commit_reference(r, args[i]), &revs);
 
 	result = get_octopus_merge_bases(revs);
 	free_commit_list(revs);
@@ -97,15 +101,15 @@ static int handle_octopus(int count, const char **args, int show_all)
 	return 0;
 }
 
-static int handle_is_ancestor(int argc, const char **argv)
+static int handle_is_ancestor(struct repository *r, int argc, const char **argv)
 {
 	struct commit *one, *two;
 
 	if (argc != 2)
 		die("--is-ancestor takes exactly two commits");
-	one = get_commit_reference(argv[0]);
-	two = get_commit_reference(argv[1]);
-	if (in_merge_bases(one, two))
+	one = get_commit_reference(r, argv[0]);
+	two = get_commit_reference(r, argv[1]);
+	if (repo_in_merge_bases(r, one, two))
 		return 0;
 	else
 		return 1;
@@ -116,19 +120,22 @@ struct rev_collect {
 	int nr;
 	int alloc;
 	unsigned int initial : 1;
+	struct repository *repo;
 };
 
-static void add_one_commit(struct object_id *oid, struct rev_collect *revs)
+static void add_one_commit(struct repository *r,
+			   struct object_id *oid,
+			   struct rev_collect *revs)
 {
 	struct commit *commit;
 
 	if (is_null_oid(oid))
 		return;
 
-	commit = lookup_commit(the_repository, oid);
+	commit = lookup_commit(r, oid);
 	if (!commit ||
 	    (commit->object.flags & TMP_MARK) ||
-	    parse_commit(commit))
+	    repo_parse_commit(r, commit))
 		return;
 
 	ALLOC_GROW(revs->commit, revs->nr + 1, revs->alloc);
@@ -144,13 +151,13 @@ static int collect_one_reflog_ent(struct object_id *ooid, struct object_id *noid
 
 	if (revs->initial) {
 		revs->initial = 0;
-		add_one_commit(ooid, revs);
+		add_one_commit(revs->repo, ooid, revs);
 	}
-	add_one_commit(noid, revs);
+	add_one_commit(revs->repo, noid, revs);
 	return 0;
 }
 
-static int handle_fork_point(int argc, const char **argv)
+static int handle_fork_point(struct repository *r, int argc, const char **argv)
 {
 	struct object_id oid;
 	char *refname;
@@ -173,13 +180,14 @@ static int handle_fork_point(int argc, const char **argv)
 	if (get_oid(commitname, &oid))
 		die("Not a valid object name: '%s'", commitname);
 
-	derived = lookup_commit_reference(the_repository, &oid);
+	derived = lookup_commit_reference(r, &oid);
 	memset(&revs, 0, sizeof(revs));
 	revs.initial = 1;
+	revs.repo = r;
 	for_each_reflog_ent(refname, collect_one_reflog_ent, &revs);
 
 	if (!revs.nr && !get_oid(refname, &oid))
-		add_one_commit(&oid, &revs);
+		add_one_commit(r, &oid, &revs);
 
 	for (i = 0; i < revs.nr; i++)
 		revs.commit[i]->object.flags &= ~TMP_MARK;
@@ -217,6 +225,7 @@ int cmd_merge_base(int argc, const char **argv, const char *prefix)
 	int rev_nr = 0;
 	int show_all = 0;
 	int cmdmode = 0;
+	struct repository *r;
 
 	struct option options[] = {
 		OPT_BOOL('a', "all", &show_all, N_("output all common ancestors")),
@@ -234,27 +243,33 @@ int cmd_merge_base(int argc, const char **argv, const char *prefix)
 	git_config(git_default_config, NULL);
 	argc = parse_options(argc, argv, prefix, options, merge_base_usage, 0);
 
+	/*
+	 * TODO: once the config machinery can cope without proper setup of
+	 * the_repository, move this call up
+	 */
+	r = get_the_repository();
+
 	if (cmdmode == 'a') {
 		if (argc < 2)
 			usage_with_options(merge_base_usage, options);
 		if (show_all)
 			die("--is-ancestor cannot be used with --all");
-		return handle_is_ancestor(argc, argv);
+		return handle_is_ancestor(r, argc, argv);
 	}
 
 	if (cmdmode == 'r' && show_all)
 		die("--independent cannot be used with --all");
 
 	if (cmdmode == 'o')
-		return handle_octopus(argc, argv, show_all);
+		return handle_octopus(r, argc, argv, show_all);
 
 	if (cmdmode == 'r')
-		return handle_independent(argc, argv);
+		return handle_independent(r, argc, argv);
 
 	if (cmdmode == 'f') {
 		if (argc < 1 || 2 < argc)
 			usage_with_options(merge_base_usage, options);
-		return handle_fork_point(argc, argv);
+		return handle_fork_point(r, argc, argv);
 	}
 
 	if (argc < 2)
@@ -262,6 +277,6 @@ int cmd_merge_base(int argc, const char **argv, const char *prefix)
 
 	ALLOC_ARRAY(rev, argc);
 	while (argc-- > 0)
-		rev[rev_nr++] = get_commit_reference(*argv++);
+		rev[rev_nr++] = get_commit_reference(r, *argv++);
 	return show_merge_base(rev, rev_nr, show_all);
 }
diff --git a/t/t6010-merge-base.sh b/t/t6010-merge-base.sh
index 44c726ea39..ae1c85ee8d 100755
--- a/t/t6010-merge-base.sh
+++ b/t/t6010-merge-base.sh
@@ -15,7 +15,8 @@ GIT_COMMITTER_EMAIL=git@comm.iter.xz
 GIT_COMMITTER_NAME='C O Mmiter'
 GIT_AUTHOR_NAME='A U Thor'
 GIT_AUTHOR_EMAIL=git@au.thor.xz
-export GIT_COMMITTER_EMAIL GIT_COMMITTER_NAME GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL
+GIT_NO_THE_REPOSITORY=1
+export GIT_COMMITTER_EMAIL GIT_COMMITTER_NAME GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_NO_THE_REPOSITORY
 
 doit () {
 	OFFSET=$1 &&
-- 
2.19.0

