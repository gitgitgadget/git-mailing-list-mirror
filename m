From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH 1/2] diff: do not color --stat output like patch context
Date: Sat, 25 Apr 2009 00:06:47 +0200
Message-ID: <1240610808-7285-1-git-send-email-markus.heidelberg@web.de>
References: <200904222313.50081.markus.heidelberg@web.de>
Cc: git@vger.kernel.org, Markus Heidelberg <markus.heidelberg@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 25 00:08:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxTYv-000761-2S
	for gcvg-git-2@gmane.org; Sat, 25 Apr 2009 00:08:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754931AbZDXWG1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 18:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754834AbZDXWG0
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 18:06:26 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:46710 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754397AbZDXWG0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 18:06:26 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate01.web.de (Postfix) with ESMTP id 19E5A1009DDA0;
	Sat, 25 Apr 2009 00:06:25 +0200 (CEST)
Received: from [89.59.109.160] (helo=localhost.localdomain)
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1LxTXM-0008K9-00; Sat, 25 Apr 2009 00:06:24 +0200
X-Mailer: git-send-email 1.6.3.rc1.84.g1036b
In-Reply-To: <200904222313.50081.markus.heidelberg@web.de>
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX19IsE/iXVVtxI+U3D3ToeE7E+a86afFpknWBN3j
	uqT2rEHITzoYgf9T+kkXH3D2I/LJchzcbPr1tu222SGMYC9jIP
	XjbYMdol+vd5u77Rc1hA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117497>

The diffstat used the color.diff.plain slot (context text) for coloring
filenames and the whole summary line. This didn't look nice and the
affected text isn't patch context at all.

Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---

    Maybe it's easier to begin with a patch :)

 diff.c |   15 +++++++--------
 1 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/diff.c b/diff.c
index 3ac7168..d581d4d 100644
--- a/diff.c
+++ b/diff.c
@@ -839,10 +839,9 @@ static int scale_linear(int it, int width, int max_change)
 }
 
 static void show_name(FILE *file,
-		      const char *prefix, const char *name, int len,
-		      const char *reset, const char *set)
+		      const char *prefix, const char *name, int len)
 {
-	fprintf(file, " %s%s%-*s%s |", set, prefix, len, name, reset);
+	fprintf(file, " %s%-*s |", prefix, len, name);
 }
 
 static void show_graph(FILE *file, char ch, int cnt, const char *set, const char *reset)
@@ -956,7 +955,7 @@ static void show_stats(struct diffstat_t* data, struct diff_options *options)
 		}
 
 		if (data->files[i]->is_binary) {
-			show_name(options->file, prefix, name, len, reset, set);
+			show_name(options->file, prefix, name, len);
 			fprintf(options->file, "  Bin ");
 			fprintf(options->file, "%s%d%s", del_c, deleted, reset);
 			fprintf(options->file, " -> ");
@@ -966,7 +965,7 @@ static void show_stats(struct diffstat_t* data, struct diff_options *options)
 			continue;
 		}
 		else if (data->files[i]->is_unmerged) {
-			show_name(options->file, prefix, name, len, reset, set);
+			show_name(options->file, prefix, name, len);
 			fprintf(options->file, "  Unmerged\n");
 			continue;
 		}
@@ -988,7 +987,7 @@ static void show_stats(struct diffstat_t* data, struct diff_options *options)
 			add = scale_linear(add, width, max_change);
 			del = scale_linear(del, width, max_change);
 		}
-		show_name(options->file, prefix, name, len, reset, set);
+		show_name(options->file, prefix, name, len);
 		fprintf(options->file, "%5d%s", added + deleted,
 				added + deleted ? " " : "");
 		show_graph(options->file, '+', add, add_c, reset);
@@ -996,8 +995,8 @@ static void show_stats(struct diffstat_t* data, struct diff_options *options)
 		fprintf(options->file, "\n");
 	}
 	fprintf(options->file,
-	       "%s %d files changed, %d insertions(+), %d deletions(-)%s\n",
-	       set, total_files, adds, dels, reset);
+	       " %d files changed, %d insertions(+), %d deletions(-)\n",
+	       total_files, adds, dels);
 }
 
 static void show_shortstats(struct diffstat_t* data, struct diff_options *options)
-- 
1.6.3.rc1.84.g1036b
