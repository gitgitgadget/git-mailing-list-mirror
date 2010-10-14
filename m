From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH v6 0/5] Detection of directory renames
Date: Fri, 15 Oct 2010 01:29:54 +0200
Message-ID: <1287098999-9244-1-git-send-email-ydirson@altern.org>
Cc: Yann Dirson <ydirson@altern.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 15 01:20:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6X5j-00046c-OF
	for gcvg-git-2@lo.gmane.org; Fri, 15 Oct 2010 01:20:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755885Ab0JNXTN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Oct 2010 19:19:13 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:40412 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754947Ab0JNXTK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Oct 2010 19:19:10 -0400
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id D8F61D48044;
	Fri, 15 Oct 2010 01:19:04 +0200 (CEST)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1P6XFJ-0002Pu-OA; Fri, 15 Oct 2010 01:30:01 +0200
X-Mailer: git-send-email 1.7.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159081>

Changes since v5:

* added more tests (one OK, one for suboptimal work only, one for a
  bug fixed)
* adjusted expected output for 'diff-index --detect-bulk-moves on a
  move including a subdir.', it is OK
* include a better copy_dirname based on Johnathan's code
* dropped the "Transfer special display of toplevel dir to display-time."
  patch posted earlier, I really think that was a bad idea.
* include 2 more patches that deal with problems with moves of deep trees,
  separated for easier review, but which should be squashed into the main
  one ultimately

Only relatively easy things are still on my immediate TODO list for
this series:

* unified diff informational output
* memrchr() implementation for portability
* cleanups (free allocated structures, split long funcs a bit more, better
  comments, etc)
* audit remaining FIXME tags

Finishing the "--hide" feature will be next.

Yann Dirson (5):
  Introduce bulk-move detection in diffcore.
  Add testcases for the --detect-bulk-moves diffcore flag.
  [RFC] Handle the simpler case of a subdir invalidating bulk move.
  [RFC] Consider all parents of a file as candidates for bulk rename.
  [WIP] Allow hiding renames of individual files involved in a
    directory rename.

 diff-lib.c                       |    6 +-
 diff.c                           |   21 ++-
 diff.h                           |    6 +
 diffcore-rename.c                |  376 +++++++++++++++++++++++++++++++++++++-
 diffcore.h                       |    2 +
 t/t4046-diff-rename-factorize.sh |  301 ++++++++++++++++++++++++++++++
 tree-diff.c                      |    4 +-
 7 files changed, 703 insertions(+), 13 deletions(-)
 create mode 100755 t/t4046-diff-rename-factorize.sh

-- 
1.7.2.3
