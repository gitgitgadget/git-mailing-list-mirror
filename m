From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 3/3] git-read-tree.txt: correct sparse-checkout and skip-worktree description
Date: Wed, 21 Sep 2011 09:48:38 +0200
Message-ID: <31152a2ddb83e37be1efce1d0cd742b71ea3efdd.1316590874.git.git@drmicha.warpmail.net>
References: <4E7996AA.4040909@drmicha.warpmail.net>
Cc: Joshua Jensen <jjensen@workspacewhiz.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 21 09:48:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6HY6-0000EA-NA
	for gcvg-git-2@lo.gmane.org; Wed, 21 Sep 2011 09:48:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752644Ab1IUHsu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Sep 2011 03:48:50 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:57960 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752640Ab1IUHss (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Sep 2011 03:48:48 -0400
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway2.nyi.mail.srv.osa (Postfix) with ESMTP id 603462930C;
	Wed, 21 Sep 2011 03:48:48 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute4.internal (MEProxy); Wed, 21 Sep 2011 03:48:48 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:in-reply-to:references; s=smtpout; bh=We
	uv5Ps8loCxceC9gpxyX6NOf0k=; b=aTSo46NF07rpBjmIle+4PBaxErqa2e0KUR
	sBgm+9gvqohHJWiWLTOQCipn6sauypL8VNSYcn61GVo6pgtfQwaCOcvTlA63vlj/
	scxuglo9UqF21d1V5Kk1nX8BpBRwvoFe3nHt5I6vgAJZ2HqAKp08FFHTficUWGH6
	YYiwAgHJk=
X-Sasl-enc: XAEYzC6LsbnRajEe+D7G/XtNew+5b8c0a+/o+NGfFotN 1316591327
Received: from localhost (p548594C9.dip0.t-ipconnect.de [84.133.148.201])
	by mail.messagingengine.com (Postfix) with ESMTPSA id BC9717C064A;
	Wed, 21 Sep 2011 03:48:47 -0400 (EDT)
X-Mailer: git-send-email 1.7.7.rc0.469.g9eb94
In-Reply-To: <4E7996AA.4040909@drmicha.warpmail.net>
In-Reply-To: <cover.1316590874.git.git@drmicha.warpmail.net>
References: <cover.1316590874.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181822>

The description of .git/info/sparse-checkout and
skip-worktree is exactly the opposite of what is true, which is:

If a file matches a pattern in sparse-checkout, then (it is to be
checked out and therefore) skip-worktree is unset for that file;
otherwise, it is set (so that it is not checked out).

Currently, the opposite is documented, and (consistently) read-tree's
behavior with respect to bit flips is descibed incorrectly.

Fix it.

In hindsight, it would have been much better to have a "sparse-ignore"
or "sparse-skip" file so that an empty file would mean a full checkout,
and the file logic would be analogous to that of .gitignore, excludes
and skip-worktree.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/git-read-tree.txt |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tree.txt
index 0004f4b..1bd0317 100644
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -389,12 +389,12 @@ directory update. `$GIT_DIR/info/sparse-checkout` is used to
 define the skip-worktree reference bitmap. When 'git read-tree' needs
 to update the working directory, it resets the skip-worktree bit in the index
 based on this file, which uses the same syntax as .gitignore files.
-If an entry matches a pattern in this file, skip-worktree will be
-set on that entry. Otherwise, skip-worktree will be unset.
+If an entry matches a pattern in this file, skip-worktree will not be
+set on that entry. Otherwise, skip-worktree will be set.
 
 Then it compares the new skip-worktree value with the previous one. If
-skip-worktree turns from unset to set, it will add the corresponding
-file back. If it turns from set to unset, that file will be removed.
+skip-worktree turns from set to unset, it will add the corresponding
+file back. If it turns from unset to set, that file will be removed.
 
 While `$GIT_DIR/info/sparse-checkout` is usually used to specify what
 files are in, you can also specify what files are _not_ in, using
-- 
1.7.7.rc0.469.g9eb94
