Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5147F1FC43
	for <e@80x24.org>; Fri, 10 Mar 2017 20:34:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755344AbdCJUeG (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Mar 2017 15:34:06 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:36116 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753292AbdCJUeD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2017 15:34:03 -0500
Received: by mail-wm0-f48.google.com with SMTP id n11so3591753wma.1
        for <git@vger.kernel.org>; Fri, 10 Mar 2017 12:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fKLtoV3fT1/wPaTbjlp+JI2kH3TtPzv9fV4Th2HiLy8=;
        b=izlMJIgba3pp8WUQ7J+Uz9H0LdlNAmSeNZHzCgyXxv+r3RIdayI5ilgwYOBVt0NqDB
         DXJOrSDLa2DDKX0b8mcuW0h3dqEunpvT8FkuHiP4w9wTfQchuJbAdMkrRlgVF/lM/aAJ
         TDqPZ74FxxB8BBa1a/MFku1y3DShr6eKPg+C4213fmZzK2zN7ZBAgtPMHHcZ3ptJaQU0
         /utPZdVwo5c4fRhj0rPjTEJRGdtczks4QmntWauaB8tJs9euXvkHTC9T6BQZvQe3Detp
         nNYbzkLpGfQmma/AMEK0YFEfRPpuQx+lcWM+eGRBDW1BRbZ8aFGvPQbFSgncLxDlHR1p
         38Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fKLtoV3fT1/wPaTbjlp+JI2kH3TtPzv9fV4Th2HiLy8=;
        b=FHNEDgULdHUpUat03wkvmOpdFfwVkswqt7sffkBNM0zGCVl/i82V8eEf3VAlG/Eh0J
         5L4IMsEP0txr+pkIooBKPxwZlQOn9RXeIMqQjNupRHnNbekNXssFu0tsM2o/JV+HxV7y
         KdCoSKtb3zYNKYK8UJ130txgl0xX7OFU14OQ1/okjxsnWKpXImIjvripM8YL1BtfzOwJ
         fqw9EAq9OdDrSiNfK0jW9/RBb5N01jszTOL1ljVvSYGBVnDhz9AlloPHcxltRDbNbgy4
         HL+v+fJ11RELxluLLrSkZBzQbIJ6gSmIJ8jcHJR9RzYjgWjxYEGkIk9FLk1xP7gGYwDF
         7x5g==
X-Gm-Message-State: AFeK/H3YnOcoAG1LYgzexRjqK2ny0SU1LvEITdVMtR/1eOGTVly97eEipFoBd9pSIO2bow==
X-Received: by 10.28.166.133 with SMTP id p127mr738191wme.62.1489178040163;
        Fri, 10 Mar 2017 12:34:00 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id g13sm655794wmd.28.2017.03.10.12.33.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 Mar 2017 12:33:58 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Lars Hjemli <hjemli@gmail.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3] ref-filter: Add --no-contains option to tag/branch/for-each-ref
Date:   Fri, 10 Mar 2017 20:33:48 +0000
Message-Id: <20170310203348.675-1-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170309200243.2203-1-avarab@gmail.com>
References: <20170309200243.2203-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the tag, branch & for-each-ref commands to have a --no-contains
option in addition to their longstanding --contains options.

The use-case I have for this is to find the last-good rollout tag
given a known-bad <commit>. Right now, given a hypothetically bad
commit v2.10.1-3-gcf5c7253e0, you can find which git version to revert
to with this hacky two-liner:

    (./git tag -l 'v[0-9]*'; ./git tag -l 'v[0-9]*' --contains v2.10.1-3-gcf5c7253e0) \
        |sort|uniq -c|grep -E '^ *1 '|awk '{print $2}' | tail -n 10

But with the --no-contains option you can now get the exact same
output with:

    ./git tag -l 'v[0-9]*' --no-contains v2.10.1-3-gcf5c7253e0|sort|tail -n 10

The filtering machinery is generic between the tag, branch &
for-each-ref commands, so once I'd implemented it for tag it was
trivial to add support for this to the other two.

A practical use for this with "branch" is e.g. finding branches which
diverged between 2.8 & 2.10:

    ./git branch --contains v2.8.0 --no-contains v2.10.0

The "describe" command also has a --contains option, but its semantics
are unrelated to what tag/branch/for-each-ref use --contains for. I
don't see how a --no-contains option for "describe" would make any
sense, other than being exactly equivalent to not supplying --contains
at all, which would be confusing at best.

I'm adding a --without option to "tag" as an alias for --no-contains
for consistency with --with and --contains. Since we don't even
document --with anymore (or test it). The --with option is
undocumented, and possibly the only user of it is Junio[1]. But it's
trivial to support, so let's do that.

Where I'm changing existing documentation lines I'm mainly word
wrapping at 75 columns to be consistent with the existing style. The
changes to Documentation/ are much smaller with: git show --word-diff,
same for the minor change to git-completion.bash.

Most of the test changes I've made are just doing the inverse of the
existing --contains tests, with this change --no-contains for tag,
branch & for-each-ref is just as well tested as the existing
--contains option.

In addition to those tests I've added tests for --contains in
combination with --no-contains for all three commands, and a test for
"tag" which asserts that --no-contains won't find tree/blob tags,
which is slightly unintuitive, but consistent with how --contains
works.

When --contains and --no-contains are provided to "tag" we disable the
optimized code to find tags added in v1.7.2-rc1-1-gffc4b8012d. That
code changes flags on commit objects as an optimization, and thus
can't be called twice.

Jeff King has a WIP patch to fix that[2], but rather than try to
incorporate that into this already big patch I'm just disabling the
optimized codepath. Using both --contains and --no-contains will most
likely be rare, and we can get an initial correct version working &
optimize it later.

It's possible that the --merge & --no-merge codepaths for "tag" have a
similar bug, but as of writing I can't produce any evidence of that
via a brute-force test script[3].

1. <xmqqefy71iej.fsf@gitster.mtv.corp.google.com>
2. <20170309125132.tubwxtneffok4nrc@sigill.intra.peff.net>
3. <CACBZZX4W7brFe5ecTvQPMmf4X5_zH+dw3cB5xeVg+2hWYps0Ug@mail.gmail.com>

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

With the changes noted in my
<CACBZZX74fpEzic3Qs0kG5i5pb-up+Ct0cp71beDXaj+BoDcKRQ@mail.gmail.com>
&&
<CACBZZX7EW013ZhDtUWome5nOqLjha34B9gJCRQgc0J0qkvWBuA@mail.gmail.com>.

 Documentation/git-branch.txt           |  24 ++++---
 Documentation/git-for-each-ref.txt     |   6 +-
 Documentation/git-tag.txt              |   6 +-
 builtin/branch.c                       |   4 +-
 builtin/for-each-ref.c                 |   3 +-
 builtin/tag.c                          |  17 ++++-
 contrib/completion/git-completion.bash |   9 +--
 parse-options.h                        |   4 +-
 ref-filter.c                           |  16 +++--
 ref-filter.h                           |   1 +
 t/t3201-branch-contains.sh             |  51 +++++++++++++-
 t/t6302-for-each-ref-filter.sh         |  16 +++++
 t/t7004-tag.sh                         | 123 ++++++++++++++++++++++++++++++++-
 13 files changed, 251 insertions(+), 29 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 092f1bcf9f..28a36a8a0a 100644
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
+serve four related but different purposes:
 
 - `--contains <commit>` is used to find all branches which will need
   special attention if <commit> were to be rebased or amended, since those
   branches contain the specified <commit>.
 
+- `--no-contains <commit>` is the inverse of that, i.e. branches that don't
+  contain the specified <commit>.
+
 - `--merged` is used to find all branches which can be safely deleted,
   since those branches are fully contained by HEAD.
 
diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 111e1be6f5..83b93c75a8 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 'git for-each-ref' [--count=<count>] [--shell|--perl|--python|--tcl]
 		   [(--sort=<key>)...] [--format=<format>] [<pattern>...]
 		   [--points-at <object>] [(--merged | --no-merged) [<object>]]
-		   [--contains [<object>]]
+		   [(--contains | --no-contains) [<object>]]
 
 DESCRIPTION
 -----------
@@ -79,6 +79,10 @@ OPTIONS
 	Only list refs which contain the specified commit (HEAD if not
 	specified).
 
+--no-contains [<object>]::
+	Only list refs which don't contain the specified commit (HEAD
+	if not specified).
+
 --ignore-case::
 	Sorting and filtering refs are case insensitive.
 
diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 525737a5d8..d9243bf5e4 100644
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
+	not specified).
+
 --points-at <object>::
 	Only list tags of the given object.
 
diff --git a/builtin/branch.c b/builtin/branch.c
index 94f7de7fa5..dd96319726 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -548,7 +548,9 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT_SET_INT('r', "remotes",     &filter.kind, N_("act on remote-tracking branches"),
 			FILTER_REFS_REMOTES),
 		OPT_CONTAINS(&filter.with_commit, N_("print only branches that contain the commit")),
+		OPT_NO_CONTAINS(&filter.no_commit, N_("print only branches that don't contain the commit")),
 		OPT_WITH(&filter.with_commit, N_("print only branches that contain the commit")),
+		OPT_WITHOUT(&filter.no_commit, N_("print only branches that don't contain the commit")),
 		OPT__ABBREV(&filter.abbrev),
 
 		OPT_GROUP(N_("Specific git-branch actions:")),
@@ -604,7 +606,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	if (!delete && !rename && !edit_description && !new_upstream && !unset_upstream && argc == 0)
 		list = 1;
 
-	if (filter.with_commit || filter.merge != REF_FILTER_MERGED_NONE || filter.points_at.nr)
+	if (filter.with_commit || filter.no_commit || filter.merge != REF_FILTER_MERGED_NONE || filter.points_at.nr)
 		list = 1;
 
 	if (!!delete + !!rename + !!new_upstream +
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index df41fa0350..a11542c4fd 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -9,7 +9,7 @@ static char const * const for_each_ref_usage[] = {
 	N_("git for-each-ref [<options>] [<pattern>]"),
 	N_("git for-each-ref [--points-at <object>]"),
 	N_("git for-each-ref [(--merged | --no-merged) [<object>]]"),
-	N_("git for-each-ref [--contains [<object>]]"),
+	N_("git for-each-ref [(--contains | --no-contains) [<object>]]"),
 	NULL
 };
 
@@ -43,6 +43,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 		OPT_MERGED(&filter, N_("print only refs that are merged")),
 		OPT_NO_MERGED(&filter, N_("print only refs that are not merged")),
 		OPT_CONTAINS(&filter.with_commit, N_("print only refs which contain the commit")),
+		OPT_NO_CONTAINS(&filter.no_commit, N_("print only refs which don't contain the commit")),
 		OPT_BOOL(0, "ignore-case", &icase, N_("sorting and filtering are case insensitive")),
 		OPT_END(),
 	};
diff --git a/builtin/tag.c b/builtin/tag.c
index ad29be6923..57289132a9 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -22,7 +22,7 @@
 static const char * const git_tag_usage[] = {
 	N_("git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>] <tagname> [<head>]"),
 	N_("git tag -d <tagname>..."),
-	N_("git tag -l [-n[<num>]] [--contains <commit>] [--points-at <object>]"
+	N_("git tag -l [-n[<num>]] [--[no-]contains <commit>] [--points-at <object>]"
 		"\n\t\t[--format=<format>] [--[no-]merged [<commit>]] [<pattern>...]"),
 	N_("git tag -v [--format=<format>] <tagname>..."),
 	NULL
@@ -53,7 +53,16 @@ static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting, con
 	}
 
 	verify_ref_format(format);
-	filter->with_commit_tag_algo = 1;
+	if (filter->with_commit && filter->no_commit)
+		/* Due to the way the contains_tag_algo() function
+		   touches object.flags we can only call it once
+		   per-process.
+
+		   For now sacrifice performance for correctness when
+		   both --contains and --no-contains are provided */
+		filter->with_commit_tag_algo = 0;
+	else
+		filter->with_commit_tag_algo = 1;
 	filter_refs(&array, filter, FILTER_REFS_TAGS);
 	ref_array_sort(sorting, &array);
 
@@ -424,7 +433,9 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		OPT_GROUP(N_("Tag listing options")),
 		OPT_COLUMN(0, "column", &colopts, N_("show tag list in columns")),
 		OPT_CONTAINS(&filter.with_commit, N_("print only tags that contain the commit")),
+		OPT_NO_CONTAINS(&filter.no_commit, N_("print only tags that don't contain the commit")),
 		OPT_WITH(&filter.with_commit, N_("print only tags that contain the commit")),
+		OPT_WITHOUT(&filter.no_commit, N_("print only tags that don't contain the commit")),
 		OPT_MERGED(&filter, N_("print only tags that are merged")),
 		OPT_NO_MERGED(&filter, N_("print only tags that are not merged")),
 		OPT_CALLBACK(0 , "sort", sorting_tail, N_("key"),
@@ -488,6 +499,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		die(_("-n option is only allowed with -l."));
 	if (filter.with_commit)
 		die(_("--contains option is only allowed with -l."));
+	if (filter.no_commit)
+		die(_("--no-contains option is only allowed with -l."));
 	if (filter.points_at.nr)
 		die(_("--points-at option is only allowed with -l."));
 	if (filter.merge_commit)
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
index 1ec0fb8391..b6dab75729 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1571,11 +1571,11 @@ static enum contains_result contains_tag_algo(struct commit *candidate,
 	return contains_test(candidate, want);
 }
 
-static int commit_contains(struct ref_filter *filter, struct commit *commit)
+static int commit_contains(struct ref_filter *filter, struct commit_list *list, struct commit *commit)
 {
 	if (filter->with_commit_tag_algo)
-		return contains_tag_algo(commit, filter->with_commit);
-	return is_descendant_of(commit, filter->with_commit);
+		return contains_tag_algo(commit, list);
+	return is_descendant_of(commit, list);
 }
 
 /*
@@ -1765,13 +1765,17 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
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
+		    !commit_contains(filter, filter->with_commit, commit))
+			return 0;
+		/* ...or for the `--no-contains' option */
+		if (filter->no_commit &&
+		    commit_contains(filter, filter->no_commit, commit))
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
index 7f3ec47241..506415dbd3 100755
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
 
@@ -159,4 +195,15 @@ test_expect_success 'branch --merged with --verbose' '
 	test_i18ncmp expect actual
 '
 
+test_expect_success 'branch --contains combined with --no-contains' '
+	git branch --contains zzz --no-contains topic >actual &&
+	cat >expect <<-\EOF &&
+	  master
+	  side
+	  zzz
+	EOF
+	test_cmp expect actual
+
+'
+
 test_done
diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index a09a1a46ef..4902ba5f16 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -93,6 +93,22 @@ test_expect_success 'filtering with --contains' '
 	test_cmp expect actual
 '
 
+test_expect_success 'filtering with --no-contains' '
+	cat >expect <<-\EOF &&
+	refs/tags/one
+	EOF
+	git for-each-ref --format="%(refname)" --no-contains=two >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'filtering with --contains and --no-contains' '
+	cat >expect <<-\EOF &&
+	refs/tags/two
+	EOF
+	git for-each-ref --format="%(refname)" --contains=two --no-contains=three >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success '%(color) must fail' '
 	test_must_fail git for-each-ref --format="%(color)%(refname)"
 '
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index b4698ab5f5..bec3d0fb42 100755
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
@@ -1709,7 +1783,7 @@ run_with_limited_stack () {
 test_lazy_prereq ULIMIT_STACK_SIZE 'run_with_limited_stack true'
 
 # we require ulimit, this excludes Windows
-test_expect_success ULIMIT_STACK_SIZE '--contains works in a deep repo' '
+test_expect_success ULIMIT_STACK_SIZE '--contains and --no-contains work in a deep repo' '
 	>expect &&
 	i=1 &&
 	while test $i -lt 8000
@@ -1725,7 +1799,9 @@ EOF"
 	git checkout master &&
 	git tag far-far-away HEAD^ &&
 	run_with_limited_stack git tag --contains HEAD >actual &&
-	test_cmp expect actual
+	test_cmp expect actual &&
+	run_with_limited_stack git tag --no-contains HEAD >actual &&
+	test_line_count ">" 10 actual
 '
 
 test_expect_success '--format should list tags as per format given' '
@@ -1773,4 +1849,47 @@ test_expect_success 'ambiguous branch/tags not marked' '
 	test_cmp expect actual
 '
 
+test_expect_success '--contains combined with --no-contains' '
+	(
+		git init no-contains &&
+		cd no-contains &&
+		test_commit v0.1 &&
+		test_commit v0.2 &&
+		test_commit v0.3 &&
+		test_commit v0.4 &&
+		test_commit v0.5 &&
+		cat >expected <<-\EOF &&
+		v0.2
+		v0.3
+		v0.4
+		EOF
+		git tag --contains v0.2 --no-contains v0.5 >actual &&
+		test_cmp expected actual
+	)
+'
+
+# As the docs say, list tags which contain a specified *commit*. We
+# don't recurse down to tags for trees or blobs pointed to by *those*
+# commits.
+test_expect_success 'Does --[no-]contains stop at commits? Yes!' '
+	cd no-contains &&
+	blob=$(git rev-parse v0.3:v0.3.t) &&
+	tree=$(git rev-parse v0.3^{tree}) &&
+	git tag tag-blob $blob &&
+	git tag tag-tree $tree &&
+	git tag --contains v0.3 >actual &&
+	cat >expected <<-\EOF &&
+	v0.3
+	v0.4
+	v0.5
+	EOF
+	test_cmp expected actual &&
+	git tag --no-contains v0.3 >actual &&
+	cat >expected <<-\EOF &&
+	v0.1
+	v0.2
+	EOF
+	test_cmp expected actual
+'
+
 test_done
-- 
2.11.0

