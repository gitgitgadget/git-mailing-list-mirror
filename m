From: Ben Walton <bdwalton@gmail.com>
Subject: [PATCH] Do not make trace.c/getnanotime an inlined function
Date: Sun, 28 Sep 2014 08:50:26 +0100
Message-ID: <1411890626-28237-1-git-send-email-bdwalton@gmail.com>
Cc: git@vger.kernel.org, Ben Walton <bdwalton@gmail.com>
To: karsten.blees@gmail.com, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Sep 28 10:54:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XYAFj-0002sd-VV
	for gcvg-git-2@plane.gmane.org; Sun, 28 Sep 2014 10:54:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753546AbaI1Iyo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Sep 2014 04:54:44 -0400
Received: from jimi.chass.utoronto.ca ([128.100.160.32]:35174 "EHLO
	jimi.chass.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752481AbaI1Iyn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Sep 2014 04:54:43 -0400
X-Greylist: delayed 3854 seconds by postgrey-1.27 at vger.kernel.org; Sun, 28 Sep 2014 04:54:43 EDT
Received: from hendrix.chass.utoronto.ca ([128.100.160.33]:37714 ident=93)
	  by jimi.chass.utoronto.ca with esmtp  (Exim 4.76)
	 (envelope-from <bwalton@benandwen.net>)
	 id 1XY9FU-0000uE-VH ; Sun, 28 Sep 2014 03:50:28 -0400
Received: from 86-42-132-115-dynamic.b-ras1.bbh.dublin.eircom.net ([86.42.132.115]:55061 helo=neilyoung)
	 (auth info: dovecot_plain:bwalton@chass.utoronto.ca) by hendrix.chass.utoronto.ca with esmtpsa (TLSv1:AES128-SHA:128)
	 (Exim 4.76)
	 (envelope-from <bwalton@benandwen.net>)
	 id 1XY9FK-0008Hv-Jx ; Sun, 28 Sep 2014 03:50:19 -0400
Received: from bwalton by neilyoung with local (Exim 4.82)
	(envelope-from <bwalton@benandwen.net>)
	id 1XY9Ff-0007M0-F7; Sun, 28 Sep 2014 08:50:39 +0100
X-Mailer: git-send-email 1.9.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257593>

Oracle Studio compilers don't allow for static variables in functions
that are defined to be inline. GNU C does permit this. Let's reference
the C99 standard though, which doesn't allow for inline functions to
contain modifiable static variables.

Signed-off-by: Ben Walton <bdwalton@gmail.com>
---
 trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/trace.c b/trace.c
index b6f25a2..4778608 100644
--- a/trace.c
+++ b/trace.c
@@ -385,7 +385,7 @@ static inline uint64_t gettimeofday_nanos(void)
  * Returns nanoseconds since the epoch (01/01/1970), for performance tracing
  * (i.e. favoring high precision over wall clock time accuracy).
  */
-inline uint64_t getnanotime(void)
+uint64_t getnanotime(void)
 {
 	static uint64_t offset;
 	if (offset > 1) {
-- 
1.9.1
