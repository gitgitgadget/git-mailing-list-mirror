From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] t1503: Fix arithmetic expansion syntax error when using dash
Date: Tue, 21 Sep 2010 18:45:09 +0100
Message-ID: <4C98EF25.4070700@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>, jon.seymour@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 21 19:46:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oy6v8-0000cw-8j
	for gcvg-git-2@lo.gmane.org; Tue, 21 Sep 2010 19:46:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754985Ab0IURqQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Sep 2010 13:46:16 -0400
Received: from lon1-post-2.mail.demon.net ([195.173.77.149]:38719 "EHLO
	lon1-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753013Ab0IURqP (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Sep 2010 13:46:15 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-2.mail.demon.net with esmtp (Exim 4.69)
	id 1Oy6ux-00056h-bJ; Tue, 21 Sep 2010 17:46:14 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156734>


On systems which have dash as /bin/sh, such as Ubuntu, the final
test (master@{n} for various n) fails with a syntax error while
processing an arithmetic expansion. The syntax error is caused by
using a bare name ('N') as a variable reference in the expression.

In order to avoid the syntax error, we spell the variable reference
as '$N' rather than simply 'N'.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 t/t1503-rev-parse-verify.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t1503-rev-parse-verify.sh b/t/t1503-rev-parse-verify.sh
index 100f857..813cc1b 100755
--- a/t/t1503-rev-parse-verify.sh
+++ b/t/t1503-rev-parse-verify.sh
@@ -106,8 +106,8 @@ test_expect_success 'use --default' '
 
 test_expect_success 'master@{n} for various n' '
 	N=$(git reflog | wc -l) &&
-	Nm1=$((N-1)) &&
-	Np1=$((N+1)) &&
+	Nm1=$(($N-1)) &&
+	Np1=$(($N+1)) &&
 	git rev-parse --verify master@{0} &&
 	git rev-parse --verify master@{1} &&
 	git rev-parse --verify master@{$Nm1} &&
-- 
1.7.3
