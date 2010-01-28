From: Jeff King <peff@peff.net>
Subject: [PATCH] rerere: fix too-short initialization
Date: Thu, 28 Jan 2010 09:52:16 -0500
Message-ID: <20100128145216.GA29727@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 28 15:52:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaVjU-0007Lq-II
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jan 2010 15:52:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754779Ab0A1OwX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2010 09:52:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754323Ab0A1OwX
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jan 2010 09:52:23 -0500
Received: from peff.net ([208.65.91.99]:54763 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752458Ab0A1OwX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2010 09:52:23 -0500
Received: (qmail 25093 invoked by uid 107); 28 Jan 2010 14:52:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 28 Jan 2010 09:52:23 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Jan 2010 09:52:16 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138253>

This was caused by a typo in the sizeof parameter, and meant
we looked at uninitialized memory.  Caught by valgrind in
t2030.

Signed-off-by: Jeff King <peff@peff.net>
---
I'm running the whole test suite under valgrind for the current
'master'. This was the first hit, but it's very s-l-o-w, so there might
be more as the day progresses.

 rerere.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/rerere.c b/rerere.c
index a86d73d..d1d3e75 100644
--- a/rerere.c
+++ b/rerere.c
@@ -325,7 +325,7 @@ static int handle_cache(const char *path, unsigned char *sha1, const char *outpu
 	for (i = 0; i < 3; i++)
 		free(mmfile[i].ptr);
 
-	memset(&io, 0, sizeof(&io));
+	memset(&io, 0, sizeof(io));
 	io.io.getline = rerere_mem_getline;
 	if (output)
 		io.io.output = fopen(output, "w");
-- 
1.7.0.rc0.41.g538720
