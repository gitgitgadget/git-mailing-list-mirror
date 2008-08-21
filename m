From: Paolo Bonzini <bonzini@gnu.org>
Subject: [PATCH] provide more errors for the "merge into empty head" case
Date: Thu, 21 Aug 2008 14:14:18 +0200
Message-ID: <E1KW9N5-0003mA-CB@fencepost.gnu.org>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 21 14:37:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KW9PT-0001kE-Pr
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 14:37:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751715AbYHUMf6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 08:35:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751718AbYHUMf6
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 08:35:58 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:56017 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751611AbYHUMf5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 08:35:57 -0400
Received: from bonzini by fencepost.gnu.org with local (Exim 4.67)
	(envelope-from <bonzini@gnu.org>)
	id 1KW9N5-0003mA-CB
	for git@vger.kernel.org; Thu, 21 Aug 2008 08:34:35 -0400
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93142>

--squash merges are not supported yet.  They could be implemented
by building the index from the merged-from branch, and doing a
single commit.

Non-fast-forward merges instead do not make sense, because you
cannot make a merge commit if you don't have a base in the
beginning.

Signed-off-by: Paolo Bonzini <bonzini@gnu.org>
---
 builtin-merge.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/builtin-merge.c b/builtin-merge.c
index b4c7eda..a3b9b10 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -869,6 +869,11 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		if (argc != 1)
 			die("Can merge only exactly one commit into "
 				"empty head");
+		if (squash)
+			die("Squash commit into empty head not supported yet");
+		if (!allow_fast_forward)
+			die("Non-fast-forward commit does not make sense into "
+			    "an empty head");
 		remote_head = peel_to_type(argv[0], 0, NULL, OBJ_COMMIT);
 		if (!remote_head)
 			die("%s - not something we can merge", argv[0]);
-- 
1.5.5
