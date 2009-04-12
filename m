From: Allan Caffee <allan.caffee@gmail.com>
Subject: [PATCH v4] graph API: Added logic for colored edges
Date: Sun, 12 Apr 2009 16:27:09 -0400
Message-ID: <20090412202709.GA20549@linux.vnet>
References: <7vk55p7lu3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Teemu Likonen <tlikonen@iki.fi>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 12 22:29:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lt6If-0004DL-UR
	for gcvg-git-2@gmane.org; Sun, 12 Apr 2009 22:29:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751613AbZDLU1U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Apr 2009 16:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751103AbZDLU1T
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Apr 2009 16:27:19 -0400
Received: from rv-out-0506.google.com ([209.85.198.235]:1643 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750758AbZDLU1S (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Apr 2009 16:27:18 -0400
Received: by rv-out-0506.google.com with SMTP id f9so1766578rvb.1
        for <git@vger.kernel.org>; Sun, 12 Apr 2009 13:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mail-followup-to:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=RH4+up38JUM6MdXseVP2ifB5w0xwD3gyrFNSDnAd62k=;
        b=GWmP1kmLwaBVHP0d+qkGqOs8QvJnUQwFV4wiS6dQX7oBKcXB1BkWP2Zh2gzj4B6K7g
         NPU+j7R2cwgCdi/T8xDHTmtKGBNheORoriHQHUKuDaiP5FdVBr9wOTkKVr4GHydCmuta
         7ohdxCtAV0QfpQuLcYBlgFb3kotk5laUde6KE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=iLpHLWgrcDFOljKTG/eq1UCcrUP2gsKiM9O3WTDCKSmEIDA8rCxl/6y0bTCtqG2HW6
         rN3G0bhs42ORggza0plS3gdxWAz6e2bf5rZNepprQS6Kvo89JSTtTS6R3m1OM8RM9ljp
         HMrLbsGRJb2Rfdwo+0OvWjOsXlBYkW1nSn/Aw=
Received: by 10.142.76.15 with SMTP id y15mr2303365wfa.263.1239568035872;
        Sun, 12 Apr 2009 13:27:15 -0700 (PDT)
Received: from linux.vnet (pool-71-185-49-127.phlapa.fios.verizon.net [71.185.49.127])
        by mx.google.com with ESMTPS id 30sm14228223wfg.34.2009.04.12.13.27.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 12 Apr 2009 13:27:15 -0700 (PDT)
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, Nanako Shiraishi <nanako3@lavabit.com>,
	Teemu Likonen <tlikonen@iki.fi>
Content-Disposition: inline
In-Reply-To: <7vk55p7lu3.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116392>

Modified the graph drawing logic to colorize edges based on parent-child
relationships similiarly to gitk.

Signed-off-by: Allan Caffee <allan.caffee@gmail.com>
---

On Sun, 12 Apr 2009, Junio C Hamano wrote:

> Allan Caffee <allan.caffee@gmail.com> writes:
>
> >> > +const unsigned short GIT_NOT_A_COLOR = -1;
> >>
> >> That (-1) is an unusual value for an *unsigned* short variable.
> >
> > Perhaps you would prefer USHRT_MAX?  I noticed that none of the
> > existing
> > code #includes limits.h.  Is it safe to assume this header is
> > present?
>
> I expected to see something like
>
>       #define COLUMN_COLORS_MAX (ARRAY_SIZE(column_colors)+1)
>
>       write_with_color(...) {
>                 if (c->color < COLUMN_COLORS_MAX)
>                         add color prefix;
>                 add string
>                 if (c->color < COLUMN_COLORS_MAX)
>                         add color suffix;
>       }
>
> instead, actually, and was a bit surprised with (-1).

Junio,

I assumed that the +1 in your example was a typo since AFAIKS ARRAY_SIZE
should give us one past the last index.  If that's not correct let me
know and I'll fix it.

Also if git is to be expanded allow the use of non-ANSI color codes (or
already does so) the strbuf_escape_sequence_length needs to be updated
to accept the relevant escape codes.

Thanks for all the help,
Allan

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
index 162a516..1ae7a9c 100644
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
 
+#define COLUMN_COLORS_MAX (ARRAY_SIZE(column_colors))
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
+	if (c->color < COLUMN_COLORS_MAX)
+		strbuf_addstr(sb, column_get_color_code(c));
+	strbuf_addch(sb, col_char);
+	if (c->color < COLUMN_COLORS_MAX)
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
 
+unsigned short graph_get_current_column_color(const struct git_graph *graph)
+{
+	if (!DIFF_OPT_TST(&graph->revs->diffopt, COLOR_DIFF))
+		return COLUMN_COLORS_MAX;
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
+unsigned short graph_find_commit_color(const struct git_graph *graph,
+				       const struct commit *commit)
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
 
+void graph_draw_octopus_merge(const struct git_graph *graph,
+			      struct strbuf *sb)
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
 
+struct column *find_new_column_by_commit(struct git_graph *graph,
+					 struct commit *commit)
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
index a884960..666460d 100644
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
+size_t strbuf_esc_sequence_length(const struct strbuf *sb, size_t i)
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
