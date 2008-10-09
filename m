From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] test-lib: fix color reset in say_color()
Date: Fri, 10 Oct 2008 00:07:10 +0200
Message-ID: <1223590030-7464-1-git-send-email-vmiklos@frugalware.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 10 00:08:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ko3fk-0004Kv-WB
	for gcvg-git-2@gmane.org; Fri, 10 Oct 2008 00:07:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756074AbYJIWGm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2008 18:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755570AbYJIWGl
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Oct 2008 18:06:41 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:32976 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754866AbYJIWGl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2008 18:06:41 -0400
Received: from vmobile.example.net (dsl5401C654.pool.t-online.hu [84.1.198.84])
	by yugo.frugalware.org (Postfix) with ESMTPA id A4FF8149C60
	for <git@vger.kernel.org>; Fri, 10 Oct 2008 00:06:39 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 30A9E19D922; Fri, 10 Oct 2008 00:07:10 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97896>

When executing a single test with colors enabled, the cursor was not set
back to the previous one, and you had to hit an extra enter to get it
back.

Work around this problem by calling 'tput sgr0' before printing the
final newline.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

Actually I'm not 100% sure about how many users are affected. I have a
black background in konsole with white letters, and after the test I get
a green cursor, and once I hit enter, I get the white one back.

 t/test-lib.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index e2b106c..fb89741 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -112,8 +112,9 @@ if test -n "$color"; then
 			*) test -n "$quiet" && return;;
 		esac
 		shift
-		echo "* $*"
+		printf "* $*"
 		tput sgr0
+		echo
 		)
 	}
 else
-- 
1.6.0.2
