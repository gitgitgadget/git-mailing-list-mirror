From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH] Skip archive --remote tests on Windows
Date: Wed, 03 Aug 2011 10:20:08 +0200
Message-ID: <4E3904B8.7080208@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 03 10:20:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoWgh-0000Nj-FT
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 10:20:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753134Ab1HCIUR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Aug 2011 04:20:17 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:5722 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752921Ab1HCIUP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 04:20:15 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1QoWgS-0005fi-S5; Wed, 03 Aug 2011 10:20:09 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 982BA1660F;
	Wed,  3 Aug 2011 10:20:08 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
X-Enigmail-Version: 1.1.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178548>

From: Johannes Sixt <j6t@kdbg.org>

These depend on a working git-upload-archive, which is broken on Windows,
because it depends on fork().

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 These prerequisites are needed in current master, but would have to be
 patched out again by Erik's upload-archive series.

 t/t5000-tar-tree.sh |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 9e3ba98..d906898 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -266,7 +266,7 @@ test_expect_success 'archive --list mentions user filter' '
 	grep "^bar\$" output
 '
 
-test_expect_success 'archive --list shows only enabled remote filters' '
+test_expect_success NOT_MINGW 'archive --list shows only enabled remote filters' '
 	git archive --list --remote=. >output &&
 	! grep "^tar\.foo\$" output &&
 	grep "^bar\$" output
@@ -298,7 +298,7 @@ test_expect_success 'extension matching requires dot' '
 	test_cmp b.tar config-implicittar.foo
 '
 
-test_expect_success 'only enabled filters are available remotely' '
+test_expect_success NOT_MINGW 'only enabled filters are available remotely' '
 	test_must_fail git archive --remote=. --format=tar.foo HEAD \
 		>remote.tar.foo &&
 	git archive --remote=. --format=bar >remote.bar HEAD &&
@@ -341,12 +341,12 @@ test_expect_success GZIP,GUNZIP 'extract tgz file' '
 	test_cmp b.tar j.tar
 '
 
-test_expect_success GZIP 'remote tar.gz is allowed by default' '
+test_expect_success GZIP,NOT_MINGW 'remote tar.gz is allowed by default' '
 	git archive --remote=. --format=tar.gz HEAD >remote.tar.gz &&
 	test_cmp j.tgz remote.tar.gz
 '
 
-test_expect_success GZIP 'remote tar.gz can be disabled' '
+test_expect_success GZIP,NOT_MINGW 'remote tar.gz can be disabled' '
 	git config tar.tar.gz.remote false &&
 	test_must_fail git archive --remote=. --format=tar.gz HEAD \
 		>remote.tar.gz
-- 
1.7.6.1572.g1f80c3
