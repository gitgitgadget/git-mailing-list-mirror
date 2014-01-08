From: Jeff King <peff@peff.net>
Subject: [PATCH 3/5] branch_get: return early on error
Date: Wed, 8 Jan 2014 04:35:00 -0500
Message-ID: <20140108093500.GC15720@sigill.intra.peff.net>
References: <20140108093338.GA15659@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 08 10:35:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0pXY-0006mM-NH
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jan 2014 10:35:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755458AbaAHJfE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jan 2014 04:35:04 -0500
Received: from cloud.peff.net ([50.56.180.127]:57093 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753919AbaAHJfC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jan 2014 04:35:02 -0500
Received: (qmail 29617 invoked by uid 102); 8 Jan 2014 09:35:02 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 08 Jan 2014 03:35:02 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Jan 2014 04:35:00 -0500
Content-Disposition: inline
In-Reply-To: <20140108093338.GA15659@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240201>

Right now we simply check if "ret" is valid before doing
further processing. As we add more processing, this will
become more and more cumbersome. Instead, let's just check
whether "ret" is invalid and return early with the error.

Signed-off-by: Jeff King <peff@peff.net>
---
 remote.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/remote.c b/remote.c
index a89efab..a773004 100644
--- a/remote.c
+++ b/remote.c
@@ -1543,7 +1543,10 @@ struct branch *branch_get(const char *name)
 		ret = current_branch;
 	else
 		ret = make_branch(name, 0);
-	if (ret && ret->remote_name) {
+	if (!ret)
+		return NULL;
+
+	if (ret->remote_name) {
 		ret->remote = remote_get(ret->remote_name);
 		if (ret->merge_nr) {
 			int i;
-- 
1.8.5.2.500.g8060133
