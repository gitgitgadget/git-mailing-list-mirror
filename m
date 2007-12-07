From: Len Brown <lenb@kernel.org>
Subject: Re: git-am: catch missing author date early.
Date: Thu, 6 Dec 2007 21:34:47 -0500
Organization: Intel Open Source Technology Center
Message-ID: <200712062134.47330.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 07 03:35:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0T3y-0005Qt-Db
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 03:35:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752953AbXLGCfH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 21:35:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752998AbXLGCfH
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 21:35:07 -0500
Received: from hera.kernel.org ([140.211.167.34]:58130 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752953AbXLGCfF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2007 21:35:05 -0500
Received: from d975xbx2 (c-65-96-213-102.hsd1.ma.comcast.net [65.96.213.102])
	(authenticated bits=0)
	by hera.kernel.org (8.13.8/8.13.8) with ESMTP id lB72Yqr7032310
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Fri, 7 Dec 2007 02:34:54 GMT
User-Agent: KMail/1.9.5
Content-Disposition: inline
X-Virus-Scanned: ClamAV 0.88.7/5023/Thu Dec  6 19:37:18 2007 on hera.kernel.org
X-Virus-Status: Clean
X-Spam-Status: No, score=-1.9 required=5.0 tests=AWL,BAYES_00,RCVD_IN_PBL,
	RCVD_IN_SORBS_DUL,RDNS_DYNAMIC autolearn=no version=3.2.3
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on hera.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67367>

This change made git-am more difficult to use.

I tend to check-in a fair number of patches that didn't come from an e-mail message.
In the past, I slap a Subject: and a From: on the top of the commit message
and off I go.

With this change git-am fails b/c I haven't also conjured up the time,
when in the past it figured out what time it was for me.

thanks,
-Len

commit 6e9e0327b7d7f384d8a223b4bc40330ef3e7fb61
Author: Junio C Hamano <gitster@pobox.com>
Date:   Sun Dec 2 14:38:40 2007 -0800

    git-am: catch missing author date early.
    
    Even though commit-tree would default to the current time if the incoming
    e-mail message somehow did not record the timestamp, it is safer to catch
    the breakage sooner.
    
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

diff --git a/git-am.sh b/git-am.sh
index 76c1c84..2e40708 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -307,9 +307,9 @@ do
 	GIT_AUTHOR_EMAIL="$(sed -n '/^Email/ s/Email: //p' "$dotest/info")"
 	GIT_AUTHOR_DATE="$(sed -n '/^Date/ s/Date: //p' "$dotest/info")"
 
-	if test -z "$GIT_AUTHOR_EMAIL"
+	if test -z "$GIT_AUTHOR_EMAIL" || test -z "$GIT_AUTHOR_DATE"
 	then
-		echo "Patch does not have a valid e-mail address."
+		echo "Patch does not have valid authorship information."
 		stop_here $this
 	fi
 
