From: Lea Wiemann <lewiemann@gmail.com>
Subject: [PATCH] test-lib.sh: add --long-tests option
Date: Tue, 17 Jun 2008 08:26:01 +0200
Message-ID: <1213683961-15183-1-git-send-email-LeWiemann@gmail.com>
Cc: Lea Wiemann <LeWiemann@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 17 08:27:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8Uek-0007mN-98
	for gcvg-git-2@gmane.org; Tue, 17 Jun 2008 08:27:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752151AbYFQG0H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2008 02:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752134AbYFQG0G
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jun 2008 02:26:06 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:14886 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752047AbYFQG0F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2008 02:26:05 -0400
Received: by ug-out-1314.google.com with SMTP id h2so510537ugf.16
        for <git@vger.kernel.org>; Mon, 16 Jun 2008 23:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:to:cc:subject:date
         :message-id:x-mailer:from;
        bh=0Vm1Sh8ZKvyO+kYC6VeR0YcZQDqT+on4nk7CyNi6b/4=;
        b=DFbkrhXjg2y1hETiheAJV8z9I5Eg2h6Wk12k6xxorsHaR/b3QqzIfqGbRJSA62YrP2
         5jFgm2/m5Ipc/VBgW1o7D3BpYwSoXgat67HRdMSSxY6yO+gDfk5ivPHTP3dEMVLVPcRd
         SrD3D5eUh5maI2arGmkVPzY2Ke6uwAoG1R+TU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=to:cc:subject:date:message-id:x-mailer:from;
        b=Mt2zTMgfPisLXfpjDlyL73ay4E8FqA5IalnAp/d+6O6sVpzu/1Jf9dsw5mcVP+ZJ0R
         qqhsH+Lf2jj1iGCerG0GqyqEDjyvm3aKIX4WxLRYGq/jlh0Zy7koqQXzEis9DMEYl543
         ziEkGOuu9sdspg7QnnGlhWfKmlhQ42A2gVzrA=
Received: by 10.210.49.7 with SMTP id w7mr7182988ebw.50.1213683962974;
        Mon, 16 Jun 2008 23:26:02 -0700 (PDT)
Received: from fly ( [91.33.200.72])
        by mx.google.com with ESMTPS id u14sm11607596gvf.6.2008.06.16.23.26.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 16 Jun 2008 23:26:02 -0700 (PDT)
Received: from lea by fly with local (Exim 4.69)
	(envelope-from <lea@fly>)
	id 1K8Udl-0003xK-M8; Tue, 17 Jun 2008 08:26:01 +0200
X-Mailer: git-send-email 1.5.6.rc3.7.ged9620
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85263>

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
