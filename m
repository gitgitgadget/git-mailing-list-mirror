From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] read_cache: cast types from stat to ce_cache
Date: Thu, 10 Jun 2010 11:15:03 +0200
Message-ID: <a06cc84698f174d914350d6fd6e6b4739d22aa45.1276161176.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 10 11:15:45 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMdrT-0006CU-Un
	for gcvg-git-2@lo.gmane.org; Thu, 10 Jun 2010 11:15:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758706Ab0FJJPj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jun 2010 05:15:39 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:57141 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753082Ab0FJJPi (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Jun 2010 05:15:38 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id D9EE8F8AB5;
	Thu, 10 Jun 2010 05:15:35 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Thu, 10 Jun 2010 05:15:37 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id; s=smtpout; bh=GKrIm0cAODiZF/ODdltNIUi4jec=; b=tFxKkx1zSaLB++I5USRFHJfxW63IXFhOWp5OHQEbgsuotj0ZzrrBuLXAEBwVJY1tzAyCdX7mCG6gZZjoOas9OKdI1tjllJ3OYHV7Z9i+ODEkedYWjqI0almqsSOX3cgXAMm+F8sVZjF4/g28lQKnJAQ88s6NXLJ5m+D/yqXLj5o=
X-Sasl-enc: w7sk2qqjAgOem8CFTtVzLOc7lJ1q+iltLJPtekvkB9EY 1276161335
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 2C5194CF625;
	Thu, 10 Jun 2010 05:15:35 -0400 (EDT)
X-Mailer: git-send-email 1.7.1.501.g23b46
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148845>

Cast the system dependent entries of struct stat to unsigned integers
for struct ce_cache just like in other places where we do this already,
to protect against any type conversion issues.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
This does not fix the "filesystem boundary issue" I reported, but I spotted
this when digging through read-cache.c. My device ids would have issues
when int = short.

 read-cache.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index e381ea5..aa9b847 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -72,11 +72,11 @@ void fill_stat_cache_info(struct cache_entry *ce, struct stat *st)
 	ce->ce_mtime.sec = (unsigned int)st->st_mtime;
 	ce->ce_ctime.nsec = ST_CTIME_NSEC(*st);
 	ce->ce_mtime.nsec = ST_MTIME_NSEC(*st);
-	ce->ce_dev = st->st_dev;
-	ce->ce_ino = st->st_ino;
-	ce->ce_uid = st->st_uid;
-	ce->ce_gid = st->st_gid;
-	ce->ce_size = st->st_size;
+	ce->ce_dev = (unsigned int)st->st_dev;
+	ce->ce_ino = (unsigned int)st->st_ino;
+	ce->ce_uid = (unsigned int)st->st_uid;
+	ce->ce_gid = (unsigned int)st->st_gid;
+	ce->ce_size = (unsigned int)st->st_size;
 
 	if (assume_unchanged)
 		ce->ce_flags |= CE_VALID;
-- 
1.7.1.501.g23b46
