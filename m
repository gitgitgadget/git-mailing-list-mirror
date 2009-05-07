From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] archive-tar.c: squelch a type mismatch warning
Date: Thu, 07 May 2009 01:08:19 -0700
Message-ID: <7vd4alfi8c.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 07 10:08:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1yed-00089h-F4
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 10:08:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752187AbZEGIIW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 04:08:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751954AbZEGIIV
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 04:08:21 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:38390 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751171AbZEGIIT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2009 04:08:19 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090507080821.RCOG17670.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Thu, 7 May 2009 04:08:21 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id oY8K1b0014aMwMQ03Y8KRV; Thu, 07 May 2009 04:08:19 -0400
X-Authority-Analysis: v=1.0 c=1 a=X8ftBq99y3wA:10 a=yUxhJFVlWwkA:10
 a=ybZZDoGAAAAA:8 a=rF6kWTHgJdWqpvalJlAA:9 a=esasviDgsN7gaxOM7ZzlqMbbY4AA:4
 a=qIVjreYYsbEA:10
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118438>

On some systems, giving a value of type time_t to printf "%lo" that
expects an unsigned long would give a type mismatch warning.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * A fallout from my foray into FreeBSD (7.2) running on Linux kvm.  I was
   a bit surprised to find that there only was this one, without saying 
   anything to NoThanks.

 archive-tar.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index ba890eb..cee06ce 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -180,7 +180,7 @@ static int write_tar_entry(struct archiver_args *args,
 
 	sprintf(header.mode, "%07o", mode & 07777);
 	sprintf(header.size, "%011lo", S_ISREG(mode) ? size : 0);
-	sprintf(header.mtime, "%011lo", args->time);
+	sprintf(header.mtime, "%011lo", (unsigned long) args->time);
 
 	sprintf(header.uid, "%07o", 0);
 	sprintf(header.gid, "%07o", 0);
