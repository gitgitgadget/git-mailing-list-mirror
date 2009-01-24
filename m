From: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
Subject: [PATCH 00/10] Misc. cvsserver, dashless, and test suite patches
Date: Sat, 24 Jan 2009 16:43:11 -0700
Message-ID: <1232840601-24696-1-git-send-email-mmogilvi_git@miniinfo.net>
Cc: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 25 00:45:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQsBY-0006Ei-5C
	for gcvg-git-2@gmane.org; Sun, 25 Jan 2009 00:45:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753500AbZAXXnd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jan 2009 18:43:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752530AbZAXXnb
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jan 2009 18:43:31 -0500
Received: from qmta07.emeryville.ca.mail.comcast.net ([76.96.30.64]:43000 "EHLO
	QMTA07.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752065AbZAXXn3 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Jan 2009 18:43:29 -0500
Received: from OMTA13.emeryville.ca.mail.comcast.net ([76.96.30.52])
	by QMTA07.emeryville.ca.mail.comcast.net with comcast
	id 7RCA1b00917UAYkA7bjUdW; Sat, 24 Jan 2009 23:43:28 +0000
Received: from mmogilvi.homeip.net ([75.70.161.67])
	by OMTA13.emeryville.ca.mail.comcast.net with comcast
	id 7bjT1b00G1TYyYj8ZbjT4L; Sat, 24 Jan 2009 23:43:28 +0000
Received: from localhost.localdomain (bean [192.168.30.96])
	by mmogilvi.homeip.net (Postfix) with ESMTP id 0EA0389114;
	Sat, 24 Jan 2009 16:43:23 -0700 (MST)
X-Mailer: git-send-email 1.6.1.81.g9833d.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107019>

This series of small patches fixes a few minor issues I noticed
while researching what it would take to for cvsserver to support
cvs's "-r" flags properly.  No real progress on the "-r" front,
but see comments in the "cvsserver: add comments about database ..."
email.

The "run test suite without dashed..." patch has wide scope,
even though is is fairly small.  It (along with fixing the things it
found in t2300 and t3409) was inspired by a desire to avoid future
regressions of the bug fixed in "cvsserver: run dashless 'git commands'"
patch, where git-cvsserver was trying to run dashed commands that
are not in the default PATH...

As this patch series was going to press, I noticed that
the "run test suite without dashed..." patch probably conflicts with
recently posted valgrind test suite patches.  See extra comments in
the email for possible resolutions.

The other patches in this series are mostly independent of each other.

When working on the "git-shell" patch, I noticed a couple of other
things related to "git-shell" that maybe ought to be changed (change
the argc==2 special case, and document the best way(s) to
configure an account to use git-shell).  See also extra information in
the email.

--
Matthew Ogilvie   [mmogilvi_git@miniinfo.net]

Matthew Ogilvie (10):
  cvsserver: removed unused sha1Or-k mode from kopts_from_path
  cvsserver: add comments about database schema/usage
  cvsserver: remove unused functions _headrev and gethistory
  git-shell: allow running git-cvsserver, not just cvs
  cvsserver: run dashless "git command"s to access plumbing
  t2300: use documented technique to invoke git-sh-setup
  t3409: use dashless "git commit" instead of "git-commit"
  run test suite without dashed git-commands in PATH
  Revert "adapt git-cvsserver manpage to dash-free syntax"
  cvsserver doc: emphasize using CVS_SERVER= phrase within CVSROOT

 .gitignore                        |    1 +
 Documentation/git-cvsserver.txt   |   29 +++++--
 Documentation/git-shell.txt       |    5 +-
 Makefile                          |   40 +++++++---
 git-cvsserver.perl                |  163 ++++++++++++++++---------------------
 shell.c                           |    1 +
 t/t2300-cd-to-toplevel.sh         |    2 +-
 t/t3409-rebase-preserve-merges.sh |    6 +-
 t/t9400-git-cvsserver-server.sh   |   88 ++++++++++++++++++++
 t/test-lib.sh                     |   14 +++-
 test-bin-wrapper.sh               |   12 +++
 11 files changed, 246 insertions(+), 115 deletions(-)
 create mode 100644 test-bin-wrapper.sh
