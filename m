From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH] grep: correctly initialize help-all option
Date: Thu,  9 Apr 2015 15:41:56 +0200
Message-ID: <1428586916-22679-1-git-send-email-ps@pks.im>
Cc: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 09 15:42:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YgCih-0003k6-GH
	for gcvg-git-2@plane.gmane.org; Thu, 09 Apr 2015 15:42:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753860AbbDINmI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Apr 2015 09:42:08 -0400
Received: from sender1.zohomail.com ([74.201.84.162]:53377 "EHLO
	sender1.zohomail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751313AbbDINmG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Apr 2015 09:42:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=mail; d=pks.im; 
  h=from:to:cc:subject:date:message-id; 
  b=ogQ1SWt11UI8BRyN2tYuXb2zGNKf5qkIs8MFMyZSszHTdaU/HmSQxrLZCs379yGHm3v1X7eSa85c
    TxZPRsYkcc+zowK0sdBMlrvgEYKuL0DsmAkK2QqdioN66dmg3s0MplbtAhwWkMnARGBeSvpRyG4y
    rBKNI6edLFHWwi1K/ic=  
Received: from localhost (x5ce10066.dyn.telefonica.de [92.225.0.102]) by mx.zohomail.com
	with SMTPS id 1428586923796112.80816618548704; Thu, 9 Apr 2015 06:42:03 -0700 (PDT)
X-Mailer: git-send-email 2.3.5
X-ZohoMail: Ss  SS_10 UW1 iCHF_KNW_WHT_EXT UW1 UB2468 iCHF_INT_SMD_EXT UW1 iSFP_NO_WHTCNT_EXT UW1 UB2468 iZSF-HLOLL_2  SGR3_0_01045_129
X-ZohoMail-Owner: <1428586916-22679-1-git-send-email-ps@pks.im>+zmo_0_<ps@pks.im>
X-ZohoMail-Sender: 92.225.0.102
X-Zoho-Virus-Status: 2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266994>

The "help-all" option is being initialized with a wrong value.
While being semantically wrong this can also cause a gcc
segmentation fault on ARMv7 hardfloat platforms with a hardened
toolchain. Fix this by initializing with the correct value.
---
 builtin/grep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index abc4400..c0bf005 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -738,7 +738,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			PARSE_OPT_OPTARG, NULL, (intptr_t)default_pager },
 		OPT_BOOL(0, "ext-grep", &external_grep_allowed__ignored,
 			 N_("allow calling of grep(1) (ignored by this build)")),
-		{ OPTION_CALLBACK, 0, "help-all", &options, NULL, N_("show usage"),
+		{ OPTION_CALLBACK, 0, "help-all", &opt, NULL, N_("show usage"),
 		  PARSE_OPT_HIDDEN | PARSE_OPT_NOARG, help_callback },
 		OPT_END()
 	};
-- 
2.3.5
