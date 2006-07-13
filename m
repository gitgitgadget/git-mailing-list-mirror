From: Robert Shearman <rob@codeweavers.com>
Subject: [PATCH] format-patch: Generate a newline between the subject header
 and the message body
Date: Thu, 13 Jul 2006 23:17:22 +0100
Organization: CodeWeavers
Message-ID: <44B6C672.9090300@codeweavers.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030503020701050208020603"
X-From: git-owner@vger.kernel.org Fri Jul 14 00:18:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G19VP-00087p-1C
	for gcvg-git@gmane.org; Fri, 14 Jul 2006 00:17:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030429AbWGMWR4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Jul 2006 18:17:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030431AbWGMWR4
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Jul 2006 18:17:56 -0400
Received: from mail.codeweavers.com ([216.251.189.131]:63934 "EHLO
	mail.codeweavers.com") by vger.kernel.org with ESMTP
	id S1030429AbWGMWRz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jul 2006 18:17:55 -0400
Received: from host86-141-83-116.range86-141.btcentralplus.com ([86.141.83.116] helo=[172.16.0.10])
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1G19VJ-0000oo-RO
	for git@vger.kernel.org; Thu, 13 Jul 2006 17:17:54 -0500
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060502)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23860>

This is a multi-part message in MIME format.
--------------030503020701050208020603
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


format-patch previously didn't generate a newline after a subject. This 
caused the diffstat to not be displayed in messages with only one line 
for the commit message.
This patch fixes this by adding a newline after the headers if a body 
hasn't been added.
Signed-off-by: Robert Shearman <rob@codeweavers.com>
---
  commit.c |   11 +++++++++--
  1 files changed, 9 insertions(+), 2 deletions(-)

--------------030503020701050208020603
Content-Type: text/x-patch;
 name="e4ec67def0af32e4a1704ce5ad941c81136b34e8.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="e4ec67def0af32e4a1704ce5ad941c81136b34e8.diff"

diff --git a/commit.c b/commit.c
index 522a6f3..6ac3bf7 100644
--- a/commit.c
+++ b/commit.c
@@ -655,6 +655,9 @@ unsigned long pretty_print_commit(enum c
 			continue;
 		}
 
+		if (!subject)
+			body = 1;
+
 		if (is_empty_line(line, &linelen)) {
 			if (!body)
 				continue;
@@ -662,8 +665,6 @@ unsigned long pretty_print_commit(enum c
 				continue;
 			if (fmt == CMIT_FMT_SHORT)
 				break;
-		} else {
-			body = 1;
 		}
 
 		if (subject) {
@@ -702,6 +703,12 @@ unsigned long pretty_print_commit(enum c
 	/* Make sure there is an EOLN for the non-oneline case */
 	if (fmt != CMIT_FMT_ONELINE)
 		buf[offset++] = '\n';
+	/*
+	 * make sure there is another EOLN to separate the headers from whatever
+	 * body the caller appends if we haven't already written a body
+	 */
+	if (fmt == CMIT_FMT_EMAIL && !body)
+		buf[offset++] = '\n';
 	buf[offset] = '\0';
 	return offset;
 }


--------------030503020701050208020603--
