From: Alexander Strasser <eclipse7@gmx.net>
Subject: [PATCH v2 7/8] t4012: use 'printf' instead of 'dd' to generate a
 binary file
Date: Mon, 16 Jul 2012 22:46:56 +0200
Message-ID: <d831ad4226688aa8ca2b3b152e242e357adbb3b2.1342468069.git.eclipse7@gmx.net>
References: <cover.1342468069.git.eclipse7@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 16 22:47:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SqsCD-0004Fg-6Y
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jul 2012 22:47:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752702Ab2GPUrE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jul 2012 16:47:04 -0400
Received: from mailout-de.gmx.net ([213.165.64.22]:43426 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752461Ab2GPUrC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2012 16:47:02 -0400
Received: (qmail invoked by alias); 16 Jul 2012 20:47:00 -0000
Received: from p5DC37C42.dip.t-dialin.net (EHLO gmx.net) [93.195.124.66]
  by mail.gmx.net (mp034) with SMTP; 16 Jul 2012 22:47:00 +0200
X-Authenticated: #8251126
X-Provags-ID: V01U2FsdGVkX19Bjz0dcwNB75Zf1FEI6DASNXOxjC4CWVKr2l2SL0
	bOjFDCicM2OlJt
Received: by gmx.net (sSMTP sendmail emulation); Mon, 16 Jul 2012 22:46:56 +0200
Content-Disposition: inline
In-Reply-To: <cover.1342468069.git.eclipse7@gmx.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201575>

From: Johannes Sixt <j6t@kdbg.org>

For some reason, 'echo X | dd bs=1k seek=1' creates a file with 2050 bytes
on Windows instead of the expected 1026 bytes, so that a test fails. Since
the actual contents of the file are irrelevant as long as there is at
least one zero byte so that the diff machinery recognizes it as binary,
use printf to generate it.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Alexander Strasser <eclipse7@gmx.net>
---
 t/t4012-diff-binary.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t4012-diff-binary.sh b/t/t4012-diff-binary.sh
index 7b0e759..077870e 100755
--- a/t/t4012-diff-binary.sh
+++ b/t/t4012-diff-binary.sh
@@ -131,7 +131,7 @@ cat >expect <<EOF
 EOF
 
 test_expect_success 'diff --stat with binary files and big change count' '
-	echo X | dd of=binfile bs=1k seek=1 &&
+	printf "\01\00%1024d" 1 >binfile &&
 	git add binfile &&
 	i=0 &&
 	while test $i -lt 10000; do
-- 
1.7.10.2.552.gaa3bb87
