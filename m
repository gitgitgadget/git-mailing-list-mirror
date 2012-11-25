From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 1/8] Add new function strbuf_add_xml_quoted()
Date: Sun, 25 Nov 2012 12:08:34 +0100
Message-ID: <1353841721-16269-2-git-send-email-mhagger@alum.mit.edu>
References: <1353841721-16269-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeremy White <jwhite@codeweavers.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 25 12:09:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tca5Z-00048V-SG
	for gcvg-git-2@plane.gmane.org; Sun, 25 Nov 2012 12:09:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753136Ab2KYLJM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2012 06:09:12 -0500
Received: from ALUM-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.19]:44512 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753125Ab2KYLJL (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Nov 2012 06:09:11 -0500
X-AuditID: 12074413-b7f786d0000008bb-0a-50b1fc568c01
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id D4.AE.02235.65CF1B05; Sun, 25 Nov 2012 06:09:10 -0500 (EST)
Received: from michael.fritz.box (p57A25314.dip.t-dialin.net [87.162.83.20])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id qAPB90UD002898
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 25 Nov 2012 06:09:09 -0500
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1353841721-16269-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsUixO6iqBv2Z2OAwbfbEhZdV7qZLBp6rzBb
	9C/vYrO4fHIuo8XtFfOZHVg9/r7/wOTx5Wojk8eHj3EeFy8pe3zeJBfAGsVtk5RYUhacmZ6n
	b5fAnfFw3XbGgg88FVs/HWRsYJzI1cXIySEhYCKx80UvM4QtJnHh3no2EFtI4DKjxNfleV2M
	XED2GSaJ5f96WEASbAK6Eot6mplAbBEBNYmJbYdYQIqYBVYzSkzecp4dJCEsYCvxdNlPsEks
	AqoS/XePsILYvAIuEic75jNBbJOT+LDnEVg9p4CrxI99D6A2u0hsvrCfcQIj7wJGhlWMcok5
	pbm6uYmZOcWpybrFyYl5ealFuuZ6uZkleqkppZsYISElvINx10m5Q4wCHIxKPLxGKRsDhFgT
	y4orcw8xSnIwKYnyzv0KFOJLyk+pzEgszogvKs1JLT7EKMHBrCTCG/oMKMebklhZlVqUD5OS
	5mBREudVW6LuJySQnliSmp2aWpBaBJOV4eBQkuA98RuoUbAoNT21Ii0zpwQhzcTBCSK4QDbw
	AG2YD1LIW1yQmFucmQ5RdIpRUUqcdydIQgAkkVGaBzcAFv2vGMWB/hHmXQtSxQNMHHDdr4AG
	MwENTr4ONrgkESEl1cBYcViwRPpigbTW5b6HiRffc7u0P5F++26D/+dHc/yfS8uv3zjBe8WD
	8n/fDh1XDWnbU2SxZKeI3dLc/6nHNvVc1reuir428fexEy0VhZkTdHdIlRUFN388fnJTiHLB
	be44a9cL2utWC/r/cJZ8LLHY0aGwPN1ebVHPLQdTd++6hPC/uvz/XI4rsRRnJBpq 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210356>

Substantially the same code is present in http-push.c and imap-send.c,
so make a library function out of it.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 strbuf.c | 26 ++++++++++++++++++++++++++
 strbuf.h |  6 ++++++
 2 files changed, 32 insertions(+)

diff --git a/strbuf.c b/strbuf.c
index 05d0693..9a373be 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -425,6 +425,32 @@ void strbuf_add_lines(struct strbuf *out, const char *prefix,
 	strbuf_complete_line(out);
 }
 
+void strbuf_addstr_xml_quoted(struct strbuf *buf, const char *s)
+{
+	while (*s) {
+		size_t len = strcspn(s, "\"<>&");
+		strbuf_add(buf, s, len);
+		s += len;
+		switch (*s) {
+		case '"':
+			strbuf_addstr(buf, "&quot;");
+			break;
+		case '<':
+			strbuf_addstr(buf, "&lt;");
+			break;
+		case '>':
+			strbuf_addstr(buf, "&gt;");
+			break;
+		case '&':
+			strbuf_addstr(buf, "&amp;");
+			break;
+		case 0:
+			return;
+		}
+		s++;
+	}
+}
+
 static int is_rfc3986_reserved(char ch)
 {
 	switch (ch) {
diff --git a/strbuf.h b/strbuf.h
index aa386c6..ecae4e2 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -136,6 +136,12 @@ extern void strbuf_vaddf(struct strbuf *sb, const char *fmt, va_list ap);
 
 extern void strbuf_add_lines(struct strbuf *sb, const char *prefix, const char *buf, size_t size);
 
+/*
+ * Append s to sb, with the characters '<', '>', '&' and '"' converted
+ * into XML entities.
+ */
+extern void strbuf_addstr_xml_quoted(struct strbuf *sb, const char *s);
+
 static inline void strbuf_complete_line(struct strbuf *sb)
 {
 	if (sb->len && sb->buf[sb->len - 1] != '\n')
-- 
1.8.0
