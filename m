From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v3] i18n: format_tracking_info "Your branch is behind" message
Date: Thu,  2 Feb 2012 10:02:23 +0800
Message-ID: <1328148143-88593-1-git-send-email-worldhello.net@gmail.com>
Cc: Jiang Xin <worldhello.net@gmail.com>
To: Git List <git@vger.kernel.org>, avarab@gmail.com,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 03:02:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rsm0Z-0008IE-ER
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 03:02:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754339Ab2BBCCj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Feb 2012 21:02:39 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:46377 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753509Ab2BBCCi (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Feb 2012 21:02:38 -0500
Received: by obcva7 with SMTP id va7so2118990obc.19
        for <git@vger.kernel.org>; Wed, 01 Feb 2012 18:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=RjHmqtIUTmPrXG2Zp24Ate4UZhqCranMm0QyjN3nYp4=;
        b=xHb2L+HlN+4lCjM8P7RlY1KZU2XXmiEPZvVvW+IsBwV67vvhpFlAZfDtOorJTf9Nqx
         +S+JUqQLxnHJcBViMjmb9vQcjkJ1sLTuSHaCfLsgecT5G/vQQVAGvxdLcfEX1f8via69
         8xCAimz0OVdKTtLcJG1MZ27YtVJHxSZxrcATw=
Received: by 10.182.41.5 with SMTP id b5mr782066obl.79.1328148157875;
        Wed, 01 Feb 2012 18:02:37 -0800 (PST)
Received: from localhost.localdomain (li380-141.members.linode.com. [106.187.37.141])
        by mx.google.com with ESMTPS id q5sm10928805obl.2.2012.02.01.18.02.35
        (version=SSLv3 cipher=OTHER);
        Wed, 01 Feb 2012 18:02:37 -0800 (PST)
X-Mailer: git-send-email 1.7.9.109.gd927b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189575>

Function format_tracking_info in remote.c is called by
wt_status_print_tracking in wt-status.c, which will print
branch tracking message in git-status. git-checkout also
show these messages through it's report_tracking function.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 remote.c |   32 +++++++++++++++++++++-----------
 1 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/remote.c b/remote.c
index 73a38..af597 100644
--- a/remote.c
+++ b/remote.c
@@ -1572,19 +1572,29 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb)
 	base = branch->merge[0]->dst;
 	base = shorten_unambiguous_ref(base, 0);
 	if (!num_theirs)
-		strbuf_addf(sb, "Your branch is ahead of '%s' "
-			    "by %d commit%s.\n",
-			    base, num_ours, (num_ours == 1) ? "" : "s");
+		strbuf_addf(sb,
+			Q_("Your branch is ahead of '%s' by %d commit.\n",
+			   "Your branch is ahead of '%s' by %d commits.\n",
+			   num_ours),
+			base, num_ours);
 	else if (!num_ours)
-		strbuf_addf(sb, "Your branch is behind '%s' "
-			    "by %d commit%s, "
-			    "and can be fast-forwarded.\n",
-			    base, num_theirs, (num_theirs == 1) ? "" : "s");
+		strbuf_addf(sb,
+			Q_("Your branch is behind '%s' by %d commit, "
+			       "and can be fast-forwarded.\n",
+			   "Your branch is behind '%s' by %d commits, "
+			       "and can be fast-forwarded.\n",
+			   num_theirs),
+			base, num_theirs);
 	else
-		strbuf_addf(sb, "Your branch and '%s' have diverged,\n"
-			    "and have %d and %d different commit(s) each, "
-			    "respectively.\n",
-			    base, num_ours, num_theirs);
+		strbuf_addf(sb,
+			Q_("Your branch and '%s' have diverged,\n"
+			       "and have %d and %d different commit each, "
+			       "respectively.\n",
+			   "Your branch and '%s' have diverged,\n"
+			       "and have %d and %d different commits each, "
+			       "respectively.\n",
+			   num_theirs),
+			base, num_ours, num_theirs);
 	return 1;
 }
 
-- 
1.7.9.109.gd927b
