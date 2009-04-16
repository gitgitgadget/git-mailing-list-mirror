From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/5] unpack-trees: do not muck with attributes when we are
 not checking out
Date: Wed, 15 Apr 2009 19:28:35 -0700
Message-ID: <1239848917-14399-4-git-send-email-gitster@pobox.com>
References: <1239848917-14399-1-git-send-email-gitster@pobox.com>
 <1239848917-14399-2-git-send-email-gitster@pobox.com>
 <1239848917-14399-3-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 16 04:31:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LuHNe-0000r0-Pq
	for gcvg-git-2@gmane.org; Thu, 16 Apr 2009 04:31:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754278AbZDPC2w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2009 22:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757034AbZDPC2w
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Apr 2009 22:28:52 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62650 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756362AbZDPC2v (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2009 22:28:51 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id ACB26AA3BC
	for <git@vger.kernel.org>; Wed, 15 Apr 2009 22:28:50 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 1985EAA3BB for
 <git@vger.kernel.org>; Wed, 15 Apr 2009 22:28:49 -0400 (EDT)
X-Mailer: git-send-email 1.6.3.rc0.6.g08087
In-Reply-To: <1239848917-14399-3-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 52642190-2A2E-11DE-BC9E-C121C5FC92D5-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116661>

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
1.6.3.rc0.6.g08087
