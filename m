From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v16 2/7] bisect: use && to connect statements that are deferred with eval.
Date: Thu,  4 Aug 2011 07:57:01 +1000
Message-ID: <1312408626-8600-3-git-send-email-jon.seymour@gmail.com>
References: <1312408626-8600-1-git-send-email-jon.seymour@gmail.com>
Cc: chriscool@tuxfamily.org, gitster@pobox.com, j6t@kdbg.org,
	jnareb@gmail.com, jrnieder@gmail.com,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 03 23:58:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QojS0-0007IA-CQ
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 23:58:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755481Ab1HCV6C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Aug 2011 17:58:02 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:62852 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755380Ab1HCV6A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 17:58:00 -0400
Received: by ywn13 with SMTP id 13so737844ywn.19
        for <git@vger.kernel.org>; Wed, 03 Aug 2011 14:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=wJu03UGArmXqD4uJG0xwGgACEbxICZiDDdppqMEZLVI=;
        b=Fwnt/vpRUSSWFV52Vh8t6hNkGg35oV2OaRAZRNeixWJ7HvFJkiYgeHNAcJQ0Qzb4rG
         agKfBD61I5z4lzNuG2vBfyNgYhBi6zH7ypwPKfSXahWmPmztE0mHN/6hpEB0SnNwepNv
         CTZh/inLFgG/46GwgSnPTh8cP6cnZFK+RrQFg=
Received: by 10.150.239.4 with SMTP id m4mr1150109ybh.369.1312408680216;
        Wed, 03 Aug 2011 14:58:00 -0700 (PDT)
Received: from localhost.localdomain ([120.16.210.46])
        by mx.google.com with ESMTPS id e7sm625568ybg.18.2011.08.03.14.57.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 03 Aug 2011 14:57:59 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.352.g172e
In-Reply-To: <1312408626-8600-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178631>

Christian Couder pointed out that the existing eval strategy
swallows an initial non-zero return. Using && to connect
the statements should fix this.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 git-bisect.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 20f6dd5..a44ffe1 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -86,7 +86,7 @@ bisect_start() {
 		0) state='bad' ; bad_seen=1 ;;
 		*) state='good' ;;
 		esac
-		eval="$eval bisect_write '$state' '$rev' 'nolog'; "
+		eval="$eval bisect_write '$state' '$rev' 'nolog' &&"
 		shift
 		;;
 	    esac
@@ -145,7 +145,7 @@ bisect_start() {
 	#
 	echo "$start_head" >"$GIT_DIR/BISECT_START" &&
 	git rev-parse --sq-quote "$@" >"$GIT_DIR/BISECT_NAMES" &&
-	eval "$eval" &&
+	eval "$eval true" &&
 	echo "git bisect start$orig_args" >>"$GIT_DIR/BISECT_LOG" || exit
 	#
 	# Check if we can proceed to the next bisect state.
-- 
1.7.6.352.g172e
