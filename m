From: Albert Yale <surfingalbert@gmail.com>
Subject: [PATCH v2] Fix the result of "git grep [-l|-L] -C <num>"
Date: Mon, 23 Jan 2012 12:06:15 -0500
Message-ID: <1327338375-48917-1-git-send-email-surfingalbert@gmail.com>
Cc: trast@student.ethz.ch, rene.scharfe@lsrfire.ath.cx,
	Albert Yale <surfingalbert@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 23 18:06:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RpNLf-0005EF-0x
	for gcvg-git-2@lo.gmane.org; Mon, 23 Jan 2012 18:06:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751406Ab2AWRGV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jan 2012 12:06:21 -0500
Received: from mail-qw0-f53.google.com ([209.85.216.53]:54271 "EHLO
	mail-qw0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750831Ab2AWRGV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jan 2012 12:06:21 -0500
Received: by qabg24 with SMTP id g24so1887761qab.19
        for <git@vger.kernel.org>; Mon, 23 Jan 2012 09:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=r9IBf5lng+UyRZK2SEyeYn7BqsF2D70Bur3T90GPKUM=;
        b=FQqeumITV94HgtAfEehfSptS66RmC1BL1fw/tFjqYD4YJx+ZJzfetNqqCeVnnhOolz
         YaRijYP1zR1Zb5DRFXRDO6hF+RVfs2lmNnZB1oQZF82U6sL8AuEXXa4fklZ0ngX7Mhal
         KlyhiK7wqrm41gdwHvZQCt7TmD3D6KSzyujzo=
Received: by 10.224.194.129 with SMTP id dy1mr10274053qab.52.1327338380371;
        Mon, 23 Jan 2012 09:06:20 -0800 (PST)
Received: from f.uze.ca.uze.ca (modemcable104.125-21-96.mc.videotron.ca. [96.21.125.104])
        by mx.google.com with ESMTPS id r10sm27865167qaz.7.2012.01.23.09.06.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 23 Jan 2012 09:06:19 -0800 (PST)
X-Mailer: git-send-email 1.7.7.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188999>

When combining "git grep [-l|-L]" with "-C <num>",
the first result is omitted.

Reviewed-by: Thomas Rast <trast@student.ethz.ch>
Signed-off-by: Albert Yale <surfingalbert@gmail.com>
---
 builtin/grep.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 9ce064a..beebe20 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -1036,7 +1036,10 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	if (use_threads) {
 		if (opt.pre_context || opt.post_context || opt.file_break ||
 		    opt.funcbody)
-			skip_first_line = 1;
+		{
+			if( ! ( opt.name_only || opt.unmatch_name_only ) )
+				skip_first_line = 1;
+		}
 		start_threads(&opt);
 	}
 #endif
-- 
1.7.8.3
