From: Andi Kleen <andi@firstfloor.org>
Subject: [PATCH 1/2] Remove noreturn function pointers in usage.c
Date: Wed,  8 Jun 2011 14:43:36 -0700
Message-ID: <1307569417-8924-1-git-send-email-andi@firstfloor.org>
Cc: Andi Kleen <ak@linux.intel.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 08 23:44:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUQYZ-0003rM-Oi
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 23:44:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753309Ab1FHVou (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 17:44:50 -0400
Received: from mga11.intel.com ([192.55.52.93]:49991 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752090Ab1FHVot (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 17:44:49 -0400
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP; 08 Jun 2011 14:44:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.65,340,1304319600"; 
   d="scan'208";a="13712288"
Received: from tassilo.jf.intel.com ([10.7.201.108])
  by fmsmga002.fm.intel.com with ESMTP; 08 Jun 2011 14:44:49 -0700
Received: by tassilo.jf.intel.com (Postfix, from userid 501)
	id 8E4AC242B3F; Wed,  8 Jun 2011 14:43:41 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175462>

From: Andi Kleen <ak@linux.intel.com>

Due to a bug in gcc 4.6+ it can crash when doing profile feedback
with a noreturn function pointer

(http://gcc.gnu.org/bugzilla/show_bug.cgi?id=49299)

Remove the NORETURNs from the die functions for now to work
around this. Doesn't seem to make any difference.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 usage.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/usage.c b/usage.c
index b5e67e3..4045574 100644
--- a/usage.c
+++ b/usage.c
@@ -12,13 +12,13 @@ void vreportf(const char *prefix, const char *err, va_list params)
 	fprintf(stderr, "%s%s\n", prefix, msg);
 }
 
-static NORETURN void usage_builtin(const char *err, va_list params)
+static  void usage_builtin(const char *err, va_list params)
 {
 	vreportf("usage: ", err, params);
 	exit(129);
 }
 
-static NORETURN void die_builtin(const char *err, va_list params)
+static  void die_builtin(const char *err, va_list params)
 {
 	vreportf("fatal: ", err, params);
 	exit(128);
@@ -36,8 +36,8 @@ static void warn_builtin(const char *warn, va_list params)
 
 /* If we are in a dlopen()ed .so write to a global variable would segfault
  * (ugh), so keep things static. */
-static NORETURN_PTR void (*usage_routine)(const char *err, va_list params) = usage_builtin;
-static NORETURN_PTR void (*die_routine)(const char *err, va_list params) = die_builtin;
+static void (*usage_routine)(const char *err, va_list params) = usage_builtin;
+static void (*die_routine)(const char *err, va_list params) = die_builtin;
 static void (*error_routine)(const char *err, va_list params) = error_builtin;
 static void (*warn_routine)(const char *err, va_list params) = warn_builtin;
 
-- 
1.7.4.4
