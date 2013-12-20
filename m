From: Junio C Hamano <gitster@pobox.com>
Subject: [RFH/PATCH] graph: give an extra gap after showing root commit
Date: Fri, 20 Dec 2013 12:22:39 -0800
Message-ID: <xmqqbo0be0hc.fsf_-_@gitster.dls.corp.google.com>
References: <1382717268-21884-1-git-send-email-milton.soares.filho@gmail.com>
	<xmqqeh79jmtr.fsf@gitster.dls.corp.google.com>
	<CAPNngRMP29s9gZg9R987yRd2qJ=UuaMWnFphtQdGDRgG_SCxsQ@mail.gmail.com>
	<87mwlwn4e0.fsf@gmail.com>
	<xmqqeh75h087.fsf@gitster.dls.corp.google.com>
	<CAPNngRMprE3QwDn3y74QqitAs+-DCBm1oO33uKRHsn9jLrNSnA@mail.gmail.com>
	<xmqqsivlfg6z.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Keshav Kini <keshav.kini@gmail.com>,
	Milton Soares Filho <milton.soares.filho@gmail.com>,
	Adam Simpkins <simpkins@facebook.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 20 21:22:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vu6b0-0007ui-V0
	for gcvg-git-2@plane.gmane.org; Fri, 20 Dec 2013 21:22:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752428Ab3LTUWu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Dec 2013 15:22:50 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43647 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751797Ab3LTUWt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Dec 2013 15:22:49 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 93026573A0;
	Fri, 20 Dec 2013 15:22:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mp8hJIxNesn56YXOpj6cXE9UPCQ=; b=rKhgSX
	tpV7Z9VwU7lvdgJTcbNy7Lr3b/uNEu+UfDupZcc8gXaoLvjq8HiGDh9SQAyIq7XE
	XZEmKBWoMecGfpTNTwbvCQ4+X41wSb9fIQwA3tuoiThpqsbZbAWSBxo3rn/9GyFv
	8k5gGOtXNaL72qyE0w6nRc9gAJyjogm8+/1cA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mmkx5FuH/q7z3bWFotcxNvsmEIQfez61
	JjNtWO9G0/1vjLTNoAbx7cyQhXJX5q+akZvFH+cYaDlyH0JR/ns4HtxVf1HHKn9F
	W+RVAnvfbVD9FXI4zag9Om/g/KJMA9T0gJlr/OWTbTswpQMxjI11zJQaM0rr+1TP
	z115x6wfHB0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 81B275739F;
	Fri, 20 Dec 2013 15:22:43 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 813095739D;
	Fri, 20 Dec 2013 15:22:42 -0500 (EST)
In-Reply-To: <xmqqsivlfg6z.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 28 Oct 2013 10:39:16 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7ABC1C18-69B4-11E3-ADD5-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239580>

With a history with more than one root commit, if a root commit
falls on one display column and another commit that is unrelated to
that root's history is shown on the next line on the same column,
the resulting graph would appear as if the latter is a parent of the
former, like this (there are two histories a1-a2 & b1-b2):

        ------------------------------------------
        $ git log --graph --oneline a2 b2
        * a2
        * a1
        * b2
        * b1
        ------------------------------------------

which is misleading.  b2 is a tip of a history unrelated to the
history that has a1 as a root.

Force a gap line immediately before showing next unrelated commit if
we showed a root from one history, to make the above display look
like this instead:

        ------------------------------------------
        $ git log --graph --oneline a2 b2
        * a2
        * a1

        * b2
        * b1
        ------------------------------------------

but do not waste line when we do not have to.  E.g. with a history
that merges a2 and b2,

        ------------------------------------------
        $ git log --graph --oneline m
        * Merge a2 and b2
        |\
        | * a2
        | * a1
        * b2
        * b1
        ------------------------------------------

there is no need to show an extra blank line after showing a1, as
it is clear that it has no parents.

This takes inspiration from Milton Soares Filho's "graph.c: mark
root commit differently" from a few months ago ($gmane/236708),
which tried to show a root commit as 'x', but only if it would have
been shown as '*' in the original, but uses a different approach so
that a root that may have been painted differently from '*'
(e.g. '<' for "left root") can also be made distinguishable.

Signed-off-by: Junio C Hamano <gitster@pobox.com>

---

 Note that this still does not work very well for --boundary case
 (see the last test added to t6016).

 It may actually make sense to force the "next" commit after showing
 a root always occupy a different column, instead of wasting a blank
 line.  If we did so, the output from the first example may look like
 this:

        ------------------------------------------
        $ git log --graph --oneline a2 b2
        * a2
        * a1
          * b2
          * b1
        ------------------------------------------

 or it may even look like this:

        ------------------------------------------
        $ git log --graph --oneline a2 b2
        * a2
        * a1
          * b2
         /
        * b1
        ------------------------------------------

 I tried to follow graph_update_columns() logic but gave up for now;
 avoiding to place a commit whose descendant has already been seen
 to the same column as the root commit we are processing there is
 easy, but the current commit may not yet be in columns[], and
 graph_output_commit_line() needs to show the current commit beyond
 the end of the columns[] list in such a case, so teaching
 graph_update_columns() to tweak placement of the next line is not
 sufficient.

 graph.c                                    | 20 ++++++++++++++++--
 t/t6016-rev-list-graph-simplify-history.sh | 34 ++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/graph.c b/graph.c
index b24d04c..2c3f141 100644
--- a/graph.c
+++ b/graph.c
@@ -187,6 +187,10 @@ struct git_graph {
 	 * stored as an index into the array column_colors.
 	 */
 	unsigned short default_column_color;
+	/* The last one was a root and we haven't emitted an extra blank */
+	unsigned need_post_root_gap : 1;
+	/* Are we looking at the root? */
+	unsigned is_root : 1;
 };
 
 static struct strbuf *diff_output_prefix_callback(struct diff_options *opt, void *data)
@@ -205,7 +209,7 @@ static struct strbuf *diff_output_prefix_callback(struct diff_options *opt, void
 
 struct git_graph *graph_init(struct rev_info *opt)
 {
-	struct git_graph *graph = xmalloc(sizeof(struct git_graph));
+	struct git_graph *graph = xcalloc(1, sizeof(struct git_graph));
 
 	if (!column_colors)
 		graph_set_column_colors(column_colors_ansi,
@@ -552,11 +556,14 @@ static void graph_update_columns(struct git_graph *graph)
 void graph_update(struct git_graph *graph, struct commit *commit)
 {
 	struct commit_list *parent;
+	int was_root = graph->is_root;
 
 	/*
 	 * Set the new commit
 	 */
 	graph->commit = commit;
+	graph->is_root = !commit->parents;
+	graph->need_post_root_gap = 0;
 
 	/*
 	 * Count how many interesting parents this commit has
@@ -607,8 +614,12 @@ void graph_update(struct git_graph *graph, struct commit *commit)
 	else if (graph->num_parents >= 3 &&
 		 graph->commit_index < (graph->num_columns - 1))
 		graph->state = GRAPH_PRE_COMMIT;
-	else
+	else {
 		graph->state = GRAPH_COMMIT;
+		if (was_root &&
+		    graph->prev_commit_index == graph->commit_index)
+			graph->need_post_root_gap = 1;
+	}
 }
 
 static int graph_is_mapping_correct(struct git_graph *graph)
@@ -814,6 +825,11 @@ static void graph_output_commit_line(struct git_graph *graph, struct strbuf *sb)
 	int seen_this = 0;
 	int i, chars_written;
 
+	if (graph->need_post_root_gap) {
+		graph->need_post_root_gap = 0;
+		strbuf_addch(sb, '\n');
+	}
+
 	/*
 	 * Output the row containing this commit
 	 * Iterate up to and including graph->num_columns,
diff --git a/t/t6016-rev-list-graph-simplify-history.sh b/t/t6016-rev-list-graph-simplify-history.sh
index f7181d1..ca53a80 100755
--- a/t/t6016-rev-list-graph-simplify-history.sh
+++ b/t/t6016-rev-list-graph-simplify-history.sh
@@ -264,4 +264,38 @@ test_expect_success '--graph --boundary ^C3' '
 	test_cmp expected actual
 	'
 
+one_independent_branch () {
+	git checkout --orphan root$1 A1 &&
+	test_commit root_$1 &&
+	test_commit then_$1 &&
+	test_commit further_$1
+}
+
+test_expect_success 'multi-root setup' '
+	one_independent_branch 0 &&
+	one_independent_branch 1 &&
+	one_independent_branch 2 &&
+
+	git checkout -b merge210 root2 &&
+	test_tick &&
+	git merge -s ours root1 &&
+	test_tick &&
+	git merge -s ours root0
+'
+
+test_expect_success 'multi-root does not emit unnecessary post-root gap' '
+	git log --oneline --graph >actual &&
+	! grep "^$" actual
+'
+
+test_expect_success 'multi-root does show necessary post-root gap' '
+	git log --oneline --graph root0 root1 root2 >actual &&
+	test $(grep -c "^$" actual) = 2
+'
+
+test_expect_failure 'multi-root does not emit unnecessary post-root gap' '
+	git log --oneline --graph merge210~1...merge210~1^2~2 >actual &&
+	! grep "^$" actual
+'
+
 test_done
-- 
1.8.5.2-297-g3e57c29
