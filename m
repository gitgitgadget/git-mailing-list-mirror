From: "Michael J. Cohen" <michaeljosephcohen@mac.com>
Subject: [PATCH] Add support for Apple Mail's Maildir format to builtin-mailsplit.
Date: Mon, 5 Nov 2007 07:57:15 -0500
Message-ID: <B702E75B-6002-440E-91B5-0E52E16BCCF0@mac.com>
Mime-Version: 1.0 (Apple Message framework v912)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 05 13:57:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ip1WH-0008Il-JL
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 13:57:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754575AbXKEM5T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 07:57:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754184AbXKEM5T
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 07:57:19 -0500
Received: from smtpoutm.mac.com ([17.148.16.67]:52400 "EHLO smtpoutm.mac.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753889AbXKEM5S (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 07:57:18 -0500
Received: from mac.com (asmtp010-s [10.150.69.73])
	by smtpoutm.mac.com (Xserve/smtpout004/MantshX 4.0) with ESMTP id lA5CvIvJ010729
	for <git@vger.kernel.org>; Mon, 5 Nov 2007 04:57:18 -0800 (PST)
Received: from mac-pro.lan (c-71-196-112-35.hsd1.fl.comcast.net [71.196.112.35])
	(authenticated bits=0)
	by mac.com (Xserve/asmtp010/MantshX 4.0) with ESMTP id lA5CvFJj016713
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO)
	for <git@vger.kernel.org>; Mon, 5 Nov 2007 04:57:17 -0800 (PST)
X-Mailer: Apple Mail (2.912)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63509>

  Add support for Apple Mail's Maildir format to builtin-mailsplit.
  Currently, mailsplit only checks for the directory 'cur' inside of the
  specified directory, whereas Apple Mail's Maildirs have a Messages  
directory.

Signed-off-by: Michael Cohen <mjc@kernel.org>
---

Another patch will follow to allow builtin-mailinfo to parse Apple  
Mail's extra header and footers.

  builtin-mailsplit.c |    7 +++++--
  1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/builtin-mailsplit.c b/builtin-mailsplit.c
index 74b0470..6256351 100644
--- a/builtin-mailsplit.c
+++ b/builtin-mailsplit.c
@@ -129,8 +129,11 @@ static int split_maildir(const char *maildir,  
const char *dir,
  	struct path_list list = {NULL, 0, 0, 1};

  	snprintf(curdir, sizeof(curdir), "%s/cur", maildir);
-	if (populate_maildir_list(&list, curdir) < 0)
-		goto out;
+	if (populate_maildir_list(&list, curdir) < 0) {
+		snprintf(curdir, sizeof(curdir), "%s/Messages", maildir);
+		if (populate_maildir_list(&list, curdir) < 0)
+			goto out;
+	}

  	for (i = 0; i < list.nr; i++) {
  		FILE *f;
-- 
1.5.3.5.562.g45f4-dirty
