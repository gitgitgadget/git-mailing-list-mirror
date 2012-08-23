From: mhagger@alum.mit.edu
Subject: [PATCH 14/17] Report missing refs even if no existing refs were received
Date: Thu, 23 Aug 2012 10:10:39 +0200
Message-ID: <1345709442-16046-15-git-send-email-mhagger@alum.mit.edu>
References: <1345709442-16046-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 23 10:19:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4Sdw-0001ue-EF
	for gcvg-git-2@plane.gmane.org; Thu, 23 Aug 2012 10:19:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933739Ab2HWITp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Aug 2012 04:19:45 -0400
Received: from ALUM-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.20]:55521 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030248Ab2HWITU (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Aug 2012 04:19:20 -0400
X-Greylist: delayed 461 seconds by postgrey-1.27 at vger.kernel.org; Thu, 23 Aug 2012 04:19:20 EDT
X-AuditID: 12074414-b7f846d0000008b8-ba-5035e5ba4514
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id FC.52.02232.AB5E5305; Thu, 23 Aug 2012 04:11:38 -0400 (EDT)
Received: from michael.fritz.box (p57A2588E.dip.t-dialin.net [87.162.88.142])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q7N8AkVE030408
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 23 Aug 2012 04:11:37 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1345709442-16046-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLIsWRmVeSWpSXmKPExsUixO6iqLvrqWmAwdmTehZdV7qZLBp6rzBb
	3F4xn9niR0sPswOLx9/3H5g8nvXuYfS4eEnZ4/MmuQCWKG6bpMSSsuDM9Dx9uwTujNl7T7AV
	zOKsuNG/namBcQ97FyMnh4SAicTns+9YIGwxiQv31rN1MXJxCAlcZpTY9buPCcI5yyQx5/8M
	VpAqNgEpiZeNPWDdIgJqEhPbDoF1MwukSHQ872YEsYUFAiU+zO4Di7MIqEpMmXEfzOYVcJVY
	8usuE8Q2RYkf39cwg9icQPEF3zeB9QoJuEh8bLzJPIGRdwEjwypGucSc0lzd3MTMnOLUZN3i
	5MS8vNQiXQu93MwSvdSU0k2MkAAS2cF45KTcIUYBDkYlHt4X5qYBQqyJZcWVuYcYJTmYlER5
	/z0CCvEl5adUZiQWZ8QXleakFh9ilOBgVhLhDZ8HlONNSaysSi3Kh0lJc7AoifN+W6zuJySQ
	nliSmp2aWpBaBJOV4eBQkuANBUaKkGBRanpqRVpmTglCmomDE0RwgWzgAdqgCFLIW1yQmFuc
	mQ5RdIpRUUqc1wQkIQCSyCjNgxsAi/VXjOJA/wjzuoNU8QDTBFz3K6DBTECD1a4agwwuSURI
	STUwLlYsvMF099CK3pLn8+/H5+W9TPVQlI9RSfb5GPiG0c5309KcY4XhSY0bd/vV7y4vTt0Y
	cODjB5GVi/qKpU5uOPYjwUbnWZPw67kdv+Xm7ay61PK8KHGffY1jz4OkLzJcc1suS5Zwxiaq
	n2YM+H7m8rLb/C4vFLi3vPpxkGGhHhNH0fmCn9IvlViKMxINtZiLihMBmaa2ZNAC 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204133>

From: Michael Haggerty <mhagger@alum.mit.edu>

This fixes a test in t5500.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/fetch-pack.c  | 2 +-
 t/t5500-fetch-pack.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 4794839..5b1e603 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -1028,7 +1028,7 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 		return 1;
 
 	ret = !ref;
-	if (ref && nr_heads) {
+	if (nr_heads) {
 		/* If the heads to pull were given, we should have
 		 * consumed all of them by matching the remote.
 		 * Otherwise, 'git fetch remote no-such-ref' would
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 0d4edcb..f78a118 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -403,7 +403,7 @@ test_expect_success 'set up tests of missing reference' '
 	EOF
 '
 
-test_expect_failure 'test lonely missing ref' '
+test_expect_success 'test lonely missing ref' '
 	(
 	cd client &&
 	test_must_fail git fetch-pack --no-progress .. refs/heads/xyzzy
-- 
1.7.11.3
