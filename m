From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] refresh-index: fix bitmask assignment
Date: Sat, 19 Jul 2008 23:31:52 -0700
Message-ID: <7vtzelf4mf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 20 08:33:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKSTg-0008L4-TS
	for gcvg-git-2@gmane.org; Sun, 20 Jul 2008 08:33:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754680AbYGTGcF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 02:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755856AbYGTGcE
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 02:32:04 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:56851 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754680AbYGTGcC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 02:32:02 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id AAEA533E7E;
	Sun, 20 Jul 2008 02:31:58 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id AC00433E7D; Sun, 20 Jul 2008 02:31:54 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8DF7F62E-5625-11DD-BA23-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89163>

5fdeacb (Teach update-index about --ignore-submodules, 2008-05-14) added a
new refresh option flag but did not assign a unique bit for it correctly,
and broke "update-index --ignore-missing".

This should fix it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * The fact that it took this long for anybody to notice the breakage
   probably means that the "--ignore-missing" option in particular but the
   ability for plumbing to allow scripting in general is not utilized by
   as many people as the design initially envisioned.

 cache.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/cache.h b/cache.h
index ca382d4..9735b66 100644
--- a/cache.h
+++ b/cache.h
@@ -396,7 +396,7 @@ extern void fill_stat_cache_info(struct cache_entry *ce, struct stat *st);
 #define REFRESH_UNMERGED	0x0002	/* allow unmerged */
 #define REFRESH_QUIET		0x0004	/* be quiet about it */
 #define REFRESH_IGNORE_MISSING	0x0008	/* ignore non-existent */
-#define REFRESH_IGNORE_SUBMODULES	0x0008	/* ignore submodules */
+#define REFRESH_IGNORE_SUBMODULES	0x0010	/* ignore submodules */
 extern int refresh_index(struct index_state *, unsigned int flags, const char **pathspec, char *seen);
 
 struct lock_file {
-- 
1.5.6.4.570.g052e6
