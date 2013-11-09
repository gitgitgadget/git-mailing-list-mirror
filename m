From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 52/86] builtin/commit: replace prefixcmd() with has_prefix()
Date: Sat, 09 Nov 2013 08:06:45 +0100
Message-ID: <20131109070720.18178.60526.chriscool@tuxfamily.org>
References: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 09 08:09:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vf2g4-0003eY-2g
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 08:09:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933327Ab3KIHJo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Nov 2013 02:09:44 -0500
Received: from mail-2y.bbox.fr ([194.158.98.15]:36319 "EHLO mail-2y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933286Ab3KIHIm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 02:08:42 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id 8A3EAB1;
	Sat,  9 Nov 2013 08:08:41 +0100 (CET)
X-git-sha1: 1f71b03aebb0c9d9d907bf8fc5cef00fe63d0780 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237504>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/commit.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 6ab4605..a8c46c6 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -733,7 +733,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 				eol = nl - sb.buf;
 			else
 				eol = sb.len;
-			if (!prefixcmp(sb.buf + previous, "\nConflicts:\n")) {
+			if (has_prefix(sb.buf + previous, "\nConflicts:\n")) {
 				ignore_footer = sb.len - previous;
 				break;
 			}
@@ -904,7 +904,7 @@ static int rest_is_empty(struct strbuf *sb, int start)
 			eol = sb->len;
 
 		if (strlen(sign_off_header) <= eol - i &&
-		    !prefixcmp(sb->buf + i, sign_off_header)) {
+		    has_prefix(sb->buf + i, sign_off_header)) {
 			i = eol;
 			continue;
 		}
@@ -1183,7 +1183,7 @@ static int git_status_config(const char *k, const char *v, void *cb)
 {
 	struct wt_status *s = cb;
 
-	if (!prefixcmp(k, "column."))
+	if (has_prefix(k, "column."))
 		return git_column_config(k, v, "status", &s->colopts);
 	if (!strcmp(k, "status.submodulesummary")) {
 		int is_bool;
@@ -1211,7 +1211,7 @@ static int git_status_config(const char *k, const char *v, void *cb)
 		s->display_comment_prefix = git_config_bool(k, v);
 		return 0;
 	}
-	if (!prefixcmp(k, "status.color.") || !prefixcmp(k, "color.status.")) {
+	if (has_prefix(k, "status.color.") || has_prefix(k, "color.status.")) {
 		int slot = parse_status_slot(k, 13);
 		if (slot < 0)
 			return 0;
@@ -1377,7 +1377,7 @@ static void print_summary(const char *prefix, const unsigned char *sha1,
 
 	head = resolve_ref_unsafe("HEAD", junk_sha1, 0, NULL);
 	printf("[%s%s ",
-		!prefixcmp(head, "refs/heads/") ?
+		has_prefix(head, "refs/heads/") ?
 			head + 11 :
 			!strcmp(head, "HEAD") ?
 				_("detached HEAD") :
-- 
1.8.4.1.566.geca833c
