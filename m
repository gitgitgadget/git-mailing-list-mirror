From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] merge-recursive: separate message for common ancestors
Date: Sun,  5 Aug 2012 19:56:38 +0200
Message-ID: <1344189398-27127-1-git-send-email-ralf.thielow@gmail.com>
Cc: gitster@pobox.com, worldhello.net@gmail.com,
	Ralf Thielow <ralf.thielow@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 05 19:57:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sy54p-0002Un-HN
	for gcvg-git-2@plane.gmane.org; Sun, 05 Aug 2012 19:57:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754843Ab2HER5I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Aug 2012 13:57:08 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:43347 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754742Ab2HER5G (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2012 13:57:06 -0400
Received: by bkwj10 with SMTP id j10so770031bkw.19
        for <git@vger.kernel.org>; Sun, 05 Aug 2012 10:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=OEy4vvorgdADeXHKNONVwVJSAWTnyBgqkhYjTnrMwcA=;
        b=jQpyqbVkQYVqMFoNbewl8094eiyoUFo/aUX+2F0gHh1+piVUsbBEDnfR0/KfJpkT1v
         +w9Jk7wcKGw1xTjEvjlqsKStahY9VnwUbMmmxqX7oja2T+OOY97hu3ugEQpGNZxDBd51
         q84qAJmz0LkxRVWIqtCgSfDp6RzGTEzt4hmQ4/ZMEm2j3FxU32JQ2RVG0OJcK+Gbtqte
         QxesCjDBw7OP9cEpvIcus/DUHZcLv++2wBA/xCo//UTV4dqO+jFNaJtmpxurvqbXXPQW
         yYQ90dNk8u2CrO/AUcYIvXLjVAJw32aiqMqweSveXqI7uBfiZMOOvcTYioYHmme3rnO1
         CPmg==
Received: by 10.204.130.156 with SMTP id t28mr3177225bks.33.1344189425586;
        Sun, 05 Aug 2012 10:57:05 -0700 (PDT)
Received: from rath.fedora (dslb-094-222-138-170.pools.arcor-ip.net. [94.222.138.170])
        by mx.google.com with ESMTPS id g6sm6427898bkg.2.2012.08.05.10.57.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 05 Aug 2012 10:57:05 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.rc1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202910>

The function "merge_recursive" prints the count of common
ancestors as "found %u common ancestor(s):". At least for
better translation, we should use a singular and a plural
form of this message.

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 merge-recursive.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 8903a73..39b2e16 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1915,7 +1915,10 @@ int merge_recursive(struct merge_options *o,
 	}
 
 	if (show(o, 5)) {
-		output(o, 5, _("found %u common ancestor(s):"), commit_list_count(ca));
+		unsigned cnt = commit_list_count(ca);
+
+		output(o, 5, Q_("found %u common ancestor:",
+				"found %u common ancestors:", cnt), cnt);
 		for (iter = ca; iter; iter = iter->next)
 			output_commit_title(o, iter->item);
 	}
-- 
1.7.12.rc1
