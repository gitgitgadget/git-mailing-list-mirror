From: maximilian attems <max@stro.at>
Subject: [PATCH] am: pass exclude down to apply
Date: Wed,  3 Aug 2011 11:37:29 +0200
Message-ID: <1312364249-1439-1-git-send-email-max@stro.at>
Cc: Junio C Hamano <gitster@pobox.com>, maximilian attems <max@stro.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 03 11:36:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoXsn-0003kz-S7
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 11:36:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753665Ab1HCJgy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Aug 2011 05:36:54 -0400
Received: from vostochny.stro.at ([78.47.22.85]:43634 "EHLO vostochny.stro.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753547Ab1HCJgw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 05:36:52 -0400
Received: from stro.at (cp6.itp.tuwien.ac.at [128.131.48.206])
	by vostochny.stro.at (Postfix) with ESMTPA id 8D9D3C14C;
	Wed,  3 Aug 2011 09:36:51 +0000 (UTC)
Received: by stro.at (Postfix, from userid 1000)
	id CA1A1161A93; Wed,  3 Aug 2011 11:37:41 +0200 (CEST)
X-Mailer: git-send-email 1.7.5.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178552>

This allows to pass patches around from repositories,
where the other repository doesn't feature certain files.

In the special case this works for dash git sync to klibc dash:
 git am --directory="usr/dash" --exclude="usr/dash/configure.ac" \
        --exclude="usr/dash/ChangeLog" --exclude="usr/dash/dash.1" \
	.. -i -s -k ../dash/000X-foo.patch

Signed-off-by: maximilian attems <max@stro.at>
---
 git-am.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

This is a resent, haven't a test for this usecase,
but it is useful and simple enough, so reposted.

diff --git a/git-am.sh b/git-am.sh
index 463c741..8d185aa 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -22,6 +22,7 @@ whitespace=     pass it through git-apply
 ignore-space-change pass it through git-apply
 ignore-whitespace pass it through git-apply
 directory=      pass it through git-apply
+exclude=        pass it through git-apply
 C=              pass it through git-apply
 p=              pass it through git-apply
 patch-format=   format the patch(es) are in
@@ -366,7 +367,7 @@ do
 		;;
 	--resolvemsg)
 		shift; resolvemsg=$1 ;;
-	--whitespace|--directory)
+	--whitespace|--directory|--exclude)
 		git_apply_opt="$git_apply_opt $(sq "$1=$2")"; shift ;;
 	-C|-p)
 		git_apply_opt="$git_apply_opt $(sq "$1$2")"; shift ;;
-- 
1.7.5.4
