From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 27/27] t9104: fix test for following larger parents
Date: Fri, 20 Mar 2015 15:32:56 +0100
Message-ID: <43da457ddd8840ac5cf131e59d488fc41cdc8a52.1426861743.git.git@drmicha.warpmail.net>
References: <550C2E7B.3030203@drmicha.warpmail.net>
Cc: Jeff King <peff@peff.net>, Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 20 15:33:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYxz4-0004Jg-0w
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 15:33:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751622AbbCTOdD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 10:33:03 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:54803 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751131AbbCTOdA (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Mar 2015 10:33:00 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 74A8120C66
	for <git@vger.kernel.org>; Fri, 20 Mar 2015 10:32:57 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute1.internal (MEProxy); Fri, 20 Mar 2015 10:32:59 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=
	x-sasl-enc:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references; s=mesmtp; bh=BJJ5zjbW0J/xrON
	bPTCGg03ADqk=; b=jW+MfLlearSVil23PrGYNczA8gGyYJHiE9FiciTM+3rStMK
	nLPhDlmwHv+SuqrVv3/PS7BETjR0SmfB3YROogDYORoWTYOzptHfUyArW9hfUBK5
	GS6Ltk9OSX/6JBKIqxn8zUBmcBf21wWrS3evJFmfmwisfwsadukHxoXeMWF0=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:from:to:cc:subject:date
	:message-id:in-reply-to:references:in-reply-to:references; s=
	smtpout; bh=BJJ5zjbW0J/xrONbPTCGg03ADqk=; b=jDgL2cOEwZ+c1qZDtNqE
	qaRWb2QEjFyD+aRRB2pKSCadinyEE9uZHKCPhSfD+WmUpLE+bz7PoVSUYgBvFTNZ
	CjysY7yu+op0fTau6RTOU21Eg7CVPpZRCzyDOJ/A2htunm24E5ZzpqwjSQEQIi/l
	c15VtzjV0pQUmLn8smDVqkk=
X-Sasl-enc: WwDaCXzQZva3xhebekq33hyY/6gwSvJDq94mb+Um/70s 1426861979
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 4AECE6800F3;
	Fri, 20 Mar 2015 10:32:59 -0400 (EDT)
X-Mailer: git-send-email 2.3.3.438.g7254779
In-Reply-To: <550C2E7B.3030203@drmicha.warpmail.net>
In-Reply-To: <317e6b1e70f3e1c50d62207c53f4d038ad027c9d.1426861743.git.git@drmicha.warpmail.net>
References: <317e6b1e70f3e1c50d62207c53f4d038ad027c9d.1426861743.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265906>

This test is special for several reasons:
It ends with a "true" statement, which should be a no-op.
It is not because the &&-chain is broken right before it.

Also, looking at what the test intended to test according to
7f578c5 (git-svn: --follow-parent now works on sub-directories of larger
branches, 2007-01-24)
it is not clear how it would achieve that with the given steps.

Amend the test to include the second svn id to be tested for, and
change the tested refs to the ones which are to be expected, and which
make the test pass.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
In fact, these merge-base tests look kind of ugly, too.
But they appear in many more places here and should best be rewritten
separately.

 t/t9104-git-svn-follow-parent.sh | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/t/t9104-git-svn-follow-parent.sh b/t/t9104-git-svn-follow-parent.sh
index 13b179e..1bd1022 100755
--- a/t/t9104-git-svn-follow-parent.sh
+++ b/t/t9104-git-svn-follow-parent.sh
@@ -72,16 +72,18 @@ test_expect_success 'follow larger parent' '
         svn import -m "import a larger parent" import "$svnrepo"/larger-parent &&
         svn cp -m "hi" "$svnrepo"/larger-parent "$svnrepo"/another-larger &&
         git svn init --minimize-url -i larger \
-          "$svnrepo"/another-larger/trunk/thunk/bump/thud &&
+          "$svnrepo"/larger-parent/trunk/thunk/bump/thud &&
         git svn fetch -i larger &&
+        git svn init --minimize-url -i larger-parent \
+          "$svnrepo"/another-larger/trunk/thunk/bump/thud &&
+        git svn fetch -i larger-parent &&
         git rev-parse --verify refs/remotes/larger &&
         git rev-parse --verify \
-           refs/remotes/larger-parent/trunk/thunk/bump/thud &&
+           refs/remotes/larger-parent &&
         test "`git merge-base \
-                 refs/remotes/larger-parent/trunk/thunk/bump/thud \
+                 refs/remotes/larger-parent \
                  refs/remotes/larger`" = \
              "`git rev-parse refs/remotes/larger`"
-        true
         '
 
 test_expect_success 'follow higher-level parent' '
-- 
2.3.3.438.g7254779
