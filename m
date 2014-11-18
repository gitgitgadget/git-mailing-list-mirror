From: Jeff King <peff@peff.net>
Subject: [PATCH] t960[34]: mark cvsimport tests as requiring perl
Date: Tue, 18 Nov 2014 12:29:32 -0500
Message-ID: <20141118172932.GA31672@peff.net>
References: <20141118172231.GA16387@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 18 18:29:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xqmax-0001cY-JV
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 18:29:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754408AbaKRR3f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 12:29:35 -0500
Received: from cloud.peff.net ([50.56.180.127]:41782 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754063AbaKRR3f (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2014 12:29:35 -0500
Received: (qmail 21251 invoked by uid 102); 18 Nov 2014 17:29:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 18 Nov 2014 11:29:34 -0600
Received: (qmail 18091 invoked by uid 107); 18 Nov 2014 17:29:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 18 Nov 2014 12:29:47 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Nov 2014 12:29:32 -0500
Content-Disposition: inline
In-Reply-To: <20141118172231.GA16387@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git-cvsimport is written in perl, which understandably
causes the tests to fail if you build with NO_PERL (which
will avoid building cvsimport at all). The earlier cvsimport
tests in t9600-t9602 are all marked with a PERL
prerequisite, but these ones are not.

The one in t9603 was likely not noticed because it is an
expected failure anyway.

The ones in t9604 have been around for a long time, but it
is likely that the combination of NO_PERL and having cvsps
installed is rare enough that nobody noticed.

Signed-off-by: Jeff King <peff@peff.net>
---
It would probably make sense to have these scripts just
skip_all if NO_PERL is set, but I opted to follow the pattern
set by t9600, etc. If somebody feels like spending time refactoring the
cvsimport test harness, be my guest.

 t/t9603-cvsimport-patchsets.sh  | 2 +-
 t/t9604-cvsimport-timestamps.sh | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t9603-cvsimport-patchsets.sh b/t/t9603-cvsimport-patchsets.sh
index 52034c8..c4c3c49 100755
--- a/t/t9603-cvsimport-patchsets.sh
+++ b/t/t9603-cvsimport-patchsets.sh
@@ -16,7 +16,7 @@ test_description='git cvsimport testing for correct patchset estimation'
 
 setup_cvs_test_repository t9603
 
-test_expect_failure 'import with criss cross times on revisions' '
+test_expect_failure PERL 'import with criss cross times on revisions' '
 
     git cvsimport -p"-x" -C module-git module &&
     (cd module-git &&
diff --git a/t/t9604-cvsimport-timestamps.sh b/t/t9604-cvsimport-timestamps.sh
index 1fd5142..a4b3db2 100755
--- a/t/t9604-cvsimport-timestamps.sh
+++ b/t/t9604-cvsimport-timestamps.sh
@@ -5,7 +5,7 @@ test_description='git cvsimport timestamps'
 
 setup_cvs_test_repository t9604
 
-test_expect_success 'check timestamps are UTC (TZ=CST6CDT)' '
+test_expect_success PERL 'check timestamps are UTC (TZ=CST6CDT)' '
 
 	TZ=CST6CDT git cvsimport -p"-x" -C module-1 module &&
 	git cvsimport -p"-x" -C module-1 module &&
@@ -34,7 +34,7 @@ test_expect_success 'check timestamps are UTC (TZ=CST6CDT)' '
 	test_cmp actual-1 expect-1
 '
 
-test_expect_success 'check timestamps with author-specific timezones' '
+test_expect_success PERL 'check timestamps with author-specific timezones' '
 
 	cat >cvs-authors <<-EOF &&
 	user1=User One <user1@domain.org>
-- 
2.1.2.596.g7379948
