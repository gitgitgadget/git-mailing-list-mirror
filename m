From: Stefan Naewe <stefan.naewe@gmail.com>
Subject: [PATCH] fix git-parse-remote.sh for remotes that contain slashes
Date: Fri, 14 Jan 2011 12:36:40 +0100
Message-ID: <1295005000-11562-1-git-send-email-stefan.naewe@gmail.com>
References: <20110114090645.GA13060@pengutronix.de>
Cc: Stefan Naewe <stefan.naewe@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 14 12:36:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pdhxg-0008Hq-Kx
	for gcvg-git-2@lo.gmane.org; Fri, 14 Jan 2011 12:36:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751613Ab1ANLgv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jan 2011 06:36:51 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:50708 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751539Ab1ANLgt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jan 2011 06:36:49 -0500
Received: by fxm20 with SMTP id 20so2657778fxm.19
        for <git@vger.kernel.org>; Fri, 14 Jan 2011 03:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=PKRq8VuZBamV75T6RP2XY1RtUx3ttV70SV3auMeOpa4=;
        b=kNR/wKgcjJSP5G41UEyXOfzqjF7mx6999koPnD2DOVCeQmVprj9XUtqea1Azmw/DYj
         IGC/Hu55tNweedFg06ZFHbyABxheeu8PV79/lIi4fx8ryl4uLaaXU3BQnjEspuQltF3u
         YZob6lY6nAEgFzIhAcVc4TH0OvWAUxZLAlKJ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Sqwj9oE+22g6Fnb9pYuan7i5zW119lIyGHSSTuITgAZw+6FjCE8hDgA/PRg4Jy4GWX
         x0NxuBfg5cTJOifGXGrhoLdFjwiTLxbN69T/QCgisLq+NVifjEYMA0yoKOxIS7MyaKvV
         PPqqrlW/MB3E0X3zN8Uvzt87C5SzHMsiLkGzw=
Received: by 10.223.103.8 with SMTP id i8mr625540fao.47.1295005004514;
        Fri, 14 Jan 2011 03:36:44 -0800 (PST)
Received: from darkstar.home (dslc-082-083-230-174.pools.arcor-ip.net [82.83.230.174])
        by mx.google.com with ESMTPS id l14sm423489fan.9.2011.01.14.03.36.42
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 14 Jan 2011 03:36:43 -0800 (PST)
X-Mailer: git-send-email 1.7.3.5
In-Reply-To: <20110114090645.GA13060@pengutronix.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165094>

Signed-off-by: Stefan Naewe <stefan.naewe@gmail.com>
---
 git-parse-remote.sh |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index 5f47b18..7cf204e 100644
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -7,8 +7,12 @@ GIT_DIR=$(git rev-parse -q --git-dir) || :;
 get_data_source () {
 	case "$1" in
 	*/*)
-		echo ''
-		;;
+		if test "$(git config --get "remote.$1.url")"
+		then
+			echo config
+		else
+			echo ''
+		fi ;;
 	.)
 		echo self
 		;;
-- 
1.7.3.5
