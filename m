From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/6] Rename git_one_line() to git_line_length() and export
 it
Date: Mon, 16 Jul 2007 00:22:00 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707160021390.14781@racer.site>
References: <Pine.LNX.4.64.0707152326080.14781@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Alberto Bertogli <albertito@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com, Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Jul 16 01:22:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IADQ8-00019c-8r
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 01:22:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756835AbXGOXWR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 19:22:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755838AbXGOXWR
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 19:22:17 -0400
Received: from mail.gmx.net ([213.165.64.20]:53453 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754729AbXGOXWQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2007 19:22:16 -0400
Received: (qmail invoked by alias); 15 Jul 2007 23:22:14 -0000
Received: from R04e1.r.pppool.de (EHLO noname) [89.54.4.225]
  by mail.gmx.net (mp003) with SMTP; 16 Jul 2007 01:22:14 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19ZnzM7vcZZN7mmDf7pvYFsMa6BVrmdVtLByDyHaY
	22dUaa6AaG6aQd
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0707152326080.14781@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52600>


The function get_one_line() really returns the line length, not the
whole line, but it is really useful, so do not hide it in commit.c,
under the wrong name.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 commit.c |   10 +++++-----
 commit.h |    1 +
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/commit.c b/commit.c
index 4c5dfa9..0c350bc 100644
--- a/commit.c
+++ b/commit.c
@@ -458,7 +458,7 @@ void clear_commit_marks(struct commit *commit, unsigned int mark)
 /*
  * Generic support for pretty-printing the header
  */
-static int get_one_line(const char *msg, unsigned long len)
+int get_line_length(const char *msg, unsigned long len)
 {
 	int ret = 0;
 
@@ -950,7 +950,7 @@ static void pp_header(enum cmit_fmt fmt,
 	for (;;) {
 		const char *line = *msg_p;
 		char *dst;
-		int linelen = get_one_line(*msg_p, *len_p);
+		int linelen = get_line_length(*msg_p, *len_p);
 		unsigned long len;
 
 		if (!linelen)
@@ -1041,7 +1041,7 @@ static void pp_title_line(enum cmit_fmt fmt,
 	title = xmalloc(title_alloc);
 	for (;;) {
 		const char *line = *msg_p;
-		int linelen = get_one_line(line, *len_p);
+		int linelen = get_line_length(line, *len_p);
 		*msg_p += linelen;
 		*len_p -= linelen;
 
@@ -1118,7 +1118,7 @@ static void pp_remainder(enum cmit_fmt fmt,
 	int first = 1;
 	for (;;) {
 		const char *line = *msg_p;
-		int linelen = get_one_line(line, *len_p);
+		int linelen = get_line_length(line, *len_p);
 		*msg_p += linelen;
 		*len_p -= linelen;
 
@@ -1214,7 +1214,7 @@ unsigned long pretty_print_commit(enum cmit_fmt fmt,
 
 	/* Skip excess blank lines at the beginning of body, if any... */
 	for (;;) {
-		int linelen = get_one_line(msg, len);
+		int linelen = get_line_length(msg, len);
 		int ll = linelen;
 		if (!linelen)
 			break;
diff --git a/commit.h b/commit.h
index 467872e..fc6df23 100644
--- a/commit.h
+++ b/commit.h
@@ -60,6 +60,7 @@ enum cmit_fmt {
 	CMIT_FMT_UNSPECIFIED,
 };
 
+extern int get_line_length(const char *msg, unsigned long len);
 extern enum cmit_fmt get_commit_format(const char *arg);
 extern unsigned long pretty_print_commit(enum cmit_fmt fmt, const struct commit *, unsigned long len, char **buf_p, unsigned long *space_p, int abbrev, const char *subject, const char *after_subject, enum date_mode dmode);
 
-- 
1.5.3.rc1.2718.gd2dc9-dirty
