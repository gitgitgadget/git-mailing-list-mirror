From: Brian Gernhardt <benji@silverinsanity.com>
Subject: [PATCH 2/2] Fix t3404 assumption that `wc -l` does not use
	whitespace.
Date: Sun, 27 Apr 2008 11:16:10 -0400
Message-ID: <20080427151610.GB57955@Hermes.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 27 17:17:08 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jq8cj-0001F8-Ru
	for gcvg-git-2@gmane.org; Sun, 27 Apr 2008 17:17:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754278AbYD0PQN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2008 11:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754023AbYD0PQN
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Apr 2008 11:16:13 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:49589 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753862AbYD0PQM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2008 11:16:12 -0400
Received: from localhost.localdomain (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	by silverinsanity.com (Postfix) with ESMTP id BF0EE1FFD6C4
	for <git@vger.kernel.org>; Sun, 27 Apr 2008 15:16:07 +0000 (UTC)
Received: from Mutt by mutt-smtp-wrapper.pl 1.2  (www.zdo.com/articles/mutt-smtp-wrapper.shtml)
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80450>

t3404-rebase-interactive used `grep -Fx 0` to match against `wc -l`
output.  This fails on OS X and any other system where wc outputs
whitespace.  Use `test 0 = `... instead, like we do in other tests.

Signed-off-by: Brian Gernhardt <benji@silverinsanity.com>
---

 Should this construct go into CodingStyle?  I seem to have to write
 patches like this every month or so.

 t/t3404-rebase-interactive.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index d20ed4f..f204284 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -211,7 +211,7 @@ test_expect_success 'setting marks works' '
 	test "$(git rev-parse HEAD~2)" = \
 		"$(git rev-parse refs/rebase-marks/42)" &&
 	git rebase --abort &&
-	ls $marks_dir | wc -l | grep -Fx 0
+	test 0 = $(ls $marks_dir | wc -l)
 '
 
 test_expect_success 'reset with nonexistent mark fails' '
-- 
1.5.5.1.174.g8f57349
