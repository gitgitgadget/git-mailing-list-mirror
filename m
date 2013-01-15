From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 07/14] imap-send.c: inline imap_parse_list() in imap_list()
Date: Tue, 15 Jan 2013 09:06:25 +0100
Message-ID: <1358237193-8887-8-git-send-email-mhagger@alum.mit.edu>
References: <1358237193-8887-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 15 09:14:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tv1fK-0008WQ-RA
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 09:14:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756474Ab3AOIOT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 03:14:19 -0500
Received: from ALUM-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.20]:42959 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756258Ab3AOIOS (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Jan 2013 03:14:18 -0500
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 Jan 2013 03:14:18 EST
X-AuditID: 12074414-b7f9b6d0000008b3-f1-50f50e34adf4
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 65.2E.02227.43E05F05; Tue, 15 Jan 2013 03:07:16 -0500 (EST)
Received: from michael.berlin.jpk.com (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r0F86n5T029668
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 15 Jan 2013 03:07:15 -0500
X-Mailer: git-send-email 1.8.0.3
In-Reply-To: <1358237193-8887-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsUixO6iqGvC9zXA4FGngEXXlW4mi4beK8wW
	t1fMZ3Zg9vj7/gOTx8VLyh6fN8kFMEdx2yQllpQFZ6bn6dslcGfsePOOpeAMW8XUSyfYGxgX
	s3YxcnJICJhIfO3axgxhi0lcuLeerYuRi0NI4DKjxJYNy1khnDNMEseWXmcDqWIT0JVY1NPM
	BGKLCKhJTGw7xAJiMws4SGz+3MgIYgsL+EmsWzkZbCqLgKpE+50PYNt4BZwlllx9wQSxTUHi
	9c5LYHFOAReJqz+PgdULAdV82XCacQIj7wJGhlWMcok5pbm6uYmZOcWpybrFyYl5ealFuhZ6
	uZkleqkppZsYIcEisoPxyEm5Q4wCHIxKPLwmBl8ChFgTy4orcw8xSnIwKYnydnB9DRDiS8pP
	qcxILM6ILyrNSS0+xCjBwawkwuvzDqicNyWxsiq1KB8mJc3BoiTO+22xup+QQHpiSWp2ampB
	ahFMVoaDQ0mC9ykP0FDBotT01Iq0zJwShDQTByeI4ALZwAO0oZsXqJC3uCAxtzgzHaLoFKOi
	lDjvHpAJAiCJjNI8uAGwuH7FKA70jzCvKEg7DzAlwHW/AhrMBDR4097PIINLEhFSUg2MNQ0L
	vHmcpj0OiZ7+wqi3/P6FzOIwJp1rF077HjrqtvKxdpiSeJlxzk+X78ZmM2o01zLtT7uiLx6n
	+N81ea3nxzjVE/l9bpW8577n5e97qMq302BC1YGX5vOWXlbtux82V9ZQ8e9lLuHvVkEt4S/8
	H2w4N3//5vkW9bHxEx84PWO7WHGQ+1OGEktxRqKhFnNRcSIAI2dgqcYCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213616>

The function is only called from here.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 imap-send.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index f193211..cbbf845 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -669,21 +669,16 @@ bail:
 	return -1;
 }
 
-static struct imap_list *parse_imap_list(struct imap *imap, char **sp)
+static struct imap_list *parse_list(char **sp)
 {
 	struct imap_list *head;
 
-	if (!parse_imap_list_l(imap, sp, &head, 0))
+	if (!parse_imap_list_l(NULL, sp, &head, 0))
 		return head;
 	free_list(head);
 	return NULL;
 }
 
-static struct imap_list *parse_list(char **sp)
-{
-	return parse_imap_list(NULL, sp);
-}
-
 static void parse_capability(struct imap *imap, char *cmd)
 {
 	char *arg;
-- 
1.8.0.3
