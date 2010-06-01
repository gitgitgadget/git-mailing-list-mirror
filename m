From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/3] Set cmdline globally, not in stop_here_user_resolve
Date: Tue,  1 Jun 2010 11:20:20 +0200
Message-ID: <1275384022-12131-2-git-send-email-artagnon@gmail.com>
References: <1275384022-12131-1-git-send-email-artagnon@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 01 11:19:24 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJNd1-0001cL-5O
	for gcvg-git-2@lo.gmane.org; Tue, 01 Jun 2010 11:19:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753613Ab0FAJTM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jun 2010 05:19:12 -0400
Received: from mail-ew0-f216.google.com ([209.85.219.216]:41754 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753471Ab0FAJTK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jun 2010 05:19:10 -0400
Received: by ewy8 with SMTP id 8so1155134ewy.28
        for <git@vger.kernel.org>; Tue, 01 Jun 2010 02:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=kE23VmRsBzt/ApJ3BEMTJysR4+3a3Xg8OrRTy3d+0Co=;
        b=eM/HJ9NSaMQWjLVtJG5cLO3JHHzsNzjeoAAEBnPG9Cyfew/zkrkv7O87Z1jF8vV2Vo
         yqG7dSvXObSgsxipHfINzQ/A233LjMNkngBGY/kYm1AQsHghHGcPo5yOiSeL1+MgXgzK
         +IcaRcLWbR1yTAMKcaeIep2Tl2ElUoMmach5E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=qvi9dR5hUGH1bE9iyzLdZHiG1icJSKrvGyvI/iq6SwAUN60ahj6HyFyRv07Bsx+Cbt
         msqERe1hw2xa6lhKxIPHfjqf8rJ8bNtAUkKQcdfnjeJs03lJ9DZ41dl0ADs7ImxF1Lt6
         Dn1lq2mSrWoPvjZlTflqm7Y5ZsLWRnuXhaHy0=
Received: by 10.213.7.135 with SMTP id d7mr3176785ebd.52.1275383949157;
        Tue, 01 Jun 2010 02:19:09 -0700 (PDT)
Received: from localhost (nat-wireless.itu.dk [130.226.142.243])
        by mx.google.com with ESMTPS id 15sm3613358ewy.0.2010.06.01.02.19.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 01 Jun 2010 02:19:08 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1275384022-12131-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148096>

Set the $cmdline variable globally, so it can be used in other code
fragments as well. Also, instead of hardcoding the string "git am",
use the command line argument "$0".

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 git-am.sh |   19 ++++++++++---------
 1 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 87ffae2..b779277 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -52,6 +52,16 @@ else
 	HAS_HEAD=
 fi
 
+cmdline="$0"
+if test '' != "$interactive"
+then
+    cmdline="$cmdline -i"
+fi
+if test '' != "$threeway"
+then
+    cmdline="$cmdline -3"
+fi
+
 sq () {
 	git rev-parse --sq-quote "$@"
 }
@@ -66,15 +76,6 @@ stop_here_user_resolve () {
 	    printf '%s\n' "$resolvemsg"
 	    stop_here $1
     fi
-    cmdline="git am"
-    if test '' != "$interactive"
-    then
-        cmdline="$cmdline -i"
-    fi
-    if test '' != "$threeway"
-    then
-        cmdline="$cmdline -3"
-    fi
     echo "When you have resolved this problem run \"$cmdline --resolved\"."
     echo "If you would prefer to skip this patch, instead run \"$cmdline --skip\"."
     echo "To restore the original branch and stop patching run \"$cmdline --abort\"."
-- 
1.7.1
