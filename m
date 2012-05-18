From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH] Fix t3411.3 to actually rebase something
Date: Fri, 18 May 2012 15:48:53 +0200
Message-ID: <4FB65345.3090201@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Stephen Haberman <stephen@exigencecorp.com>
X-From: git-owner@vger.kernel.org Fri May 18 15:49:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVNYT-00017m-W0
	for gcvg-git-2@plane.gmane.org; Fri, 18 May 2012 15:49:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933730Ab2ERNs7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 May 2012 09:48:59 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:30413 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933714Ab2ERNs6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2012 09:48:58 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 9077510016;
	Fri, 18 May 2012 15:44:30 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 6274119F6E5;
	Fri, 18 May 2012 15:48:54 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120421 Thunderbird/12.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197955>

The test intends to rebase a branchy history onto a later commit, but it
forgot to reset HEAD back to an earlier commit before it set up the side
branches. In the end, every "rebased" commit was only a fast-forward and
the 'rebase -p' did not change the commit graph at all. Insert the missing
checkout that moves to an earlier commit.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 Noticed while I was working on replacing 'git merge' by 'git
 cherry-pick' in the rebase -p code path.

 t/t3411-rebase-preserve-around-merges.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t3411-rebase-preserve-around-merges.sh
b/t/t3411-rebase-preserve-around-merges.sh
index ace8e54..dc81bf2 100755
--- a/t/t3411-rebase-preserve-around-merges.sh
+++ b/t/t3411-rebase-preserve-around-merges.sh
@@ -56,6 +56,7 @@ test_expect_success 'squash F1 into D1' '
 # And rebase G1..M1 onto E2

 test_expect_success 'rebase two levels of merge' '
+	git checkout A1 &&
 	test_commit G1 &&
 	test_commit H1 &&
 	test_commit I1 &&
-- 
1.7.10.2.529.g0c18cfd
