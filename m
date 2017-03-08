Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC8DD202D7
	for <e@80x24.org>; Wed,  8 Mar 2017 20:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754339AbdCHU33 (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 15:29:29 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35242 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754335AbdCHU31 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 15:29:27 -0500
Received: by mail-wm0-f66.google.com with SMTP id z63so7913987wmg.2
        for <git@vger.kernel.org>; Wed, 08 Mar 2017 12:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5X2OAvIYRHSGkj9kTmcdDYAvYbZSDg3BMPGeofkl4NI=;
        b=f4rB6qf6KIScC5ywwiDPGISte+9iazeV3QtS0p8tGZ7fBj7KmDAnWmZ7PCl9qmNL0I
         8bDV1JyayOBC1/zpGxWVLCSsisWcxN4+pJlfULeH9Lx9GOCj96ULBwyBzxW/6jlfZ3+8
         FHCBYBmUBcCj2oII3aETS8nXeSEQSo2JINWn9//Zy9wlWACcsAeCp/GwFoxoGFxnAYnr
         LbboA5Mhd3eqZVuQbCwDzrTkVWjGSwJ/OmX64oVas2zhPZjK7idO5c6LFz+6Y9fWGu6e
         /fk8H0MHocDHOouRBBUz+aKe8TSwjvg5GPWKAgOovyGi9QMKvdzQxYS5zESJFBzRtFos
         uC7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5X2OAvIYRHSGkj9kTmcdDYAvYbZSDg3BMPGeofkl4NI=;
        b=JgHvq3v+B6SF8e7LQOnVwMrs5Egt1XOzieQGpt+buSvln0aIwToGXaPlu29tWCH+th
         YGoHvrxSaib4/U5/TbnVvl5V6gji1Kjshx2sS33IWhEUCyoHUvcTpCeUyp2DQv9Bjbhl
         29j5JaYJWyb+ySX6ErTFucZw1Clt5tKgGdA5NKZIddsQilJ15LiUWgkXPehfKVvwCkx3
         xDYc5PWldbyQIzivBvYx9C/W46oPfXB5Bc1EjaKXGbZEd+3WxCUcjV6Z1I+DcqkAdE7t
         kaVfko+HHCkZ/jHioV2xlqRPOxQfDDRfQYCpxkM/K7L7l1FUv4UiTyzPhQoFwY6LKdCt
         iU9A==
X-Gm-Message-State: AMke39kaKmF1uob/+X1VRZ2z8ctPNmeY2HX7ubMCpVsoe0a456vTkGVrzqI//KdoZTrfMw==
X-Received: by 10.28.60.66 with SMTP id j63mr7413484wma.74.1489004437437;
        Wed, 08 Mar 2017 12:20:37 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id i82sm4825667wmf.1.2017.03.08.12.20.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 08 Mar 2017 12:20:36 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Lars Hjemli <hjemli@gmail.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] branch & tag: Add a --no-contains option
Date:   Wed,  8 Mar 2017 20:20:25 +0000
Message-Id: <20170308202025.17900-1-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the branch & tag commands to have a --no-contains option in
addition to their longstanding --contains options.

The use-case I have for this is mainly to find the last-good rollout
tag given a known-bad <commit>. Right given a hypothetically bad
commit v2.10.1-3-gcf5c7253e0 now you can find that with this hacky
one-liner:

    (./git tag -l 'v[0-9]*'; ./git tag -l 'v[0-9]*' --contains v2.10.1-3-gcf5c7253e0)|sort|uniq -c|grep -E '^ *1 '|awk '{print $2}'

But with the --no-contains option you can now get the exact same
output with:

    ./git tag -l 'v[0-9]*' --no-contains v2.10.1-3-gcf5c7253e0 | sort

Once I'd implemented this for "tag" it was easy enough to add it for
"branch". I haven't added it to "for-each-ref" but that would be
trivial if anyone cares, but that use-case would be even more obscure
than adding it to "branch", so I haven't bothered. The "describe"
command also has a --contains option, but its semantics are unrelated
to what tag/branch/for-each-ref use --contains for, and I don't see
how a --no-contains option for it would make any sense.

More notes about this patch:

 * I'm not really happy with the "special attention" documentation
   example in git-branch.txt, but it follows logically from the
   description for --contains just above it which I think is overly
   specific as well. IMO that entire NOTES section in git-branch.txt
   could just be removed.

 * I'm adding a --without option as an alias for --no-contains for
   consistency with --with and --contains. Since we don't even
   document --with anymore (or test it) perhaps we shouldn't be adding
   --without.

 * Where I'm changing existing documentation lines I'm mainly word
   wrapping at 75 columns to be consistent with the existing style.

 * Ditto the minor change to git-completion.bash.

 * Perhaps we should just copy/paste commit_contains() into
   commit_no_contains() and skip the ternary struct assignment. It's a
   hot loop, but I have faith in modern compilers.

 * All of the test changes I've made are just doing the inverse of the
   existing --contains tests, with this --no-contains for both tag &
   branch should be just as tested as the existing --contains option.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-branch.txt           |  24 +++--
 Documentation/git-tag.txt              |   6 +-
 builtin/branch.c                       |   4 +-
 builtin/tag.c                          |   2 +
 contrib/completion/git-completion.bash |   9 +-
 parse-options.h                        |   4 +-
 ref-filter.c                           |  17 ++--
 ref-filter.h                           |   1 +
 t/t3201-branch-contains.sh             |  40 +++++++-
 t/t7004-tag.sh                         | 163 ++++++++++++++++++++++++++++++++-
 10 files changed, 245 insertions(+), 25 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 092f1bcf9f..316ec5b2d4 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 'git branch' [--color[=<when>] | --no-color] [-r | -a]
 	[--list] [-v [--abbrev=<length> | --no-abbrev]]
 	[--column[=<options>] | --no-column]
-	[(--merged | --no-merged | --contains) [<commit>]] [--sort=<key>]
+	[(--merged | --no-merged | --contains | --no-contains) [<commit>]] [--sort=<key>]
 	[--points-at <object>] [--format=<format>] [<pattern>...]
 'git branch' [--set-upstream | --track | --no-track] [-l] [-f] <branchname> [<start-point>]
 'git branch' (--set-upstream-to=<upstream> | -u <upstream>) [<branchname>]
@@ -35,11 +35,12 @@ as branch creation.
 
 With `--contains`, shows only the branches that contain the named commit
 (in other words, the branches whose tip commits are descendants of the
-named commit).  With `--merged`, only branches merged into the named
-commit (i.e. the branches whose tip commits are reachable from the named
-commit) will be listed.  With `--no-merged` only branches not merged into
-the named commit will be listed.  If the <commit> argument is missing it
-defaults to `HEAD` (i.e. the tip of the current branch).
+named commit), `--no-contains` inverts it. With `--merged`, only branches
+merged into the named commit (i.e. the branches whose tip commits are
+reachable from the named commit) will be listed.  With `--no-merged` only
+branches not merged into the named commit will be listed.  If the <commit>
+argument is missing it defaults to `HEAD` (i.e. the tip of the current
+branch).
 
 The command's second form creates a new branch head named <branchname>
 which points to the current `HEAD`, or <start-point> if given.
@@ -213,6 +214,10 @@ start-point is either a local or remote-tracking branch.
 	Only list branches which contain the specified commit (HEAD
 	if not specified). Implies `--list`.
 
+--no-contains [<commit>]::
+	Only list branches which don't contain the specified commit
+	(HEAD if not specified). Implies `--list`.
+
 --merged [<commit>]::
 	Only list branches whose tips are reachable from the
 	specified commit (HEAD if not specified). Implies `--list`.
@@ -296,13 +301,16 @@ If you are creating a branch that you want to checkout immediately, it is
 easier to use the git checkout command with its `-b` option to create
 a branch and check it out with a single command.
 
-The options `--contains`, `--merged` and `--no-merged` serve three related
-but different purposes:
+The options `--contains`, `--no-contains`, `--merged` and `--no-merged`
+serve three related but different purposes:
 
 - `--contains <commit>` is used to find all branches which will need
   special attention if <commit> were to be rebased or amended, since those
   branches contain the specified <commit>.
 
+- `--no-contains <commit>` is used to find those branches which won't need
+  that special attention.
+
 - `--merged` is used to find all branches which can be safely deleted,
   since those branches are fully contained by HEAD.
 
diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 525737a5d8..4938496194 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 'git tag' [-a | -s | -u <keyid>] [-f] [-m <msg> | -F <file>]
 	<tagname> [<commit> | <object>]
 'git tag' -d <tagname>...
-'git tag' [-n[<num>]] -l [--contains <commit>] [--points-at <object>]
+'git tag' [-n[<num>]] -l [--[no-]contains <commit>] [--points-at <object>]
 	[--column[=<options>] | --no-column] [--create-reflog] [--sort=<key>]
 	[--format=<format>] [--[no-]merged [<commit>]] [<pattern>...]
 'git tag' -v [--format=<format>] <tagname>...
@@ -124,6 +124,10 @@ This option is only applicable when listing tags without annotation lines.
 	Only list tags which contain the specified commit (HEAD if not
 	specified).
 
+--no-contains [<commit>]::
+	Only list tags which don't contain the specified commit (HEAD if
+	not secified).
+
 --points-at <object>::
 	Only list tags of the given object.
 
diff --git a/builtin/branch.c b/builtin/branch.c
index 94f7de7fa5..e8d534604c 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -548,7 +548,9 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT_SET_INT('r', "remotes",     &filter.kind, N_("act on remote-tracking branches"),
 			FILTER_REFS_REMOTES),
 		OPT_CONTAINS(&filter.with_commit, N_("print only branches that contain the commit")),
+		OPT_NO_CONTAINS(&filter.no_commit, N_("print only branches that don't contain the commit")),
 		OPT_WITH(&filter.with_commit, N_("print only branches that contain the commit")),
+		OPT_WITHOUT(&filter.with_commit, N_("print only branches that don't contain the commit")),
 		OPT__ABBREV(&filter.abbrev),
 
 		OPT_GROUP(N_("Specific git-branch actions:")),
@@ -604,7 +606,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	if (!delete && !rename && !edit_description && !new_upstream && !unset_upstream && argc == 0)
 		list = 1;
 
-	if (filter.with_commit || filter.merge != REF_FILTER_MERGED_NONE || filter.points_at.nr)
+	if (filter.with_commit || filter.no_commit || filter.merge != REF_FILTER_MERGED_NONE || filter.points_at.nr)
 		list = 1;
 
 	if (!!delete + !!rename + !!new_upstream +
diff --git a/builtin/tag.c b/builtin/tag.c
index ad29be6923..737a83028a 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -424,7 +424,9 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		OPT_GROUP(N_("Tag listing options")),
 		OPT_COLUMN(0, "column", &colopts, N_("show tag list in columns")),
 		OPT_CONTAINS(&filter.with_commit, N_("print only tags that contain the commit")),
+		OPT_NO_CONTAINS(&filter.no_commit, N_("print only tags that don't contain the commit")),
 		OPT_WITH(&filter.with_commit, N_("print only tags that contain the commit")),
+		OPT_WITHOUT(&filter.no_commit, N_("print only tags that don't contain the commit")),
 		OPT_MERGED(&filter, N_("print only tags that are merged")),
 		OPT_NO_MERGED(&filter, N_("print only tags that are not merged")),
 		OPT_CALLBACK(0 , "sort", sorting_tail, N_("key"),
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index fc32286a43..fa3da49478 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1093,9 +1093,9 @@ _git_branch ()
 	--*)
 		__gitcomp "
 			--color --no-color --verbose --abbrev= --no-abbrev
-			--track --no-track --contains --merged --no-merged
-			--set-upstream-to= --edit-description --list
-			--unset-upstream --delete --move --remotes
+			--track --no-track --contains --no-contains --merged
+			--no-merged --set-upstream-to= --edit-description
+			--list --unset-upstream --delete --move --remotes
 			--column --no-column --sort= --points-at
 			"
 		;;
@@ -2862,7 +2862,8 @@ _git_tag ()
 		__gitcomp "
 			--list --delete --verify --annotate --message --file
 			--sign --cleanup --local-user --force --column --sort=
-			--contains --points-at --merged --no-merged --create-reflog
+			--contains --no-contains --points-at --merged
+			--no-merged --create-reflog
 			"
 		;;
 	esac
diff --git a/parse-options.h b/parse-options.h
index dcd8a0926c..0eac90b510 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -258,7 +258,9 @@ extern int parse_opt_passthru_argv(const struct option *, const char *, int);
 	  PARSE_OPT_LASTARG_DEFAULT | flag, \
 	  parse_opt_commits, (intptr_t) "HEAD" \
 	}
-#define OPT_CONTAINS(v, h) _OPT_CONTAINS_OR_WITH("contains", v, h, 0)
+#define OPT_CONTAINS(v, h) _OPT_CONTAINS_OR_WITH("contains", v, h, PARSE_OPT_NONEG)
+#define OPT_NO_CONTAINS(v, h) _OPT_CONTAINS_OR_WITH("no-contains", v, h, PARSE_OPT_NONEG)
 #define OPT_WITH(v, h) _OPT_CONTAINS_OR_WITH("with", v, h, PARSE_OPT_HIDDEN)
+#define OPT_WITHOUT(v, h) _OPT_CONTAINS_OR_WITH("without", v, h, PARSE_OPT_HIDDEN)
 
 #endif
diff --git a/ref-filter.c b/ref-filter.c
index 1ec0fb8391..6a7ca1cdac 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1571,11 +1571,12 @@ static enum contains_result contains_tag_algo(struct commit *candidate,
 	return contains_test(candidate, want);
 }
 
-static int commit_contains(struct ref_filter *filter, struct commit *commit)
+static int commit_contains(struct ref_filter *filter, struct commit *commit, const int with_commit)
 {
+	struct commit_list *tmp = with_commit ? filter->with_commit : filter->no_commit;
 	if (filter->with_commit_tag_algo)
-		return contains_tag_algo(commit, filter->with_commit);
-	return is_descendant_of(commit, filter->with_commit);
+		return contains_tag_algo(commit, tmp);
+	return is_descendant_of(commit, tmp);
 }
 
 /*
@@ -1765,13 +1766,17 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
 	 * obtain the commit using the 'oid' available and discard all
 	 * non-commits early. The actual filtering is done later.
 	 */
-	if (filter->merge_commit || filter->with_commit || filter->verbose) {
+	if (filter->merge_commit || filter->with_commit || filter->no_commit || filter->verbose) {
 		commit = lookup_commit_reference_gently(oid->hash, 1);
 		if (!commit)
 			return 0;
-		/* We perform the filtering for the '--contains' option */
+		/* We perform the filtering for the '--contains' option... */
 		if (filter->with_commit &&
-		    !commit_contains(filter, commit))
+		    !commit_contains(filter, commit, 1))
+			return 0;
+		/* ...or for the `--no-contains' option */
+		if (filter->no_commit &&
+		    commit_contains(filter, commit, 0))
 			return 0;
 	}
 
diff --git a/ref-filter.h b/ref-filter.h
index 154e24c405..af85eb4592 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -53,6 +53,7 @@ struct ref_filter {
 	const char **name_patterns;
 	struct sha1_array points_at;
 	struct commit_list *with_commit;
+	struct commit_list *no_commit;
 
 	enum {
 		REF_FILTER_MERGED_NONE = 0,
diff --git a/t/t3201-branch-contains.sh b/t/t3201-branch-contains.sh
index 7f3ec47241..9fb79e66f0 100755
--- a/t/t3201-branch-contains.sh
+++ b/t/t3201-branch-contains.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-test_description='branch --contains <commit>, --merged, and --no-merged'
+test_description='branch --contains <commit>, --no-contains <commit> --merged, and --no-merged'
 
 . ./test-lib.sh
 
@@ -45,6 +45,22 @@ test_expect_success 'branch --contains master' '
 
 '
 
+test_expect_success 'branch --no-contains=master' '
+
+	git branch --no-contains=master >actual &&
+	>expect &&
+	test_cmp expect actual
+
+'
+
+test_expect_success 'branch --no-contains master' '
+
+	git branch --no-contains master >actual &&
+	>expect &&
+	test_cmp expect actual
+
+'
+
 test_expect_success 'branch --contains=side' '
 
 	git branch --contains=side >actual &&
@@ -55,6 +71,16 @@ test_expect_success 'branch --contains=side' '
 
 '
 
+test_expect_success 'branch --no-contains=side' '
+
+	git branch --no-contains=side >actual &&
+	{
+		echo "  master"
+	} >expect &&
+	test_cmp expect actual
+
+'
+
 test_expect_success 'branch --contains with pattern implies --list' '
 
 	git branch --contains=master master >actual &&
@@ -65,6 +91,14 @@ test_expect_success 'branch --contains with pattern implies --list' '
 
 '
 
+test_expect_success 'branch --no-contains with pattern implies --list' '
+
+	git branch --no-contains=master master >actual &&
+	>expect &&
+	test_cmp expect actual
+
+'
+
 test_expect_success 'side: branch --merged' '
 
 	git branch --merged >actual &&
@@ -126,7 +160,9 @@ test_expect_success 'branch --no-merged with pattern implies --list' '
 test_expect_success 'implicit --list conflicts with modification options' '
 
 	test_must_fail git branch --contains=master -d &&
-	test_must_fail git branch --contains=master -m foo
+	test_must_fail git branch --contains=master -m foo &&
+	test_must_fail git branch --no-contains=master -d &&
+	test_must_fail git branch --no-contains=master -m foo
 
 '
 
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index b4698ab5f5..f01bcafea4 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1385,6 +1385,23 @@ test_expect_success 'checking that first commit is in all tags (relative)' "
 	test_cmp expected actual
 "
 
+# All the --contains tests above, but with --no-contains
+test_expect_success 'checking that first commit is not listed in any tag with --no-contains  (hash)' "
+	>expected &&
+	git tag -l --no-contains $hash1 v* >actual &&
+	test_cmp expected actual
+"
+
+test_expect_success 'checking that first commit is in all tags (tag)' "
+	git tag -l --no-contains v1.0 v* >actual &&
+	test_cmp expected actual
+"
+
+test_expect_success 'checking that first commit is in all tags (relative)' "
+	git tag -l --no-contains HEAD~2 v* >actual &&
+	test_cmp expected actual
+"
+
 cat > expected <<EOF
 v2.0
 EOF
@@ -1394,6 +1411,17 @@ test_expect_success 'checking that second commit only has one tag' "
 	test_cmp expected actual
 "
 
+cat > expected <<EOF
+v0.2.1
+v1.0
+v1.0.1
+v1.1.3
+EOF
+
+test_expect_success 'inverse of the last test, with --no-contains' "
+	git tag -l --no-contains $hash2 v* >actual &&
+	test_cmp expected actual
+"
 
 cat > expected <<EOF
 EOF
@@ -1403,6 +1431,19 @@ test_expect_success 'checking that third commit has no tags' "
 	test_cmp expected actual
 "
 
+cat > expected <<EOF
+v0.2.1
+v1.0
+v1.0.1
+v1.1.3
+v2.0
+EOF
+
+test_expect_success 'conversely --no-contains on the third commit lists all tags' "
+	git tag -l --no-contains $hash3 v* >actual &&
+	test_cmp expected actual
+"
+
 # how about a simple merge?
 
 test_expect_success 'creating simple branch' '
@@ -1424,6 +1465,19 @@ test_expect_success 'checking that branch head only has one tag' "
 	test_cmp expected actual
 "
 
+cat > expected <<EOF
+v0.2.1
+v1.0
+v1.0.1
+v1.1.3
+v2.0
+EOF
+
+test_expect_success 'checking that branch head with --no-contains lists all but one tag' "
+	git tag -l --no-contains $hash4 v* >actual &&
+	test_cmp expected actual
+"
+
 test_expect_success 'merging original branch into this branch' '
 	git merge --strategy=ours master &&
         git tag v4.0
@@ -1445,6 +1499,20 @@ v1.0.1
 v1.1.3
 v2.0
 v3.0
+EOF
+
+test_expect_success 'checking that original branch head with --no-contains lists all but one tag now' "
+	git tag -l --no-contains $hash3 v* >actual &&
+	test_cmp expected actual
+"
+
+cat > expected <<EOF
+v0.2.1
+v1.0
+v1.0.1
+v1.1.3
+v2.0
+v3.0
 v4.0
 EOF
 
@@ -1453,6 +1521,12 @@ test_expect_success 'checking that initial commit is in all tags' "
 	test_cmp expected actual
 "
 
+test_expect_success 'checking that initial commit is in all tags with --no-contains' "
+	>expected &&
+	git tag -l --no-contains $hash1 v* >actual &&
+	test_cmp expected actual
+"
+
 # mixing modes and options:
 
 test_expect_success 'mixing incompatibles modes and options is forbidden' '
@@ -1708,8 +1782,91 @@ run_with_limited_stack () {
 
 test_lazy_prereq ULIMIT_STACK_SIZE 'run_with_limited_stack true'
 
+# These are all the tags we've created above
+cat >expect.no-contains <<EOF
+a1
+aa1
+annotated-again-v4.0
+annotated-tag
+annotated-v4.0
+blank-annotated-tag
+blank-signed-tag
+blankfile-annotated-tag
+blankfile-signed-tag
+blanknonlfile-annotated-tag
+blanknonlfile-signed-tag
+blanks-annotated-tag
+blanks-signed-tag
+cba
+comment-annotated-tag
+comment-signed-tag
+commentfile-annotated-tag
+commentfile-signed-tag
+commentnonlfile-annotated-tag
+commentnonlfile-signed-tag
+comments-annotated-tag
+comments-signed-tag
+empty-annotated-tag
+empty-signed-tag
+emptyfile-annotated-tag
+emptyfile-signed-tag
+far-far-away
+file-annotated-tag
+file-signed-tag
+foo1.10
+foo1.10-alpha
+foo1.10-beta
+foo1.10-delta
+foo1.10-gamma
+foo1.10-unlisted-suffix
+foo1.3
+foo1.6
+foo1.6-rc1
+foo1.6-rc2
+foo1.7
+foo1.7-after1
+foo1.7-before1
+foo1.8
+foo1.8-foo-bar
+foo1.8-foo-baz
+foo1.9-pre1
+foo1.9-pre2
+foo1.9-prerelease1
+forcesignannotated-annotate
+forcesignannotated-disabled
+forcesignannotated-implied-sign
+forcesignannotated-lightweight
+forged-tag
+implied-annotate
+implied-sign
+non-annotated-tag
+reuse
+signed-tag
+stag-lines
+stag-one-line
+stag-zero-lines
+stdin-annotated-tag
+stdin-signed-tag
+t210
+t211
+tag-from-subdir
+tag-from-subdir-2
+tag-lines
+tag-one-line
+tag-signed-tag
+tag-zero-lines
+u-signed-tag
+v0.2.1
+v1.0
+v1.0.1
+v1.1.3
+v2.0
+v3.0
+v4.0
+EOF
+
 # we require ulimit, this excludes Windows
-test_expect_success ULIMIT_STACK_SIZE '--contains works in a deep repo' '
+test_expect_success ULIMIT_STACK_SIZE '--contains and --no-contains work in a deep repo' '
 	>expect &&
 	i=1 &&
 	while test $i -lt 8000
@@ -1725,7 +1882,9 @@ EOF"
 	git checkout master &&
 	git tag far-far-away HEAD^ &&
 	run_with_limited_stack git tag --contains HEAD >actual &&
-	test_cmp expect actual
+	test_cmp expect actual &&
+	run_with_limited_stack git tag --no-contains HEAD >actual &&
+	test_cmp expect.no-contains actual
 '
 
 test_expect_success '--format should list tags as per format given' '
-- 
2.11.0

