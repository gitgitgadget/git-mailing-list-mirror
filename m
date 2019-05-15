Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 694671F461
	for <e@80x24.org>; Wed, 15 May 2019 21:45:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbfEOVpZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 May 2019 17:45:25 -0400
Received: from mail-oi1-f201.google.com ([209.85.167.201]:55588 "EHLO
        mail-oi1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbfEOVpZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 May 2019 17:45:25 -0400
Received: by mail-oi1-f201.google.com with SMTP id c64so565922oia.22
        for <git@vger.kernel.org>; Wed, 15 May 2019 14:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=COTN2MgrYrow2Qk6A5GXkdn0DLdDUqX9aD9FsoLWfmY=;
        b=dFgH73ZRdTH5yCVEcxZ792/b8gK1fcvkAQqBNthoALNtykiGD0isl6M2DJfT1WZ2OG
         eFR1HNtq1rxFL+2T7YtXBumtaP32icKpUVLEbB/l7zq5ys7/Kf83FksINzIxhvbd6adM
         vgg6xqQtxkgdMRvqgJM23crpD/NKIEYPsBqFAouEl9Gev/OH1SaAGCBCx+gzub+O2ry9
         nFuN3rsCqUHhp1AdgJG9PFjhV89Ud0zYoD3wQ9Ani89qT6j7k1TPQHRWnWnKpoE3V3mM
         kZ2XO6hzvEyRr3Sb94OEmwyl9y/gshYHreRYnytRhD+3X1NRueZIqp0WTySyTDaIA7lm
         GDog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=COTN2MgrYrow2Qk6A5GXkdn0DLdDUqX9aD9FsoLWfmY=;
        b=bBqKDXzD9NdUAiGEslWXq6i26xmSLo4yLFWCz0LUL5GuTa3+AmUvQFjzZtAK9PgvLE
         XUEZ2dpORirn+r5OgK/G/bZKUrg2/ZSzUyuUqUx2XtaUrOWFtY6FescfcbZ2Q0w5E3Ju
         ji6ZSZ/+xxmCQWLrwH/xZwP6PKgpELto6O/9RyPsWWcXTeg9EUIHM5xyaja6An6Dsk6o
         s0A3YKEjzwBYH49JPIb5JeKdY+zZFEkcGWSN7gISc3bug/L6/4H/r+sATTATfOwD6vn3
         9T+f/uuiJLY1VhADr9Aj5T4nmaJsIKwDSHG1mW7gfHS94gPLg9lpKbXNF4wO+wKq3ndq
         6ooQ==
X-Gm-Message-State: APjAAAXz9N5mDRBYty6kPUWFh3BnuLFzjaNJUKSy2ynACtCpDqtfvPN9
        swUBI0DDPzQzoD3yxqScUqp0e7bmKIWzWxO+xBIs/gnv3Rr0sNRrR4vpUu57c4D/bZuFkrSHnNn
        ocTlJ2yWbb5/pvwebJNS9ylqr93wM0fhT1QyK0Y0ez1d8cDGOHI59
X-Google-Smtp-Source: APXvYqzUGXi9P9qIu8fEmsKRof73AUZ+qZDcLMr5m2GbstydU0sYKG9vROfjirbbzKqn84huHmfgh1s/
X-Received: by 2002:a9d:7858:: with SMTP id c24mr146206otm.64.1557956723291;
 Wed, 15 May 2019 14:45:23 -0700 (PDT)
Date:   Wed, 15 May 2019 17:44:59 -0400
In-Reply-To: <20190515214503.77162-1-brho@google.com>
Message-Id: <20190515214503.77162-5-brho@google.com>
Mime-Version: 1.0
References: <20190515214503.77162-1-brho@google.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH v7 4/8] blame: add the ability to ignore commits and their changes
From:   Barret Rhoden <brho@google.com>
To:     git@vger.kernel.org
Cc:     "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, David Kastrup <dak@gnu.org>,
        Jeff King <peff@peff.net>, Jeff Smith <whydoubt@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        "=?UTF-8?q?Ren=C3=A9=20Scharfe?=" <l.s.r@web.de>,
        Stefan Beller <stefanbeller@gmail.com>,
        Michael Platings <michael@platin.gs>
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
have the option to ignore all of the commits in that file.

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

One issue is that the ignored commit *did* make some change, and there is
no general solution to finding the line in the parent commit that
corresponds to a given line in the ignored commit.  That makes it hard
to attribute a particular line within an ignored commit's diff
correctly.

For example, the parent of an ignored commit has this, say at line 11:

commit-a 11) #include "a.h"
commit-b 12) #include "b.h"

Commit X, which we will ignore, swaps these lines:

commit-X 11) #include "b.h"
commit-X 12) #include "a.h"

We can pass that blame entry to the parent, but line 11 will be
attributed to commit A, even though "include b.h" came from commit B.
The blame mechanism will be looking at the parent's view of the file at
line number 11.

ignore_blame_entry() is set up to allow alternative algorithms for
guessing per-line blames.  Any line that is not attributed to the parent
will continue to be blamed on the ignored commit as if that commit was
not ignored.  Upcoming patches have the ability to detect these lines
and mark them in the blame output.

The existing algorithm is simple: blame each line on the corresponding
line in the parent's diff chunk.  Any lines beyond that stay with the
target.

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

Commit X nets two additionally lines: 13 and 14.  The current
guess_line_blames() algorithm will not attribute these to the parent,
whose diff chunk is only two lines - not four.

When we ignore with the current algorithm, we get:

commit-a 11) void new_func_1(void *x,
commit-b 12)                 void *y);
commit-X 13) void new_func_2(void *x,
commit-X 14)                 void *y);
commit-c 15) some_line_c
commit-d 16) some_line_d

Note that line 12 was blamed on B, though B was the commit for
new_func_2(), not new_func_1().  Even when guess_line_blames() finds a
line in the parent, it may still be incorrect.

Signed-off-by: Barret Rhoden <brho@google.com>
---
 Documentation/blame-options.txt |  14 +++
 Documentation/config/blame.txt  |   7 ++
 Documentation/git-blame.txt     |   1 +
 blame.c                         | 176 +++++++++++++++++++++++++--
 blame.h                         |   2 +
 builtin/blame.c                 |  38 ++++++
 t/t8013-blame-ignore-revs.sh    | 203 ++++++++++++++++++++++++++++++++
 7 files changed, 432 insertions(+), 9 deletions(-)
 create mode 100755 t/t8013-blame-ignore-revs.sh

diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
index dc41957afab2..2c2d1ceb5653 100644
--- a/Documentation/blame-options.txt
+++ b/Documentation/blame-options.txt
@@ -110,5 +110,19 @@ commit. And the default value is 40. If there are more than one
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
+	Ignore revisions listed in `file`, which must be in the same format as an
+	`fsck.skipList`.  This option may be repeated, and these files will be
+	processed after any files specified with the `blame.ignoreRevsFile` config
+	option.  An empty file name, `""`, will clear the list of revs from
+	previously processed files.
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
index 5369be9a2233..290bc97f31db 100644
--- a/blame.c
+++ b/blame.c
@@ -860,6 +860,103 @@ static struct blame_entry *split_blame_at(struct blame_entry *e, int len,
 	return n;
 }
 
+struct blame_line_tracker {
+	int is_parent;
+	int s_lno;
+};
+
+static int are_lines_adjacent(struct blame_line_tracker *first,
+			      struct blame_line_tracker *second)
+{
+	return first->is_parent == second->is_parent &&
+	       first->s_lno + 1 == second->s_lno;
+}
+
+/*
+ * This cheap heuristic assigns lines in the chunk to their relative location in
+ * the parent's chunk.  Any additional lines are left with the target.
+ */
+static void guess_line_blames(struct blame_origin *parent,
+			      struct blame_origin *target,
+			      int tlno, int offset, int same, int parent_len,
+			      struct blame_line_tracker *line_blames)
+{
+	int i, best_idx, target_idx;
+	int parent_slno = tlno + offset;
+
+	for (i = 0; i < same - tlno; i++) {
+		target_idx = tlno + i;
+		best_idx = target_idx + offset;
+		if (best_idx < parent_slno + parent_len) {
+			line_blames[i].is_parent = 1;
+			line_blames[i].s_lno = best_idx;
+		} else {
+			line_blames[i].is_parent = 0;
+			line_blames[i].s_lno = target_idx;
+		}
+	}
+}
+
+/*
+ * This decides which parts of a blame entry go to the parent (added to the
+ * ignoredp list) and which stay with the target (added to the diffp list).  The
+ * actual decision was made in a separate heuristic function, and those answers
+ * for the lines in 'e' are in line_blames.  This consumes e, essentially
+ * putting it on a list.
+ *
+ * Note that the blame entries on the ignoredp list are not necessarily sorted
+ * with respect to the parent's line numbers yet.
+ */
+static void ignore_blame_entry(struct blame_entry *e,
+			       struct blame_origin *parent,
+			       struct blame_origin *target,
+			       struct blame_entry **diffp,
+			       struct blame_entry **ignoredp,
+			       struct blame_line_tracker *line_blames)
+{
+	int entry_len, nr_lines, i;
+
+	/*
+	 * We carve new entries off the front of e.  Each entry comes from a
+	 * contiguous chunk of lines: adjacent lines from the same origin
+	 * (either the parent or the target).
+	 */
+	entry_len = 1;
+	nr_lines = e->num_lines;	/* e changes in the loop */
+	for (i = 0; i < nr_lines; i++) {
+		struct blame_entry *next = NULL;
+
+		/*
+		 * We are often adjacent to the next line - only split the blame
+		 * entry when we have to.
+		 */
+		if (i + 1 < nr_lines) {
+			if (are_lines_adjacent(&line_blames[i],
+					       &line_blames[i + 1])) {
+				entry_len++;
+				continue;
+			}
+			next = split_blame_at(e, entry_len,
+					      blame_origin_incref(e->suspect));
+		}
+		if (line_blames[i].is_parent) {
+			blame_origin_decref(e->suspect);
+			e->suspect = blame_origin_incref(parent);
+			e->s_lno = line_blames[i - entry_len + 1].s_lno;
+			e->next = *ignoredp;
+			*ignoredp = e;
+		} else {
+			/* e->s_lno is already in the target's address space. */
+			e->next = *diffp;
+			*diffp = e;
+		}
+		assert(e->num_lines == entry_len);
+		e = next;
+		entry_len = 1;
+	}
+	assert(!e);
+}
+
 /*
  * Process one hunk from the patch between the current suspect for
  * blame_entry e and its parent.  This first blames any unfinished
@@ -869,13 +966,20 @@ static struct blame_entry *split_blame_at(struct blame_entry *e, int len,
  * -C options may lead to overlapping/duplicate source line number
  * ranges, all we can rely on from sorting/merging is the order of the
  * first suspect line number.
+ *
+ * tlno: line number in the target where this chunk begins
+ * same: line number in the target where this chunk ends
+ * offset: add to tlno to get the chunk starting point in the parent
+ * parent_len: number of lines in the parent chunk
  */
 static void blame_chunk(struct blame_entry ***dstq, struct blame_entry ***srcq,
-			int tlno, int offset, int same,
-			struct blame_origin *parent)
+			int tlno, int offset, int same, int parent_len,
+			struct blame_origin *parent,
+			struct blame_origin *target, int ignore_diffs)
 {
 	struct blame_entry *e = **srcq;
-	struct blame_entry *samep = NULL, *diffp = NULL;
+	struct blame_entry *samep = NULL, *diffp = NULL, *ignoredp = NULL;
+	struct blame_line_tracker *line_blames = NULL;
 
 	while (e && e->s_lno < tlno) {
 		struct blame_entry *next = e->next;
@@ -924,6 +1028,14 @@ static void blame_chunk(struct blame_entry ***dstq, struct blame_entry ***srcq,
 	 */
 	samep = NULL;
 	diffp = NULL;
+
+	if (ignore_diffs && same - tlno > 0) {
+		line_blames = xcalloc(sizeof(struct blame_line_tracker),
+				      same - tlno);
+		guess_line_blames(parent, target, tlno, offset, same,
+				  parent_len, line_blames);
+	}
+
 	while (e && e->s_lno < same) {
 		struct blame_entry *next = e->next;
 
@@ -943,10 +1055,29 @@ static void blame_chunk(struct blame_entry ***dstq, struct blame_entry ***srcq,
 			n->next = samep;
 			samep = n;
 		}
-		e->next = diffp;
-		diffp = e;
+		if (ignore_diffs) {
+			ignore_blame_entry(e, parent, target, &diffp, &ignoredp,
+					   line_blames + e->s_lno - tlno);
+		} else {
+			e->next = diffp;
+			diffp = e;
+		}
 		e = next;
 	}
+	free(line_blames);
+	if (ignoredp) {
+		/*
+		 * Note ignoredp is not sorted yet, and thus neither is dstq.
+		 * That list must be sorted before we queue_blames().  We defer
+		 * sorting until after all diff hunks are processed, so that
+		 * guess_line_blames() can pick *any* line in the parent.  The
+		 * slight drawback is that we end up sorting all blame entries
+		 * passed to the parent, including those that are unrelated to
+		 * changes made by the ignored commit.
+		 */
+		**dstq = reverse_blame(ignoredp, **dstq);
+		*dstq = &ignoredp->next;
+	}
 	**srcq = reverse_blame(diffp, reverse_blame(samep, e));
 	/* Move across elements that are in the unblamable portion */
 	if (diffp)
@@ -955,7 +1086,9 @@ static void blame_chunk(struct blame_entry ***dstq, struct blame_entry ***srcq,
 
 struct blame_chunk_cb_data {
 	struct blame_origin *parent;
+	struct blame_origin *target;
 	long offset;
+	int ignore_diffs;
 	struct blame_entry **dstq;
 	struct blame_entry **srcq;
 };
@@ -968,7 +1101,8 @@ static int blame_chunk_cb(long start_a, long count_a,
 	if (start_a - start_b != d->offset)
 		die("internal error in blame::blame_chunk_cb");
 	blame_chunk(&d->dstq, &d->srcq, start_b, start_a - start_b,
-		    start_b + count_b, d->parent);
+		    start_b + count_b, count_a, d->parent, d->target,
+		    d->ignore_diffs);
 	d->offset = start_a + count_a - (start_b + count_b);
 	return 0;
 }
@@ -980,7 +1114,7 @@ static int blame_chunk_cb(long start_a, long count_a,
  */
 static void pass_blame_to_parent(struct blame_scoreboard *sb,
 				 struct blame_origin *target,
-				 struct blame_origin *parent)
+				 struct blame_origin *parent, int ignore_diffs)
 {
 	mmfile_t file_p, file_o;
 	struct blame_chunk_cb_data d;
@@ -990,7 +1124,9 @@ static void pass_blame_to_parent(struct blame_scoreboard *sb,
 		return; /* nothing remains for this target */
 
 	d.parent = parent;
+	d.target = target;
 	d.offset = 0;
+	d.ignore_diffs = ignore_diffs;
 	d.dstq = &newdest; d.srcq = &target->suspects;
 
 	fill_origin_blob(&sb->revs->diffopt, parent, &file_p, &sb->num_read_blob);
@@ -1002,8 +1138,13 @@ static void pass_blame_to_parent(struct blame_scoreboard *sb,
 		    oid_to_hex(&parent->commit->object.oid),
 		    oid_to_hex(&target->commit->object.oid));
 	/* The rest are the same as the parent */
-	blame_chunk(&d.dstq, &d.srcq, INT_MAX, d.offset, INT_MAX, parent);
+	blame_chunk(&d.dstq, &d.srcq, INT_MAX, d.offset, INT_MAX, 0,
+		    parent, target, 0);
 	*d.dstq = NULL;
+	if (ignore_diffs)
+		newdest = llist_mergesort(newdest, get_next_blame,
+					  set_next_blame,
+					  compare_blame_suspect);
 	queue_blames(sb, parent, newdest);
 
 	return;
@@ -1507,11 +1648,28 @@ static void pass_blame(struct blame_scoreboard *sb, struct blame_origin *origin,
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
index d62f80fa74c4..bd2f23ca36cf 100644
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
index 21cde57e711e..b8ef1e547cae 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -53,6 +53,7 @@ static int no_whole_file_rename;
 static int show_progress;
 static char repeated_meta_color[COLOR_MAXLEN];
 static int coloring_mode;
+static struct string_list ignore_revs_file_list = STRING_LIST_INIT_NODUP;
 
 static struct date_mode blame_date_mode = { DATE_ISO8601 };
 static size_t blame_date_width;
@@ -696,6 +697,16 @@ static int git_blame_config(const char *var, const char *value, void *cb)
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
@@ -775,6 +786,27 @@ static int is_a_rev(const char *name)
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
+			die(_("cannot find revision %s to ignore"), i->string);
+		oidset_insert(&sb->ignore_list, &oid);
+	}
+}
+
 int cmd_blame(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info revs;
@@ -786,6 +818,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	struct progress_info pi = { NULL, 0 };
 
 	struct string_list range_list = STRING_LIST_INIT_NODUP;
+	struct string_list ignore_rev_list = STRING_LIST_INIT_NODUP;
 	int output_option = 0, opt = 0;
 	int show_stats = 0;
 	const char *revs_file = NULL;
@@ -807,6 +840,8 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		OPT_BIT('s', NULL, &output_option, N_("Suppress author name and timestamp (Default: off)"), OUTPUT_NO_AUTHOR),
 		OPT_BIT('e', "show-email", &output_option, N_("Show author email instead of name (Default: off)"), OUTPUT_SHOW_EMAIL),
 		OPT_BIT('w', NULL, &xdl_opts, N_("Ignore whitespace differences"), XDF_IGNORE_WHITESPACE),
+		OPT_STRING_LIST(0, "ignore-rev", &ignore_rev_list, N_("rev"), N_("Ignore <rev> when blaming")),
+		OPT_STRING_LIST(0, "ignore-revs-file", &ignore_revs_file_list, N_("file"), N_("Ignore revisions from <file>")),
 		OPT_BIT(0, "color-lines", &output_option, N_("color redundant metadata from previous line differently"), OUTPUT_COLOR_LINE),
 		OPT_BIT(0, "color-by-age", &output_option, N_("color lines by age"), OUTPUT_SHOW_AGE_WITH_COLOR),
 
@@ -1012,6 +1047,9 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
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
index 000000000000..fdb2fa879781
--- /dev/null
+++ b/t/t8013-blame-ignore-revs.sh
@@ -0,0 +1,203 @@
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
+	grep -E "^[0-9a-f]+ [0-9]+ 1" blame_raw | sed -e "s/ .*//" >actual &&
+	git rev-parse X >expect &&
+	test_cmp expect actual &&
+
+	grep -E "^[0-9a-f]+ [0-9]+ 2" blame_raw | sed -e "s/ .*//" >actual &&
+	git rev-parse X >expect &&
+	test_cmp expect actual
+	'
+
+# Ignore X, make sure A is blamed for line 1 and B for line 2.
+test_expect_success ignore_rev_changing_lines '
+	git blame --line-porcelain --ignore-rev X file >blame_raw &&
+
+	grep -E "^[0-9a-f]+ [0-9]+ 1" blame_raw | sed -e "s/ .*//" >actual &&
+	git rev-parse A >expect &&
+	test_cmp expect actual &&
+
+	grep -E "^[0-9a-f]+ [0-9]+ 2" blame_raw | sed -e "s/ .*//" >actual &&
+	git rev-parse B >expect &&
+	test_cmp expect actual
+	'
+
+# For ignored revs that have added 'unblamable' lines, attribute those to the
+# ignored commit.
+# 	A--B--X--Y
+# Where Y changes lines 1 and 2, and adds lines 3 and 4.  The added lines ought
+# to have nothing in common with "line-one" or "line-two", to keep any
+# heuristics from matching them with any lines in the parent.
+test_expect_success ignore_rev_adding_unblamable_lines '
+	test_write_lines line-one-change line-two-changed y3 y4 >file &&
+	git add file &&
+	test_tick &&
+	git commit -m Y &&
+	git tag Y &&
+
+	git rev-parse Y >expect &&
+	git blame --line-porcelain file --ignore-rev Y >blame_raw &&
+
+	grep -E "^[0-9a-f]+ [0-9]+ 3" blame_raw | sed -e "s/ .*//" >actual &&
+	test_cmp expect actual &&
+
+	grep -E "^[0-9a-f]+ [0-9]+ 4" blame_raw | sed -e "s/ .*//" >actual &&
+	test_cmp expect actual
+	'
+
+# Ignore X and Y, both in separate files.  Lines 1 == A, 2 == B.
+test_expect_success ignore_revs_from_files '
+	git rev-parse X >ignore_x &&
+	git rev-parse Y >ignore_y &&
+	git blame --line-porcelain file --ignore-revs-file ignore_x --ignore-revs-file ignore_y >blame_raw &&
+
+	grep -E "^[0-9a-f]+ [0-9]+ 1" blame_raw | sed -e "s/ .*//" >actual &&
+	git rev-parse A >expect &&
+	test_cmp expect actual &&
+
+	grep -E "^[0-9a-f]+ [0-9]+ 2" blame_raw | sed -e "s/ .*//" >actual &&
+	git rev-parse B >expect &&
+	test_cmp expect actual
+	'
+
+# Ignore X from the config option, Y from a file.
+test_expect_success ignore_revs_from_configs_and_files '
+	git config --add blame.ignoreRevsFile ignore_x &&
+	git blame --line-porcelain file --ignore-revs-file ignore_y >blame_raw &&
+
+	grep -E "^[0-9a-f]+ [0-9]+ 1" blame_raw | sed -e "s/ .*//" >actual &&
+	git rev-parse A >expect &&
+	test_cmp expect actual &&
+
+	grep -E "^[0-9a-f]+ [0-9]+ 2" blame_raw | sed -e "s/ .*//" >actual &&
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
+	grep -E "^[0-9a-f]+ [0-9]+ 1" blame_raw | sed -e "s/ .*//" >actual &&
+	test_cmp expect actual &&
+
+	grep -E "^[0-9a-f]+ [0-9]+ 2" blame_raw | sed -e "s/ .*//" >actual &&
+	test_cmp expect actual
+	'
+test_expect_success bad_files_and_revs '
+	test_must_fail git blame file --ignore-rev NOREV 2>err &&
+	test_i18ngrep "cannot find revision NOREV to ignore" err &&
+
+	test_must_fail git blame file --ignore-revs-file NOFILE 2>err &&
+	test_i18ngrep "could not open.*: NOFILE" err &&
+
+	echo NOREV >ignore_norev &&
+	test_must_fail git blame file --ignore-revs-file ignore_norev 2>err &&
+	test_i18ngrep "invalid object name: NOREV" err
+	'
+# The heuristic called by guess_line_blames() tries to find the size of a
+# blame_entry 'e' in the parent's address space.  Those calculations need to
+# check for negative or zero values for when a blame entry is completely outside
+# the window of the parent's version of a file.
+#
+# This happens when one commit adds several lines (commit B below).  A later
+# commit (C) changes one line in the middle of B's change.  Commit C gets blamed
+# for its change, and that breaks up B's change into multiple blame entries.
+# When processing B, one of the blame_entries is outside A's window (which was
+# zero - it had no lines added on its side of the diff).
+#
+# A--B--C, ignore B to test the ignore heuristic's boundary checks.
+test_expect_success ignored_chunk_negative_parent_size '
+	rm -rf .git/ &&
+	git init &&
+
+	test_write_lines L1 L2 L7 L8 L9 >file &&
+	git add file &&
+	test_tick &&
+	git commit -m A &&
+	git tag A &&
+
+	test_write_lines L1 L2 L3 L4 L5 L6 L7 L8 L9 >file &&
+	git add file &&
+	test_tick &&
+	git commit -m B &&
+	git tag B &&
+
+	test_write_lines L1 L2 L3 L4 xxx L6 L7 L8 L9 >file &&
+	git add file &&
+	test_tick &&
+	git commit -m C &&
+	git tag C &&
+
+	git blame file --ignore-rev B >blame_raw
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
+	grep -E "^[0-9a-f]+ [0-9]+ 1" blame_raw | sed -e "s/ .*//" >actual &&
+	git rev-parse B >expect &&
+	test_cmp expect actual &&
+
+	grep -E "^[0-9a-f]+ [0-9]+ 9" blame_raw | sed -e "s/ .*//" >actual &&
+	git rev-parse C >expect &&
+	test_cmp expect actual
+	'
+
+test_done
-- 
2.21.0.1020.gf2820cf01a-goog

