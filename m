From: Frank Sorenson <frank@tuxrocks.com>
Subject: [PATCH] git-rev-list: Don't die on a bad tag
Date: Sat, 27 Aug 2005 02:17:01 -0600
Message-ID: <4310217D.80408@tuxrocks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Aug 27 10:17:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8vsI-0003DS-3m
	for gcvg-git@gmane.org; Sat, 27 Aug 2005 10:17:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030341AbVH0IRJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Aug 2005 04:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030342AbVH0IRJ
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Aug 2005 04:17:09 -0400
Received: from www.tuxrocks.com ([64.62.190.123]:40966 "EHLO tuxrocks.com")
	by vger.kernel.org with ESMTP id S1030341AbVH0IRJ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 Aug 2005 04:17:09 -0400
Received: from [10.0.0.10] (216-190-206-130.customer.csolutions.net [216.190.206.130])
	(authenticated bits=0)
	by tuxrocks.com (8.13.1/8.13.1) with ESMTP id j7R8H2Nv027110
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 27 Aug 2005 02:17:04 -0600
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
X-Enigmail-Version: 0.91.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7845>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

The current cogito tree contains an invalid tag
(junio-gpg-pub => 0918385dbd9656cab0d1d81ba7453d49bbc16250), and
git-repack-script (and probably others) will die when git-rev-list
tries to dump the objects.  This patch changes it to complain, but
continue.

Signed-off-by: Frank Sorenson <frank@tuxrocks.com>


diff --git a/rev-list.c b/rev-list.c
- --- a/rev-list.c
+++ b/rev-list.c
@@ -418,8 +418,10 @@ static struct commit *get_commit_referen
 		if (tag_objects && !(object->flags & UNINTERESTING))
 			add_pending_object(object, tag->tag);
 		object = parse_object(tag->tagged->sha1);
- -		if (!object)
- -			die("bad object %s", sha1_to_hex(tag->tagged->sha1));
+		if (!object) {
+			fprintf(stderr, "Bad tag: %s\n", sha1_to_hex(tag->tagged->sha1));
+			return NULL;
+		}
 	}
 
 	/*


Frank
- -- 
Frank Sorenson - KD7TZK
Systems Manager, Computer Science Department
Brigham Young University
frank@tuxrocks.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDECF9aI0dwg4A47wRAncdAKCIcNFzihLm9cy7RWRKakM6INikigCfcCvu
R/XG+XlMsbgWesEvZcFBmQY=
=OY7G
-----END PGP SIGNATURE-----
