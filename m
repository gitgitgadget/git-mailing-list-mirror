From: Bryan Larsen <bryanlarsen@yahoo.com>
Subject: [PATCH 4/5] cogito: try harder to find gnu date
Date: Sat, 16 Jul 2005 19:24:02 -0400
Message-ID: <20050716232353.7317.63574.sendpatchset@bryan-larsens-ibook-g4.local>
References: <20050716232308.7317.56890.sendpatchset@bryan-larsens-ibook-g4.local>
Cc: Bryan Larsen <bryanlarsen@yahoo.com>, pasky@suse.cz,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 17 01:24:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dtw1W-0007ZW-Bv
	for gcvg-git@gmane.org; Sun, 17 Jul 2005 01:24:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261882AbVGPXYW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Jul 2005 19:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261891AbVGPXYS
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jul 2005 19:24:18 -0400
Received: from smtp103.mail.sc5.yahoo.com ([66.163.169.222]:34666 "HELO
	smtp103.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261883AbVGPXYC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jul 2005 19:24:02 -0400
Received: (qmail 10044 invoked from network); 16 Jul 2005 23:23:58 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Received:From:To:Cc:Message-Id:In-Reply-To:References:Subject;
  b=iCkno31y68s8At0E8e7KtfBzlvw9JPhzQ0IpRIw8gBQIBj3xx1NAcRYAhzyZbaJXm0UBdjQaL+HuTN0mjEo095PeLL3jHrQ8XMYliNkZ6Zp993wRtLZjTY7j8qJ5IQnXTtCXT19zNJxMB8Oaz+XJdGRg9mNZqXl19emvfIL/5Ac=  ;
Received: from unknown (HELO bryan-larsens-ibook-g4.local) (bryanlarsen@65.93.75.85 with plain)
  by smtp103.mail.sc5.yahoo.com with SMTP; 16 Jul 2005 23:23:58 -0000
To: bryan.larsen@gmail.com
In-Reply-To: <20050716232308.7317.56890.sendpatchset@bryan-larsens-ibook-g4.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Look harder for gnu date, use if available.

Signed-off-by: Bryan Larsen <bryan.larsen@gmail.com>
---

 cg-Xlib |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

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
@@ -236,4 +236,8 @@ has_stat=$(which gnustat 2> /dev/null ||
     which gstat 2> /dev/null ||
     which stat 2>/dev/null)
 [ "$has_stat" ] && $has_stat -c %s / 2>/dev/null >&2 || has_stat=
-has_gnudate=$(date -Rud "1970-01-01 UTC" 2>/dev/null)
+has_gnudate=$(which gnudate 2> /dev/null || 
+    which gdate 2> /dev/null || 
+    which stat 2>/dev/null)
+[ "$has_gnudate" ] && 
+    $has_gnudate -Rud  "1970-01-01 UTC" 2> /dev/null >&2 || has_gnudate=
