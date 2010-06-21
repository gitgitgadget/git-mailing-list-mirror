From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 2/3] t/t7811-grep-open.sh: ensure fake "less" is made executable
Date: Mon, 21 Jun 2010 12:37:14 -0500
Message-ID: <__CrpvAIIX9lgHHkBLHB9a3UByh6vEB5nG8C7-bzzaY-zhXjKlkZfsB4GNmQRsIYGu10jf-0sjU@cipher.nrlssc.navy.mil>
References: <__CrpvAIIX9lgHHkBLHB9fuuN7Rspzl7LFSDSwXwVCT6rYs_YOUHNMf7JZQbKaPHRl6AjsJ9dx8@cipher.nrlssc.navy.mil>
Cc: gitster@pobox.com, johannes.schindelin@gmx.de,
	Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 21 19:38:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OQkwv-0007kx-Dg
	for gcvg-git-2@lo.gmane.org; Mon, 21 Jun 2010 19:38:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932872Ab0FURiO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jun 2010 13:38:14 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:60795 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932715Ab0FURiO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jun 2010 13:38:14 -0400
Received: by mail.nrlssc.navy.mil id o5LHbdQU008620; Mon, 21 Jun 2010 12:37:39 -0500
In-Reply-To: <__CrpvAIIX9lgHHkBLHB9fuuN7Rspzl7LFSDSwXwVCT6rYs_YOUHNMf7JZQbKaPHRl6AjsJ9dx8@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 21 Jun 2010 17:37:38.0910 (UTC) FILETIME=[718677E0:01CB1168]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149425>

From: Brandon Casey <drafnel@gmail.com>

The fake "less" script was not being made executable.  This can cause the
tests that follow to fail.  This failure is not apparent on platforms which
have DEFAULT_PAGER set to the string "less", since lib-pager.sh will have
set the $less variable to "less" and the SIMPLEPAGER prerequisite will have
been set, and so the "less" script will have already been created properly
and made executable in test 2 'git grep -O'.  On platforms which set
DEFAULT_PAGER to something like "more", no such script will have been
previously created, and tests 7 and 8 will fail.

So, add a call to chmod to make the fake "less" script executable.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 t/t7811-grep-open.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/t/t7811-grep-open.sh b/t/t7811-grep-open.sh
index 8db4fc8..2e5c701 100755
--- a/t/t7811-grep-open.sh
+++ b/t/t7811-grep-open.sh
@@ -84,10 +84,11 @@ test_expect_success 'git grep -O --no-index' '
 '
 
 test_expect_success 'setup: fake "less"' '
-	cat >less <<-\EOF
+	cat >less <<-\EOF &&
 	#!/bin/sh
 	printf "%s\n" "$@" >actual
 	EOF
+	chmod +x less
 '
 
 test_expect_success 'git grep -O jumps to line in less' '
-- 
1.6.6.2
