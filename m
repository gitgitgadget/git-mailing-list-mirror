From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH] filter-branch documentation: some more touch-ups.
Date: Wed,  4 Jul 2007 09:32:47 +0200
Message-ID: <1183534367401-git-send-email-johannes.sixt@telecom.at>
References: <20070703220540.GN12721@planck.djpig.de>
Cc: git@vger.kernel.org, gitster@pobox.com,
	Frank Lichtenheld <frank@lichtenheld.de>, j.sixt@eudaptics.com,
	Johannes Sixt <johannes.sixt@telecom.at>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 04 09:33:17 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5zMS-0004p8-Rn
	for gcvg-git@gmane.org; Wed, 04 Jul 2007 09:33:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754570AbXGDHc5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Jul 2007 03:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753359AbXGDHc5
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jul 2007 03:32:57 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:7018 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752805AbXGDHc4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2007 03:32:56 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtp (Exim 4.66)
	(envelope-from <j.sixt@eudaptics.com>)
	id 1I5zM2-0006MQ-SE; Wed, 04 Jul 2007 09:32:51 +0200
Received: from srv.linz.eudaptics (srv.linz.eudaptics [192.168.1.4])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 414106EF; Wed,  4 Jul 2007 09:32:48 +0200 (CEST)
Received: by srv.linz.eudaptics (Postfix, from userid 503)
	id C5853103; Wed,  4 Jul 2007 09:32:47 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.rc0.5.g7cd9
In-Reply-To: <20070703220540.GN12721@planck.djpig.de>
X-Spam-Score: 3.6 (+++)
X-Spam-Report: BAYES_99=3.5, FORGED_RCVD_HELO=0.135
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51574>

- The map function used to fail, but no longer does (since 3520e1e8687.)
- Fix the "edge-graft" example.
- Show the same using .git/info/grafts.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---

I think that "edge-graft" makes more sense than "etch-graft".
Native speakers, please?

I tried the example, and its quoting was incorrect. The reason is that
the shell removes the single quotes even if they are in the middle of
a word; so they didn't end up in the eval'd script and made sed barf.

-- Hannes

 Documentation/git-filter-branch.txt |   20 ++++++++++++++------
 1 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index ee60a1a..528ccc8 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -57,8 +57,9 @@ variables are set before the first filter is run.
 
 A 'map' function is available that takes an "original sha1 id" argument
 and outputs a "rewritten sha1 id" if the commit has been already
-rewritten, fails otherwise; the 'map' function can return several
-ids on separate lines if your commit filter emitted multiple commits.
+rewritten, and "original sha1 id" otherwise; the 'map' function can
+return several ids on separate lines if your commit filter emitted
+multiple commits.
 
 
 OPTIONS
@@ -164,12 +165,12 @@ git filter-branch --index-filter 'git update-index --remove filename' newbranch
 Now, you will get the rewritten history saved in the branch 'newbranch'
 (your current branch is left untouched).
 
-To "etch-graft" a commit to the revision history (set a commit to be
+To "edge-graft" a commit to the revision history (set a commit to be
 the parent of the current initial commit and propagate that):
 
-----------------------------------------------------------------------
-git filter-branch --parent-filter sed\ 's/^$/-p <graft-id>/' newbranch
-----------------------------------------------------------------------
+------------------------------------------------------------------------
+git filter-branch --parent-filter 'sed "s/^\$/-p <graft-id>/"' newbranch
+------------------------------------------------------------------------
 
 (if the parent string is empty - therefore we are dealing with the
 initial commit - add graftcommit as a parent).  Note that this assumes
@@ -181,6 +182,13 @@ git filter-branch --parent-filter \
 	'cat; test $GIT_COMMIT = <commit-id> && echo "-p <graft-id>"' newbranch
 -------------------------------------------------------------------------------
 
+or even simpler:
+
+-----------------------------------------------
+echo "$commit-id $graft-id" >> .git/info/grafts
+git filter-branch newbranch $graft-id..
+-----------------------------------------------
+
 To remove commits authored by "Darl McBribe" from the history:
 
 ------------------------------------------------------------------------------
-- 
1.5.3.rc0.5.g7cd9
