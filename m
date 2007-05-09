From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH] checkout: allow full refnames for local branches
Date: Wed,  9 May 2007 10:40:03 +0200
Message-ID: <11787000032830-git-send-email-hjemli@gmail.com>
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 09 10:38:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hlhgk-0003Br-5o
	for gcvg-git@gmane.org; Wed, 09 May 2007 10:38:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752979AbXEIIiQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 04:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752929AbXEIIiQ
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 04:38:16 -0400
Received: from mail45.e.nsc.no ([193.213.115.45]:40879 "EHLO mail45.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752062AbXEIIiP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 04:38:15 -0400
Received: from localhost.localdomain (ti231210a080-10429.bb.online.no [80.212.184.195])
	by mail45.nsc.no (8.13.8/8.13.5) with ESMTP id l498c8ba008944;
	Wed, 9 May 2007 10:38:09 +0200 (CEST)
X-Mailer: git-send-email 1.5.2.rc2.21.g3082a
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46680>

This teaches git-checkout to strip the prefix 'refs/heads/' from the
supplied <branch> argument, to make

	git-checkout refs/heads/master

behave like

	git-checkout master

The former command would detach HEAD.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---

I'm undecided on wheter this is a bugfix or a new feature. It certainly
introduces new behaviour, but it passes all the tests.

 git-checkout.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-checkout.sh b/git-checkout.sh
index ed7c2c5..6ff7b6e 100755
--- a/git-checkout.sh
+++ b/git-checkout.sh
@@ -63,6 +63,7 @@ while [ "$#" != "0" ]; do
 				echo "unknown flag $arg"
 				exit 1
 			fi
+			arg=$(echo "$arg" | sed -e "s|^refs/heads/||")
 			new="$rev"
 			new_name="$arg"
 			if git-show-ref --verify --quiet -- "refs/heads/$arg"
-- 
1.5.2.rc2.21.g3082a
