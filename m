From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH/WIP 0/6] Detached HEADs in new worktrees considered harmful
Date: Fri, 26 Feb 2016 17:39:40 +0100
Message-ID: <cover.1456504190.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 26 17:40:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZLRT-0001M5-AI
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 17:40:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933301AbcBZQk2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 11:40:28 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:50731 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754493AbcBZQjt (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Feb 2016 11:39:49 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 3D02820CA9
	for <git@vger.kernel.org>; Fri, 26 Feb 2016 11:39:48 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute3.internal (MEProxy); Fri, 26 Feb 2016 11:39:48 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=
	date:from:message-id:subject:to:x-sasl-enc:x-sasl-enc; s=mesmtp;
	 bh=ktzQrB0xEywSRWmLraAdBOaXN88=; b=YUsz0Xcu/iOf7fLa4zWi9zCt2IBl
	+m+glboqs/EiE1LQiglNOxbx38rpMtKdC8vB8u7QwaeVlQN/mWzmX+R7Dr9ZL/TS
	cFIfXSC7tAYQy0d47/dcPN0r5L80jnuXV198SYwimbt9SFRLnw8JATF0JthAyJFA
	g0XywLpLpF2iKtI=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=date:from:message-id:subject:to
	:x-sasl-enc:x-sasl-enc; s=smtpout; bh=ktzQrB0xEywSRWmLraAdBOaXN8
	8=; b=ojDfH9zZWBvN6oeyHm3a8hbRYpsMcgYKEMhkMVz62570BEbMtf/4R0sJmn
	0EM+O9XSPBM2k4kPqxZqFsBuCU6kuDQiFFAFOirBCVRZqpwS8GD1dkvVe/jiAO5k
	SyUh4apEqyUTrG6+sqWhoUltcT4Gm357ZsNFqfww5ZLxYbQdo=
X-Sasl-enc: quCQYwwEboVrJFMF22upPjhwBJDfyzcdUGcdbLRzx8kk 1456504787
Received: from localhost (skimbleshanks.math.uni-hannover.de [130.75.46.4])
	by mail.messagingengine.com (Postfix) with ESMTPA id C8E9EC00018;
	Fri, 26 Feb 2016 11:39:47 -0500 (EST)
X-Mailer: git-send-email 2.7.2.618.g7a61b68
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287588>

Before someone loses their HEAD I should put this series out (again).

1/6 is a tiny documentation fix.

2/6 demonstrates that "git prune" in the main worktree loses HEADs in other
worktrees, and vice versa.

In fact, one should rethink the meaning of "git rev-list --all" in the context
of per-worktree refs such as HEAD.

3/6 is a possible fix (making "--all" mean "all refs in all worktrees") but may
be too intrusive.

4/6, 5/6, 6/6 are some WIP patches about making 3/6 less intrusive and fixing
some cases where do_head_ref_worktrees() has problems that do_head_ref() doesn't
have.

Michael J Gruber (6):
  Documentation/git-worktree: spell --detach correctly
  t6014: test prune with detached HEADs in separate worktrees
  rev-list: list all heads with --all
  WIP: mess only with mark_reachable
  fix unborn branch case
  revisions: list all worktree HEADs with --all

 Documentation/git-worktree.txt     |  2 +-
 Documentation/rev-list-options.txt |  2 +-
 reachable.c                        |  2 +-
 refs.h                             |  1 +
 refs/files-backend.c               | 34 +++++++++++++++++++++++++++++++++-
 t/t6014-rev-list-all.sh            | 25 +++++++++++++++++++++++++
 6 files changed, 62 insertions(+), 4 deletions(-)

-- 
2.7.2.618.g7a61b68
