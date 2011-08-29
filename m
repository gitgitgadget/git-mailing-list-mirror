From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] t6030: use $SHELL_PATH to invoke user's preferred shell instead of bare sh
Date: Mon, 29 Aug 2011 13:09:25 -0700
Message-ID: <Sn_8tnPB8FBe4C5QxoGkIRcdzJ2sLq_-h0oZ37fkrq42HJgWSlGgty_hMznS2ckiKKOg66yY7R2mRQqhJAzedr762dMKb_s6ELjELyGXyU-tkJzir-FnxhCkAIb3q1028d5FrBBy6EW3SXEPBMTYTw@cipher.nrlssc.navy.mil>
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Aug 29 22:10:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qy89t-00057F-3A
	for gcvg-git-2@lo.gmane.org; Mon, 29 Aug 2011 22:10:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754953Ab1H2UKI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Aug 2011 16:10:08 -0400
Received: from mail4.nrlssc.navy.mil ([128.160.11.9]:57146 "EHLO
	mail3.nrlssc.navy.mil" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754885Ab1H2UKH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Aug 2011 16:10:07 -0400
Received: by mail3.nrlssc.navy.mil id p7TK9u5v010151; Mon, 29 Aug 2011 15:09:56 -0500
X-OriginalArrivalTime: 29 Aug 2011 20:09:55.0262 (UTC) FILETIME=[9E7EA5E0:01CC6687]
X-Virus-Scanned: clamav-milter 0.97.2 at mail4
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180338>

From: Brandon Casey <drafnel@gmail.com>

Some platforms (IRIX, Solaris) provide an ancient /bin/sh which chokes on
modern shell syntax like $().  SHELL_PATH is provided to allow the user to
specify a working sh, let's use it here.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 t/t6030-bisect-porcelain.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 62125ec..c53af62 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -732,7 +732,7 @@ test_expect_success 'bisect: demonstrate identification of damage boundary' "
 	git bisect reset &&
 	git checkout broken &&
 	git bisect start broken master --no-checkout &&
-	git bisect run sh -c '
+	git bisect run \"$SHELL_PATH\" -c '
 		GOOD=\$(git for-each-ref \"--format=%(objectname)\" refs/bisect/good-*) &&
 		git rev-list --objects BISECT_HEAD --not \$GOOD >tmp.\$\$ &&
 		git pack-objects --stdout >/dev/null < tmp.\$\$
-- 
1.7.6.1
