From: Andreas Gruenbacher <agruen@suse.de>
Subject: [PATCH 1/9] fetch: Check for a "^{}" suffix with suffixcmp()
Date: Sat, 13 Mar 2010 18:17:04 +0100
Message-ID: <f2bf11648d2cfb58e348d2c8caffa841012fd994.1268913163.git.agruen@suse.de>
References: <cover.1268913163.git.agruen@suse.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 18 12:55:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsEK9-0001wv-2J
	for gcvg-git-2@lo.gmane.org; Thu, 18 Mar 2010 12:55:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752937Ab0CRLz3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Mar 2010 07:55:29 -0400
Received: from cantor.suse.de ([195.135.220.2]:53035 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752723Ab0CRLz0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Mar 2010 07:55:26 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id DD31790847
	for <git@vger.kernel.org>; Thu, 18 Mar 2010 12:55:25 +0100 (CET)
In-Reply-To: <cover.1268913163.git.agruen@suse.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142458>

Otherwise, we will check random bytes for ref names < 3 characters.

Signed-off-by: Andreas Gruenbacher <agruen@suse.de>
---
 builtin/fetch.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 2bb75c1..77031e2 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -590,7 +590,7 @@ static void find_non_local_tags(struct transport *transport,
 		 * to fetch then we can mark the ref entry in the list
 		 * as one to ignore by setting util to NULL.
 		 */
-		if (!strcmp(ref->name + strlen(ref->name) - 3, "^{}")) {
+		if (!suffixcmp(ref->name, "^{}")) {
 			if (item && !has_sha1_file(ref->old_sha1) &&
 			    !will_fetch(head, ref->old_sha1) &&
 			    !has_sha1_file(item->util) &&
-- 
1.7.0.2.273.gc2413
