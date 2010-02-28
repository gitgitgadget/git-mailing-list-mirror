From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 00/12] add --ff option to cherry-pick
Date: Sun, 28 Feb 2010 23:21:55 +0100
Message-ID: <20100228222038.2260.25016.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Paolo Bonzini <bonzini@gnu.org>,
	Stephen Boyd <bebarino@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 28 23:22:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlrXJ-0006BL-QT
	for gcvg-git-2@lo.gmane.org; Sun, 28 Feb 2010 23:22:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032128Ab0B1WWr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Feb 2010 17:22:47 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:48473 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1032116Ab0B1WWq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Feb 2010 17:22:46 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 071E08180E2;
	Sun, 28 Feb 2010 23:22:37 +0100 (CET)
Received: from style.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id B59AD8180F5;
	Sun, 28 Feb 2010 23:22:33 +0100 (CET)
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141277>

The goal of this patch series is to make it possible for "git cherry-pick"
to fast forward instead of creating a new commit if the cherry picked commit
has the same parent as the one we are cherry-picking on.

Changes since the previous series are the following:

- now --ff should work with merge commits and "-m <parent-num>" option
- added a no-op --no-ff option as request by Paolo
- removed for now the patch that used the new reset() function in
"builtin-merge.c"

Christian Couder (11):
  pick: refactor checking parent in a check_parent function
  pick: make check_parent function extern
  pick: move calling check_parent() ouside pick_commit()
  reset: refactor updating heads into a static function
  reset: refactor reseting in its own function
  reset: make reset function non static and declare it in "reset.h"
  revert: add --ff option to allow fast forward when cherry-picking
  cherry-pick: add tests for new --ff option
  Documentation: describe new cherry-pick --ff option
  cherry-pick: add a no-op --no-ff option to future proof scripts
  rebase -i: use new --ff cherry-pick option

Stephan Beyer (1):
  revert: libify cherry-pick and revert functionnality

 Documentation/git-cherry-pick.txt |   10 +-
 Makefile                          |    2 +
 builtin/reset.c                   |  178 ++++++++++++----------
 builtin/revert.c                  |  308 ++++++++++---------------------------
 git-rebase--interactive.sh        |   15 +--
 pick.c                            |  223 +++++++++++++++++++++++++++
 pick.h                            |   14 ++
 reset.h                           |   10 ++
 t/t3506-cherry-pick-ff.sh         |  106 +++++++++++++
 9 files changed, 545 insertions(+), 321 deletions(-)
 create mode 100644 pick.c
 create mode 100644 pick.h
 create mode 100644 reset.h
 create mode 100755 t/t3506-cherry-pick-ff.sh
