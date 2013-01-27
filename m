From: Pete Wyckoff <pw@padd.com>
Subject: [PATCHv2 00/21] git p4: work on cygwin
Date: Sat, 26 Jan 2013 22:11:03 -0500
Message-ID: <1359256284-5660-1-git-send-email-pw@padd.com>
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 27 04:12:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzIf1-0004Ee-Ua
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 04:12:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755374Ab3A0DL3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2013 22:11:29 -0500
Received: from honk.padd.com ([74.3.171.149]:45233 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755361Ab3A0DL1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2013 22:11:27 -0500
Received: from arf.padd.com (unknown [50.52.174.88])
	by honk.padd.com (Postfix) with ESMTPSA id CFBC52F3F;
	Sat, 26 Jan 2013 19:11:26 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 1535D22838; Sat, 26 Jan 2013 22:11:24 -0500 (EST)
X-Mailer: git-send-email 1.8.1.1.517.gf5c753f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214650>

Junio and Hannes:  thanks for the comments four months ago; I've
been slow getting back to this.  I incorporated all your
suggestions.

Junio: this merges okay with Brandon's v2.4 support series.

This series fixes problems in git-p4, and its tests, so that
git-p4 works on the cygwin platform.

See the wiki for info on how to get started on cygwin:

    https://git.wiki.kernel.org/index.php/GitP4

Testing by people who use cygwin would be appreciated.  It would
be good to support cygwin more regularly.  Anyone who had time
to contribute to testing on cygwin, and reporting problems, would
be welcome.

There's more work requried to support msysgit.  Those patches
are not in good enough shape to ship out yet, but a lot of what
is in this series is required for msysgit too.

These patches:

    - fix bugs in git-p4 related to issues found on cygwin

    - cleanup some ugly code in git-p4 observed in error paths while
      getting tests to work on cygwin

    - simplify and refactor code and tests to make cygwin changes easier

    - handle newline and path issues for cygwin platform

    - speed up some aspects of git-p4 by removing extra shell invocations

Changes from v1:

    http://thread.gmane.org/gmane.comp.version-control.git/206557

    - Addressed comments from Junio and Hannes:

	- Removed "git p4: fix error message when "describe -s" fails";
	  it was fixed as part of 18fa13d (git p4: catch p4 describe
	  errors, 2012-11-23), with messages like "p4 describe -s ...
	  failed".

	- Removed extranneous "grep -q" in "git p4: generate better
	  error message for bad depot path".

	- Added "git p4 test: avoid loop in client_view" after a
	  suggestion from Junio.

	- Made the test-path-utils removal explicit.

	- Modify the chmod test to use test_chmod, and verify at
	  least the p4 bits on cygwin, although not the filesystem.

    - Retested on latest cygwin

Pete Wyckoff (21):
  git p4: temp branch name should use / even on windows
  git p4: remove unused imports
  git p4: generate better error message for bad depot path
  git p4 test: use client_view to build the initial client
  git p4 test: avoid loop in client_view
  git p4 test: use client_view in t9806
  git p4 test: start p4d inside its db dir
  git p4 test: translate windows paths for cygwin
  git p4: remove unreachable windows \r\n conversion code
  git p4: scrub crlf for utf16 files on windows
  git p4 test: newline handling
  git p4 test: use LineEnd unix in windows tests too
  git p4 test: avoid wildcard * in windows
  git p4: cygwin p4 client does not mark read-only
  git p4 test: use test_chmod for cygwin
  git p4: disable read-only attribute before deleting
  git p4: avoid shell when mapping users
  git p4: avoid shell when invoking git rev-list
  git p4: avoid shell when invoking git config --get-all
  git p4: avoid shell when calling git config
  git p4: introduce gitConfigBool

 git-p4.py                     | 119 ++++++++++++++++++++++++++++--------------
 t/lib-git-p4.sh               |  64 ++++++++++++++++-------
 t/t9800-git-p4-basic.sh       |   5 ++
 t/t9802-git-p4-filetype.sh    | 117 +++++++++++++++++++++++++++++++++++++++++
 t/t9806-git-p4-options.sh     |  51 ++++++++----------
 t/t9807-git-p4-submit.sh      |  14 ++++-
 t/t9809-git-p4-client-view.sh |  16 ++++--
 t/t9812-git-p4-wildcards.sh   |  37 ++++++++++---
 t/t9815-git-p4-submit-fail.sh |  11 ++--
 t/test-lib.sh                 |   3 ++
 10 files changed, 332 insertions(+), 105 deletions(-)

-- 
1.8.1.1.460.g6fa8886
