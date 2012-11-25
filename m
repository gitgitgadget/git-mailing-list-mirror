From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 3/8] lf_to_crlf(): NUL-terminate msg_data::data
Date: Sun, 25 Nov 2012 12:08:36 +0100
Message-ID: <1353841721-16269-4-git-send-email-mhagger@alum.mit.edu>
References: <1353841721-16269-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeremy White <jwhite@codeweavers.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 25 12:09:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tca5l-0004G0-B8
	for gcvg-git-2@plane.gmane.org; Sun, 25 Nov 2012 12:09:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753154Ab2KYLJU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2012 06:09:20 -0500
Received: from ALUM-MAILSEC-SCANNER-6.MIT.EDU ([18.7.68.18]:44172 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753125Ab2KYLJS (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Nov 2012 06:09:18 -0500
X-AuditID: 12074412-b7f216d0000008e3-46-50b1fc5d6aad
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id D3.C1.02275.D5CF1B05; Sun, 25 Nov 2012 06:09:17 -0500 (EST)
Received: from michael.fritz.box (p57A25314.dip.t-dialin.net [87.162.83.20])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id qAPB90UF002898
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 25 Nov 2012 06:09:16 -0500
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1353841721-16269-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsUixO6iqBv7Z2OAwak/phZdV7qZLBp6rzBb
	9C/vYrO4fHIuo8XtFfOZHVg9/r7/wOTx5Wojk8eHj3EeFy8pe3zeJBfAGsVtk5RYUhacmZ6n
	b5fAnbHzzFP2gttcFYeeNbM1MC7j6GLk4JAQMJE41qbaxcgJZIpJXLi3nq2LkYtDSOAyo8T0
	j/ehnDNMEmcXvGIFqWIT0JVY1NPMBGKLCKhJTGw7xAJSxCywmlFi8pbz7CAJYQF7iZl/X4AV
	sQioSux99h7M5hVwkXh5vZUdYp2cxIc9j8BsTgFXiR/7HrCB2EJANZsv7GecwMi7gJFhFaNc
	Yk5prm5uYmZOcWqybnFyYl5eapGumV5uZoleakrpJkZISAntYFx/Uu4QowAHoxIP783EjQFC
	rIllxZW5hxglOZiURHnnfgUK8SXlp1RmJBZnxBeV5qQWH2KU4GBWEuENfQaU401JrKxKLcqH
	SUlzsCiJ8/5crO4nJJCeWJKanZpakFoEk5Xh4FCS4G3/DdQoWJSanlqRlplTgpBm4uAEEVwg
	G3iANswHKeQtLkjMLc5Mhyg6xagoJc5bD5IQAElklObBDYBF/ytGcaB/hHnXglTxABMHXPcr
	oMFMQIOTr4MNLklESEk1MM5a6rLIqC3WTfi9q+m0SVFbfmWx6J5eGnPEpPmfRmnXBfGiq9MO
	7nzXxf4l9GmZxRRVxxqOFz8/Bs5QfB1XaNBacKvq0sanD5Pel/5lVd8g7f1v84L76wuYbwXO
	lXxxtTUgQoEh1ub+iqu7qriOcP29Vlme3Xpp8gI2r+Xfz7JMnTwpKqJe6IcSS3FG 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210359>

Through the rest of the file, the data member of struct msg_data is
kept NUL-terminated, and that fact is relied upon in a couple of
places.  Change lf_to_crlf() to preserve this invariant.

In fact, there are no execution paths in which lf_to_crlf() is called
and then its data member is required to be NUL-terminated, but it is
better to be consistent to prevent future confusion.

Document the invariant in the struct msg_data definition.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 imap-send.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/imap-send.c b/imap-send.c
index d42e471..c818b0c 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -69,8 +69,12 @@ struct store {
 };
 
 struct msg_data {
+	/* NUL-terminated data: */
 	char *data;
+
+	/* length of data (not including NUL): */
 	int len;
+
 	unsigned char flags;
 };
 
@@ -1276,7 +1280,7 @@ static void lf_to_crlf(struct msg_data *msg)
 			lfnum++;
 	}
 
-	new = xmalloc(msg->len + lfnum);
+	new = xmalloc(msg->len + lfnum + 1);
 	if (msg->data[0] == '\n') {
 		new[0] = '\r';
 		new[1] = '\n';
@@ -1297,6 +1301,7 @@ static void lf_to_crlf(struct msg_data *msg)
 		/* otherwise it already had CR before */
 		new[j++] = '\n';
 	}
+	new[j] = '\0';
 	msg->len += lfnum;
 	free(msg->data);
 	msg->data = new;
-- 
1.8.0
