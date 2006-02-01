From: Mark Wooding <mdw@distorted.org.uk>
Subject: [PATCH 5/9] http-fetch: Fix message reporting rename of object file.
Date: Wed, 01 Feb 2006 11:44:35 +0000
Message-ID: <20060201114435.5042.11777.stgit@metalzone.distorted.org.uk>
References: <20060201112822.5042.41256.stgit@metalzone.distorted.org.uk>
X-From: git-owner@vger.kernel.org Wed Feb 01 12:44:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4GPm-00055O-Lq
	for gcvg-git@gmane.org; Wed, 01 Feb 2006 12:44:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932101AbWBALoi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Feb 2006 06:44:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932423AbWBALoh
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Feb 2006 06:44:37 -0500
Received: from excessus.demon.co.uk ([83.105.60.35]:6128 "HELO
	metalzone.distorted.org.uk") by vger.kernel.org with SMTP
	id S1161025AbWBALog (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2006 06:44:36 -0500
Received: (qmail 6562 invoked from network); 1 Feb 2006 11:44:35 -0000
Received: from localhost (HELO metalzone.distorted.org.uk) (?FfkQNJuiuzatb6Hz20wsxFsS3FUeOdKi?@127.0.0.1)
  by localhost with SMTP; 1 Feb 2006 11:44:35 -0000
To: git@vger.kernel.org
In-Reply-To: <20060201112822.5042.41256.stgit@metalzone.distorted.org.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15405>

From: Mark Wooding <mdw@distorted.org.uk>

move_temp_to_file returns 0 or -1.  This is not a good thing to pass to
strerror(3).  Fortunately, someone already reported the error, so don't
worry too much.

Signed-off-by: Mark Wooding <mdw@distorted.org.uk>
---

 http-fetch.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/http-fetch.c b/http-fetch.c
index 8656070..f1aac14 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -831,9 +831,8 @@ static int fetch_object(struct alt_base 
 	} else if (memcmp(obj_req->sha1, obj_req->real_sha1, 20)) {
 		ret = error("File %s has bad hash\n", hex);
 	} else if (obj_req->rename < 0) {
-		ret = error("unable to write sha1 filename %s: %s",
-			    obj_req->filename,
-			    strerror(obj_req->rename));
+		ret = error("unable to write sha1 filename %s",
+			    obj_req->filename);
 	}
 
 	release_object_request(obj_req);
