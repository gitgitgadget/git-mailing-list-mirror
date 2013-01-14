From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 07/14] imap-send.c: inline imap_parse_list() in imap_list()
Date: Mon, 14 Jan 2013 06:32:39 +0100
Message-ID: <1358141566-26081-8-git-send-email-mhagger@alum.mit.edu>
References: <1358141566-26081-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 14 06:41:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TucnP-0005In-GM
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 06:41:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371Ab3ANFk7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 00:40:59 -0500
Received: from ALUM-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.20]:46075 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751040Ab3ANFk6 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Jan 2013 00:40:58 -0500
X-AuditID: 12074414-b7f9b6d0000008b3-fc-50f398b97d9d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 78.31.02227.9B893F05; Mon, 14 Jan 2013 00:33:45 -0500 (EST)
Received: from michael.fritz.box (p57A25AA5.dip.t-dialin.net [87.162.90.165])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r0E5Wt2o026427
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 14 Jan 2013 00:33:44 -0500
X-Mailer: git-send-email 1.8.0.3
In-Reply-To: <1358141566-26081-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLIsWRmVeSWpSXmKPExsUixO6iqLtzxucAg761VhZdV7qZLBp6rzBb
	3F4xn9niR0sPswOLx9/3H5g8nvXuYfS4eEnZ4/MmuQCWKG6bpMSSsuDM9Dx9uwTujDPPfzMV
	nGGr+LLuLWsD42LWLkZODgkBE4lV+1+xQdhiEhfurQeyuTiEBC4zShzduRTKOcskcejJEkaQ
	KjYBXYlFPc1MILaIgJrExLZDLCA2s0CKRMfzbrAaYQFvidsL/jOD2CwCqhIXz3SA2bwCLhLf
	t9yF2qwg8XrnJTCbU8BV4vvHU2A1QkA1D081s01g5F3AyLCKUS4xpzRXNzcxM6c4NVm3ODkx
	Ly+1SNdCLzezRC81pXQTIySARHYwHjkpd4hRgINRiYd3c8nnACHWxLLiytxDjJIcTEqivOH9
	QCG+pPyUyozE4oz4otKc1OJDjBIczEoivKF1QDnelMTKqtSifJiUNAeLkjjvt8XqfkIC6Ykl
	qdmpqQWpRTBZGQ4OJQne0OlAjYJFqempFWmZOSUIaSYOThDBBbKBB2hDDUghb3FBYm5xZjpE
	0SlGRSlx3lSQhABIIqM0D24ALNZfMYoD/SPM2wRSxQNME3Ddr4AGMwENPnvhPcjgkkSElFQD
	43pR6SkGHrFXXOul70q/2ejF2PT34OMJaWXvp9p9WvQpsai2uC08WWeOqLLMarFt4h+sHD8J
	OZtIefkJ/FsRe7+n/7CWW+Kmq89e6vJ+vt72JanwS+cGjWcODK8UtyQ/Njizp5b/uOrF97O/
	333Q9bbra6bpjQ17JJWO2C/13+qzQ/HdlZRzLEosxRmJhlrMRcWJAAWzBf3QAgAA 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213444>

The function is only called from here.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 imap-send.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index fe2bfab..452e73e 100644
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
