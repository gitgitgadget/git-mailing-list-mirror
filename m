From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] git-submodule: move ill placed shift.
Date: Mon, 21 Jul 2008 20:15:59 +0200
Message-ID: <1216664159-2643-1-git-send-email-madcoder@debian.org>
Cc: gitster@pobox.com, Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 21 20:17:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKzwZ-0003PI-9l
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 20:17:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750951AbYGUSQF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 14:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750733AbYGUSQF
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 14:16:05 -0400
Received: from pan.madism.org ([88.191.52.104]:44616 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751754AbYGUSQC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 14:16:02 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 6332834D72;
	Mon, 21 Jul 2008 20:16:00 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 5B916E55C8; Mon, 21 Jul 2008 20:15:59 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.rc0.138.g5af7f.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89375>

When running git submodule update -i, the "-i" is shifted before recursing
into cmd_init and then again outside of the loop. This causes some /bin/sh
to complain about shifting when there are no arguments left (and would
discard anything written after -i too).

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 git-submodule.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 9228f56..b40f876 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -264,6 +264,7 @@ cmd_update()
 	do
 		case "$1" in
 		-q|--quiet)
+			shift
 			quiet=1
 			;;
 		-i|--init)
@@ -281,7 +282,6 @@ cmd_update()
 			break
 			;;
 		esac
-		shift
 	done
 
 	git ls-files --stage -- "$@" | grep '^160000 ' |
-- 
1.6.0.rc0.138.g5af7f.dirty
