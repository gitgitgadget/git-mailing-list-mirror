From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [WIP PATCH 22/22] A merge should not be printed anyway
Date: Sat, 24 Jul 2010 23:13:54 +0800
Message-ID: <1279984434-28933-23-git-send-email-struggleyb.nku@gmail.com>
References: <1279984434-28933-1-git-send-email-struggleyb.nku@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 24 17:16:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcgSS-0002K0-IQ
	for gcvg-git-2@lo.gmane.org; Sat, 24 Jul 2010 17:16:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756312Ab0GXPPp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jul 2010 11:15:45 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:58504 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756172Ab0GXPPm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jul 2010 11:15:42 -0400
Received: by mail-pw0-f46.google.com with SMTP id 5so3932862pwi.19
        for <git@vger.kernel.org>; Sat, 24 Jul 2010 08:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=56+y4EifXnJurdLKqcQ7j0c2cR/DVffB4Zm3itiQTHs=;
        b=TkLajZsu0c801mPfyCagR3iL1w5SaD0XawQw4aMyS4ZVJanIB1ZKm5uRcuhKoWEV3U
         anrK7QDNdmAAw9m3i4otLOlxFvuCXKnIHg9hghaYO7EcV984JScgffr8Dzcfd6ayVfXC
         xpQ7bdD0Ypte90twPpgYZPzIqqE5rMBfjzIa4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        b=hbGS276MAU5k10ofsuLdCUFV8lX8wHEekyR4mDIyJefkMgN0zgCISVz6JVSG9T+hYV
         pYbbZqmOL+7xpI4c5M339iwl9hk/tpTXqVkgbODTemSjnJ3c8Blyie2i2oU1T5eZO6qm
         yI57kTQArUsoNemnm5CNKxApPXcR71vK4NsPU=
Received: by 10.142.207.9 with SMTP id e9mr5987146wfg.143.1279984542580;
        Sat, 24 Jul 2010 08:15:42 -0700 (PDT)
Received: from localhost.localdomain ([58.68.143.121])
        by mx.google.com with ESMTPS id w8sm1705169wfd.19.2010.07.24.08.15.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 24 Jul 2010 08:15:42 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.rc3.80.g6f8ea9.dirty
In-Reply-To: <1279984434-28933-1-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151652>

Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
---
 line.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/line.c b/line.c
index bc9fc76..5782003 100644
--- a/line.c
+++ b/line.c
@@ -1023,8 +1023,6 @@ static void assign_parents_range(struct rev_info *rev, struct commit *commit)
 	 * be an evil merge.
 	 */
 	copy = diff_line_range_clone_deeply(r);
-	/* Never print out any diff for a merge commit */
-	commit->object.flags &= ~NEED_PRINT;
 	parents = commit->parents;
 	while (parents) {
 		struct commit *p = parents->item;
@@ -1059,6 +1057,8 @@ static void assign_parents_range(struct rev_info *rev, struct commit *commit)
 			commit->parents = parents;
 			parents = parents->next;
 			commit->parents->next = NULL;
+
+			/* free the non-use commit_list */
 			while (parents) {
 				struct commit_list *list = parents;
 				parents = parents->next;
@@ -1084,6 +1084,9 @@ static void assign_parents_range(struct rev_info *rev, struct commit *commit)
 	}
 
 out:
+	/* Never print out any diff for a merge commit */
+	commit->object.flags &= ~NEED_PRINT;
+
 	parents = commit->parents;
 	while (parents) {
 		state = lookup_decoration(&parents_state, &parents->item->object);
-- 
1.7.0.2.273.gc2413.dirty
