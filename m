From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 00/21] git p4: work on cygwin
Date: Fri, 28 Sep 2012 08:04:04 -0400
Message-ID: <1348833865-6093-1-git-send-email-pw@padd.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 28 14:04:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THZJ9-0000rW-Hh
	for gcvg-git-2@plane.gmane.org; Fri, 28 Sep 2012 14:04:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753517Ab2I1MEa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2012 08:04:30 -0400
Received: from honk.padd.com ([74.3.171.149]:34951 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751222Ab2I1ME3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2012 08:04:29 -0400
Received: from arf.padd.com (unknown [50.55.148.232])
	by honk.padd.com (Postfix) with ESMTPSA id E307E5AF2;
	Fri, 28 Sep 2012 05:04:28 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id F187E31413; Fri, 28 Sep 2012 08:04:25 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.1.457.g468b3ef
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206557>

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

Pete Wyckoff (21):
  git p4: temp branch name should use / even on windows
  git p4: remove unused imports
  git p4: generate better error message for bad depot path
  git p4: fix error message when "describe -s" fails
  git p4 test: use client_view to build the initial client
  git p4 test: use client_view in t9806
  git p4 test: start p4d inside its db dir
  git p4 test: translate windows paths for cygwin
  git p4: remove unreachable windows \r\n conversion code
  git p4: scrub crlf for utf16 files on windows
  git p4 test: newline handling
  git p4 test: use LineEnd unix in windows tests too
  git p4 test: avoid wildcard * in windows
  git p4: cygwin p4 client does not mark read-only
  git p4 test: disable chmod test for cygwin
  git p4: disable read-only attribute before deleting
  git p4: avoid shell when mapping users
  git p4: avoid shell when invoking git rev-list
  git p4: avoid shell when invoking git config --get-all
  git p4: avoid shell when calling git config
  git p4: introduce gitConfigBool

 git-p4.py                     | 122 ++++++++++++++++++++++++++++--------------
 t/lib-git-p4.sh               |  60 +++++++++++++++------
 t/t9800-git-p4-basic.sh       |   5 ++
 t/t9802-git-p4-filetype.sh    | 117 ++++++++++++++++++++++++++++++++++++++++
 t/t9806-git-p4-options.sh     |  50 ++++++++---------
 t/t9807-git-p4-submit.sh      |  14 ++++-
 t/t9809-git-p4-client-view.sh |  14 +++--
 t/t9812-git-p4-wildcards.sh   |  37 ++++++++++---
 t/t9815-git-p4-submit-fail.sh |   4 +-
 t/test-lib.sh                 |   3 ++
 10 files changed, 330 insertions(+), 96 deletions(-)

-- 
1.7.12.1.403.g28165e1
