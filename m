From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 1/3] Allow builtin-fetch to work on a detached HEAD
Date: Sun, 16 Sep 2007 02:31:26 -0400
Message-ID: <20070916063126.GA6487@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 16 08:31:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWnfL-0007z9-Dw
	for gcvg-git-2@gmane.org; Sun, 16 Sep 2007 08:31:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751231AbXIPGbc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2007 02:31:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbXIPGbc
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Sep 2007 02:31:32 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:44688 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751181AbXIPGbb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2007 02:31:31 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IWnfD-0005c0-Mg; Sun, 16 Sep 2007 02:31:27 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id EE5BC20FBAE; Sun, 16 Sep 2007 02:31:26 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58298>

If we are running fetch in a repository that has a detached HEAD
then there is no current_branch available.  In such a case any ref
that the fetch might update by definition cannot also be the current
branch so we should always bypass the "don't update HEAD" test.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 builtin-fetch.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/builtin-fetch.c b/builtin-fetch.c
index 300d563..d9272ed 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -151,7 +151,8 @@ static int update_local_ref(struct ref *ref,
 		return 0;
 	}
 
-	if (!strcmp(ref->name, current_branch->name) &&
+	if (current_branch &&
+	    !strcmp(ref->name, current_branch->name) &&
 	    !(update_head_ok || is_bare_repository()) &&
 	    !is_null_sha1(ref->old_sha1)) {
 		/*
-- 
1.5.3.1.1000.g7319b
