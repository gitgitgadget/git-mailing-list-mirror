From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 1/4] lockfile: replace random() by rand()
Date: Fri,  5 Jun 2015 21:45:04 +0200
Message-ID: <06da8b5946687223276460be4db6348938df08a4.1433532967.git.j6t@kdbg.org>
References: <55700F10.8030806@kdbg.org>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 05 21:45:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0xYw-0007tK-QV
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jun 2015 21:45:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752075AbbFETpu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2015 15:45:50 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:8226 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751444AbbFETpu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2015 15:45:50 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 3m3Dwr5r72z5tlG;
	Fri,  5 Jun 2015 21:45:48 +0200 (CEST)
Received: from dx.lan (localhost [127.0.0.1])
	by dx.site (Postfix) with ESMTP id 698B21D0;
	Fri,  5 Jun 2015 21:45:47 +0200 (CEST)
X-Mailer: git-send-email 2.3.2.245.gb5bf9d3
In-Reply-To: <55700F10.8030806@kdbg.org>
In-Reply-To: <cover.1433532967.git.j6t@kdbg.org>
References: <cover.1433532967.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270879>

On Windows, we do not have functions srandom() and random(). Use srand()
and rand(). These functions produce random numbers of lesser quality,
but for the purpose (a retry time-out) they are still good enough.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 This is the same version I posted earlier.

 lockfile.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index 30e65e9..738f202 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -191,7 +191,7 @@ static int lock_file_timeout(struct lock_file *lk, const char *path,
 		return lock_file(lk, path, flags);
 
 	if (!random_initialized) {
-		srandom((unsigned int)getpid());
+		srand((unsigned int)getpid());
 		random_initialized = 1;
 	}
 
@@ -218,7 +218,7 @@ static int lock_file_timeout(struct lock_file *lk, const char *path,
 
 		backoff_ms = multiplier * INITIAL_BACKOFF_MS;
 		/* back off for between 0.75*backoff_ms and 1.25*backoff_ms */
-		wait_us = (750 + random() % 500) * backoff_ms;
+		wait_us = (750 + rand() % 500) * backoff_ms;
 		sleep_microseconds(wait_us);
 		remaining_us -= wait_us;
 
-- 
2.3.2.245.gb5bf9d3
