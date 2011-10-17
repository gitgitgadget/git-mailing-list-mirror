From: mhagger@alum.mit.edu
Subject: [PATCH v4 6/7] write_ref_sha1(): only invalidate the loose ref cache
Date: Mon, 17 Oct 2011 04:38:10 +0200
Message-ID: <1318819091-7066-7-git-send-email-mhagger@alum.mit.edu>
References: <1318819091-7066-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 17 04:39:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFd6X-00026B-Ay
	for gcvg-git-2@lo.gmane.org; Mon, 17 Oct 2011 04:39:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754382Ab1JQCiy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Oct 2011 22:38:54 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:45419 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754325Ab1JQCiu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Oct 2011 22:38:50 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BECB73.dip.t-dialin.net [84.190.203.115])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p9H2cN3Y013403;
	Mon, 17 Oct 2011 04:38:36 +0200
X-Mailer: git-send-email 1.7.7.rc2
In-Reply-To: <1318819091-7066-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183758>

From: Michael Haggerty <mhagger@alum.mit.edu>

Since write_ref_sha1() can only write loose refs and cannot write
symbolic refs, there is no need for it to invalidate the packed ref
cache.

Suggested by: Martin Fick <mfick@codeaurora.org>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/refs.c b/refs.c
index 2a21dc3..a888cea 100644
--- a/refs.c
+++ b/refs.c
@@ -1534,7 +1534,7 @@ int write_ref_sha1(struct ref_lock *lock,
 		unlock_ref(lock);
 		return -1;
 	}
-	invalidate_ref_cache(NULL);
+	clear_loose_ref_cache(get_ref_cache(NULL));
 	if (log_ref_write(lock->ref_name, lock->old_sha1, sha1, logmsg) < 0 ||
 	    (strcmp(lock->ref_name, lock->orig_ref_name) &&
 	     log_ref_write(lock->orig_ref_name, lock->old_sha1, sha1, logmsg) < 0)) {
-- 
1.7.7.rc2
