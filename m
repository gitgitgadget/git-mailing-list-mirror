From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] config: add test cases for empty value and no value config
 variables.
Date: Thu, 7 Feb 2008 06:23:46 +0100
Message-ID: <20080207062346.3936cc53.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Thu Feb 07 06:18:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMz9Q-00073t-Jv
	for gcvg-git-2@gmane.org; Thu, 07 Feb 2008 06:18:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751838AbYBGFRr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2008 00:17:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751469AbYBGFRr
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 00:17:47 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:34622 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751320AbYBGFRq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2008 00:17:46 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id DEE631AB2B4;
	Thu,  7 Feb 2008 06:17:44 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 8B7951AB2B9;
	Thu,  7 Feb 2008 06:17:44 +0100 (CET)
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.5; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72894>

The tests in 't1300-repo-config.sh' did not check what happens when
an empty value like the following is used in the config file:

[emptyvalue]
	variable =

Also it was not checked that a variable with no value like the
following:

[novalue]
	variable

gives a boolean "true" value, while an ampty value gives a boolean
"false" value.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t1300-repo-config.sh |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index a786c5c..66aeb88 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -283,17 +283,40 @@ test_expect_success '--add' \
 cat > .git/config << EOF
 [novalue]
 	variable
+[emptyvalue]
+	variable =
 EOF
 
 test_expect_success 'get variable with no value' \
 	'git config --get novalue.variable ^$'
 
+test_expect_success 'get variable with empty value' \
+	'git config --get emptyvalue.variable ^$'
+
 echo novalue.variable > expect
 
 test_expect_success 'get-regexp variable with no value' \
 	'git config --get-regexp novalue > output &&
 	 cmp output expect'
 
+echo 'emptyvalue.variable ' > expect
+
+test_expect_success 'get-regexp variable with empty value' \
+	'git config --get-regexp emptyvalue > output &&
+	 cmp output expect'
+
+echo true > expect
+
+test_expect_success 'get bool variable with no value' \
+	'git config --bool novalue.variable > output &&
+	 cmp output expect'
+
+echo false > expect
+
+test_expect_success 'get bool variable with empty value' \
+	'git config --bool emptyvalue.variable > output &&
+	 cmp output expect'
+
 git config > output 2>&1
 
 test_expect_success 'no arguments, but no crash' \
-- 
1.5.4.18.gd0b8
