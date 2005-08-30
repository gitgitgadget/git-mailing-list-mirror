From: Martin Langhoff <martin@catalyst.net.nz>
Subject: [PATCH] cg-update - refuse to update dirty tree
Date: Tue, 30 Aug 2005 21:37:28 +1200
Message-ID: <11253946482734-git-send-email-martin@catalyst.net.nz>
Reply-To: Martin Langhoff <martin@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Tue Aug 30 11:39:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EA2Yt-0002nB-D4
	for gcvg-git@gmane.org; Tue, 30 Aug 2005 11:37:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751339AbVH3Jhe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Aug 2005 05:37:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751345AbVH3Jhe
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Aug 2005 05:37:34 -0400
Received: from leibniz.catalyst.net.nz ([202.78.240.7]:4743 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1751339AbVH3Jhd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Aug 2005 05:37:33 -0400
Received: from aporo-debian (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (Postfix) with SMTP id 27D168AAC3;
	Tue, 30 Aug 2005 21:37:28 +1200 (NZST)
In-Reply-To: 
X-Mailer: git-send-email-script
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7951>

cg-merge currently clobbers local changes while runnign cg-update. Do the
safe thing and refuse to update on a dirty tree.

Signed-off-by: Martin Langhoff <martin@catalyst.net.nz>


---

 cg-update |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

7a961c02ee6228c2a80869b4b3f179a7e279df8e
diff --git a/cg-update b/cg-update
--- a/cg-update
+++ b/cg-update
@@ -27,6 +27,10 @@ while optparse; do
 	fi
 done
 
+# Better safe than sorry
+(git-update-cache --refresh >> /dev/null) ||
+        die "Your working tree is dirty - will not update."
+
 name=${ARGS[0]}
 [ "$name" ] || { [ -s $_git/refs/heads/origin ] && name=origin; }
 [ "$name" ] || die "where to update from?"
