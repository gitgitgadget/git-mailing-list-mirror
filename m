From: David Aguilar <davvid@gmail.com>
Subject: [PATCH] mergetools,difftool: fix printf usage
Date: Sat,  9 Feb 2013 17:21:25 -0800
Message-ID: <1360459285-88709-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, Asheesh Laroia <asheesh@asheesh.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 02:21:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4LcA-0000ih-1I
	for gcvg-git-2@plane.gmane.org; Sun, 10 Feb 2013 02:21:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760915Ab3BJBV1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2013 20:21:27 -0500
Received: from mail-ia0-f181.google.com ([209.85.210.181]:56560 "EHLO
	mail-ia0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760897Ab3BJBV0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2013 20:21:26 -0500
Received: by mail-ia0-f181.google.com with SMTP id l29so1778105iag.40
        for <git@vger.kernel.org>; Sat, 09 Feb 2013 17:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=/OiH7Xg4ghZQS1wLfZIZAO+BAGCWcSur8FGa92Gz6Ho=;
        b=d3mjJViaZ6R6sd5/0AucWQKshtnz9d0vljdJEDd3MuEDwSzil44RVo73kWRvk7or1j
         EYDxMapb4Jzk43AesIH0FlDlOJdiGtVTMGPjL8IArFKwEIgch/WG50B3QfBYzYxDgQ2D
         +7cwBk1hUy/MrvhAoFwKM1FYeWBx4dOGCRM9ZQ4E+ObY5oANd1Pe2CUH82lrCzAR9GPv
         5/iSn2GyMnTnr/AnWefZYP5W8ko6RAIM6Dp01jmINlfvOWmFBEIQSXXg2uPSLTtXsPZs
         RmZYBdqtisZRiF0/W0QjXkMPM6GjM5smL2iBdvQlAbRZS75df36P/iqOvRl3FWeaET18
         w3gw==
X-Received: by 10.50.57.164 with SMTP id j4mr8578290igq.91.1360459284642;
        Sat, 09 Feb 2013 17:21:24 -0800 (PST)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPS id as6sm20530596igc.8.2013.02.09.17.21.22
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 09 Feb 2013 17:21:23 -0800 (PST)
X-Mailer: git-send-email 1.8.1.3.696.gfd94e3d.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215890>

Prevent environment variables and filenames from masquerading
as format strings for printf.

Reported-by: Asheesh Laroia <asheesh@asheesh.org>
Signed-off-by: David Aguilar <davvid@gmail.com>
---
 git-difftool--helper.sh | 2 +-
 mergetools/p4merge      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-difftool--helper.sh b/git-difftool--helper.sh
index 3d0fe0c..b00ed95 100755
--- a/git-difftool--helper.sh
+++ b/git-difftool--helper.sh
@@ -40,7 +40,7 @@ launch_merge_tool () {
 	# the user with the real $MERGED name before launching $merge_tool.
 	if should_prompt
 	then
-		printf "\nViewing: '$MERGED'\n"
+		printf "\nViewing: '%s'\n" "$MERGED"
 		if use_ext_cmd
 		then
 			printf "Launch '%s' [Y/n]: " \
diff --git a/mergetools/p4merge b/mergetools/p4merge
index 52f7c8f..8a36916 100644
--- a/mergetools/p4merge
+++ b/mergetools/p4merge
@@ -30,5 +30,5 @@ create_empty_file () {
 	empty_file="${TMPDIR:-/tmp}/git-difftool-p4merge-empty-file.$$"
 	>"$empty_file"
 
-	printf "$empty_file"
+	printf "%s" "$empty_file"
 }
-- 
1.8.1.3.696.gfd94e3d.dirty
