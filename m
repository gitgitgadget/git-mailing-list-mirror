From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 16/38] resolve_gitlink_ref(): implement using resolve_ref_recursively()
Date: Fri,  3 Jun 2016 23:03:51 +0200
Message-ID: <a9787723bcd990413661b8cb2e5542d618ab6321.1464983301.git.mhagger@alum.mit.edu>
References: <cover.1464983301.git.mhagger@alum.mit.edu>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 23:05:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8wHc-0000uA-Nl
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 23:05:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932966AbcFCVFX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 17:05:23 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:53972 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932946AbcFCVE4 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2016 17:04:56 -0400
X-AuditID: 12074412-51bff700000009f7-d3-5751f0f522c6
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 5E.94.02551.5F0F1575; Fri,  3 Jun 2016 17:04:53 -0400 (EDT)
Received: from michael.fritz.box (p548D60E2.dip0.t-ipconnect.de [84.141.96.226])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u53L4Kcg003260
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 3 Jun 2016 17:04:52 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1464983301.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHIsWRmVeSWpSXmKPExsUixO6iqPv1Q2C4wduvVhbzN51gtOi60s1k
	0dB7hdni9or5zBbdU94yWvxo6WG2mHnV2uLMm0ZGBw6Pv+8/MHnsnHWX3eNZ7x5Gj4uXlD32
	L93G5rH4gZfHguf32T0+b5IL4IjitklKLCkLzkzP07dL4M64euU3U8EWmYp/vSuYGhi/i3Ux
	cnJICJhInLt6l7mLkYtDSGAro8S+Ux/ZIJzjTBJT3zcxg1SxCehKLOppZgKxRQQiJBpetTCC
	FDELzGGSuP2wE6xIWCBc4tD3W2A2i4CqRPeNaWwgNq9AlMTJI/eZINbJSVye/gAszilgIdHy
	eRUriC0kYC7ReOowywRGngWMDKsY5RJzSnN1cxMzc4pTk3WLkxPz8lKLdM30cjNL9FJTSjcx
	QsJOaAfj+pNyhxgFOBiVeHgLngWGC7EmlhVX5h5ilORgUhLl3XsHKMSXlJ9SmZFYnBFfVJqT
	WnyIUYKDWUmEN+U1UI43JbGyKrUoHyYlzcGiJM77c7G6n5BAemJJanZqakFqEUxWhoNDSYJX
	HhhfQoJFqempFWmZOSUIaSYOTpDhXFIixal5KalFiaUlGfGgKIgvBsYBSIoHaC83SDtvcUFi
	LlAUovUUo6KUOO+h90AJAZBERmke3FhYMnnFKA70pTBvMkgVDzARwXW/AhrMBDS44JE/yOCS
	RISUVAPjJhUWuwB3sbaWEyvW5BwrqovephJVy5feKRHVf1Mx5tjHF17a9+smhQkbOUwNnzLN
	5H/ro4D2rhu/njl0Ptk4Z+oN5wNb7Z53c0g+XXPb0FP3wadzXzI+W9f6KIasuvwy 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296383>

resolve_ref_recursively() can handle references in arbitrary files
reference stores, so use it to resolve "gitlink" (i.e., submodule)
references. Aside from removing redundant code, this allows submodule
lookups to benefit from the much more robust code that we use for
reading non-submodule references. And, since the code is now agnostic
about reference backends, it will work for any future references
backend (so move its definition to refs.c).

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c               | 24 +++++++++++++++++++
 refs/files-backend.c | 67 ----------------------------------------------------
 2 files changed, 24 insertions(+), 67 deletions(-)

diff --git a/refs.c b/refs.c
index 93f2e4d..5e0777a 100644
--- a/refs.c
+++ b/refs.c
@@ -1299,6 +1299,30 @@ const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
 				       resolve_flags, sha1, flags);
 }
 
+int resolve_gitlink_ref(const char *path, const char *refname, unsigned char *sha1)
+{
+	int len = strlen(path);
+	struct strbuf submodule = STRBUF_INIT;
+	struct ref_store *refs;
+	int flags;
+
+	while (len && path[len-1] == '/')
+		len--;
+	if (!len)
+		return -1;
+
+	strbuf_add(&submodule, path, len);
+	refs = get_ref_store(submodule.buf);
+	strbuf_release(&submodule);
+	if (!refs)
+		return -1;
+
+	if (!resolve_ref_recursively(refs, refname, 0, sha1, &flags) ||
+	    is_null_sha1(sha1))
+		return -1;
+	return 0;
+}
+
 static struct ref_store *main_ref_store = NULL;
 
 static struct ref_store *submodule_ref_stores = NULL;
diff --git a/refs/files-backend.c b/refs/files-backend.c
index ff7ee7d..d6d83d2 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1498,73 +1498,6 @@ static void unlock_ref(struct ref_lock *lock)
 	free(lock);
 }
 
-#define MAXREFLEN (1024)
-
-static int resolve_gitlink_ref_recursive(struct files_ref_store *refs,
-					 const char *refname, unsigned char *sha1,
-					 int recursion)
-{
-	int fd, len;
-	char buffer[128], *p;
-	char *path;
-
-	if (recursion > SYMREF_MAXDEPTH || strlen(refname) > MAXREFLEN)
-		return -1;
-	path = *refs->base.submodule
-		? git_pathdup_submodule(refs->base.submodule, "%s", refname)
-		: git_pathdup("%s", refname);
-	fd = open(path, O_RDONLY);
-	free(path);
-	if (fd < 0) {
-		unsigned int flags;
-
-		return resolve_packed_ref(refs, refname, sha1, &flags);
-	}
-
-	len = read(fd, buffer, sizeof(buffer)-1);
-	close(fd);
-	if (len < 0)
-		return -1;
-	while (len && isspace(buffer[len-1]))
-		len--;
-	buffer[len] = 0;
-
-	/* Was it a detached head or an old-fashioned symlink? */
-	if (!get_sha1_hex(buffer, sha1))
-		return 0;
-
-	/* Symref? */
-	if (strncmp(buffer, "ref:", 4))
-		return -1;
-	p = buffer + 4;
-	while (isspace(*p))
-		p++;
-
-	return resolve_gitlink_ref_recursive(refs, p, sha1, recursion+1);
-}
-
-int resolve_gitlink_ref(const char *path, const char *refname, unsigned char *sha1)
-{
-	int len = strlen(path);
-	struct strbuf submodule = STRBUF_INIT;
-	struct files_ref_store *refs;
-
-	while (len && path[len-1] == '/')
-		len--;
-	if (!len)
-		return -1;
-
-	strbuf_add(&submodule, path, len);
-	refs = get_files_ref_store(submodule.buf, "resolve_gitlink_ref");
-	if (!refs) {
-		strbuf_release(&submodule);
-		return -1;
-	}
-	strbuf_release(&submodule);
-
-	return resolve_gitlink_ref_recursive(refs, refname, sha1, 0);
-}
-
 /*
  * Lock refname, without following symrefs, and set *lock_p to point
  * at a newly-allocated lock object. Fill in lock->old_oid, referent,
-- 
2.8.1
