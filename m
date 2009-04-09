From: Allan Caffee <allan.caffee@gmail.com>
Subject: [PATCH v3] graph API: Added logic for colored edges
Date: Thu, 9 Apr 2009 18:22:38 -0400
Message-ID: <20090409222238.GA16573@linux.vnet>
References: <7vocv6is9g.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Junio C Hamano <gitster@pobox.com>,
	Teemu Likonen <tlikonen@iki.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 10 00:24:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ls2fb-00017e-M8
	for gcvg-git-2@gmane.org; Fri, 10 Apr 2009 00:24:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761679AbZDIWWr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Apr 2009 18:22:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761225AbZDIWWr
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Apr 2009 18:22:47 -0400
Received: from wf-out-1314.google.com ([209.85.200.170]:10539 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761072AbZDIWWo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Apr 2009 18:22:44 -0400
Received: by wf-out-1314.google.com with SMTP id 29so822661wff.4
        for <git@vger.kernel.org>; Thu, 09 Apr 2009 15:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mail-followup-to:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=DKBIqvasvdpd7liAVkMSkegXGXl1ool+OzE+XaDWBS4=;
        b=Zs4qOmL1D+5axvIUA76l4m3moWC2wlyoEQGcFF42wllfJYcdGa4A4BVggLjgtMCbzE
         VFeXO4x29WZQB2EXt6Vt05uCLxqbiWl4XaHMAz3+s0Wr1xIQrWcmnC+YLpeE2noOwn9N
         UTTFZg7ioTE0pkOOK8TwLmgbbOUrvv0pZeG5E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=l2Vs8z7miv8FrCXRiSYCPjTDmUXjTj2AmHEJuw+gDF6x/xLkZdl+j1lWjTs5m/cXr+
         qKcn4GqnIZcwv3K3/t2KWEMbF5YqcjHh/Sp7812oU8DSpY/6olRPQIreE5RWIB4DQW7h
         GaJLg/AcmIwelK1l57uciaTOfSZBjqzmW/JNg=
Received: by 10.142.13.13 with SMTP id 13mr1032463wfm.155.1239315763926;
        Thu, 09 Apr 2009 15:22:43 -0700 (PDT)
Received: from linux.vnet (pool-71-185-49-127.phlapa.fios.verizon.net [71.185.49.127])
        by mx.google.com with ESMTPS id 30sm1132953wfa.18.2009.04.09.15.22.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 09 Apr 2009 15:22:43 -0700 (PDT)
Mail-Followup-To: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, Nanako Shiraishi <nanako3@lavabit.com>,
	Junio C Hamano <gitster@pobox.com>, Teemu Likonen <tlikonen@iki.fi>
Content-Disposition: inline
In-Reply-To: <7vocv6is9g.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116214>

Modified the graph drawing logic to colorize edges based on parent-child
relationships similiarly to gitk.

Signed-off-by: Allan Caffee <allan.caffee@gmail.com>
---

Here's a list of the changes this round (I can send individual patches
if it's easier to review):

* graph API: Fix graph_pad_horizontal to work properly with colors
    The horizontal padding was counting the number of characters in the
strbuf in order to decide how much whitespace to pad the row with.
The ANSI escape sequences for colors and attributes are not printable
characters but do contribute to the length of the strbuf.  This fix
teaches strbuf's to count printing characters (i.e. characters that
consume space).
* graph.c: Add graph_draw_octopus_merge() to simplify graph_output_commit_line()
* --graph: Fix whitespace discoloration
    Background colors now work as expected (but boy are they ugly ;).
* graph.c: Store colors as unsigned short
* graph: Fixed up some stylistic issues with pointers

~Allan

 color.h  |    1 +
 graph.c  |  212 +++++++++++++++++++++++++++++++++++++++++++++++++------------
 strbuf.c |   39 +++++++++++
 strbuf.h |    1 +
 4 files changed, 211 insertions(+), 42 deletions(-)

diff --git a/color.h b/color.h
index 6846be1..18abeb7 100644
--- a/color.h
+++ b/color.h
@@ -11,6 +11,7 @@
 #define GIT_COLOR_GREEN		"\033[32m"
 #define GIT_COLOR_YELLOW	"\033[33m"
 #define GIT_COLOR_BLUE		"\033[34m"
+#define GIT_COLOR_MAGENTA	"\033[35m"
 #define GIT_COLOR_CYAN		"\033[36m"
 #define GIT_COLOR_BG_RED	"\033[41m"
 
diff --git a/graph.c b/graph.c
index 162a516..beb622a 100644
--- a/graph.c
+++ b/graph.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "commit.h"
+#include "color.h"
 #include "graph.h"
 #include "diff.h"
 #include "revision.h"
@@ -43,10 +44,6 @@ static void graph_show_strbuf(struct git_graph *graph, struct strbuf const *sb);
 
 /*
  * TODO:
- * - Add colors to the graph.
- *   Pick a color for each column, and print all characters
- *   in that column with the specified color.
- *
  * - Limit the number of columns, similar to the way gitk does.
  *   If we reach more than a specified number of columns, omit
  *   sections of some columns.
@@ -72,11 +69,14 @@ struct column {
 	 */
 	struct commit *commit;
 	/*
-	 * XXX: Once we add support for colors, struct column could also
-	 * contain the color of its branch line.
+	 * The color to (optionally) print this column in.  This is an
+	 * index into column_colors.
 	 */
+	unsigned short color;
 };
 
+const unsigned short GIT_NOT_A_COLOR = -1;
+
 enum graph_state {
 	GRAPH_PADDING,
 	GRAPH_SKIP,
@@ -86,6 +86,39 @@ enum graph_state {
 	GRAPH_COLLAPSING
 };
 
+/*
+ * The list of available column colors.
+ */
+static char column_colors[][COLOR_MAXLEN] = {
+	GIT_COLOR_RED,
+	GIT_COLOR_GREEN,
+	GIT_COLOR_YELLOW,
+	GIT_COLOR_BLUE,
+	GIT_COLOR_MAGENTA,
+	GIT_COLOR_CYAN,
+	GIT_COLOR_BOLD GIT_COLOR_RED,
+	GIT_COLOR_BOLD GIT_COLOR_GREEN,
+	GIT_COLOR_BOLD GIT_COLOR_YELLOW,
+	GIT_COLOR_BOLD GIT_COLOR_BLUE,
+	GIT_COLOR_BOLD GIT_COLOR_MAGENTA,
+	GIT_COLOR_BOLD GIT_COLOR_CYAN,
+};
+
+static const char *column_get_color_code(const struct column *c)
+{
+	return column_colors[c->color];
+}
+
+static void strbuf_write_column(struct strbuf *sb, const struct column *c,
+				char col_char)
+{
+	if (c->color != GIT_NOT_A_COLOR)
+		strbuf_addstr(sb, column_get_color_code(c));
+	strbuf_addch(sb, col_char);
+	if (c->color != GIT_NOT_A_COLOR)
+		strbuf_addstr(sb, GIT_COLOR_RESET);
+}
+
 struct git_graph {
 	/*
 	 * The commit currently being processed
@@ -185,6 +218,11 @@ struct git_graph {
 	 * temporary array each time we have to output a collapsing line.
 	 */
 	int *new_mapping;
+	/*
+	 * The current default column color being used.  This is
+	 * stored as an index into the array column_colors.
+	 */
+	unsigned short default_column_color;
 };
 
 struct git_graph *graph_init(struct rev_info *opt)
@@ -201,6 +239,7 @@ struct git_graph *graph_init(struct rev_info *opt)
 	graph->num_columns = 0;
 	graph->num_new_columns = 0;
 	graph->mapping_size = 0;
+	graph->default_column_color = 0;
 
 	/*
 	 * Allocate a reasonably large default number of columns
@@ -312,6 +351,33 @@ static struct commit_list *first_interesting_parent(struct git_graph *graph)
 	return next_interesting_parent(graph, parents);
 }
 
+inline unsigned short graph_get_current_column_color(const struct git_graph *graph)
+{
+	if (!DIFF_OPT_TST(&graph->revs->diffopt, COLOR_DIFF))
+		return GIT_NOT_A_COLOR;
+	return graph->default_column_color;
+}
+
+/*
+ * Update the graph's default column color.
+ */
+static void graph_increment_column_color(struct git_graph *graph)
+{
+	graph->default_column_color = (graph->default_column_color + 1) %
+		ARRAY_SIZE(column_colors);
+}
+
+inline unsigned short graph_find_commit_color(const struct git_graph *graph,
+					      const struct commit *commit)
+{
+	int i;
+	for (i = 0; i < graph->num_columns; i++) {
+		if (graph->columns[i].commit == commit)
+			return graph->columns[i].color;
+	}
+	return graph_get_current_column_color(graph);
+}
+
 static void graph_insert_into_new_columns(struct git_graph *graph,
 					  struct commit *commit,
 					  int *mapping_index)
@@ -334,6 +400,7 @@ static void graph_insert_into_new_columns(struct git_graph *graph,
 	 * This commit isn't already in new_columns.  Add it.
 	 */
 	graph->new_columns[graph->num_new_columns].commit = commit;
+	graph->new_columns[graph->num_new_columns].color = graph_find_commit_color(graph, commit);
 	graph->mapping[*mapping_index] = graph->num_new_columns;
 	*mapping_index += 2;
 	graph->num_new_columns++;
@@ -445,6 +512,12 @@ static void graph_update_columns(struct git_graph *graph)
 			for (parent = first_interesting_parent(graph);
 			     parent;
 			     parent = next_interesting_parent(graph, parent)) {
+				/*
+				 * If this is a merge increment the current
+				 * color.
+				 */
+				if (graph->num_parents > 1)
+					graph_increment_column_color(graph);
 				graph_insert_into_new_columns(graph,
 							      parent->item,
 							      &mapping_idx);
@@ -569,11 +642,11 @@ static void graph_pad_horizontally(struct git_graph *graph, struct strbuf *sb)
 	 * This way, fields printed to the right of the graph will remain
 	 * aligned for the entire commit.
 	 */
-	int extra;
-	if (sb->len >= graph->width)
+	int extra, printing;
+	printing = strbuf_count_printing_chars(sb);
+	if (printing >= graph->width)
 		return;
-
-	extra = graph->width - sb->len;
+	extra = graph->width - printing;
 	strbuf_addf(sb, "%*s", (int) extra, "");
 }
 
@@ -596,7 +669,8 @@ static void graph_output_padding_line(struct git_graph *graph,
 	 * Output a padding row, that leaves all branch lines unchanged
 	 */
 	for (i = 0; i < graph->num_new_columns; i++) {
-		strbuf_addstr(sb, "| ");
+		strbuf_write_column(sb, &graph->new_columns[i], '|');
+		strbuf_addch(sb, ' ');
 	}
 
 	graph_pad_horizontally(graph, sb);
@@ -649,7 +723,8 @@ static void graph_output_pre_commit_line(struct git_graph *graph,
 		struct column *col = &graph->columns[i];
 		if (col->commit == graph->commit) {
 			seen_this = 1;
-			strbuf_addf(sb, "| %*s", graph->expansion_row, "");
+			strbuf_write_column(sb, col, '|');
+			strbuf_addf(sb, " %*s", graph->expansion_row, "");
 		} else if (seen_this && (graph->expansion_row == 0)) {
 			/*
 			 * This is the first line of the pre-commit output.
@@ -662,14 +737,15 @@ static void graph_output_pre_commit_line(struct git_graph *graph,
 			 */
 			if (graph->prev_state == GRAPH_POST_MERGE &&
 			    graph->prev_commit_index < i)
-				strbuf_addstr(sb, "\\ ");
+				strbuf_write_column(sb, col, '\\');
 			else
-				strbuf_addstr(sb, "| ");
+				strbuf_write_column(sb, col, '|');
 		} else if (seen_this && (graph->expansion_row > 0)) {
-			strbuf_addstr(sb, "\\ ");
+			strbuf_write_column(sb, col, '\\');
 		} else {
-			strbuf_addstr(sb, "| ");
+			strbuf_write_column(sb, col, '|');
 		}
+		strbuf_addch(sb, ' ');
 	}
 
 	graph_pad_horizontally(graph, sb);
@@ -714,10 +790,30 @@ static void graph_output_commit_char(struct git_graph *graph, struct strbuf *sb)
 	strbuf_addch(sb, '*');
 }
 
+inline void graph_draw_octopus_merge(const struct git_graph *graph,
+				     struct strbuf *sb)
+{
+	/*
+	 * Here dashless_commits represents the number of parents
+	 * which don't need to have dashes (because their edges fit
+	 * neatly under the commit).
+	 */
+	const int dashless_commits = 2;
+	int col_num, i;
+	int num_dashes =
+		((graph->num_parents - dashless_commits) * 2) - 1;
+	for (i = 0; i < num_dashes; i++) {
+		col_num = (i / 2) + dashless_commits;
+		strbuf_write_column(sb, &graph->new_columns[col_num], '-');
+	}
+	col_num = (i / 2) + dashless_commits;
+	strbuf_write_column(sb, &graph->new_columns[col_num], '.');
+}
+
 static void graph_output_commit_line(struct git_graph *graph, struct strbuf *sb)
 {
 	int seen_this = 0;
-	int i, j;
+	int i;
 
 	/*
 	 * Output the row containing this commit
@@ -728,6 +824,7 @@ static void graph_output_commit_line(struct git_graph *graph, struct strbuf *sb)
 	 */
 	seen_this = 0;
 	for (i = 0; i <= graph->num_columns; i++) {
+		struct column *col = &graph->columns[i];
 		struct commit *col_commit;
 		if (i == graph->num_columns) {
 			if (seen_this)
@@ -741,17 +838,10 @@ static void graph_output_commit_line(struct git_graph *graph, struct strbuf *sb)
 			seen_this = 1;
 			graph_output_commit_char(graph, sb);
 
-			if (graph->num_parents < 3)
-				strbuf_addch(sb, ' ');
-			else {
-				int num_dashes =
-					((graph->num_parents - 2) * 2) - 1;
-				for (j = 0; j < num_dashes; j++)
-					strbuf_addch(sb, '-');
-				strbuf_addstr(sb, ". ");
-			}
+			if (graph->num_parents > 3)
+				graph_draw_octopus_merge(graph, sb);
 		} else if (seen_this && (graph->num_parents > 2)) {
-			strbuf_addstr(sb, "\\ ");
+			strbuf_write_column(sb, col, '\\');
 		} else if (seen_this && (graph->num_parents == 2)) {
 			/*
 			 * This is a 2-way merge commit.
@@ -768,12 +858,13 @@ static void graph_output_commit_line(struct git_graph *graph, struct strbuf *sb)
 			 */
 			if (graph->prev_state == GRAPH_POST_MERGE &&
 			    graph->prev_commit_index < i)
-				strbuf_addstr(sb, "\\ ");
+				strbuf_write_column(sb, col, '\\');
 			else
-				strbuf_addstr(sb, "| ");
+				strbuf_write_column(sb, col, '|');
 		} else {
-			strbuf_addstr(sb, "| ");
+			strbuf_write_column(sb, col, '|');
 		}
+		strbuf_addch(sb, ' ');
 	}
 
 	graph_pad_horizontally(graph, sb);
@@ -789,6 +880,17 @@ static void graph_output_commit_line(struct git_graph *graph, struct strbuf *sb)
 		graph_update_state(graph, GRAPH_COLLAPSING);
 }
 
+inline struct column *find_new_column_by_commit(struct git_graph *graph,
+						struct commit *commit)
+{
+	int i;
+	for (i = 0; i < graph->num_new_columns; i++) {
+		if (graph->new_columns[i].commit == commit)
+			return &graph->new_columns[i];
+	}
+	return 0;
+}
+
 static void graph_output_post_merge_line(struct git_graph *graph, struct strbuf *sb)
 {
 	int seen_this = 0;
@@ -798,24 +900,46 @@ static void graph_output_post_merge_line(struct git_graph *graph, struct strbuf
 	 * Output the post-merge row
 	 */
 	for (i = 0; i <= graph->num_columns; i++) {
+		struct column *col = &graph->columns[i];
 		struct commit *col_commit;
 		if (i == graph->num_columns) {
 			if (seen_this)
 				break;
 			col_commit = graph->commit;
 		} else {
-			col_commit = graph->columns[i].commit;
+			col_commit = col->commit;
 		}
 
 		if (col_commit == graph->commit) {
+			/*
+			 * Since the current commit is a merge find
+			 * the columns for the parent commits in
+			 * new_columns and use those to format the
+			 * edges.
+			 */
+			struct commit_list *parents = NULL;
+			struct column *par_column;
 			seen_this = 1;
-			strbuf_addch(sb, '|');
-			for (j = 0; j < graph->num_parents - 1; j++)
-				strbuf_addstr(sb, "\\ ");
+			parents = first_interesting_parent(graph);
+			assert(parents);
+			par_column = find_new_column_by_commit(graph,parents->item);
+			assert(par_column);
+
+			strbuf_write_column(sb, par_column, '|');
+			for (j = 0; j < graph->num_parents - 1; j++) {
+				parents = next_interesting_parent(graph, parents);
+				assert(parents);
+				par_column = find_new_column_by_commit(graph,parents->item);
+				assert(par_column);
+				strbuf_write_column(sb, par_column, '\\');
+				strbuf_addch(sb, ' ');
+			}
 		} else if (seen_this) {
-			strbuf_addstr(sb, "\\ ");
+			strbuf_write_column(sb, col, '\\');
+			strbuf_addch(sb, ' ');
 		} else {
-			strbuf_addstr(sb, "| ");
+			strbuf_write_column(sb, col, '|');
+			strbuf_addch(sb, ' ');
 		}
 	}
 
@@ -912,9 +1036,11 @@ static void graph_output_collapsing_line(struct git_graph *graph, struct strbuf
 		if (target < 0)
 			strbuf_addch(sb, ' ');
 		else if (target * 2 == i)
-			strbuf_addch(sb, '|');
-		else
-			strbuf_addch(sb, '/');
+			strbuf_write_column(sb, &graph->new_columns[target], '|');
+		else {
+			strbuf_write_column(sb, &graph->new_columns[target], '/');
+
+		}
 	}
 
 	graph_pad_horizontally(graph, sb);
@@ -979,9 +1105,10 @@ static void graph_padding_line(struct git_graph *graph, struct strbuf *sb)
 	 * children that we have already processed.)
 	 */
 	for (i = 0; i < graph->num_columns; i++) {
-		struct commit *col_commit = graph->columns[i].commit;
+		struct column *col = &graph->columns[i];
+		struct commit *col_commit = col->commit;
 		if (col_commit == graph->commit) {
-			strbuf_addch(sb, '|');
+			strbuf_write_column(sb, col, '|');
 
 			if (graph->num_parents < 3)
 				strbuf_addch(sb, ' ');
@@ -991,7 +1118,8 @@ static void graph_padding_line(struct git_graph *graph, struct strbuf *sb)
 					strbuf_addch(sb, ' ');
 			}
 		} else {
-			strbuf_addstr(sb, "| ");
+			strbuf_write_column(sb, col, '|');
+			strbuf_addch(sb, ' ');
 		}
 	}
 
diff --git a/strbuf.c b/strbuf.c
index a884960..f525d51 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -1,3 +1,4 @@
+#include <ctype.h>
 #include "cache.h"
 #include "refs.h"
 
@@ -138,6 +139,44 @@ void strbuf_list_free(struct strbuf **sbs)
 	free(sbs);
 }
 
+/*
+ * Return the length of the escape sequence in a string buffer
+ * starting at index i.  If there is no escape sequence starting at
+ * return 0.
+ */
+inline size_t strbuf_esc_sequence_length(const struct strbuf *sb, size_t i)
+{
+	size_t start = i;
+	if (sb->buf[i] != '\033')
+		return 0;
+	++i;
+
+	if (i >= sb->len || sb->buf[i] != '[')
+		return 0;
+	++i;
+	while (i < sb->len && isdigit(sb->buf[i]))
+		++i;
+
+	if (i >= sb->len || sb->buf[i] != 'm')
+		return 0;
+	return i - start;
+}
+
+size_t strbuf_count_printing_chars(const struct strbuf *sb)
+{
+	int i;
+	size_t n = 0;
+	size_t esc_len;
+	for (i = 0; i < sb->len; i++) {
+		esc_len = strbuf_esc_sequence_length(sb, i);
+		if (esc_len)
+			i += esc_len;
+		else if (isgraph(sb->buf[i]) || sb->buf[i] == ' ')
+			++n;
+	}
+	return n;
+}
+
 int strbuf_cmp(const struct strbuf *a, const struct strbuf *b)
 {
 	int len = a->len < b->len ? a->len: b->len;
diff --git a/strbuf.h b/strbuf.h
index 9ee908a..3851ddf 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -86,6 +86,7 @@ extern void strbuf_tolower(struct strbuf *);
 extern struct strbuf **strbuf_split(const struct strbuf *, int delim);
 extern void strbuf_list_free(struct strbuf **);
 
+extern size_t strbuf_count_printing_chars(const struct strbuf *sb);
 /*----- add data in your buffer -----*/
 static inline void strbuf_addch(struct strbuf *sb, int c) {
 	strbuf_grow(sb, 1);
-- 
1.5.6.3
