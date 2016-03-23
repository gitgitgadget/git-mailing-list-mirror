From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 09/21] resolve_ref_1(): eliminate local variable
Date: Wed, 23 Mar 2016 11:04:26 +0100
Message-ID: <e9008ce41529e6692cb01825c3127a12eb959def.1458723959.git.mhagger@alum.mit.edu>
References: <cover.1458723959.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, peff@peff.net, pclouds@gmail.com,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 11:15:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aifmf-0001Ah-4q
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 11:13:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754718AbcCWKMn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 06:12:43 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:49379 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754688AbcCWKMi (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Mar 2016 06:12:38 -0400
X-AuditID: 1207440c-99fff700000008b4-cb-56f26a4d749e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 6B.D9.02228.D4A62F65; Wed, 23 Mar 2016 06:05:01 -0400 (EDT)
Received: from michael.fritz.box (p548D66C6.dip0.t-ipconnect.de [84.141.102.198])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u2NA4g1E018017
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 23 Mar 2016 06:04:59 -0400
X-Mailer: git-send-email 2.8.0.rc3
In-Reply-To: <cover.1458723959.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJIsWRmVeSWpSXmKPExsUixO6iqOub9SnMoOMIh0XXlW4mi4beK8wW
	t1fMZ7bonvKW0eJHSw+zxcyr1g5sHn/ff2Dy2DnrLrvHs949jB4XLyl77F+6jc3j8ya5ALYo
	bpukxJKy4Mz0PH27BO6MtV/3sBV85q6Y/OwyawPjNs4uRk4OCQETiY331rJ0MXJxCAlsZZQ4
	+HQWO0hCSOAkk8TstbogNpuArsSinmYmEFtEQE1iYtshsAZmgQWMEhsXL2YGSQgLOEg8aLjM
	2sXIwcEioCrR3BQPEuYViJL42PubCWKZksSGBxfAbE4BC4mTJ5cyQuwyl9j+YC3TBEaeBYwM
	qxjlEnNKc3VzEzNzilOTdYuTE/PyUot0DfVyM0v0UlNKNzFCgolnB+O3dTKHGAU4GJV4eCXO
	fAwTYk0sK67MPcQoycGkJMp7PuhTmBBfUn5KZUZicUZ8UWlOavEhRgkOZiUR3uZMoBxvSmJl
	VWpRPkxKmoNFSZxXdYm6n5BAemJJanZqakFqEUxWhoNDSYK3HaRRsCg1PbUiLTOnBCHNxMEJ
	MpxLSqQ4NS8ltSixtCQjHhQB8cXAGABJ8QDtbQXbW1yQmAsUhWg9xagoJc7rDZIQAElklObB
	jYWliFeM4kBfCvOuBKniAaYXuO5XQIOZgAYv9AEbXJKIkJJqYMyo3OnQckRWdIOJlYa//H3z
	H9lXLBdksmV8kvJ5dngdE7/O3IzGw4tN3/6MYjwuU/9ew0bgsEbAFM57aRs9TEQaDI+726/a
	UfNS70x8aEJXmko/X79onqvp9amCWRcrd/RMq/zNeGPLxDnW964JRCrtNtU9aLdu 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289626>

In place of `buf`, use `refname`, which is anyway a better description
of what is being pointed at.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 067ce1c..69ec903 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1426,7 +1426,6 @@ static const char *resolve_ref_1(const char *refname,
 	for (symref_count = 0; symref_count < MAXDEPTH; symref_count++) {
 		const char *path;
 		struct stat st;
-		char *buf;
 		int fd;
 
 		strbuf_reset(sb_path);
@@ -1532,21 +1531,21 @@ static const char *resolve_ref_1(const char *refname,
 			return refname;
 		}
 		*flags |= REF_ISSYMREF;
-		buf = sb_contents->buf + 4;
-		while (isspace(*buf))
-			buf++;
+		refname = sb_contents->buf + 4;
+		while (isspace(*refname))
+			refname++;
 		strbuf_reset(sb_refname);
-		strbuf_addstr(sb_refname, buf);
+		strbuf_addstr(sb_refname, refname);
 		refname = sb_refname->buf;
 		if (resolve_flags & RESOLVE_REF_NO_RECURSE) {
 			hashclr(sha1);
 			return refname;
 		}
-		if (check_refname_format(buf, REFNAME_ALLOW_ONELEVEL)) {
+		if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
 			*flags |= REF_ISBROKEN;
 
 			if (!(resolve_flags & RESOLVE_REF_ALLOW_BAD_NAME) ||
-			    !refname_is_safe(buf)) {
+			    !refname_is_safe(refname)) {
 				errno = EINVAL;
 				return NULL;
 			}
-- 
2.8.0.rc3
