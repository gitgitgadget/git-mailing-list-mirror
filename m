From: Bryan Larsen <bryanlarsen@yahoo.com>
Subject: [PATCH 4/6] cogito: try harder to find gnu date
Date: Sun, 17 Jul 2005 22:51:14 -0400
Message-ID: <20050718025107.11198.93279.sendpatchset@bryan-larsens-ibook-g4.local>
References: <20050718025024.11198.10556.sendpatchset@bryan-larsens-ibook-g4.local>
Cc: Bryan Larsen <bryanlarsen@yahoo.com>, pasky@suse.cz,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 18 04:51:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DuLj4-0008HL-58
	for gcvg-git@gmane.org; Mon, 18 Jul 2005 04:51:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261499AbVGRCvR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Jul 2005 22:51:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261501AbVGRCvR
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jul 2005 22:51:17 -0400
Received: from smtp109.mail.sc5.yahoo.com ([66.163.170.7]:52621 "HELO
	smtp109.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261499AbVGRCvO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jul 2005 22:51:14 -0400
Received: (qmail 30019 invoked from network); 18 Jul 2005 02:51:13 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Received:From:To:Cc:Message-Id:In-Reply-To:References:Subject;
  b=C1ZKe7+Gq2nd1lq+eyWTBxOLvj7nErxEN5wYWbIDIegyUKhe1j7GdvHyuhYv5qXzhUpRxclgn35SjN+N8dyJ2QFHzFcsKQacIrcx6tfU7ze0UJYSIDm5yOtN/3LHx8j4gsCs0uNwbFd90j9LQi2h8nHotlDjFrzgfGhMPxrU09c=  ;
Received: from unknown (HELO bryan-larsens-ibook-g4.local) (bryanlarsen@70.26.43.137 with plain)
  by smtp109.mail.sc5.yahoo.com with SMTP; 18 Jul 2005 02:51:12 -0000
To: bryan.larsen@gmail.com
In-Reply-To: <20050718025024.11198.10556.sendpatchset@bryan-larsens-ibook-g4.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Look harder for gnu date, use if available.

Signed-off-by: Bryan Larsen <bryan.larsen@gmail.com>
---

 cg-Xlib |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/cg-Xlib b/cg-Xlib
--- a/cg-Xlib
+++ b/cg-Xlib
@@ -70,7 +70,7 @@ showdate () {
 	secs=$(($secs + $tzhours * 3600 + $tzmins * 60))
 	[ "$format" ] || format="+%a, %d %b %Y %H:%M:%S $2"
 	if [ "$has_gnudate" ]; then
-		LANG=C date -ud "1970-01-01 UTC + $secs sec" "$format"
+		LANG=C ${has_gnudate} -ud "1970-01-01 UTC + $secs sec" "$format"
 	else
 		LANG=C date -u -r $secs "$format"
 	fi
@@ -241,4 +241,12 @@ for stat in "$(which gnustat)" "$(which 
     fi
 done
 
-has_gnudate=$(date -Rud "1970-01-01 UTC" 2>/dev/null)
+has_gnudate=
+for date in "$(which gnudate)" "$(which gdate)" "$(which date)" ; do
+    if ( [ $date ] && $date -Rud  "1970-01-01 UTC" 2> /dev/null >&2 ) ; then
+	has_gnudate=$date
+	break
+    fi
+done
+
+
