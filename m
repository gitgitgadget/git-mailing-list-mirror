Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18B7820188
	for <e@80x24.org>; Sun, 14 May 2017 03:16:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758878AbdENDQr (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 May 2017 23:16:47 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:35153 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757197AbdENDQd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2017 23:16:33 -0400
Received: by mail-oi0-f66.google.com with SMTP id m17so14324431oik.2
        for <git@vger.kernel.org>; Sat, 13 May 2017 20:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fX9mWznYQiJrmgcZPhm6GS6HwOY/Tnznva9/SXDbA2Y=;
        b=MviXXWgPLigAy9UxAVHwDTVuS5nWqdgdZgyM9zYKoit9pE28LRMOU+LLDjdpZQ/eQm
         bIVqN7ANfsIM7/FzMwRPGFANQrbemcIAHG3TRfpaJXSFvzCpf+KivgzARNSDjePEILqB
         OTB49Z1ZuqZzoxWHMyTRsmAN9glGJH0jOuzdYhBggj5djvqRYO3/hArhZ82kuL4nzQ2t
         aD0zlizKLredm7XTH7hm/EV8ePDLF5Icnui2rydXufc7q4XpCIyrmxkAKZAGpB0blpWi
         ydpIb0etHKkulqQc/fvt5fl/DVgHO5HX+8Ektfw6FAzVw3uTLIHdyMl4tIkfcL2htTVU
         /+hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fX9mWznYQiJrmgcZPhm6GS6HwOY/Tnznva9/SXDbA2Y=;
        b=f7PfGacjbxBtGhOkQhcQBzFs6HXTSktSaeL2Q+z8pacBweQAmgVDLd8kvZ9TjuucOS
         QLtggLGpke8tUDcj5i8/qbUtrUoZzqXfbsUaZ3869pamPXJwUlr5jtv5TyyfItELQzBc
         nlOnof4WNw5vmxxM+bmQGncaqFFQBemgcUxJHkK/SOsYUD4r+HZaio8n36vBHz/n2rvZ
         1jY4klae/WjZdYKLpOJ1u5TapEbtl7b3xwgus/c/b3Plfn7qSBMqXk7PX6U8cJdcGY7c
         7fm2B8r8OUCmDEFKjWmtk7HZ0WdYfZwCd60Slb/3cy6bvFB+6STBFuf+7inBjKqohi79
         8pXw==
X-Gm-Message-State: AODbwcBLvEDEfuAXNE0ViLpHBJXgrKVCs6kllBj4mcs3UFwrf+93xpcC
        QCXSZjsCgNgGdQ==
X-Received: by 10.157.37.1 with SMTP id k1mr5103173otb.116.1494731790778;
        Sat, 13 May 2017 20:16:30 -0700 (PDT)
Received: from whydoubt.T-mobile.com (ip68-12-240-88.ok.ok.cox.net. [68.12.240.88])
        by smtp.gmail.com with ESMTPSA id 67sm3735193otb.53.2017.05.13.20.16.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 May 2017 20:16:29 -0700 (PDT)
From:   Jeff Smith <whydoubt@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Jeff Smith <whydoubt@gmail.com>
Subject: [RFC PATCH v2 19/22] blame: move scoreboard-related methods to libgit
Date:   Sat, 13 May 2017 22:15:10 -0500
Message-Id: <20170514031513.9042-20-whydoubt@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170514031513.9042-1-whydoubt@gmail.com>
References: <20170505052729.7576-1-whydoubt@gmail.com>
 <20170514031513.9042-1-whydoubt@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jeff Smith <whydoubt@gmail.com>
---
 blame.c         | 1313 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 blame.h         |   11 +
 builtin/blame.c | 1330 +------------------------------------------------------
 3 files changed, 1330 insertions(+), 1324 deletions(-)

diff --git a/blame.c b/blame.c
index 8c025bc..798e61b 100644
--- a/blame.c
+++ b/blame.c
@@ -1,6 +1,9 @@
 #include "cache.h"
 #include "refs.h"
 #include "cache-tree.h"
+#include "mergesort.h"
+#include "diff.h"
+#include "diffcore.h"
 #include "blame.h"
 
 void blame_origin_decref(struct blame_origin *o)
@@ -261,3 +264,1313 @@ struct commit *fake_working_tree_commit(struct diff_options *opt,
 
 	return commit;
 }
+
+
+
+static int diff_hunks(mmfile_t *file_a, mmfile_t *file_b,
+		      xdl_emit_hunk_consume_func_t hunk_func, void *cb_data, int xdl_opts)
+{
+	xpparam_t xpp = {0};
+	xdemitconf_t xecfg = {0};
+	xdemitcb_t ecb = {NULL};
+
+	xpp.flags = xdl_opts;
+	xecfg.hunk_func = hunk_func;
+	ecb.priv = cb_data;
+	return xdi_diff(file_a, file_b, &xpp, &xecfg, &ecb);
+}
+
+/*
+ * Given an origin, prepare mmfile_t structure to be used by the
+ * diff machinery
+ */
+static void fill_origin_blob(struct diff_options *opt,
+			     struct blame_origin *o, mmfile_t *file, int *num_read_blob)
+{
+	if (!o->file.ptr) {
+		enum object_type type;
+		unsigned long file_size;
+
+		(*num_read_blob)++;
+		if (DIFF_OPT_TST(opt, ALLOW_TEXTCONV) &&
+		    textconv_object(o->path, o->mode, &o->blob_oid, 1, &file->ptr, &file_size))
+			;
+		else
+			file->ptr = read_sha1_file(o->blob_oid.hash, &type,
+						   &file_size);
+		file->size = file_size;
+
+		if (!file->ptr)
+			die("Cannot read blob %s for path %s",
+			    oid_to_hex(&o->blob_oid),
+			    o->path);
+		o->file = *file;
+	}
+	else
+		*file = o->file;
+}
+
+static void drop_origin_blob(struct blame_origin *o)
+{
+	if (o->file.ptr) {
+		free(o->file.ptr);
+		o->file.ptr = NULL;
+	}
+}
+
+/*
+ * Any merge of blames happens on lists of blames that arrived via
+ * different parents in a single suspect.  In this case, we want to
+ * sort according to the suspect line numbers as opposed to the final
+ * image line numbers.  The function body is somewhat longish because
+ * it avoids unnecessary writes.
+ */
+
+static struct blame_entry *blame_merge(struct blame_entry *list1,
+				       struct blame_entry *list2)
+{
+	struct blame_entry *p1 = list1, *p2 = list2,
+		**tail = &list1;
+
+	if (!p1)
+		return p2;
+	if (!p2)
+		return p1;
+
+	if (p1->s_lno <= p2->s_lno) {
+		do {
+			tail = &p1->next;
+			if ((p1 = *tail) == NULL) {
+				*tail = p2;
+				return list1;
+			}
+		} while (p1->s_lno <= p2->s_lno);
+	}
+	for (;;) {
+		*tail = p2;
+		do {
+			tail = &p2->next;
+			if ((p2 = *tail) == NULL)  {
+				*tail = p1;
+				return list1;
+			}
+		} while (p1->s_lno > p2->s_lno);
+		*tail = p1;
+		do {
+			tail = &p1->next;
+			if ((p1 = *tail) == NULL) {
+				*tail = p2;
+				return list1;
+			}
+		} while (p1->s_lno <= p2->s_lno);
+	}
+}
+
+static void *get_next_blame(const void *p)
+{
+	return ((struct blame_entry *)p)->next;
+}
+
+static void set_next_blame(void *p1, void *p2)
+{
+	((struct blame_entry *)p1)->next = p2;
+}
+
+/*
+ * Final image line numbers are all different, so we don't need a
+ * three-way comparison here.
+ */
+
+static int compare_blame_final(const void *p1, const void *p2)
+{
+	return ((struct blame_entry *)p1)->lno > ((struct blame_entry *)p2)->lno
+		? 1 : -1;
+}
+
+static int compare_blame_suspect(const void *p1, const void *p2)
+{
+	const struct blame_entry *s1 = p1, *s2 = p2;
+	/*
+	 * to allow for collating suspects, we sort according to the
+	 * respective pointer value as the primary sorting criterion.
+	 * The actual relation is pretty unimportant as long as it
+	 * establishes a total order.  Comparing as integers gives us
+	 * that.
+	 */
+	if (s1->suspect != s2->suspect)
+		return (intptr_t)s1->suspect > (intptr_t)s2->suspect ? 1 : -1;
+	if (s1->s_lno == s2->s_lno)
+		return 0;
+	return s1->s_lno > s2->s_lno ? 1 : -1;
+}
+
+void blame_sort_final(struct blame_scoreboard *sb)
+{
+	sb->ent = llist_mergesort(sb->ent, get_next_blame, set_next_blame,
+				  compare_blame_final);
+}
+
+/*
+ * For debugging -- origin is refcounted, and this asserts that
+ * we do not underflow.
+ */
+static void sanity_check_refcnt(struct blame_scoreboard *sb)
+{
+	int baa = 0;
+	struct blame_entry *ent;
+
+	for (ent = sb->ent; ent; ent = ent->next) {
+		/* Nobody should have zero or negative refcnt */
+		if (ent->suspect->refcnt <= 0) {
+			fprintf(stderr, "%s in %s has negative refcnt %d\n",
+				ent->suspect->path,
+				oid_to_hex(&ent->suspect->commit->object.oid),
+				ent->suspect->refcnt);
+			baa = 1;
+		}
+	}
+	if (baa)
+		sb->on_sanity_fail(sb, baa);
+}
+
+/*
+ * If two blame entries that are next to each other came from
+ * contiguous lines in the same origin (i.e. <commit, path> pair),
+ * merge them together.
+ */
+void blame_coalesce(struct blame_scoreboard *sb)
+{
+	struct blame_entry *ent, *next;
+
+	for (ent = sb->ent; ent && (next = ent->next); ent = next) {
+		if (ent->suspect == next->suspect &&
+		    ent->s_lno + ent->num_lines == next->s_lno) {
+			ent->num_lines += next->num_lines;
+			ent->next = next->next;
+			blame_origin_decref(next->suspect);
+			free(next);
+			ent->score = 0;
+			next = ent; /* again */
+		}
+	}
+
+	if (sb->debug) /* sanity */
+		sanity_check_refcnt(sb);
+}
+
+/*
+ * Merge the given sorted list of blames into a preexisting origin.
+ * If there were no previous blames to that commit, it is entered into
+ * the commit priority queue of the score board.
+ */
+
+static void queue_blames(struct blame_scoreboard *sb, struct blame_origin *porigin,
+			 struct blame_entry *sorted)
+{
+	if (porigin->suspects)
+		porigin->suspects = blame_merge(porigin->suspects, sorted);
+	else {
+		struct blame_origin *o;
+		for (o = porigin->commit->util; o; o = o->next) {
+			if (o->suspects) {
+				porigin->suspects = sorted;
+				return;
+			}
+		}
+		porigin->suspects = sorted;
+		prio_queue_put(&sb->commits, porigin->commit);
+	}
+}
+
+/*
+ * We have an origin -- check if the same path exists in the
+ * parent and return an origin structure to represent it.
+ */
+static struct blame_origin *find_origin(struct commit *parent,
+				  struct blame_origin *origin)
+{
+	struct blame_origin *porigin;
+	struct diff_options diff_opts;
+	const char *paths[2];
+
+	/* First check any existing origins */
+	for (porigin = parent->util; porigin; porigin = porigin->next)
+		if (!strcmp(porigin->path, origin->path)) {
+			/*
+			 * The same path between origin and its parent
+			 * without renaming -- the most common case.
+			 */
+			return blame_origin_incref (porigin);
+		}
+
+	/* See if the origin->path is different between parent
+	 * and origin first.  Most of the time they are the
+	 * same and diff-tree is fairly efficient about this.
+	 */
+	diff_setup(&diff_opts);
+	DIFF_OPT_SET(&diff_opts, RECURSIVE);
+	diff_opts.detect_rename = 0;
+	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
+	paths[0] = origin->path;
+	paths[1] = NULL;
+
+	parse_pathspec(&diff_opts.pathspec,
+		       PATHSPEC_ALL_MAGIC & ~PATHSPEC_LITERAL,
+		       PATHSPEC_LITERAL_PATH, "", paths);
+	diff_setup_done(&diff_opts);
+
+	if (is_null_oid(&origin->commit->object.oid))
+		do_diff_cache(parent->tree->object.oid.hash, &diff_opts);
+	else
+		diff_tree_sha1(parent->tree->object.oid.hash,
+			       origin->commit->tree->object.oid.hash,
+			       "", &diff_opts);
+	diffcore_std(&diff_opts);
+
+	if (!diff_queued_diff.nr) {
+		/* The path is the same as parent */
+		porigin = get_origin(parent, origin->path);
+		oidcpy(&porigin->blob_oid, &origin->blob_oid);
+		porigin->mode = origin->mode;
+	} else {
+		/*
+		 * Since origin->path is a pathspec, if the parent
+		 * commit had it as a directory, we will see a whole
+		 * bunch of deletion of files in the directory that we
+		 * do not care about.
+		 */
+		int i;
+		struct diff_filepair *p = NULL;
+		for (i = 0; i < diff_queued_diff.nr; i++) {
+			const char *name;
+			p = diff_queued_diff.queue[i];
+			name = p->one->path ? p->one->path : p->two->path;
+			if (!strcmp(name, origin->path))
+				break;
+		}
+		if (!p)
+			die("internal error in blame::find_origin");
+		switch (p->status) {
+		default:
+			die("internal error in blame::find_origin (%c)",
+			    p->status);
+		case 'M':
+			porigin = get_origin(parent, origin->path);
+			oidcpy(&porigin->blob_oid, &p->one->oid);
+			porigin->mode = p->one->mode;
+			break;
+		case 'A':
+		case 'T':
+			/* Did not exist in parent, or type changed */
+			break;
+		}
+	}
+	diff_flush(&diff_opts);
+	clear_pathspec(&diff_opts.pathspec);
+	return porigin;
+}
+
+/*
+ * We have an origin -- find the path that corresponds to it in its
+ * parent and return an origin structure to represent it.
+ */
+static struct blame_origin *find_rename(struct commit *parent,
+				  struct blame_origin *origin)
+{
+	struct blame_origin *porigin = NULL;
+	struct diff_options diff_opts;
+	int i;
+
+	diff_setup(&diff_opts);
+	DIFF_OPT_SET(&diff_opts, RECURSIVE);
+	diff_opts.detect_rename = DIFF_DETECT_RENAME;
+	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
+	diff_opts.single_follow = origin->path;
+	diff_setup_done(&diff_opts);
+
+	if (is_null_oid(&origin->commit->object.oid))
+		do_diff_cache(parent->tree->object.oid.hash, &diff_opts);
+	else
+		diff_tree_sha1(parent->tree->object.oid.hash,
+			       origin->commit->tree->object.oid.hash,
+			       "", &diff_opts);
+	diffcore_std(&diff_opts);
+
+	for (i = 0; i < diff_queued_diff.nr; i++) {
+		struct diff_filepair *p = diff_queued_diff.queue[i];
+		if ((p->status == 'R' || p->status == 'C') &&
+		    !strcmp(p->two->path, origin->path)) {
+			porigin = get_origin(parent, p->one->path);
+			oidcpy(&porigin->blob_oid, &p->one->oid);
+			porigin->mode = p->one->mode;
+			break;
+		}
+	}
+	diff_flush(&diff_opts);
+	clear_pathspec(&diff_opts.pathspec);
+	return porigin;
+}
+
+/*
+ * Append a new blame entry to a given output queue.
+ */
+static void add_blame_entry(struct blame_entry ***queue,
+			    const struct blame_entry *src)
+{
+	struct blame_entry *e = xmalloc(sizeof(*e));
+	memcpy(e, src, sizeof(*e));
+	blame_origin_incref(e->suspect);
+
+	e->next = **queue;
+	**queue = e;
+	*queue = &e->next;
+}
+
+/*
+ * src typically is on-stack; we want to copy the information in it to
+ * a malloced blame_entry that gets added to the given queue.  The
+ * origin of dst loses a refcnt.
+ */
+static void dup_entry(struct blame_entry ***queue,
+		      struct blame_entry *dst, struct blame_entry *src)
+{
+	blame_origin_incref(src->suspect);
+	blame_origin_decref(dst->suspect);
+	memcpy(dst, src, sizeof(*src));
+	dst->next = **queue;
+	**queue = dst;
+	*queue = &dst->next;
+}
+
+const char *blame_nth_line(struct blame_scoreboard *sb, long lno)
+{
+	return sb->final_buf + sb->lineno[lno];
+}
+
+/*
+ * It is known that lines between tlno to same came from parent, and e
+ * has an overlap with that range.  it also is known that parent's
+ * line plno corresponds to e's line tlno.
+ *
+ *                <---- e ----->
+ *                   <------>
+ *                   <------------>
+ *             <------------>
+ *             <------------------>
+ *
+ * Split e into potentially three parts; before this chunk, the chunk
+ * to be blamed for the parent, and after that portion.
+ */
+static void split_overlap(struct blame_entry *split,
+			  struct blame_entry *e,
+			  int tlno, int plno, int same,
+			  struct blame_origin *parent)
+{
+	int chunk_end_lno;
+	memset(split, 0, sizeof(struct blame_entry [3]));
+
+	if (e->s_lno < tlno) {
+		/* there is a pre-chunk part not blamed on parent */
+		split[0].suspect = blame_origin_incref(e->suspect);
+		split[0].lno = e->lno;
+		split[0].s_lno = e->s_lno;
+		split[0].num_lines = tlno - e->s_lno;
+		split[1].lno = e->lno + tlno - e->s_lno;
+		split[1].s_lno = plno;
+	}
+	else {
+		split[1].lno = e->lno;
+		split[1].s_lno = plno + (e->s_lno - tlno);
+	}
+
+	if (same < e->s_lno + e->num_lines) {
+		/* there is a post-chunk part not blamed on parent */
+		split[2].suspect = blame_origin_incref(e->suspect);
+		split[2].lno = e->lno + (same - e->s_lno);
+		split[2].s_lno = e->s_lno + (same - e->s_lno);
+		split[2].num_lines = e->s_lno + e->num_lines - same;
+		chunk_end_lno = split[2].lno;
+	}
+	else
+		chunk_end_lno = e->lno + e->num_lines;
+	split[1].num_lines = chunk_end_lno - split[1].lno;
+
+	/*
+	 * if it turns out there is nothing to blame the parent for,
+	 * forget about the splitting.  !split[1].suspect signals this.
+	 */
+	if (split[1].num_lines < 1)
+		return;
+	split[1].suspect = blame_origin_incref(parent);
+}
+
+/*
+ * split_overlap() divided an existing blame e into up to three parts
+ * in split.  Any assigned blame is moved to queue to
+ * reflect the split.
+ */
+static void split_blame(struct blame_entry ***blamed,
+			struct blame_entry ***unblamed,
+			struct blame_entry *split,
+			struct blame_entry *e)
+{
+	if (split[0].suspect && split[2].suspect) {
+		/* The first part (reuse storage for the existing entry e) */
+		dup_entry(unblamed, e, &split[0]);
+
+		/* The last part -- me */
+		add_blame_entry(unblamed, &split[2]);
+
+		/* ... and the middle part -- parent */
+		add_blame_entry(blamed, &split[1]);
+	}
+	else if (!split[0].suspect && !split[2].suspect)
+		/*
+		 * The parent covers the entire area; reuse storage for
+		 * e and replace it with the parent.
+		 */
+		dup_entry(blamed, e, &split[1]);
+	else if (split[0].suspect) {
+		/* me and then parent */
+		dup_entry(unblamed, e, &split[0]);
+		add_blame_entry(blamed, &split[1]);
+	}
+	else {
+		/* parent and then me */
+		dup_entry(blamed, e, &split[1]);
+		add_blame_entry(unblamed, &split[2]);
+	}
+}
+
+/*
+ * After splitting the blame, the origins used by the
+ * on-stack blame_entry should lose one refcnt each.
+ */
+static void decref_split(struct blame_entry *split)
+{
+	int i;
+
+	for (i = 0; i < 3; i++)
+		blame_origin_decref(split[i].suspect);
+}
+
+/*
+ * reverse_blame reverses the list given in head, appending tail.
+ * That allows us to build lists in reverse order, then reverse them
+ * afterwards.  This can be faster than building the list in proper
+ * order right away.  The reason is that building in proper order
+ * requires writing a link in the _previous_ element, while building
+ * in reverse order just requires placing the list head into the
+ * _current_ element.
+ */
+
+static struct blame_entry *reverse_blame(struct blame_entry *head,
+					 struct blame_entry *tail)
+{
+	while (head) {
+		struct blame_entry *next = head->next;
+		head->next = tail;
+		tail = head;
+		head = next;
+	}
+	return tail;
+}
+
+/*
+ * Process one hunk from the patch between the current suspect for
+ * blame_entry e and its parent.  This first blames any unfinished
+ * entries before the chunk (which is where target and parent start
+ * differing) on the parent, and then splits blame entries at the
+ * start and at the end of the difference region.  Since use of -M and
+ * -C options may lead to overlapping/duplicate source line number
+ * ranges, all we can rely on from sorting/merging is the order of the
+ * first suspect line number.
+ */
+static void blame_chunk(struct blame_entry ***dstq, struct blame_entry ***srcq,
+			int tlno, int offset, int same,
+			struct blame_origin *parent)
+{
+	struct blame_entry *e = **srcq;
+	struct blame_entry *samep = NULL, *diffp = NULL;
+
+	while (e && e->s_lno < tlno) {
+		struct blame_entry *next = e->next;
+		/*
+		 * current record starts before differing portion.  If
+		 * it reaches into it, we need to split it up and
+		 * examine the second part separately.
+		 */
+		if (e->s_lno + e->num_lines > tlno) {
+			/* Move second half to a new record */
+			int len = tlno - e->s_lno;
+			struct blame_entry *n = xcalloc(1, sizeof (struct blame_entry));
+			n->suspect = e->suspect;
+			n->lno = e->lno + len;
+			n->s_lno = e->s_lno + len;
+			n->num_lines = e->num_lines - len;
+			e->num_lines = len;
+			e->score = 0;
+			/* Push new record to diffp */
+			n->next = diffp;
+			diffp = n;
+		} else
+			blame_origin_decref(e->suspect);
+		/* Pass blame for everything before the differing
+		 * chunk to the parent */
+		e->suspect = blame_origin_incref(parent);
+		e->s_lno += offset;
+		e->next = samep;
+		samep = e;
+		e = next;
+	}
+	/*
+	 * As we don't know how much of a common stretch after this
+	 * diff will occur, the currently blamed parts are all that we
+	 * can assign to the parent for now.
+	 */
+
+	if (samep) {
+		**dstq = reverse_blame(samep, **dstq);
+		*dstq = &samep->next;
+	}
+	/*
+	 * Prepend the split off portions: everything after e starts
+	 * after the blameable portion.
+	 */
+	e = reverse_blame(diffp, e);
+
+	/*
+	 * Now retain records on the target while parts are different
+	 * from the parent.
+	 */
+	samep = NULL;
+	diffp = NULL;
+	while (e && e->s_lno < same) {
+		struct blame_entry *next = e->next;
+
+		/*
+		 * If current record extends into sameness, need to split.
+		 */
+		if (e->s_lno + e->num_lines > same) {
+			/*
+			 * Move second half to a new record to be
+			 * processed by later chunks
+			 */
+			int len = same - e->s_lno;
+			struct blame_entry *n = xcalloc(1, sizeof (struct blame_entry));
+			n->suspect = blame_origin_incref(e->suspect);
+			n->lno = e->lno + len;
+			n->s_lno = e->s_lno + len;
+			n->num_lines = e->num_lines - len;
+			e->num_lines = len;
+			e->score = 0;
+			/* Push new record to samep */
+			n->next = samep;
+			samep = n;
+		}
+		e->next = diffp;
+		diffp = e;
+		e = next;
+	}
+	**srcq = reverse_blame(diffp, reverse_blame(samep, e));
+	/* Move across elements that are in the unblamable portion */
+	if (diffp)
+		*srcq = &diffp->next;
+}
+
+struct blame_chunk_cb_data {
+	struct blame_origin *parent;
+	long offset;
+	struct blame_entry **dstq;
+	struct blame_entry **srcq;
+};
+
+/* diff chunks are from parent to target */
+static int blame_chunk_cb(long start_a, long count_a,
+			  long start_b, long count_b, void *data)
+{
+	struct blame_chunk_cb_data *d = data;
+	if (start_a - start_b != d->offset)
+		die("internal error in blame::blame_chunk_cb");
+	blame_chunk(&d->dstq, &d->srcq, start_b, start_a - start_b,
+		    start_b + count_b, d->parent);
+	d->offset = start_a + count_a - (start_b + count_b);
+	return 0;
+}
+
+/*
+ * We are looking at the origin 'target' and aiming to pass blame
+ * for the lines it is suspected to its parent.  Run diff to find
+ * which lines came from parent and pass blame for them.
+ */
+static void pass_blame_to_parent(struct blame_scoreboard *sb,
+				 struct blame_origin *target,
+				 struct blame_origin *parent)
+{
+	mmfile_t file_p, file_o;
+	struct blame_chunk_cb_data d;
+	struct blame_entry *newdest = NULL;
+
+	if (!target->suspects)
+		return; /* nothing remains for this target */
+
+	d.parent = parent;
+	d.offset = 0;
+	d.dstq = &newdest; d.srcq = &target->suspects;
+
+	fill_origin_blob(&sb->revs->diffopt, parent, &file_p, &sb->num_read_blob);
+	fill_origin_blob(&sb->revs->diffopt, target, &file_o, &sb->num_read_blob);
+	sb->num_get_patch++;
+
+	if (diff_hunks(&file_p, &file_o, blame_chunk_cb, &d, sb->xdl_opts))
+		die("unable to generate diff (%s -> %s)",
+		    oid_to_hex(&parent->commit->object.oid),
+		    oid_to_hex(&target->commit->object.oid));
+	/* The rest are the same as the parent */
+	blame_chunk(&d.dstq, &d.srcq, INT_MAX, d.offset, INT_MAX, parent);
+	*d.dstq = NULL;
+	queue_blames(sb, parent, newdest);
+
+	return;
+}
+
+/*
+ * The lines in blame_entry after splitting blames many times can become
+ * very small and trivial, and at some point it becomes pointless to
+ * blame the parents.  E.g. "\t\t}\n\t}\n\n" appears everywhere in any
+ * ordinary C program, and it is not worth to say it was copied from
+ * totally unrelated file in the parent.
+ *
+ * Compute how trivial the lines in the blame_entry are.
+ */
+unsigned blame_entry_score(struct blame_scoreboard *sb, struct blame_entry *e)
+{
+	unsigned score;
+	const char *cp, *ep;
+
+	if (e->score)
+		return e->score;
+
+	score = 1;
+	cp = blame_nth_line(sb, e->lno);
+	ep = blame_nth_line(sb, e->lno + e->num_lines);
+	while (cp < ep) {
+		unsigned ch = *((unsigned char *)cp);
+		if (isalnum(ch))
+			score++;
+		cp++;
+	}
+	e->score = score;
+	return score;
+}
+
+/*
+ * best_so_far[] and this[] are both a split of an existing blame_entry
+ * that passes blame to the parent.  Maintain best_so_far the best split
+ * so far, by comparing this and best_so_far and copying this into
+ * bst_so_far as needed.
+ */
+static void copy_split_if_better(struct blame_scoreboard *sb,
+				 struct blame_entry *best_so_far,
+				 struct blame_entry *this)
+{
+	int i;
+
+	if (!this[1].suspect)
+		return;
+	if (best_so_far[1].suspect) {
+		if (blame_entry_score(sb, &this[1]) < blame_entry_score(sb, &best_so_far[1]))
+			return;
+	}
+
+	for (i = 0; i < 3; i++)
+		blame_origin_incref(this[i].suspect);
+	decref_split(best_so_far);
+	memcpy(best_so_far, this, sizeof(struct blame_entry [3]));
+}
+
+/*
+ * We are looking at a part of the final image represented by
+ * ent (tlno and same are offset by ent->s_lno).
+ * tlno is where we are looking at in the final image.
+ * up to (but not including) same match preimage.
+ * plno is where we are looking at in the preimage.
+ *
+ * <-------------- final image ---------------------->
+ *       <------ent------>
+ *         ^tlno ^same
+ *    <---------preimage----->
+ *         ^plno
+ *
+ * All line numbers are 0-based.
+ */
+static void handle_split(struct blame_scoreboard *sb,
+			 struct blame_entry *ent,
+			 int tlno, int plno, int same,
+			 struct blame_origin *parent,
+			 struct blame_entry *split)
+{
+	if (ent->num_lines <= tlno)
+		return;
+	if (tlno < same) {
+		struct blame_entry this[3];
+		tlno += ent->s_lno;
+		same += ent->s_lno;
+		split_overlap(this, ent, tlno, plno, same, parent);
+		copy_split_if_better(sb, split, this);
+		decref_split(this);
+	}
+}
+
+struct handle_split_cb_data {
+	struct blame_scoreboard *sb;
+	struct blame_entry *ent;
+	struct blame_origin *parent;
+	struct blame_entry *split;
+	long plno;
+	long tlno;
+};
+
+static int handle_split_cb(long start_a, long count_a,
+			   long start_b, long count_b, void *data)
+{
+	struct handle_split_cb_data *d = data;
+	handle_split(d->sb, d->ent, d->tlno, d->plno, start_b, d->parent,
+		     d->split);
+	d->plno = start_a + count_a;
+	d->tlno = start_b + count_b;
+	return 0;
+}
+
+/*
+ * Find the lines from parent that are the same as ent so that
+ * we can pass blames to it.  file_p has the blob contents for
+ * the parent.
+ */
+static void find_copy_in_blob(struct blame_scoreboard *sb,
+			      struct blame_entry *ent,
+			      struct blame_origin *parent,
+			      struct blame_entry *split,
+			      mmfile_t *file_p)
+{
+	const char *cp;
+	mmfile_t file_o;
+	struct handle_split_cb_data d;
+
+	memset(&d, 0, sizeof(d));
+	d.sb = sb; d.ent = ent; d.parent = parent; d.split = split;
+	/*
+	 * Prepare mmfile that contains only the lines in ent.
+	 */
+	cp = blame_nth_line(sb, ent->lno);
+	file_o.ptr = (char *) cp;
+	file_o.size = blame_nth_line(sb, ent->lno + ent->num_lines) - cp;
+
+	/*
+	 * file_o is a part of final image we are annotating.
+	 * file_p partially may match that image.
+	 */
+	memset(split, 0, sizeof(struct blame_entry [3]));
+	if (diff_hunks(file_p, &file_o, handle_split_cb, &d, sb->xdl_opts))
+		die("unable to generate diff (%s)",
+		    oid_to_hex(&parent->commit->object.oid));
+	/* remainder, if any, all match the preimage */
+	handle_split(sb, ent, d.tlno, d.plno, ent->num_lines, parent, split);
+}
+
+/* Move all blame entries from list *source that have a score smaller
+ * than score_min to the front of list *small.
+ * Returns a pointer to the link pointing to the old head of the small list.
+ */
+
+static struct blame_entry **filter_small(struct blame_scoreboard *sb,
+					 struct blame_entry **small,
+					 struct blame_entry **source,
+					 unsigned score_min)
+{
+	struct blame_entry *p = *source;
+	struct blame_entry *oldsmall = *small;
+	while (p) {
+		if (blame_entry_score(sb, p) <= score_min) {
+			*small = p;
+			small = &p->next;
+			p = *small;
+		} else {
+			*source = p;
+			source = &p->next;
+			p = *source;
+		}
+	}
+	*small = oldsmall;
+	*source = NULL;
+	return small;
+}
+
+/*
+ * See if lines currently target is suspected for can be attributed to
+ * parent.
+ */
+static void find_move_in_parent(struct blame_scoreboard *sb,
+				struct blame_entry ***blamed,
+				struct blame_entry **toosmall,
+				struct blame_origin *target,
+				struct blame_origin *parent)
+{
+	struct blame_entry *e, split[3];
+	struct blame_entry *unblamed = target->suspects;
+	struct blame_entry *leftover = NULL;
+	mmfile_t file_p;
+
+	if (!unblamed)
+		return; /* nothing remains for this target */
+
+	fill_origin_blob(&sb->revs->diffopt, parent, &file_p, &sb->num_read_blob);
+	if (!file_p.ptr)
+		return;
+
+	/* At each iteration, unblamed has a NULL-terminated list of
+	 * entries that have not yet been tested for blame.  leftover
+	 * contains the reversed list of entries that have been tested
+	 * without being assignable to the parent.
+	 */
+	do {
+		struct blame_entry **unblamedtail = &unblamed;
+		struct blame_entry *next;
+		for (e = unblamed; e; e = next) {
+			next = e->next;
+			find_copy_in_blob(sb, e, parent, split, &file_p);
+			if (split[1].suspect &&
+			    sb->move_score < blame_entry_score(sb, &split[1])) {
+				split_blame(blamed, &unblamedtail, split, e);
+			} else {
+				e->next = leftover;
+				leftover = e;
+			}
+			decref_split(split);
+		}
+		*unblamedtail = NULL;
+		toosmall = filter_small(sb, toosmall, &unblamed, sb->move_score);
+	} while (unblamed);
+	target->suspects = reverse_blame(leftover, NULL);
+}
+
+struct blame_list {
+	struct blame_entry *ent;
+	struct blame_entry split[3];
+};
+
+/*
+ * Count the number of entries the target is suspected for,
+ * and prepare a list of entry and the best split.
+ */
+static struct blame_list *setup_blame_list(struct blame_entry *unblamed,
+					   int *num_ents_p)
+{
+	struct blame_entry *e;
+	int num_ents, i;
+	struct blame_list *blame_list = NULL;
+
+	for (e = unblamed, num_ents = 0; e; e = e->next)
+		num_ents++;
+	if (num_ents) {
+		blame_list = xcalloc(num_ents, sizeof(struct blame_list));
+		for (e = unblamed, i = 0; e; e = e->next)
+			blame_list[i++].ent = e;
+	}
+	*num_ents_p = num_ents;
+	return blame_list;
+}
+
+/*
+ * For lines target is suspected for, see if we can find code movement
+ * across file boundary from the parent commit.  porigin is the path
+ * in the parent we already tried.
+ */
+static void find_copy_in_parent(struct blame_scoreboard *sb,
+				struct blame_entry ***blamed,
+				struct blame_entry **toosmall,
+				struct blame_origin *target,
+				struct commit *parent,
+				struct blame_origin *porigin,
+				int opt)
+{
+	struct diff_options diff_opts;
+	int i, j;
+	struct blame_list *blame_list;
+	int num_ents;
+	struct blame_entry *unblamed = target->suspects;
+	struct blame_entry *leftover = NULL;
+
+	if (!unblamed)
+		return; /* nothing remains for this target */
+
+	diff_setup(&diff_opts);
+	DIFF_OPT_SET(&diff_opts, RECURSIVE);
+	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
+
+	diff_setup_done(&diff_opts);
+
+	/* Try "find copies harder" on new path if requested;
+	 * we do not want to use diffcore_rename() actually to
+	 * match things up; find_copies_harder is set only to
+	 * force diff_tree_sha1() to feed all filepairs to diff_queue,
+	 * and this code needs to be after diff_setup_done(), which
+	 * usually makes find-copies-harder imply copy detection.
+	 */
+	if ((opt & PICKAXE_BLAME_COPY_HARDEST)
+	    || ((opt & PICKAXE_BLAME_COPY_HARDER)
+		&& (!porigin || strcmp(target->path, porigin->path))))
+		DIFF_OPT_SET(&diff_opts, FIND_COPIES_HARDER);
+
+	if (is_null_oid(&target->commit->object.oid))
+		do_diff_cache(parent->tree->object.oid.hash, &diff_opts);
+	else
+		diff_tree_sha1(parent->tree->object.oid.hash,
+			       target->commit->tree->object.oid.hash,
+			       "", &diff_opts);
+
+	if (!DIFF_OPT_TST(&diff_opts, FIND_COPIES_HARDER))
+		diffcore_std(&diff_opts);
+
+	do {
+		struct blame_entry **unblamedtail = &unblamed;
+		blame_list = setup_blame_list(unblamed, &num_ents);
+
+		for (i = 0; i < diff_queued_diff.nr; i++) {
+			struct diff_filepair *p = diff_queued_diff.queue[i];
+			struct blame_origin *norigin;
+			mmfile_t file_p;
+			struct blame_entry this[3];
+
+			if (!DIFF_FILE_VALID(p->one))
+				continue; /* does not exist in parent */
+			if (S_ISGITLINK(p->one->mode))
+				continue; /* ignore git links */
+			if (porigin && !strcmp(p->one->path, porigin->path))
+				/* find_move already dealt with this path */
+				continue;
+
+			norigin = get_origin(parent, p->one->path);
+			oidcpy(&norigin->blob_oid, &p->one->oid);
+			norigin->mode = p->one->mode;
+			fill_origin_blob(&sb->revs->diffopt, norigin, &file_p, &sb->num_read_blob);
+			if (!file_p.ptr)
+				continue;
+
+			for (j = 0; j < num_ents; j++) {
+				find_copy_in_blob(sb, blame_list[j].ent,
+						  norigin, this, &file_p);
+				copy_split_if_better(sb, blame_list[j].split,
+						     this);
+				decref_split(this);
+			}
+			blame_origin_decref(norigin);
+		}
+
+		for (j = 0; j < num_ents; j++) {
+			struct blame_entry *split = blame_list[j].split;
+			if (split[1].suspect &&
+			    sb->copy_score < blame_entry_score(sb, &split[1])) {
+				split_blame(blamed, &unblamedtail, split,
+					    blame_list[j].ent);
+			} else {
+				blame_list[j].ent->next = leftover;
+				leftover = blame_list[j].ent;
+			}
+			decref_split(split);
+		}
+		free(blame_list);
+		*unblamedtail = NULL;
+		toosmall = filter_small(sb, toosmall, &unblamed, sb->copy_score);
+	} while (unblamed);
+	target->suspects = reverse_blame(leftover, NULL);
+	diff_flush(&diff_opts);
+	clear_pathspec(&diff_opts.pathspec);
+}
+
+/*
+ * The blobs of origin and porigin exactly match, so everything
+ * origin is suspected for can be blamed on the parent.
+ */
+static void pass_whole_blame(struct blame_scoreboard *sb,
+			     struct blame_origin *origin, struct blame_origin *porigin)
+{
+	struct blame_entry *e, *suspects;
+
+	if (!porigin->file.ptr && origin->file.ptr) {
+		/* Steal its file */
+		porigin->file = origin->file;
+		origin->file.ptr = NULL;
+	}
+	suspects = origin->suspects;
+	origin->suspects = NULL;
+	for (e = suspects; e; e = e->next) {
+		blame_origin_incref(porigin);
+		blame_origin_decref(e->suspect);
+		e->suspect = porigin;
+	}
+	queue_blames(sb, porigin, suspects);
+}
+
+/*
+ * We pass blame from the current commit to its parents.  We keep saying
+ * "parent" (and "porigin"), but what we mean is to find scapegoat to
+ * exonerate ourselves.
+ */
+static struct commit_list *first_scapegoat(struct rev_info *revs, struct commit *commit,
+					int reverse)
+{
+	if (!reverse) {
+		if (revs->first_parent_only &&
+		    commit->parents &&
+		    commit->parents->next) {
+			free_commit_list(commit->parents->next);
+			commit->parents->next = NULL;
+		}
+		return commit->parents;
+	}
+	return lookup_decoration(&revs->children, &commit->object);
+}
+
+static int num_scapegoats(struct rev_info *revs, struct commit *commit, int reverse)
+{
+	struct commit_list *l = first_scapegoat(revs, commit, reverse);
+	return commit_list_count(l);
+}
+
+/* Distribute collected unsorted blames to the respected sorted lists
+ * in the various origins.
+ */
+static void distribute_blame(struct blame_scoreboard *sb, struct blame_entry *blamed)
+{
+	blamed = llist_mergesort(blamed, get_next_blame, set_next_blame,
+				 compare_blame_suspect);
+	while (blamed)
+	{
+		struct blame_origin *porigin = blamed->suspect;
+		struct blame_entry *suspects = NULL;
+		do {
+			struct blame_entry *next = blamed->next;
+			blamed->next = suspects;
+			suspects = blamed;
+			blamed = next;
+		} while (blamed && blamed->suspect == porigin);
+		suspects = reverse_blame(suspects, NULL);
+		queue_blames(sb, porigin, suspects);
+	}
+}
+
+#define MAXSG 16
+
+static void pass_blame(struct blame_scoreboard *sb, struct blame_origin *origin, int opt)
+{
+	struct rev_info *revs = sb->revs;
+	int i, pass, num_sg;
+	struct commit *commit = origin->commit;
+	struct commit_list *sg;
+	struct blame_origin *sg_buf[MAXSG];
+	struct blame_origin *porigin, **sg_origin = sg_buf;
+	struct blame_entry *toosmall = NULL;
+	struct blame_entry *blames, **blametail = &blames;
+
+	num_sg = num_scapegoats(revs, commit, sb->reverse);
+	if (!num_sg)
+		goto finish;
+	else if (num_sg < ARRAY_SIZE(sg_buf))
+		memset(sg_buf, 0, sizeof(sg_buf));
+	else
+		sg_origin = xcalloc(num_sg, sizeof(*sg_origin));
+
+	/*
+	 * The first pass looks for unrenamed path to optimize for
+	 * common cases, then we look for renames in the second pass.
+	 */
+	for (pass = 0; pass < 2 - sb->no_whole_file_rename; pass++) {
+		struct blame_origin *(*find)(struct commit *, struct blame_origin *);
+		find = pass ? find_rename : find_origin;
+
+		for (i = 0, sg = first_scapegoat(revs, commit, sb->reverse);
+		     i < num_sg && sg;
+		     sg = sg->next, i++) {
+			struct commit *p = sg->item;
+			int j, same;
+
+			if (sg_origin[i])
+				continue;
+			if (parse_commit(p))
+				continue;
+			porigin = find(p, origin);
+			if (!porigin)
+				continue;
+			if (!oidcmp(&porigin->blob_oid, &origin->blob_oid)) {
+				pass_whole_blame(sb, origin, porigin);
+				blame_origin_decref(porigin);
+				goto finish;
+			}
+			for (j = same = 0; j < i; j++)
+				if (sg_origin[j] &&
+				    !oidcmp(&sg_origin[j]->blob_oid, &porigin->blob_oid)) {
+					same = 1;
+					break;
+				}
+			if (!same)
+				sg_origin[i] = porigin;
+			else
+				blame_origin_decref(porigin);
+		}
+	}
+
+	sb->num_commits++;
+	for (i = 0, sg = first_scapegoat(revs, commit, sb->reverse);
+	     i < num_sg && sg;
+	     sg = sg->next, i++) {
+		struct blame_origin *porigin = sg_origin[i];
+		if (!porigin)
+			continue;
+		if (!origin->previous) {
+			blame_origin_incref(porigin);
+			origin->previous = porigin;
+		}
+		pass_blame_to_parent(sb, origin, porigin);
+		if (!origin->suspects)
+			goto finish;
+	}
+
+	/*
+	 * Optionally find moves in parents' files.
+	 */
+	if (opt & PICKAXE_BLAME_MOVE) {
+		filter_small(sb, &toosmall, &origin->suspects, sb->move_score);
+		if (origin->suspects) {
+			for (i = 0, sg = first_scapegoat(revs, commit, sb->reverse);
+			     i < num_sg && sg;
+			     sg = sg->next, i++) {
+				struct blame_origin *porigin = sg_origin[i];
+				if (!porigin)
+					continue;
+				find_move_in_parent(sb, &blametail, &toosmall, origin, porigin);
+				if (!origin->suspects)
+					break;
+			}
+		}
+	}
+
+	/*
+	 * Optionally find copies from parents' files.
+	 */
+	if (opt & PICKAXE_BLAME_COPY) {
+		if (sb->copy_score > sb->move_score)
+			filter_small(sb, &toosmall, &origin->suspects, sb->copy_score);
+		else if (sb->copy_score < sb->move_score) {
+			origin->suspects = blame_merge(origin->suspects, toosmall);
+			toosmall = NULL;
+			filter_small(sb, &toosmall, &origin->suspects, sb->copy_score);
+		}
+		if (!origin->suspects)
+			goto finish;
+
+		for (i = 0, sg = first_scapegoat(revs, commit, sb->reverse);
+		     i < num_sg && sg;
+		     sg = sg->next, i++) {
+			struct blame_origin *porigin = sg_origin[i];
+			find_copy_in_parent(sb, &blametail, &toosmall,
+					    origin, sg->item, porigin, opt);
+			if (!origin->suspects)
+				goto finish;
+		}
+	}
+
+finish:
+	*blametail = NULL;
+	distribute_blame(sb, blames);
+	/*
+	 * prepend toosmall to origin->suspects
+	 *
+	 * There is no point in sorting: this ends up on a big
+	 * unsorted list in the caller anyway.
+	 */
+	if (toosmall) {
+		struct blame_entry **tail = &toosmall;
+		while (*tail)
+			tail = &(*tail)->next;
+		*tail = origin->suspects;
+		origin->suspects = toosmall;
+	}
+	for (i = 0; i < num_sg; i++) {
+		if (sg_origin[i]) {
+			drop_origin_blob(sg_origin[i]);
+			blame_origin_decref(sg_origin[i]);
+		}
+	}
+	drop_origin_blob(origin);
+	if (sg_buf != sg_origin)
+		free(sg_origin);
+}
+
+/*
+ * The main loop -- while we have blobs with lines whose true origin
+ * is still unknown, pick one blob, and allow its lines to pass blames
+ * to its parents. */
+void assign_blame(struct blame_scoreboard *sb, int opt)
+{
+	struct rev_info *revs = sb->revs;
+	struct commit *commit = prio_queue_get(&sb->commits);
+
+	while (commit) {
+		struct blame_entry *ent;
+		struct blame_origin *suspect = commit->util;
+
+		/* find one suspect to break down */
+		while (suspect && !suspect->suspects)
+			suspect = suspect->next;
+
+		if (!suspect) {
+			commit = prio_queue_get(&sb->commits);
+			continue;
+		}
+
+		assert(commit == suspect->commit);
+
+		/*
+		 * We will use this suspect later in the loop,
+		 * so hold onto it in the meantime.
+		 */
+		blame_origin_incref(suspect);
+		parse_commit(commit);
+		if (sb->reverse ||
+		    (!(commit->object.flags & UNINTERESTING) &&
+		     !(revs->max_age != -1 && commit->date < revs->max_age)))
+			pass_blame(sb, suspect, opt);
+		else {
+			commit->object.flags |= UNINTERESTING;
+			if (commit->object.parsed)
+				mark_parents_uninteresting(commit);
+		}
+		/* treat root commit as boundary */
+		if (!commit->parents && !sb->show_root)
+			commit->object.flags |= UNINTERESTING;
+
+		/* Take responsibility for the remaining entries */
+		ent = suspect->suspects;
+		if (ent) {
+			suspect->guilty = 1;
+			for (;;) {
+				struct blame_entry *next = ent->next;
+				if (sb->found_guilty_entry)
+					sb->found_guilty_entry(ent, sb->found_guilty_entry_data);
+				if (next) {
+					ent = next;
+					continue;
+				}
+				ent->next = sb->ent;
+				sb->ent = suspect->suspects;
+				suspect->suspects = NULL;
+				break;
+			}
+		}
+		blame_origin_decref(suspect);
+
+		if (sb->debug) /* sanity */
+			sanity_check_refcnt(sb);
+	}
+}
diff --git a/blame.h b/blame.h
index f831dec..a3ea677 100644
--- a/blame.h
+++ b/blame.h
@@ -8,6 +8,11 @@
 #include "prio-queue.h"
 #include "diff.h"
 
+#define PICKAXE_BLAME_MOVE		01
+#define PICKAXE_BLAME_COPY		02
+#define PICKAXE_BLAME_COPY_HARDER	04
+#define PICKAXE_BLAME_COPY_HARDEST	010
+
 #define BLAME_DEFAULT_MOVE_SCORE	20
 #define BLAME_DEFAULT_COPY_SCORE	40
 
@@ -160,4 +165,10 @@ extern struct blame_origin *get_origin(struct commit *commit, const char *path);
 
 extern struct commit *fake_working_tree_commit(struct diff_options *opt, const char *path, const char *contents_from);
 
+extern void blame_coalesce(struct blame_scoreboard *sb);
+extern void blame_sort_final(struct blame_scoreboard *sb);
+extern unsigned blame_entry_score(struct blame_scoreboard *sb, struct blame_entry *e);
+extern void assign_blame(struct blame_scoreboard *sb, int opt);
+extern const char *blame_nth_line(struct blame_scoreboard *sb, long lno);
+
 #endif /* BLAME_H */
diff --git a/builtin/blame.c b/builtin/blame.c
index 33ede4f..207a74d 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -12,13 +12,10 @@
 #include "tag.h"
 #include "tree-walk.h"
 #include "diff.h"
-#include "diffcore.h"
 #include "revision.h"
 #include "quote.h"
-#include "xdiff-interface.h"
 #include "string-list.h"
 #include "mailmap.h"
-#include "mergesort.h"
 #include "parse-options.h"
 #include "prio-queue.h"
 #include "utf8.h"
@@ -61,11 +58,6 @@ static struct string_list mailmap = STRING_LIST_INIT_NODUP;
 #define DEBUG 0
 #endif
 
-#define PICKAXE_BLAME_MOVE		01
-#define PICKAXE_BLAME_COPY		02
-#define PICKAXE_BLAME_COPY_HARDER	04
-#define PICKAXE_BLAME_COPY_HARDEST	010
-
 static unsigned blame_move_score;
 static unsigned blame_copy_score;
 
@@ -78,143 +70,6 @@ struct progress_info {
 	int blamed_lines;
 };
 
-static int diff_hunks(mmfile_t *file_a, mmfile_t *file_b,
-		      xdl_emit_hunk_consume_func_t hunk_func, void *cb_data, int xdl_opts)
-{
-	xpparam_t xpp = {0};
-	xdemitconf_t xecfg = {0};
-	xdemitcb_t ecb = {NULL};
-
-	xpp.flags = xdl_opts;
-	xecfg.hunk_func = hunk_func;
-	ecb.priv = cb_data;
-	return xdi_diff(file_a, file_b, &xpp, &xecfg, &ecb);
-}
-
-/*
- * Given an origin, prepare mmfile_t structure to be used by the
- * diff machinery
- */
-static void fill_origin_blob(struct diff_options *opt,
-			     struct blame_origin *o, mmfile_t *file, int *num_read_blob)
-{
-	if (!o->file.ptr) {
-		enum object_type type;
-		unsigned long file_size;
-
-		(*num_read_blob)++;
-		if (DIFF_OPT_TST(opt, ALLOW_TEXTCONV) &&
-		    textconv_object(o->path, o->mode, &o->blob_oid, 1, &file->ptr, &file_size))
-			;
-		else
-			file->ptr = read_sha1_file(o->blob_oid.hash, &type,
-						   &file_size);
-		file->size = file_size;
-
-		if (!file->ptr)
-			die("Cannot read blob %s for path %s",
-			    oid_to_hex(&o->blob_oid),
-			    o->path);
-		o->file = *file;
-	}
-	else
-		*file = o->file;
-}
-
-static void drop_origin_blob(struct blame_origin *o)
-{
-	if (o->file.ptr) {
-		free(o->file.ptr);
-		o->file.ptr = NULL;
-	}
-}
-
-/*
- * Any merge of blames happens on lists of blames that arrived via
- * different parents in a single suspect.  In this case, we want to
- * sort according to the suspect line numbers as opposed to the final
- * image line numbers.  The function body is somewhat longish because
- * it avoids unnecessary writes.
- */
-
-static struct blame_entry *blame_merge(struct blame_entry *list1,
-				       struct blame_entry *list2)
-{
-	struct blame_entry *p1 = list1, *p2 = list2,
-		**tail = &list1;
-
-	if (!p1)
-		return p2;
-	if (!p2)
-		return p1;
-
-	if (p1->s_lno <= p2->s_lno) {
-		do {
-			tail = &p1->next;
-			if ((p1 = *tail) == NULL) {
-				*tail = p2;
-				return list1;
-			}
-		} while (p1->s_lno <= p2->s_lno);
-	}
-	for (;;) {
-		*tail = p2;
-		do {
-			tail = &p2->next;
-			if ((p2 = *tail) == NULL)  {
-				*tail = p1;
-				return list1;
-			}
-		} while (p1->s_lno > p2->s_lno);
-		*tail = p1;
-		do {
-			tail = &p1->next;
-			if ((p1 = *tail) == NULL) {
-				*tail = p2;
-				return list1;
-			}
-		} while (p1->s_lno <= p2->s_lno);
-	}
-}
-
-static void *get_next_blame(const void *p)
-{
-	return ((struct blame_entry *)p)->next;
-}
-
-static void set_next_blame(void *p1, void *p2)
-{
-	((struct blame_entry *)p1)->next = p2;
-}
-
-/*
- * Final image line numbers are all different, so we don't need a
- * three-way comparison here.
- */
-
-static int compare_blame_final(const void *p1, const void *p2)
-{
-	return ((struct blame_entry *)p1)->lno > ((struct blame_entry *)p2)->lno
-		? 1 : -1;
-}
-
-static int compare_blame_suspect(const void *p1, const void *p2)
-{
-	const struct blame_entry *s1 = p1, *s2 = p2;
-	/*
-	 * to allow for collating suspects, we sort according to the
-	 * respective pointer value as the primary sorting criterion.
-	 * The actual relation is pretty unimportant as long as it
-	 * establishes a total order.  Comparing as integers gives us
-	 * that.
-	 */
-	if (s1->suspect != s2->suspect)
-		return (intptr_t)s1->suspect > (intptr_t)s2->suspect ? 1 : -1;
-	if (s1->s_lno == s2->s_lno)
-		return 0;
-	return s1->s_lno > s2->s_lno ? 1 : -1;
-}
-
 static int compare_commits_by_reverse_commit_date(const void *a,
 						  const void *b,
 						  void *c)
@@ -222,63 +77,6 @@ static int compare_commits_by_reverse_commit_date(const void *a,
 	return -compare_commits_by_commit_date(a, b, c);
 }
 
-static void blame_sort_final(struct blame_scoreboard *sb)
-{
-	sb->ent = llist_mergesort(sb->ent, get_next_blame, set_next_blame,
-				  compare_blame_final);
-}
-
-static void sanity_check_refcnt(struct blame_scoreboard *);
-
-/*
- * If two blame entries that are next to each other came from
- * contiguous lines in the same origin (i.e. <commit, path> pair),
- * merge them together.
- */
-static void coalesce(struct blame_scoreboard *sb)
-{
-	struct blame_entry *ent, *next;
-
-	for (ent = sb->ent; ent && (next = ent->next); ent = next) {
-		if (ent->suspect == next->suspect &&
-		    ent->s_lno + ent->num_lines == next->s_lno) {
-			ent->num_lines += next->num_lines;
-			ent->next = next->next;
-			blame_origin_decref(next->suspect);
-			free(next);
-			ent->score = 0;
-			next = ent; /* again */
-		}
-	}
-
-	if (sb->debug) /* sanity */
-		sanity_check_refcnt(sb);
-}
-
-/*
- * Merge the given sorted list of blames into a preexisting origin.
- * If there were no previous blames to that commit, it is entered into
- * the commit priority queue of the score board.
- */
-
-static void queue_blames(struct blame_scoreboard *sb, struct blame_origin *porigin,
-			 struct blame_entry *sorted)
-{
-	if (porigin->suspects)
-		porigin->suspects = blame_merge(porigin->suspects, sorted);
-	else {
-		struct blame_origin *o;
-		for (o = porigin->commit->util; o; o = o->next) {
-			if (o->suspects) {
-				porigin->suspects = sorted;
-				return;
-			}
-		}
-		porigin->suspects = sorted;
-		prio_queue_put(&sb->commits, porigin->commit);
-	}
-}
-
 /*
  * Fill the blob_sha1 field of an origin if it hasn't, so that later
  * call to fill_origin_blob() can use it to locate the data.  blob_sha1
@@ -305,1034 +103,9 @@ static int fill_blob_sha1_and_mode(struct blame_origin *origin)
 	return -1;
 }
 
-/*
- * We have an origin -- check if the same path exists in the
- * parent and return an origin structure to represent it.
- */
-static struct blame_origin *find_origin(struct commit *parent,
-				  struct blame_origin *origin)
-{
-	struct blame_origin *porigin;
-	struct diff_options diff_opts;
-	const char *paths[2];
-
-	/* First check any existing origins */
-	for (porigin = parent->util; porigin; porigin = porigin->next)
-		if (!strcmp(porigin->path, origin->path)) {
-			/*
-			 * The same path between origin and its parent
-			 * without renaming -- the most common case.
-			 */
-			return blame_origin_incref (porigin);
-		}
-
-	/* See if the origin->path is different between parent
-	 * and origin first.  Most of the time they are the
-	 * same and diff-tree is fairly efficient about this.
-	 */
-	diff_setup(&diff_opts);
-	DIFF_OPT_SET(&diff_opts, RECURSIVE);
-	diff_opts.detect_rename = 0;
-	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
-	paths[0] = origin->path;
-	paths[1] = NULL;
-
-	parse_pathspec(&diff_opts.pathspec,
-		       PATHSPEC_ALL_MAGIC & ~PATHSPEC_LITERAL,
-		       PATHSPEC_LITERAL_PATH, "", paths);
-	diff_setup_done(&diff_opts);
-
-	if (is_null_oid(&origin->commit->object.oid))
-		do_diff_cache(parent->tree->object.oid.hash, &diff_opts);
-	else
-		diff_tree_sha1(parent->tree->object.oid.hash,
-			       origin->commit->tree->object.oid.hash,
-			       "", &diff_opts);
-	diffcore_std(&diff_opts);
-
-	if (!diff_queued_diff.nr) {
-		/* The path is the same as parent */
-		porigin = get_origin(parent, origin->path);
-		oidcpy(&porigin->blob_oid, &origin->blob_oid);
-		porigin->mode = origin->mode;
-	} else {
-		/*
-		 * Since origin->path is a pathspec, if the parent
-		 * commit had it as a directory, we will see a whole
-		 * bunch of deletion of files in the directory that we
-		 * do not care about.
-		 */
-		int i;
-		struct diff_filepair *p = NULL;
-		for (i = 0; i < diff_queued_diff.nr; i++) {
-			const char *name;
-			p = diff_queued_diff.queue[i];
-			name = p->one->path ? p->one->path : p->two->path;
-			if (!strcmp(name, origin->path))
-				break;
-		}
-		if (!p)
-			die("internal error in blame::find_origin");
-		switch (p->status) {
-		default:
-			die("internal error in blame::find_origin (%c)",
-			    p->status);
-		case 'M':
-			porigin = get_origin(parent, origin->path);
-			oidcpy(&porigin->blob_oid, &p->one->oid);
-			porigin->mode = p->one->mode;
-			break;
-		case 'A':
-		case 'T':
-			/* Did not exist in parent, or type changed */
-			break;
-		}
-	}
-	diff_flush(&diff_opts);
-	clear_pathspec(&diff_opts.pathspec);
-	return porigin;
-}
-
-/*
- * We have an origin -- find the path that corresponds to it in its
- * parent and return an origin structure to represent it.
- */
-static struct blame_origin *find_rename(struct commit *parent,
-				  struct blame_origin *origin)
-{
-	struct blame_origin *porigin = NULL;
-	struct diff_options diff_opts;
-	int i;
-
-	diff_setup(&diff_opts);
-	DIFF_OPT_SET(&diff_opts, RECURSIVE);
-	diff_opts.detect_rename = DIFF_DETECT_RENAME;
-	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
-	diff_opts.single_follow = origin->path;
-	diff_setup_done(&diff_opts);
-
-	if (is_null_oid(&origin->commit->object.oid))
-		do_diff_cache(parent->tree->object.oid.hash, &diff_opts);
-	else
-		diff_tree_sha1(parent->tree->object.oid.hash,
-			       origin->commit->tree->object.oid.hash,
-			       "", &diff_opts);
-	diffcore_std(&diff_opts);
-
-	for (i = 0; i < diff_queued_diff.nr; i++) {
-		struct diff_filepair *p = diff_queued_diff.queue[i];
-		if ((p->status == 'R' || p->status == 'C') &&
-		    !strcmp(p->two->path, origin->path)) {
-			porigin = get_origin(parent, p->one->path);
-			oidcpy(&porigin->blob_oid, &p->one->oid);
-			porigin->mode = p->one->mode;
-			break;
-		}
-	}
-	diff_flush(&diff_opts);
-	clear_pathspec(&diff_opts.pathspec);
-	return porigin;
-}
-
-/*
- * Append a new blame entry to a given output queue.
- */
-static void add_blame_entry(struct blame_entry ***queue,
-			    const struct blame_entry *src)
-{
-	struct blame_entry *e = xmalloc(sizeof(*e));
-	memcpy(e, src, sizeof(*e));
-	blame_origin_incref(e->suspect);
-
-	e->next = **queue;
-	**queue = e;
-	*queue = &e->next;
-}
-
-/*
- * src typically is on-stack; we want to copy the information in it to
- * a malloced blame_entry that gets added to the given queue.  The
- * origin of dst loses a refcnt.
- */
-static void dup_entry(struct blame_entry ***queue,
-		      struct blame_entry *dst, struct blame_entry *src)
-{
-	blame_origin_incref(src->suspect);
-	blame_origin_decref(dst->suspect);
-	memcpy(dst, src, sizeof(*src));
-	dst->next = **queue;
-	**queue = dst;
-	*queue = &dst->next;
-}
-
-static const char *nth_line(struct blame_scoreboard *sb, long lno)
-{
-	return sb->final_buf + sb->lineno[lno];
-}
-
 static const char *nth_line_cb(void *data, long lno)
 {
-	return nth_line((struct blame_scoreboard *)data, lno);
-}
-
-/*
- * It is known that lines between tlno to same came from parent, and e
- * has an overlap with that range.  it also is known that parent's
- * line plno corresponds to e's line tlno.
- *
- *                <---- e ----->
- *                   <------>
- *                   <------------>
- *             <------------>
- *             <------------------>
- *
- * Split e into potentially three parts; before this chunk, the chunk
- * to be blamed for the parent, and after that portion.
- */
-static void split_overlap(struct blame_entry *split,
-			  struct blame_entry *e,
-			  int tlno, int plno, int same,
-			  struct blame_origin *parent)
-{
-	int chunk_end_lno;
-	memset(split, 0, sizeof(struct blame_entry [3]));
-
-	if (e->s_lno < tlno) {
-		/* there is a pre-chunk part not blamed on parent */
-		split[0].suspect = blame_origin_incref(e->suspect);
-		split[0].lno = e->lno;
-		split[0].s_lno = e->s_lno;
-		split[0].num_lines = tlno - e->s_lno;
-		split[1].lno = e->lno + tlno - e->s_lno;
-		split[1].s_lno = plno;
-	}
-	else {
-		split[1].lno = e->lno;
-		split[1].s_lno = plno + (e->s_lno - tlno);
-	}
-
-	if (same < e->s_lno + e->num_lines) {
-		/* there is a post-chunk part not blamed on parent */
-		split[2].suspect = blame_origin_incref(e->suspect);
-		split[2].lno = e->lno + (same - e->s_lno);
-		split[2].s_lno = e->s_lno + (same - e->s_lno);
-		split[2].num_lines = e->s_lno + e->num_lines - same;
-		chunk_end_lno = split[2].lno;
-	}
-	else
-		chunk_end_lno = e->lno + e->num_lines;
-	split[1].num_lines = chunk_end_lno - split[1].lno;
-
-	/*
-	 * if it turns out there is nothing to blame the parent for,
-	 * forget about the splitting.  !split[1].suspect signals this.
-	 */
-	if (split[1].num_lines < 1)
-		return;
-	split[1].suspect = blame_origin_incref(parent);
-}
-
-/*
- * split_overlap() divided an existing blame e into up to three parts
- * in split.  Any assigned blame is moved to queue to
- * reflect the split.
- */
-static void split_blame(struct blame_entry ***blamed,
-			struct blame_entry ***unblamed,
-			struct blame_entry *split,
-			struct blame_entry *e)
-{
-	if (split[0].suspect && split[2].suspect) {
-		/* The first part (reuse storage for the existing entry e) */
-		dup_entry(unblamed, e, &split[0]);
-
-		/* The last part -- me */
-		add_blame_entry(unblamed, &split[2]);
-
-		/* ... and the middle part -- parent */
-		add_blame_entry(blamed, &split[1]);
-	}
-	else if (!split[0].suspect && !split[2].suspect)
-		/*
-		 * The parent covers the entire area; reuse storage for
-		 * e and replace it with the parent.
-		 */
-		dup_entry(blamed, e, &split[1]);
-	else if (split[0].suspect) {
-		/* me and then parent */
-		dup_entry(unblamed, e, &split[0]);
-		add_blame_entry(blamed, &split[1]);
-	}
-	else {
-		/* parent and then me */
-		dup_entry(blamed, e, &split[1]);
-		add_blame_entry(unblamed, &split[2]);
-	}
-}
-
-/*
- * After splitting the blame, the origins used by the
- * on-stack blame_entry should lose one refcnt each.
- */
-static void decref_split(struct blame_entry *split)
-{
-	int i;
-
-	for (i = 0; i < 3; i++)
-		blame_origin_decref(split[i].suspect);
-}
-
-/*
- * reverse_blame reverses the list given in head, appending tail.
- * That allows us to build lists in reverse order, then reverse them
- * afterwards.  This can be faster than building the list in proper
- * order right away.  The reason is that building in proper order
- * requires writing a link in the _previous_ element, while building
- * in reverse order just requires placing the list head into the
- * _current_ element.
- */
-
-static struct blame_entry *reverse_blame(struct blame_entry *head,
-					 struct blame_entry *tail)
-{
-	while (head) {
-		struct blame_entry *next = head->next;
-		head->next = tail;
-		tail = head;
-		head = next;
-	}
-	return tail;
-}
-
-/*
- * Process one hunk from the patch between the current suspect for
- * blame_entry e and its parent.  This first blames any unfinished
- * entries before the chunk (which is where target and parent start
- * differing) on the parent, and then splits blame entries at the
- * start and at the end of the difference region.  Since use of -M and
- * -C options may lead to overlapping/duplicate source line number
- * ranges, all we can rely on from sorting/merging is the order of the
- * first suspect line number.
- */
-static void blame_chunk(struct blame_entry ***dstq, struct blame_entry ***srcq,
-			int tlno, int offset, int same,
-			struct blame_origin *parent)
-{
-	struct blame_entry *e = **srcq;
-	struct blame_entry *samep = NULL, *diffp = NULL;
-
-	while (e && e->s_lno < tlno) {
-		struct blame_entry *next = e->next;
-		/*
-		 * current record starts before differing portion.  If
-		 * it reaches into it, we need to split it up and
-		 * examine the second part separately.
-		 */
-		if (e->s_lno + e->num_lines > tlno) {
-			/* Move second half to a new record */
-			int len = tlno - e->s_lno;
-			struct blame_entry *n = xcalloc(1, sizeof (struct blame_entry));
-			n->suspect = e->suspect;
-			n->lno = e->lno + len;
-			n->s_lno = e->s_lno + len;
-			n->num_lines = e->num_lines - len;
-			e->num_lines = len;
-			e->score = 0;
-			/* Push new record to diffp */
-			n->next = diffp;
-			diffp = n;
-		} else
-			blame_origin_decref(e->suspect);
-		/* Pass blame for everything before the differing
-		 * chunk to the parent */
-		e->suspect = blame_origin_incref(parent);
-		e->s_lno += offset;
-		e->next = samep;
-		samep = e;
-		e = next;
-	}
-	/*
-	 * As we don't know how much of a common stretch after this
-	 * diff will occur, the currently blamed parts are all that we
-	 * can assign to the parent for now.
-	 */
-
-	if (samep) {
-		**dstq = reverse_blame(samep, **dstq);
-		*dstq = &samep->next;
-	}
-	/*
-	 * Prepend the split off portions: everything after e starts
-	 * after the blameable portion.
-	 */
-	e = reverse_blame(diffp, e);
-
-	/*
-	 * Now retain records on the target while parts are different
-	 * from the parent.
-	 */
-	samep = NULL;
-	diffp = NULL;
-	while (e && e->s_lno < same) {
-		struct blame_entry *next = e->next;
-
-		/*
-		 * If current record extends into sameness, need to split.
-		 */
-		if (e->s_lno + e->num_lines > same) {
-			/*
-			 * Move second half to a new record to be
-			 * processed by later chunks
-			 */
-			int len = same - e->s_lno;
-			struct blame_entry *n = xcalloc(1, sizeof (struct blame_entry));
-			n->suspect = blame_origin_incref(e->suspect);
-			n->lno = e->lno + len;
-			n->s_lno = e->s_lno + len;
-			n->num_lines = e->num_lines - len;
-			e->num_lines = len;
-			e->score = 0;
-			/* Push new record to samep */
-			n->next = samep;
-			samep = n;
-		}
-		e->next = diffp;
-		diffp = e;
-		e = next;
-	}
-	**srcq = reverse_blame(diffp, reverse_blame(samep, e));
-	/* Move across elements that are in the unblamable portion */
-	if (diffp)
-		*srcq = &diffp->next;
-}
-
-struct blame_chunk_cb_data {
-	struct blame_origin *parent;
-	long offset;
-	struct blame_entry **dstq;
-	struct blame_entry **srcq;
-};
-
-/* diff chunks are from parent to target */
-static int blame_chunk_cb(long start_a, long count_a,
-			  long start_b, long count_b, void *data)
-{
-	struct blame_chunk_cb_data *d = data;
-	if (start_a - start_b != d->offset)
-		die("internal error in blame::blame_chunk_cb");
-	blame_chunk(&d->dstq, &d->srcq, start_b, start_a - start_b,
-		    start_b + count_b, d->parent);
-	d->offset = start_a + count_a - (start_b + count_b);
-	return 0;
-}
-
-/*
- * We are looking at the origin 'target' and aiming to pass blame
- * for the lines it is suspected to its parent.  Run diff to find
- * which lines came from parent and pass blame for them.
- */
-static void pass_blame_to_parent(struct blame_scoreboard *sb,
-				 struct blame_origin *target,
-				 struct blame_origin *parent)
-{
-	mmfile_t file_p, file_o;
-	struct blame_chunk_cb_data d;
-	struct blame_entry *newdest = NULL;
-
-	if (!target->suspects)
-		return; /* nothing remains for this target */
-
-	d.parent = parent;
-	d.offset = 0;
-	d.dstq = &newdest; d.srcq = &target->suspects;
-
-	fill_origin_blob(&sb->revs->diffopt, parent, &file_p, &sb->num_read_blob);
-	fill_origin_blob(&sb->revs->diffopt, target, &file_o, &sb->num_read_blob);
-	sb->num_get_patch++;
-
-	if (diff_hunks(&file_p, &file_o, blame_chunk_cb, &d, sb->xdl_opts))
-		die("unable to generate diff (%s -> %s)",
-		    oid_to_hex(&parent->commit->object.oid),
-		    oid_to_hex(&target->commit->object.oid));
-	/* The rest are the same as the parent */
-	blame_chunk(&d.dstq, &d.srcq, INT_MAX, d.offset, INT_MAX, parent);
-	*d.dstq = NULL;
-	queue_blames(sb, parent, newdest);
-
-	return;
-}
-
-/*
- * The lines in blame_entry after splitting blames many times can become
- * very small and trivial, and at some point it becomes pointless to
- * blame the parents.  E.g. "\t\t}\n\t}\n\n" appears everywhere in any
- * ordinary C program, and it is not worth to say it was copied from
- * totally unrelated file in the parent.
- *
- * Compute how trivial the lines in the blame_entry are.
- */
-static unsigned ent_score(struct blame_scoreboard *sb, struct blame_entry *e)
-{
-	unsigned score;
-	const char *cp, *ep;
-
-	if (e->score)
-		return e->score;
-
-	score = 1;
-	cp = nth_line(sb, e->lno);
-	ep = nth_line(sb, e->lno + e->num_lines);
-	while (cp < ep) {
-		unsigned ch = *((unsigned char *)cp);
-		if (isalnum(ch))
-			score++;
-		cp++;
-	}
-	e->score = score;
-	return score;
-}
-
-/*
- * best_so_far[] and this[] are both a split of an existing blame_entry
- * that passes blame to the parent.  Maintain best_so_far the best split
- * so far, by comparing this and best_so_far and copying this into
- * bst_so_far as needed.
- */
-static void copy_split_if_better(struct blame_scoreboard *sb,
-				 struct blame_entry *best_so_far,
-				 struct blame_entry *this)
-{
-	int i;
-
-	if (!this[1].suspect)
-		return;
-	if (best_so_far[1].suspect) {
-		if (ent_score(sb, &this[1]) < ent_score(sb, &best_so_far[1]))
-			return;
-	}
-
-	for (i = 0; i < 3; i++)
-		blame_origin_incref(this[i].suspect);
-	decref_split(best_so_far);
-	memcpy(best_so_far, this, sizeof(struct blame_entry [3]));
-}
-
-/*
- * We are looking at a part of the final image represented by
- * ent (tlno and same are offset by ent->s_lno).
- * tlno is where we are looking at in the final image.
- * up to (but not including) same match preimage.
- * plno is where we are looking at in the preimage.
- *
- * <-------------- final image ---------------------->
- *       <------ent------>
- *         ^tlno ^same
- *    <---------preimage----->
- *         ^plno
- *
- * All line numbers are 0-based.
- */
-static void handle_split(struct blame_scoreboard *sb,
-			 struct blame_entry *ent,
-			 int tlno, int plno, int same,
-			 struct blame_origin *parent,
-			 struct blame_entry *split)
-{
-	if (ent->num_lines <= tlno)
-		return;
-	if (tlno < same) {
-		struct blame_entry this[3];
-		tlno += ent->s_lno;
-		same += ent->s_lno;
-		split_overlap(this, ent, tlno, plno, same, parent);
-		copy_split_if_better(sb, split, this);
-		decref_split(this);
-	}
-}
-
-struct handle_split_cb_data {
-	struct blame_scoreboard *sb;
-	struct blame_entry *ent;
-	struct blame_origin *parent;
-	struct blame_entry *split;
-	long plno;
-	long tlno;
-};
-
-static int handle_split_cb(long start_a, long count_a,
-			   long start_b, long count_b, void *data)
-{
-	struct handle_split_cb_data *d = data;
-	handle_split(d->sb, d->ent, d->tlno, d->plno, start_b, d->parent,
-		     d->split);
-	d->plno = start_a + count_a;
-	d->tlno = start_b + count_b;
-	return 0;
-}
-
-/*
- * Find the lines from parent that are the same as ent so that
- * we can pass blames to it.  file_p has the blob contents for
- * the parent.
- */
-static void find_copy_in_blob(struct blame_scoreboard *sb,
-			      struct blame_entry *ent,
-			      struct blame_origin *parent,
-			      struct blame_entry *split,
-			      mmfile_t *file_p)
-{
-	const char *cp;
-	mmfile_t file_o;
-	struct handle_split_cb_data d;
-
-	memset(&d, 0, sizeof(d));
-	d.sb = sb; d.ent = ent; d.parent = parent; d.split = split;
-	/*
-	 * Prepare mmfile that contains only the lines in ent.
-	 */
-	cp = nth_line(sb, ent->lno);
-	file_o.ptr = (char *) cp;
-	file_o.size = nth_line(sb, ent->lno + ent->num_lines) - cp;
-
-	/*
-	 * file_o is a part of final image we are annotating.
-	 * file_p partially may match that image.
-	 */
-	memset(split, 0, sizeof(struct blame_entry [3]));
-	if (diff_hunks(file_p, &file_o, handle_split_cb, &d, sb->xdl_opts))
-		die("unable to generate diff (%s)",
-		    oid_to_hex(&parent->commit->object.oid));
-	/* remainder, if any, all match the preimage */
-	handle_split(sb, ent, d.tlno, d.plno, ent->num_lines, parent, split);
-}
-
-/* Move all blame entries from list *source that have a score smaller
- * than score_min to the front of list *small.
- * Returns a pointer to the link pointing to the old head of the small list.
- */
-
-static struct blame_entry **filter_small(struct blame_scoreboard *sb,
-					 struct blame_entry **small,
-					 struct blame_entry **source,
-					 unsigned score_min)
-{
-	struct blame_entry *p = *source;
-	struct blame_entry *oldsmall = *small;
-	while (p) {
-		if (ent_score(sb, p) <= score_min) {
-			*small = p;
-			small = &p->next;
-			p = *small;
-		} else {
-			*source = p;
-			source = &p->next;
-			p = *source;
-		}
-	}
-	*small = oldsmall;
-	*source = NULL;
-	return small;
-}
-
-/*
- * See if lines currently target is suspected for can be attributed to
- * parent.
- */
-static void find_move_in_parent(struct blame_scoreboard *sb,
-				struct blame_entry ***blamed,
-				struct blame_entry **toosmall,
-				struct blame_origin *target,
-				struct blame_origin *parent)
-{
-	struct blame_entry *e, split[3];
-	struct blame_entry *unblamed = target->suspects;
-	struct blame_entry *leftover = NULL;
-	mmfile_t file_p;
-
-	if (!unblamed)
-		return; /* nothing remains for this target */
-
-	fill_origin_blob(&sb->revs->diffopt, parent, &file_p, &sb->num_read_blob);
-	if (!file_p.ptr)
-		return;
-
-	/* At each iteration, unblamed has a NULL-terminated list of
-	 * entries that have not yet been tested for blame.  leftover
-	 * contains the reversed list of entries that have been tested
-	 * without being assignable to the parent.
-	 */
-	do {
-		struct blame_entry **unblamedtail = &unblamed;
-		struct blame_entry *next;
-		for (e = unblamed; e; e = next) {
-			next = e->next;
-			find_copy_in_blob(sb, e, parent, split, &file_p);
-			if (split[1].suspect &&
-			    sb->move_score < ent_score(sb, &split[1])) {
-				split_blame(blamed, &unblamedtail, split, e);
-			} else {
-				e->next = leftover;
-				leftover = e;
-			}
-			decref_split(split);
-		}
-		*unblamedtail = NULL;
-		toosmall = filter_small(sb, toosmall, &unblamed, sb->move_score);
-	} while (unblamed);
-	target->suspects = reverse_blame(leftover, NULL);
-}
-
-struct blame_list {
-	struct blame_entry *ent;
-	struct blame_entry split[3];
-};
-
-/*
- * Count the number of entries the target is suspected for,
- * and prepare a list of entry and the best split.
- */
-static struct blame_list *setup_blame_list(struct blame_entry *unblamed,
-					   int *num_ents_p)
-{
-	struct blame_entry *e;
-	int num_ents, i;
-	struct blame_list *blame_list = NULL;
-
-	for (e = unblamed, num_ents = 0; e; e = e->next)
-		num_ents++;
-	if (num_ents) {
-		blame_list = xcalloc(num_ents, sizeof(struct blame_list));
-		for (e = unblamed, i = 0; e; e = e->next)
-			blame_list[i++].ent = e;
-	}
-	*num_ents_p = num_ents;
-	return blame_list;
-}
-
-/*
- * For lines target is suspected for, see if we can find code movement
- * across file boundary from the parent commit.  porigin is the path
- * in the parent we already tried.
- */
-static void find_copy_in_parent(struct blame_scoreboard *sb,
-				struct blame_entry ***blamed,
-				struct blame_entry **toosmall,
-				struct blame_origin *target,
-				struct commit *parent,
-				struct blame_origin *porigin,
-				int opt)
-{
-	struct diff_options diff_opts;
-	int i, j;
-	struct blame_list *blame_list;
-	int num_ents;
-	struct blame_entry *unblamed = target->suspects;
-	struct blame_entry *leftover = NULL;
-
-	if (!unblamed)
-		return; /* nothing remains for this target */
-
-	diff_setup(&diff_opts);
-	DIFF_OPT_SET(&diff_opts, RECURSIVE);
-	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
-
-	diff_setup_done(&diff_opts);
-
-	/* Try "find copies harder" on new path if requested;
-	 * we do not want to use diffcore_rename() actually to
-	 * match things up; find_copies_harder is set only to
-	 * force diff_tree_sha1() to feed all filepairs to diff_queue,
-	 * and this code needs to be after diff_setup_done(), which
-	 * usually makes find-copies-harder imply copy detection.
-	 */
-	if ((opt & PICKAXE_BLAME_COPY_HARDEST)
-	    || ((opt & PICKAXE_BLAME_COPY_HARDER)
-		&& (!porigin || strcmp(target->path, porigin->path))))
-		DIFF_OPT_SET(&diff_opts, FIND_COPIES_HARDER);
-
-	if (is_null_oid(&target->commit->object.oid))
-		do_diff_cache(parent->tree->object.oid.hash, &diff_opts);
-	else
-		diff_tree_sha1(parent->tree->object.oid.hash,
-			       target->commit->tree->object.oid.hash,
-			       "", &diff_opts);
-
-	if (!DIFF_OPT_TST(&diff_opts, FIND_COPIES_HARDER))
-		diffcore_std(&diff_opts);
-
-	do {
-		struct blame_entry **unblamedtail = &unblamed;
-		blame_list = setup_blame_list(unblamed, &num_ents);
-
-		for (i = 0; i < diff_queued_diff.nr; i++) {
-			struct diff_filepair *p = diff_queued_diff.queue[i];
-			struct blame_origin *norigin;
-			mmfile_t file_p;
-			struct blame_entry this[3];
-
-			if (!DIFF_FILE_VALID(p->one))
-				continue; /* does not exist in parent */
-			if (S_ISGITLINK(p->one->mode))
-				continue; /* ignore git links */
-			if (porigin && !strcmp(p->one->path, porigin->path))
-				/* find_move already dealt with this path */
-				continue;
-
-			norigin = get_origin(parent, p->one->path);
-			oidcpy(&norigin->blob_oid, &p->one->oid);
-			norigin->mode = p->one->mode;
-			fill_origin_blob(&sb->revs->diffopt, norigin, &file_p, &sb->num_read_blob);
-			if (!file_p.ptr)
-				continue;
-
-			for (j = 0; j < num_ents; j++) {
-				find_copy_in_blob(sb, blame_list[j].ent,
-						  norigin, this, &file_p);
-				copy_split_if_better(sb, blame_list[j].split,
-						     this);
-				decref_split(this);
-			}
-			blame_origin_decref(norigin);
-		}
-
-		for (j = 0; j < num_ents; j++) {
-			struct blame_entry *split = blame_list[j].split;
-			if (split[1].suspect &&
-			    sb->copy_score < ent_score(sb, &split[1])) {
-				split_blame(blamed, &unblamedtail, split,
-					    blame_list[j].ent);
-			} else {
-				blame_list[j].ent->next = leftover;
-				leftover = blame_list[j].ent;
-			}
-			decref_split(split);
-		}
-		free(blame_list);
-		*unblamedtail = NULL;
-		toosmall = filter_small(sb, toosmall, &unblamed, sb->copy_score);
-	} while (unblamed);
-	target->suspects = reverse_blame(leftover, NULL);
-	diff_flush(&diff_opts);
-	clear_pathspec(&diff_opts.pathspec);
-}
-
-/*
- * The blobs of origin and porigin exactly match, so everything
- * origin is suspected for can be blamed on the parent.
- */
-static void pass_whole_blame(struct blame_scoreboard *sb,
-			     struct blame_origin *origin, struct blame_origin *porigin)
-{
-	struct blame_entry *e, *suspects;
-
-	if (!porigin->file.ptr && origin->file.ptr) {
-		/* Steal its file */
-		porigin->file = origin->file;
-		origin->file.ptr = NULL;
-	}
-	suspects = origin->suspects;
-	origin->suspects = NULL;
-	for (e = suspects; e; e = e->next) {
-		blame_origin_incref(porigin);
-		blame_origin_decref(e->suspect);
-		e->suspect = porigin;
-	}
-	queue_blames(sb, porigin, suspects);
-}
-
-/*
- * We pass blame from the current commit to its parents.  We keep saying
- * "parent" (and "porigin"), but what we mean is to find scapegoat to
- * exonerate ourselves.
- */
-static struct commit_list *first_scapegoat(struct rev_info *revs, struct commit *commit,
-					   int reverse)
-{
-	if (!reverse) {
-		if (revs->first_parent_only &&
-		    commit->parents &&
-		    commit->parents->next) {
-			free_commit_list(commit->parents->next);
-			commit->parents->next = NULL;
-		}
-		return commit->parents;
-	}
-	return lookup_decoration(&revs->children, &commit->object);
-}
-
-static int num_scapegoats(struct rev_info *revs, struct commit *commit, int reverse)
-{
-	struct commit_list *l = first_scapegoat(revs, commit, reverse);
-	return commit_list_count(l);
-}
-
-/* Distribute collected unsorted blames to the respected sorted lists
- * in the various origins.
- */
-static void distribute_blame(struct blame_scoreboard *sb, struct blame_entry *blamed)
-{
-	blamed = llist_mergesort(blamed, get_next_blame, set_next_blame,
-				 compare_blame_suspect);
-	while (blamed)
-	{
-		struct blame_origin *porigin = blamed->suspect;
-		struct blame_entry *suspects = NULL;
-		do {
-			struct blame_entry *next = blamed->next;
-			blamed->next = suspects;
-			suspects = blamed;
-			blamed = next;
-		} while (blamed && blamed->suspect == porigin);
-		suspects = reverse_blame(suspects, NULL);
-		queue_blames(sb, porigin, suspects);
-	}
-}
-
-#define MAXSG 16
-
-static void pass_blame(struct blame_scoreboard *sb, struct blame_origin *origin, int opt)
-{
-	struct rev_info *revs = sb->revs;
-	int i, pass, num_sg;
-	struct commit *commit = origin->commit;
-	struct commit_list *sg;
-	struct blame_origin *sg_buf[MAXSG];
-	struct blame_origin *porigin, **sg_origin = sg_buf;
-	struct blame_entry *toosmall = NULL;
-	struct blame_entry *blames, **blametail = &blames;
-
-	num_sg = num_scapegoats(revs, commit, sb->reverse);
-	if (!num_sg)
-		goto finish;
-	else if (num_sg < ARRAY_SIZE(sg_buf))
-		memset(sg_buf, 0, sizeof(sg_buf));
-	else
-		sg_origin = xcalloc(num_sg, sizeof(*sg_origin));
-
-	/*
-	 * The first pass looks for unrenamed path to optimize for
-	 * common cases, then we look for renames in the second pass.
-	 */
-	for (pass = 0; pass < 2 - sb->no_whole_file_rename; pass++) {
-		struct blame_origin *(*find)(struct commit *, struct blame_origin *);
-		find = pass ? find_rename : find_origin;
-
-		for (i = 0, sg = first_scapegoat(revs, commit, sb->reverse);
-		     i < num_sg && sg;
-		     sg = sg->next, i++) {
-			struct commit *p = sg->item;
-			int j, same;
-
-			if (sg_origin[i])
-				continue;
-			if (parse_commit(p))
-				continue;
-			porigin = find(p, origin);
-			if (!porigin)
-				continue;
-			if (!oidcmp(&porigin->blob_oid, &origin->blob_oid)) {
-				pass_whole_blame(sb, origin, porigin);
-				blame_origin_decref(porigin);
-				goto finish;
-			}
-			for (j = same = 0; j < i; j++)
-				if (sg_origin[j] &&
-				    !oidcmp(&sg_origin[j]->blob_oid, &porigin->blob_oid)) {
-					same = 1;
-					break;
-				}
-			if (!same)
-				sg_origin[i] = porigin;
-			else
-				blame_origin_decref(porigin);
-		}
-	}
-
-	sb->num_commits++;
-	for (i = 0, sg = first_scapegoat(revs, commit, sb->reverse);
-	     i < num_sg && sg;
-	     sg = sg->next, i++) {
-		struct blame_origin *porigin = sg_origin[i];
-		if (!porigin)
-			continue;
-		if (!origin->previous) {
-			blame_origin_incref(porigin);
-			origin->previous = porigin;
-		}
-		pass_blame_to_parent(sb, origin, porigin);
-		if (!origin->suspects)
-			goto finish;
-	}
-
-	/*
-	 * Optionally find moves in parents' files.
-	 */
-	if (opt & PICKAXE_BLAME_MOVE) {
-		filter_small(sb, &toosmall, &origin->suspects, sb->move_score);
-		if (origin->suspects) {
-			for (i = 0, sg = first_scapegoat(revs, commit, sb->reverse);
-			     i < num_sg && sg;
-			     sg = sg->next, i++) {
-				struct blame_origin *porigin = sg_origin[i];
-				if (!porigin)
-					continue;
-				find_move_in_parent(sb, &blametail, &toosmall, origin, porigin);
-				if (!origin->suspects)
-					break;
-			}
-		}
-	}
-
-	/*
-	 * Optionally find copies from parents' files.
-	 */
-	if (opt & PICKAXE_BLAME_COPY) {
-		if (sb->copy_score > sb->move_score)
-			filter_small(sb, &toosmall, &origin->suspects, sb->copy_score);
-		else if (sb->copy_score < sb->move_score) {
-			origin->suspects = blame_merge(origin->suspects, toosmall);
-			toosmall = NULL;
-			filter_small(sb, &toosmall, &origin->suspects, sb->copy_score);
-		}
-		if (!origin->suspects)
-			goto finish;
-
-		for (i = 0, sg = first_scapegoat(revs, commit, sb->reverse);
-		     i < num_sg && sg;
-		     sg = sg->next, i++) {
-			struct blame_origin *porigin = sg_origin[i];
-			find_copy_in_parent(sb, &blametail, &toosmall,
-					    origin, sg->item, porigin, opt);
-			if (!origin->suspects)
-				goto finish;
-		}
-	}
-
-finish:
-	*blametail = NULL;
-	distribute_blame(sb, blames);
-	/*
-	 * prepend toosmall to origin->suspects
-	 *
-	 * There is no point in sorting: this ends up on a big
-	 * unsorted list in the caller anyway.
-	 */
-	if (toosmall) {
-		struct blame_entry **tail = &toosmall;
-		while (*tail)
-			tail = &(*tail)->next;
-		*tail = origin->suspects;
-		origin->suspects = toosmall;
-	}
-	for (i = 0; i < num_sg; i++) {
-		if (sg_origin[i]) {
-			drop_origin_blob(sg_origin[i]);
-			blame_origin_decref(sg_origin[i]);
-		}
-	}
-	drop_origin_blob(origin);
-	if (sg_buf != sg_origin)
-		free(sg_origin);
+	return blame_nth_line((struct blame_scoreboard *)data, lno);
 }
 
 /*
@@ -1544,74 +317,6 @@ static void found_guilty_entry(struct blame_entry *ent, void *data)
 	display_progress(pi->progress, pi->blamed_lines);
 }
 
-/*
- * The main loop -- while we have blobs with lines whose true origin
- * is still unknown, pick one blob, and allow its lines to pass blames
- * to its parents. */
-static void assign_blame(struct blame_scoreboard *sb, int opt)
-{
-	struct rev_info *revs = sb->revs;
-	struct commit *commit = prio_queue_get(&sb->commits);
-
-	while (commit) {
-		struct blame_entry *ent;
-		struct blame_origin *suspect = commit->util;
-
-		/* find one suspect to break down */
-		while (suspect && !suspect->suspects)
-			suspect = suspect->next;
-
-		if (!suspect) {
-			commit = prio_queue_get(&sb->commits);
-			continue;
-		}
-
-		assert(commit == suspect->commit);
-
-		/*
-		 * We will use this suspect later in the loop,
-		 * so hold onto it in the meantime.
-		 */
-		blame_origin_incref(suspect);
-		parse_commit(commit);
-		if (sb->reverse ||
-		    (!(commit->object.flags & UNINTERESTING) &&
-		     !(revs->max_age != -1 && commit->date < revs->max_age)))
-			pass_blame(sb, suspect, opt);
-		else {
-			commit->object.flags |= UNINTERESTING;
-			if (commit->object.parsed)
-				mark_parents_uninteresting(commit);
-		}
-		/* treat root commit as boundary */
-		if (!commit->parents && !sb->show_root)
-			commit->object.flags |= UNINTERESTING;
-
-		/* Take responsibility for the remaining entries */
-		ent = suspect->suspects;
-		if (ent) {
-			suspect->guilty = 1;
-			for (;;) {
-				struct blame_entry *next = ent->next;
-				if (sb->found_guilty_entry)
-					sb->found_guilty_entry(ent, sb->found_guilty_entry_data);
-				if (next) {
-					ent = next;
-					continue;
-				}
-				ent->next = sb->ent;
-				sb->ent = suspect->suspects;
-				suspect->suspects = NULL;
-				break;
-			}
-		}
-		blame_origin_decref(suspect);
-
-		if (sb->debug) /* sanity */
-			sanity_check_refcnt(sb);
-	}
-}
-
 static const char *format_time(unsigned long time, const char *tz_str,
 			       int show_raw_time)
 {
@@ -1675,7 +380,7 @@ static void emit_porcelain(struct blame_scoreboard *sb, struct blame_entry *ent,
 	       ent->num_lines);
 	emit_porcelain_details(suspect, repeat);
 
-	cp = nth_line(sb, ent->lno);
+	cp = blame_nth_line(sb, ent->lno);
 	for (cnt = 0; cnt < ent->num_lines; cnt++) {
 		char ch;
 		if (cnt) {
@@ -1709,7 +414,7 @@ static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent, int
 	get_commit_info(suspect->commit, &ci, 1);
 	oid_to_hex_r(hex, &suspect->commit->object.oid);
 
-	cp = nth_line(sb, ent->lno);
+	cp = blame_nth_line(sb, ent->lno);
 	for (cnt = 0; cnt < ent->num_lines; cnt++) {
 		char ch;
 		int length = (opt & OUTPUT_LONG_OBJECT_NAME) ? GIT_SHA1_HEXSZ : abbrev;
@@ -1913,8 +618,8 @@ static void find_alignment(struct blame_scoreboard *sb, int *option)
 		num = e->lno + e->num_lines;
 		if (longest_dst_lines < num)
 			longest_dst_lines = num;
-		if (largest_score < ent_score(sb, e))
-			largest_score = ent_score(sb, e);
+		if (largest_score < blame_entry_score(sb, e))
+			largest_score = blame_entry_score(sb, e);
 	}
 	max_orig_digits = decimal_width(longest_src_lines);
 	max_digits = decimal_width(longest_dst_lines);
@@ -1925,29 +630,6 @@ static void find_alignment(struct blame_scoreboard *sb, int *option)
 		abbrev = auto_abbrev + 1;
 }
 
-/*
- * For debugging -- origin is refcounted, and this asserts that
- * we do not underflow.
- */
-static void sanity_check_refcnt(struct blame_scoreboard *sb)
-{
-	int baa = 0;
-	struct blame_entry *ent;
-
-	for (ent = sb->ent; ent; ent = ent->next) {
-		/* Nobody should have zero or negative refcnt */
-		if (ent->suspect->refcnt <= 0) {
-			fprintf(stderr, "%s in %s has negative refcnt %d\n",
-				ent->suspect->path,
-				oid_to_hex(&ent->suspect->commit->object.oid),
-				ent->suspect->refcnt);
-			baa = 1;
-		}
-	}
-	if (baa)
-		sb->on_sanity_fail(sb, baa);
-}
-
 static void sanity_check_on_fail(struct blame_scoreboard *sb, int baa)
 {
 	int opt = OUTPUT_SHOW_SCORE | OUTPUT_SHOW_NUMBER | OUTPUT_SHOW_NAME;
@@ -2519,7 +1201,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 
 	blame_sort_final(&sb);
 
-	coalesce(&sb);
+	blame_coalesce(&sb);
 
 	if (!(output_option & OUTPUT_PORCELAIN))
 		find_alignment(&sb, &output_option);
-- 
2.9.3

