From: Lars Hjemli <hjemli@gmail.com>
Subject: Intoducing the .git file (again)
Date: Sun, 17 Feb 2008 23:14:11 +0100
Message-ID: <1203286456-26033-1-git-send-email-hjemli@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 17 23:17:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQroe-0004NO-Ug
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 23:16:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753816AbYBQWQV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 17:16:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753821AbYBQWQU
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 17:16:20 -0500
Received: from mail49.e.nsc.no ([193.213.115.49]:36794 "EHLO mail49.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753792AbYBQWQS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 17:16:18 -0500
Received: from localhost.localdomain (ti231210a341-0179.bb.online.no [88.88.168.179])
	by mail49.nsc.no (8.13.8/8.13.5) with ESMTP id m1HMFTko007281;
	Sun, 17 Feb 2008 23:15:29 +0100 (MET)
X-Mailer: git-send-email 1.5.4.1.188.gfde78
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74194>

These patches enables .git to be a textfile containing the path to the git
directory proper. It passes all the tests so hopefully there are no
regressions, but there may be bugs and omissions lurking when this feature
is actually used; I've exercised it in my git, cgit and dayjob repos but git
is big and has many codepaths so I wouldn't be suprised if there still are
some git commands left which fails to obey the .git file.

PS: These patches could certainly be squashed into a single patch, but I've
left them as is to make each one easier to review.

PPS: If included, the .git file should probably be used by git-submodule to
clone submodule repositories into something like $GIT_DIR/submodules/<name>,
as that would make local submodule changes more resistant to dataloss due to
checkout/reset in the containing repository.

Shortlog:
 Add platform-independent .git "symlink"
 Fix setup of $GIT_DIR in git-sh-setup.sh
 Teach resolve_gitlink_ref() about the .git file
 git-submodule: prepare for the .git-file
 Teach GIT-VERSION-GEN about the .git file

Diffstat:
 Documentation/repository-layout.txt |    5 ++-
 GIT-VERSION-GEN                     |    2 +-
 cache.h                             |    1 +
 environment.c                       |   38 ++++++++++++++++++
 git-sh-setup.sh                     |   12 ++---
 git-submodule.sh                    |    4 +-
 refs.c                              |   17 +++++++-
 setup.c                             |    9 ++++
 t/t0002-gitfile.sh                  |   74 +++++++++++++++++++++++++++++++++++
 9 files changed, 148 insertions(+), 14 deletions(-)
