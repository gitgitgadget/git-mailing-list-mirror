From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v6 1/7] t/lib-httpd: load mod_unixd
Date: Mon, 29 Feb 2016 14:58:29 -0800
Message-ID: <1456786715-24256-2-git-send-email-jacob.e.keller@intel.com>
References: <1456786715-24256-1-git-send-email-jacob.e.keller@intel.com>
Cc: Jeff King <peff@peff.net>,
	Mark Strapetz <marc.strapetz@syntevo.com>,
	Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 29 23:58:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaWmI-0005VE-Ds
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 23:58:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752786AbcB2W6x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 17:58:53 -0500
Received: from mga03.intel.com ([134.134.136.65]:52381 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751134AbcB2W6j (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 17:58:39 -0500
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP; 29 Feb 2016 14:58:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,521,1449561600"; 
   d="scan'208";a="661447394"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([134.134.3.65])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Feb 2016 14:58:37 -0800
X-Mailer: git-send-email 2.7.1.429.g45cd78e
In-Reply-To: <1456786715-24256-1-git-send-email-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287930>

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

I am sending this as an indicator that we need to queue my submodule
work on top of this, because at least locally on my Fedora 23 system I
an unable to get the httpd tests to pass otherwise.

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
