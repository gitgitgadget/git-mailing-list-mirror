From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH v3 02/11] t5550-http-fetch: Use subshell for repository operations
Date: Sat, 17 Apr 2010 13:07:35 -0700
Message-ID: <1271534864-31944-2-git-send-email-spearce@spearce.org>
References: <20100416100307.0000423f@unknown>
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Christian Halstrick <christian.halstrick@gmail.com>,
	jan.sievers@sap.com, Matthias Sohn <matthias.sohn@sap.com>
To: Junio C Hamano <gitster@pobox.com>,
	Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 17 22:08:42 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3EJm-0005p7-72
	for gcvg-git-2@lo.gmane.org; Sat, 17 Apr 2010 22:08:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754774Ab0DQUIH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Apr 2010 16:08:07 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:43145 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754215Ab0DQUHv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Apr 2010 16:07:51 -0400
Received: by gwaa18 with SMTP id a18so1946168gwa.19
        for <git@vger.kernel.org>; Sat, 17 Apr 2010 13:07:49 -0700 (PDT)
Received: by 10.101.176.6 with SMTP id d6mr8469674anp.155.1271534869049;
        Sat, 17 Apr 2010 13:07:49 -0700 (PDT)
Received: from localhost (yellowpostit.mtv.corp.google.com [172.18.104.34])
        by mx.google.com with ESMTPS id y2sm26262415ani.14.2010.04.17.13.07.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 17 Apr 2010 13:07:48 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.rc1.269.ga27c7
In-Reply-To: <20100416100307.0000423f@unknown>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145182>

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
