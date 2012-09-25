From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH 6/5] side-step a make rule that builds t3070-wildmatch
Date: Tue, 25 Sep 2012 09:01:55 +0200
Message-ID: <506156E3.4060508@viscovery.net>
References: <1347710524-15404-1-git-send-email-pclouds@gmail.com> <1347809265-2457-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 25 09:02:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGP9s-0002A2-5d
	for gcvg-git-2@plane.gmane.org; Tue, 25 Sep 2012 09:02:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753353Ab2IYHCE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2012 03:02:04 -0400
Received: from lilzmailso03.liwest.at ([212.33.55.24]:29235 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753349Ab2IYHCD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2012 03:02:03 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1TGP9Y-0008OJ-Dj; Tue, 25 Sep 2012 09:01:57 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 098AC1660F;
	Tue, 25 Sep 2012 09:01:55 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:15.0) Gecko/20120907 Thunderbird/15.0.1
In-Reply-To: <1347809265-2457-1-git-send-email-pclouds@gmail.com>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206350>

From: Johannes Sixt <j6t@kdbg.org>

Running "make t3070-wildmatch" aborts with this error:

   $ make t3070-wildmatch
   *** t3070-wildmatch.sh ***
   # passed all 11 test(s)
   1..11
   cat t3070-wildmatch.sh >t3070-wildmatch
   /bin/sh.exe: t3070-wildmatch: File exists
   make: *** [t3070-wildmatch] Error 1

It seems that there is a make rule that attempts to transform a *.sh file
into a file without the extension. The rule fails because t3070-wildmatch
is a directory. Rename it to t3070.

Of course, nobody would run exactly "make t3070-wildmatch". But it is
common (at least for me) to run "make t[3-9]*" or similar, which would
include t3070-wildmatch. With this patch, it includes t3070, but that does
not hurt because make just skips it with "Nothing to be done for `t3070'."

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 Feel free to squash this patch if you re-roll the series.

 t/t3070-wildmatch.sh                      | 2 +-
 t/{t3070-wildmatch => t3070}/wildtest.txt | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename t/{t3070-wildmatch => t3070}/wildtest.txt (100%)

diff --git a/t/t3070-wildmatch.sh b/t/t3070-wildmatch.sh
index 7fb63ff..c4da26c 100755
--- a/t/t3070-wildmatch.sh
+++ b/t/t3070-wildmatch.sh
@@ -6,7 +6,7 @@ test_description='wildmatch tests'

 test_wildmatch() {
     test_expect_success "wildmatch $*" "
-	test-wildmatch $* ../t3070-wildmatch/wildtest.txt >actual &&
+	test-wildmatch $* ../t3070/wildtest.txt >actual &&
 	echo 'No wildmatch errors found.' >expected &&
 	test_cmp expected actual
     "
diff --git a/t/t3070-wildmatch/wildtest.txt b/t/t3070/wildtest.txt
similarity index 100%
rename from t/t3070-wildmatch/wildtest.txt
rename to t/t3070/wildtest.txt
-- 
1.7.12.1.1626.gf25df0e
