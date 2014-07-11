From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH 1/3] tag: use skip_prefix instead of magic numbers
Date: Fri, 11 Jul 2014 13:51:33 -0700
Message-ID: <1405111895-17451-1-git-send-email-jacob.e.keller@intel.com>
Cc: Jeff King <peff@peff.net>, Jacob Keller <jacob.e.keller@intel.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 11 22:51:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5hnF-0002ua-Tl
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jul 2014 22:51:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752896AbaGKUvl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2014 16:51:41 -0400
Received: from mga11.intel.com ([192.55.52.93]:26284 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752834AbaGKUvl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2014 16:51:41 -0400
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP; 11 Jul 2014 13:51:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.01,645,1400050800"; 
   d="scan'208";a="568662200"
Received: from jekeller-desk1.jf.intel.com (HELO jekeller-desk1.amr.corp.intel.com) ([134.134.173.156])
  by fmsmga002.fm.intel.com with ESMTP; 11 Jul 2014 13:51:40 -0700
X-Mailer: git-send-email 2.0.1.475.g9b8d714
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253322>

From: Jeff King <peff@peff.net>

Make the parsing of the --sort parameter more readable by having
skip_prefix keep our pointer up to date.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
Fixed authorship. I don't expect this version to be taken, but it helps me in
review, and I figured it is good to send the whole series.

 builtin/tag.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index ef765563388c..7ccb6f3c581b 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -524,18 +524,12 @@ static int parse_opt_sort(const struct option *opt, const char *arg, int unset)
 	int *sort = opt->value;
 	int flags = 0;
 
-	if (*arg == '-') {
+	if (skip_prefix(arg, "-", &arg))
 		flags |= REVERSE_SORT;
-		arg++;
-	}
-	if (starts_with(arg, "version:")) {
+
+	if (skip_prefix(arg, "version:", &arg) || skip_prefix(arg, "v:", &arg))
 		*sort = VERCMP_SORT;
-		arg += 8;
-	} else if (starts_with(arg, "v:")) {
-		*sort = VERCMP_SORT;
-		arg += 2;
-	} else
-		*sort = STRCMP_SORT;
+
 	if (strcmp(arg, "refname"))
 		die(_("unsupported sort specification %s"), arg);
 	*sort |= flags;
-- 
2.0.1.475.g9b8d714
