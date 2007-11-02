From: David Symonds <dsymonds@gmail.com>
Subject: [PATCH 2/3] Act on WS_WARN for ws_mode_space_before_tab.
Date: Sat,  3 Nov 2007 00:34:20 +1100
Message-ID: <11940104621856-git-send-email-dsymonds@gmail.com>
References: <11940104611948-git-send-email-dsymonds@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Andreas Ericsson <ae@op5.se>,
	David Symonds <dsymonds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 02 14:35:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Inwfw-0003VG-UC
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 14:35:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756306AbXKBNed (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 09:34:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756289AbXKBNeb
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 09:34:31 -0400
Received: from ipmail03.adl2.internode.on.net ([203.16.214.135]:7063 "EHLO
	ipmail03.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756228AbXKBNe3 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Nov 2007 09:34:29 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Aq4HAO3DKkd5LCBH/2dsb2JhbACBWw
X-IronPort-AV: E=Sophos;i="4.21,362,1188743400"; 
   d="scan'208";a="180027727"
Received: from ppp121-44-32-71.lns10.syd7.internode.on.net (HELO localhost.localdomain) ([121.44.32.71])
  by ipmail03.adl2.internode.on.net with ESMTP; 03 Nov 2007 00:04:25 +1030
X-Mailer: git-send-email 1.5.3.1
In-Reply-To: <11940104611948-git-send-email-dsymonds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63118>

Signed-off-by: David Symonds <dsymonds@gmail.com>
---
 diff.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index a6aaaf7..6f9b624 100644
--- a/diff.c
+++ b/diff.c
@@ -508,8 +508,12 @@ static void emit_line_with_ws(int nparents,
 	for (i = col0; i < len; i++) {
 		if (line[i] == '\t') {
 			last_tab_in_indent = i;
-			if (0 <= last_space_in_indent)
-				need_highlight_leading_space = 1;
+			if ((ws_mode_space_before_tab != WS_OKAY) &&
+			    (0 <= last_space_in_indent)) {
+				if (ws_mode_space_before_tab == WS_WARN)
+					need_highlight_leading_space = 1;
+				/* TODO: handle WS_ERROR and WS_AUTOFIX */
+			}
 		}
 		else if (line[i] == ' ')
 			last_space_in_indent = i;
-- 
1.5.3.1
