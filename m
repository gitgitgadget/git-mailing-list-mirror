From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 04/17] safe_create_leading_directories(): rename local variable
Date: Sat, 18 Jan 2014 23:48:48 +0100
Message-ID: <1390085341-2553-5-git-send-email-mhagger@alum.mit.edu>
References: <1390085341-2553-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 18 23:50:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W4eiF-0005CE-E3
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jan 2014 23:49:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751792AbaARWtr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jan 2014 17:49:47 -0500
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:58704 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751700AbaARWte (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Jan 2014 17:49:34 -0500
X-AuditID: 1207440c-b7f566d000004272-78-52db04fd5747
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 30.CE.17010.DF40BD25; Sat, 18 Jan 2014 17:49:33 -0500 (EST)
Received: from michael.fritz.box (p4FDD4E9C.dip0.t-ipconnect.de [79.221.78.156])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s0IMnN8v030075
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 18 Jan 2014 17:49:32 -0500
X-Mailer: git-send-email 1.8.5.2
In-Reply-To: <1390085341-2553-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAIsWRmVeSWpSXmKPExsUixO6iqPuX5XaQwc0DKhZdV7qZLBp6rzBb
	3F4xn9mB2ePv+w9MHhcvKXt83iQXwBzFbZOUWFIWnJmep2+XwJ3xbsMRpoKb7BWHZro1MDaw
	dTFyckgImEj86r3GDGGLSVy4tx4ozsUhJHCZUeJNVycjhHOCSaJ76wV2kCo2AV2JRT3NTCC2
	iICaxMS2QywgNrOAg8Tmz41ADRwcwgJBEr++u4GEWQRUJSZ8WwpWwivgLNG8YgkTSImEgILE
	6utCIGFOAReJI/MvgE0UAiq5+foJ+wRG3gWMDKsY5RJzSnN1cxMzc4pTk3WLkxPz8lKLdA31
	cjNL9FJTSjcxQsKEZwfjt3UyhxgFOBiVeHgzGG4HCbEmlhVX5h5ilORgUhLlVWYCCvEl5adU
	ZiQWZ8QXleakFh9ilOBgVhLhDd5wK0iINyWxsiq1KB8mJc3BoiTOq7pE3U9IID2xJDU7NbUg
	tQgmK8PBoSTBKwCMByHBotT01Iq0zJwShDQTByeI4ALZwAO0QRKkkLe4IDG3ODMdougUo6KU
	OK88SEIAJJFRmgc3ABbRrxjFgf4R5r3PDFTFA0wGcN2vgAYzAQ0Wib0JMrgkESEl1cBYeOha
	4eMPrS/Url9/d7y/buOcWdfV3GQ2M8doBCgeaG7/pb0+06A6UHnRfE+umvMuBT/MFN2mxeyq
	q4toq4k5cKO0oODqxl0P+LesWTe7x6r+k0vCgrDnSUdYpI/Fq7ysknP2OMj/9sOx4/c7p0XV
	zHxhvYVbUOvTqWLBKewrov63XKtvu3tYiaU4I9FQi7moOBEA8A+JKcMCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240658>

Rename "pos" to "next_component", because now it always points at the
next component of the path name that has to be processed.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 sha1_file.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 88b8d8c..1e1510d 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -107,18 +107,18 @@ int mkdir_in_gitdir(const char *path)
 
 int safe_create_leading_directories(char *path)
 {
-	char *pos = path + offset_1st_component(path);
+	char *next_component = path + offset_1st_component(path);
 
-	while (pos) {
+	while (next_component) {
 		struct stat st;
-		char *slash = strchr(pos, '/');
+		char *slash = strchr(next_component, '/');
 
 		if (!slash)
 			break;
 		while (*(slash + 1) == '/')
 			slash++;
-		pos = slash + 1;
-		if (!*pos)
+		next_component = slash + 1;
+		if (!*next_component)
 			break;
 
 		*slash = '\0';
-- 
1.8.5.2
