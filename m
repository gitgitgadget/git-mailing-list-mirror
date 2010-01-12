From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 05/18] http.c: mark file-local functions static
Date: Mon, 11 Jan 2010 23:52:48 -0800
Message-ID: <1263282781-25596-6-git-send-email-gitster@pobox.com>
References: <1263282781-25596-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 12 08:54:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUbaW-00056x-3N
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jan 2010 08:54:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753404Ab0ALHxY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2010 02:53:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751095Ab0ALHxW
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jan 2010 02:53:22 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41011 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752589Ab0ALHxT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2010 02:53:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 683348E889
	for <git@vger.kernel.org>; Tue, 12 Jan 2010 02:53:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=mh67
	iT8zxGnpKXxhgXJbWU924hI=; b=rR9DKoyeKTCWCP/DStn/ogyblTJ3nzcLBtq4
	E1rF+o0Tme0uRmAsH6qYGKyXxCS1ln6Ce2HmHUnVmZr2oOHxZ3OgY9pwZ2IjouQl
	JaJNnIMpFjPNjED+XpL2wx4cs3Xge4BKGiJ4ZBjas9cqAjgLiQ3XYlR/rRhMmM8K
	DqArn1k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=AfN3xU
	rnyXSaqzqjZS4ly/ZOvzcGLNFLp++iK3AoEwvZi5U6lxPsueea9spx7kf080CNWJ
	7ufOwWfZpq+qe+SHKH4lLD22eblSKeVNRPZiwfxuPOxuo/0dF58SxQSKwbHYp90f
	9x5svAJv3lhSy4KaPSoDitrTcR2JuszF+/I6w=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 62DED8E888
	for <git@vger.kernel.org>; Tue, 12 Jan 2010 02:53:19 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CD6488E886 for
 <git@vger.kernel.org>; Tue, 12 Jan 2010 02:53:18 -0500 (EST)
X-Mailer: git-send-email 1.6.6.280.ge295b7.dirty
In-Reply-To: <1263282781-25596-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 8C942490-FF4F-11DE-A07A-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136696>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 http.c |   10 ++++++++--
 http.h |    9 ---------
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/http.c b/http.c
index 5c3efb9..deab595 100644
--- a/http.c
+++ b/http.c
@@ -651,7 +651,7 @@ static void closedown_active_slot(struct active_request_slot *slot)
 	slot->in_use = 0;
 }
 
-void release_active_slot(struct active_request_slot *slot)
+static void release_active_slot(struct active_request_slot *slot)
 {
 	closedown_active_slot(slot);
 	if (slot->curl && curl_session_count > min_curl_sessions) {
@@ -834,7 +834,13 @@ int http_get_strbuf(const char *url, struct strbuf *result, int options)
 	return http_request(url, result, HTTP_REQUEST_STRBUF, options);
 }
 
-int http_get_file(const char *url, const char *filename, int options)
+/*
+ * Downloads an url and stores the result in the given file.
+ *
+ * If a previous interrupted download is detected (i.e. a previous temporary
+ * file is still around) the download is resumed.
+ */
+static int http_get_file(const char *url, const char *filename, int options)
 {
 	int ret;
 	struct strbuf tmpfile = STRBUF_INIT;
diff --git a/http.h b/http.h
index f828e1d..5c9441c 100644
--- a/http.h
+++ b/http.h
@@ -81,7 +81,6 @@ extern int start_active_slot(struct active_request_slot *slot);
 extern void run_active_slot(struct active_request_slot *slot);
 extern void finish_active_slot(struct active_request_slot *slot);
 extern void finish_all_active_slots(void);
-extern void release_active_slot(struct active_request_slot *slot);
 
 #ifdef USE_CURL_MULTI
 extern void fill_active_slots(void);
@@ -136,14 +135,6 @@ extern char *get_remote_object_url(const char *url, const char *hex,
 int http_get_strbuf(const char *url, struct strbuf *result, int options);
 
 /*
- * Downloads an url and stores the result in the given file.
- *
- * If a previous interrupted download is detected (i.e. a previous temporary
- * file is still around) the download is resumed.
- */
-int http_get_file(const char *url, const char *filename, int options);
-
-/*
  * Prints an error message using error() containing url and curl_errorstr,
  * and returns ret.
  */
-- 
1.6.6.280.ge295b7.dirty
