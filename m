From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH v4 13/18] Make graph_next_line external to other part of git
Date: Fri,  6 Aug 2010 00:11:52 +0800
Message-ID: <1281024717-7855-14-git-send-email-struggleyb.nku@gmail.com>
References: <1281024717-7855-1-git-send-email-struggleyb.nku@gmail.com>
Cc: trast@student.ethz.ch, Jens.Lehmann@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 05 18:14:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oh35J-0001XF-1T
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 18:14:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933630Ab0HEQN2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Aug 2010 12:13:28 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:59045 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933595Ab0HEQNX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 12:13:23 -0400
Received: by mail-px0-f174.google.com with SMTP id 14so2531057pxi.19
        for <git@vger.kernel.org>; Thu, 05 Aug 2010 09:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=0WFRTHBy38IYhbnSr8pc+XtL4qntS7ti6nM/YuOOyUE=;
        b=DpHu/X6mtgQ0vd8lzOachm11MbYPLTp8R/c/n6OEAXmsJKZy3zuc9gJDhO0nTCV6+w
         wfNIbxR1BXzn128vQ/OqpDYtWDAi9JoSy/M6D8oTHSAv3CtfQYkkDWTuHY1Ipo4f7cRl
         Lueq/aikLrDh8BMAgyaAwTd8wG5bB17aSXry8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=qLnKoD1hhG5T/WtDJ/mhHGOEsNfBticSS2U3+u+qDmBTiHdRbn/6gP5nlmZDKpoOk3
         ++lL6JT8hmGpIkJVW5dUEGsl9D+3R9pfoIYyvR9gAf4mQlOlSifgJ8DZE6DLJyfuKx9b
         VV1Dd+4I3qw6jYIkif5qNlHq7Fs0O7Te3FfPE=
Received: by 10.142.134.12 with SMTP id h12mr5070077wfd.185.1281024802954;
        Thu, 05 Aug 2010 09:13:22 -0700 (PDT)
Received: from localhost.localdomain ([222.35.120.192])
        by mx.google.com with ESMTPS id w8sm343653wfd.19.2010.08.05.09.13.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 05 Aug 2010 09:13:22 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.20.g388bbb
In-Reply-To: <1281024717-7855-1-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152679>

We will use it in line level log output.

Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
---
 graph.c |   14 +-------------
 graph.h |   10 ++++++++++
 2 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/graph.c b/graph.c
index ac7c605..824e055 100644
--- a/graph.c
+++ b/graph.c
@@ -4,21 +4,9 @@
 #include "graph.h"
 #include "diff.h"
 #include "revision.h"
-
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
@@ -1143,7 +1131,7 @@ static void graph_output_collapsing_line(struct git_graph *graph, struct strbuf
 		graph_update_state(graph, GRAPH_PADDING);
 }
 
-static int graph_next_line(struct git_graph *graph, struct strbuf *sb)
+int graph_next_line(struct git_graph *graph, struct strbuf *sb)
 {
 	switch (graph->state) {
 	case GRAPH_PADDING:
diff --git a/graph.h b/graph.h
index b82ae87..5b3f059 100644
--- a/graph.h
+++ b/graph.h
@@ -32,6 +32,16 @@ void graph_update(struct git_graph *graph, struct commit *commit);
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
 
 /*
  * graph_show_*: helper functions for printing to stdout
-- 
1.7.2.20.g388bbb
