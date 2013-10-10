From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH] path-utils: Rename mingw_path function to print_path
Date: Thu, 10 Oct 2013 22:49:43 +0200
Message-ID: <525712E7.2010608@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j6t@kdbg.org>, Jiang Xin <worldhello.net@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 10 22:50:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUNBJ-00059u-5b
	for gcvg-git-2@plane.gmane.org; Thu, 10 Oct 2013 22:50:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756860Ab3JJUt5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Oct 2013 16:49:57 -0400
Received: from plane.gmane.org ([80.91.229.3]:50597 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756644Ab3JJUt4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Oct 2013 16:49:56 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1VUNBD-00056z-Ub
	for git@vger.kernel.org; Thu, 10 Oct 2013 22:49:55 +0200
Received: from p5ddb14be.dip0.t-ipconnect.de ([93.219.20.190])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 10 Oct 2013 22:49:55 +0200
Received: from sschuberth by p5ddb14be.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 10 Oct 2013 22:49:55 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: p5ddb14be.dip0.t-ipconnect.de
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235884>

mingw_path was introduced in abd4284 to output a mangled path as it is
passed as an argument to main(). But the name is misleading because
mangling does not come from MinGW, but from MSYS [1]. As abd4284 does not
introduce any MSYS or MinGW specific code but just prints out argv[2] as
it is passed to main(), give the function the more generic and less
confusing name "print_path".

[1] http://www.mingw.org/wiki/Posix_path_conversion

Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 t/t0060-path-utils.sh | 4 ++--
 test-path-utils.c     | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index 3a48de2..2bd5e32 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -8,13 +8,13 @@ test_description='Test various path utilities'
 . ./test-lib.sh
 
 norm_path() {
-	expected=$(test-path-utils mingw_path "$2")
+	expected=$(test-path-utils print_path "$2")
 	test_expect_success $3 "normalize path: $1 => $2" \
 	"test \"\$(test-path-utils normalize_path_copy '$1')\" = '$expected'"
 }
 
 relative_path() {
-	expected=$(test-path-utils mingw_path "$3")
+	expected=$(test-path-utils print_path "$3")
 	test_expect_success $4 "relative path: $1 $2 => $3" \
 	"test \"\$(test-path-utils relative_path '$1' '$2')\" = '$expected'"
 }
diff --git a/test-path-utils.c b/test-path-utils.c
index bb975e4..3dd3744 100644
--- a/test-path-utils.c
+++ b/test-path-utils.c
@@ -116,7 +116,7 @@ int main(int argc, char **argv)
 		return 0;
 	}
 
-	if (argc == 3 && !strcmp(argv[1], "mingw_path")) {
+	if (argc == 3 && !strcmp(argv[1], "print_path")) {
 		puts(argv[2]);
 		return 0;
 	}
-- 
1.8.4.msysgit.0
