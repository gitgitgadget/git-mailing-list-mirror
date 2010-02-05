From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 0/9] add --ff option to cherry-pick
Date: Sat, 06 Feb 2010 00:11:02 +0100
Message-ID: <20100205231028.3689.12228.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Paolo Bonzini <bonzini@gnu.org>,
	Stephen Boyd <bebarino@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 06 00:12:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdXLL-00082w-2f
	for gcvg-git-2@lo.gmane.org; Sat, 06 Feb 2010 00:12:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757665Ab0BEXL7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2010 18:11:59 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:53931 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752539Ab0BEXL6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2010 18:11:58 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id AA04781809C;
	Sat,  6 Feb 2010 00:11:49 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 51FFD818057;
	Sat,  6 Feb 2010 00:11:46 +0100 (CET)
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139109>

Changes since the previous series are the following:

- added some tests in a new patch
- added some documentation in a new patch
- added a patch to use the new "reset" function in builtin-merge.c
- made --ff incompatible with --edit -x and --signoff too, thanks to Paolo
- improved the first patch with suggestions from Stephen Boyd, thanks
- made a "struct lock_file" static to initialize it in the first patch
- improved commit messages

Christian Couder (8):
  reset: refactor updating heads into a static function
  reset: refactor reseting in its own function
  reset: make reset function non static and declare it in "reset.h"
  revert: add --ff option to allow fast forward when cherry-picking
  cherry-pick: add tests for new --ff option
  Documentation: describe new cherry-pick --ff option
  rebase -i: use new --ff cherry-pick option
  merge: use new "reset" function instead of running "git read-tree"

Stephan Beyer (1):
  revert: libify cherry-pick and revert functionnality

 Documentation/git-cherry-pick.txt |    6 +-
 Makefile                          |    2 +
 builtin-merge.c                   |   31 ++---
 builtin-reset.c                   |  175 ++++++++++++----------
 builtin-revert.c                  |  303 +++++++++----------------------------
 git-rebase--interactive.sh        |   15 +--
 pick.c                            |  218 ++++++++++++++++++++++++++
 pick.h                            |   13 ++
 reset.h                           |   10 ++
 t/t3506-cherry-pick-ff.sh         |   38 +++++
 10 files changed, 471 insertions(+), 340 deletions(-)
 create mode 100644 pick.c
 create mode 100644 pick.h
 create mode 100644 reset.h
 create mode 100755 t/t3506-cherry-pick-ff.sh
