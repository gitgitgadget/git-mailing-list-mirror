From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [WIP PATCH 19/22] Make graph_next_line external to other part of git
Date: Sat, 24 Jul 2010 23:13:51 +0800
Message-ID: <1279984434-28933-20-git-send-email-struggleyb.nku@gmail.com>
References: <1279984434-28933-1-git-send-email-struggleyb.nku@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 24 17:16:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcgST-0002K0-KL
	for gcvg-git-2@lo.gmane.org; Sat, 24 Jul 2010 17:16:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756354Ab0GXPPw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jul 2010 11:15:52 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:58504 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756181Ab0GXPPc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jul 2010 11:15:32 -0400
Received: by mail-pw0-f46.google.com with SMTP id 5so3932862pwi.19
        for <git@vger.kernel.org>; Sat, 24 Jul 2010 08:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=3oIlrklVzxEEwLZte1pQi7v1mDPqu1Z4i7IZWTXA1/E=;
        b=PtucdvyZGJYklF1ygRmiuqxWZJiNbG6jt745DE+a1Fk2KdSS2tiLrqbAqIGIfVFzB9
         /ioedXmFN21jPoaD3UuLrEMglfkXE4wgX/9Yh43m4oHi+qWhL32KB+lOSvHrl3N4qYMJ
         mVBJMiJg+JG9ooKhgLklL+Ndpk11392sPLPTU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        b=XC2tWQdOgnNGUFd8OVNmA3ew99KLFuI/0D7hcA2H4I6OdKQ1jsvnWNlwWuNQaNDgof
         +Vu/elDGBU7CriBSjUezOZZUeCjkl3iMbiavtA0z6yPMTxV0cyBN60BsKLF18XvaBFMg
         bRlPXcsuUSGTCjfNe96dy1BlYsMIZWF5DKksc=
Received: by 10.142.136.1 with SMTP id j1mr5887078wfd.331.1279984532331;
        Sat, 24 Jul 2010 08:15:32 -0700 (PDT)
Received: from localhost.localdomain ([58.68.143.121])
        by mx.google.com with ESMTPS id w8sm1705169wfd.19.2010.07.24.08.15.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 24 Jul 2010 08:15:31 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.rc3.80.g6f8ea9.dirty
In-Reply-To: <1279984434-28933-1-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151655>

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
1.7.0.2.273.gc2413.dirty
