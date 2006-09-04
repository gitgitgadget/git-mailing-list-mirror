From: Martin Langhoff <martin@catalyst.net.nz>
Subject: [PATCH] git-repack: clear out tmp packfiles from $PACKDIR instead of cwd
Date: Mon,  4 Sep 2006 17:42:16 +1200
Message-ID: <11573485362686-git-send-email-martin@catalyst.net.nz>
Cc: Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Mon Sep 04 07:42:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GK7Dw-0000hf-BM
	for gcvg-git@gmane.org; Mon, 04 Sep 2006 07:42:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932312AbWIDFmR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Sep 2006 01:42:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932315AbWIDFmR
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Sep 2006 01:42:17 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:23773 "EHLO
	mail1.catalyst.net.nz") by vger.kernel.org with ESMTP
	id S932312AbWIDFmQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Sep 2006 01:42:16 -0400
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=localhost.localdomain)
	by mail1.catalyst.net.nz with esmtp (Exim 4.50)
	id 1GK7Dq-0005VE-8a; Mon, 04 Sep 2006 17:42:14 +1200
To: git@vger.kernel.org, junkio@cox.net
X-Mailer: git-send-email 1.4.2.gdfe7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26398>

Temp packfiles should never be created in cwd anyway ;-)

Signed-off-by: Martin Langhoff <martin@catalyst.net.nz>
---
 git-repack.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-repack.sh b/git-repack.sh
index ccc8e43..eee0d72 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -24,8 +24,9 @@ do
 	shift
 done
 
-rm -f .tmp-pack-*
 PACKDIR="$GIT_OBJECT_DIRECTORY/pack"
+mkdir -p "$PACKDIR" || exit
+rm -f "$PACKDIR/.tmp-pack-*"
 
 # There will be more repacking strategies to come...
 case ",$all_into_one," in
@@ -43,7 +44,6 @@ case ",$all_into_one," in
 	;;
 esac
 
-mkdir -p "$PACKDIR" || exit
 pack_objects="$pack_objects $local $quiet $no_reuse_delta$extra"
 name=$( { git-rev-list --objects --all $rev_list ||
 	  echo "git-rev-list died with exit code $?"
-- 
1.4.2.gdfe7


-- 
VGER BF report: U 0.983488
