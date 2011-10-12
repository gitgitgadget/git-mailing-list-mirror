From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 6/7] write_ref_sha1(): only invalidate the loose ref cache
Date: Wed, 12 Oct 2011 20:44:26 +0200
Message-ID: <1318445067-19279-7-git-send-email-mhagger@alum.mit.edu>
References: <7vty7ggzum.fsf@alter.siamese.dyndns.org>
 <1318445067-19279-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 12 20:50:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RE3sV-0006Yt-Ow
	for gcvg-git-2@lo.gmane.org; Wed, 12 Oct 2011 20:50:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754018Ab1JLStu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Oct 2011 14:49:50 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:58236 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753978Ab1JLStt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2011 14:49:49 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RE3mc-0008JO-7y; Wed, 12 Oct 2011 20:44:02 +0200
X-Mailer: git-send-email 1.7.7.rc2
In-Reply-To: <1318445067-19279-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183397>

Since write_ref_sha1() can only write loose refs and cannot write
symbolic refs, there is no need for it to invalidate the packed ref
cache.

Suggested by: Martin Fick <mfick@codeaurora.org>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/refs.c b/refs.c
index 9d962bd..9e9edf7 100644
--- a/refs.c
+++ b/refs.c
@@ -1534,7 +1534,7 @@ int write_ref_sha1(struct ref_lock *lock,
 		unlock_ref(lock);
 		return -1;
 	}
-	invalidate_ref_cache(NULL);
+	clear_cached_loose_refs(get_cached_refs(NULL));
 	if (log_ref_write(lock->ref_name, lock->old_sha1, sha1, logmsg) < 0 ||
 	    (strcmp(lock->ref_name, lock->orig_ref_name) &&
 	     log_ref_write(lock->orig_ref_name, lock->old_sha1, sha1, logmsg) < 0)) {
-- 
1.7.7.rc2
