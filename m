From: Allan Caffee <allan.caffee@gmail.com>
Subject: [PATCH v2 (resend)] graph API: Use horizontal lines for more
	compact graphs
Date: Mon, 27 Apr 2009 11:43:41 -0400
Message-ID: <20090427154341.GA9818@linux.vnet>
References: <20090422212812.GA30830@linux.vnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 27 17:43:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LySzo-0004qf-4k
	for gcvg-git-2@gmane.org; Mon, 27 Apr 2009 17:43:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756711AbZD0Pns (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2009 11:43:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756469AbZD0Pns
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Apr 2009 11:43:48 -0400
Received: from rv-out-0506.google.com ([209.85.198.230]:11401 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756236AbZD0Pnr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2009 11:43:47 -0400
Received: by rv-out-0506.google.com with SMTP id f9so1859622rvb.1
        for <git@vger.kernel.org>; Mon, 27 Apr 2009 08:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mail-followup-to:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=Nukb9Xnx3jvZ0VshBZYV1hv0hYYsOLM4NaQNjtJXfEo=;
        b=g7DDB6bsUefTrCR8xua3qHoKyMdUlcy6tSqfznrvcVa0wgaYy2kL5dfGv///mwvQeH
         bCVHKZiFxifKqHH2dQxxP2CXPHcd43DqbRuXlqjg8bkYlO2cVMDifsO0y40Nnzd8eVTs
         pQHJkTBlAgFFWnPnny3o4Z3GBBGv5a4y8dzGQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=JWMgzt+HQMVZX53eoWDcR6os/IIEtWZNCRSohGSPbDnynVluevf7xg09m6kGdkoRzt
         sZgGuychPP36pjRbZA0UagCYRxZjh0N4b0ENzaM0wiWW1OISQ3NgEprXz1/cOrIwk4Oj
         JWSZMlSml4iuDKfZhAuc+DD1btm1bniVsmuRA=
Received: by 10.142.132.2 with SMTP id f2mr1158218wfd.175.1240847027437;
        Mon, 27 Apr 2009 08:43:47 -0700 (PDT)
Received: from linux.vnet (n2-51-168.dhcp.drexel.edu [144.118.51.168])
        by mx.google.com with ESMTPS id 9sm1550339wfc.16.2009.04.27.08.43.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 27 Apr 2009 08:43:46 -0700 (PDT)
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20090422212812.GA30830@linux.vnet>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117680>

Use horizontal lines instead of long diagonal lines during the
collapsing state of graph rendering.  For example what used to be:

 | | | | |
 | | | |/
 | | |/|
 | |/| |
 |/| | |
 | | | |
is now
 | | | | |
 | |_|_|/
 |/| | |
 | | | |

resulting in more compact and legible graphs.

Signed-off-by: Allan Caffee <allan.caffee@gmail.com>
---

Junio, is this patch acceptable for inclusion?

 graph.c        |   63 ++++++++++++++++++++++++++++++++++++++++++-------------
 t/t4202-log.sh |    6 +---
 2 files changed, 50 insertions(+), 19 deletions(-)

diff --git a/graph.c b/graph.c
index 06fbeb6..f3fa253 100644
--- a/graph.c
+++ b/graph.c
@@ -47,20 +47,6 @@ static void graph_show_strbuf(struct git_graph *graph, struct strbuf const *sb);
  * - Limit the number of columns, similar to the way gitk does.
  *   If we reach more than a specified number of columns, omit
  *   sections of some columns.
- *
- * - The output during the GRAPH_PRE_COMMIT and GRAPH_COLLAPSING states
- *   could be made more compact by printing horizontal lines, instead of
- *   long diagonal lines.  For example, during collapsing, something like
- *   this:          instead of this:
- *   | | | | |      | | | | |
- *   | |_|_|/       | | | |/
- *   |/| | |        | | |/|
- *   | | | |        | |/| |
- *                  |/| | |
- *                  | | | |
- *
- *   If there are several parallel diagonal lines, they will need to be
- *   replaced with horizontal lines on subsequent rows.
  */
 
 struct column {
@@ -982,6 +968,9 @@ static void graph_output_collapsing_line(struct git_graph *graph, struct strbuf
 {
 	int i;
 	int *tmp_mapping;
+	short used_horizontal = 0;
+	int horizontal_edge = -1;
+	int horizontal_edge_target = -1;
 
 	/*
 	 * Clear out the new_mapping array
@@ -1019,6 +1008,23 @@ static void graph_output_collapsing_line(struct git_graph *graph, struct strbuf
 			 * Move to the left by one
 			 */
 			graph->new_mapping[i - 1] = target;
+			/*
+			 * If there isn't already an edge moving horizontally
+			 * select this one.
+			 */
+			if (horizontal_edge == -1) {
+				int j;
+				horizontal_edge = i;
+				horizontal_edge_target = target;
+				/*
+				 * The variable target is the index of the graph
+				 * column, and therefore target*2+3 is the
+				 * actual screen column of the first horizontal
+				 * line.
+				 */
+				for (j = (target * 2)+3; j < (i - 2); j += 2)
+					graph->new_mapping[j] = target;
+			}
 		} else if (graph->new_mapping[i - 1] == target) {
 			/*
 			 * There is a branch line to our left
@@ -1039,10 +1045,21 @@ static void graph_output_collapsing_line(struct git_graph *graph, struct strbuf
 			 *
 			 * The space just to the left of this
 			 * branch should always be empty.
+			 *
+			 * The branch to the left of that space
+			 * should be our eventual target.
 			 */
 			assert(graph->new_mapping[i - 1] > target);
 			assert(graph->new_mapping[i - 2] < 0);
+			assert(graph->new_mapping[i - 3] == target);
 			graph->new_mapping[i - 2] = target;
+			/*
+			 * Mark this branch as the horizontal edge to
+			 * prevent any other edges from moving
+			 * horizontally.
+			 */
+			if (horizontal_edge == -1)
+				horizontal_edge = i;
 		}
 	}
 
@@ -1061,8 +1078,24 @@ static void graph_output_collapsing_line(struct git_graph *graph, struct strbuf
 			strbuf_addch(sb, ' ');
 		else if (target * 2 == i)
 			strbuf_write_column(sb, &graph->new_columns[target], '|');
-		else
+		else if (target == horizontal_edge_target &&
+			 i != horizontal_edge - 1) {
+				/*
+				 * Set the mappings for all but the
+				 * first segment to -1 so that they
+				 * won't continue into the next line.
+				 */
+				if (i != (target * 2)+3)
+					graph->new_mapping[i] = -1;
+				used_horizontal = 1;
+			strbuf_write_column(sb, &graph->new_columns[target], '_');
+		}
+		else {
+			if (used_horizontal && i < horizontal_edge)
+				graph->new_mapping[i] = -1;
 			strbuf_write_column(sb, &graph->new_columns[target], '/');
+
+		}
 	}
 
 	graph_pad_horizontally(graph, sb, graph->mapping_size);
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 67f983f..076f79e 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -324,14 +324,12 @@ cat > expect <<\EOF
 * | | |   Merge branch 'side'
 |\ \ \ \
 | * | | | side-2
-| | | |/
-| | |/|
+| | |_|/
 | |/| |
 | * | | side-1
 * | | | Second
 * | | | sixth
-| | |/
-| |/|
+| |_|/
 |/| |
 * | | fifth
 * | | fourth
-- 
1.5.6.3
