From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 2/3] add strbuf_adddup()
Date: Sat, 10 Nov 2007 12:16:05 +0100
Message-ID: <473592F5.2070407@lsrfire.ath.cx>
References: <4733AEA6.1040802@lsrfire.ath.cx> <20071109045040.GC31760@sigill.intra.peff.net> <4734EA4E.8070405@lsrfire.ath.cx> <20071110004635.GA14992@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Paul Mackerras <paulus@samba.org>,
	Git Mailing List <git@vger.kernel.org>,
	Pierre Habouzit <madcoder@debian.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 10 12:16:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqoKS-0007H3-Uy
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 12:16:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751475AbXKJLQa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2007 06:16:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751420AbXKJLQ3
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Nov 2007 06:16:29 -0500
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:39345
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751455AbXKJLQ3 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Nov 2007 06:16:29 -0500
Received: from [10.0.1.201] (p57B7EF01.dip.t-dialin.net [87.183.239.1])
	by neapel230.server4you.de (Postfix) with ESMTP id AC16C873BA;
	Sat, 10 Nov 2007 12:16:27 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20071110004635.GA14992@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64331>

Add a new function, strbuf_adddup(), that appends a duplicate of a
part of a struct strbuf to end of the latter.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 strbuf.c |    7 +++++++
 strbuf.h |    1 +
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index 536b432..dbd8c4b 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -106,6 +106,13 @@ void strbuf_add(struct strbuf *sb, const void *data, size_t len)
 	strbuf_setlen(sb, sb->len + len);
 }
 
+void strbuf_adddup(struct strbuf *sb, size_t pos, size_t len)
+{
+	strbuf_grow(sb, len);
+	memcpy(sb->buf + sb->len, sb->buf + pos, len);
+	strbuf_setlen(sb, sb->len + len);
+}
+
 void strbuf_addf(struct strbuf *sb, const char *fmt, ...)
 {
 	int len;
diff --git a/strbuf.h b/strbuf.h
index 21d8944..1391912 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -101,6 +101,7 @@ static inline void strbuf_addstr(struct strbuf *sb, const char *s) {
 static inline void strbuf_addbuf(struct strbuf *sb, struct strbuf *sb2) {
 	strbuf_add(sb, sb2->buf, sb2->len);
 }
+extern void strbuf_adddup(struct strbuf *sb, size_t pos, size_t len);
 
 typedef void (*expand_fn_t) (struct strbuf *sb, const char *placeholder, void *context);
 extern void strbuf_expand(struct strbuf *sb, const char *format, const char **placeholders, expand_fn_t fn, void *context);
-- 
1.5.3.5.1651.g30bf
