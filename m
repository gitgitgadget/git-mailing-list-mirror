From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] t1304,t2007: quell output to stdout and stderr
Date: Wed, 21 Apr 2010 15:55:40 +0200
Message-ID: <00e68c9727f8dd3426db6f78d6b583a0dcec4d13.1271858119.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 21 15:58:52 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4aS3-0007aV-HM
	for gcvg-git-2@lo.gmane.org; Wed, 21 Apr 2010 15:58:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752125Ab0DUN6p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Apr 2010 09:58:45 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:52896 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751382Ab0DUN6p (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Apr 2010 09:58:45 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id C506FEB066;
	Wed, 21 Apr 2010 09:58:44 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 21 Apr 2010 09:58:44 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id; s=smtpout; bh=iIwYufTRb6ySnyFx2DJMJA4IWws=; b=GpD2BvZpfGlwwPzuaS41TvUiJNgcVea5JkCotFb4fdFkWM7KmiwYXQIaVCh6d9fwANMYAnOq5J8a+7CpVzr4oiJHwON7wab2A2ckRMF+frGebTSLKVUkkiI3yOoAizAxa7RneLXFZWL3Hsxl9/+vlMMKzwEuLGZEuxN+e7mwGec=
X-Sasl-enc: +YBQvTtEGPGbCjXxvl0p9GX+mw0fWqTicfpkoPOFF6NW 1271858324
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 3400A4B0F24;
	Wed, 21 Apr 2010 09:58:44 -0400 (EDT)
X-Mailer: git-send-email 1.7.1.rc1.248.gcefbb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145430>

These tests send output to stdout or stderr even without -v. This is
distracting because unexpected output flashing by during make test
usually indicates problems

Shut them up uncoditionally: In both cases, the output was due to
intermediate commands in between the actual test cases.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 t/t1304-default-acl.sh      |    2 +-
 t/t2007-checkout-symlink.sh |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t1304-default-acl.sh b/t/t1304-default-acl.sh
index 055ad00..b26d2e8 100755
--- a/t/t1304-default-acl.sh
+++ b/t/t1304-default-acl.sh
@@ -15,7 +15,7 @@ umask 077
 # is a good candidate: exists on all unices, and it has permission
 # anyway, so we don't create a security hole running the testsuite.
 
-if ! setfacl -m u:root:rwx .; then
+if ! setfacl -m u:root:rwx . 2>/dev/null; then
     say "Skipping ACL tests: unable to use setfacl"
     test_done
 fi
diff --git a/t/t2007-checkout-symlink.sh b/t/t2007-checkout-symlink.sh
index 20f3343..fc5db05 100755
--- a/t/t2007-checkout-symlink.sh
+++ b/t/t2007-checkout-symlink.sh
@@ -45,7 +45,7 @@ test_expect_success 'switch from symlink to dir' '
 '
 
 rm -fr frotz xyzzy nitfol &&
-git checkout -f master || exit
+git checkout -q -f master || exit
 
 test_expect_success 'switch from dir to symlink' '
 
-- 
1.7.1.rc1.248.gcefbb
