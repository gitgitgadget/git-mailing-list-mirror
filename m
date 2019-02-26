Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8F7020248
	for <e@80x24.org>; Tue, 26 Feb 2019 17:07:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbfBZRHJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Feb 2019 12:07:09 -0500
Received: from mail-yw1-f73.google.com ([209.85.161.73]:48226 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727416AbfBZRHI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Feb 2019 12:07:08 -0500
Received: by mail-yw1-f73.google.com with SMTP id i21so9264739ywe.15
        for <git@vger.kernel.org>; Tue, 26 Feb 2019 09:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=FleXVvQSR9qmJnHcivJQwdjBSpTe9VTufeM64IOekc8=;
        b=IlC75Xd677ip3gmxRpAG7DYri/7Ll7vGmfjeo+j5+pMI6/ZesHwfgdCPe1YLppzOZD
         n9rq45LOkY33pMIfqAaq/CQr1aP0NST403nGLpjDoqbBNYHGF9yr5Z3ch5uO+3WIF3aB
         x/mz5tPbjB8rl1wDVofo93dZri+EaP9bpwxjFlME8Bx/+pSo6SkxZ5pFMWpW0n/jiymj
         YgciUSivjpCDvDBvtjm9UdH356LPOImtfWQ75U95fYBYXz5Ixhf8vcwZMOXxOqrg3NtS
         TQSj+xE2G61W4n55moTznnZXLFNsZg349wSo+Y53CLtXHfNsyF6Hf5eqa24I/gdKe95x
         S6sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FleXVvQSR9qmJnHcivJQwdjBSpTe9VTufeM64IOekc8=;
        b=djyAojnS/eTOLQ5hz1OPEUh74uAnOgK1LdbwO95cNxuvZQ8bi8Ofk6c4tZhTjIzBsd
         VYMBIUyFsuYF3llLNcK8hUlXVTkkdDTzqKbw8b5243IVs130crMONQ9ad5hBBwYxPIAK
         LGuGiyQ7dMPKnyu3jbczaAzqQS9JZLDMGRqHlpeHco1u/MVeGAXz0sLV3dwhVNVWT38f
         B3K3t89anVOzFc46MVpbkZaTH1m5mi791LAQxMUnBvQBh6IAywc1W5/O4543hMUDilN3
         CZvw5F7DYlFnV99ttJz8Ls8WhzSPMf1f+AjSJJlMGaPqYuEB9FF4mF03vtAAtPwPgnys
         WV3w==
X-Gm-Message-State: AHQUAuYl+Xq5iFyM1BP453c33RAQQIxze/D/ThtKZvaYzon/CFYPuSRk
        ar5MIiP6o3XOAkQb/Eh20Aa2KTQhOb4BiclesCemLRuG+xm5eEaQMHFkikk8I0fppoh833h919V
        bwRSAvR1uKH3Gv2sGXjy4Cm1Ps2CRGibmdt//NG9lfGhv8R8eXGcW
X-Google-Smtp-Source: AHgI3IZFIXnOW2wH/OFrWqRrbHlEdjG9ZsuRV7bQvpGG661r4EF/1k04Rs1pqecbrdqIkJigeT6XUtDG
X-Received: by 2002:a25:8582:: with SMTP id x2mr8154073ybk.29.1551200826783;
 Tue, 26 Feb 2019 09:07:06 -0800 (PST)
Date:   Tue, 26 Feb 2019 12:06:47 -0500
In-Reply-To: <20190226170648.211847-1-brho@google.com>
Message-Id: <20190226170648.211847-4-brho@google.com>
Mime-Version: 1.0
References: <20190226170648.211847-1-brho@google.com>
X-Mailer: git-send-email 2.21.0.rc2.261.ga7da99ff1b-goog
Subject: [PATCH v4 3/4] blame: add the ability to ignore commits and their changes
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
process for the blame.  We would still process Y, but just don't let the
blame 'stick.'

This patch adds the ability for users to ignore a revision with
--ignore-rev=rev, which may be repeated.  They can specify a set of
files of full object names of revs, e.g. SHA-1 hashes, one per line.  A
single file may be specified with the blame.ignoreRevFile config option
or with --ignore-rev-file=file.  Both the config option and the command
line option may be repeated multiple times.  An empty file name "" will
clear the list of revs from previously processed files.  Config options
are processed before command line options.

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
has a diff chunk that affects those lines.

If an ignored commit added more lines than it removed, we will never be
able to attribute those lines to any commit.  The blame_entry consists
of the number of lines that the ignored commit touched, but the parent
has fewer lines.  Those extra lines extend beyond the parent's version
of the diff hunk, so any blamed commit will be incorrect - it will be
blamed on a commit that changed lines *after* the diff hunk.  We mark
those extra lines as "unblamable" and output a hash of all zeros.

For example, the parent of an ignored commit has this, say at line 11:

commit-a 11) void new_func_1(void *x, void *y);
commit-b 12) void new_func_2(void *x, void *y);
commit-c 13) some_line_c
commit-d 14) some_line_d

After a commit 'X', we have:

commit-X 11) void new_func_1(void *x,
commit-X 12)                 void *y);
commit-X 13) void new_func_2(void *x,
commit-X 14)                 void *y);
commit-c 15) some_line_c
commit-d 16) some_line_d

Commit X nets two additionally lines: 13 and 14.  Those are unblamable.
If you ignore commit X and attempt to find blame, you will get this:

commit-a 11) void new_func_1(void *x,
commit-b 12)                 void *y);
commit-c 13) void new_func_2(void *x,
commit-d 14)                 void *y);
commit-c 15) some_line_c
commit-d 16) some_line_d

Lines 13 and 14 received the blames from lines 15 and 16.  From the
parent's perspective, lines 15 and 16 are the ones that follow lines 11
and 12.  By marking those lines unblamable, we get:

commit-a 11) void new_func_1(void *x,
commit-b 12)                 void *y);
00000000 13) void new_func_2(void *x,
00000000 14)                 void *y);
commit-c 15) some_line_c
commit-d 16) some_line_d

We still can never be certain about which commits *should* be blamed for
which lines.  Note that line 12 was blamed on B, though B was the commit
for new_func_2(), not new_func_1().  But we can avoid blaming commits
that just happen to be in the area and would only be 'correct' due to
dumb luck.  The commits that are blamed merely changed lines in the
parent's version of the file at that offset.

Signed-off-by: Barret Rhoden <brho@google.com>
---
 Documentation/blame-options.txt |  16 +++
 Documentation/config/blame.txt  |   7 ++
 Documentation/git-blame.txt     |   1 +
 blame.c                         |  69 +++++++++++--
 blame.h                         |   3 +
 builtin/blame.c                 |  42 ++++++++
 t/t8013-blame-ignore-revs.sh    | 166 ++++++++++++++++++++++++++++++++
 7 files changed, 295 insertions(+), 9 deletions(-)
 create mode 100755 t/t8013-blame-ignore-revs.sh

diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
index dc41957afab2..a0a340ef1b73 100644
--- a/Documentation/blame-options.txt
+++ b/Documentation/blame-options.txt
@@ -110,5 +110,21 @@ commit. And the default value is 40. If there are more than one
 `-C` options given, the <num> argument of the last `-C` will
 take effect.
 
+--ignore-rev <rev>::
+	Ignore changes made by the revision when assigning blame, as if the
+	change never happened.  Lines that were changed or added by an ignored
+	commit will be blamed on the previous commit that changed that line or
+	nearby lines.  This option may be specified multiple times to ignore
+	more than one revision.  If the `blame.markIgnoredLines` config option
+	is set, then lines that were changed by an ignored commit will be
+	marked with a `*` in the blame output.
+
+--ignore-revs-file <file>::
+	Ignore revisions listed in `file`, one unabbreviated object name per line.
+	Whitespace and comments beginning with `#` are ignored.  This option may be
+	repeated, and these files will be processed after any files specified with
+	the `blame.ignoreRevsFile` config option.  An empty file name, `""`, will
+	clear the list of revs from previously processed files.
+
 -h::
 	Show help message.
diff --git a/Documentation/config/blame.txt b/Documentation/config/blame.txt
index 67b5c1d1e02a..4da2788f306d 100644
--- a/Documentation/config/blame.txt
+++ b/Documentation/config/blame.txt
@@ -19,3 +19,10 @@ blame.showEmail::
 blame.showRoot::
 	Do not treat root commits as boundaries in linkgit:git-blame[1].
 	This option defaults to false.
+
+blame.ignoreRevsFile::
+	Ignore revisions listed in the file, one unabbreviated object name per
+	line, in linkgit:git-blame[1].  Whitespace and comments beginning with
+	`#` are ignored.  This option may be repeated multiple times.  Empty
+	file names will reset the list of ignored revisions.  This option will
+	be handled before the command line option `--ignore-revs-file`.
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
index f30bb2430c5e..4427cde95dc5 100644
--- a/blame.c
+++ b/blame.c
@@ -479,7 +479,8 @@ void blame_coalesce(struct blame_scoreboard *sb)
 
 	for (ent = sb->ent; ent && (next = ent->next); ent = next) {
 		if (ent->suspect == next->suspect &&
-		    ent->s_lno + ent->num_lines == next->s_lno) {
+		    ent->s_lno + ent->num_lines == next->s_lno &&
+		    ent->unblamable == next->unblamable) {
 			ent->num_lines += next->num_lines;
 			ent->next = next->next;
 			blame_origin_decref(next->suspect);
@@ -731,6 +732,10 @@ static void split_overlap(struct blame_entry *split,
 	int chunk_end_lno;
 	memset(split, 0, sizeof(struct blame_entry [3]));
 
+	split[0].unblamable = e->unblamable;
+	split[1].unblamable = e->unblamable;
+	split[2].unblamable = e->unblamable;
+
 	if (e->s_lno < tlno) {
 		/* there is a pre-chunk part not blamed on parent */
 		split[0].suspect = blame_origin_incref(e->suspect);
@@ -849,6 +854,7 @@ static struct blame_entry *split_blame_at(struct blame_entry *e, int len,
 	struct blame_entry *n = xcalloc(1, sizeof(struct blame_entry));
 
 	n->suspect = new_suspect;
+	n->unblamable = e->unblamable;
 	n->lno = e->lno + len;
 	n->s_lno = e->s_lno + len;
 	n->num_lines = e->num_lines - len;
@@ -869,10 +875,10 @@ static struct blame_entry *split_blame_at(struct blame_entry *e, int len,
  */
 static void blame_chunk(struct blame_entry ***dstq, struct blame_entry ***srcq,
 			int tlno, int offset, int same,
-			struct blame_origin *parent)
+			struct blame_origin *parent, int ignore_diffs, int delta)
 {
 	struct blame_entry *e = **srcq;
-	struct blame_entry *samep = NULL, *diffp = NULL;
+	struct blame_entry *samep = NULL, *diffp = NULL, *ignoredp = NULL;
 
 	while (e && e->s_lno < tlno) {
 		struct blame_entry *next = e->next;
@@ -940,10 +946,36 @@ static void blame_chunk(struct blame_entry ***dstq, struct blame_entry ***srcq,
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
+			/* The top part of any ignored diff will not exist in
+			 * the parent, and we will never be able to accurately
+			 * blame it.  We'll keep it on the blame list for the
+			 * target and mark it during the output. */
+			if (delta > 0) {
+				struct blame_entry *n;
+
+				n = split_blame_at(e, e->num_lines - delta,
+					blame_origin_incref(e->suspect));
+				n->unblamable = 1;
+				n->next = diffp;
+				diffp = n;
+			}
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
@@ -953,6 +985,7 @@ static void blame_chunk(struct blame_entry ***dstq, struct blame_entry ***srcq,
 struct blame_chunk_cb_data {
 	struct blame_origin *parent;
 	long offset;
+	int ignore_diffs;
 	struct blame_entry **dstq;
 	struct blame_entry **srcq;
 };
@@ -965,7 +998,7 @@ static int blame_chunk_cb(long start_a, long count_a,
 	if (start_a - start_b != d->offset)
 		die("internal error in blame::blame_chunk_cb");
 	blame_chunk(&d->dstq, &d->srcq, start_b, start_a - start_b,
-		    start_b + count_b, d->parent);
+		    start_b + count_b, d->parent, d->ignore_diffs, count_b - count_a);
 	d->offset = start_a + count_a - (start_b + count_b);
 	return 0;
 }
@@ -977,7 +1010,7 @@ static int blame_chunk_cb(long start_a, long count_a,
  */
 static void pass_blame_to_parent(struct blame_scoreboard *sb,
 				 struct blame_origin *target,
-				 struct blame_origin *parent)
+				 struct blame_origin *parent, int ignore_diffs)
 {
 	mmfile_t file_p, file_o;
 	struct blame_chunk_cb_data d;
@@ -988,6 +1021,7 @@ static void pass_blame_to_parent(struct blame_scoreboard *sb,
 
 	d.parent = parent;
 	d.offset = 0;
+	d.ignore_diffs = ignore_diffs;
 	d.dstq = &newdest; d.srcq = &target->suspects;
 
 	fill_origin_blob(&sb->revs->diffopt, parent, &file_p, &sb->num_read_blob);
@@ -999,7 +1033,7 @@ static void pass_blame_to_parent(struct blame_scoreboard *sb,
 		    oid_to_hex(&parent->commit->object.oid),
 		    oid_to_hex(&target->commit->object.oid));
 	/* The rest are the same as the parent */
-	blame_chunk(&d.dstq, &d.srcq, INT_MAX, d.offset, INT_MAX, parent);
+	blame_chunk(&d.dstq, &d.srcq, INT_MAX, d.offset, INT_MAX, parent, 0, 0);
 	*d.dstq = NULL;
 	queue_blames(sb, parent, newdest);
 
@@ -1504,11 +1538,28 @@ static void pass_blame(struct blame_scoreboard *sb, struct blame_origin *origin,
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
index be3a895043e0..91664913d7c4 100644
--- a/blame.h
+++ b/blame.h
@@ -92,6 +92,7 @@ struct blame_entry {
 	 * scanning the lines over and over.
 	 */
 	unsigned score;
+	int unblamable;
 };
 
 /*
@@ -117,6 +118,8 @@ struct blame_scoreboard {
 	/* linked list of blames */
 	struct blame_entry *ent;
 
+	struct oidset ignore_list;
+
 	/* look-up a line in the final buffer */
 	int num_lines;
 	int *lineno;
diff --git a/builtin/blame.c b/builtin/blame.c
index 581de0d83226..5f38e9dccddd 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -52,6 +52,7 @@ static int no_whole_file_rename;
 static int show_progress;
 static char repeated_meta_color[COLOR_MAXLEN];
 static int coloring_mode;
+static struct string_list ignore_revs_file_list = STRING_LIST_INIT_NODUP;
 
 static struct date_mode blame_date_mode = { DATE_ISO8601 };
 static size_t blame_date_width;
@@ -346,6 +347,8 @@ static void emit_porcelain(struct blame_scoreboard *sb, struct blame_entry *ent,
 	char hex[GIT_MAX_HEXSZ + 1];
 
 	oid_to_hex_r(hex, &suspect->commit->object.oid);
+	if (ent->unblamable)
+		memset(hex, '0', strlen(hex));
 	printf("%s %d %d %d\n",
 	       hex,
 	       ent->s_lno + 1,
@@ -479,6 +482,8 @@ static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent, int
 			}
 		}
 
+		if (ent->unblamable)
+			memset(hex, '0', length);
 		printf("%.*s", length, hex);
 		if (opt & OUTPUT_ANNOTATE_COMPAT) {
 			const char *name;
@@ -695,6 +700,16 @@ static int git_blame_config(const char *var, const char *value, void *cb)
 		parse_date_format(value, &blame_date_mode);
 		return 0;
 	}
+	if (!strcmp(var, "blame.ignorerevsfile")) {
+		const char *str;
+		int ret;
+
+		ret = git_config_pathname(&str, var, value);
+		if (ret)
+			return ret;
+		string_list_insert(&ignore_revs_file_list, str);
+		return 0;
+	}
 	if (!strcmp(var, "color.blame.repeatedlines")) {
 		if (color_parse_mem(value, strlen(value), repeated_meta_color))
 			warning(_("invalid color '%s' in color.blame.repeatedLines"),
@@ -774,6 +789,27 @@ static int is_a_rev(const char *name)
 	return OBJ_NONE < oid_object_info(the_repository, &oid, NULL);
 }
 
+static void build_ignorelist(struct blame_scoreboard *sb,
+			     struct string_list *ignore_revs_file_list,
+			     struct string_list *ignore_rev_list)
+{
+	struct string_list_item *i;
+	struct object_id oid;
+
+	oidset_init(&sb->ignore_list, 0);
+	for_each_string_list_item(i, ignore_revs_file_list) {
+		if (!strcmp(i->string, ""))
+			oidset_clear(&sb->ignore_list);
+		else
+			oidset_parse_file(&sb->ignore_list, i->string);
+	}
+	for_each_string_list_item(i, ignore_rev_list) {
+		if (get_oid_committish(i->string, &oid))
+			die(_("Cannot find revision %s to ignore"), i->string);
+		oidset_insert(&sb->ignore_list, &oid);
+	}
+}
+
 int cmd_blame(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info revs;
@@ -785,6 +821,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	struct progress_info pi = { NULL, 0 };
 
 	struct string_list range_list = STRING_LIST_INIT_NODUP;
+	struct string_list ignore_rev_list = STRING_LIST_INIT_NODUP;
 	int output_option = 0, opt = 0;
 	int show_stats = 0;
 	const char *revs_file = NULL;
@@ -806,6 +843,8 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		OPT_BIT('s', NULL, &output_option, N_("Suppress author name and timestamp (Default: off)"), OUTPUT_NO_AUTHOR),
 		OPT_BIT('e', "show-email", &output_option, N_("Show author email instead of name (Default: off)"), OUTPUT_SHOW_EMAIL),
 		OPT_BIT('w', NULL, &xdl_opts, N_("Ignore whitespace differences"), XDF_IGNORE_WHITESPACE),
+		OPT_STRING_LIST(0, "ignore-rev", &ignore_rev_list, N_("rev"), N_("Ignore <rev> when blaming")),
+		OPT_STRING_LIST(0, "ignore-revs-file", &ignore_revs_file_list, N_("file"), N_("Ignore revisions from <file>")),
 		OPT_BIT(0, "color-lines", &output_option, N_("color redundant metadata from previous line differently"), OUTPUT_COLOR_LINE),
 		OPT_BIT(0, "color-by-age", &output_option, N_("color lines by age"), OUTPUT_SHOW_AGE_WITH_COLOR),
 
@@ -999,6 +1038,9 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	sb.contents_from = contents_from;
 	sb.reverse = reverse;
 	sb.repo = the_repository;
+	build_ignorelist(&sb, &ignore_revs_file_list, &ignore_rev_list);
+	string_list_clear(&ignore_revs_file_list, 0);
+	string_list_clear(&ignore_rev_list, 0);
 	setup_scoreboard(&sb, path, &o);
 	lno = sb.num_lines;
 
diff --git a/t/t8013-blame-ignore-revs.sh b/t/t8013-blame-ignore-revs.sh
new file mode 100755
index 000000000000..c5ef1e4b1b00
--- /dev/null
+++ b/t/t8013-blame-ignore-revs.sh
@@ -0,0 +1,166 @@
+#!/bin/sh
+
+test_description='ignore revisions when blaming'
+. ./test-lib.sh
+
+# Creates:
+# 	A--B--X
+# A added line 1 and B added line 2.  X makes changes to those lines.  Sanity
+# check that X is blamed for both lines.
+test_expect_success setup '
+	test_commit A file line1 &&
+
+	echo line2 >>file &&
+	git add file &&
+	test_tick &&
+	git commit -m B &&
+	git tag B &&
+
+	test_write_lines line-one line-two >file &&
+	git add file &&
+	test_tick &&
+	git commit -m X &&
+	git tag X &&
+
+	git blame --line-porcelain file >blame_raw &&
+
+	grep "^[0-9a-f]\+ 1 1" blame_raw | sed -e "s/ .*//" >actual &&
+	git rev-parse X >expect &&
+	test_cmp expect actual &&
+
+	grep "^[0-9a-f]\+ 2 2" blame_raw | sed -e "s/ .*//" >actual &&
+	git rev-parse X >expect &&
+	test_cmp expect actual
+	'
+
+# Ignore X, make sure A is blamed for line 1 and B for line 2.
+test_expect_success ignore_rev_changing_lines '
+	git blame --line-porcelain --ignore-rev X file >blame_raw &&
+
+	grep "^[0-9a-f]\+ 1 1" blame_raw | sed -e "s/ .*//" >actual &&
+	git rev-parse A >expect &&
+	test_cmp expect actual &&
+
+	grep "^[0-9a-f]\+ 2 2" blame_raw | sed -e "s/ .*//" >actual &&
+	git rev-parse B >expect &&
+	test_cmp expect actual
+	'
+
+# For ignored revs that have added more lines than they removed, the extra lines
+# must be blamed on an all-zeros rev.
+# 	A--B--X--Y
+# Where Y changes lines 1 and 2, and adds lines 3 and 4.
+test_expect_success ignore_rev_adding_lines '
+	test_write_lines line-one-change line-two-changed new_line3 new_line4 >file &&
+	git add file &&
+	test_tick &&
+	git commit -m Y &&
+	git tag Y &&
+
+	git rev-parse Y >y_rev &&
+	sed -e "s/[0-9a-f]/0/g" y_rev >expect &&
+	git blame --line-porcelain file --ignore-rev Y >blame_raw &&
+
+	grep "^[0-9a-f]\+ 3 3" blame_raw | sed -e "s/ .*//" >actual &&
+	test_cmp expect actual &&
+
+	grep "^[0-9a-f]\+ 4 4" blame_raw | sed -e "s/ .*//" >actual &&
+	test_cmp expect actual
+	'
+
+# Ignore X and Y, both in separate files.  Lines 1 == A, 2 == B.
+test_expect_success ignore_revs_from_files '
+	git rev-parse X >ignore_x &&
+	git rev-parse Y >ignore_y &&
+	git blame --line-porcelain file --ignore-revs-file ignore_x --ignore-revs-file ignore_y >blame_raw &&
+
+	grep "^[0-9a-f]\+ 1 1" blame_raw | sed -e "s/ .*//" >actual &&
+	git rev-parse A >expect &&
+	test_cmp expect actual &&
+
+	grep "^[0-9a-f]\+ 2 2" blame_raw | sed -e "s/ .*//" >actual &&
+	git rev-parse B >expect &&
+	test_cmp expect actual
+	'
+
+# Ignore X from the config option, Y from a file.
+test_expect_success ignore_revs_from_configs_and_files '
+	git config --add blame.ignoreRevsFile ignore_x &&
+	git blame --line-porcelain file --ignore-revs-file ignore_y >blame_raw &&
+
+	grep "^[0-9a-f]\+ 1 1" blame_raw | sed -e "s/ .*//" >actual &&
+	git rev-parse A >expect &&
+	test_cmp expect actual &&
+
+	grep "^[0-9a-f]\+ 2 2" blame_raw | sed -e "s/ .*//" >actual &&
+	git rev-parse B >expect &&
+	test_cmp expect actual
+	'
+
+# Override blame.ignoreRevsFile (ignore_x) with an empty string.  X should be
+# blamed now for lines 1 and 2, since we are no longer ignoring X.
+test_expect_success override_ignore_revs_file '
+	git blame --line-porcelain file --ignore-revs-file "" --ignore-revs-file ignore_y >blame_raw &&
+	git rev-parse X >expect &&
+
+	grep "^[0-9a-f]\+ 1 1" blame_raw | sed -e "s/ .*//" >actual &&
+	test_cmp expect actual &&
+
+	grep "^[0-9a-f]\+ 2 2" blame_raw | sed -e "s/ .*//" >actual &&
+	test_cmp expect actual
+	'
+test_expect_success bad_files_and_revs '
+	test_must_fail git blame file --ignore-rev NOREV 2>err &&
+	test_i18ngrep "Cannot find revision NOREV to ignore" err &&
+
+	test_must_fail git blame file --ignore-revs-file NOFILE 2>err &&
+	test_i18ngrep "Could not open object name list: NOFILE" err &&
+
+	echo NOREV >ignore_norev &&
+	test_must_fail git blame file --ignore-revs-file ignore_norev 2>err &&
+	test_i18ngrep "Invalid object name: NOREV" err
+	'
+
+# Resetting the repo and creating:
+#
+# A--B--M
+#  \   /
+#   C-+
+#
+# 'A' creates a file.  B changes line 1, and C changes line 9.  M merges.
+test_expect_success ignore_merge '
+	rm -rf .git/ &&
+	git init &&
+
+	test_write_lines L1 L2 L3 L4 L5 L6 L7 L8 L9 >file &&
+	git add file &&
+	test_tick &&
+	git commit -m A &&
+	git tag A &&
+
+	test_write_lines BB L2 L3 L4 L5 L6 L7 L8 L9 >file &&
+	git add file &&
+	test_tick &&
+	git commit -m B &&
+	git tag B &&
+
+	git reset --hard A &&
+	test_write_lines L1 L2 L3 L4 L5 L6 L7 L8 CC >file &&
+	git add file &&
+	test_tick &&
+	git commit -m C &&
+	git tag C &&
+
+	test_merge M B &&
+	git blame --line-porcelain file --ignore-rev M >blame_raw &&
+
+	grep "^[0-9a-f]\+ 1 1" blame_raw | sed -e "s/ .*//" >actual &&
+	git rev-parse B >expect &&
+	test_cmp expect actual &&
+
+	grep "^[0-9a-f]\+ 9 9" blame_raw | sed -e "s/ .*//" >actual &&
+	git rev-parse C >expect &&
+	test_cmp expect actual
+	'
+
+test_done
-- 
2.21.0.rc2.261.ga7da99ff1b-goog

