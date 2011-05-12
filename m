From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH jc/magic-pathspec] t3703: Skip tests using directory name
 ":" on Windows
Date: Thu, 12 May 2011 10:21:33 +0200
Message-ID: <4DCB988D.6060908@viscovery.net>
References: <1304852906-29272-1-git-send-email-pclouds@gmail.com> <1305006678-4051-1-git-send-email-gitster@pobox.com> <1305006678-4051-10-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, pclouds@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 12 10:27:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKREf-0004SR-7G
	for gcvg-git-2@lo.gmane.org; Thu, 12 May 2011 10:27:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754452Ab1ELI07 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2011 04:26:59 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:20730 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754401Ab1ELI06 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2011 04:26:58 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1QKREP-0001e7-PE; Thu, 12 May 2011 10:26:56 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id CEFD61660F;
	Thu, 12 May 2011 10:21:33 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
In-Reply-To: <1305006678-4051-10-git-send-email-gitster@pobox.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173450>

From: Johannes Sixt <j6t@kdbg.org>

":" is not allowed in file names on Windows. Detect this case and skip a
test if necessary.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t3703-add-magic-pathspec.sh |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/t/t3703-add-magic-pathspec.sh b/t/t3703-add-magic-pathspec.sh
index ce5585e..e508246 100755
--- a/t/t3703-add-magic-pathspec.sh
+++ b/t/t3703-add-magic-pathspec.sh
@@ -44,8 +44,12 @@ test_expect_success 'a file with the same (long) magic name exists' '
 	git add -n "./:(icase)ha"
 '
 
-test_expect_success 'a file with the same (short) magic name exists' '
-	mkdir ":" &&
+if mkdir ":" 2>/dev/null
+then
+	test_set_prereq COLON_DIR
+fi
+
+test_expect_success COLON_DIR 'a file with the same (short) magic name exists' '
 	: >":/bar" &&
 	test_must_fail git add -n :/bar &&
 	git add -n "./:/bar"
-- 
1.7.5.1.1644.g7f2ed
