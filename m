From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v3 1/2] gc: demonstrate failure with stale remote HEAD
Date: Tue, 06 Oct 2015 15:58:42 +0200
Organization: gmx
Message-ID: <f6e1778a42460ac5fbcbd3c9ee76edcf52358299.1444139796.git.johannes.schindelin@gmx.de>
References: <xmqqr3lnuzqu.fsf@gitster.mtv.corp.google.com>
 <cover.1444139796.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 06 15:59:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjSln-0003VB-Tr
	for gcvg-git-2@plane.gmane.org; Tue, 06 Oct 2015 15:59:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752654AbbJFN67 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Oct 2015 09:58:59 -0400
Received: from mout.gmx.net ([212.227.15.18]:64021 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752590AbbJFN65 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Oct 2015 09:58:57 -0400
Received: from dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MQhyf-1aCrcn0q2X-00U4nI; Tue, 06 Oct 2015 15:58:44
 +0200
In-Reply-To: <cover.1444139796.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:sRSsDu0nmMCnzOfYMbNRGOIZ57hBjA2lpnrLOTDMepHulxHEYti
 gawsHiwjG/X3CHW7MrQG+YO68ThRpKUk4Txicrr44XygVwFK2mBLGPdlgIoOW9rHPEAfm+Z
 +Qd5PF9/2eo8z3bq4vOc1/HjM4GOLzqvtAhrfMCYdzFFL1Wb+P1bUYk4g8H9eTp9ciQxtav
 u7XviOebnZDUqL43JiCzg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:t2Cfukb6Vyo=:3k0ACyy0v9UiSBijv2nY6e
 UD9ialmvZQX/wDdLUiBiZdU2Iu/EgURS/OFbAoi7ilOLylU/BCZ7INQV550mD1JONohNvf+Nn
 qo36Bp3AvAyM6zLoKDjLEi+DOutoQlrbo8mB2YC8LUaICXwdGE/6omzgE+SC/g+ZEQ7iuOImC
 BmW9Wb6pWrUGsnjIgNBMUiK2weQQOl5D8iAywQDgylUx951mfNp9mmhs5APDURjUx1TTDLCik
 Bcg+N7BMrMSUtGSEB/iFQ9V+tVYrFeC5PG+ifNchwtd+BhhfF0MFCVh1mHndgOq0hxTwl6Ndo
 Pvv4n/h36LLE+VgoB/BiCgvSf/yJIMQLQhwt9VMjmhvARGr9CggLhPnY2yf9WdcYQANZZWGxf
 +TcWSg4Y32u7TXgCIVu1+bRGs290V6GDhzwVw+u2UEtYF7a08BMXtgZ6AdJUSouMVqK+B0lHo
 JhXYkFWk3AhtCJcCDJILeLvMjGZKHZwCgGeh6OjY3M0rvcujuJJb98OsyuHjNF9+IwRs+0B4M
 9kiPbTVj89Mu/OGVf/zh91qEw1FepEeaEnk1sMjS3LCgSx+1elknFcmFY2EPg2cIHcJfUokQn
 7ZP9SX+d8ebHzAwHR87E7FAmHWiWtL3yPTmiPZQYKGQvkjLFsVokbVcryN9/73K2TdO9wLpr6
 OkRXSP7zaE7rSEhUncub4ysOwih2daVvjOB2zCqwPooDKOyG5lq2AFPlVqXMc8aVhM4H2119D
 l0QiBcIqDeb+owuk1JHfYNWN6BR38HBLrdxCiJL8C30GZ2O0WpCPr9R2NrznoQdnCRx3vZzV 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279144>

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t6500-gc.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index 63194d8..9a3a285 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -30,4 +30,17 @@ test_expect_success 'gc -h with invalid configuration' '
 	test_i18ngrep "[Uu]sage" broken/usage
 '
 
+test_expect_failure 'gc removes broken refs/remotes/<name>/HEAD' '
+	git init remote &&
+	(
+		cd remote &&
+		test_commit initial &&
+		git clone . ../client &&
+		git branch -m develop &&
+		cd ../client &&
+		git fetch --prune &&
+		git gc
+	)
+'
+
 test_done
-- 
2.6.1.windows.1
