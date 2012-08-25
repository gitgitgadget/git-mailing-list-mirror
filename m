From: mhagger@alum.mit.edu
Subject: [PATCH v2 09/17] Pass nr_heads to filter_refs() by reference
Date: Sat, 25 Aug 2012 08:44:19 +0200
Message-ID: <1345877067-11841-10-git-send-email-mhagger@alum.mit.edu>
References: <1345877067-11841-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.org>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 25 08:52:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T5AEO-0001mR-57
	for gcvg-git-2@plane.gmane.org; Sat, 25 Aug 2012 08:52:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753902Ab2HYGwW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Aug 2012 02:52:22 -0400
Received: from ALUM-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.17]:56483 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753586Ab2HYGwV (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Aug 2012 02:52:21 -0400
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Sat, 25 Aug 2012 02:52:20 EDT
X-AuditID: 12074411-b7fa36d0000008cc-63-5038747e6b56
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 03.29.02252.E7478305; Sat, 25 Aug 2012 02:45:18 -0400 (EDT)
Received: from michael.fritz.box (p57A257CD.dip.t-dialin.net [87.162.87.205])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q7P6igSk011615
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 25 Aug 2012 02:45:17 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1345877067-11841-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCIsWRmVeSWpSXmKPExsUixO6iqFtXYhFg8OSBpEXXlW4mi4beK8wW
	t1fMZ7b40dLDbNE5VdaB1ePv+w9MHsuXrmP0eNa7h9Hj4iVlj8+b5AJYo7htkhJLyoIz0/P0
	7RK4M+59+chU8E+gYnKzbQPjat4uRk4OCQETiR2nf7JD2GISF+6tZ+ti5OIQErjMKPG6+SUT
	SEJI4CyTxO/bWSA2m4CUxMvGHrAGEQE1iYlth1hAGpgFuhgllq/7xQaSEBZwlXjw+iZQEQcH
	i4CqxPWDkiBhXqDwlsYXbBDLFCV+fF/DDGJzAsUn/LrIDrHLRaLp2BWWCYy8CxgZVjHKJeaU
	5urmJmbmFKcm6xYnJ+blpRbpmurlZpbopaaUbmKEhJPgDsYZJ+UOMQpwMCrx8N44Yx4gxJpY
	VlyZe4hRkoNJSZRXrNAiQIgvKT+lMiOxOCO+qDQntfgQowQHs5II73cGoBxvSmJlVWpRPkxK
	moNFSZyXb4m6n5BAemJJanZqakFqEUxWhoNDSYL3ezFQo2BRanpqRVpmTglCmomDE0RwgWzg
	AdpwF6SQt7ggMbc4Mx2i6BSjopQ47ymQhABIIqM0D24ALPJfMYoD/SPMO7MIqIoHmDTgul8B
	DWYCGlzuag4yuCQRISXVwLh+RRi/zj/1v6u3KTP6cr+/aia+/FvQPN2K5+rhhUd2x0d/utP8
	oHDmcQder6kzeYpq3fiude/qzLI/+q6/Y3XlV6PII/x7891EfNVOOW5yUOTxVP1jwcvVLrdB
	YkeyazU/06ITcR/vl7JvN3spuTS06XnmhCgDJod1M2f+Ulg+cbtpqvCLB0osxRmJ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204264>

From: Michael Haggerty <mhagger@alum.mit.edu>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/fetch-pack.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index a4bb0ff..c47090d 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -521,7 +521,7 @@ static void mark_recent_complete_commits(unsigned long cutoff)
 	}
 }
 
-static void filter_refs(struct ref **refs, int nr_heads, char **heads)
+static void filter_refs(struct ref **refs, int *nr_heads, char **heads)
 {
 	struct ref **return_refs;
 	struct ref *newlist = NULL;
@@ -530,12 +530,12 @@ static void filter_refs(struct ref **refs, int nr_heads, char **heads)
 	struct ref *fastarray[32];
 	int head_pos;
 
-	if (nr_heads && !args.fetch_all) {
-		if (ARRAY_SIZE(fastarray) < nr_heads)
-			return_refs = xcalloc(nr_heads, sizeof(struct ref *));
+	if (*nr_heads && !args.fetch_all) {
+		if (ARRAY_SIZE(fastarray) < *nr_heads)
+			return_refs = xcalloc(*nr_heads, sizeof(struct ref *));
 		else {
 			return_refs = fastarray;
-			memset(return_refs, 0, sizeof(struct ref *) * nr_heads);
+			memset(return_refs, 0, sizeof(struct ref *) * *nr_heads);
 		}
 	}
 	else
@@ -556,7 +556,7 @@ static void filter_refs(struct ref **refs, int nr_heads, char **heads)
 		}
 		else {
 			int cmp = -1;
-			while (head_pos < nr_heads) {
+			while (head_pos < *nr_heads) {
 				cmp = strcmp(ref->name, heads[head_pos]);
 				if (cmp < 0) /* definitely do not have it */
 					break;
@@ -576,7 +576,7 @@ static void filter_refs(struct ref **refs, int nr_heads, char **heads)
 
 	if (!args.fetch_all) {
 		int i;
-		for (i = 0; i < nr_heads; i++) {
+		for (i = 0; i < *nr_heads; i++) {
 			ref = return_refs[i];
 			if (ref) {
 				*newtail = ref;
@@ -646,7 +646,7 @@ static int everything_local(struct ref **refs, int *nr_heads, char **heads)
 		}
 	}
 
-	filter_refs(refs, *nr_heads, heads);
+	filter_refs(refs, nr_heads, heads);
 
 	for (retval = 1, ref = *refs; ref ; ref = ref->next) {
 		const unsigned char *remote = ref->old_sha1;
-- 
1.7.11.3
