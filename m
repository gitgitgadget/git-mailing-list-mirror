From: "Philippe Bruhat (BooK)" <book@cpan.org>
Subject: [PATCH] Define $PERL_PATH in test-lib.sh
Date: Tue, 10 Nov 2009 11:46:51 +0100
Message-ID: <1257850011-7544-1-git-send-email-book@cpan.org>
Cc: "Philippe Bruhat (BooK)" <book@cpan.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 10 12:11:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7odP-0007oJ-UJ
	for gcvg-git-2@lo.gmane.org; Tue, 10 Nov 2009 12:11:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753319AbZKJLL1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2009 06:11:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753249AbZKJLL1
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Nov 2009 06:11:27 -0500
Received: from mail-out3.booking.com ([91.195.237.20]:33646 "EHLO
	mail-out3.booking.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751386AbZKJLL0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2009 06:11:26 -0500
X-Greylist: delayed 1480 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 Nov 2009 06:11:26 EST
Received: from corpds-102.ams4.corp.booking.com ([10.196.68.83])
	by mtx-101.ams4.prod.booking.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <philippe.bruhat@free.fr>)
	id 1N7oFP-0003o9-Ao; Tue, 10 Nov 2009 11:46:51 +0100
Received: from ams4-mail-03.ams4.corp.booking.com ([10.196.68.31])
	by corpds-102.ams4.corp.booking.com with esmtp (Exim 4.69)
	(envelope-from <philippe.bruhat@free.fr>)
	id 1N7oFP-000074-9E; Tue, 10 Nov 2009 11:46:51 +0100
Received: from plop (bkbastion-01.corp.lhr1.booking.com [10.146.90.100])
	by ams4-mail-03.ams4.corp.booking.com (Postfix) with ESMTP id 23D76EF80B9;
	Tue, 10 Nov 2009 11:46:51 +0100 (CET)
Received: from book by plop with local (Exim 4.69)
	(envelope-from <philippe.bruhat@free.fr>)
	id 1N7oFP-0001y9-6K; Tue, 10 Nov 2009 11:46:51 +0100
X-Mailer: git-send-email 1.6.0.3.517.g759a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132560>

The main Makefile defines PERL_PATH as the perl to use in the shebang
line of git*.perl commands. This ensures this will be the perl used
to run the tests (in case another perl appears in $PATH before the one
defined in $PERL_PATH)

Signed-off-by: Philippe Bruhat (BooK) <book@cpan.org>
---
 t/t9400-git-cvsserver-server.sh |    2 +-
 t/t9401-git-cvsserver-crlf.sh   |    2 +-
 t/t9700-perl-git.sh             |    4 ++--
 t/test-lib.sh                   |    2 ++
 4 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
index 64f947d..dc710f8 100755
--- a/t/t9400-git-cvsserver-server.sh
+++ b/t/t9400-git-cvsserver-server.sh
@@ -20,7 +20,7 @@ then
     say 'skipping git-cvsserver tests, cvs not found'
     test_done
 fi
-perl -e 'use DBI; use DBD::SQLite' >/dev/null 2>&1 || {
+$PERL_PATH -e 'use DBI; use DBD::SQLite' >/dev/null 2>&1 || {
     say 'skipping git-cvsserver tests, Perl SQLite interface unavailable'
     test_done
 }
diff --git a/t/t9401-git-cvsserver-crlf.sh b/t/t9401-git-cvsserver-crlf.sh
index aca40c1..c9e3dba 100755
--- a/t/t9401-git-cvsserver-crlf.sh
+++ b/t/t9401-git-cvsserver-crlf.sh
@@ -57,7 +57,7 @@ then
     say 'skipping git-cvsserver tests, perl not available'
     test_done
 fi
-perl -e 'use DBI; use DBD::SQLite' >/dev/null 2>&1 || {
+$PERL_PATH -e 'use DBI; use DBD::SQLite' >/dev/null 2>&1 || {
     say 'skipping git-cvsserver tests, Perl SQLite interface unavailable'
     test_done
 }
diff --git a/t/t9700-perl-git.sh b/t/t9700-perl-git.sh
index 4eb7d3f..3354e18 100755
--- a/t/t9700-perl-git.sh
+++ b/t/t9700-perl-git.sh
@@ -11,7 +11,7 @@ if ! test_have_prereq PERL; then
 	test_done
 fi
 
-perl -MTest::More -e 0 2>/dev/null || {
+$PERL_PATH -MTest::More -e 0 2>/dev/null || {
 	say "Perl Test::More unavailable, skipping test"
 	test_done
 }
@@ -48,6 +48,6 @@ test_expect_success \
 
 test_external_without_stderr \
     'Perl API' \
-    perl "$TEST_DIRECTORY"/t9700/test.pl
+    $PERL_PATH "$TEST_DIRECTORY"/t9700/test.pl
 
 test_done
diff --git a/t/test-lib.sh b/t/test-lib.sh
index f2ca536..54dd4d5 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -730,6 +730,8 @@ esac
 
 test -z "$NO_PERL" && test_set_prereq PERL
 
+test -z "$NO_PERL" && test -z "$PERL_PATH" && export PERL_PATH=/usr/bin/perl
+
 # test whether the filesystem supports symbolic links
 ln -s x y 2>/dev/null && test -h y 2>/dev/null && test_set_prereq SYMLINKS
 rm -f y
-- 
1.6.0.3.517.g759a
