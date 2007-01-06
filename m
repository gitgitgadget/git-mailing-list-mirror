From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: [PATCH] git-reset --hard: use quotes when we tell the user what HEAD was reset to
Date: Sat, 06 Jan 2007 11:23:22 +0100
Message-ID: <20070106102322.7468.57615.stgit@c165>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 06 11:32:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H38qz-000546-Ui
	for gcvg-git@gmane.org; Sat, 06 Jan 2007 11:32:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337AbXAFKcg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 Jan 2007 05:32:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751339AbXAFKcg
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jan 2007 05:32:36 -0500
Received: from mxfep04.bredband.com ([195.54.107.79]:44587 "EHLO
	mxfep04.bredband.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751337AbXAFKcf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jan 2007 05:32:35 -0500
X-Greylist: delayed 551 seconds by postgrey-1.27 at vger.kernel.org; Sat, 06 Jan 2007 05:32:35 EST
Received: from ironport2.bredband.com ([195.54.107.84] [195.54.107.84])
          by mxfep03.bredband.com with ESMTP
          id <20070106102322.UAQ2708.mxfep03.bredband.com@ironport2.bredband.com>
          for <git@vger.kernel.org>; Sat, 6 Jan 2007 11:23:22 +0100
Received: from c-eb66e455.09-360-6c6b701.cust.bredbandsbolaget.se (HELO c165) ([85.228.102.235])
  by ironport2.bredband.com with ESMTP; 06 Jan 2007 11:23:22 +0100
Received: from c165 ([127.0.0.1])
	by c165 with esmtp (Exim 3.36 #1 (Debian))
	id 1H38hu-0001wZ-00; Sat, 06 Jan 2007 11:23:22 +0100
To: junkio@cox.net
User-Agent: StGIT/0.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36085>


Idea and motivating example from Andy Whitcroft:

    apw@pinky$ git checkout -b bar master
    apw@pinky$ git reset --hard ac9c1108d8915f0937795e354ad72c4ae6890a3f
    HEAD is now at ac9c110... git-fetch: remove .keep file at the end.

    Huh, fetch?  Remove what .keep file?  Did I do a fetch?  What?
    
    I think we need to delimit the name better, probabally we need to quote
    it.  Perhaps something like:

    HEAD is now at ac9c110: "git-fetch: remove .keep file at the end".

Signed-off-by: Fredrik Kuivinen <frekui@gmail.com>

---

 git-reset.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-reset.sh b/git-reset.sh
index a969370..9b49883 100755
--- a/git-reset.sh
+++ b/git-reset.sh
@@ -90,7 +90,8 @@ case "$reset_type" in
 	test $update_ref_status = 0 && {
 		echo -n "HEAD is now at "
 		GIT_PAGER= git log --max-count=1 --pretty=oneline \
-			--abbrev-commit HEAD
+			--abbrev-commit HEAD |
+		    sed 's/\([0-9a-f.]*\) \(.*\)/\1: "\2"/'
 	}
 	;;
 --soft )
