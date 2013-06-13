From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH jx/clean-interactive] t0060: skip a few relative_path tests
 on Windows
Date: Thu, 13 Jun 2013 10:23:34 +0200
Message-ID: <51B98186.2020100@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 13 10:23:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Un2p3-0006Nk-VJ
	for gcvg-git-2@plane.gmane.org; Thu, 13 Jun 2013 10:23:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758360Ab3FMIXn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jun 2013 04:23:43 -0400
Received: from so.liwest.at ([212.33.55.13]:35882 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758340Ab3FMIXk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jun 2013 04:23:40 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Un2oh-0003iW-CT; Thu, 13 Jun 2013 10:23:35 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 223501660F;
	Thu, 13 Jun 2013 10:23:35 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
X-Enigmail-Version: 1.5.1
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227706>

From: Johannes Sixt <j6t@kdbg.org>

The bash on Windows rewrites paths that look like absolute POSIX paths
when they are a command-line argument of a regular Windows program, such
as git and the test helpers. As a consequence, the actual tests performed
are not what the tests scripts expect.

The tests that need *not* be skipped are those where the two paths passed
to 'test-path-utils relative_path' have the same prefix and the result is
expected to be a relative path. This is because the rewriting changes
"/a/b" to "D:/Src/MSysGit/a/b", and when both inputs are extended the same
way, this just cancels out in the relative path computation.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t0060-path-utils.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index dfe4747..4deec52 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -190,15 +190,15 @@ test_expect_success SYMLINKS 'real path works on
symlinks' '

 relative_path /a/b/c/	/a/b/		c/
 relative_path /a/b/c/	/a/b		c/
-relative_path /a//b//c/	//a/b//		c/
+relative_path /a//b//c/	//a/b//		c/	POSIX
 relative_path /a/b	/a/b		./
 relative_path /a/b/	/a/b		./
 relative_path /a	/a/b		../
 relative_path /		/a/b/		../../
 relative_path /a/c	/a/b/		../c
 relative_path /a/c	/a/b		../c
-relative_path /a/b	"<empty>"	/a/b
-relative_path /a/b 	"<null>"	/a/b
+relative_path /a/b	"<empty>"	/a/b	POSIX
+relative_path /a/b 	"<null>"	/a/b	POSIX
 relative_path "<empty>"	/a/b		./
 relative_path "<empty>"	"<empty>"	./
 relative_path "<empty>"	"<null>"	./
-- 
1.8.3.1.1670.g1dbc49e
