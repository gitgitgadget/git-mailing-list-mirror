From: David Aguilar <davvid@gmail.com>
Subject: [PATCH] gitk: do not show local changes for bare repositories
Date: Thu,  6 Mar 2008 04:39:24 -0800
Message-ID: <64b42ab91804e670057c807fd8265fc07106792c.1204806475.git.davvid@gmail.com>
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Thu Mar 06 13:30:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXFEa-0001eM-7v
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 13:30:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932608AbYCFM3Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2008 07:29:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765703AbYCFM3Z
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 07:29:25 -0500
Received: from rn-out-0910.google.com ([64.233.170.189]:19471 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759549AbYCFM3X (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 07:29:23 -0500
Received: by rn-out-0910.google.com with SMTP id v46so940074rnb.15
        for <git@vger.kernel.org>; Thu, 06 Mar 2008 04:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer;
        bh=lrS/DUYLwMeKK/3EbJyZrhyl93eqc86VLPP08ZJ5sfM=;
        b=kQkqPZAtaO37OTs6mlX7qMQ/BySuf68+95Sul+yVaQ8psNypE0jdIo4KhalUN+oGVvW5HIgxCGnRsF8t4aKadbhqKXhU6uYqgC8hNud71lUnBjRmK2RPcH7/y7MCxPUUlNhR11nSdL7qND7NNeHdSMy5ikioLxqq8W6S0K4lXp8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=a97s0njhuzbcuFmqv2sBy4Oa5cNmblYcmCl1BuYsoNlj/kIi2jTwWwwBVfv9j+EEv5wEP/sUUCyae3uQxrCuzRYOI44ZUkh3ZSjcvMT6tiNh+qvgwBajXIea5ELvQHTr+9HTYssSSm194tUSbXmZ4Mn91WYKLX7nnnymep3Tt1s=
Received: by 10.114.89.1 with SMTP id m1mr6754753wab.77.1204806560076;
        Thu, 06 Mar 2008 04:29:20 -0800 (PST)
Received: from localhost ( [208.106.56.2])
        by mx.google.com with ESMTPS id y11sm4320813pod.9.2008.03.06.04.29.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 06 Mar 2008 04:29:18 -0800 (PST)
X-Mailer: git-send-email 1.5.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76387>

Launching gitk on a bare repository would previously show the
work tree as having removed all files.  We now test for bare
repositories before showing local changes.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 gitk |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/gitk b/gitk
index f1f21e9..cc4cde3 100755
--- a/gitk
+++ b/gitk
@@ -2843,9 +2843,9 @@ proc dohidelocalchanges {} {
 
 # spawn off a process to do git diff-index --cached HEAD
 proc dodiffindex {} {
-    global localirow localfrow lserial showlocalchanges
+    global localirow localfrow lserial showlocalchanges isbare
 
-    if {!$showlocalchanges} return
+    if {!$showlocalchanges || $isbare} return
     incr lserial
     set localfrow -1
     set localirow -1
@@ -8643,6 +8643,7 @@ set patchnum 0
 set localirow -1
 set localfrow -1
 set lserial 0
+set isbare [expr {[exec git rev-parse --is-bare-repository] == "true"}]
 setcoords
 makewindow
 # wait for the window to become visible
-- 
1.5.4.rc2.1105.gfc5f2

