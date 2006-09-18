From: "Art Haas" <ahaas@airmail.net>
Subject: Patch for http-fetch.c and older curl releases
Date: Mon, 18 Sep 2006 17:54:45 -0500
Message-ID: <20060918225445.GF1261@artsapartment.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Sep 19 00:55:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPS18-0000xw-1v
	for gcvg-git@gmane.org; Tue, 19 Sep 2006 00:55:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030244AbWIRWyw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Sep 2006 18:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030246AbWIRWyw
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Sep 2006 18:54:52 -0400
Received: from wmail-1.airmail.net ([209.196.70.86]:62461 "EHLO
	wmail-1.airmail.net") by vger.kernel.org with ESMTP
	id S1030244AbWIRWyv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Sep 2006 18:54:51 -0400
Received: from cpe-24-28-121-3.houston.res.rr.com ([24.28.121.3] helo=pcdebian)
	by wmail-1.airmail.net with esmtp (Exim 4.60)
	(envelope-from <ahaas@airmail.net>)
	id 1GPS0o-000KaE-Df
	for git@vger.kernel.org; Mon, 18 Sep 2006 17:54:50 -0500
Received: (qmail 8661 invoked by uid 1000); 18 Sep 2006 22:54:46 -0000
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27260>

Hi.

Older curl releases do not define CURLE_HTTP_RETURNED_ERROR, they
use CURLE_HTTP_NOT_FOUND instead. The trivial patch below fixes
the build error. Newer curl releases keep the CURLE_HTTP_NOT_FOUND
definition but using a -DCURL_NO_OLDIES preprocessor flag
the old name will not be present in the 'curl.h' header. The
comments in 'curl.h' have more info about the name change.

Signed-off-by:  Art Haas <ahaas@airmail.net>

diff --git a/http-fetch.c b/http-fetch.c
index bc74f30..76fcdc7 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -149,7 +149,7 @@ static int missing__target(int code, int
 	return	/* file:// URL -- do we ever use one??? */
 		(result == CURLE_FILE_COULDNT_READ_FILE) ||
 		/* http:// and https:// URL */
-		(code == 404 && result == CURLE_HTTP_RETURNED_ERROR) ||
+		(code == 404 && result == CURLE_HTTP_NOT_FOUND) ||
 		/* ftp:// URL */
 		(code == 550 && result == CURLE_FTP_COULDNT_RETR_FILE)
 		;

-- 
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every wind.

-Thomas Jefferson to James Smith, 1822
