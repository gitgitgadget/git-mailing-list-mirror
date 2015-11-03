From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v6 14/25] refs: move prettify_refname to the common code
Date: Tue,  3 Nov 2015 08:39:58 +0100
Message-ID: <2dbbc21d1aad46a7422070299451e1aff89df50c.1446534991.git.mhagger@alum.mit.edu>
References: <cover.1446534991.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Ronnie Sahlberg <sahlberg@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 03 08:40:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtWCv-0007Pz-Rd
	for gcvg-git-2@plane.gmane.org; Tue, 03 Nov 2015 08:40:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752974AbbKCHkj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2015 02:40:39 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:53800 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752671AbbKCHke (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Nov 2015 02:40:34 -0500
X-AuditID: 1207440f-f79df6d000007c0f-b3-563864f0f1d5
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id E8.B2.31759.0F468365; Tue,  3 Nov 2015 02:40:32 -0500 (EST)
Received: from michael.fritz.box (p5DDB0E27.dip0.t-ipconnect.de [93.219.14.39])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id tA37eDdB016391
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 3 Nov 2015 02:40:31 -0500
X-Mailer: git-send-email 2.6.2
In-Reply-To: <cover.1446534991.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsUixO6iqPshxSLM4PhpY4uuK91MFg29V5gt
	bq+Yz2zxb0KNA4vH3/cfmDwWbCr1uHhJ2ePzJrkAlihum6TEkrLgzPQ8fbsE7owTU18yFszi
	rtiy8x9jA+NEzi5GTg4JAROJI1dPMULYYhIX7q1n62Lk4hASuMwosXDJYSYI5xiTxJ07Pewg
	VWwCuhKLepqZQGwRATWJiW2HWEBsZoECidlLt4LVCAt4SGw6+oANxGYRUJU4OuU1WD2vQJTE
	+2e3WSC2yUlMud8OFucUsJB4cPcPWK+QgLnEpnvL2CYw8i5gZFjFKJeYU5qrm5uYmVOcmqxb
	nJyYl5dapGuil5tZopeaUrqJERI8/DsYu9bLHGIU4GBU4uFdsMQ8TIg1say4MvcQoyQHk5Io
	77oYizAhvqT8lMqMxOKM+KLSnNTiQ4wSHMxKIrwFgUA53pTEyqrUonyYlDQHi5I4r/oSdT8h
	gfTEktTs1NSC1CKYrAwHh5IE7+xkoEbBotT01Iq0zJwShDQTByfIcC4pkeLUvJTUosTSkox4
	UGzEFwOjAyTFA7R3JUg7b3FBYi5QFKL1FKOilDhvBEhCACSRUZoHNxaWEl4xigN9Kcx7AaSK
	B5hO4LpfAQ1mAhocvs0UZHBJIkJKqoGxwmOnnYRqxzr/lqrcFdYz2i57GckoixT7P2N7VK4u
	FKWXcbq8pbXXSdqzlP+dvYVK1bnCvzvqVvYoVq/gVrjZvera0l+3tzImfY9bxF+wnOvEgicX
	DBe6ha8O3Sc8752a3OZzLFd+7urdLHho6adY68A3v83mKK93+sv04SGjKxvTF1aJ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280760>

From: Ronnie Sahlberg <sahlberg@google.com>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 9 ---------
 refs/refs.c          | 9 +++++++++
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 468758a..89410a7 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2064,15 +2064,6 @@ int for_each_rawref(each_ref_fn fn, void *cb_data)
 			       DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
 }
 
-const char *prettify_refname(const char *name)
-{
-	return name + (
-		starts_with(name, "refs/heads/") ? 11 :
-		starts_with(name, "refs/tags/") ? 10 :
-		starts_with(name, "refs/remotes/") ? 13 :
-		0);
-}
-
 static void unlock_ref(struct ref_lock *lock)
 {
 	/* Do not free lock->lk -- atexit() still looks at them */
diff --git a/refs/refs.c b/refs/refs.c
index fb0e5df..3dd8e91 100644
--- a/refs/refs.c
+++ b/refs/refs.c
@@ -736,3 +736,12 @@ int is_branch(const char *refname)
 {
 	return !strcmp(refname, "HEAD") || starts_with(refname, "refs/heads/");
 }
+
+const char *prettify_refname(const char *name)
+{
+	return name + (
+		starts_with(name, "refs/heads/") ? 11 :
+		starts_with(name, "refs/tags/") ? 10 :
+		starts_with(name, "refs/remotes/") ? 13 :
+		0);
+}
-- 
2.6.2
