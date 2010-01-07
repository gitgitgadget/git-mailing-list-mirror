From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 0/5] Miscellaneous improvements on Windows
Date: Thu,  7 Jan 2010 22:54:56 +0100
Message-ID: <cover.1262895936.git.j6t@kdbg.org>
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: msysgit <msysgit@googlegroups.com>
X-From: git-owner@vger.kernel.org Thu Jan 07 22:56:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NT0LK-0001zm-9p
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jan 2010 22:56:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754191Ab0AGV4Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2010 16:56:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754151Ab0AGV4X
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jan 2010 16:56:23 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:50646 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754191Ab0AGV4X (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2010 16:56:23 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id E18F92C400B;
	Thu,  7 Jan 2010 22:56:20 +0100 (CET)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 6800219F610;
	Thu,  7 Jan 2010 22:55:33 +0100 (CET)
X-Mailer: git-send-email 1.6.6.115.gd1ab3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136389>

This series is actually a set of independent changes that improve
the Windows port. (Except that 2/5 depends on 1/5.)

1/5 and 2/5 enable threaded code on Windows. This topic was discussed
beginning of November. The change to builtin-pack-objects.c was
positively commented (though not formally acked) by Nico:

http://thread.gmane.org/gmane.comp.version-control.git/131998/focus=132239

3/5 removes a static dependency on shell32.dll so that startup time is
reduced. It does reduce the runtime of the test suite ('make -j2 test')
from 16:00min to 12:40min for me.

4/5 (the new pipe implementation) could be considered code churn.
It reduces LOC, but the effect is not noticable during run-time.

5/5 (avoid "dup dance") straightens our run-command implementation a
bit. It is more of the future-proofing kind because it avoids that a
writable pipe end remains accidentally open in a child process, leaving
the reader waiting idenfinetly. This doesn't seem to be a problem
currently, though.


I'm using these patches since November.


Andrzej K. Haczewski (1):
  MSVC: Windows-native implementation for subset of Pthreads API

Johannes Sixt (4):
  MinGW: enable pthreads
  Windows: boost startup by avoiding a static dependency on shell32.dll
  Windows: simplify the pipe(2) implementation
  Windows: avoid the "dup dance" when spawning a child process

 Makefile               |   13 +++--
 builtin-pack-objects.c |   31 +++++++++++--
 compat/mingw.c         |   80 ++++++++++++++++----------------
 compat/mingw.h         |    8 +++-
 compat/win32/pthread.c |  120 ++++++++++++++++++++++++++++++++++++++++++++++++
 compat/win32/pthread.h |   68 +++++++++++++++++++++++++++
 run-command.c          |   71 ++++++++++++----------------
 7 files changed, 300 insertions(+), 91 deletions(-)
 create mode 100644 compat/win32/pthread.c
 create mode 100644 compat/win32/pthread.h
