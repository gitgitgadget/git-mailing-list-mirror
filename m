From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: [PATCH 1/2] graph: simplify graph_padding_line()
Date: Sat, 20 Sep 2014 20:29:53 +0200
Message-ID: <541DC7A1.1000509@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 20 20:30:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XVPQM-0002Vj-7z
	for gcvg-git-2@plane.gmane.org; Sat, 20 Sep 2014 20:30:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757393AbaITSaR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Sep 2014 14:30:17 -0400
Received: from mout.web.de ([212.227.15.4]:64318 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757000AbaITSaQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Sep 2014 14:30:16 -0400
Received: from [192.168.178.27] ([79.253.175.32]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0Lb1nV-1YApq63nrd-00kgRz; Sat, 20 Sep 2014 20:30:11
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.1.1
X-Provags-ID: V03:K0:4Kwi3FrmB5hWdGkoba7EweJoMlAQhKk8Br6vxRh1I/a974WZaDk
 EXepG5kBF9VS77VltKWQ1mZxxku5mfuCVsR6wjFh81G//7x5Y7kmychZjAjB/N65vy652g8
 xlRl+wu60ksXilZwDYCv0fprqzJTs5qDDWKFLBNhpLD6JaV0DbI7jgbefkAp2x4uaWIm0Ca
 ifKAMecqcenH5qjjdPELQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257329>

Deduplicate code common to both branches of if statements.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 graph.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/graph.c b/graph.c
index dfb99f6..52605e4 100644
--- a/graph.c
+++ b/graph.c
@@ -1161,20 +1161,11 @@ static void graph_padding_line(struct git_graph *graph, struct strbuf *sb)
 	 */
 	for (i = 0; i < graph->num_columns; i++) {
 		struct column *col = &graph->columns[i];
-		struct commit *col_commit = col->commit;
-		if (col_commit == graph->commit) {
-			strbuf_write_column(sb, col, '|');
-
-			if (graph->num_parents < 3)
-				strbuf_addch(sb, ' ');
-			else {
-				int num_spaces = ((graph->num_parents - 2) * 2);
-				strbuf_addchars(sb, ' ', num_spaces);
-			}
-		} else {
-			strbuf_write_column(sb, col, '|');
+		strbuf_write_column(sb, col, '|');
+		if (col->commit == graph->commit && graph->num_parents > 2)
+			strbuf_addchars(sb, ' ', (graph->num_parents - 2) * 2);
+		else
 			strbuf_addch(sb, ' ');
-		}
 	}
 
 	graph_pad_horizontally(graph, sb, graph->num_columns);
-- 
2.1.1
