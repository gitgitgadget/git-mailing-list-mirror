From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v2] i18n: format_tracking_info "Your branch is behind" message
Date: Thu,  2 Feb 2012 09:37:19 +0800
Message-ID: <1328146639-87863-1-git-send-email-worldhello.net@gmail.com>
Cc: Jiang Xin <worldhello.net@gmail.com>
To: Git List <git@vger.kernel.org>, avarab@gmail.com
X-From: git-owner@vger.kernel.org Thu Feb 02 02:37:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RslcL-0006CA-0l
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 02:37:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753988Ab2BBBhg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Feb 2012 20:37:36 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:40052 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753505Ab2BBBhf (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Feb 2012 20:37:35 -0500
Received: by obcva7 with SMTP id va7so2093056obc.19
        for <git@vger.kernel.org>; Wed, 01 Feb 2012 17:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=k1YzgIvnrMJ6n9jNFt7yx04UYGi9udQ1O4Bxd4eYwgs=;
        b=mre7c+U1Q2Fxihp0Tm4/2xwBs3GrXaK/5dwSri+oYkF1/bTqjxzbEov8geX4ZLfevz
         1oGnoNK2DmNp+2oToB8E5U1wu82BWfmdbgIaDy50Bpuc28PGD1AhwLTOIQSN+WYkusZd
         j3u1M3OWt8ccRQXwHVf2yQ7XMMQF5EitGs54M=
Received: by 10.50.219.225 with SMTP id pr1mr1066503igc.23.1328146654787;
        Wed, 01 Feb 2012 17:37:34 -0800 (PST)
Received: from localhost.localdomain (li380-141.members.linode.com. [106.187.37.141])
        by mx.google.com with ESMTPS id wn6sm17003937igb.3.2012.02.01.17.37.31
        (version=SSLv3 cipher=OTHER);
        Wed, 01 Feb 2012 17:37:34 -0800 (PST)
X-Mailer: git-send-email 1.7.9.109.gd927b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189568>

Function format_tracking_info in remote.c is called by
wt_status_print_tracking in wt-status.c, which will print
branch tracking message in git-status. git-checkout also
show these messages through it's report_tracking function.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 remote.c |   48 +++++++++++++++++++++++++++++++++++++-----------
 1 files changed, 37 insertions(+), 11 deletions(-)

diff --git a/remote.c b/remote.c
index 73a38..45ac1 100644
--- a/remote.c
+++ b/remote.c
@@ -1572,19 +1572,45 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb)
 	base = branch->merge[0]->dst;
 	base = shorten_unambiguous_ref(base, 0);
 	if (!num_theirs)
-		strbuf_addf(sb, "Your branch is ahead of '%s' "
-			    "by %d commit%s.\n",
-			    base, num_ours, (num_ours == 1) ? "" : "s");
+		strbuf_addf(sb,
+			Q_(
+			/* The singular version */
+			"Your branch is ahead of '%s' by %d commit.\n",
+			/* The plural version */
+			"Your branch is ahead of '%s' by %d commits.\n",
+			/* Give ngettext() the count */
+			num_ours),
+			base,
+			num_ours);
 	else if (!num_ours)
-		strbuf_addf(sb, "Your branch is behind '%s' "
-			    "by %d commit%s, "
-			    "and can be fast-forwarded.\n",
-			    base, num_theirs, (num_theirs == 1) ? "" : "s");
+		strbuf_addf(sb,
+			Q_(
+			/* The singular version */
+			"Your branch is behind '%s' by %d commit, "
+			"and can be fast-forwarded.\n",
+			/* The plural version */
+			"Your branch is behind '%s' by %d commits, "
+			"and can be fast-forwarded.\n",
+			/* Give ngettext() the count */
+			num_theirs),
+			base,
+			num_theirs);
 	else
-		strbuf_addf(sb, "Your branch and '%s' have diverged,\n"
-			    "and have %d and %d different commit(s) each, "
-			    "respectively.\n",
-			    base, num_ours, num_theirs);
+		strbuf_addf(sb,
+			Q_(
+			/* The singular version */
+			"Your branch and '%s' have diverged,\n"
+			"and have %d and %d different commit each, "
+			"respectively.\n",
+			/* The plural version */
+			"Your branch and '%s' have diverged,\n"
+			"and have %d and %d different commits each, "
+			"respectively.\n",
+			/* Give ngettext() the count */
+			num_theirs),
+			base,
+			num_ours,
+			num_theirs);
 	return 1;
 }
 
-- 
1.7.9.109.gd927b
