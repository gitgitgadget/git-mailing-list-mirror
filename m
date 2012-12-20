From: David Aguilar <davvid@gmail.com>
Subject: [PATCH] mergetools/p4merge: Honor $TMPDIR for the /dev/null placeholder
Date: Wed, 19 Dec 2012 20:45:54 -0800
Message-ID: <1355978754-7041-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 20 05:53:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlY7q-0005A2-VJ
	for gcvg-git-2@plane.gmane.org; Thu, 20 Dec 2012 05:52:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752459Ab2LTEwg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2012 23:52:36 -0500
Received: from mail-da0-f54.google.com ([209.85.210.54]:59752 "EHLO
	mail-da0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752194Ab2LTEwg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2012 23:52:36 -0500
X-Greylist: delayed 389 seconds by postgrey-1.27 at vger.kernel.org; Wed, 19 Dec 2012 23:52:35 EST
Received: by mail-da0-f54.google.com with SMTP id n2so1302625dad.41
        for <git@vger.kernel.org>; Wed, 19 Dec 2012 20:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=sJcy7c/B1j3j8xb1gjpRFrY8PyyLcS7ewpzyp8UBPwc=;
        b=BCBn1DCO0lRJzhlc7HfdwN4klT7Yf6yThPXkPg4sz1/4OEYfgJM8TaLID/Tme9LWSj
         w7qKV4gLb5i1/PX1GhY7W+UuFjhsNEWi0oMWSCMrgDuRvulZ+vie0XmAe+HSkoEzFCmL
         PJEK0kG914TPNgHLaVFH2bAZGudDMV8QpzIyWtUXAV+x+pQYki3APQNVjNoKLZvuF9AC
         6rCLI6t6ncjzqsyrADONg8GGGjsRyW6kDaeJZLdu81JV14LhXjP8RnttkIh16AM/wG21
         9WqQezY9jnHZM+nG/bwu2cQwpNxq/yOnqBZ1bf1a9hOTkEV9BmNtxvj6j8bAEXPFEWEO
         Sw/Q==
X-Received: by 10.68.225.232 with SMTP id rn8mr25799282pbc.34.1355978765163;
        Wed, 19 Dec 2012 20:46:05 -0800 (PST)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPS id is6sm4313711pbc.55.2012.12.19.20.46.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 19 Dec 2012 20:46:04 -0800 (PST)
X-Mailer: git-send-email 1.8.1.rc2.6.g18499ba
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211879>

Use mktemp to create the /dev/null placeholder for p4merge.
This keeps it out of the current directory.

Reported-by: Jeremy Morton <admin@game-point.net>
Signed-off-by: David Aguilar <davvid@gmail.com>
---
I consider this a final finishing touch on a new 1.8.1 feature,
so hopefully we can get this in before 1.8.1.

 mergetools/p4merge | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mergetools/p4merge b/mergetools/p4merge
index 295361a..090fa9b 100644
--- a/mergetools/p4merge
+++ b/mergetools/p4merge
@@ -4,13 +4,13 @@ diff_cmd () {
 	rm_remote=
 	if test "/dev/null" = "$LOCAL"
 	then
-		LOCAL="./p4merge-dev-null.LOCAL.$$"
+		LOCAL="$(create_empty_file)"
 		>"$LOCAL"
 		rm_local=true
 	fi
 	if test "/dev/null" = "$REMOTE"
 	then
-		REMOTE="./p4merge-dev-null.REMOTE.$$"
+		REMOTE="$(create_empty_file)"
 		>"$REMOTE"
 		rm_remote=true
 	fi
@@ -33,3 +33,7 @@ merge_cmd () {
 	"$merge_tool_path" "$BASE" "$LOCAL" "$REMOTE" "$MERGED"
 	check_unchanged
 }
+
+create_empty_file () {
+	mktemp -t git-difftool-p4merge-empty-file.XXXXXX
+}
-- 
1.8.1.rc2.6.g18499ba
