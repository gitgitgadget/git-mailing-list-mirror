From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 15/21] read_raw_ref(): change flags parameter to unsigned int
Date: Wed, 23 Mar 2016 11:04:32 +0100
Message-ID: <317cccf286a11f2e4ac92fecacd206494b1bc30f.1458723959.git.mhagger@alum.mit.edu>
References: <cover.1458723959.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, peff@peff.net, pclouds@gmail.com,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 11:16:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aifmI-0000gX-31
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 11:12:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754687AbcCWKMe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 06:12:34 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:58900 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752037AbcCWKM0 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Mar 2016 06:12:26 -0400
X-AuditID: 1207440e-c03ff70000000398-cd-56f26a564bed
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 38.BC.00920.65A62F65; Wed, 23 Mar 2016 06:05:10 -0400 (EDT)
Received: from michael.fritz.box (p548D66C6.dip0.t-ipconnect.de [84.141.102.198])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u2NA4g1K018017
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 23 Mar 2016 06:05:09 -0400
X-Mailer: git-send-email 2.8.0.rc3
In-Reply-To: <cover.1458723959.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsUixO6iqBue9SnMoGeehEXXlW4mi4beK8wW
	t1fMZ7bonvKW0eJHSw+zxcyr1g5sHn/ff2Dy2DnrLrvHs949jB4XLyl77F+6jc3j8ya5ALYo
	bpukxJKy4Mz0PH27BO6Mmb2P2QsW8lRc3nCVsYHxCWcXIyeHhICJxMHFLexdjFwcQgJbGSVO
	LZvMBuGcZJLoOv+JGaSKTUBXYlFPMxOILSKgJjGx7RALSBGzwAJGiY2LF4MVCQv4Sqxs2MsK
	YrMIqEocufgAzOYViJL4+H8DC8Q6JYkNDy6ADeIUsJA4eXIpI4gtJGAusf3BWqYJjDwLGBlW
	Mcol5pTm6uYmZuYUpybrFicn5uWlFuka6+VmluilppRuYoQEFN8Oxvb1MocYBTgYlXh4Jc98
	DBNiTSwrrsw9xCjJwaQkyns+6FOYEF9SfkplRmJxRnxRaU5q8SFGCQ5mJRFezXSgHG9KYmVV
	alE+TEqag0VJnFdtibqfkEB6YklqdmpqQWoRTFaGg0NJgndeGlCjYFFqempFWmZOCUKaiYMT
	ZDiXlEhxal5KalFiaUlGPCgK4ouBcQCS4gHauxRsb3FBYi5QFKL1FKOilDjvB5C5AiCJjNI8
	uLGwNPGKURzoS2FeEZB2HmCKget+BTSYCWjwQh+wwSWJCCmpBsZ5N85GO6ctKS1TXz2xefpX
	v3VnJz+1+nomhr3ElGfx1n+vtjo+33lATbl13qsVTJM3FJQ97Zj8arV4HkdPhVLyr5mPXVx5
	r/t1WhQc+75ySyAX66EVV3s1edIlNdhu1CVdWeNY8WTtneXnrZ903HncnN/+KIDf 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289630>

read_raw_ref() is going to be part of the vtable for reference backends,
so clean up its interface to use "unsigned int flags" rather than "int
flags". Its caller still uses signed int for its flags arguments. But
changing that would touch a lot of code, so leave it for now.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 120b2dd..a15986c 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1372,7 +1372,7 @@ static struct ref_entry *get_packed_ref(const char *refname)
  */
 static int resolve_missing_loose_ref(const char *refname,
 				     unsigned char *sha1,
-				     int *flags)
+				     unsigned int *flags)
 {
 	struct ref_entry *entry;
 
@@ -1421,7 +1421,7 @@ static int resolve_missing_loose_ref(const char *refname,
  *   refname will still be valid and unchanged.
  */
 static int read_raw_ref(const char *refname, unsigned char *sha1,
-			struct strbuf *symref, int *flags)
+			struct strbuf *symref, unsigned int *flags)
 {
 	struct strbuf sb_contents = STRBUF_INIT;
 	struct strbuf sb_path = STRBUF_INIT;
@@ -1570,7 +1570,7 @@ const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
 	}
 
 	for (symref_count = 0; symref_count < MAXDEPTH; symref_count++) {
-		int read_flags = 0;
+		unsigned int read_flags = 0;
 
 		if (read_raw_ref(refname, sha1, &sb_refname, &read_flags)) {
 			*flags |= read_flags;
-- 
2.8.0.rc3
