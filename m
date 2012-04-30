From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 2/2] remove blank filename in error message
Date: Sun, 29 Apr 2012 20:28:46 -0400
Message-ID: <1335745726-2583-3-git-send-email-pw@padd.com>
References: <1335745726-2583-1-git-send-email-pw@padd.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 30 02:29:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOeUh-0000nf-Sz
	for gcvg-git-2@plane.gmane.org; Mon, 30 Apr 2012 02:29:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754830Ab2D3A3a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Apr 2012 20:29:30 -0400
Received: from honk.padd.com ([74.3.171.149]:35042 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754581Ab2D3A33 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Apr 2012 20:29:29 -0400
Received: from arf.padd.com (unknown [50.55.155.59])
	by honk.padd.com (Postfix) with ESMTPSA id CBA2B2EB4;
	Sun, 29 Apr 2012 17:29:28 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 90EFC313F8; Sun, 29 Apr 2012 20:29:26 -0400 (EDT)
X-Mailer: git-send-email 1.7.10.574.g53b8dd
In-Reply-To: <1335745726-2583-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196526>

When write_loose_object() finds that it is unable to
create a temporary file, it complains, for instance:

    unable to create temporary sha1 filename : Too many open files

That extra space was supposed to be the name of the file,
and will be an empty string if the git_mkstemps_mode() fails.

The name of the temporary file is unimportant; delete it.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 sha1_file.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sha1_file.c b/sha1_file.c
index c8d572d..3c4f165 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2511,7 +2511,7 @@ static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
 		if (errno == EACCES)
 			return error("insufficient permission for adding an object to repository database %s", get_object_directory());
 		else
-			return error("unable to create temporary sha1 filename %s: %s", tmp_file, strerror(errno));
+			return error("unable to create temporary file: %s", strerror(errno));
 	}
 
 	/* Set it up */
-- 
1.7.10.572.ged86f
