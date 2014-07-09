From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH] makefile: add ability to run specific test files
Date: Wed,  9 Jul 2014 15:36:52 -0700
Message-ID: <1404945412-10197-2-git-send-email-jacob.e.keller@intel.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 10 00:37:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X50U0-0007Ra-Dp
	for gcvg-git-2@plane.gmane.org; Thu, 10 Jul 2014 00:37:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756536AbaGIWg5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2014 18:36:57 -0400
Received: from mga11.intel.com ([192.55.52.93]:36453 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755745AbaGIWg4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2014 18:36:56 -0400
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP; 09 Jul 2014 15:36:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.01,634,1400050800"; 
   d="scan'208";a="567595608"
Received: from jekeller-desk1.jf.intel.com (HELO jekeller-desk1.amr.corp.intel.com) ([134.134.173.156])
  by fmsmga002.fm.intel.com with ESMTP; 09 Jul 2014 15:36:55 -0700
X-Mailer: git-send-email 2.0.1.475.g9b8d714
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253167>

Running a specific test file manually does not obtain the exact
environment setup by the Makefile. Add ability to run any of the tests
in the t/ directory so that a user can more quickly debug a failing
test. Otherwise, the entire test suite needs to be run, which can take a
vary long time.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 Makefile | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 07ea1058379a..86bdc4ed1ee9 100644
--- a/Makefile
+++ b/Makefile
@@ -2262,13 +2262,18 @@ export TEST_NO_MALLOC_CHECK
 
 ### Testing rules
 
+T = $(sort $(wildcard t/t[0-9][0-9][0-9][0-9]-*.sh))
+
+$(T):
+	$(MAKE) -C t $(notdir $@)
+
 test: all
 	$(MAKE) -C t/ all
 
 perf: all
 	$(MAKE) -C t/perf/ all
 
-.PHONY: test perf
+.PHONY: test perf $(T)
 
 test-ctype$X: ctype.o
 
-- 
2.0.1.475.g9b8d714
