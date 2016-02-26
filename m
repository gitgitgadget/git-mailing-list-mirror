From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v3 1/3] t/lib-httpd: load mod_unixd
Date: Fri, 26 Feb 2016 11:17:46 -0800
Message-ID: <1456514268-8241-1-git-send-email-jacob.e.keller@intel.com>
Cc: Jeff King <peff@peff.net>,
	Mark Strapetz <marc.strapetz@syntevo.com>,
	Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 26 20:17:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZNtk-0003L4-KQ
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 20:17:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423067AbcBZTRv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 14:17:51 -0500
Received: from mga03.intel.com ([134.134.136.65]:18344 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753764AbcBZTRv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 14:17:51 -0500
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP; 26 Feb 2016 11:17:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,504,1449561600"; 
   d="scan'208";a="921924027"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([134.134.3.65])
  by orsmga002.jf.intel.com with ESMTP; 26 Feb 2016 11:17:50 -0800
X-Mailer: git-send-email 2.7.1.429.g45cd78e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287606>

From: Michael J Gruber <git@drmicha.warpmail.net>

In contrast to apache 2.2, apache 2.4 does not load mod_unixd in its
default configuration (because there are choices). Thus, with the
current config, apache 2.4.10 will not be started and the httpd tests
will not run on distros with default apache config (RedHat type).

Enable mod_unixd to make the httpd tests run. This does not affect
distros negatively which have that config already in their default
(Debian type). httpd tests will run on these before and after this patch.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
I am resending this as part of my series, although I have made zero
edits from what was on pu, only to show that I need this to get my
system to pass the httpd tests.

 t/lib-httpd/apache.conf | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index 7d15e6d44c83..f667e7ce2f33 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -64,6 +64,9 @@ LockFile accept.lock
 <IfModule !mod_mpm_prefork.c>
 	LoadModule mpm_prefork_module modules/mod_mpm_prefork.so
 </IfModule>
+<IfModule !mod_unixd.c>
+	LoadModule unixd_module modules/mod_unixd.so
+</IfModule>
 </IfVersion>
 
 PassEnv GIT_VALGRIND
-- 
2.7.1.429.g45cd78e
