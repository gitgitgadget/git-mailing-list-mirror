From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] clone: report check out for non-bare clones
Date: Mon, 10 May 2010 16:46:03 +0200
Message-ID: <3521b4733b58bfa516303fafc64d87f05760ea02.1273502583.git.git@drmicha.warpmail.net>
References: <4BE7E09F.3040303@drmicha.warpmail.net>
Cc: Pete Harlan <pgit@pcharlan.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 10 16:46:49 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBUFp-0000lV-DA
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 16:46:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312Ab0EJOqj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 May 2010 10:46:39 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:33109 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751160Ab0EJOqi (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 May 2010 10:46:38 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 10959F538E;
	Mon, 10 May 2010 10:46:11 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Mon, 10 May 2010 10:46:11 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=QLY3fIym12BWI/jnCpBHIdCaSJU=; b=W0fQCkA3p+i7gt1Y92dfK8OHQkLwRl5wim3psvFWyTjX2OTiO50+IMVShUdU4NRp9kqmvrob6XaS/1GzvN7Y5hibfp7hEBYxbXbqNXC2TD0YQqgZNHjI8OwmPufdzX0ScVfTtPHKBB65ctMXpv7uWaypdC7szFnY9PoRzwewj1o=
X-Sasl-enc: RnH0kno9O/qL8F3lc8K8CgXPaZH08bHwWrW0VtG2NZPY 1273502759
Received: from localhost (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 00E724DCF35;
	Mon, 10 May 2010 10:45:58 -0400 (EDT)
X-Mailer: git-send-email 1.7.1.240.geeaa4d
In-Reply-To: <4BE7E09F.3040303@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146817>

git clone reports $GIT_DIR as the destination of a clone operation,
which is correct but possibly confusing for new users cloning into
non-bare repositories.

Thus, report additionally the check out process as

checking out branch $branchname into worktree $worktree

which has the additional benefit of confirming the checked out branch
(as specified by -b, defaulting to master).

In the case of a detached head, (null) is the branch name.

Inspired-by: Pete Harlan <pgit@pcharlan.com>
Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
I mean something like this. Noobs won't use --no-checkout so that a
check out message should help all possibly confused users.

 builtin/clone.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 4457922..38ca5e8 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -629,6 +629,11 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		struct tree_desc t;
 		int fd;
 
+		if (0 <= option_verbosity)
+			printf("Checking out branch %s into worktree %s.\n",
+				skip_prefix(our_head_points_at->name, "refs/heads/"),
+				work_tree);
+
 		/* We need to be in the new work tree for the checkout */
 		setup_work_tree();
 
-- 
1.7.1.240.geeaa4d
