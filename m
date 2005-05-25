From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Adjust show-files test for dotfiles.
Date: Wed, 25 May 2005 15:06:50 -0700
Message-ID: <7vwtpnhsed.fsf_-_@assigned-by-dhcp.cox.net>
References: <20050525111711.GA27492@vrfy.org>
	<Pine.LNX.4.58.0505251054110.2307@ppc970.osdl.org>
	<20050525183546.GA4241@vrfy.org>
	<7vzmujjdq4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kay Sievers <kay.sievers@vrfy.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 26 00:06:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Db40O-0006fL-SU
	for gcvg-git@gmane.org; Thu, 26 May 2005 00:05:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261575AbVEYWHN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 May 2005 18:07:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261492AbVEYWHJ
	(ORCPT <rfc822;git-outgoing>); Wed, 25 May 2005 18:07:09 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:32931 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S261571AbVEYWGw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2005 18:06:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050525220652.MBOH20235.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 25 May 2005 18:06:52 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vzmujjdq4.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Wed, 25 May 2005 12:40:51 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The earlier test was relying on the fact that dotfiles do not
appear in the output to prepare expected test results, which
inevitably got broken when we started handling dotfiles.  Change
the test to be honest about what "--other" file it creates.

The problem was originally pointed out by Mark Allen.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

t/t3000-ls-files-others.sh |    7 ++++---
1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/t/t3000-ls-files-others.sh b/t/t3000-ls-files-others.sh
--- a/t/t3000-ls-files-others.sh
+++ b/t/t3000-ls-files-others.sh
@@ -20,8 +20,9 @@ mkdir path2
 date >path2/file2
 test_expect_success \
     'git-ls-files --others to show output.' \
-    'git-ls-files --others >.output'
-cat >.expected <<EOF
+    'git-ls-files --others >output'
+cat >expected <<EOF
+output
 path0
 path1
 path2/file2
@@ -29,5 +30,5 @@ EOF
 
 test_expect_success \
     'git-ls-files --others should pick up symlinks.' \
-    'diff .output .expected'
+    'diff output expected'
 test_done
------------------------------------------------

