From: Lea Wiemann <lewiemann@gmail.com>
Subject: [PATCH] test-lib.sh: add --long-tests option
Date: Tue, 17 Jun 2008 03:29:02 +0200
Message-ID: <1213666142-24680-1-git-send-email-LeWiemann@gmail.com>
Cc: Lea Wiemann <LeWiemann@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 17 08:04:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8UIq-0002F0-7C
	for gcvg-git-2@gmane.org; Tue, 17 Jun 2008 08:04:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751761AbYFQGDM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2008 02:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751779AbYFQGDM
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jun 2008 02:03:12 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:63867 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751693AbYFQGDM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2008 02:03:12 -0400
Received: by fg-out-1718.google.com with SMTP id 19so3463182fgg.17
        for <git@vger.kernel.org>; Mon, 16 Jun 2008 23:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:to:cc:subject:date
         :message-id:x-mailer:from;
        bh=0Vm1Sh8ZKvyO+kYC6VeR0YcZQDqT+on4nk7CyNi6b/4=;
        b=VlLlVXfeYmrJJVhmgjjMn0w1gq11MHOkhkxtas90c9THxpVdtVQFait2esC/XDnFzc
         G4BejFue91E/DDmZdPc5YtC8T/TxWsdAp7DCHOhZG82rtOzFn/kmmAsAZ9jmQB7kuE3Z
         PM5MKX7mlFj2KUZuIR6FfVEergR6J4lYo/jik=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=to:cc:subject:date:message-id:x-mailer:from;
        b=k8NWarFfzCUNErB5+j2XnzV2CH5C4ldPi6vuyH7dUBKclVMzCfLBlVKexip4Ca6d6V
         aV99cGh5fc/FVRXC/G2Mhl6xAnuzIe8ZcqxljhuUZYeZ/tcKTkf/n0FmUngiDEu+r6Ac
         4baQmnfOFiwNvhJIUnPcW27LCr++xhY/fgL24=
Received: by 10.86.65.9 with SMTP id n9mr8699149fga.69.1213682588070;
        Mon, 16 Jun 2008 23:03:08 -0700 (PDT)
Received: from fly ( [91.33.200.72])
        by mx.google.com with ESMTPS id l19sm12932421fgb.7.2008.06.16.23.03.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 16 Jun 2008 23:03:07 -0700 (PDT)
Received: from lea by fly with local (Exim 4.69)
	(envelope-from <lea@fly>)
	id 1K8Q0M-0006QR-M5; Tue, 17 Jun 2008 03:29:02 +0200
X-Mailer: git-send-email 1.5.6.rc3.7.ged9620
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85260>

Add a --long-tests option to test-lib.sh, which enables tests to
selectively run more exhaustive (longer running, potentially
brute-force) tests.  Such exhaustive tests would only be useful if one
works on the specific module that is being tested -- for a general "cd
t/; make" to check whether everything is OK, such exhaustive tests
shouldn't be run by default since the longer it takes to run the
tests, the less often they are actually run.

Signed-off-by: Lea Wiemann <LeWiemann@gmail.com>
---
Right now I'm using this in the Mechanize test for exhaustive link
checking on each page.  I've caught bugs with this (such as the
"[PATCH] gitweb: fix support for repository directories with spaces"
that I just sent), so it's actually useful for development, but it's
so slow that I wouldn't want it to be run unless the user requests it
-- the link checking is really quite brute-force and doesn't cover
much more than the actual test.  Actual breakages (regressions) are
quite likely to be caught by the normal test.

Running the Mechanize test in long mode takes more than 1 minute on my
system, vs 5 seconds in normal mode -- and that's just with a really
short draft of the test suite.  So running those long tests
unconditionally would slow down "cd t; make" unncessarily, and we want
tests to be fast so that people actually run them.


Is the wording OK?  --long-tests and GIT_TEST_LONG were the best terms
I could come up with off the top of my head.


(ISTR that there's some large open source project that uses this
strategy (long vs. normal tests) quite extensively, but I can't recall
which one; hints appreciated.  GCC uses it in its compatibility tests;
its testsuite/README.compat reads,

  Normally, only a small amount of compatibility tests is run.
  Setting RUN_ALL_COMPAT_TESTS=1 in the environment before running the
  testsuite enables running all compatibility tests, but might take
  significantly longer than it takes without this variable.)

-- Lea

 t/README      |    4 ++++
 t/test-lib.sh |    2 ++
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/t/README b/t/README
index 70841a4..dc89263 100644
--- a/t/README
+++ b/t/README
@@ -54,6 +54,10 @@ You can pass --verbose (or -v), --debug (or -d), and --immediate
 	This causes the test to immediately exit upon the first
 	failed test.
 
+--long-tests::
+	This causes additional long-running tests to be run (where
+	available), for more exhaustive testing.
+
 
 Naming Tests
 ------------
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 163167c..4cd99af 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -80,6 +80,8 @@ do
 		debug=t; shift ;;
 	-i|--i|--im|--imm|--imme|--immed|--immedi|--immedia|--immediat|--immediate)
 		immediate=t; shift ;;
+	-l|--l|--lo|--lon|--long|--long-|--long-t|--long-te|--long-tes|--long-test|--long-tests)
+		export GIT_TEST_LONG=t; shift ;;
 	-h|--h|--he|--hel|--help)
 		help=t; shift ;;
 	-v|--v|--ve|--ver|--verb|--verbo|--verbos|--verbose)
-- 
1.5.6.rc3.7.ged9620
