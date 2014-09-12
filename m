From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH] t9300: use cmp instead of test_cmp to compare binary files
Date: Fri, 12 Sep 2014 19:34:00 +0200
Message-ID: <54132E88.8050803@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 12 19:34:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSUjb-0003a0-AW
	for gcvg-git-2@plane.gmane.org; Fri, 12 Sep 2014 19:34:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751538AbaILReG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2014 13:34:06 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:37251 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750841AbaILReF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2014 13:34:05 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id AC9391300A7
	for <git@vger.kernel.org>; Fri, 12 Sep 2014 19:34:02 +0200 (CEST)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 32C8619F4B8
	for <git@vger.kernel.org>; Fri, 12 Sep 2014 19:34:01 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256932>

test_cmp is intended to produce diff output for human consumption. The
input in one instance in t9300-fast-import.sh are binary files, however.
Use cmp to compare the files.

This was noticed because on Windows we have a special implementation of
test_cmp in pure bash code (to ignore differences due to intermittent CR
in actual output), and bash runs into an infinite loop due to the binary
nature of the input.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t9300-fast-import.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 99f5161..4b13170 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -2687,7 +2687,7 @@ test_expect_success 'R: verify created pack' '
 test_expect_success \
 	'R: verify written objects' \
 	'git --git-dir=R/.git cat-file blob big-file:big1 >actual &&
-	 test_cmp expect actual &&
+	 cmp expect actual &&
 	 a=$(git --git-dir=R/.git rev-parse big-file:big1) &&
 	 b=$(git --git-dir=R/.git rev-parse big-file:big2) &&
 	 test $a = $b'
-- 
2.0.0.12.gbcf935e
