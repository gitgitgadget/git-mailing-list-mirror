From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] status: be prepared for not-yet-started interactive rebase
Date: Fri, 22 Jan 2016 17:28:40 +0100 (CET)
Message-ID: <99f6de4be107044fdf01ee796f42e124ac147891.1453480067.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 22 17:29:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMea4-0004Ep-9e
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jan 2016 17:29:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753443AbcAVQ25 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2016 11:28:57 -0500
Received: from mout.gmx.net ([212.227.17.22]:53568 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754230AbcAVQ2z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2016 11:28:55 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MaV3V-1ageQt1vUf-00K9Kv; Fri, 22 Jan 2016 17:28:42
 +0100
X-X-Sender: virtualbox@virtualbox
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:nsb8dH1MDbT7OSzYlQQL9BY9dG0x8MbjZR0oEp7jMPI5KnIEiob
 kdGOt5/229U3vKxpyflJeGTA89LRGiIruL6nWBrlWjtt14QueQvfK7zLvEhHkAAtCrt7DpG
 7q9IaR8/TLqK16/GIyAGl/8gvHk/PYEhCZfWK7yX0oK8cK8jGLkacWaRVJjRhEUHH8kruXv
 hGxPjwN0sFXzPxacyg9Gw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:EjSr3BwD9VE=:apuF2xif9cTbMhv4DXIPZv
 Gne/kLmbnBzhhY4oXCDhnjElI/vYOYAcWRDNCu2xIwDKvAKlNxf5MSzf0fHmef7yyc2Si//Ke
 unynNOei7aeIfHWyewtWb6CcZPZVLbklJopJ6VDvVY8Ve7EZ/aXjgh+xjQSY5adyRTFk7ZXik
 dW5az6PVtv/7DSEKhwg9vAZy6T/RzR5vhIbYdcr75KLK/FcajIcBIlrpXxYJMKP366sMD4OZq
 xmGbf3WvuaQeGg7lX+mMwtloxipLkJ4GEXSoD6KSzzD6GAMB38pMoQu+UtsUZWINKXexsBFGc
 7pZK+GTywEifKM8oskfcDKq1thkYA2ZTtDSo7/67EytlKCgDOqPRlGs6gTLIs7/q+mTIvWuFV
 G16nDm47RBARwMnQfC+GQBOwTGVqN/TSYwYdUyOF/Q8Xcf5vVP7sgdbX+6VINT9q6kiegGtiY
 9CPBpK0n88TOXQhSHshog36j+2f6KAmDBNu1dbdnvTNTN1CBzBSYRrQ9bxp/qCirw00cGY9HJ
 IcJeULgh40Zrp1SswHUZ/PuBVng9M2pFZic6iGlMoTgfb23SHbhRq212Ebx7ZuK5o37ePDTIf
 2wQHXv14eheNbFHNhT7eG4hP51qCE/SqV9yRYZAUk+zVi3+7sqjd1JiRwB1Y7mDYVPaPNNgbo
 /UdwETWO0iqms0g3ePKPkxyXAngTgekFDpBkGkDQ1GW4oBAO/M6X0vDkG2UX5r6h3Fbjm7reO
 UY4cLpqQuG0t1Eii1xFoJ4GrNbY3774w1RSzbAUBXrqclWhKmS3Gzr7zkYOQWvC7CcU1mECp 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284559>

From: Junio C Hamano <gitster@pobox.com>

Some developers might want to call `git status` in a working
directory where they just started an interactive rebase, but the
edit script is still opened in the editor.

Let's show a meaningful message in such cases.

[jes: suppressed the "No commands remaining" message when the
interactive rebase has not started yet.]

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 wt-status.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index bba2596..ce8dfda 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1068,14 +1068,17 @@ static void abbrev_sha1_in_line(struct strbuf *line)
 
 }
 
-static void read_rebase_todolist(const char *fname, struct string_list *lines)
+static int read_rebase_todolist(const char *fname, struct string_list *lines)
 {
 	struct strbuf line = STRBUF_INIT;
 	FILE *f = fopen(git_path("%s", fname), "r");
 
-	if (!f)
+	if (!f) {
+		if (errno == ENOENT)
+			return -1;
 		die_errno("Could not open file %s for reading",
 			  git_path("%s", fname));
+	}
 	while (!strbuf_getline(&line, f, '\n')) {
 		if (line.len && line.buf[0] == comment_line_char)
 			continue;
@@ -1085,6 +1088,7 @@ static void read_rebase_todolist(const char *fname, struct string_list *lines)
 		abbrev_sha1_in_line(&line);
 		string_list_append(lines, line.buf);
 	}
+	return 0;
 }
 
 static void show_rebase_information(struct wt_status *s,
@@ -1098,10 +1102,12 @@ static void show_rebase_information(struct wt_status *s,
 		struct string_list have_done = STRING_LIST_INIT_DUP;
 		struct string_list yet_to_do = STRING_LIST_INIT_DUP;
 
-		read_rebase_todolist("rebase-merge/done", &have_done);
-		read_rebase_todolist("rebase-merge/git-rebase-todo", &yet_to_do);
-
-		if (have_done.nr == 0)
+		if ((read_rebase_todolist("rebase-merge/done", &have_done)) ||
+		    (read_rebase_todolist("rebase-merge/git-rebase-todo",
+				  &yet_to_do)))
+			status_printf_ln(s, color,
+				_("rebase-i not started yet."));
+		else if (have_done.nr == 0)
 			status_printf_ln(s, color, _("No commands done."));
 		else {
 			status_printf_ln(s, color,
@@ -1119,7 +1125,9 @@ static void show_rebase_information(struct wt_status *s,
 					_("  (see more in file %s)"), git_path("rebase-merge/done"));
 		}
 
-		if (yet_to_do.nr == 0)
+		if (have_done.nr == 0)
+			; /* do nothing */
+		else if (yet_to_do.nr == 0)
 			status_printf_ln(s, color,
 					 _("No commands remaining."));
 		else {
-- 
2.7.0.windows.1.7.g55a05c8
