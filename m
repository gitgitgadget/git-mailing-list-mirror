Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 711531F453
	for <e@80x24.org>; Thu, 17 Jan 2019 20:29:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729506AbfAQU3h (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 15:29:37 -0500
Received: from mail-qt1-f202.google.com ([209.85.160.202]:34491 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729220AbfAQU3h (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 15:29:37 -0500
Received: by mail-qt1-f202.google.com with SMTP id u32so10345270qte.1
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 12:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=SaOc1FljB2sALXT6lfkDnoUI2SbpThJ4+3UQfvrSLH8=;
        b=bpgshcGBpEZDP1WQO2AakzRpFDBtzq6A9xxznhiGR6DZkYx8c8q8SuZ1wXaLqEudPS
         cB2Et9dJnkPrZOExSZXjsMgxoNcPuxBe0rBAX31XWMtZnhoHG/CHP7Ofc27LJ0XA12xp
         9G+BKiEuP2zxkwCM6/qihkFNxtTlAKTeOBurAz4FAV8xU7TplwSe5ik/SwL0RKcCV1pI
         tWfDc0fGMDgZhgbLTxwZuvst19/muJDU4QGEuddq2+C8SCpP+godSeuj3yW7Pwxscf1S
         LI+vlOcn5u8m56NQcxfGzJQvv1W9YuP4bWnLch7FmZ8yps6bE2q+fRB4fNqdldPPR2hD
         yZJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SaOc1FljB2sALXT6lfkDnoUI2SbpThJ4+3UQfvrSLH8=;
        b=Kbu0cioQMoMmonBuaTz6K2Qyp/2AAq8X17gc0kDCXxKP36Qp0eysXRE6rVt6MWh1jI
         /LCZbMp79eq3sEABD37Xi6/5apI3/IzZ6pWu8u0IspNhNnvSrjMXyv9MYqcxxfSOz1SM
         qNhoGUY3L0fz9X3H4D85286jTDDVD8NZk2mDdy3mB0DLDdQ9a1VGK7+Mduu/TAMT79eR
         /D0rYZarEgkAErVJcJdGQVpcECzxXYb1y6CtRTUMsF0NE6UinuzV/WqVsXfML8dkx8hJ
         tuWe1QyMWikHAxQ5c63LGeBdfiVceyUNDitdT3DkHToUS+bBfh9y2D3MxN5WWtOk9n9S
         2xYQ==
X-Gm-Message-State: AJcUuke7tLh3YtvGaMQM8oBEfxkDoy7ZASbWWxk8RG0jU9Tl6hXYclwx
        tPCQHU3OwadAi/+rpLF5tJqmerbUxmt0mOpnwsMw4cQhckH+AA2I4YWKkBiuDpy4DrmrQgVxlTy
        qr/G94ZCvfUjAKF2sV2mUFxrXTu8SbjYrpwCiuUoiJpV06/3iaNPK
X-Google-Smtp-Source: ALg8bN7f7y+8ORmGJpPJgXa3PpyR4slpo+meyeT7R8QUo3NKuStbsh3bZtutQ0fYYHl6rcogWVCjYcdh
X-Received: by 2002:a37:717:: with SMTP id 23mr8922292qkh.1.1547756975342;
 Thu, 17 Jan 2019 12:29:35 -0800 (PST)
Date:   Thu, 17 Jan 2019 15:29:18 -0500
In-Reply-To: <20190117202919.157326-1-brho@google.com>
Message-Id: <20190117202919.157326-3-brho@google.com>
Mime-Version: 1.0
References: <20190107213013.231514-1-brho@google.com> <20190117202919.157326-1-brho@google.com>
X-Mailer: git-send-email 2.20.1.321.g9e740568ce-goog
Subject: [PATCH v2 2/3] blame: add the ability to ignore commits and their changes
From:   Barret Rhoden <brho@google.com>
To:     git@vger.kernel.org
Cc:     "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, David Kastrup <dak@gnu.org>,
        Jeff King <peff@peff.net>, Jeff Smith <whydoubt@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        "=?UTF-8?q?Ren=C3=A9=20Scharfe?=" <l.s.r@web.de>,
        Stefan Beller <stefanbeller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commits that make formatting changes or function renames are often not
interesting when blaming a file.  A user may deem such a commit as 'not
interesting' and want to ignore and its changes it when assigning blame.

For example, say a file has the following git history / rev-list:

---O---A---X---B---C---D---Y---E---F

Commits X and Y both touch a particular line, and the other commits do
not:

X: "Take a third parameter"
-MyFunc(1, 2);
+MyFunc(1, 2, 3);

Y: "Remove camelcase"
-MyFunc(1, 2, 3);
+my_func(1, 2, 3);

git-blame will blame Y for the change.  I'd like to be able to ignore Y:
both the existence of the commit as well as any changes it made.  This
differs from -S rev-list, which specifies the list of commits to
process for the blame.  We still process Y, we just don't let the blame
'stick.'

Users can ignore a revision with --ignore-rev=rev, which may be
repeated.  They can specify a file of full SHA-1 hashes of revs (one per
line) with the blame.ignoreRevFile config option.  They can also specify
a file with --ignore-rev-file=file, which overrides the config option.

For a typical use case, projects will maintain the file containing
revisions for commits that perform mass reformatting, and their users
have the optional to ignore all of the commits in that file.

Additionally, a user can use the --ignore-rev option for one-off
investigation.  To go back to the example above, X was a substantive
change to the function, but not the change the user is interested in.
The user inspected X, but wanted to find the previous change to that
line - perhaps a commit that introduced that function call.

To make this work, we can't simply remove all ignored commits from the
rev-list.  We need to diff the changes introduced by Y so that we can
ignore them.  We let the blames get passed to Y, just like when
processing normally.  When Y is the target, we make sure that Y does not
*keep* any blames.  Any changes that Y is responsible for get passed to
its parent.  Note we make one pass through all of the scapegoats
(parents) to attempt to pass blame normally; we don't know if we *need*
to ignore the commit until we've checked all of the parents.

The blame_entry will get passed up the tree until we find a commit that
has a diff chunk that affects those lines.  If an ignored commit added
more lines than it removed, the blame will fall on a commit that made a
change nearby.  There is no general solution here, just a best-effort
approach.  For a trivial example, consider ignoring this commit:

Z: "Adding Lines"
 foo
+No commit
+ever touched
+these lines
 bar

Signed-off-by: Barret Rhoden <brho@google.com>
---
 Documentation/blame-options.txt | 13 +++++++++
 Documentation/git-blame.txt     |  1 +
 blame.c                         | 48 +++++++++++++++++++++++++++------
 blame.h                         |  2 ++
 builtin/blame.c                 | 24 +++++++++++++++++
 5 files changed, 80 insertions(+), 8 deletions(-)

diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
index dc41957afab2..424a63f0b45c 100644
--- a/Documentation/blame-options.txt
+++ b/Documentation/blame-options.txt
@@ -110,5 +110,18 @@ commit. And the default value is 40. If there are more than one
 `-C` options given, the <num> argument of the last `-C` will
 take effect.
 
+--ignore-rev <rev>::
+	Ignore changes made by the revision when assigning blame, as if the
+	change never happened.  Lines that were changed or added by an ignored
+	commit will be blamed on the previous commit that changed that line or
+	nearby lines.  This option may be specified multiple times to ignore
+	more than one revision.
+
+--ignore-revs-file <file>::
+	Ignore revisions listed in `file`, one full SHA-1 hash per line.
+	Whitespace and comments beginning with `#` are ignored.  This overrides
+	the `blame.ignoreRevsFile` config option, which specifies a default
+	file.
+
 -h::
 	Show help message.
diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
index 16323eb80e31..7e8154199635 100644
--- a/Documentation/git-blame.txt
+++ b/Documentation/git-blame.txt
@@ -10,6 +10,7 @@ SYNOPSIS
 [verse]
 'git blame' [-c] [-b] [-l] [--root] [-t] [-f] [-n] [-s] [-e] [-p] [-w] [--incremental]
 	    [-L <range>] [-S <revs-file>] [-M] [-C] [-C] [-C] [--since=<date>]
+	    [--ignore-rev <rev>] [--ignore-revs-file <file>]
 	    [--progress] [--abbrev=<n>] [<rev> | --contents <file> | --reverse <rev>..<rev>]
 	    [--] <file>
 
diff --git a/blame.c b/blame.c
index d84c93778080..0b91fba2d04c 100644
--- a/blame.c
+++ b/blame.c
@@ -845,10 +845,10 @@ static struct blame_entry *reverse_blame(struct blame_entry *head,
  */
 static void blame_chunk(struct blame_entry ***dstq, struct blame_entry ***srcq,
 			int tlno, int offset, int same,
-			struct blame_origin *parent)
+			struct blame_origin *parent, int ignore_diffs)
 {
 	struct blame_entry *e = **srcq;
-	struct blame_entry *samep = NULL, *diffp = NULL;
+	struct blame_entry *samep = NULL, *diffp = NULL, *ignoredp = NULL;
 
 	while (e && e->s_lno < tlno) {
 		struct blame_entry *next = e->next;
@@ -925,10 +925,23 @@ static void blame_chunk(struct blame_entry ***dstq, struct blame_entry ***srcq,
 			n->next = samep;
 			samep = n;
 		}
-		e->next = diffp;
-		diffp = e;
+		if (ignore_diffs) {
+			/* These go to the parent, like the ones before tlno. */
+			blame_origin_decref(e->suspect);
+			e->suspect = blame_origin_incref(parent);
+			e->s_lno += offset;
+			e->next = ignoredp;
+			ignoredp = e;
+		} else {
+			e->next = diffp;
+			diffp = e;
+		}
 		e = next;
 	}
+	if (ignoredp) {
+		**dstq = reverse_blame(ignoredp, **dstq);
+		*dstq = &ignoredp->next;
+	}
 	**srcq = reverse_blame(diffp, reverse_blame(samep, e));
 	/* Move across elements that are in the unblamable portion */
 	if (diffp)
@@ -938,6 +951,7 @@ static void blame_chunk(struct blame_entry ***dstq, struct blame_entry ***srcq,
 struct blame_chunk_cb_data {
 	struct blame_origin *parent;
 	long offset;
+	int ignore_diffs;
 	struct blame_entry **dstq;
 	struct blame_entry **srcq;
 };
@@ -950,7 +964,7 @@ static int blame_chunk_cb(long start_a, long count_a,
 	if (start_a - start_b != d->offset)
 		die("internal error in blame::blame_chunk_cb");
 	blame_chunk(&d->dstq, &d->srcq, start_b, start_a - start_b,
-		    start_b + count_b, d->parent);
+		    start_b + count_b, d->parent, d->ignore_diffs);
 	d->offset = start_a + count_a - (start_b + count_b);
 	return 0;
 }
@@ -962,7 +976,7 @@ static int blame_chunk_cb(long start_a, long count_a,
  */
 static void pass_blame_to_parent(struct blame_scoreboard *sb,
 				 struct blame_origin *target,
-				 struct blame_origin *parent)
+				 struct blame_origin *parent, int ignore_diffs)
 {
 	mmfile_t file_p, file_o;
 	struct blame_chunk_cb_data d;
@@ -973,6 +987,7 @@ static void pass_blame_to_parent(struct blame_scoreboard *sb,
 
 	d.parent = parent;
 	d.offset = 0;
+	d.ignore_diffs = ignore_diffs;
 	d.dstq = &newdest; d.srcq = &target->suspects;
 
 	fill_origin_blob(&sb->revs->diffopt, parent, &file_p, &sb->num_read_blob);
@@ -984,7 +999,7 @@ static void pass_blame_to_parent(struct blame_scoreboard *sb,
 		    oid_to_hex(&parent->commit->object.oid),
 		    oid_to_hex(&target->commit->object.oid));
 	/* The rest are the same as the parent */
-	blame_chunk(&d.dstq, &d.srcq, INT_MAX, d.offset, INT_MAX, parent);
+	blame_chunk(&d.dstq, &d.srcq, INT_MAX, d.offset, INT_MAX, parent, 0);
 	*d.dstq = NULL;
 	queue_blames(sb, parent, newdest);
 
@@ -1489,11 +1504,28 @@ static void pass_blame(struct blame_scoreboard *sb, struct blame_origin *origin,
 			blame_origin_incref(porigin);
 			origin->previous = porigin;
 		}
-		pass_blame_to_parent(sb, origin, porigin);
+		pass_blame_to_parent(sb, origin, porigin, 0);
 		if (!origin->suspects)
 			goto finish;
 	}
 
+	/*
+	 * Pass remaining suspects for ignored commits to their parents.
+	 */
+	if (oidset_contains(&sb->ignore_list, &commit->object.oid)) {
+		for (i = 0, sg = first_scapegoat(revs, commit, sb->reverse);
+		     i < num_sg && sg;
+		     sg = sg->next, i++) {
+			struct blame_origin *porigin = sg_origin[i];
+
+			if (!porigin)
+				continue;
+			pass_blame_to_parent(sb, origin, porigin, 1);
+			if (!origin->suspects)
+				goto finish;
+		}
+	}
+
 	/*
 	 * Optionally find moves in parents' files.
 	 */
diff --git a/blame.h b/blame.h
index be3a895043e0..086b92915e4b 100644
--- a/blame.h
+++ b/blame.h
@@ -117,6 +117,8 @@ struct blame_scoreboard {
 	/* linked list of blames */
 	struct blame_entry *ent;
 
+	struct oidset ignore_list;
+
 	/* look-up a line in the final buffer */
 	int num_lines;
 	int *lineno;
diff --git a/builtin/blame.c b/builtin/blame.c
index 6d798f99392e..2f9183fb5fbd 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -52,6 +52,7 @@ static int no_whole_file_rename;
 static int show_progress;
 static char repeated_meta_color[COLOR_MAXLEN];
 static int coloring_mode;
+static const char *ignore_revs_file;
 
 static struct date_mode blame_date_mode = { DATE_ISO8601 };
 static size_t blame_date_width;
@@ -695,6 +696,8 @@ static int git_blame_config(const char *var, const char *value, void *cb)
 		parse_date_format(value, &blame_date_mode);
 		return 0;
 	}
+	if (!strcmp(var, "blame.ignorerevsfile"))
+		return git_config_pathname(&ignore_revs_file, var, value);
 	if (!strcmp(var, "color.blame.repeatedlines")) {
 		if (color_parse_mem(value, strlen(value), repeated_meta_color))
 			warning(_("invalid color '%s' in color.blame.repeatedLines"),
@@ -774,6 +777,22 @@ static int is_a_rev(const char *name)
 	return OBJ_NONE < oid_object_info(the_repository, &oid, NULL);
 }
 
+static void build_ignorelist(struct blame_scoreboard *sb,
+			     struct string_list *ignore_rev_list)
+{
+	struct string_list_item *i;
+	struct object_id oid;
+
+	oidset_init(&sb->ignore_list, 0);
+	if (ignore_revs_file)
+		oidset_parse_file(&sb->ignore_list, ignore_revs_file);
+	for_each_string_list_item(i, ignore_rev_list) {
+		if (get_oid_committish(i->string, &oid))
+			die(_("Can't find revision '%s' to ignore"), i->string);
+		oidset_insert(&sb->ignore_list, &oid);
+	}
+}
+
 int cmd_blame(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info revs;
@@ -785,6 +804,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	struct progress_info pi = { NULL, 0 };
 
 	struct string_list range_list = STRING_LIST_INIT_NODUP;
+	struct string_list ignore_rev_list = STRING_LIST_INIT_NODUP;
 	int output_option = 0, opt = 0;
 	int show_stats = 0;
 	const char *revs_file = NULL;
@@ -806,6 +826,8 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		OPT_BIT('s', NULL, &output_option, N_("Suppress author name and timestamp (Default: off)"), OUTPUT_NO_AUTHOR),
 		OPT_BIT('e', "show-email", &output_option, N_("Show author email instead of name (Default: off)"), OUTPUT_SHOW_EMAIL),
 		OPT_BIT('w', NULL, &xdl_opts, N_("Ignore whitespace differences"), XDF_IGNORE_WHITESPACE),
+		OPT_STRING_LIST(0, "ignore-rev", &ignore_rev_list, N_("rev"), N_("Ignore <rev> when blaming")),
+		OPT_STRING(0, "ignore-revs-file", &ignore_revs_file, N_("file"), N_("Ignore revisions from <file>")),
 		OPT_BIT(0, "color-lines", &output_option, N_("color redundant metadata from previous line differently"), OUTPUT_COLOR_LINE),
 		OPT_BIT(0, "color-by-age", &output_option, N_("color lines by age"), OUTPUT_SHOW_AGE_WITH_COLOR),
 
@@ -995,6 +1017,8 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	sb.contents_from = contents_from;
 	sb.reverse = reverse;
 	sb.repo = the_repository;
+	build_ignorelist(&sb, &ignore_rev_list);
+	string_list_clear(&ignore_rev_list, 0);
 	setup_scoreboard(&sb, path, &o);
 	lno = sb.num_lines;
 
-- 
2.20.1.321.g9e740568ce-goog

