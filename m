From: Nick Hengeveld <nickh@reactrix.com>
Subject: [PATCH] http-fetch: fix possible segfault
Date: Tue, 6 Jun 2006 22:22:35 -0700
Message-ID: <20060607052235.GA4000@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Jun 07 07:22:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FnqVG-00006a-23
	for gcvg-git@gmane.org; Wed, 07 Jun 2006 07:22:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750895AbWFGFWh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Jun 2006 01:22:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750910AbWFGFWh
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jun 2006 01:22:37 -0400
Received: from 241.37.26.69.virtela.net ([69.26.37.241]:2422 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S1750895AbWFGFWg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jun 2006 01:22:36 -0400
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id k575MaDc012332
	for <git@vger.kernel.org>; Tue, 6 Jun 2006 22:22:36 -0700
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id k575MZYG012330
	for git@vger.kernel.org; Tue, 6 Jun 2006 22:22:35 -0700
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21429>

Initialize an object request's slot to a safe value.  A non-NULL value
can cause a segfault if the request is aborted before it starts.

Signed-off-by: Nick Hengeveld <nickh@reactrix.com>
---
 http-fetch.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/http-fetch.c b/http-fetch.c
index 661c909..d3602b7 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -399,6 +399,7 @@ void prefetch(unsigned char *sha1)
 	snprintf(newreq->filename, sizeof(newreq->filename), "%s", filename);
 	snprintf(newreq->tmpfile, sizeof(newreq->tmpfile),
 		 "%s.temp", filename);
+	newreq->slot = NULL;
 	newreq->next = NULL;
 
 	if (object_queue_head == NULL) {
-- 
1.4.0.rc1.gf75c7-dirty
