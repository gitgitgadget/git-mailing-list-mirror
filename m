From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH 1/3] Add strbuf_rtrim (to remove trailing spaces).
Date: Sat,  8 Sep 2007 13:53:17 +0200
Message-ID: <1189252399433-git-send-email-madcoder@debian.org>
References: <20070902224213.GB431@artemis.corp>
 <11892523992761-git-send-email-madcoder@debian.org>
Cc: Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 08 13:53:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITysT-0006v1-TC
	for gcvg-git@gmane.org; Sat, 08 Sep 2007 13:53:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751791AbXIHLxW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Sep 2007 07:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751654AbXIHLxV
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Sep 2007 07:53:21 -0400
Received: from pan.madism.org ([88.191.52.104]:57493 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751017AbXIHLxU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Sep 2007 07:53:20 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id F1CD71E9CE;
	Sat,  8 Sep 2007 13:53:19 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 3466D101FD9; Sat,  8 Sep 2007 13:53:19 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.1
In-Reply-To: <11892523992761-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58121>

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 strbuf.c |    7 +++++++
 strbuf.h |    3 +++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index acc7fc8..565c343 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -28,6 +28,13 @@ void strbuf_grow(struct strbuf *sb, size_t extra) {
 	ALLOC_GROW(sb->buf, sb->len + extra + 1, sb->alloc);
 }
 
+void strbuf_rtrim(struct strbuf *sb)
+{
+    while (sb->len > 0 && isspace((unsigned char)sb->buf[sb->len - 1]))
+        sb->len--;
+    sb->buf[sb->len] = '\0';
+}
+
 void strbuf_add(struct strbuf *sb, const void *data, size_t len) {
 	strbuf_grow(sb, len);
 	memcpy(sb->buf + sb->len, data, len);
diff --git a/strbuf.h b/strbuf.h
index b40dc99..9b708cc 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -68,6 +68,9 @@ static inline void strbuf_setlen(struct strbuf *sb, size_t len) {
 
 extern void strbuf_grow(struct strbuf *, size_t);
 
+/*----- content related -----*/
+extern void strbuf_rtrim(struct strbuf *);
+
 /*----- add data in your buffer -----*/
 static inline void strbuf_addch(struct strbuf *sb, int c) {
 	strbuf_grow(sb, 1);
-- 
1.5.3.1
