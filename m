From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2] grep: correctly initialize help-all option
Date: Thu,  9 Apr 2015 21:59:06 +0200
Message-ID: <1428609546-3535-1-git-send-email-ps@pks.im>
References: <1428586916-22679-1-git-send-email-ps@pks.im>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 09 22:01:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YgIdQ-000445-SX
	for gcvg-git-2@plane.gmane.org; Thu, 09 Apr 2015 22:01:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933562AbbDIUBE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Apr 2015 16:01:04 -0400
Received: from sender1.zohomail.com ([74.201.84.162]:53847 "EHLO
	sender1.zohomail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933293AbbDIUBC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Apr 2015 16:01:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=mail; d=pks.im; 
  h=from:to:cc:subject:date:message-id:in-reply-to:references; 
  b=M7sZu4c7+RrHz4ykaUHRJMpSePeqFobD0+G14hhYuyz6GmY9JL+v9b884KuoWKgOpw7wpjwQrLoM
    0YI9w1fCckx1PJhiBEJYhcehBp0ax0MMdeoWxfkrBurKvN7UhO190q2LlVzLiVGsbNIfgHf/bRsr
    +aRHLjrfQSCZZ9lQezo=  
Received: from localhost (x5ce10066.dyn.telefonica.de [92.225.0.102]) by mx.zohomail.com
	with SMTPS id 1428609657144761.9847284423331; Thu, 9 Apr 2015 13:00:57 -0700 (PDT)
X-Mailer: git-send-email 2.3.5
In-Reply-To: <1428586916-22679-1-git-send-email-ps@pks.im>
X-ZohoMail: Ss  SS_10 UW1 iCHF_KNW_WHT_EXT UW1 UB2468 iCHF_INT_SMD_EXT UW1 iSFP_NO_WHTCNT_EXT UW1 UB2468 iZSF-HLOLL_2  SGR3_0_01045_97
X-ZohoMail-Owner: <1428609546-3535-1-git-send-email-ps@pks.im>+zmo_0_<ps@pks.im>
X-ZohoMail-Sender: 92.225.0.102
X-Zoho-Virus-Status: 2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267001>

The "help-all" option is being initialized with a wrong value.
While being semantically wrong this can also cause a segmentation
fault in gcc on ARMv7 hardfloat platforms with a hardened
toolchain. Fix this by initializing with a NULL value.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---

Added missing sign-off and changed initialization with &opts to
initialization with NULL according to Eric's comment as the value
is not being used anyway.

 builtin/grep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index abc4400..d04f440 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -738,7 +738,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			PARSE_OPT_OPTARG, NULL, (intptr_t)default_pager },
 		OPT_BOOL(0, "ext-grep", &external_grep_allowed__ignored,
 			 N_("allow calling of grep(1) (ignored by this build)")),
-		{ OPTION_CALLBACK, 0, "help-all", &options, NULL, N_("show usage"),
+		{ OPTION_CALLBACK, 0, "help-all", NULL, NULL, N_("show usage"),
 		  PARSE_OPT_HIDDEN | PARSE_OPT_NOARG, help_callback },
 		OPT_END()
 	};
-- 
2.3.5
