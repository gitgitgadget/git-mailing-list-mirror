From: Thomas Rast <trast@inf.ethz.ch>
Subject: [PATCH v4 0/8] --valgrind improvements
Date: Sun, 23 Jun 2013 20:12:51 +0200
Message-ID: <cover.1372010917.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, Fredrik Gustafsson <iveqy@iveqy.com>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 23 20:13:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uqon5-0007dl-2h
	for gcvg-git-2@plane.gmane.org; Sun, 23 Jun 2013 20:13:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752169Ab3FWSNE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Jun 2013 14:13:04 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:39655 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751737Ab3FWSND (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Jun 2013 14:13:03 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sun, 23 Jun
 2013 20:12:45 +0200
Received: from hexa.v.cablecom.net (46.126.8.85) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sun, 23 Jun
 2013 20:12:59 +0200
X-Mailer: git-send-email 1.8.3.1.727.gcbe3af3
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228748>

> Please hold off; Fredrik found an issue with the test automation that
> bisects to "verbose mode for only tests matching a pattern"; when
> running with the 'test' target (not with prove however), the suite
> reports
> 
>   failed test(s):  
> 
>   fixed   0
>   success 9788
>   failed  2
>   broken  69
>   total   9989
> 
> Even worse, I botched a rebase that makes the commit before --
> "self-test that --verbose works" untestable.  I'm pretty sure that it
> has the same problem, too, though I'm still investigating the actual
> issue.

This should fix it.  The culprit was that the test suite generates
.counts files when not under $TEST_HARNESS, and these are seen and
reported by aggregate-results.  So this version changes 4/8 to set
TEST_HARNESS, instead of unsetting it.

Sorry for the trouble.


Thomas Rast (8):
  test-lib: enable MALLOC_* for the actual tests
  test-lib: refactor $GIT_SKIP_TESTS matching
  test-lib: rearrange start/end of test_expect_* and test_skip
  test-lib: self-test that --verbose works
  test-lib: verbose mode for only tests matching a pattern
  test-lib: valgrind for only tests matching a pattern
  test-lib: allow prefixing a custom string before "ok N" etc.
  test-lib: support running tests under valgrind in parallel

 t/README                |  10 ++
 t/t0000-basic.sh        |  61 +++++++++++-
 t/test-lib-functions.sh |   6 +-
 t/test-lib.sh           | 246 ++++++++++++++++++++++++++++++++++++++----------
 t/valgrind/valgrind.sh  |   3 +
 5 files changed, 274 insertions(+), 52 deletions(-)

-- 
1.8.3.1.727.gcbe3af3
