From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: [PATCH] git-remote-hg: Fix . at end of ref
Date: Fri, 21 Jun 2013 12:12:38 -0400
Message-ID: <1371831158-9720-1-git-send-email-brian@gernhardtsoftware.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 21 18:12:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uq3xG-0004Q7-8H
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 18:12:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423043Ab3FUQMu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jun 2013 12:12:50 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:52484 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422821Ab3FUQMt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jun 2013 12:12:49 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 86FCF2736194; Fri, 21 Jun 2013 16:12:48 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.5 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from localhost.localdomain (cpe-142-105-190-134.rochester.res.rr.com [142.105.190.134])
	by silverinsanity.com (Postfix) with ESMTPA id 52884273617B;
	Fri, 21 Jun 2013 16:12:47 +0000 (UTC)
X-Mailer: git-send-email 1.8.3.1.636.g893104c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228625>

Any Mercurial tag/branch/bookmark that ended with a period would be
rejected by fast-import.  The repository could be cloned, but any
further fetch would fail.

Use a similar trick to the space handling, but only when the period is
at the end of the ref.

Probably need a more general solution to this problem.

Signed-off-by: Brian Gernhardt <brian@gernhardtsoftware.com>
---
 contrib/remote-helpers/git-remote-hg | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 0194c67..7fa6cd7 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -78,9 +78,11 @@ def hgbin(n):
     return node.bin(n)
 
 def hgref(ref):
+    ref = re.sub('_\._$', '.', ref)
     return ref.replace('___', ' ')
 
 def gitref(ref):
+    ref = re.sub('\.$', '_._', ref)
     return ref.replace(' ', '___')
 
 def check_version(*check):
-- 
1.8.3.1.636.g893104c
