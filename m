From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 23/25] exclude_existing(): set existing_refs.strdup_strings
Date: Sat, 25 May 2013 11:08:22 +0200
Message-ID: <1369472904-12875-24-git-send-email-mhagger@alum.mit.edu>
References: <1369472904-12875-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johan Herland <johan@herland.net>, Thomas Rast <trast@inf.ethz.ch>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 25 11:09:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UgATu-0005LV-SB
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 11:09:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755085Ab3EYJJe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 May 2013 05:09:34 -0400
Received: from ALUM-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.20]:50792 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754611Ab3EYJJc (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 May 2013 05:09:32 -0400
X-AuditID: 12074414-b7fb86d000000905-0a-51a07fcb8f2b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id BD.D4.02309.BCF70A15; Sat, 25 May 2013 05:09:31 -0400 (EDT)
Received: from michael.fritz.box (p4FDD49F3.dip0.t-ipconnect.de [79.221.73.243])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r4P98gux000489
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 25 May 2013 05:09:30 -0400
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1369472904-12875-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsUixO6iqHu6fkGgwZZv+hZdV7qZLBp6rzBb
	zLu7i8ni9or5zBY/WnqYLe5eXsXuwObx9/0HJo9LL7+zedx+PZ/Z41nvHkaPi5eUPT5vkgtg
	i+K2SUosKQvOTM/Tt0vgztjQf4mp4BFbxbM5H9kbGM+wdjFyckgImEjM//ePCcIWk7hwbz1b
	FyMXh5DAZUaJVX/3MUE4F5gk3n/dzwxSxSagK7GopxmsQ0TAUeLEg+usIEXMAr2MEg8ffQdL
	CAv4STw53MoCYrMIqEr8mjEFrJlXwFWi+dAsZoh1ChKXZ60Bsjk4OIHib09wgoSFBFwknn86
	xzqBkXcBI8MqRrnEnNJc3dzEzJzi1GTd4uTEvLzUIl0LvdzMEr3UlNJNjJBAE9nBeOSk3CFG
	AQ5GJR5egfL5gUKsiWXFlbmHGCU5mJREeflrFwQK8SXlp1RmJBZnxBeV5qQWH2KU4GBWEuFl
	SAHK8aYkVlalFuXDpKQ5WJTEeb8tVvcTEkhPLEnNTk0tSC2CycpwcChJ8O6tA2oULEpNT61I
	y8wpQUgzcXCCCC6QDTxAG86CFPIWFyTmFmemQxSdYlSUEue9CZIQAElklObBDYClhFeM4kD/
	CPPeBaniAaYTuO5XQIOZgAbfzJ0PMrgkESEl1cAo73zF+I3lheQa+4L2gkd5dn86lGRsIpNY
	Xd30U/xe11+69Lz21tF3B3ftdS4tUcvOy2Av7j+2WzqpYfPf5edMXd8s+72aI8VOUzAsSGx5
	j3D8ovMhrio6K7PerpU1/cNq1/Zwj4PPFVnr7He+HTX3k3Kz+39cNfvy8Gila9um 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225504>

The each_ref_fn add_existing() adds refnames to the existing_refs
list.  But the lifetimes of these refnames is not guaranteed by the
refs API, so configure the string_list to make copies as it adds them.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/show-ref.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 8d9b76a..4a0310d 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -103,7 +103,7 @@ static int add_existing(const char *refname, const unsigned char *sha1, int flag
  */
 static int exclude_existing(const char *match)
 {
-	static struct string_list existing_refs = STRING_LIST_INIT_NODUP;
+	static struct string_list existing_refs = STRING_LIST_INIT_DUP;
 	char buf[1024];
 	int matchlen = match ? strlen(match) : 0;
 
-- 
1.8.2.3
