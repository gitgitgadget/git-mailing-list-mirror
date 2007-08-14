From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] diff: squelch empty diffs even more
Date: Tue, 14 Aug 2007 23:09:57 +0200
Message-ID: <46C21A25.2040304@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Aug 14 23:10:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IL3ew-00024q-1c
	for gcvg-git@gmane.org; Tue, 14 Aug 2007 23:10:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933315AbXHNVKT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Aug 2007 17:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933251AbXHNVKR
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Aug 2007 17:10:17 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:41044
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933015AbXHNVKP (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Aug 2007 17:10:15 -0400
Received: from [10.0.1.201] (p508ED78A.dip.t-dialin.net [80.142.215.138])
	by neapel230.server4you.de (Postfix) with ESMTP id 085F48B008;
	Tue, 14 Aug 2007 23:10:10 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55857>

When we compare two non-tracked files or explicitly specify
--no-index then the suggestion to run git-status is not helpful.
max_count is set to -2 in these cases; don't print the warning
then.

Signed-off-by: Rene Scharfe <rene.scharfe@lsfire.ath.cx>
---

 builtin-diff.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin-diff.c b/builtin-diff.c
index 6ed7b68..b2fd8c8 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -346,8 +346,8 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 	if (rev.diffopt.exit_with_status)
 		result = rev.diffopt.has_changes;
 
-	if ((rev.diffopt.output_format & DIFF_FORMAT_PATCH)
-	    && (1 < rev.diffopt.skip_stat_unmatch))
+	if ((rev.diffopt.output_format & DIFF_FORMAT_PATCH) &&
+	    1 < rev.diffopt.skip_stat_unmatch && rev.max_count != -2)
 		printf("Warning: %d path%s touched but unmodified. "
 		       "Consider running git-status.\n",
 		       rev.diffopt.skip_stat_unmatch - 1,
