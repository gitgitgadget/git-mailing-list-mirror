From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v3 1/2] t/lib-http/apache.conf: load mod_unixd module in apache 2.4
Date: Thu, 25 Feb 2016 10:57:11 -0800
Message-ID: <1456426632-23257-1-git-send-email-jacob.e.keller@intel.com>
Cc: Jeff King <peff@peff.net>,
	Mark Strapetz <marc.strapetz@syntevo.com>,
	Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 25 19:57:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ16H-0000vb-Io
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 19:57:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933392AbcBYS5Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 13:57:16 -0500
Received: from mga14.intel.com ([192.55.52.115]:12359 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933225AbcBYS5Q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 13:57:16 -0500
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP; 25 Feb 2016 10:57:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,498,1449561600"; 
   d="scan'208";a="921188632"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([134.134.3.65])
  by orsmga002.jf.intel.com with ESMTP; 25 Feb 2016 10:57:15 -0800
X-Mailer: git-send-email 2.7.1.429.g45cd78e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287415>

From: Jacob Keller <jacob.keller@gmail.com>

Since 2.4, apache will fail to load unless mod_unixd is loaded in order
to drop privileges.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---

I am not sure why this wasn't there already, but I am unable to run
httpd 2.4.18 without it, on Fedora 23.

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
