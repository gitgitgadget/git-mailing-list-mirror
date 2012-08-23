From: mhagger@alum.mit.edu
Subject: [PATCH 07/17] Pass nr_heads to do_pack_ref() by reference
Date: Thu, 23 Aug 2012 10:10:32 +0200
Message-ID: <1345709442-16046-8-git-send-email-mhagger@alum.mit.edu>
References: <1345709442-16046-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 23 10:19:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4SdP-0000rv-PE
	for gcvg-git-2@plane.gmane.org; Thu, 23 Aug 2012 10:19:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933725Ab2HWITG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Aug 2012 04:19:06 -0400
Received: from ALUM-MAILSEC-SCANNER-6.MIT.EDU ([18.7.68.18]:56734 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933713Ab2HWISv (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Aug 2012 04:18:51 -0400
X-Greylist: delayed 450 seconds by postgrey-1.27 at vger.kernel.org; Thu, 23 Aug 2012 04:18:51 EDT
X-AuditID: 12074412-b7f216d0000008e3-33-5035e5a775ee
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 3F.B8.02275.7A5E5305; Thu, 23 Aug 2012 04:11:19 -0400 (EDT)
Received: from michael.fritz.box (p57A2588E.dip.t-dialin.net [87.162.88.142])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q7N8AkV7030408
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 23 Aug 2012 04:11:18 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1345709442-16046-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPIsWRmVeSWpSXmKPExsUixO6iqLv8qWmAwdfd1hZdV7qZLBp6rzBb
	3F4xn9niR0sPswOLx9/3H5g8nvXuYfS4eEnZ4/MmuQCWKG6bpMSSsuDM9Dx9uwTujCXNM5kL
	LnBXPGn7xtLAeICzi5GTQ0LARGLe71fMELaYxIV769m6GLk4hAQuM0r8eL2dCcI5yyRx9Ekv
	G0gVm4CUxMvGHnYQW0RATWJi2yEWEJtZIEWi43k3I4gtLOAkMfvQGbA4i4CqxIGlN8HqeQVc
	JGa/+M8OsU1R4sf3NWCbOQVcJRZ83wTWKwRU87HxJvMERt4FjAyrGOUSc0pzdXMTM3OKU5N1
	i5MT8/JSi3TN9HIzS/RSU0o3MUICSGgH4/qTcocYBTgYlXh4X5ibBgixJpYVV+YeYpTkYFIS
	5f33CCjEl5SfUpmRWJwRX1Sak1p8iFGCg1lJhDd8HlCONyWxsiq1KB8mJc3BoiTO+3Oxup+Q
	QHpiSWp2ampBahFMVoaDQ0mCVxIYKUKCRanpqRVpmTklCGkmDk6Q4VxSIsWpeSmpRYmlJRnx
	oNiILwZGB0iKB2ivIkg7b3FBYi5QFKL1FKMux/+TJ+8yCrHk5eelSonzmoAUCYAUZZTmwa2A
	pYtXjOJAHwvzuoNU8QBTDdykV0BLmICWqF01BllSkoiQkmpgNJyWO+XZsvTvM6SXmp2+vf5W
	fuqljVK7ZEOOi+85rXQg8o7+0m0d210UFvFq/zmh2jRj9431SzqcV1sEOMTYJ4VvmsRn7n5Q
	4/q2l7V9PQ+VZtb6+T5d11eYyPEw69vRSpnpb9dEH4gKPBuqpt658l7eFsPAfa5V 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204126>

From: Michael Haggerty <mhagger@alum.mit.edu>

This is the first of a few baby steps towards changing filter_refs()
to compress matched refs out of the list rather than overwriting the
first character of such references with '\0'.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/fetch-pack.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 3c93ec4..d3ff166 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -777,7 +777,7 @@ static int get_pack(int xd[2], char **pack_lockfile)
 
 static struct ref *do_fetch_pack(int fd[2],
 		const struct ref *orig_ref,
-		int nr_heads, char **heads,
+		int *nr_heads, char **heads,
 		char **pack_lockfile)
 {
 	struct ref *ref = copy_ref_list(orig_ref);
@@ -818,7 +818,7 @@ static struct ref *do_fetch_pack(int fd[2],
 			fprintf(stderr, "Server supports ofs-delta\n");
 	} else
 		prefer_ofs_delta = 0;
-	if (everything_local(&ref, nr_heads, heads)) {
+	if (everything_local(&ref, *nr_heads, heads)) {
 		packet_flush(fd[1]);
 		goto all_done;
 	}
@@ -1086,7 +1086,7 @@ struct ref *fetch_pack(struct fetch_pack_args *my_args,
 		packet_flush(fd[1]);
 		die("no matching remote head");
 	}
-	ref_cpy = do_fetch_pack(fd, ref, *nr_heads, heads, pack_lockfile);
+	ref_cpy = do_fetch_pack(fd, ref, nr_heads, heads, pack_lockfile);
 
 	if (args.depth > 0) {
 		struct cache_time mtime;
-- 
1.7.11.3
