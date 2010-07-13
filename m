From: Johan Herland <johan@herland.net>
Subject: [PATCH 1/2] Make graph_next_line() available in the graph.h API
Date: Tue, 13 Jul 2010 23:23:38 +0200
Message-ID: <1279056219-27096-2-git-send-email-johan@herland.net>
References: <1279056219-27096-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, johan@herland.net,
	Lars Hjemli <hjemli@gmail.com>, nanako3@lavabit.com,
	adam@adamsimpkins.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 13 23:23:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYmxK-00066v-SG
	for gcvg-git-2@lo.gmane.org; Tue, 13 Jul 2010 23:23:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756216Ab0GMVXt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jul 2010 17:23:49 -0400
Received: from smtp.getmail.no ([84.208.15.66]:63069 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752574Ab0GMVXq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jul 2010 17:23:46 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L5I00AQ3M3JA650@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Tue, 13 Jul 2010 23:23:43 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 356A61EA5B9B_C3CD95FB	for <git@vger.kernel.org>; Tue,
 13 Jul 2010 21:23:43 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id DBD7E1EA35BA_C3CD95EF	for <git@vger.kernel.org>; Tue,
 13 Jul 2010 21:23:42 +0000 (GMT)
Received: from alpha.herland ([84.215.68.234]) by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L5I00746M3I0N00@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Tue, 13 Jul 2010 23:23:42 +0200 (MEST)
X-Mailer: git-send-email 1.7.0.4
In-reply-to: <1279056219-27096-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150919>

In order to successfully use the graph API from a context other than the
stdout/command-line scenario (where the graph_show_* functions are
suitable), we need direct access to graph_next_line(), to drive the
graph drawing process.

Signed-off-by: Johan Herland <johan@herland.net>
---
 graph.c |   13 +------------
 graph.h |   11 +++++++++++
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/graph.c b/graph.c
index ac7c605..47397da 100644
--- a/graph.c
+++ b/graph.c
@@ -8,17 +8,6 @@
 /* Internal API */
 
 /*
- * Output the next line for a graph.
- * This formats the next graph line into the specified strbuf.  It is not
- * terminated with a newline.
- *
- * Returns 1 if the line includes the current commit, and 0 otherwise.
- * graph_next_line() will return 1 exactly once for each time
- * graph_update() is called.
- */
-static int graph_next_line(struct git_graph *graph, struct strbuf *sb);
-
-/*
  * Output a padding line in the graph.
  * This is similar to graph_next_line().  However, it is guaranteed to
  * never print the current commit line.  Instead, if the commit line is
@@ -1143,7 +1132,7 @@ static void graph_output_collapsing_line(struct git_graph *graph, struct strbuf
 		graph_update_state(graph, GRAPH_PADDING);
 }
 
-static int graph_next_line(struct git_graph *graph, struct strbuf *sb)
+int graph_next_line(struct git_graph *graph, struct strbuf *sb)
 {
 	switch (graph->state) {
 	case GRAPH_PADDING:
diff --git a/graph.h b/graph.h
index b82ae87..f188168 100644
--- a/graph.h
+++ b/graph.h
@@ -32,6 +32,17 @@ void graph_update(struct git_graph *graph, struct commit *commit);
  */
 int graph_is_commit_finished(struct git_graph const *graph);
 
+/*
+ * Output the next line for a graph.
+ * This formats the next graph line into the specified strbuf.  It is not
+ * terminated with a newline.
+ *
+ * Returns 1 if the line includes the current commit, and 0 otherwise.
+ * graph_next_line() will return 1 exactly once for each time
+ * graph_update() is called.
+ */
+int graph_next_line(struct git_graph *graph, struct strbuf *sb);
+
 
 /*
  * graph_show_*: helper functions for printing to stdout
-- 
1.7.0.4
