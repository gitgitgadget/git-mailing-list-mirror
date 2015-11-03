From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v6 07/25] refs: move the hidden refs functions to the common code
Date: Tue,  3 Nov 2015 08:39:51 +0100
Message-ID: <41fe017e6d9ae1348de1838b80af70b8bf7db947.1446534991.git.mhagger@alum.mit.edu>
References: <cover.1446534991.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Ronnie Sahlberg <sahlberg@google.com>,
	David Turner <dturner@twopensource.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 03 08:48:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtWKC-0005ql-IF
	for gcvg-git-2@plane.gmane.org; Tue, 03 Nov 2015 08:48:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752615AbbKCHsI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2015 02:48:08 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:44588 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751346AbbKCHsG (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Nov 2015 02:48:06 -0500
X-AuditID: 12074414-f794f6d000007852-94-563864e8ca42
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 38.2D.30802.8E468365; Tue,  3 Nov 2015 02:40:24 -0500 (EST)
Received: from michael.fritz.box (p5DDB0E27.dip0.t-ipconnect.de [93.219.14.39])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id tA37eDd4016391
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 3 Nov 2015 02:40:23 -0500
X-Mailer: git-send-email 2.6.2
In-Reply-To: <cover.1446534991.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsUixO6iqPsixSLM4MclAYv5m04wWnRd6Way
	aOi9wmxxe8V8Zot/E2ocWD3+vv/A5LFgU6nHxUvKHgue32f3+LxJLoA1itsmKbGkLDgzPU/f
	LoE7Y9m+BYwFU2Qq/i1czdTAuECsi5GDQ0LARGLjq4guRk4gU0ziwr31bF2MXBxCApcZJSY8
	WcIC4Rxjkpjy7w8zSBWbgK7Eop5mJhBbREBNYmLbIbAiZoFFjBKtb6aDJYQFAiXmvTrFDmKz
	CKhKzJt0ByzOKxAlcfrCfjaIdXISU+63g8U5BSwkHtz9A1YvJGAuseneMrYJjLwLGBlWMcol
	5pTm6uYmZuYUpybrFicn5uWlFula6OVmluilppRuYoQElMgOxiMn5Q4xCnAwKvHwLlhiHibE
	mlhWXJl7iFGSg0lJlHddjEWYEF9SfkplRmJxRnxRaU5q8SFGCQ5mJRHegkCgHG9KYmVValE+
	TEqag0VJnPfbYnU/IYH0xJLU7NTUgtQimKwMB4eSBO+lZKBGwaLU9NSKtMycEoQ0EwcnyHAu
	KZHi1LyU1KLE0pKMeFBsxBcDowMkxQO0NyEFZG9xQWIuUBSi9RSjopQ470WQuQIgiYzSPLix
	sDTxilEc6Eth3okgVTzAFAPX/QpoMBPQ4PBtpiCDSxIRUlINjFzfr122mlITsURfZ6raD/sp
	zzTSd4XZFXgnpokXrLTpsIq8I9u3ydexuvSAF8uKZwr5Z6tXX89Y/CS44mjJjlR/67fuuR/6
	65fHdy3Y+NYh2MH6UabgPZdFkzoW3dmlvVl7/oGHL3e+sJDKWPa+0cd5da2Y7etT 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280774>

From: Ronnie Sahlberg <sahlberg@google.com>

Move the hidden refs functions to refs/refs.c since these functions do
not contain any backend specific code.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 51 ---------------------------------------------------
 refs/refs.c          | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+), 51 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 8eba347..8f1e486 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -4219,57 +4219,6 @@ char *shorten_unambiguous_ref(const char *refname, int strict)
 	return xstrdup(refname);
 }
 
-static struct string_list *hide_refs;
-
-int parse_hide_refs_config(const char *var, const char *value, const char *section)
-{
-	if (!strcmp("transfer.hiderefs", var) ||
-	    /* NEEDSWORK: use parse_config_key() once both are merged */
-	    (starts_with(var, section) && var[strlen(section)] == '.' &&
-	     !strcmp(var + strlen(section), ".hiderefs"))) {
-		char *ref;
-		int len;
-
-		if (!value)
-			return config_error_nonbool(var);
-		ref = xstrdup(value);
-		len = strlen(ref);
-		while (len && ref[len - 1] == '/')
-			ref[--len] = '\0';
-		if (!hide_refs) {
-			hide_refs = xcalloc(1, sizeof(*hide_refs));
-			hide_refs->strdup_strings = 1;
-		}
-		string_list_append(hide_refs, ref);
-	}
-	return 0;
-}
-
-int ref_is_hidden(const char *refname)
-{
-	int i;
-
-	if (!hide_refs)
-		return 0;
-	for (i = hide_refs->nr - 1; i >= 0; i--) {
-		const char *match = hide_refs->items[i].string;
-		int neg = 0;
-		int len;
-
-		if (*match == '!') {
-			neg = 1;
-			match++;
-		}
-
-		if (!starts_with(refname, match))
-			continue;
-		len = strlen(match);
-		if (!refname[len] || refname[len] == '/')
-			return !neg;
-	}
-	return 0;
-}
-
 struct expire_reflog_cb {
 	unsigned int flags;
 	reflog_expiry_should_prune_fn *should_prune_fn;
diff --git a/refs/refs.c b/refs/refs.c
index 99221a3..0620ba3 100644
--- a/refs/refs.c
+++ b/refs/refs.c
@@ -291,3 +291,54 @@ int read_ref_at(const char *refname, unsigned int flags, unsigned long at_time,
 
 	return 1;
 }
+
+static struct string_list *hide_refs;
+
+int parse_hide_refs_config(const char *var, const char *value, const char *section)
+{
+	if (!strcmp("transfer.hiderefs", var) ||
+	    /* NEEDSWORK: use parse_config_key() once both are merged */
+	    (starts_with(var, section) && var[strlen(section)] == '.' &&
+	     !strcmp(var + strlen(section), ".hiderefs"))) {
+		char *ref;
+		int len;
+
+		if (!value)
+			return config_error_nonbool(var);
+		ref = xstrdup(value);
+		len = strlen(ref);
+		while (len && ref[len - 1] == '/')
+			ref[--len] = '\0';
+		if (!hide_refs) {
+			hide_refs = xcalloc(1, sizeof(*hide_refs));
+			hide_refs->strdup_strings = 1;
+		}
+		string_list_append(hide_refs, ref);
+	}
+	return 0;
+}
+
+int ref_is_hidden(const char *refname)
+{
+	int i;
+
+	if (!hide_refs)
+		return 0;
+	for (i = hide_refs->nr - 1; i >= 0; i--) {
+		const char *match = hide_refs->items[i].string;
+		int neg = 0;
+		int len;
+
+		if (*match == '!') {
+			neg = 1;
+			match++;
+		}
+
+		if (!starts_with(refname, match))
+			continue;
+		len = strlen(match);
+		if (!refname[len] || refname[len] == '/')
+			return !neg;
+	}
+	return 0;
+}
-- 
2.6.2
