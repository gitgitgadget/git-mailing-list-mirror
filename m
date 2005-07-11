From: Bryan Larsen <bryanlarsen@yahoo.com>
Subject: [PATCH 2/6] config-sh: find and verify utils
Date: Mon, 11 Jul 2005 06:14:49 -0400
Message-ID: <20050711101443.10318.71126.sendpatchset@bryan-larsens-ibook-g4.local>
References: <20050711101417.10318.64006.sendpatchset@bryan-larsens-ibook-g4.local>
Cc: junkio@cox.net, torvalds@osdl.org,
	Bryan Larsen <bryanlarsen@yahoo.com>, pasky@suse.cz,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 11 12:15:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DrvJX-000053-44
	for gcvg-git@gmane.org; Mon, 11 Jul 2005 12:15:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261583AbVGKKOz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jul 2005 06:14:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261586AbVGKKOz
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jul 2005 06:14:55 -0400
Received: from smtp109.mail.sc5.yahoo.com ([66.163.170.7]:46447 "HELO
	smtp109.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261583AbVGKKOt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2005 06:14:49 -0400
Received: (qmail 24467 invoked from network); 11 Jul 2005 10:14:48 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Received:From:To:Cc:Message-Id:In-Reply-To:References:Subject;
  b=YzbUS45I5FOIq9eG0+bVg9PX6nPAFqz4Tf5i0gBs3YAGcuWZyON5VVGUKkqrfRhgPr4YiF3hXQ4G2GOhoo/TDxYcZNkQCxPM0wK2+IPah5SqG2Vo3nuv6kj9WWPjTjBWp40oWNKfuBTB5kofZnu1XWFiAKR5lckTBQQtGqx1/14=  ;
Received: from unknown (HELO bryan-larsens-ibook-g4.local) (bryanlarsen@70.26.43.137 with plain)
  by smtp109.mail.sc5.yahoo.com with SMTP; 11 Jul 2005 10:14:48 -0000
To: bryan.larsen@gmail.com
In-Reply-To: <20050711101417.10318.64006.sendpatchset@bryan-larsens-ibook-g4.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Add config.sh which searches for gnu versions of 'cp' 'stat' 'date' and 'xargs'.

Signed-off-by: Bryan Larsen <bryan.larsen@gmail.com>
---

 config.sh |   65 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 65 insertions(+), 0 deletions(-)

diff --git a/config.sh b/config.sh
new file mode 100755
--- /dev/null
+++ b/config.sh
@@ -0,0 +1,65 @@
+#!/bin/sh
+#
+# Search for gnu utils.
+# Copyright (c) Bryan Larsen, 2005
+#
+# cogito and git-*-script rely on gnu versions of
+# cp, date, xargs and stat.  Look for them and
+# ensure they're gnu.
+#
+
+set -e
+
+if which gdate > /dev/null ; then 
+    DATE=gdate ;
+else 
+    DATE=date ; 
+fi ;
+
+# you don't actually have to have gnu date, it just works better.
+
+if which gcp > /dev/null ; then 
+    CP=gcp ; 
+else 
+    CP=cp ; 
+fi ;
+
+if $CP -a config.sh cp-test-dummy ; then 
+    rm cp-test-dummy ;
+else 
+    echo 'You must have gnu cp installed'; 
+    exit 1; 
+fi ;
+
+if which gnuxargs > /dev/null ; then 
+    XARGS=gnuxargs ; 
+else 
+    XARGS=xargs ; 
+fi ;
+
+if ! ( echo | $XARGS -r ) ; then 
+    echo 'You must have gnu xargs installed'; 
+    exit 1; 
+fi ;
+
+if which gstat > /dev/null ; then
+    STAT=gstat ;
+else
+    STAT=stat ;
+fi ;
+
+if ! ($STAT -c '%s' config.sh > /dev/null ) ; then
+    if which awk > /dev/null ; then
+	STAT=dont_have_stat ;
+    else
+	echo 'You must have awk or gnu stat installed.';
+	exit 1;
+    fi
+fi ;
+
+echo CP=$CP > config
+echo XARGS=$XARGS >> config
+echo DATE=$DATE >> config
+echo STAT=$STAT >> config
+
+set +e
