From: Uwe Zeisberger <Uwe_Zeisberger@digi.com>
Subject: [PATCH] Make GIT-VERSION-GEN tolerate missing git describe command again
Date: Thu, 26 Jan 2006 17:39:27 +0100
Message-ID: <1138293567831-git-send-email-Uwe_Zeisberger@digi.com>
References: <20060126134521.GA11570@informatik.uni-freiburg.de>
Reply-To: Uwe Zeisberger <Uwe_Zeisberger@digi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>
X-From: git-owner@vger.kernel.org Thu Jan 26 17:39:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F2A9M-0005Og-ON
	for gcvg-git@gmane.org; Thu, 26 Jan 2006 17:39:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964798AbWAZQjG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jan 2006 11:39:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964797AbWAZQjF
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jan 2006 11:39:05 -0500
Received: from www.z-kom.de ([212.101.151.131]:48023 "EHLO www.levante.de")
	by vger.kernel.org with ESMTP id S964798AbWAZQjE convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jan 2006 11:39:04 -0500
Received: from pd95b6420.dip0.t-ipconnect.de ([217.91.100.32] helo=mail.fsforth.de)
	by www.levante.de with asmtp (Exim 3.36 #1 (Debian))
	id 1F2A9B-0000FB-00; Thu, 26 Jan 2006 17:38:57 +0100
Received: from io.fsforth.de ([192.168.40.169])
	by mail.fsforth.de with esmtp (Exim 4.52)
	id 1F2A96-00038X-Vx; Thu, 26 Jan 2006 17:38:53 +0100
Received: from io.fsforth.de (localhost [127.0.0.1])
	by io.fsforth.de (Postfix) with SMTP id 343C7358E;
	Thu, 26 Jan 2006 17:39:27 +0100 (CET)
In-Reply-To: <20060126134521.GA11570@informatik.uni-freiburg.de>
X-Mailer: git-send-email
To: git@vger.kernel.org
X-FS-MailScanner: Found to be clean
X-MailScanner-From: uwe_zeisberger@digi.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15169>

Commit 5c7d3c95 broke that by making the git-describe command part of
a pipe.

Signed-off-by: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>

---

 GIT-VERSION-GEN |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

b5763601050151e944cb58b3b0fe6f4aee88b47f
diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index e3cd9fa..72201be 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -5,9 +5,11 @@ DEF_VER=v1.1.GIT
 
 # First try git-describe, then see if there is a version file
 # (included in release tarballs), then default
-VN=$(git-describe --abbrev=4 HEAD 2>/dev/null | sed -e 's/-/./g') ||
-VN=$(cat version) ||
-VN="$DEF_VER"
+if VN=$(git-describe --abbrev=4 HEAD 2>/dev/null); then
+	VN=$(echo "$VN" | sed -e 's/-/./g');
+else
+	VN=$(cat version) || VN="$DEF_VER"
+fi
 
 VN=$(expr "$VN" : v*'\(.*\)')
 
-- 
1.1.4-g9acfd
