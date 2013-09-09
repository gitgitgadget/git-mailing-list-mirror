From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 3/5] pull: add --merge option
Date: Sun,  8 Sep 2013 20:23:14 -0500
Message-ID: <1378689796-19305-4-git-send-email-felipe.contreras@gmail.com>
References: <1378689796-19305-1-git-send-email-felipe.contreras@gmail.com>
Cc: Andreas Krey <a.krey@gmx.de>, John Keeping <john@keeping.me.uk>,
	Jeff King <peff@peff.net>, Richard Hansen <rhansen@bbn.com>,
	Philip Oakley <philipoakley@iee.org>,
	sandals@crustytoothpaste.net,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 09 03:28:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIqHS-0001HK-La
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 03:28:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359Ab3IIB2i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 21:28:38 -0400
Received: from mail-oa0-f51.google.com ([209.85.219.51]:44580 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751210Ab3IIB2f (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 21:28:35 -0400
Received: by mail-oa0-f51.google.com with SMTP id h1so5874734oag.24
        for <git@vger.kernel.org>; Sun, 08 Sep 2013 18:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BxuqkjON86b7RwmLlue9/LOpcpWnw3GyzVih+CXtttM=;
        b=o1OOBmxd5TlHh2r9ayKThpSF5vfX2uZTJ4N9IQRjkQ3OY9UE3fH6r9qhQkdhQmXgmv
         vo9qrBpvj3W+WVlo4G2HliudBIbz4ffZTkRdlPxBoADYa5T3+170ykCZmGeHKPARC2VF
         KnQPMoS1emS3kcbR00fFTVj3WBaH8fYoT17eu+h35rHKhxBOKkbWWY1lt1sfmoq8j16H
         y+QYhieQ6tzhLeerRk4pfpmxYFfSIfGLNZSfiqzpU3snhK8KR3HNtsdU9QfP1qQN/Q6U
         JOSH2+WxVTIH/nVdoYVWFOAqi2D3Pz6wCW2M+OKArer5A3dq3gKelRFpwJxZfKXcC3aK
         zFQA==
X-Received: by 10.182.48.194 with SMTP id o2mr9633449obn.90.1378690114563;
        Sun, 08 Sep 2013 18:28:34 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id ru3sm10466009obc.2.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 08 Sep 2013 18:28:33 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-338-gefd7fa6
In-Reply-To: <1378689796-19305-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234298>

Also, deprecate --no-rebase since there's no need for it any more.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-pull.txt | 8 ++++++--
 git-pull.sh                | 6 +++++-
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 991352f..e09f004 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -119,8 +119,12 @@ It rewrites history, which does not bode well when you
 published that history already.  Do *not* use this option
 unless you have read linkgit:git-rebase[1] carefully.
 
---no-rebase::
-	Override earlier --rebase.
+-m::
+--merge::
+	Force a merge.
++
+See `pull.mode`, `branch.<name>.pullmode` in linkgit:git-config[1] if you want
+to make `git pull` always use `--merge`.
 
 Options related to fetching
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/git-pull.sh b/git-pull.sh
index f53d193..fbb8a9b 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -127,8 +127,12 @@ do
 	-r|--r|--re|--reb|--reba|--rebas|--rebase)
 		mode=rebase
 		;;
+	-m|--m|--me|--mer|--merg|--merge)
+		mode=merge
+		;;
 	--no-r|--no-re|--no-reb|--no-reba|--no-rebas|--no-rebase)
-		mode=
+		mode=merge
+		echo "--no-rebase is deprecated, please use --merge instead"
 		;;
 	--recurse-submodules)
 		recurse_submodules=--recurse-submodules
-- 
1.8.4-338-gefd7fa6
