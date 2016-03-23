From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 11/21] resolve_ref_1(): eliminate local variable "bad_name"
Date: Wed, 23 Mar 2016 11:04:28 +0100
Message-ID: <2702bd2cb33c454eea064e21a7cedded0580ed63.1458723959.git.mhagger@alum.mit.edu>
References: <cover.1458723959.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, peff@peff.net, pclouds@gmail.com,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 11:15:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aifmo-0001Ah-UE
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 11:13:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754740AbcCWKND (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 06:13:03 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:49322 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754711AbcCWKMr (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Mar 2016 06:12:47 -0400
X-AuditID: 12074411-fd3ff700000071cf-f4-56f26a502e78
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 3E.17.29135.05A62F65; Wed, 23 Mar 2016 06:05:04 -0400 (EDT)
Received: from michael.fritz.box (p548D66C6.dip0.t-ipconnect.de [84.141.102.198])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u2NA4g1G018017
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 23 Mar 2016 06:05:02 -0400
X-Mailer: git-send-email 2.8.0.rc3
In-Reply-To: <cover.1458723959.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBIsWRmVeSWpSXmKPExsUixO6iqBuQ9SnM4N8NBYuuK91MFg29V5gt
	bq+Yz2zRPeUto8WPlh5mi5lXrR3YPP6+/8DksXPWXXaPZ717GD0uXlL22L90G5vH501yAWxR
	3DZJiSVlwZnpefp2CdwZhy/GFvzhq2hcU9bAOJe7i5GTQ0LAROLymeVsILaQwFZGicXTeboY
	uYDsk0wS85unsoIk2AR0JRb1NDOB2CICahIT2w6xgBQxCyxglNi4eDEzSEJYwFviXM80sAYW
	AVWJm2+3gTXwCkRJrLn9gQlim5LEhgcXwGxOAQuJkyeXMkJsNpfY/mAt0wRGngWMDKsY5RJz
	SnN1cxMzc4pTk3WLkxPz8lKLdE31cjNL9FJTSjcxQkJJcAfjjJNyhxgFOBiVeHgLz30ME2JN
	LCuuzD3EKMnBpCTKez7oU5gQX1J+SmVGYnFGfFFpTmrxIUYJDmYlEd6QDKAcb0piZVVqUT5M
	SpqDRUmcl2+Jup+QQHpiSWp2ampBahFMVoaDQ0mC91o6UKNgUWp6akVaZk4JQpqJgxNkOJeU
	SHFqXkpqUWJpSUY8KPzji4ERAJLiAdobCba3uCAxFygK0XqKUVFKnFcDJCEAksgozYMbC0sQ
	rxjFgb4U5q0HqeIBJhe47ldAg5mABi/0ARtckoiQkmpgnPh5TrbzRnP9zdbLFy1PtW2YF61l
	eX2hwBGOnktXpn/x3PUppyLo8pPn/q8SVPpWSEVq8/5OXXbCY0LL5JvxOTd7L8zV/T33uoVA
	bUnWpVNtPcV8Jms+LeZVu/EgRWmpZW8az8FZ0n4KhT8e+5imsf3x3Wxxe/GRMlWb 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289618>

We can use (*flags & REF_BAD_NAME) for that purpose.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 60f1493..b865ba5 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1399,19 +1399,17 @@ static const char *resolve_ref_1(const char *refname,
 				 struct strbuf *sb_path,
 				 struct strbuf *sb_contents)
 {
-	int bad_name = 0;
 	int symref_count;
 
 	*flags = 0;
 
 	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
-		*flags |= REF_BAD_NAME;
-
 		if (!(resolve_flags & RESOLVE_REF_ALLOW_BAD_NAME) ||
 		    !refname_is_safe(refname)) {
 			errno = EINVAL;
 			return NULL;
 		}
+
 		/*
 		 * dwim_ref() uses REF_ISBROKEN to distinguish between
 		 * missing refs and refs that were present but invalid,
@@ -1420,7 +1418,7 @@ static const char *resolve_ref_1(const char *refname,
 		 * We don't know whether the ref exists, so don't set
 		 * REF_ISBROKEN yet.
 		 */
-		bad_name = 1;
+		*flags |= REF_BAD_NAME;
 	}
 
 	for (symref_count = 0; symref_count < MAXDEPTH; symref_count++) {
@@ -1452,7 +1450,7 @@ static const char *resolve_ref_1(const char *refname,
 				}
 				hashclr(sha1);
 			}
-			if (bad_name) {
+			if (*flags & REF_BAD_NAME) {
 				hashclr(sha1);
 				*flags |= REF_ISBROKEN;
 			}
@@ -1524,7 +1522,7 @@ static const char *resolve_ref_1(const char *refname,
 				errno = EINVAL;
 				return NULL;
 			}
-			if (bad_name) {
+			if (*flags & REF_BAD_NAME) {
 				hashclr(sha1);
 				*flags |= REF_ISBROKEN;
 			}
@@ -1548,8 +1546,7 @@ static const char *resolve_ref_1(const char *refname,
 				return NULL;
 			}
 
-			*flags |= REF_ISBROKEN;
-			bad_name = 1;
+			*flags |= REF_ISBROKEN | REF_BAD_NAME;
 		}
 	}
 
-- 
2.8.0.rc3
