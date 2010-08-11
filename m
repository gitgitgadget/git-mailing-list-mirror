From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH V5 12/17] Make graph_next_line external to other part of git
Date: Wed, 11 Aug 2010 23:03:37 +0800
Message-ID: <1281539022-31616-13-git-send-email-struggleyb.nku@gmail.com>
References: <1281539022-31616-1-git-send-email-struggleyb.nku@gmail.com>
Cc: Jens.Lehmann@web.de, trast@student.ethz.ch, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 11 17:06:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjCsT-0005Yv-Iv
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 17:06:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753761Ab0HKPFf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Aug 2010 11:05:35 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:62685 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753748Ab0HKPFd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Aug 2010 11:05:33 -0400
Received: by mail-pv0-f174.google.com with SMTP id 2so75417pvg.19
        for <git@vger.kernel.org>; Wed, 11 Aug 2010 08:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=4UXWwZklq7FCO8N8ns/IVnRWkmgyMN6XatTDRQfZLIg=;
        b=PFMUYvf6CltwGx86M8VOfb2nHYd5qZ9frlP7vxxmelYiNMyf+17D7kQePlKpNZQ7wb
         3A9/NGPXPA8FXSQ3/Jq8z4tWwLXf2TeDbS60s+vkvImCxQlnCTr70SrQ6gWhGiMsz5aG
         gPtAcAmBUHqwZA4LZ9oQCB2mBnmQ7LAtSWgfE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=pLcJZzFDBOwMyj7rftBNwC7Fmzs88lvgu5rn2+GyFNu67zKaawaRqXBJuE6u+Idv32
         ZKq7Rc9Av9TDDXyfznPThCUiMvADYDcI8exIFWbG1brLrCVd9cJqf1B7GmXy/K7UlfZL
         JJsfFdJFh+AumI+B2jCyaGPyZZmuw8stDxsiA=
Received: by 10.114.93.19 with SMTP id q19mr22107490wab.206.1281539133519;
        Wed, 11 Aug 2010 08:05:33 -0700 (PDT)
Received: from localhost.localdomain ([116.226.85.245])
        by mx.google.com with ESMTPS id c10sm356199wam.1.2010.08.11.08.05.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 11 Aug 2010 08:05:32 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.19.g79e5d
In-Reply-To: <1281539022-31616-1-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153249>

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
1.7.2.19.g79e5d
