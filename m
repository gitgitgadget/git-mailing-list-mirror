Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6123020248
	for <e@80x24.org>; Sun,  3 Mar 2019 12:00:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbfCCMAI (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Mar 2019 07:00:08 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39306 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbfCCMAI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Mar 2019 07:00:08 -0500
Received: by mail-ed1-f68.google.com with SMTP id p27so1939018edc.6
        for <git@vger.kernel.org>; Sun, 03 Mar 2019 04:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=hYkDYlW8MVcMUQdOSiN+Zmcl0zr5Nnw8WryhjPhNcJA=;
        b=P4ZDOxhGfuzxLV9ideYQbi/2pmhRTMh5xGyPtxMnwkqAlMO0fWN3KEwK5prsewfB/p
         Ky3SIHvckJud0qf2PSH7sWJ8FfT9rIuoxkSTs2JUAMccl5Er5n5QUCiL9PAfR+iIBu6n
         +u0yu3QYpRn0i6eLSWJm2Go9sDbRIkLPCw97XhUYcb0dfmPdmGhWOUC6PfIZL4vjBv9X
         PF+OB05iiCc7umDB7emQZEe5rhHOXdpzdIVRzkOUylTv5lTxIsh9PCO08np5tsMtH5Zl
         O64eJXkEap9QQypnGpX4hR16BTcdZAtC842iP6yBkaI8G1ZmvNnLCbmuW2GUcvk7VCx5
         kBhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hYkDYlW8MVcMUQdOSiN+Zmcl0zr5Nnw8WryhjPhNcJA=;
        b=LDqMojQfQnr8k+4vgM6b//wnNndSGEbLafnrBPZONG2BWvCBhfNbkOBMHZlDwLkIyw
         HcDpIk90mmYeNSFi+me48XjXe/rbmJpqSfDN0NjEMjqNoHx8ldaoRiNtxXuvuY/J/B32
         NB9fh+XzJ2fucISZr4fDG2k7v96IB8yfYtvtF4v0cBU/CkGenC0PahotB7WxAt9HIerf
         R7JkgIYzrjjISWteyd6A7yw7uV3nfP28ZKaM4gb/1wRtJG8xG4KbTXVenLdRi3u4bwDN
         mAW2OTvCU9h53JACltzE1XTHOPAJMqcjmbi0UZuWqYjGgVHHwEcHNR76yJnX0hVfN5Ld
         4XfQ==
X-Gm-Message-State: APjAAAXrK/QxZfD8GdsT8+QlUEw07fNNwxhL7yrHcLupINvrrLSCE899
        4yf8FGXUEzaHeR+r3KGjnUD7Rj0U
X-Google-Smtp-Source: APXvYqyTHVYwI1nfapAESf9qGQY3EhTihYjYG5/PYjQU1dsAP3q7XuNq+1Fny+o6+sZkRkXSpnb49w==
X-Received: by 2002:a17:906:791:: with SMTP id l17mr9226501ejc.1.1551614404842;
        Sun, 03 Mar 2019 04:00:04 -0800 (PST)
Received: from poppybee.home ([77.172.207.196])
        by smtp.gmail.com with ESMTPSA id l53sm1181503eda.66.2019.03.03.04.00.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Mar 2019 04:00:04 -0800 (PST)
From:   Micha Nelissen <nelissen.micha@gmail.com>
To:     git@vger.kernel.org
Cc:     Micha Nelissen <nelissen.micha@gmail.com>
Subject: [PATCH] Make graph drawing more compact
Date:   Sun,  3 Mar 2019 12:59:57 +0100
Message-Id: <20190303115957.11871-1-nelissen.micha@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before this commit, graphs with merges have an empty line after a
merge commit to make room for a new branch. But this causes the
child commits (commits merged with the merge commit) to be separated
from the merge commit. Especially with the --tree option this
is confusing, as there is no empty line after a series of child
commits anymore (because it is a tree after all).

Therefore this change modifies the merge point to not need an
extra line (the POST_MERGE state is removed), using an underscore
to branch out instead of a '\'.

It also optimizes the case where a branch point meets a merge commit.

Signed-off-by: Micha Nelissen <nelissen.micha@gmail.com>
---
 graph.c | 281 +++++++++++++++++---------------------------------------
 1 file changed, 85 insertions(+), 196 deletions(-)

diff --git graph.c graph.c
index f53135485f..f0e30bce62 100644
--- graph.c
+++ graph.c
@@ -63,7 +63,6 @@ enum graph_state {
 	GRAPH_SKIP,
 	GRAPH_PRE_COMMIT,
 	GRAPH_COMMIT,
-	GRAPH_POST_MERGE,
 	GRAPH_COLLAPSING
 };
 
@@ -153,12 +152,6 @@ struct git_graph {
 	 * This tells us what kind of line graph_next_line() should output.
 	 */
 	enum graph_state state;
-	/*
-	 * The output state for the previous line of output.
-	 * This is primarily used to determine how the first merge line
-	 * should appear, based on the last line of the previous commit.
-	 */
-	enum graph_state prev_state;
 	/*
 	 * The index of the column that refers to this commit.
 	 *
@@ -167,13 +160,9 @@ struct git_graph {
 	 */
 	int commit_index;
 	/*
-	 * The commit_index for the previously displayed commit.
-	 *
-	 * This is used to determine how the first line of a merge
-	 * graph output should appear, based on the last line of the
-	 * previous commit.
+	 * If previous line was a merge commit, then this is its commit index
 	 */
-	int prev_commit_index;
+	int prev_merge_index;
 	/*
 	 * The maximum number of columns that can be stored in the columns
 	 * and new_columns arrays.  This is also half the number of entries
@@ -282,9 +271,7 @@ struct git_graph *graph_init(struct rev_info *opt)
 	graph->num_parents = 0;
 	graph->expansion_row = 0;
 	graph->state = GRAPH_PADDING;
-	graph->prev_state = GRAPH_PADDING;
 	graph->commit_index = 0;
-	graph->prev_commit_index = 0;
 	graph->num_columns = 0;
 	graph->num_new_columns = 0;
 	graph->mapping_size = 0;
@@ -317,7 +304,6 @@ struct git_graph *graph_init(struct rev_info *opt)
 
 static void graph_update_state(struct git_graph *graph, enum graph_state s)
 {
-	graph->prev_state = graph->state;
 	graph->state = s;
 }
 
@@ -602,6 +588,13 @@ static void graph_update_columns(struct git_graph *graph)
 	graph_update_width(graph, is_commit_in_columns);
 }
 
+static int need_pre_commit(struct git_graph *graph)
+{
+	return (graph->num_parents == 2 && graph->prev_merge_index != 0xffff)
+	    || (graph->num_parents >= 3 &&
+		graph->commit_index < (graph->num_columns - 1));
+}
+
 void graph_update(struct git_graph *graph, struct commit *commit)
 {
 	struct commit_list *parent;
@@ -622,13 +615,6 @@ void graph_update(struct git_graph *graph, struct commit *commit)
 		graph->num_parents++;
 	}
 
-	/*
-	 * Store the old commit_index in prev_commit_index.
-	 * graph_update_columns() will update graph->commit_index for this
-	 * commit.
-	 */
-	graph->prev_commit_index = graph->commit_index;
-
 	/*
 	 * Call graph_update_columns() to update
 	 * columns, new_columns, and mapping.
@@ -639,9 +625,6 @@ void graph_update(struct git_graph *graph, struct commit *commit)
 
 	/*
 	 * Update graph->state.
-	 * Note that we don't call graph_update_state() here, since
-	 * we don't want to update graph->prev_state.  No line for
-	 * graph->state was ever printed.
 	 *
 	 * If the previous commit didn't get to the GRAPH_PADDING state,
 	 * it never finished its output.  Goto GRAPH_SKIP, to print out
@@ -657,8 +640,7 @@ void graph_update(struct git_graph *graph, struct commit *commit)
 	 */
 	if (graph->state != GRAPH_PADDING)
 		graph->state = GRAPH_SKIP;
-	else if (graph->num_parents >= 3 &&
-		 graph->commit_index < (graph->num_columns - 1))
+	else if (need_pre_commit(graph))
 		graph->state = GRAPH_PRE_COMMIT;
 	else
 		graph->state = GRAPH_COMMIT;
@@ -742,8 +724,7 @@ static void graph_output_skip_line(struct git_graph *graph, struct strbuf *sb)
 	strbuf_addstr(sb, "...");
 	graph_pad_horizontally(graph, sb, 3);
 
-	if (graph->num_parents >= 3 &&
-	    graph->commit_index < (graph->num_columns - 1))
+	if (need_pre_commit(graph))
 		graph_update_state(graph, GRAPH_PRE_COMMIT);
 	else
 		graph_update_state(graph, GRAPH_COMMIT);
@@ -763,14 +744,16 @@ static void graph_output_pre_commit_line(struct git_graph *graph,
 	 *
 	 * We need 2 extra rows for every parent over 2.
 	 */
-	assert(graph->num_parents >= 3);
+	assert(graph->num_parents >= 2);
 	num_expansion_rows = (graph->num_parents - 2) * 2;
+	if (num_expansion_rows == 0)
+		graph->expansion_row = -1;
 
 	/*
 	 * graph->expansion_row tracks the current expansion row we are on.
 	 * It should be in the range [0, num_expansion_rows - 1]
 	 */
-	assert(0 <= graph->expansion_row &&
+	assert(-1 <= graph->expansion_row &&
 	       graph->expansion_row < num_expansion_rows);
 
 	/*
@@ -783,25 +766,9 @@ static void graph_output_pre_commit_line(struct git_graph *graph,
 		if (col->commit == graph->commit) {
 			seen_this = 1;
 			strbuf_write_column(sb, col, '|');
-			strbuf_addchars(sb, ' ', graph->expansion_row);
-			chars_written += 1 + graph->expansion_row;
-		} else if (seen_this && (graph->expansion_row == 0)) {
-			/*
-			 * This is the first line of the pre-commit output.
-			 * If the previous commit was a merge commit and
-			 * ended in the GRAPH_POST_MERGE state, all branch
-			 * lines after graph->prev_commit_index were
-			 * printed as "\" on the previous line.  Continue
-			 * to print them as "\" on this line.  Otherwise,
-			 * print the branch lines as "|".
-			 */
-			if (graph->prev_state == GRAPH_POST_MERGE &&
-			    graph->prev_commit_index < i)
-				strbuf_write_column(sb, col, '\\');
-			else
-				strbuf_write_column(sb, col, '|');
-			chars_written++;
-		} else if (seen_this && (graph->expansion_row > 0)) {
+			strbuf_addchars(sb, ' ', graph->expansion_row + 1);
+			chars_written += 2 + graph->expansion_row;
+		} else if (seen_this) {
 			strbuf_write_column(sb, col, '\\');
 			chars_written++;
 		} else {
@@ -887,8 +854,7 @@ static int graph_draw_octopus_merge(struct git_graph *graph,
 	int i;
 	for (i = 0; i < dashful_parents; i++) {
 		strbuf_write_column(sb, &graph->new_columns[i+first_col], '-');
-		strbuf_write_column(sb, &graph->new_columns[i+first_col],
-				    i == dashful_parents-1 ? '.' : '-');
+		strbuf_write_column(sb, &graph->new_columns[i+first_col], '-');
 	}
 	return 2 * dashful_parents;
 }
@@ -896,7 +862,8 @@ static int graph_draw_octopus_merge(struct git_graph *graph,
 static void graph_output_commit_line(struct git_graph *graph, struct strbuf *sb)
 {
 	int seen_this = 0;
-	int i, chars_written;
+	int i, j, k, chars_written;
+	char draw_ch;
 
 	/*
 	 * Output the row containing this commit
@@ -910,6 +877,7 @@ static void graph_output_commit_line(struct git_graph *graph, struct strbuf *sb)
 	for (i = 0; i <= graph->num_columns; i++) {
 		struct column *col = &graph->columns[i];
 		struct commit *col_commit;
+		int add_space = 1;
 		if (i == graph->num_columns) {
 			if (seen_this)
 				break;
@@ -923,138 +891,76 @@ static void graph_output_commit_line(struct git_graph *graph, struct strbuf *sb)
 			graph_output_commit_char(graph, sb);
 			chars_written++;
 
-			if (graph->num_parents > 2)
+			draw_ch = graph->num_parents == 2 ? '_' : 0;
+			if (graph->num_parents > 2) {
 				chars_written += graph_draw_octopus_merge(graph,
 									  sb);
-		} else if (seen_this && (graph->num_parents > 2)) {
-			strbuf_write_column(sb, col, '\\');
-			chars_written++;
-		} else if (seen_this && (graph->num_parents == 2)) {
-			/*
-			 * This is a 2-way merge commit.
-			 * There is no GRAPH_PRE_COMMIT stage for 2-way
-			 * merges, so this is the first line of output
-			 * for this commit.  Check to see what the previous
-			 * line of output was.
-			 *
-			 * If it was GRAPH_POST_MERGE, the branch line
-			 * coming into this commit may have been '\',
-			 * and not '|' or '/'.  If so, output the branch
-			 * line as '\' on this line, instead of '|'.  This
-			 * makes the output look nicer.
-			 */
-			if (graph->prev_state == GRAPH_POST_MERGE &&
-			    graph->prev_commit_index < i)
-				strbuf_write_column(sb, col, '\\');
-			else
-				strbuf_write_column(sb, col, '|');
-			chars_written++;
-		} else {
-			strbuf_write_column(sb, col, '|');
-			chars_written++;
-		}
-		strbuf_addch(sb, ' ');
-		chars_written++;
-	}
-
-	graph_pad_horizontally(graph, sb, chars_written);
-
-	/*
-	 * Update graph->state
-	 */
-	if (graph->num_parents > 1)
-		graph_update_state(graph, GRAPH_POST_MERGE);
-	else if (graph_is_mapping_correct(graph))
-		graph_update_state(graph, GRAPH_PADDING);
-	else
-		graph_update_state(graph, GRAPH_COLLAPSING);
-}
-
-static struct column *find_new_column_by_commit(struct git_graph *graph,
-						struct commit *commit)
-{
-	int i;
-	for (i = 0; i < graph->num_new_columns; i++) {
-		if (graph->new_columns[i].commit == commit)
-			return &graph->new_columns[i];
-	}
-	return NULL;
-}
-
-static void graph_output_post_merge_line(struct git_graph *graph, struct strbuf *sb)
-{
-	int seen_this = 0;
-	int i, j, chars_written;
-
-	/*
-	 * Output the post-merge row
-	 */
-	chars_written = 0;
-	for (i = 0; i <= graph->num_columns; i++) {
-		struct column *col = &graph->columns[i];
-		struct commit *col_commit;
-		if (i == graph->num_columns) {
-			if (seen_this)
-				break;
-			col_commit = graph->commit;
-		} else {
-			col_commit = col->commit;
-		}
-
-		if (col_commit == graph->commit) {
-			/*
-			 * Since the current commit is a merge find
-			 * the columns for the parent commits in
-			 * new_columns and use those to format the
-			 * edges.
-			 */
-			struct commit_list *parents = NULL;
-			struct column *par_column;
-			seen_this = 1;
-			parents = first_interesting_parent(graph);
-			assert(parents);
-			par_column = find_new_column_by_commit(graph, parents->item);
-			assert(par_column);
-
-			strbuf_write_column(sb, par_column, '|');
-			chars_written++;
-			for (j = 0; j < graph->num_parents - 1; j++) {
-				parents = next_interesting_parent(graph, parents);
-				assert(parents);
-				par_column = find_new_column_by_commit(graph, parents->item);
-				assert(par_column);
-				strbuf_write_column(sb, par_column, '\\');
-				strbuf_addch(sb, ' ');
+				draw_ch = '.';
 			}
-			chars_written += j * 2;
-		} else if (seen_this) {
-			strbuf_write_column(sb, col, '\\');
-			strbuf_addch(sb, ' ');
-			chars_written += 2;
+			if (graph->num_parents > 1) {
+				j = i+1, k = i+2;
+				if (i > 0 && graph->mapping[j*2] == i-1)
+					col = &graph->new_columns[i-1];
+				else
+					col = &graph->new_columns[i+graph->num_parents-1];
+				/* 
+				   optimize collapse after merge case:
+				   i j k
+				   | * <hash> some commit 
+				   *. \ <hash> merge branch with another commit
+				   | |/    <--- collapse line
+				   | * <hash> another commit
+
+				   this happens if the mapping of the second next
+				   column merges with the next column
+				   remember this by marking seen_this = 2
+				   adjust mapping array because we fixed it here
+
+				   output:
+				   | * <hash> some commit
+				   *.| <hash> merge branch with another commit
+				   | * <hash> another commit
+
+				   this saves a line, plus the merge commit is
+				   not indented anymore relative to what's merged
+				*/
+				if (graph->mapping[j*2] == j && graph->mapping[k*2] == j) {
+					for (; k*2 < graph->mapping_size; k++)
+						graph->mapping[k*2] = k;
+					add_space = 0;
+					seen_this = 2;  /* draw a '|' */
+				}
+			}
+		} else if (seen_this == 1 && (graph->num_parents >= 2)) {
+			draw_ch = '\\';
 		} else {
-			strbuf_write_column(sb, col, '|');
-			strbuf_addch(sb, ' ');
-			chars_written += 2;
+			draw_ch = '|';
 		}
+		if (draw_ch)
+			strbuf_write_column(sb, col, draw_ch);
+		if (add_space)
+			strbuf_addch(sb, ' ');
+		chars_written += 1 + add_space;
 	}
 
-	graph_pad_horizontally(graph, sb, chars_written);
-
 	/*
 	 * Update graph->state
 	 */
-	if (graph_is_mapping_correct(graph))
+	graph->prev_merge_index = 0xffff;
+	if (graph_is_mapping_correct(graph)) {
 		graph_update_state(graph, GRAPH_PADDING);
-	else
+		if (graph->num_parents > 1)
+			graph->prev_merge_index = graph->commit_index;
+	} else
 		graph_update_state(graph, GRAPH_COLLAPSING);
 }
 
 static void graph_output_collapsing_line(struct git_graph *graph, struct strbuf *sb)
 {
-	int i;
-	short used_horizontal = 0;
+	int i, j;
 	int horizontal_edge = -1;
 	int horizontal_edge_target = -1;
+	char draw_ch;
 
 	/*
 	 * Clear out the new_mapping array
@@ -1097,16 +1003,15 @@ static void graph_output_collapsing_line(struct git_graph *graph, struct strbuf
 			 * select this one.
 			 */
 			if (horizontal_edge == -1) {
-				int j;
 				horizontal_edge = i;
 				horizontal_edge_target = target;
 				/*
 				 * The variable target is the index of the graph
-				 * column, and therefore target*2+3 is the
+				 * column, and therefore target*2+1 is the
 				 * actual screen column of the first horizontal
 				 * line.
 				 */
-				for (j = (target * 2)+3; j < (i - 2); j += 2)
+				for (j = (target * 2)+1; j < i; j += 2)
 					graph->new_mapping[j] = target;
 			}
 		} else if (graph->new_mapping[i - 1] == target) {
@@ -1158,27 +1063,19 @@ static void graph_output_collapsing_line(struct git_graph *graph, struct strbuf
 	 */
 	for (i = 0; i < graph->mapping_size; i++) {
 		int target = graph->new_mapping[i];
-		if (target < 0)
+		if (target < 0) {
 			strbuf_addch(sb, ' ');
-		else if (target * 2 == i)
-			strbuf_write_column(sb, &graph->new_columns[target], '|');
-		else if (target == horizontal_edge_target &&
-			 i != horizontal_edge - 1) {
-				/*
-				 * Set the mappings for all but the
-				 * first segment to -1 so that they
-				 * won't continue into the next line.
-				 */
-				if (i != (target * 2)+3)
-					graph->new_mapping[i] = -1;
-				used_horizontal = 1;
-			strbuf_write_column(sb, &graph->new_columns[target], '_');
+			continue;
+		}
+		if (target * 2 == i) {
+			draw_ch = '|';
 		} else {
-			if (used_horizontal && i < horizontal_edge)
+			if (i < horizontal_edge)
 				graph->new_mapping[i] = -1;
-			strbuf_write_column(sb, &graph->new_columns[target], '/');
-
+			draw_ch = target == horizontal_edge_target &&
+				i != horizontal_edge-1 ? '_' : '/';
 		}
+		strbuf_write_column(sb, &graph->new_columns[target], draw_ch);
 	}
 
 	graph_pad_horizontally(graph, sb, graph->mapping_size);
@@ -1212,9 +1109,6 @@ int graph_next_line(struct git_graph *graph, struct strbuf *sb)
 	case GRAPH_COMMIT:
 		graph_output_commit_line(graph, sb);
 		return 1;
-	case GRAPH_POST_MERGE:
-		graph_output_post_merge_line(graph, sb);
-		return 0;
 	case GRAPH_COLLAPSING:
 		graph_output_collapsing_line(graph, sb);
 		return 0;
@@ -1258,11 +1152,6 @@ static void graph_padding_line(struct git_graph *graph, struct strbuf *sb)
 	}
 
 	graph_pad_horizontally(graph, sb, chars_written);
-
-	/*
-	 * Update graph->prev_state since we have output a padding line
-	 */
-	graph->prev_state = GRAPH_PADDING;
 }
 
 int graph_is_commit_finished(struct git_graph const *graph)
-- 
2.17.1

