From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] Warning in apply.c
Date: Sun, 03 Jul 2005 22:50:00 -0400
Message-ID: <1120445400.1265.23.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Jul 04 04:50:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DpH2Q-0000GI-Ll
	for gcvg-git@gmane.org; Mon, 04 Jul 2005 04:50:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261335AbVGDCuP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jul 2005 22:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261356AbVGDCuP
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jul 2005 22:50:15 -0400
Received: from h-64-105-159-118.phlapafg.covad.net ([64.105.159.118]:18402
	"HELO roinet.com") by vger.kernel.org with SMTP id S261335AbVGDCuB
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 3 Jul 2005 22:50:01 -0400
Received: (qmail 4741 invoked from network); 4 Jul 2005 02:50:00 -0000
Received: from mtproxy.roinet.com (HELO dv) (192.168.1.1)
  by roinet.com with SMTP; 4 Jul 2005 02:50:00 -0000
To: git <git@vger.kernel.org>
X-Mailer: Evolution 2.2.3 (2.2.3-8) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello!

gcc 4.0.0 reports one warning while compiling git on x86_64:

gcc -g -O2 -Wall '-DSHA1_HEADER=<openssl/sha.h>' -o git-apply apply.c libgit.a -lz -lcrypto
apply.c: In function 'show_rename_copy':
apply.c:1147: warning: field precision should have type 'int', but argument 3 has type 'long int'

The fix is to cast pointer difference to int.

Signed-off-by: Pavel Roskin <proski@gnu.org>

diff --git a/apply.c b/apply.c
--- a/apply.c
+++ b/apply.c
@@ -1143,7 +1143,7 @@ static void show_rename_copy(struct patc
 	 */
 	if (old != p->old_name)
 		printf(" %s %.*s{%s => %s} (%d%%)\n", renamecopy,
-		       old - p->old_name, p->old_name,
+		       (int)(old - p->old_name), p->old_name,
 		       old, new, p->score);
 	else
 		printf(" %s %s => %s (%d%%)\n", renamecopy,


-- 
Regards,
Pavel Roskin
