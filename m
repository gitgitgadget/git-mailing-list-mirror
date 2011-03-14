From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] git-bisect.txt: example for bisecting with hotfix
Date: Mon, 14 Mar 2011 14:47:20 +0100
Message-ID: <cf85600a90cea6a0a751c674b821d17d85f34c66.1300109828.git.git@drmicha.warpmail.net>
References: <20110314131623.119020@gmx.net>
Cc: Jan Beulich <JBeulich@novell.com>, "H.J. Lu" <hjl.tools@gmail.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@elte.hu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 14 14:51:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pz8Aq-0005Bi-4t
	for gcvg-git-2@lo.gmane.org; Mon, 14 Mar 2011 14:51:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752299Ab1CNNuy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Mar 2011 09:50:54 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:44985 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751808Ab1CNNux (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Mar 2011 09:50:53 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 7700A2069A;
	Mon, 14 Mar 2011 09:50:52 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Mon, 14 Mar 2011 09:50:52 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=9greniw7Zl/6DNJY2m89PZBjz2k=; b=lzLO7+QKVARejj/t45witxopDtWX/5OyulNU9i8jrS4pvm/CbsY2xl7gxW+KE3XoX3rSK6TyjKTKNBcJHNNhx8EJcnIANfZz5eKgWchEMkxqUFd7E2cDvo9n62gEPEhPzSAavz6TMx0lJj64jXNzwFWYNnEL1duwrbeNgI8oWZ4=
X-Sasl-enc: a8KptSRpnFs3KWYBg4rtV1UdoZvBjXeUosWcVkTxZTvK 1300110652
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id ED4764011EA;
	Mon, 14 Mar 2011 09:50:51 -0400 (EDT)
X-Mailer: git-send-email 1.7.4.1.404.g62d316
In-Reply-To: <20110314131623.119020@gmx.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168988>

Give an example on how to bisect when older revisions need a hotfix to
build, run or test. Triggered by the binutils/kernel issue at

http://thread.gmane.org/gmane.comp.gnu.binutils/52601/focus=1112779

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
Maybe this doc fix would do. Just tag the hotfix and tell people to cherry-pick it
like this. I don't think "git bisect --with-fix=hotfix" would be much simpler.
(culling kernel list from cc - don't apply this to the wrong tree :)

 Documentation/git-bisect.txt |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index c39d957..25acf26 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -322,6 +322,17 @@ $ git bisect run sh -c "make || exit 125; ~/check_test_case.sh"
 +
 Does the same as the previous example, but on a single line.
 
+* Bisect with compatibility hotfix:
++
+------------
+$ git bisect start HEAD HEAD~10 --   # culprit is among the last 10
+$ git bisect run sh -c "git cherry-pick -n hotfix || exit 125; make || exit 125; ~/check_test_case.sh"
+------------
++
+Does the same as the previous example, but applies an additional patch
+before building. This is useful when your build or test environment changed so
+that older revisions may need a fix which newer ones have already.
+
 Author
 ------
 Written by Linus Torvalds <torvalds@osdl.org>
-- 
1.7.4.1.404.g62d316
