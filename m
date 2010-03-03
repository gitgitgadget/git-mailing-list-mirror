From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 0/9] add --ff option to cherry-pick
Date: Wed, 03 Mar 2010 21:11:35 +0100
Message-ID: <20100303201046.23506.32653.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Paolo Bonzini <bonzini@gnu.org>,
	Stephen Boyd <bebarino@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 04 03:05:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nn0Rm-0008HT-Nf
	for gcvg-git-2@lo.gmane.org; Thu, 04 Mar 2010 03:05:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755651Ab0CDCF0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Mar 2010 21:05:26 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:40515 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754833Ab0CDCFS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Mar 2010 21:05:18 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 1AEF6818083;
	Thu,  4 Mar 2010 03:05:07 +0100 (CET)
Received: from style.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 8B0AC818064;
	Thu,  4 Mar 2010 03:05:04 +0100 (CET)
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141500>

The goal of this patch series is to make it possible for "git cherry-pick"
to fast forward instead of creating a new commit if the cherry picked commit
has the same parent as the one we are cherry-picking on.

The change since the previous series is that there is less refactoring
of builtin/revert.c before introducing the --ff option, so less code churn.
This also means that this series should be easier to merge.

Christian Couder (9):
  reset: refactor updating heads into a static function
  reset: refactor reseting in its own function
  reset: make reset function non static and declare it in "reset.h"
  revert: refactor checking parent in a check_parent() function
  revert: add --ff option to allow fast forward when cherry-picking
  cherry-pick: add tests for new --ff option
  Documentation: describe new cherry-pick --ff option
  cherry-pick: add a no-op --no-ff option to future proof scripts
  rebase -i: use new --ff cherry-pick option

 Documentation/git-cherry-pick.txt |   10 ++-
 builtin/reset.c                   |  178 ++++++++++++++++++++-----------------
 builtin/revert.c                  |   91 ++++++++++++-------
 git-rebase--interactive.sh        |   15 +---
 reset.h                           |   10 ++
 t/t3506-cherry-pick-ff.sh         |  106 ++++++++++++++++++++++
 6 files changed, 282 insertions(+), 128 deletions(-)
 create mode 100644 reset.h
 create mode 100755 t/t3506-cherry-pick-ff.sh
