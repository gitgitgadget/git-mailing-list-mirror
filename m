From: Jeff King <peff@peff.net>
Subject: [PATCH] fix compilation with NO_PTHREADS
Date: Sat, 5 Jan 2013 09:52:29 -0500
Message-ID: <20130105145229.GA25112@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 05 15:52:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrV7E-0002I2-2h
	for gcvg-git-2@plane.gmane.org; Sat, 05 Jan 2013 15:52:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755792Ab3AEOwd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2013 09:52:33 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:44373 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755739Ab3AEOwc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2013 09:52:32 -0500
Received: (qmail 27666 invoked by uid 107); 5 Jan 2013 14:53:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 05 Jan 2013 09:53:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 05 Jan 2013 09:52:29 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212697>

Commit 1327452 cleaned up an unused parameter from
wait_or_whine, but forgot to update a caller that is inside
"#ifdef NO_PTHREADS".

Signed-off-by: Jeff King <peff@peff.net>
---
I happened to notice this while looking at the sigpipe topic. I guess
not many people are building with NO_PTHREADS these days.

 run-command.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/run-command.c b/run-command.c
index cfb7274..0471219 100644
--- a/run-command.c
+++ b/run-command.c
@@ -725,7 +725,7 @@ int finish_async(struct async *async)
 int finish_async(struct async *async)
 {
 #ifdef NO_PTHREADS
-	return wait_or_whine(async->pid, "child process", 0);
+	return wait_or_whine(async->pid, "child process");
 #else
 	void *ret = (void *)(intptr_t)(-1);
 
-- 
1.8.1.rc1.16.g6d46841
