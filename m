From: Ben Walton <bdwalton@gmail.com>
Subject: [PATCH] Fix a bug in compat/bswap.h endianness detection
Date: Fri, 30 May 2014 16:22:40 +0100
Message-ID: <1401463360-26972-1-git-send-email-bdwalton@gmail.com>
Cc: git@vger.kernel.org, Ben Walton <bdwalton@gmail.com>
To: gitster@pobox.com, cbailey32@bloomberg.net
X-From: git-owner@vger.kernel.org Fri May 30 18:25:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WqPcB-0001K9-K4
	for gcvg-git-2@plane.gmane.org; Fri, 30 May 2014 18:25:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933149AbaE3QZB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2014 12:25:01 -0400
Received: from jimi.chass.utoronto.ca ([128.100.160.32]:45875 "EHLO
	jimi.chass.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752136AbaE3QZA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2014 12:25:00 -0400
X-Greylist: delayed 3250 seconds by postgrey-1.27 at vger.kernel.org; Fri, 30 May 2014 12:25:00 EDT
Received: from hendrix.chass.utoronto.ca ([128.100.160.33]:48565 ident=93)
	  by jimi.chass.utoronto.ca with esmtp  (Exim 4.76)
	 (envelope-from <bwalton@benandwen.net>)
	 id 1WqOld-0005eq-7O ; Fri, 30 May 2014 11:30:49 -0400
Received: from [86.44.14.176] (port=59963 helo=neilyoung)
	 (auth info: dovecot_plain:bwalton@chass.utoronto.ca) by hendrix.chass.utoronto.ca with esmtpsa (TLSv1:AES128-SHA:128)
	 (Exim 4.76)
	 (envelope-from <bwalton@benandwen.net>)
	 id 1WqOla-0002is-0v ; Fri, 30 May 2014 11:30:47 -0400
Received: from bwalton by neilyoung with local (Exim 4.82)
	(envelope-from <bwalton@benandwen.net>)
	id 1WqOdz-00071f-Jj; Fri, 30 May 2014 16:22:55 +0100
X-Mailer: git-send-email 1.9.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250442>

The changes to make detection of endianness more portable had a bug
that breaks on (at least) Solaris x86. The bug appears to be a simple
copy/paste typo. It checks for _BIG_ENDIAN and not _LITTLE_ENDIAN for
both the case where we would decide the system is big endian and
little endian. Instead, the second test should be for _LITTLE_ENDIAN
and not _BIG_ENDIAN.

Two fixes were possible:
1. Change the negation order of the conditions in the second test.
2. Reverse the order of the conditions in the second test.

Use the second option so that the condition we expect is always a
positive check.

Signed-off-by: Ben Walton <bdwalton@gmail.com>
---
I think that this should be applied to cb/byte-swap and re-merged
with next.

 compat/bswap.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/compat/bswap.h b/compat/bswap.h
index c4293db..f6fd9a6 100644
--- a/compat/bswap.h
+++ b/compat/bswap.h
@@ -120,7 +120,7 @@ static inline uint64_t git_bswap64(uint64_t x)
 
 # if defined(_BIG_ENDIAN) && !defined(_LITTLE_ENDIAN)
 #  define GIT_BYTE_ORDER GIT_BIG_ENDIAN
-# elif defined(_BIG_ENDIAN) && !defined(_LITTLE_ENDIAN)
+# elif defined(_LITTLE_ENDIAN) && !defined(_BIG_ENDIAN)
 #  define GIT_BYTE_ORDER GIT_LITTLE_ENDIAN
 # else
 #  error "Cannot determine endianness"
-- 
1.9.1
