Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BBC2C433F5
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 22:33:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235025AbhKVWgZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 17:36:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233472AbhKVWgS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 17:36:18 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6771C061748
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 14:33:11 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id h1-20020a170902f54100b00143c6409dbcso525182plf.5
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 14:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=GrmFINVUdKN4GO230pAsYoAhNxEwlrap+M0B4LV6Vrk=;
        b=tQABEP5COMkfMwvB66fjvfgrvrxkuGaNtFzAxJPo4nmvpizO5bP1+QSViKMY3t/DXz
         LYznPwnvzhKI43gu3EOaCmNn2zDUq1lMlGT2YCXAXzxyrI0S6t8nDt/t1Gm1nk6ebWwN
         JjmxIh1ESdC94ZWy6hMaukZwtlhLN1dtMdO3CJOwAkvvLQGOoyUkCkAtr2wmI0rSDXJR
         BPbF6McKjppOPXcTtmrwG5uqrcao/XBq3coxGD/AUCZ+LSsEpsrBIqELp8WQZC4L7S2V
         CzJR1c7RFMxowXs6+b9t/EGLN5w+8DHijcPfBmiyZj9yo3qFVIFxUt+8qQpSkkBhpbMi
         k8Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GrmFINVUdKN4GO230pAsYoAhNxEwlrap+M0B4LV6Vrk=;
        b=bMZFq6JYgoLH+eKrTYOMfoYVLQ7sUSf5bGUTIujxf3boN56EPGqJs8H5LJgw+So0tm
         KegNi9oiKYdXfDUGDHptrRihpcrQXzgKJZXXx8QQh1lwkBQ9X2vrGDdyS9vXY45yDIh4
         66txrGQ79NeLLHIbVHT6MYnQPoFyYIw9k9faDwpni05wblDK3+XIfQBee6nCvXSAbUqa
         +DiEIzokYR2bmIeIzuV8Iu4r1/ymtOQL84ND6JPB18Z8SIThx5lcoG6K9fmQabuTp3J3
         ulgN0mW1wB/eHfd1wg7sa3w3NYt2fZLLTNfHoCRJ4P0YyatUqzrZJhIF7+91aUqLY4PW
         hD/g==
X-Gm-Message-State: AOAM531y4o0r1jTTwL+kh7Fk/SbgmhoCKRFonae8CPWqyXuYMFcvF5Xz
        EtZOcylPXZe964vj4lo4qkY3nh+EZBBUy4l61Pb3c+jAoIwaRYtSjXvDi+vMUmgAidFzwCQsG2u
        P5gjt3TJC1KJJVdljAZsfc83RRKbRYm5PrSphlp5kgk4RIs6klpYjuXSsuB2L+A8=
X-Google-Smtp-Source: ABdhPJzlL7qTTywSoLcZBZLjgIdbN/ZntvdQnGnITyipPd3ULEUkz+MLPCUQqLHw/tAYXLiXlOEykWlLKLQLaA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:314e:: with SMTP id
 ip14mr448299pjb.130.1637620391306; Mon, 22 Nov 2021 14:33:11 -0800 (PST)
Date:   Mon, 22 Nov 2021 14:32:51 -0800
In-Reply-To: <20211122223252.19922-1-chooglen@google.com>
Message-Id: <20211122223252.19922-4-chooglen@google.com>
Mime-Version: 1.0
References: <20211122223252.19922-1-chooglen@google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH 3/4] branch: add --dry-run option to branch
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When running "git branch --recurse-submodules topic", it would be useful
to know whether or not 'topic' is a valid branch for all repositories.
Currently there is no way to test this without actually creating the
branch.

Add a --dry-run option to branch creation that can check whether or not
a branch name and start point would be valid for a repository without
creating a branch. Refactor cmd_branch() to make the chosen action more
obvious.

Incidentally, fix an incorrect usage string that combined the 'list'
usage of git branch (-l) with the 'create' usage; this string has been
incorrect since its inception, a8dfd5eac4 (Make builtin-branch.c use
parse_options., 2007-10-07).

Signed-off-by: Glen Choo <chooglen@google.com>
---
The --dry-run option is motivated mainly by --recurse-submodules. To my
knowledge, there isn't a strong existing demand, but this might be
mildly useful to some users.

 Documentation/git-branch.txt |  8 ++++++-
 branch.c                     |  6 ++---
 branch.h                     | 22 ++++++++++++++++++
 builtin/branch.c             | 44 ++++++++++++++++++++++++++----------
 t/t3200-branch.sh            | 13 +++++++++++
 5 files changed, 77 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 5449767121..8cdc33c097 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -16,7 +16,7 @@ SYNOPSIS
 	[--points-at <object>] [--format=<format>]
 	[(-r | --remotes) | (-a | --all)]
 	[--list] [<pattern>...]
-'git branch' [--track | --no-track] [-f] <branchname> [<start-point>]
+'git branch' [--track | --no-track] [-f] [--dry-run | -n] <branchname> [<start-point>]
 'git branch' (--set-upstream-to=<upstream> | -u <upstream>) [<branchname>]
 'git branch' --unset-upstream [<branchname>]
 'git branch' (-m | -M) [<oldbranch>] <newbranch>
@@ -205,6 +205,12 @@ This option is only applicable in non-verbose mode.
 --no-abbrev::
 	Display the full sha1s in the output listing rather than abbreviating them.
 
+-n::
+--dry-run::
+	Can only be used when creating a branch. If the branch creation
+	would fail, show the relevant error message. If the branch
+	creation would succeed, show nothing.
+
 -t::
 --track::
 	When creating a new branch, set up `branch.<name>.remote` and
diff --git a/branch.c b/branch.c
index f8b755513f..528cb2d639 100644
--- a/branch.c
+++ b/branch.c
@@ -206,9 +206,9 @@ N_("\n"
 "will track its remote counterpart, you may want to use\n"
 "\"git push -u\" to set the upstream config as you push.");
 
-static void validate_branch_start(struct repository *r, const char *start_name,
-				  enum branch_track track,
-				  struct object_id *oid, char **full_ref)
+void validate_branch_start(struct repository *r, const char *start_name,
+			   enum branch_track track, struct object_id *oid,
+			   char **full_ref)
 {
 	struct commit *commit;
 	int explicit_tracking = 0;
diff --git a/branch.h b/branch.h
index 75cefcdcbd..d8e5ff4e28 100644
--- a/branch.h
+++ b/branch.h
@@ -3,6 +3,7 @@
 
 struct repository;
 struct strbuf;
+struct object_id;
 
 enum branch_track {
 	BRANCH_TRACK_UNSPECIFIED = -1,
@@ -17,6 +18,27 @@ extern enum branch_track git_branch_track;
 
 /* Functions for acting on the information about branches. */
 
+/*
+ * Validates whether a ref is a valid starting point for a branch, where:
+ *
+ *   - r is the repository to validate the branch for
+ *
+ *   - start_name is the ref that we would like to test
+ *
+ *   - track is the tracking mode of the new branch. If tracking is
+ *     explicitly requested, start_name must be a branch (because
+ *     otherwise start_name cannot be tracked)
+ *
+ *   - oid is an out parameter containing the object_id of start_name
+ *
+ *   - full_ref is an out parameter containing the 'full' form of
+ *     start_name e.g. refs/heads/main instead of main
+ *
+ */
+void validate_branch_start(struct repository *r, const char *start_name,
+			   enum branch_track track, struct object_id *oid,
+			   char **full_ref);
+
 /*
  * This sets the branch.<new_ref>.{remote,merge} config settings so that
  * branch 'new_ref' tracks 'orig_ref'. This is called when branches are
diff --git a/builtin/branch.c b/builtin/branch.c
index eb5c117a6e..5d4b9c82b4 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -27,7 +27,8 @@
 
 static const char * const builtin_branch_usage[] = {
 	N_("git branch [<options>] [-r | -a] [--merged] [--no-merged]"),
-	N_("git branch [<options>] [-l] [-f] <branch-name> [<start-point>]"),
+	N_("git branch [<options>] [-l] [<pattern>...]"),
+	N_("git branch [<options>] [-f] [--dry-run | -n] <branch-name> [<start-point>]"),
 	N_("git branch [<options>] [-r] (-d | -D) <branch-name>..."),
 	N_("git branch [<options>] (-m | -M) [<old-branch>] <new-branch>"),
 	N_("git branch [<options>] (-c | -C) [<old-branch>] <new-branch>"),
@@ -616,14 +617,14 @@ static int edit_branch_description(const char *branch_name)
 
 int cmd_branch(int argc, const char **argv, const char *prefix)
 {
-	int delete = 0, rename = 0, copy = 0, force = 0, list = 0;
-	int show_current = 0;
-	int reflog = 0, edit_description = 0;
-	int quiet = 0, unset_upstream = 0;
+	/* possible actions */
+	int delete = 0, rename = 0, copy = 0, force = 0, list = 0, create = 0,
+	    unset_upstream = 0, show_current = 0, edit_description = 0;
+	/* possible options */
+	int reflog = 0, quiet = 0, dry_run = 0, icase = 0;
 	const char *new_upstream = NULL;
 	enum branch_track track;
 	struct ref_filter filter;
-	int icase = 0;
 	static struct ref_sorting *sorting = NULL, **sorting_tail = &sorting;
 	struct ref_format format = REF_FORMAT_INIT;
 
@@ -670,6 +671,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 			N_("print only branches of the object"), parse_opt_object_name),
 		OPT_BOOL('i', "ignore-case", &icase, N_("sorting and filtering are case insensitive")),
 		OPT_STRING(  0 , "format", &format.format, N_("format"), N_("format to use for the output")),
+		OPT__DRY_RUN(&dry_run, N_("show whether the branch would be created")),
 		OPT_END(),
 	};
 
@@ -705,10 +707,15 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	    filter.reachable_from || filter.unreachable_from || filter.points_at.nr)
 		list = 1;
 
-	if (!!delete + !!rename + !!copy + !!new_upstream + !!show_current +
-	    list + edit_description + unset_upstream > 1)
+	create = 1 - (!!delete + !!rename + !!copy + !!new_upstream +
+		      !!show_current + !!list + !!edit_description +
+		      !!unset_upstream);
+	if (create < 0)
 		usage_with_options(builtin_branch_usage, options);
 
+	if (dry_run && !create)
+		die(_("--dry-run can only be used when creating branches"));
+
 	if (filter.abbrev == -1)
 		filter.abbrev = DEFAULT_ABBREV;
 	filter.ignore_case = icase;
@@ -844,7 +851,10 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		strbuf_addf(&buf, "branch.%s.merge", branch->name);
 		git_config_set_multivar(buf.buf, NULL, NULL, CONFIG_FLAGS_MULTI_REPLACE);
 		strbuf_release(&buf);
-	} else if (argc > 0 && argc <= 2) {
+	} else if (create && argc > 0 && argc <= 2) {
+		const char *branch_name = argv[0];
+		const char *start_name = (argc == 2) ? argv[1] : head;
+
 		if (filter.kind != FILTER_REFS_BRANCHES)
 			die(_("The -a, and -r, options to 'git branch' do not take a branch name.\n"
 				  "Did you mean to use: -a|-r --list <pattern>?"));
@@ -852,10 +862,20 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		if (track == BRANCH_TRACK_OVERRIDE)
 			die(_("the '--set-upstream' option is no longer supported. Please use '--track' or '--set-upstream-to' instead."));
 
-		create_branch(the_repository,
-			      argv[0], (argc == 2) ? argv[1] : head,
-			      force, 0, reflog, quiet, track);
+		if (dry_run) {
+			struct strbuf buf = STRBUF_INIT;
+			char *unused_full_ref;
+			struct object_id unused_oid;
 
+			validate_new_branchname(branch_name, &buf, force);
+			validate_branch_start(the_repository, start_name, track,
+					      &unused_oid, &unused_full_ref);
+			strbuf_release(&buf);
+			FREE_AND_NULL(unused_full_ref);
+			return 0;
+		}
+		create_branch(the_repository, branch_name, start_name, force, 0,
+			      reflog, quiet, track);
 	} else
 		usage_with_options(builtin_branch_usage, options);
 
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 6bf95a1707..653891736a 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -59,6 +59,19 @@ test_expect_success 'git branch --force abc should succeed when abc exists' '
 	test_cmp expect actual
 '
 
+test_expect_success 'git branch --dry-run abc should fail when abc exists' '
+	test_must_fail git branch --dry-run abc
+'
+
+test_expect_success 'git branch --dry-run --force abc should succeed when abc exists' '
+	git branch --dry-run --force abc
+'
+
+test_expect_success 'git branch --dry-run def should not create a branch' '
+	git branch --dry-run def &&
+	test_must_fail git rev-parse def
+'
+
 test_expect_success 'git branch a/b/c should create a branch' '
 	git branch a/b/c && test_path_is_file .git/refs/heads/a/b/c
 '
-- 
2.33.GIT

