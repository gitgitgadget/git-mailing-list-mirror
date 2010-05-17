From: Marcus Comstedt <marcus@mc.pp.se>
Subject: [PATCH 1/2] Added "Z" as an alias for the timezone "UTC"
Date: Mon, 17 May 2010 21:07:10 +0200
Message-ID: <1274123231-18482-2-git-send-email-marcus@mc.pp.se>
References: <1274123231-18482-1-git-send-email-marcus@mc.pp.se>
Cc: Marcus Comstedt <marcus@mc.pp.se>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 17 21:15:26 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OE5me-00033s-Ai
	for gcvg-git-2@lo.gmane.org; Mon, 17 May 2010 21:15:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755832Ab0EQTPQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 May 2010 15:15:16 -0400
Received: from ua-85-227-1-6.cust.bredbandsbolaget.se ([85.227.1.6]:37397 "EHLO
	bahamut.mc.pp.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755735Ab0EQTPN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 May 2010 15:15:13 -0400
Received: from chiyo.mc.pp.se (chiyo [192.168.42.32])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by bahamut.mc.pp.se (Postfix) with ESMTPS id 59C0EDD0F;
	Mon, 17 May 2010 21:07:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mc.pp.se; s=hedgehog;
	t=1274123264; bh=8pkmP/hZY6khV4wNovSe5TT17Ai3rbPjCSng9esuHEI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=b+DS
	WTo9YYG1EIo/gSRtoLDme+LyH4eTlRPLZqKrS9d80iusRmrUyoc5ouv/B7UGO4duW+w
	gtPeyL1SEuZOfUkvNYGZV1UkFsS+97llR4jP49/BajChzzsbEqs2wzjU3lxAw7yArnb
	18y1KRuDCV7m2Mrow89tTOKqnRFRUAY9Y=
Received: from marcus by chiyo.mc.pp.se with local (Exim 4.71)
	(envelope-from <marcus@chiyo>)
	id 1OE5fE-0004om-73; Mon, 17 May 2010 21:07:44 +0200
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <1274123231-18482-1-git-send-email-marcus@mc.pp.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147254>

The name "Z" for the UTC timezone is required to properly parse
ISO 8601 times.  Added it to the list of recignozed timezones.

Also, fixed the bug that timezone names shorter than 3 characters
can never be matched by match_alpha().  Prior to the introduction
of the "Z" zone, this affected the timezone "NT" (Nome).

Signed-off-by: Marcus Comstedt <marcus@mc.pp.se>
---
:100644 100644 002aa3c... 6bae49c... M	date.c
 date.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/date.c b/date.c
index 002aa3c..6bae49c 100644
--- a/date.c
+++ b/date.c
@@ -229,6 +229,7 @@ static const struct {
 
 	{ "GMT",    0, 0, },	/* Greenwich Mean */
 	{ "UTC",    0, 0, },	/* Universal (Coordinated) */
+	{ "Z",      0, 0, },    /* Zulu, alias for UTC */
 
 	{ "WET",    0, 0, },	/* Western European */
 	{ "BST",    0, 1, },	/* British Summer */
@@ -305,7 +306,7 @@ static int match_alpha(const char *date, struct tm *tm, int *offset)
 
 	for (i = 0; i < ARRAY_SIZE(timezone_names); i++) {
 		int match = match_string(date, timezone_names[i].name);
-		if (match >= 3) {
+		if (match >= 3 || match == strlen(timezone_names[i].name)) {
 			int off = timezone_names[i].offset;
 
 			/* This is bogus, but we like summer */
-- 
1.7.0.4
