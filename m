From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] update-server-info: honor core.sharedRepository
Date: Wed, 11 Jul 2007 13:39:09 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707111338360.4516@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Wed Jul 11 14:47:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8bau-0004m5-GX
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 14:47:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762902AbXGKMqz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jul 2007 08:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762842AbXGKMqy
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 08:46:54 -0400
Received: from mail.gmx.net ([213.165.64.20]:48899 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1764356AbXGKMqx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 08:46:53 -0400
Received: (qmail invoked by alias); 11 Jul 2007 12:46:52 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp032) with SMTP; 11 Jul 2007 14:46:52 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18w8lJYSycwAgU3+Nwhh3Debz6MPji/ZGrL90l8NV
	E5iuiYg2aHKzy2
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52156>


Earlier, update-server-info used the umask, even if
core.sharedRepository = 1.

Noticed by madduck on IRC.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

	Does this work for you?

 server-info.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/server-info.c b/server-info.c
index f9be5a7..0d1312c 100644
--- a/server-info.c
+++ b/server-info.c
@@ -38,6 +38,7 @@ static int update_info_refs(int force)
 		return error("unable to update %s", path0);
 	for_each_ref(add_info_ref, NULL);
 	fclose(info_ref_fp);
+	adjust_shared_perm(path1);
 	rename(path1, path0);
 	free(path0);
 	free(path1);
@@ -227,6 +228,7 @@ static int update_info_packs(int force)
 		return error("cannot open %s", name);
 	write_pack_info_file(fp);
 	fclose(fp);
+	adjust_shared_perm(name);
 	rename(name, infofile);
 	return 0;
 }
