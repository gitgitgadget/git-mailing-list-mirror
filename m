From: Bryan Donlan <bdonlan@fushizen.net>
Subject: [PATCH 2/8] config.c: Escape backslashes in section names properly
Date: Tue,  8 Apr 2008 21:29:58 -0400
Message-ID: <1207704604-30393-2-git-send-email-bdonlan@fushizen.net>
References: <>
 <cover.1207702130.git.bdonlan@fushizen.net>
 <1207704604-30393-1-git-send-email-bdonlan@fushizen.net>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Adam Roben <aroben@apple.com>, gitster@pobox.com,
	Bryan Donlan <bdonlan@fushizen.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 09 03:32:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjPAb-0007yb-Hh
	for gcvg-git-2@gmane.org; Wed, 09 Apr 2008 03:32:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751927AbYDIBbL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Apr 2008 21:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751926AbYDIBbK
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Apr 2008 21:31:10 -0400
Received: from satoko.is.fushizen.net ([64.71.152.231]:49032 "EHLO
	satoko.is.fushizen.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751902AbYDIBbJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Apr 2008 21:31:09 -0400
Received: from hillmannl2.umeres.maine.edu ([130.111.243.252] helo=shion)
	by satoko.is.fushizen.net with esmtpa (Exim 4.69)
	(envelope-from <bd@fushizen.net>)
	id 1JjP8b-0007dS-Fa; Wed, 09 Apr 2008 01:30:09 +0000
Received: from bd by shion with local (Exim 4.69)
	(envelope-from <bd@shion.is.fushizen.net>)
	id 1JjP8W-0007v7-Co; Tue, 08 Apr 2008 21:30:04 -0400
X-Mailer: git-send-email 1.5.4.3
In-Reply-To: <1207704604-30393-1-git-send-email-bdonlan@fushizen.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79063>

Signed-off-by: Bryan Donlan <bdonlan@fushizen.net>
---
 config.c                |    2 +-
 t/t1303-wacky-config.sh |    6 ++++++
 2 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/config.c b/config.c
index 0624494..6c07245 100644
--- a/config.c
+++ b/config.c
@@ -672,7 +672,7 @@ static int store_write_section(int fd, const char* key)
 	if (dot) {
 		strbuf_addf(&sb, "[%.*s \"", (int)(dot - key), key);
 		for (i = dot - key + 1; i < store.baselen; i++) {
-			if (key[i] == '"')
+			if (key[i] == '"' || key[i] == '\\')
 				strbuf_addch(&sb, '\\');
 			strbuf_addch(&sb, key[i]);
 		}
diff --git a/t/t1303-wacky-config.sh b/t/t1303-wacky-config.sh
index 99985dc..f366b53 100755
--- a/t/t1303-wacky-config.sh
+++ b/t/t1303-wacky-config.sh
@@ -34,4 +34,10 @@ test_expect_success 'add key in different section' '
 	check section2.key bar
 '
 
+SECTION="test.q\"s\\sq'sp e.key"
+test_expect_success 'make sure git-config escapes section names properly' '
+	git config "$SECTION" bar &&
+	check "$SECTION" bar
+'
+
 test_done
-- 
1.5.5.8.gbbd98
