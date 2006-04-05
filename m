From: Mike McCormack <mike@codeweavers.com>
Subject: [PATCH] Avoid a divide by zero if there's no messages to send.
Date: Wed, 05 Apr 2006 23:22:52 +0900
Organization: CodeWeavers
Message-ID: <4433D2BC.4000306@codeweavers.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020403070402060004070007"
X-From: git-owner@vger.kernel.org Wed Apr 05 16:44:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FR9Dz-0003ma-TQ
	for gcvg-git@gmane.org; Wed, 05 Apr 2006 16:43:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750791AbWDEOnH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Apr 2006 10:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750799AbWDEOnH
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Apr 2006 10:43:07 -0400
Received: from mail.codeweavers.com ([216.251.189.131]:38601 "EHLO
	mail.codeweavers.com") by vger.kernel.org with ESMTP
	id S1750791AbWDEOnG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Apr 2006 10:43:06 -0400
Received: from foghorn.codeweavers.com ([216.251.189.130] helo=[127.0.0.1])
	by mail.codeweavers.com with esmtp (Exim 4.50)
	id 1FR8z5-0000mE-NY
	for git@vger.kernel.org; Wed, 05 Apr 2006 09:27:55 -0500
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050923
X-Accept-Language: en, en-us, ko-kr
To: git@vger.kernel.org
X-SA-Exim-Connect-IP: 216.251.189.130
X-SA-Exim-Mail-From: mike@codeweavers.com
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on mail
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.3
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on mail.codeweavers.com)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18435>

This is a multi-part message in MIME format.
--------------020403070402060004070007
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

---

  imap-send.c |    7 ++++++-
  1 files changed, 6 insertions(+), 1 deletions(-)


--------------020403070402060004070007
Content-Type: text/x-patch;
 name="8f910a131c905720e9640ddecfd8f85927ddc660.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="8f910a131c905720e9640ddecfd8f85927ddc660.diff"

8f910a131c905720e9640ddecfd8f85927ddc660
diff --git a/imap-send.c b/imap-send.c
index d04259a..52e2400 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1333,6 +1333,12 @@ main(int argc, char **argv)
 		return 1;
 	}
 
+	total = count_messages( &all_msgs );
+	if (!total) {
+		fprintf(stderr,"no messages to send\n");
+		return 1;
+	}
+
 	/* write it to the imap server */
 	ctx = imap_open_store( &server );
 	if (!ctx) {
@@ -1340,7 +1346,6 @@ main(int argc, char **argv)
 		return 1;
 	}
 
-	total = count_messages( &all_msgs );
 	fprintf( stderr, "sending %d message%s\n", total, (total!=1)?"s":"" );
 	ctx->name = imap_folder;
 	while (1) {


--------------020403070402060004070007--
