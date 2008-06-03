From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Fix t5516 on cygwin: it does not like double slashes at
	the beginning of a path
Date: Wed, 4 Jun 2008 00:16:26 +0200
Message-ID: <20080603221626.GA8081@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 04 00:17:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3eok-0005sI-Hf
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 00:17:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752890AbYFCWQa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2008 18:16:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752780AbYFCWQ3
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 18:16:29 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:50123 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752079AbYFCWQ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 18:16:29 -0400
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gYkBuibEUndJ36PWMnarZw4lfeqw==
Received: from tigra.home (Faead.f.strato-dslnet.de [195.4.174.173])
	by post.webmailer.de (klopstock mo11) (RZmta 16.38)
	with ESMTP id 00149dk53LLvgU ; Wed, 4 Jun 2008 00:16:27 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 2B33A277BD;
	Wed,  4 Jun 2008 00:16:27 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id BC25956D28; Wed,  4 Jun 2008 00:16:26 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83718>

The double slashes "//" result from url./$TRASH/. expansion and the
current directory, which even in cygwin contains "/" as first
character. In cygwin such strings have special meaning: UNC path.
Accessing an UNC path built for test purpose usually fails.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
 t/t5516-fetch-push.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index c5c5933..6805032 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -146,7 +146,7 @@ test_expect_success 'push with wildcard' '
 test_expect_success 'push with insteadOf' '
 	mk_empty &&
 	TRASH="$(pwd)/" &&
-	git config "url./$TRASH/.insteadOf" trash/ &&
+	git config "url.$TRASH.insteadOf" trash/ &&
 	git push trash/testrepo refs/heads/master:refs/remotes/origin/master &&
 	(
 		cd testrepo &&
-- 
1.5.6.rc0.112.g62868
