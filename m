From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH] git-mergetool--lib.sh: make check_unchanged return 1 on invalid read
Date: Mon, 19 Sep 2011 16:03:12 -0400
Message-ID: <1316462592-27255-1-git-send-email-jaysoffian@gmail.com>
Cc: Jay Soffian <jaysoffian@gmail.com>,
	David Aguilar <davvid@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 19 22:03:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5k3x-0001LZ-2A
	for gcvg-git-2@lo.gmane.org; Mon, 19 Sep 2011 22:03:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756078Ab1ISUD2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Sep 2011 16:03:28 -0400
Received: from mail-gw0-f42.google.com ([74.125.83.42]:51447 "EHLO
	mail-gw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755050Ab1ISUD1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2011 16:03:27 -0400
Received: by gwb17 with SMTP id 17so7077807gwb.1
        for <git@vger.kernel.org>; Mon, 19 Sep 2011 13:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=D386KOn7AsjZvflDCLlIWBxYnjFZKOo86FR+4WbSZhE=;
        b=E0U0xceYttOU9uhS2PVtPlcduAjhI2mEKS7FMbCYDHXej8iCZTSIkQ4ac9Myx31e9W
         5hFFsRPCFR17GrtAKDUSBaK5ek9PhO8HaGR4UVHivcKX3fiABIRn6pZk1f+ZzNJ5EOaX
         ovSXYFNUwUUP1t9uH7kpPtH29h/T4+60DpwYA=
Received: by 10.52.28.148 with SMTP id b20mr2369942vdh.91.1316462607134;
        Mon, 19 Sep 2011 13:03:27 -0700 (PDT)
Received: from localhost (cpe-174-097-218-168.nc.res.rr.com. [174.97.218.168])
        by mx.google.com with ESMTPS id ha1sm603534vdb.17.2011.09.19.13.03.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 19 Sep 2011 13:03:26 -0700 (PDT)
X-Mailer: git-send-email 1.7.7.rc2.2.gf185
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181698>

Else when the user hits ctrl-c at the "Was the merge successful?
[y/n]" prompt, mergetool goes into an infinite loop asking
for input.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 git-mergetool--lib.sh |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 8fc65d0400..0eb424484c 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -21,7 +21,11 @@ check_unchanged () {
 		do
 			echo "$MERGED seems unchanged."
 			printf "Was the merge successful? [y/n] "
-			read answer
+			if ! read answer
+			then
+				status=1
+				break
+			fi
 			case "$answer" in
 			y*|Y*) status=0; break ;;
 			n*|N*) status=1; break ;;
-- 
1.7.7.rc2.2.gf185
