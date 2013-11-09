From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 65/86] builtin/mailinfo: replace prefixcmd() with has_prefix()
Date: Sat, 09 Nov 2013 08:06:58 +0100
Message-ID: <20131109070720.18178.13895.chriscool@tuxfamily.org>
References: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 09 08:16:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vf2m5-0002Ge-4P
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 08:16:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933023Ab3KIHP6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Nov 2013 02:15:58 -0500
Received: from mail-3y.bbox.fr ([194.158.98.45]:55659 "EHLO mail-3y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758664Ab3KIHOR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 02:14:17 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id 1BC9E72;
	Sat,  9 Nov 2013 08:14:16 +0100 (CET)
X-git-sha1: 1b50cac59be92fdcae12f625e55d4dfc05d7ac4f 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237565>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/mailinfo.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index 24a772d..c5da04c 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -328,11 +328,11 @@ static int check_header(const struct strbuf *line,
 	}
 
 	/* for inbody stuff */
-	if (!prefixcmp(line->buf, ">From") && isspace(line->buf[5])) {
+	if (has_prefix(line->buf, ">From") && isspace(line->buf[5])) {
 		ret = 1; /* Should this return 0? */
 		goto check_header_out;
 	}
-	if (!prefixcmp(line->buf, "[PATCH]") && isspace(line->buf[7])) {
+	if (has_prefix(line->buf, "[PATCH]") && isspace(line->buf[7])) {
 		for (i = 0; header[i]; i++) {
 			if (!memcmp("Subject", header[i], 7)) {
 				handle_header(&hdr_data[i], line);
@@ -361,7 +361,7 @@ static int is_rfc2822_header(const struct strbuf *line)
 	char *cp = line->buf;
 
 	/* Count mbox From headers as headers */
-	if (!prefixcmp(cp, "From ") || !prefixcmp(cp, ">From "))
+	if (has_prefix(cp, "From ") || has_prefix(cp, ">From "))
 		return 1;
 
 	while ((ch = *cp++)) {
@@ -671,11 +671,11 @@ static inline int patchbreak(const struct strbuf *line)
 	size_t i;
 
 	/* Beginning of a "diff -" header? */
-	if (!prefixcmp(line->buf, "diff -"))
+	if (has_prefix(line->buf, "diff -"))
 		return 1;
 
 	/* CVS "Index: " line? */
-	if (!prefixcmp(line->buf, "Index: "))
+	if (has_prefix(line->buf, "Index: "))
 		return 1;
 
 	/*
@@ -685,7 +685,7 @@ static inline int patchbreak(const struct strbuf *line)
 	if (line->len < 4)
 		return 0;
 
-	if (!prefixcmp(line->buf, "---")) {
+	if (has_prefix(line->buf, "---")) {
 		/* space followed by a filename? */
 		if (line->buf[3] == ' ' && !isspace(line->buf[4]))
 			return 1;
@@ -986,7 +986,7 @@ static int mailinfo(FILE *in, FILE *out, const char *msg, const char *patch)
 
 static int git_mailinfo_config(const char *var, const char *value, void *unused)
 {
-	if (prefixcmp(var, "mailinfo."))
+	if (!has_prefix(var, "mailinfo."))
 		return git_default_config(var, value, unused);
 	if (!strcmp(var, "mailinfo.scissors")) {
 		use_scissors = git_config_bool(var, value);
@@ -1020,7 +1020,7 @@ int cmd_mailinfo(int argc, const char **argv, const char *prefix)
 			metainfo_charset = def_charset;
 		else if (!strcmp(argv[1], "-n"))
 			metainfo_charset = NULL;
-		else if (!prefixcmp(argv[1], "--encoding="))
+		else if (has_prefix(argv[1], "--encoding="))
 			metainfo_charset = argv[1] + 11;
 		else if (!strcmp(argv[1], "--scissors"))
 			use_scissors = 1;
-- 
1.8.4.1.566.geca833c
