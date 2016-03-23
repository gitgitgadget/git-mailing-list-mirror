From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 07/21] resolve_ref_unsafe(): use for loop to count up to MAXDEPTH
Date: Wed, 23 Mar 2016 11:04:24 +0100
Message-ID: <418fbb7db3d1804dd1a4d6abc723dd59bb95ea2f.1458723959.git.mhagger@alum.mit.edu>
References: <cover.1458723959.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, peff@peff.net, pclouds@gmail.com,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 11:15:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiflu-0000NM-6A
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 11:12:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754419AbcCWKMK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 06:12:10 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:54345 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752037AbcCWKMI (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Mar 2016 06:12:08 -0400
X-Greylist: delayed 424 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Mar 2016 06:12:08 EDT
X-AuditID: 12074413-f03ff7000000516b-e6-56f26a4a4465
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 1F.9E.20843.A4A62F65; Wed, 23 Mar 2016 06:04:58 -0400 (EDT)
Received: from michael.fritz.box (p548D66C6.dip0.t-ipconnect.de [84.141.102.198])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u2NA4g1C018017
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 23 Mar 2016 06:04:56 -0400
X-Mailer: git-send-email 2.8.0.rc3
In-Reply-To: <cover.1458723959.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsUixO6iqOuV9SnMYE0zn0XXlW4mi4beK8wW
	t1fMZ7bonvKW0eJHSw+zxcyr1g5sHn/ff2Dy2DnrLrvHs949jB4XLyl77F+6jc3j8ya5ALYo
	bpukxJKy4Mz0PH27BO6MPTN2MxX85azY+WAKYwPjRfYuRk4OCQETiXnbj7J0MXJxCAlsZZTY
	dXUpK4Rzkkli+c3VbCBVbAK6Eot6mplAbBEBNYmJbYfAOpgFFjBKbFy8mBkkISwQKNFwpwus
	gUVAVeLIijtgDbwCURLf29ZArVOS2PDgAlicU8BC4uTJpYwgtpCAucT2B2uZJjDyLGBkWMUo
	l5hTmqubm5iZU5yarFucnJiXl1qka66Xm1mil5pSuokRElDCOxh3nZQ7xCjAwajEw1t47mOY
	EGtiWXFl7iFGSQ4mJVHe80GfwoT4kvJTKjMSizPii0pzUosPMUpwMCuJ8HJmAuV4UxIrq1KL
	8mFS0hwsSuK8akvU/YQE0hNLUrNTUwtSi2CyMhwcShK82zKAGgWLUtNTK9Iyc0oQ0kwcnCDD
	uaREilPzUlKLEktLMuJBURBfDIwDkBQP0F5esL3FBYm5QFGI1lOMilLivBogcwVAEhmleXBj
	YWniFaM40JfCEGfzAFMMXPcroMFMQIMX+oANLklESEk1MDpP3N/7rsXg1OyFvz7dLzXW2FNT
	LRD3dXHBbL/GmLsnN3/MmHBF/kTPhne2Uq7zrnhlbFeYYP7MtkzHddqWwvsTZ81OFnv7MvWV
	XPIN60VnVyzpn35QIrPO/+mF+/e9N+n7LrTcnubItP2517w/K7e5Czznzfqs7tT5 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289623>

The loop's there anyway; we might as well use it.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index c0cf6fd..101abba 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1400,8 +1400,8 @@ static const char *resolve_ref_1(const char *refname,
 				 struct strbuf *sb_path,
 				 struct strbuf *sb_contents)
 {
-	int depth = MAXDEPTH;
 	int bad_name = 0;
+	int symref_count;
 
 	if (flags)
 		*flags = 0;
@@ -1425,17 +1425,13 @@ static const char *resolve_ref_1(const char *refname,
 		 */
 		bad_name = 1;
 	}
-	for (;;) {
+
+	for (symref_count = 0; symref_count < MAXDEPTH; symref_count++) {
 		const char *path;
 		struct stat st;
 		char *buf;
 		int fd;
 
-		if (--depth < 0) {
-			errno = ELOOP;
-			return NULL;
-		}
-
 		strbuf_reset(sb_path);
 		strbuf_git_path(sb_path, "%s", refname);
 		path = sb_path->buf;
@@ -1566,6 +1562,9 @@ static const char *resolve_ref_1(const char *refname,
 			bad_name = 1;
 		}
 	}
+
+	errno = ELOOP;
+	return NULL;
 }
 
 const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
-- 
2.8.0.rc3
