From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH v2 3/5] unpack-trees: do not muck with attributes when we
 are not checking out
Date: Sat, 18 Apr 2009 00:18:01 +0200
Message-ID: <49E90019.9030606@lsrfire.ath.cx>
References: <1239848917-14399-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 18 00:20:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LuwQ3-0000iT-Ba
	for gcvg-git-2@gmane.org; Sat, 18 Apr 2009 00:20:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762178AbZDQWSK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2009 18:18:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762149AbZDQWSJ
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Apr 2009 18:18:09 -0400
Received: from india601.server4you.de ([85.25.151.105]:46216 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761657AbZDQWSF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2009 18:18:05 -0400
Received: from [10.0.1.101] (p57B7DF1E.dip.t-dialin.net [87.183.223.30])
	by india601.server4you.de (Postfix) with ESMTPSA id 806642F8195;
	Sat, 18 Apr 2009 00:18:04 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <1239848917-14399-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116795>

From: Junio C Hamano <gitster@pobox.com>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 unpack-trees.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 6847c2d..e4eb8fa 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -87,7 +87,8 @@ static int check_updates(struct unpack_trees_options *o)
 		cnt = 0;
 	}
 
-	git_attr_set_direction(GIT_ATTR_CHECKOUT, &o->result);
+	if (o->update)
+		git_attr_set_direction(GIT_ATTR_CHECKOUT, &o->result);
 	for (i = 0; i < index->cache_nr; i++) {
 		struct cache_entry *ce = index->cache[i];
 
@@ -112,7 +113,8 @@ static int check_updates(struct unpack_trees_options *o)
 		}
 	}
 	stop_progress(&progress);
-	git_attr_set_direction(GIT_ATTR_CHECKIN, NULL);
+	if (o->update)
+		git_attr_set_direction(GIT_ATTR_CHECKIN, NULL);
 	return errs != 0;
 }
 
-- 
1.6.3.rc0
