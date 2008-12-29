From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 0/3] rebase --root
Date: Mon, 29 Dec 2008 17:45:44 +0100
Message-ID: <cover.1230568082.git.trast@student.ethz.ch>
Cc: Junio C Hamano <junio@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 29 17:47:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHLGy-00063I-A4
	for gcvg-git-2@gmane.org; Mon, 29 Dec 2008 17:47:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751925AbYL2Qpz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2008 11:45:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751794AbYL2Qpy
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Dec 2008 11:45:54 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:1411 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751756AbYL2Qpy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2008 11:45:54 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 29 Dec 2008 17:45:52 +0100
Received: from localhost.localdomain ([77.56.223.244]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 29 Dec 2008 17:45:52 +0100
X-Mailer: git-send-email 1.6.1.1.g4c1d9.dirty
X-OriginalArrivalTime: 29 Dec 2008 16:45:52.0286 (UTC) FILETIME=[E92E03E0:01C969D4]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104112>

Inspired by f95ebf7 (Allow cherry-picking root commits, 2008-07-04),
this teaches git rebase to rebase everything up to the root commit(s).

The main use-case for this is if you hack on new history, then later
notice that you want to unroll the commits "on" a git-svn branch to
dcommit them separately.  (If you just want to squash them, a merge
will do fine.)

Note that --root (in both modes) requires --onto; you cannot rebase
"onto nothing" to edit the root commit.  Such an option --onto-nothing
might be a worthwile feature however, since it would also allow
"detaching" a set of commits from their parent history.

BTW, while hacking this I noticed that there are two different tests
t3409:

  t3409-rebase-hook.sh
  t3409-rebase-preserve-merges.sh

Is this okay, or should one of them be renamed?


Thomas Rast (3):
  rebase: learn to rebase root commit
  rebase -i: learn to rebase root commit
  rebase: update documentation for --root

 Documentation/git-rebase.txt |   17 +++++++---
 git-rebase--interactive.sh   |   53 +++++++++++++++++++++++++--------
 git-rebase.sh                |   51 ++++++++++++++++++++++----------
 t/t3412-rebase-root.sh       |   66 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 153 insertions(+), 34 deletions(-)
 create mode 100755 t/t3412-rebase-root.sh
