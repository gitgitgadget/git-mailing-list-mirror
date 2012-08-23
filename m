From: mhagger@alum.mit.edu
Subject: [PATCH 09/17] Pass nr_heads to filter_refs() by reference
Date: Thu, 23 Aug 2012 10:10:34 +0200
Message-ID: <1345709442-16046-10-git-send-email-mhagger@alum.mit.edu>
References: <1345709442-16046-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 23 10:19:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4Sdb-0001PZ-EW
	for gcvg-git-2@plane.gmane.org; Thu, 23 Aug 2012 10:19:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030249Ab2HWITZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Aug 2012 04:19:25 -0400
Received: from ALUM-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.20]:56134 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933723Ab2HWITD (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Aug 2012 04:19:03 -0400
X-AuditID: 12074414-b7f846d0000008b8-a4-5035e5ae9708
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 0B.52.02232.EA5E5305; Thu, 23 Aug 2012 04:11:26 -0400 (EDT)
Received: from michael.fritz.box (p57A2588E.dip.t-dialin.net [87.162.88.142])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q7N8AkV9030408
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 23 Aug 2012 04:11:24 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1345709442-16046-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDIsWRmVeSWpSXmKPExsUixO6iqLvuqWmAwctP7BZdV7qZLBp6rzBb
	3F4xn9niR0sPswOLx9/3H5g8nvXuYfS4eEnZ4/MmuQCWKG6bpMSSsuDM9Dx9uwTujL5N79kL
	mgQrTn95xdLAuJ63i5GTQ0LAROLhuQ5WCFtM4sK99WwgtpDAZUaJxr+lXYxcQPZZJokPS08x
	gSTYBKQkXjb2sIPYIgJqEhPbDrGA2MwCKRIdz7sZQWxhASeJ9ceawGwWAVWJL1f3g9XwCrhK
	7Hn+ihFimaLEj+9rmEFsTqD4gu+bGCEWu0h8bLzJPIGRdwEjwypGucSc0lzd3MTMnOLUZN3i
	5MS8vNQiXQu93MwSvdSU0k2MkPAR2cF45KTcIUYBDkYlHt4X5qYBQqyJZcWVuYcYJTmYlER5
	/z0CCvEl5adUZiQWZ8QXleakFh9ilOBgVhLhDZ8HlONNSaysSi3Kh0lJc7AoifN+W6zuJySQ
	nliSmp2aWpBaBJOV4eBQkuANBcaJkGBRanpqRVpmTglCmomDE0RwgWzgAdqgCFLIW1yQmFuc
	mQ5RdIpRUUqc1wQkIQCSyCjNgxsAi/RXjOJA/wjzuoNU8QCTBFz3K6DBTECD1a4agwwuSURI
	STUwSnMFpiz/G/lmOe8h72mLM6UPc7Ma/JtjM+v/lvaUZ4JWDu13tq5k4mEvcvvemzD96px3
	svMiV3A/dql4MW36DeWzn7y2l39UrslMPp1b/OvxE3ffOT0vnFdGlLpPk2W2//2qrFH6h7Po
	i9NvlJco3T359UdD+NNjei3Jy3c+njRvibnGDTGdViWW4oxEQy3mouJEAGR2f67P 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204128>

From: Michael Haggerty <mhagger@alum.mit.edu>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/fetch-pack.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 5905dae..0426cf4 100644
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
 	int match_pos;
 
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
-			while (match_pos < nr_heads) {
+			while (match_pos < *nr_heads) {
 				cmp = strcmp(ref->name, heads[match_pos]);
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
