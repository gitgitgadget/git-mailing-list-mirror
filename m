From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 21/86] imap-send: replace prefixcmd() with has_prefix()
Date: Sat, 09 Nov 2013 08:06:14 +0100
Message-ID: <20131109070720.18178.19524.chriscool@tuxfamily.org>
References: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 09 08:09:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vf2fX-00036C-Hq
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 08:09:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933300Ab3KIHI7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Nov 2013 02:08:59 -0500
Received: from mail-1y.bbox.fr ([194.158.98.14]:65395 "EHLO mail-1y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933256Ab3KIHI3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 02:08:29 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id 6EFCB84;
	Sat,  9 Nov 2013 08:08:28 +0100 (CET)
X-git-sha1: e527b9a0c4b587f512c8f510113b83569208339a 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237491>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 imap-send.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 6f5cc4f..670de9f 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1263,7 +1263,7 @@ static int count_messages(struct strbuf *all_msgs)
 	char *p = all_msgs->buf;
 
 	while (1) {
-		if (!prefixcmp(p, "From ")) {
+		if (has_prefix(p, "From ")) {
 			p = strstr(p+5, "\nFrom: ");
 			if (!p) break;
 			p = strstr(p+7, "\nDate: ");
@@ -1297,7 +1297,7 @@ static int split_msg(struct strbuf *all_msgs, struct strbuf *msg, int *ofs)
 	data = &all_msgs->buf[*ofs];
 	len = all_msgs->len - *ofs;
 
-	if (len < 5 || prefixcmp(data, "From "))
+	if (len < 5 || !has_prefix(data, "From "))
 		return 0;
 
 	p = strchr(data, '\n');
@@ -1339,13 +1339,13 @@ static int git_imap_config(const char *key, const char *val, void *cb)
 	if (!strcmp("folder", key)) {
 		imap_folder = xstrdup(val);
 	} else if (!strcmp("host", key)) {
-		if (!prefixcmp(val, "imap:"))
+		if (has_prefix(val, "imap:"))
 			val += 5;
-		else if (!prefixcmp(val, "imaps:")) {
+		else if (has_prefix(val, "imaps:")) {
 			val += 6;
 			server.use_ssl = 1;
 		}
-		if (!prefixcmp(val, "//"))
+		if (has_prefix(val, "//"))
 			val += 2;
 		server.host = xstrdup(val);
 	} else if (!strcmp("user", key))
-- 
1.8.4.1.566.geca833c
