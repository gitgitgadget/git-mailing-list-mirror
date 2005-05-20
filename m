From: Frank Sorenson <frank@tuxrocks.com>
Subject: [PATCH] Fix git-fsck-cache segfault on invalid tag
Date: Fri, 20 May 2005 01:00:41 -0600
Message-ID: <428D8B19.4070605@tuxrocks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri May 20 09:02:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZ1UX-0003TW-RS
	for gcvg-git@gmane.org; Fri, 20 May 2005 09:00:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261365AbVETHA5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 May 2005 03:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261363AbVETHA5
	(ORCPT <rfc822;git-outgoing>); Fri, 20 May 2005 03:00:57 -0400
Received: from www.tuxrocks.com ([64.62.190.123]:8969 "EHLO tuxrocks.com")
	by vger.kernel.org with ESMTP id S261365AbVETHAr (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 May 2005 03:00:47 -0400
Received: from [10.0.0.10] (byu-gw.customer.csolutions.net [216.190.206.130])
	(authenticated bits=0)
	by tuxrocks.com (8.13.1/8.13.1) with ESMTP id j4K70gDg024487
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 20 May 2005 01:00:44 -0600
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
X-Enigmail-Version: 0.91.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

git-fsck-cache will segfault if a tag contains a non-existent sha1.  This
patch fixes fsck-cache to report the invalid tag and not die.

- ---
commit a6a237ee3f3d2f5d76499b8f32f58057c9b4cd2d
tree ac5d65a040c22194ddcd0706dc5f0b8bb52aef65
parent 5cd4c7b7686d334e341b21d92449349feda3ef65
author Frank Sorenson <frank@tuxrocks.com> Fri, 20 May 2005 00:52:59 -0600
committer Frank Sorenson <frank@tuxrocks.com> Fri, 20 May 2005 00:52:59 -0600

 fsck-cache.c |    4 ++++
 1 files changed, 4 insertions(+)

Index: fsck-cache.c
===================================================================
- --- ca5fef50fb68a3afbb35e1a48ac622f7a964f021/fsck-cache.c  (mode:100644)
+++ ac5d65a040c22194ddcd0706dc5f0b8bb52aef65/fsck-cache.c  (mode:100644)
@@ -315,6 +315,10 @@
 		return;
 
 	obj = lookup_object(sha1);
+	if (!obj) {
+		fprintf(stderr, "invalid tag %s - %s\n", path, hexname);
+		return;
+	}
 	obj->used = 1;
 	mark_reachable(obj, REACHABLE);
 }

Frank
- -- 
Frank Sorenson - KD7TZK
Systems Manager, Computer Science Department
Brigham Young University
frank@tuxrocks.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCjYsZaI0dwg4A47wRAn2PAJ9hyoev3stnaN0Qn2wWlBJEKiucQACgvT9Z
rVazYmUFj3nXvJDYaBoSRsM=
=KbSv
-----END PGP SIGNATURE-----
