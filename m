From: =?utf-8?q?Santi=20B=C3=A9jar?= <sbejar@gmail.com>
Subject: [PATCH] describe: fix --long output
Date: Mon,  3 Mar 2008 15:37:46 +0100
Message-ID: <1204555066-8820-1-git-send-email-sbejar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Santi=20B=C3=A9jar?= <sbejar@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 03 16:13:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWCLI-0004Ry-JA
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 16:12:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754787AbYCCPMA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Mar 2008 10:12:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754646AbYCCPMA
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 10:12:00 -0500
Received: from mail.mppmu.mpg.de ([134.107.24.11]:46398 "EHLO
	mail.mppmu.mpg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754466AbYCCPL7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 10:11:59 -0500
X-Greylist: delayed 2043 seconds by postgrey-1.27 at vger.kernel.org; Mon, 03 Mar 2008 10:11:58 EST
Received: by mail.mppmu.mpg.de (Postfix, from userid 998)
	id 306E312046; Mon,  3 Mar 2008 15:37:54 +0100 (CET)
Received: from localhost (sn3dhcp15.mppmu.mpg.de [134.107.3.155])
	by mail.mppmu.mpg.de (Postfix) with ESMTP id 627D81203B;
	Mon,  3 Mar 2008 15:37:46 +0100 (CET)
X-Mailer: git-send-email 1.5.4.3.488.g7b3a6
X-Spam-Checker-Version: SpamAssassin 2.63 (2004-01-11) on mail.mppmu.mpg.de
X-Spam-Status: No, hits=0.1 required=6.0 tests=TW_CB autolearn=no version=2.63
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75933>

Without this the output is:

$ git describe --long origin/next
v1.5.4.3-0-g31e0b2c-500-g83a2cbb

It was introduced in the conflicting part of
b00ac8c (Merge branch 'sp/describe-tag')

Signed-off-by: Santi B=C3=A9jar <sbejar@gmail.com>
---
 builtin-describe.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin-describe.c b/builtin-describe.c
index 2f1e7ba..7ba822a 100644
--- a/builtin-describe.c
+++ b/builtin-describe.c
@@ -166,9 +166,6 @@ static void display_name(struct commit_name *n)
 		printf("%s", n->tag->tag);
 	else
 		printf("%s", n->path);
-	if (longformat)
-		printf("-0-g%s",
-		       find_unique_abbrev(n->tag->tagged->sha1, abbrev));
 }
=20
 static void describe(const char *arg, int last_one)
@@ -196,6 +193,9 @@ static void describe(const char *arg, int last_one)
 	n =3D cmit->util;
 	if (n) {
 		display_name(n);
+		if (longformat)
+			printf("-0-g%s",
+				find_unique_abbrev(n->tag->tagged->sha1, abbrev));
 		printf("\n");
 		return;
 	}
--=20
1.5.4.3.488.g7b3a6

