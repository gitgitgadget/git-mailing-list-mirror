From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH jk/checkout-attribute-lookup] t2003: work around path mangling
 issue on Windows
Date: Wed, 20 Mar 2013 09:47:57 +0100
Message-ID: <514977BD.6060604@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 20 09:48:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIEhD-0007jy-V2
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 09:48:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751624Ab3CTIsC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Mar 2013 04:48:02 -0400
Received: from so.liwest.at ([212.33.55.24]:54709 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751388Ab3CTIr7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 04:47:59 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1UIEgf-0003YD-HX
	for git@vger.kernel.org; Wed, 20 Mar 2013 09:47:57 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 4D7781660F
	for <git@vger.kernel.org>; Wed, 20 Mar 2013 09:47:57 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
X-Enigmail-Version: 1.5.1
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218579>

From: Johannes Sixt <j6t@kdbg.org>

MSYS bash considers the part "/g" in the sed expression "s/./=/g" as an
absolute path after an assignment, and mangles it to a C:/something
string. Do not attract bash's attention by avoiding the equals sign.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t2003-checkout-cache-mkdir.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t2003-checkout-cache-mkdir.sh b/t/t2003-checkout-cache-mkdir.sh
index 4c97468..ff163cf 100755
--- a/t/t2003-checkout-cache-mkdir.sh
+++ b/t/t2003-checkout-cache-mkdir.sh
@@ -94,14 +94,14 @@ test_expect_success 'apply filter from working tree .gitattributes with --prefix
 	rm -fr path0 path1 path2 tmp* &&
 	mkdir path1 &&
 	mkdir tmp &&
-	git config filter.replace-all.smudge "sed -e s/./=/g" &&
+	git config filter.replace-all.smudge "sed -e s/./,/g" &&
 	git config filter.replace-all.clean cat &&
 	git config filter.replace-all.required true &&
 	echo "file1 filter=replace-all" >path1/.gitattributes &&
 	git checkout-index --prefix=tmp/ -f -a &&
 	echo frotz >expected &&
 	test_cmp expected tmp/path0 &&
-	echo ====== >expected &&
+	echo ,,,,,, >expected &&
 	test_cmp expected tmp/path1/file1
 '
 
-- 
1.8.2.1433.g0074116
