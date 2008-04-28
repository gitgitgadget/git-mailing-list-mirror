From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH] rebase--interactive: Replace unportable 'tac' by a sed script.
Date: Mon, 28 Apr 2008 09:44:48 +0200
Message-ID: <48158070.7090007@viscovery.net>
References: <8D73338C-4EC3-4078-8A34-51DAC1842C2B@silverinsanity.com> <20080427064250.GA5455@sigill.intra.peff.net> <739FA851-F7F5-4CF9-B384-25AA7022B0C2@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git list <git@vger.kernel.org>
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Mon Apr 28 09:45:49 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqO3X-0008Vq-P2
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 09:45:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763654AbYD1Ho6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 03:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763346AbYD1Ho6
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 03:44:58 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:63931 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763632AbYD1Ho5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 03:44:57 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JqO2a-0005XE-Tv; Mon, 28 Apr 2008 09:44:51 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id A9A726C4; Mon, 28 Apr 2008 09:44:48 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <739FA851-F7F5-4CF9-B384-25AA7022B0C2@silverinsanity.com>
X-Spam-Score: 0.2 (/)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_80=2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80507>

From: Johannes Sixt <johannes.sixt@telecom.at>

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
Brian Gernhardt schrieb:
> -    tac | \
> +    perl -e 'print reverse <>' | \

Here's my try, which avoids the perl hammer. ;)

Sorry, I can't test this at the moment due to an unrelated breakage
that I first have to chase down.

-- Hannes

PS: I picked the sed script from this patch by Simon 'corecode' Schubert:

http://article.gmane.org/gmane.comp.version-control.git/37074

 git-rebase--interactive.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 1751b08..a9ac332 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -469,7 +469,7 @@ create_extended_todo_list () {
 	test -n "${last_parent:-}" -a "${last_parent:-}" != $SHORTUPSTREAM && \
 		echo reset $last_parent
 	) | \
-	tac | \
+	sed -ne '1!G;$p;h' | \
 	while read cmd args
 	do
 		: ${commit_mark_list:=} ${last_commit:=000}
-- 
1.5.5.1.930.g66f94.dirty
