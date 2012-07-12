From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH 7/6?] t4012: use 'printf' instead of 'dd' to generate a binary
 file
Date: Thu, 12 Jul 2012 09:13:23 +0200
Message-ID: <4FFE7913.3090500@viscovery.net>
References: <20120711221140.GA21303@akuma>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>, Junio C Hamano <gitster@pobox.com>
To: Alexander Strasser <eclipse7@gmx.net>
X-From: git-owner@vger.kernel.org Thu Jul 12 09:13:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SpDai-0002mb-8k
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jul 2012 09:13:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757125Ab2GLHNb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jul 2012 03:13:31 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:5694 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757010Ab2GLHNa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2012 03:13:30 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.76)
	(envelope-from <j.sixt@viscovery.net>)
	id 1SpDc5-0005X8-I3; Thu, 12 Jul 2012 09:15:01 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 522A51660F;
	Thu, 12 Jul 2012 09:13:23 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:13.0) Gecko/20120614 Thunderbird/13.0.1
In-Reply-To: <20120711221140.GA21303@akuma>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201348>

From: Johannes Sixt <j6t@kdbg.org>

For some reason, 'echo X | dd bs=1k seek=1' creates a file with 2050 bytes
on Windows instead of the expected 1026 bytes, so that a test fails. Since
the actual contents of the file are irrelevant as long as there is at
least one zero byte so that the diff machinery recognizes it as binary,
use printf to generate it.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 While the focus is on t4012, maybe you can add this patch to the series.

 t/t4012-diff-binary.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t4012-diff-binary.sh b/t/t4012-diff-binary.sh
index 6cebb39..8c018ab 100755
--- a/t/t4012-diff-binary.sh
+++ b/t/t4012-diff-binary.sh
@@ -125,7 +125,7 @@ cat >expect <<EOF
 EOF
 
 test_expect_success 'diff --stat with binary files and big change count' '
-	echo X | dd of=binfile bs=1k seek=1 &&
+	printf "\01\00%1024d" 1 >binfile &&
 	git add binfile &&
 	i=0 &&
 	while test $i -lt 10000; do
-- 
1.7.11.1.1304.g11834c6
