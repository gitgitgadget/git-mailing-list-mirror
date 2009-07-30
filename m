From: Michal Marek <mmarek@suse.cz>
Subject: [PATCH] checkout: hide progress bar when stderr is not a tty
Date: Thu, 30 Jul 2009 18:13:34 +0200
Message-ID: <1248970414-21851-1-git-send-email-mmarek@suse.cz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 30 18:14:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWYGY-0000ci-6r
	for gcvg-git-2@gmane.org; Thu, 30 Jul 2009 18:14:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751556AbZG3QNx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jul 2009 12:13:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751485AbZG3QNw
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jul 2009 12:13:52 -0400
Received: from cantor.suse.de ([195.135.220.2]:33865 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751385AbZG3QNr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jul 2009 12:13:47 -0400
Received: from relay2.suse.de (relay-ext.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id C6E66749C2
	for <git@vger.kernel.org>; Thu, 30 Jul 2009 18:13:47 +0200 (CEST)
Received: by sepie.suse.cz (Postfix, from userid 10020)
	id 71E4976678; Thu, 30 Jul 2009 18:13:46 +0200 (CEST)
X-Mailer: git-send-email 1.6.4.13.ge6580.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124468>

The correct fix would be in start_progress_delay(), however this breaks
the progress bar for fetch/push via ssh. So fix it in this caller which
will always run locally.

Signed-off-by: Michal Marek <mmarek@suse.cz>
---
 unpack-trees.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 720f7a1..a11f559 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -75,7 +75,7 @@ static int check_updates(struct unpack_trees_options *o)
 	int i;
 	int errs = 0;
 
-	if (o->update && o->verbose_update) {
+	if (o->update && o->verbose_update && isatty(STDERR_FILENO)) {
 		for (total = cnt = 0; cnt < index->cache_nr; cnt++) {
 			struct cache_entry *ce = index->cache[cnt];
 			if (ce->ce_flags & (CE_UPDATE | CE_REMOVE))
-- 
1.6.4.13.ge6580.dirty
