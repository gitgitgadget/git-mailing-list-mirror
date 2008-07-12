From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH 1/2] t/test-lib.sh: Let test_must_fail fail on signals only
Date: Sat, 12 Jul 2008 17:47:51 +0200
Message-ID: <1215877672-17049-1-git-send-email-s-beyer@gmx.net>
Cc: git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 12 17:49:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHhLF-0006JO-Fh
	for gcvg-git-2@gmane.org; Sat, 12 Jul 2008 17:48:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755356AbYGLPr5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jul 2008 11:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753700AbYGLPr5
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jul 2008 11:47:57 -0400
Received: from mail.gmx.net ([213.165.64.20]:44671 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755243AbYGLPr4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jul 2008 11:47:56 -0400
Received: (qmail invoked by alias); 12 Jul 2008 15:47:54 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp015) with SMTP; 12 Jul 2008 17:47:54 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX19JrWkfkZdJPeVv5rzuVvnnG06qzRQc+rPnDDh5TX
	+pJExsJqj+2pL4
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KHhKC-0004RM-Kv; Sat, 12 Jul 2008 17:47:52 +0200
X-Mailer: git-send-email 1.5.6.2.303.g79662
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88249>

The test_must_fail function in test-lib.sh has been designed
to distinguish segmentation faults from controlled errors.
But in the current implementation this only works if a git
command does not return a small negative value, like -1, -2
or -3. But some git commands do.

Because any signal (like SIGSEGV) will result in an exit status
less than 193, this patch just adds a further check for the exit
status.

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
 t/test-lib.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 8e2849b..11c0275 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -379,7 +379,7 @@ test_external_without_stderr () {
 
 test_must_fail () {
 	"$@"
-	test $? -gt 0 -a $? -le 129
+	test $? -gt 0 -a $? -le 129 -o $? -gt 192
 }
 
 # test_cmp is a helper function to compare actual and expected output.
-- 
1.5.6.2.303.g79662
