From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 21/48] remote-hg: add check_bookmark() test helper
Date: Fri, 24 May 2013 21:29:37 -0500
Message-ID: <1369449004-17981-22-git-send-email-felipe.contreras@gmail.com>
References: <1369449004-17981-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 25 04:32:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ug4Hs-00022Y-UZ
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 04:32:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755273Ab3EYCcs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 22:32:48 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:34588 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752309Ab3EYCcr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 22:32:47 -0400
Received: by mail-ob0-f169.google.com with SMTP id 16so5881237obc.0
        for <git@vger.kernel.org>; Fri, 24 May 2013 19:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=oAaRXEffFTlvXkeCGOBjUxQD5AEwvucY1Vu+Acf9790=;
        b=VNfWbAVE+NrdHtL1XHy04FOM8Yuj/htLgFzlowpQ2bjaYR53rVaQ2EDTsMjPyQO0DE
         6ADiokUYgN/AHWbUzoikfDjEZiwC5TMLgdxCtUipCy0SHiw/7rslR7aIGKNGpsgQCRoR
         jTaJ/3Gzt36S+Nk+TGRq20BlQ+1C+qpywjrj3yCfSRSFkwm/Y3cVpRT7YUcVCEv4DBls
         QjpV4b/pHUBvyN/5Te8yIFmwDFalBwgVVVROtrBDV4Xec6779ww3Ry/AI9SLsZfqjrFq
         vOB2tJ5yvqo2UpO4ZZuj0ZAs25CmJbJnVWklm7W5Zu6Dqete1gtE1852q0ImhYgcGtP+
         jLHg==
X-Received: by 10.182.87.134 with SMTP id ay6mr13724846obb.13.1369449166753;
        Fri, 24 May 2013 19:32:46 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id w7sm20053038obx.9.2013.05.24.19.32.45
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 24 May 2013 19:32:45 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369449004-17981-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225434>

And check in a more proper way.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/test-hg.sh | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpers/test-hg.sh
index 943371a..2f2050c 100755
--- a/contrib/remote-helpers/test-hg.sh
+++ b/contrib/remote-helpers/test-hg.sh
@@ -32,6 +32,12 @@ check_branch () {
 	test_cmp expected actual
 }
 
+check_bookmark () {
+	echo $3 > expected &&
+	hg -R $1 log -r "bookmark('$2')" --template '{desc}\n' > actual &&
+	test_cmp expected actual
+}
+
 setup () {
 	(
 	echo "[ui]"
@@ -108,7 +114,7 @@ test_expect_success 'update bookmark' '
 	git push --quiet
 	) &&
 
-	hg -R hgrepo bookmarks | egrep "devel[	 ]+3:"
+	check_bookmark hgrepo devel devel
 '
 
 # cleanup previous stuff
-- 
1.8.3.rc3.312.g47657de
