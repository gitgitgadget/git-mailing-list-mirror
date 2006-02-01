From: Mark Wooding <mdw@distorted.org.uk>
Subject: [PATCH 7/9] http-fetch: Tidy control flow in process_alternate_response
Date: Wed, 01 Feb 2006 11:44:39 +0000
Message-ID: <20060201114439.5042.20761.stgit@metalzone.distorted.org.uk>
References: <20060201112822.5042.41256.stgit@metalzone.distorted.org.uk>
X-From: git-owner@vger.kernel.org Wed Feb 01 12:45:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4GPo-00055O-Nd
	for gcvg-git@gmane.org; Wed, 01 Feb 2006 12:44:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161023AbWBALom (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Feb 2006 06:44:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161024AbWBALol
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Feb 2006 06:44:41 -0500
Received: from excessus.demon.co.uk ([83.105.60.35]:6640 "HELO
	metalzone.distorted.org.uk") by vger.kernel.org with SMTP
	id S1161023AbWBALok (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2006 06:44:40 -0500
Received: (qmail 6588 invoked from network); 1 Feb 2006 11:44:39 -0000
Received: from localhost (HELO metalzone.distorted.org.uk) (?FYVf3wrikONayIhfDAYr5RnB/0tyGTqD?@127.0.0.1)
  by localhost with SMTP; 1 Feb 2006 11:44:39 -0000
To: git@vger.kernel.org
In-Reply-To: <20060201112822.5042.41256.stgit@metalzone.distorted.org.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15409>

From: Mark Wooding <mdw@distorted.org.uk>

It's a bit convoluted.  Tidy it up.

Signed-off-by: Mark Wooding <mdw@distorted.org.uk>
---

 http-fetch.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/http-fetch.c b/http-fetch.c
index f1aac14..4aa5a11 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -468,12 +468,9 @@ static void process_alternates_response(
 			if (!slot->in_use)
 				active_requests++;
 			slot->in_use |= SLOTUSE_ACTIVE;
-			if (start_active_slot(slot)) {
-				return;
-			} else {
+			if (!start_active_slot(slot))
 				got_alternates = -1;
-				return;
-			}
+			return;
 		}
 	} else if (slot->curl_result != CURLE_OK) {
 		if (slot->http_code != 404 &&
