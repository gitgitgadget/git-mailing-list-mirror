From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 2/6] t5550-http-fetch: Use subshell for repository operations
Date: Thu, 15 Apr 2010 12:09:16 -0700
Message-ID: <1271358560-8946-3-git-send-email-spearce@spearce.org>
References: <20100415141504.GB17883@spearce.org>
Cc: git@vger.kernel.org, Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Christian Halstrick <christian.halstrick@gmail.com>,
	jan.sievers@sap.com, Matthias Sohn <matthias.sohn@sap.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 15 21:09:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2URf-0004rK-3W
	for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 21:09:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755981Ab0DOTJi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Apr 2010 15:09:38 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:13557 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755843Ab0DOTJh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Apr 2010 15:09:37 -0400
Received: by fg-out-1718.google.com with SMTP id 22so764855fge.1
        for <git@vger.kernel.org>; Thu, 15 Apr 2010 12:09:35 -0700 (PDT)
Received: by 10.86.6.39 with SMTP id 39mr646080fgf.4.1271358574411;
        Thu, 15 Apr 2010 12:09:34 -0700 (PDT)
Received: from localhost (yellowpostit.mtv.corp.google.com [172.18.104.34])
        by mx.google.com with ESMTPS id 3sm1719793fge.25.2010.04.15.12.09.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 15 Apr 2010 12:09:33 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.rc1.269.ga27c7
In-Reply-To: <20100415141504.GB17883@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145005>

Change into the server repository's directory using a subshell,
so we can return back to the top of the trash directory before
doing anything more in the test script.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 t/t5550-http-fetch.sh |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/t/t5550-http-fetch.sh b/t/t5550-http-fetch.sh
index 8cfce96..78c31c9 100755
--- a/t/t5550-http-fetch.sh
+++ b/t/t5550-http-fetch.sh
@@ -55,9 +55,10 @@ test_expect_success 'http remote detects correct HEAD' '
 
 test_expect_success 'fetch packed objects' '
 	cp -R "$HTTPD_DOCUMENT_ROOT_PATH"/repo.git "$HTTPD_DOCUMENT_ROOT_PATH"/repo_pack.git &&
-	cd "$HTTPD_DOCUMENT_ROOT_PATH"/repo_pack.git &&
-	git --bare repack &&
-	git --bare prune-packed &&
+	(cd "$HTTPD_DOCUMENT_ROOT_PATH"/repo_pack.git &&
+	 git --bare repack &&
+	 git --bare prune-packed
+	) &&
 	git clone $HTTPD_URL/dumb/repo_pack.git
 '
 
-- 
1.7.1.rc1.269.ga27c7
