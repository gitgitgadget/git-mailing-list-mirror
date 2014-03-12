From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/4] wt-status: make full label string to be subject to l10n
Date: Wed, 12 Mar 2014 14:19:31 -0700
Message-ID: <1394659174-9143-2-git-send-email-gitster@pobox.com>
References: <1394659174-9143-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 12 22:19:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNqZB-00023o-DY
	for gcvg-git-2@plane.gmane.org; Wed, 12 Mar 2014 22:19:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752624AbaCLVTl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2014 17:19:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41505 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751299AbaCLVTk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2014 17:19:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CD7B974976;
	Wed, 12 Mar 2014 17:19:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=/Glo
	Fi6pyFS3mB41Hpwb81OY/hc=; b=YcQr07zJB3gIlftGO8pJpXvxIgqEqE3EIT3P
	IqEjWCvq3AemksB0XevS2P2Z6GzXRPAuL6YFI6j43VjJHrbxXcnmqlxle6K0Exji
	eAqVv1Zc1eRncbXDo55tk7rBW5MShOV5F3WofEy90VH0nF8SuXU9MASK++7z4YcP
	Yt6C2NY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=GZURI/
	qjLXcXjc08plvJoMfxtHbj3rJ7zKN3XwX9s7nfKlw40vIqPGfZgnN2VZhMvw0Jjf
	Poj+4j//6qBL5rN6n4rbohSPKuOAu+SkQQIbw/3qiGYWmcJH7U+WRCWn6bDMXdgz
	ed80H2mRPjP1o1fS9FHkqPCvfhVD9tKxQIVyg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BB0FF74974;
	Wed, 12 Mar 2014 17:19:39 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D69D974972;
	Wed, 12 Mar 2014 17:19:38 -0400 (EDT)
X-Mailer: git-send-email 1.9.0-293-gd838d6f
In-Reply-To: <1394659174-9143-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 04E85796-AA2C-11E3-A22D-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243996>

Earlier in 3651e45c (wt-status: take the alignment burden off
translators, 2013-11-05), we assumed that it is OK to make the
string before the colon in a label string we give as the section
header of various kinds of changes (e.g. "new file:") translatable.

This assumption apparently does not hold for some languages,
e.g. ones that want to have spaces around the colon.

Also introduce a static label_width to avoid having to run
strlen(padding) over and over.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 wt-status.c | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 4e55810..9cf7028 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -272,21 +272,21 @@ static const char *wt_status_diff_status_string(int status)
 {
 	switch (status) {
 	case DIFF_STATUS_ADDED:
-		return _("new file");
+		return _("new file:");
 	case DIFF_STATUS_COPIED:
-		return _("copied");
+		return _("copied:");
 	case DIFF_STATUS_DELETED:
-		return _("deleted");
+		return _("deleted:");
 	case DIFF_STATUS_MODIFIED:
-		return _("modified");
+		return _("modified:");
 	case DIFF_STATUS_RENAMED:
-		return _("renamed");
+		return _("renamed:");
 	case DIFF_STATUS_TYPE_CHANGED:
-		return _("typechange");
+		return _("typechange:");
 	case DIFF_STATUS_UNKNOWN:
-		return _("unknown");
+		return _("unknown:");
 	case DIFF_STATUS_UNMERGED:
-		return _("unmerged");
+		return _("unmerged:");
 	default:
 		return NULL;
 	}
@@ -305,21 +305,21 @@ static void wt_status_print_change_data(struct wt_status *s,
 	struct strbuf onebuf = STRBUF_INIT, twobuf = STRBUF_INIT;
 	struct strbuf extra = STRBUF_INIT;
 	static char *padding;
+	static int label_width;
 	const char *what;
 	int len;
 
 	if (!padding) {
-		int width = 0;
 		/* If DIFF_STATUS_* uses outside this range, we're in trouble */
 		for (status = 'A'; status <= 'Z'; status++) {
 			what = wt_status_diff_status_string(status);
 			len = what ? strlen(what) : 0;
-			if (len > width)
-				width = len;
+			if (len > label_width)
+				label_width = len;
 		}
-		width += 2;	/* colon and a space */
-		padding = xmallocz(width);
-		memset(padding, ' ', width);
+		label_width += strlen(" ");
+		padding = xmallocz(label_width);
+		memset(padding, ' ', label_width);
 	}
 
 	one_name = two_name = it->string;
@@ -355,14 +355,13 @@ static void wt_status_print_change_data(struct wt_status *s,
 	what = wt_status_diff_status_string(status);
 	if (!what)
 		die(_("bug: unhandled diff status %c"), status);
-	/* 1 for colon, which is not part of "what" */
-	len = strlen(padding) - (utf8_strwidth(what) + 1);
+	len = label_width - utf8_strwidth(what);
 	assert(len >= 0);
 	if (status == DIFF_STATUS_COPIED || status == DIFF_STATUS_RENAMED)
-		status_printf_more(s, c, "%s:%.*s%s -> %s",
+		status_printf_more(s, c, "%s%.*s%s -> %s",
 				   what, len, padding, one, two);
 	else
-		status_printf_more(s, c, "%s:%.*s%s",
+		status_printf_more(s, c, "%s%.*s%s",
 				   what, len, padding, one);
 	if (extra.len) {
 		status_printf_more(s, color(WT_STATUS_HEADER, s), "%s", extra.buf);
-- 
1.9.0-293-gd838d6f
