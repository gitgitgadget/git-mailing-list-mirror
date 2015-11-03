From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v6 21/25] refs: move should_autocreate_reflog to common code
Date: Tue,  3 Nov 2015 08:40:05 +0100
Message-ID: <be1e2f413f193635138ea24e90665a91906c8aa6.1446534991.git.mhagger@alum.mit.edu>
References: <cover.1446534991.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, David Turner <dturner@twopensource.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 03 08:48:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtWK4-0005if-0v
	for gcvg-git-2@plane.gmane.org; Tue, 03 Nov 2015 08:48:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752595AbbKCHr7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2015 02:47:59 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:53843 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751370AbbKCHr7 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Nov 2015 02:47:59 -0500
X-AuditID: 1207440f-f79df6d000007c0f-c8-563864f8e304
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 59.B2.31759.8F468365; Tue,  3 Nov 2015 02:40:40 -0500 (EST)
Received: from michael.fritz.box (p5DDB0E27.dip0.t-ipconnect.de [93.219.14.39])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id tA37eDdI016391
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 3 Nov 2015 02:40:39 -0500
X-Mailer: git-send-email 2.6.2
In-Reply-To: <cover.1446534991.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsUixO6iqPsjxSLMYHmTpsX8TScYLbqudDNZ
	NPReYba4vWI+swOLx9/3H5g8Ll5S9ljw/D67x+dNcgEsUdw2SYklZcGZ6Xn6dgncGQdevWIp
	2ChQ8XnVRpYGxt28XYycHBICJhL7trazQNhiEhfurWcDsYUELjNKrJ9b0sXIBWQfY5LonTiH
	FSTBJqArsainmQnEFhFQk5jYdgiomYODWaBI4k6/DkhYWMBH4v7zt2AzWQRUJRYfuc4IUsIr
	ECUx+1QNxCo5iSn328GmcApYSDy4+4cdYq25xKZ7y9gmMPIuYGRYxSiXmFOaq5ubmJlTnJqs
	W5ycmJeXWqRropebWaKXmlK6iRESOvw7GLvWyxxiFOBgVOLhXbDEPEyINbGsuDL3EKMkB5OS
	KO+6GIswIb6k/JTKjMTijPii0pzU4kOMEhzMSiK8BYFAOd6UxMqq1KJ8mJQ0B4uSOK/6EnU/
	IYH0xJLU7NTUgtQimKwMB4eSBO/sZKBGwaLU9NSKtMycEoQ0EwcnyHAuKZHi1LyU1KLE0pKM
	eFBUxBcD4wIkxQO0dyVIO29xQWIuUBSi9RSjopQ4bwRIQgAkkVGaBzcWlhBeMYoDfSnMewGk
	igeYTOC6XwENZgIaHL7NFGRwSSJCSqqBUY8ruZNj2+bPS+et7rxz+Grg10k3Jj/4H2NfpS19
	+bTzq9Xxeat9KrXyvpya8NDJN3fX6e9+P1a+FTn4pH3j3my39LuuInFb9k9TnRXvXWHp/S45
	M+//i5YLrVNe8qxqWZAvfzRhYcnh6wkJqtv/v1++7rH0NZ2p5cYns/zvvYrhuxtx 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280772>

From: David Turner <dturner@twopensource.com>

Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 10 ----------
 refs/refs-internal.h |  2 ++
 refs/refs.c          | 10 ++++++++++
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 2073004..7dc68b8 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2612,16 +2612,6 @@ static int commit_ref(struct ref_lock *lock)
 	return 0;
 }
 
-static int should_autocreate_reflog(const char *refname)
-{
-	if (!log_all_ref_updates)
-		return 0;
-	return starts_with(refname, "refs/heads/") ||
-		starts_with(refname, "refs/remotes/") ||
-		starts_with(refname, "refs/notes/") ||
-		!strcmp(refname, "HEAD");
-}
-
 /*
  * Create a reflog for a ref.  If force_create = 0, the reflog will
  * only be created for certain refs (those for which
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 5b4176e..d854d9e 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -148,6 +148,8 @@ struct ref_transaction {
 	enum ref_transaction_state state;
 };
 
+extern int should_autocreate_reflog(const char *refname);
+
 /*
  * Copy the reflog message msg to buf, which has been allocated sufficiently
  * large, while cleaning up the whitespaces.  Especially, convert LF to space,
diff --git a/refs/refs.c b/refs/refs.c
index 5d95804..25d4e22 100644
--- a/refs/refs.c
+++ b/refs/refs.c
@@ -625,6 +625,16 @@ char *resolve_refdup(const char *refname, int resolve_flags,
 						  sha1, flags));
 }
 
+int should_autocreate_reflog(const char *refname)
+{
+	if (!log_all_ref_updates)
+		return 0;
+	return starts_with(refname, "refs/heads/") ||
+		starts_with(refname, "refs/remotes/") ||
+		starts_with(refname, "refs/notes/") ||
+		!strcmp(refname, "HEAD");
+}
+
 /*
  * How to handle various characters in refnames:
  * 0: An acceptable character for refs
-- 
2.6.2
