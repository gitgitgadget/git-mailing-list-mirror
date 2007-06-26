From: Sven Verdoolaege <skimo@liacs.nl>
Subject: [PATCH] Ignore submodule commits when fetching over dumb protocols
Date: Tue, 26 Jun 2007 23:19:41 +0200
Message-ID: <20070626211940.GA27221@liacs.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 26 23:20:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3ISU-0003QC-0a
	for gcvg-git@gmane.org; Tue, 26 Jun 2007 23:20:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758355AbXFZVUU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Jun 2007 17:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758338AbXFZVUU
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jun 2007 17:20:20 -0400
Received: from rhodium.liacs.nl ([132.229.131.16]:39679 "EHLO rhodium.liacs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758228AbXFZVUT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2007 17:20:19 -0400
Received: from pc117b.liacs.nl (pc117b.liacs.nl [132.229.129.143])
	by rhodium.liacs.nl (8.13.0/8.13.0/LIACS 1.4) with ESMTP id l5QLJfgT010989;
	Tue, 26 Jun 2007 23:19:46 +0200
Received: by pc117b.liacs.nl (Postfix, from userid 17122)
	id 642943C021; Tue, 26 Jun 2007 23:19:41 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50977>

Without this patch, the code would look for the submodule
commits in the superproject and (needlessly) fail when it
couldn't find them.

Signed-off-by: Sven Verdoolaege <skimo@liacs.nl>
---
 fetch.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/fetch.c b/fetch.c
index dda33e5..811be87 100644
--- a/fetch.c
+++ b/fetch.c
@@ -46,6 +46,9 @@ static int process_tree(struct tree *tree)
 	while (tree_entry(&desc, &entry)) {
 		struct object *obj = NULL;
 
+		/* submodule commits are not stored in the superproject */
+		if (S_ISGITLINK(entry.mode))
+			continue;
 		if (S_ISDIR(entry.mode)) {
 			struct tree *tree = lookup_tree(entry.sha1);
 			if (tree)
-- 
1.5.2.2.549.gaeb59
