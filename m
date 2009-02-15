From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 0/8] Support coverage testing with GCC/gcov
Date: Sun, 15 Feb 2009 23:25:37 +0100
Message-ID: <cover.1234736374.git.trast@student.ethz.ch>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 15 23:27:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYpSs-0004VH-Dy
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 23:27:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753346AbZBOWZ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 17:25:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752918AbZBOWZ4
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 17:25:56 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:11608 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752703AbZBOWZz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 17:25:55 -0500
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 15 Feb 2009 23:25:54 +0100
Received: from localhost.localdomain ([77.56.223.244]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 15 Feb 2009 23:25:53 +0100
X-Mailer: git-send-email 1.6.2.rc0.335.g1a2b
X-OriginalArrivalTime: 15 Feb 2009 22:25:53.0819 (UTC) FILETIME=[5D44E6B0:01C98FBC]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110068>

So I found a new toy to play with ;-)

The first patch adds some Makefile rules to automate coverage testing.
This initially resulted in a list of 497 untested functions.  Then I
picked out some easy targets and made patches for them.  This shortens
the list by 20.

Note that the rules currently don't consider any of the
subdirectories.  I'm not sure if arm, ppc, and compat are worth
considering, but it would at least have been nice to support it for
xdiff.  Unfortunately I can't convince the --coverage code to save
results there, so no analysis is possible.  (Running gcc 4.3.2 here.)

BTW, I find it a bit scary that fsck (see 5/8) has so few tests, and
even scarier that out of four simple tests I could come up with it
only passes two.  Let's hope the other two are unreasonable.


Thomas Rast (8):
  Support coverage testing with GCC/gcov
  Test that diff can read from stdin
  Test diff --dirstat functionality
  Test log --graph
  Test fsck a bit harder
  Test log --decorate
  Test rev-list --parents/--children
  Test git-patch-id

 Makefile                                      |   23 ++++
 t/t1450-fsck.sh                               |   65 +++++++++++
 t/t4002-diff-basic.sh                         |    8 ++
 t/t4013-diff-various.sh                       |    5 +
 t/t4013/diff.diff_--dirstat_master~1_master~2 |    3 +
 t/t4013/diff.log_--decorate_--all             |   34 ++++++
 t/t4013/diff.rev-list_--children_HEAD         |    7 +
 t/t4013/diff.rev-list_--parents_HEAD          |    7 +
 t/t4202-log.sh                                |  148 +++++++++++++++++++++++++
 t/t4203-patch-id.sh                           |   38 +++++++
 10 files changed, 338 insertions(+), 0 deletions(-)
 create mode 100644 t/t4013/diff.diff_--dirstat_master~1_master~2
 create mode 100644 t/t4013/diff.log_--decorate_--all
 create mode 100644 t/t4013/diff.rev-list_--children_HEAD
 create mode 100644 t/t4013/diff.rev-list_--parents_HEAD
 create mode 100755 t/t4203-patch-id.sh
