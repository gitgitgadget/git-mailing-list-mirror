From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v6 11/25] refs: move resolve_refdup to common
Date: Tue,  3 Nov 2015 08:39:55 +0100
Message-ID: <4d1782ce2943a543e38999c0abb01a314231494a.1446534991.git.mhagger@alum.mit.edu>
References: <cover.1446534991.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Ronnie Sahlberg <sahlberg@google.com>,
	David Turner <dturner@twopensource.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 03 08:40:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtWCp-0007Ij-2k
	for gcvg-git-2@plane.gmane.org; Tue, 03 Nov 2015 08:40:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752859AbbKCHka (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2015 02:40:30 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:55595 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752677AbbKCHk3 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Nov 2015 02:40:29 -0500
X-AuditID: 1207440d-f79136d00000402c-ef-563864edfcc3
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id D9.6D.16428.DE468365; Tue,  3 Nov 2015 02:40:29 -0500 (EST)
Received: from michael.fritz.box (p5DDB0E27.dip0.t-ipconnect.de [93.219.14.39])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id tA37eDd8016391
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 3 Nov 2015 02:40:28 -0500
X-Mailer: git-send-email 2.6.2
In-Reply-To: <cover.1446534991.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsUixO6iqPs2xSLM4OZDNov5m04wWnRd6Way
	aOi9wmxxe8V8Zot/E2ocWD3+vv/A5LFgU6nHxUvKHgue32f3+LxJLoA1itsmKbGkLDgzPU/f
	LoE7Y/7/ncwFv7gr2n/KNTC+5uxi5OSQEDCRuPN0HRuELSZx4d56IJuLQ0jgMqPEvN//GSGc
	Y0wSq7susYBUsQnoSizqaWYCsUUE1CQmth1iASliFljEKNH6ZjpYQljAVuLcjElgNouAqsTe
	e63sIDavQJTE7uVzWCDWyUlMud8OVsMpYCHx4O4fsBohAXOJTfeWsU1g5F3AyLCKUS4xpzRX
	NzcxM6c4NVm3ODkxLy+1SNdILzezRC81pXQTIySgeHcw/l8nc4hRgINRiYd3wRLzMCHWxLLi
	ytxDjJIcTEqivOtiLMKE+JLyUyozEosz4otKc1KLDzFKcDArifAWBALleFMSK6tSi/JhUtIc
	LErivGpL1P2EBNITS1KzU1MLUotgsjIcHEoSvLOTgRoFi1LTUyvSMnNKENJMHJwgw7mkRIpT
	81JSixJLSzLiQbERXwyMDpAUD9DelSDtvMUFiblAUYjWU4yKUuK8k0ESAiCJjNI8uLGwNPGK
	URzoS2HeiSBVPMAUA9f9CmgwE9Dg8G2mIINLEhFSUg2MXLI1BzpPvpPZuv3+na384qe47yVI
	93x/xbj38+PZZtbvOpfqHLp6I5vNge9jX0rbxJ2fJ3xa0RW+ZOGbxfe2uUZNPzNt4j/16p6a
	N1UNXyN+J208tPZE+5GyzaVdzRnvVmmvT+LuLn+4ldV9epbpzfbf95S+v9pysef5 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280757>

From: Ronnie Sahlberg <sahlberg@google.com>

This function can be shared across all refs backends so move it
to the common code.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 7 -------
 refs/refs.c          | 7 +++++++
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 6940d54..f84fa9e 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1789,13 +1789,6 @@ const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
 	return ret;
 }
 
-char *resolve_refdup(const char *refname, int resolve_flags,
-		     unsigned char *sha1, int *flags)
-{
-	return xstrdup_or_null(resolve_ref_unsafe(refname, resolve_flags,
-						  sha1, flags));
-}
-
 /* The argument to filter_refs */
 struct ref_filter {
 	const char *pattern;
diff --git a/refs/refs.c b/refs/refs.c
index ae55d85..56dee05 100644
--- a/refs/refs.c
+++ b/refs/refs.c
@@ -615,3 +615,10 @@ int ref_exists(const char *refname)
 	unsigned char sha1[20];
 	return !!resolve_ref_unsafe(refname, RESOLVE_REF_READING, sha1, NULL);
 }
+
+char *resolve_refdup(const char *refname, int resolve_flags,
+		     unsigned char *sha1, int *flags)
+{
+	return xstrdup_or_null(resolve_ref_unsafe(refname, resolve_flags,
+						  sha1, flags));
+}
-- 
2.6.2
