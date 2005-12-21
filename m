From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] sanity check in add_packed_git()
Date: Wed, 21 Dec 2005 18:47:09 -0500
Message-ID: <1135208829.15567.18.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Dec 22 00:47:18 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EpDfw-0000cX-Qy
	for gcvg-git@gmane.org; Thu, 22 Dec 2005 00:47:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964994AbVLUXrM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Dec 2005 18:47:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964998AbVLUXrM
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Dec 2005 18:47:12 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:54446 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S964994AbVLUXrM
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Dec 2005 18:47:12 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1EpDfq-0002Br-LW
	for git@vger.kernel.org; Wed, 21 Dec 2005 18:47:10 -0500
Received: from proski by dv.roinet.com with local (Exim 4.54)
	id 1EpDfp-00025W-RC
	for git@vger.kernel.org; Wed, 21 Dec 2005 18:47:09 -0500
To: git <git@vger.kernel.org>
X-Mailer: Evolution 2.4.1 (2.4.1-5) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13919>

add_packed_git() tries to get the pack SHA1 by parsing its name.  It may
access uninitialized memory for packs with short names.

Signed-off-by: Pavel Roskin <proski@gnu.org>

diff --git a/sha1_file.c b/sha1_file.c
index fa22e9c..d83d824 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -464,7 +464,7 @@ struct packed_git *add_packed_git(char *
 	p->pack_last_used = 0;
 	p->pack_use_cnt = 0;
 	p->pack_local = local;
-	if (!get_sha1_hex(path + path_len - 40 - 4, sha1))
+	if ((path_len > 44) && !get_sha1_hex(path + path_len - 44, sha1))
 		memcpy(p->sha1, sha1, 20);
 	return p;
 }


-- 
Regards,
Pavel Roskin
