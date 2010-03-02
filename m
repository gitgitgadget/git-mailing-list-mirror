From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v2 1/7] t5541-http-push: check that ref is unchanged for non-ff test
Date: Tue,  2 Mar 2010 18:49:25 +0800
Message-ID: <1267526971-5552-2-git-send-email-rctay89@gmail.com>
References: <1267526971-5552-1-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Clemens Buchacher" <drizzd@aon.at>,
	"Mike Hommey" <mh@glandium.org>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 02 11:50:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmPg5-0003k4-EH
	for gcvg-git-2@lo.gmane.org; Tue, 02 Mar 2010 11:50:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752600Ab0CBKtv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Mar 2010 05:49:51 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:55210 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752456Ab0CBKtt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Mar 2010 05:49:49 -0500
Received: by gyh20 with SMTP id 20so34198gyh.19
        for <git@vger.kernel.org>; Tue, 02 Mar 2010 02:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=j4SdSVtXyHC/Ay8S9ykWUVSi5h0pFa8WCbKVhJj88Q0=;
        b=mAZhZPnFY9Kjw8Llm/Vhe3WP53d4ppq3UsbsWHu4OXX8NMi+VJpRfWQ/8CvHeQTKDY
         gSrMAU2OOJgYZ1tJtXDW9Fe41t03qpWAgq4zglMfSH8o35rmR5SuNmC3bGbwlZzlYyhe
         LXO1iEhycdqoZQsi+9wcJy2kgBMRQEnEsmOAg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=lAJCURCPMx8+mAVNQHCy2nbFJ39+PU/HOpwRpnOrkLD6Vqav13pk5QLI6lSpSiMoXX
         6AZg2BytBeV5Kk0rnq3uZNxsHtzduUn0bhnAXWxw8CH2auMAvGPR9LT3VkbJRzEo+qiA
         xTRyLgUrA3BjqZiZVM8QESM/LTnAnMmw5T4mA=
Received: by 10.100.236.5 with SMTP id j5mr351498anh.60.1267526987623;
        Tue, 02 Mar 2010 02:49:47 -0800 (PST)
Received: from localhost.localdomain (cm212.zeta152.maxonline.com.sg [116.87.152.212])
        by mx.google.com with ESMTPS id 13sm2393991gxk.12.2010.03.02.02.49.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 02 Mar 2010 02:49:47 -0800 (PST)
X-Mailer: git-send-email 1.7.0.1.241.g6604f
In-Reply-To: <1267526971-5552-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141384>

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 t/t5541-http-push.sh |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t5541-http-push.sh b/t/t5541-http-push.sh
index 53f54a2..ff947f3 100755
--- a/t/t5541-http-push.sh
+++ b/t/t5541-http-push.sh
@@ -89,15 +89,17 @@ test_expect_success 'used receive-pack service' '
 '
 
 test_expect_success 'non-fast-forward push fails' '
+	cd "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git &&
+	HEAD=$(git rev-parse --verify HEAD) &&
+
 	cd "$ROOT_PATH"/test_repo_clone &&
 	git checkout master &&
 	echo "changed" > path2 &&
 	git commit -a -m path2 --amend &&
 
-	HEAD=$(git rev-parse --verify HEAD) &&
 	!(git push -v origin >output 2>&1) &&
 	(cd "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git &&
-	 test $HEAD != $(git rev-parse --verify HEAD))
+	 test $HEAD = $(git rev-parse --verify HEAD))
 '
 
 test_expect_success 'non-fast-forward push show ref status' '
-- 
1.7.0.26.gbfa16
