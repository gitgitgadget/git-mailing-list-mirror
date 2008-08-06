From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [TopGit PATCH] tg.sh: Check for read permissions of help files
Date: Wed,  6 Aug 2008 10:02:51 +0200
Message-ID: <1218009771-30358-1-git-send-email-bert.wesarg@googlemail.com>
Cc: Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed Aug 06 10:04:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQe0O-000687-ME
	for gcvg-git-2@gmane.org; Wed, 06 Aug 2008 10:04:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755903AbYHFIDV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2008 04:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755955AbYHFIDV
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Aug 2008 04:03:21 -0400
Received: from mu-out-0910.google.com ([209.85.134.185]:49932 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755767AbYHFIDT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2008 04:03:19 -0400
Received: by mu-out-0910.google.com with SMTP id w8so4634033mue.1
        for <git@vger.kernel.org>; Wed, 06 Aug 2008 01:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=MUcaWLQf52WdG6T2eC7C8K6vVGV0peCbh7FKRN8a9EU=;
        b=mCQ+cEiudB70bEt2D1Ak0sLXu7lJKo5IvX5vM12trSkybBbK7h47meNReM8IDAt7/D
         kgauYxbI+vp8V0O1bBIDkMJSgnIQlBKJWTohHq5vqjgpkLs+1eTY/8YOpZgpap7U8YxL
         FRit86F9CKFTsXsdJFMEIWleOLI3Mg6laTXeE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=FPizpw4AyBxNHLJoaiJL4A331lvjH9qt1Ymgu0nGrwDVdFvGeIJT402HTdboUPL/Oz
         YgQLd5hyT+AXqVnkn0u7wR94GK9OHqUxWUeiA875mcGEr3nl810nNLjNBFNkM1PkMcd8
         SbVLEAV20bRgSZUsvMJH4Z9/UXFAEPH+g1Ekw=
Received: by 10.103.222.1 with SMTP id z1mr1242861muq.71.1218009775466;
        Wed, 06 Aug 2008 01:02:55 -0700 (PDT)
Received: from localhost ( [217.234.68.119])
        by mx.google.com with ESMTPS id w5sm30750126mue.11.2008.08.06.01.02.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 06 Aug 2008 01:02:54 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91491>

We currently check only for '-f' but we need to have read permissions as well.

And help files don't need the execution bit set.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

---
 Makefile |    2 +-
 tg.sh    |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 238d07d..f9dbe6e 100644
--- a/Makefile
+++ b/Makefile
@@ -35,7 +35,7 @@ install:: all
 	install -d -m 755 "$(hooksdir)"
 	install $(hooks_out) "$(hooksdir)"
 	install -d -m 755 "$(sharedir)"
-	install $(help_out) "$(sharedir)"
+	install -m 644 $(help_out) "$(sharedir)"
 
 clean::
 	rm -f tg $(commands_out) $(hooks_out) $(help_out)
diff --git a/tg.sh b/tg.sh
index 03a392b..edac006 100644
--- a/tg.sh
+++ b/tg.sh
@@ -154,7 +154,7 @@ do_help()
 	if [ -z "$1" ] ; then
 		echo "TopGit v0.1 - A different patch queue manager"
 		echo "Usage: tg (create|delete|info|patch|summary|update|help) ..."
-	elif [ -f "@sharedir@/tg-$1.txt" ] ; then
+	elif [ -f "@sharedir@/tg-$1.txt" -a -r "@sharedir@/tg-$1.txt" ] ; then
 		cat "@sharedir@/tg-$1.txt"
 	else
 		echo "`basename $0`: no help for $1" 1>&2
-- 
tg: (e311d15..) t/check-read-permissions-of-help-files (depends on: master)
