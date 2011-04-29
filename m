From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [RFC/largely untested/PATCH] sha1_name: interpret ~n as HEAD~n
Date: Fri, 29 Apr 2011 17:53:15 +0200
Message-ID: <6c53916752bf79178113157291fd675ead0804c9.1304092338.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 17:53:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFq0R-0007mC-Uq
	for gcvg-git-2@lo.gmane.org; Fri, 29 Apr 2011 17:53:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757894Ab1D2PxS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2011 11:53:18 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:50246 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755724Ab1D2PxS (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Apr 2011 11:53:18 -0400
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 84F0B20770
	for <git@vger.kernel.org>; Fri, 29 Apr 2011 11:53:17 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute4.internal (MEProxy); Fri, 29 Apr 2011 11:53:17 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:subject:date:message-id; s=smtpout; bh=LXuclMbIzSN3f4fEm1fLB6QTJyg=; b=SjLZbut+vJ/8ApiTEBYO90sU8A7zucDg2CUG/ihxwyxaUU/VbeKUi423cq/U+qT+5aiwyuwTOMJyZwEVgKyS3bmVCSBMAa7UTg6VQs1dgxxs6753x1K6G5ott+FcPZ5N8lFNqez79I4bt+zZWwdmSW7mZ4P+6XO4+VMi2Tpomio=
X-Sasl-enc: DsHjL5hnH8p+1jYNhlPWE0lxIYxVsZWV+ARshlOujNP2 1304092397
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 0127D4042DA;
	Fri, 29 Apr 2011 11:53:16 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.250.g4493b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172458>

HEAD~n is often used for rebase invocations etc. Make it use the same
default we use in other places, i.e. ~n == HEAD~n.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
I haven't checked the side effects but find this super useful. Stop
me right now if this is a bad idea...

An alternative patch subject for this would have been:

sha1_name: We don't need no hg revision numbers, stupid!
---
 sha1_name.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 69cd6c8..5d52eac 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -480,7 +480,10 @@ static int get_nth_ancestor(const char *name, int len,
 	struct commit *commit;
 	int ret;
 
-	ret = get_sha1_1(name, len, sha1);
+	if (len)
+		ret = get_sha1_1(name, len, sha1);
+	else
+		ret = get_sha1("HEAD", sha1);
 	if (ret)
 		return ret;
 	commit = lookup_commit_reference(sha1);
-- 
1.7.5.250.g4493b
