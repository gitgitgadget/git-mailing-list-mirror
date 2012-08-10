From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2] rebase -i: use full onto sha1 in reflog
Date: Fri, 10 Aug 2012 08:51:19 +0200
Message-ID: <54180665e1207275db9694cd68f49ff96812284e.1344581316.git.git@drmicha.warpmail.net>
References: <7vwr18nehe.fsf@alter.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>, martin.von.zweigbergk@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 10 08:51:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Szj4D-0002Yd-Cg
	for gcvg-git-2@plane.gmane.org; Fri, 10 Aug 2012 08:51:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753460Ab2HJGvX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Aug 2012 02:51:23 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:32945 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754564Ab2HJGvW (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Aug 2012 02:51:22 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 22DF42043E;
	Fri, 10 Aug 2012 02:51:21 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute1.internal (MEProxy); Fri, 10 Aug 2012 02:51:21 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references; s=smtpout; bh=g6jOdjOLjlzLO6Hg0SeT18T/M
	GM=; b=I7fGmSGKL7iWtzDig3nQ50q4Wep/VCFcRkQAf3uJH65cjr4sKCBW1FMM7
	QJqgwre9yyK9Cmha2SVLSA1MA7yqBtaXtG90I77H4qbsFjlIln9XLfgeU+eLVec7
	i4fdqCyqAeDsuQjMlyhQah+sJHhDRNiDovzN1f1vF16V7pFtIc=
X-Sasl-enc: 0Dw8gTKIwrS1nRRxMPsLZ+YvLFeu/LvCfkEtBxBXL9Zq 1344581480
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id A7FE2483517;
	Fri, 10 Aug 2012 02:51:20 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.rc2.245.g4f94e02
In-Reply-To: <7vwr18nehe.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203202>

'git rebase' uses the full onto sha1 for the reflog message whereas 'git
rebase -i' uses the short sha1. This is not only inconsistent, but can
lead to problems when the reflog is inspected at a later time at which
that abbreviation may have become ambiguous.

Make 'rebase -i' use the full onto sha1, as well.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
So, this is without the now superfluous shortonto definition.

The other place where shortonto is defined is still needed.

 git-rebase--interactive.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 0d2056f..a09e842 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -569,11 +569,10 @@ do_next () {
 	test -s "$todo" && return
 
 	comment_for_reflog finish &&
-	shortonto=$(git rev-parse --short $onto) &&
 	newhead=$(git rev-parse HEAD) &&
 	case $head_name in
 	refs/*)
-		message="$GIT_REFLOG_ACTION: $head_name onto $shortonto" &&
+		message="$GIT_REFLOG_ACTION: $head_name onto $onto" &&
 		git update-ref -m "$message" $head_name $newhead $orig_head &&
 		git symbolic-ref \
 		  -m "$GIT_REFLOG_ACTION: returning to $head_name" \
-- 
1.7.12.rc2.245.g4f94e02
