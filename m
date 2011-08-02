From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v13 2/8] bisect: use && to connect statements that are deferred with eval.
Date: Tue,  2 Aug 2011 21:28:59 +1000
Message-ID: <1312284545-2426-3-git-send-email-jon.seymour@gmail.com>
References: <1312284545-2426-1-git-send-email-jon.seymour@gmail.com>
Cc: chriscool@tuxfamily.org, gitster@pobox.com, j6t@kdbg.org,
	jnareb@gmail.com, Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 02 13:30:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoDAm-0004Rs-1L
	for gcvg-git-2@lo.gmane.org; Tue, 02 Aug 2011 13:30:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754000Ab1HBLaF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Aug 2011 07:30:05 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:51756 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753952Ab1HBLaB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2011 07:30:01 -0400
Received: by yxi11 with SMTP id 11so3685327yxi.19
        for <git@vger.kernel.org>; Tue, 02 Aug 2011 04:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=wTgLpuH4gXcYBdwf1C7bEIHPdZ9MnBPP6lBCq4CxKf8=;
        b=dA3jkPu/yKWNZJSY12tZO3ZL+lTaWHc60BLczLLclQOqPeCBj4HYikZ7tOsLfsosEI
         zAlPL7ufiJtDlAIX0NFqicwAOzcr+77F0lKB4W/kYejgt1H2u4tPSMt7SUI/gpxO2ETX
         nal0kMSsA+DLTO113cuFLRGrRjcrz6WN3ue20=
Received: by 10.142.119.1 with SMTP id r1mr3421030wfc.414.1312284600682;
        Tue, 02 Aug 2011 04:30:00 -0700 (PDT)
Received: from localhost.localdomain ([120.16.93.94])
        by mx.google.com with ESMTPS id t20sm3715018wfe.12.2011.08.02.04.29.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 02 Aug 2011 04:29:59 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.353.g3461
In-Reply-To: <1312284545-2426-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178453>

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
1.7.6.353.g3461
