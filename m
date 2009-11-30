From: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
Subject: [PATCH v2 0/6] Run test suite without dashed commands in PATH
Date: Sun, 29 Nov 2009 23:19:25 -0700
Message-ID: <1259561971-25730-1-git-send-email-mmogilvi_git@miniinfo.net>
Cc: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Nov 30 07:20:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NEzcJ-0000qX-0B
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 07:20:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753226AbZK3GT4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 01:19:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752688AbZK3GT4
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 01:19:56 -0500
Received: from qmta07.emeryville.ca.mail.comcast.net ([76.96.30.64]:40254 "EHLO
	QMTA07.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752601AbZK3GTy (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Nov 2009 01:19:54 -0500
Received: from OMTA21.emeryville.ca.mail.comcast.net ([76.96.30.88])
	by QMTA07.emeryville.ca.mail.comcast.net with comcast
	id BJ5V1d0031u4NiLA7JL2w6; Mon, 30 Nov 2009 06:20:02 +0000
Received: from mmogilvi.homeip.net ([24.8.125.243])
	by OMTA21.emeryville.ca.mail.comcast.net with comcast
	id BJL01d00B5FCJCg8hJL1yS; Mon, 30 Nov 2009 06:20:01 +0000
Received: from localhost.localdomain (bean [192.168.30.96])
	by mmogilvi.homeip.net (Postfix) with ESMTP id A0ABA89114;
	Sun, 29 Nov 2009 23:19:58 -0700 (MST)
X-Mailer: git-send-email 1.6.4.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134050>

This patch series runs the test suite without the dashed commands
in the PATH.

Changes since version 1:

  - Added patch 3 that documents the pre-existing GIT_TEST_INSTALLED
    feature.

  - Rename what used to be "test-bin" directory as "bin-wrappers", to
    more clearly describe what it is.

  - Split off patch 6 (INSTALL documention) from patch
    4 (was patch 3), describing how the bin-wrappers directory
    is a very convenient way to manually test an uninstalled build.
    I also reworded it a bit to mention the downsides.  Junio
    doesn't seem to agree this is useful; splitting it off makes
    it easy to leave it out.

Not changed:

There was some discussion about not building the bin-wrappers directory
unless you are actually running tests.  But I don't really think it
is worth the additional complexity to manage this.  The "make all"
target is already building several full-up binaries to support the
test suite (not just the small sed-ed scripts that this adds).  And any
such solution would need to deal with parallel execution locking
issues, as well as additional uglyness (either duplicating a list
of bindir executables within test-lib.sh itself, or calling into a
parent directory makefile that might already be running in
a grandparent process).

Matthew Ogilvie (6):
  t2300: use documented technique to invoke git-sh-setup
  t3409 t4107 t7406: use dashless commands
  t/README: Document GIT_TEST_INSTALLED and GIT_TEST_EXEC_PATH
  build dashless "bin-wrappers" directory similar to installed bindir
  run test suite without dashed git-commands in PATH
  INSTALL: document a simpler way to run uninstalled builds

 .gitignore                         |    1 +
 INSTALL                            |   11 +++++++-
 Makefile                           |   49 ++++++++++++++++++++++++++---------
 t/README                           |   21 +++++++++++++++
 t/t2300-cd-to-toplevel.sh          |    2 +-
 t/t3409-rebase-preserve-merges.sh  |    6 ++--
 t/t4107-apply-ignore-whitespace.sh |   20 +++++++-------
 t/t7406-submodule-update.sh        |    4 +-
 t/test-lib.sh                      |   33 +++++++++++++++---------
 wrap-for-bin.sh                    |   15 +++++++++++
 10 files changed, 120 insertions(+), 42 deletions(-)
 create mode 100644 wrap-for-bin.sh
