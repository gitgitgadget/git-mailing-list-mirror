From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: [PATCH 7/7] Support case folding in git fast-import when core.ignorecase=true
Date: Thu, 20 May 2010 22:50:35 -0600
Message-ID: <1274417435-2344-8-git-send-email-jjensen@workspacewhiz.com>
References: <1274417435-2344-1-git-send-email-jjensen@workspacewhiz.com>
Cc: Joshua Jensen <jjensen@workspacewhiz.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 21 06:51:20 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFKCe-0007k0-H9
	for gcvg-git-2@lo.gmane.org; Fri, 21 May 2010 06:51:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754228Ab0EUEuy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 May 2010 00:50:54 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:39247 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754140Ab0EUEuv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 May 2010 00:50:51 -0400
Received: (qmail 28967 invoked by uid 399); 20 May 2010 22:50:51 -0600
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on jeltz.qwknetllc.net
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=14.0 tests=AWL,HELO_LH_LD,RDNS_NONE
	autolearn=disabled version=3.2.5
X-Virus-Scan: Scanned by ClamAV 0.95.2 (no viruses);
  Thu, 20 May 2010 22:50:50 -0600
Received: from unknown (HELO localhost.localdomain) (jjensen@workspacewhiz.com@76.27.116.215)
  by hsmail.qwknetllc.com with ESMTPAMMMMMMMM; 20 May 2010 22:50:50 -0600
X-Originating-IP: 76.27.116.215
X-Mailer: git-send-email 1.7.1.1930.gcd3ce
In-Reply-To: <1274417435-2344-1-git-send-email-jjensen@workspacewhiz.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147438>

When core.ignorecase=true, imported file paths will be folded to match
existing directory case.

Signed-off-by: Joshua Jensen <jjensen@workspacewhiz.com>
---
 fast-import.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 352e2e3..2279276 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -156,6 +156,7 @@ Format of STDIN stream:
 #include "csum-file.h"
 #include "quote.h"
 #include "exec_cmd.h"
+#include "dir.h"
 
 #define PACK_ID_BITS 16
 #define MAX_PACK_ID ((1<<PACK_ID_BITS)-1)
@@ -1459,7 +1460,7 @@ static int tree_content_set(
 
 	for (i = 0; i < t->entry_count; i++) {
 		e = t->entries[i];
-		if (e->name->str_len == n && !strncmp(p, e->name->str_dat, n)) {
+		if (e->name->str_len == n && !strncmp_icase(p, e->name->str_dat, n)) {
 			if (!slash1) {
 				if (!S_ISDIR(mode)
 						&& e->versions[1].mode == mode
-- 
1.7.1.1930.gca7dd4
