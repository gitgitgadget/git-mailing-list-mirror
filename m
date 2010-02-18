From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 09/10] pull: learn --progress
Date: Thu, 18 Feb 2010 20:37:10 +0800
Message-ID: <1266496631-3980-10-git-send-email-rctay89@gmail.com>
References: <1266496631-3980-1-git-send-email-rctay89@gmail.com>
Cc: "Jeff King" <peff@peff.net>,
	"Sebastian Thiel" <byronimo@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 18 13:46:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ni5lY-0001qr-S7
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 13:46:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757835Ab0BRMpx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2010 07:45:53 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:63266 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753795Ab0BRMpu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2010 07:45:50 -0500
X-Greylist: delayed 461 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Feb 2010 07:45:50 EST
Received: by gwb17 with SMTP id 17so37807gwb.19
        for <git@vger.kernel.org>; Thu, 18 Feb 2010 04:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=9qFpcui65bGH0SD9nUElAvrFfRwf/QhX1fGhqgtuqRA=;
        b=B3dFBHqJEVthxavP05PqE68yJflJqiSWC2zm/qeJ1Y3u+6Q7YYWLcp6u/gS6okGNWi
         iXIRW2HPvCaoBwX8Y5sBceSrdeJkl5+RrMbawpkqEr45EUkPyAEanW/Oq/EvUHFoodqg
         QHrtiq8jXNGuTzNMyOrdGNyUAcVccOqK63LbM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=l9Sw/s08K3Nca7HQbWZzM0TVbfB8zntR90MK6CPT6lOmuzaYAKqfcpvASVQwIB4KOY
         8bXWIv3GSJ0OydDFskHz6s4o8iUX9lC26vt5yIH1yx/4j94DEVt8aqtNgTDQMqcW59Sy
         vGJDfG5s5uEao0VA01TXdheMynopzvKMGjOUE=
Received: by 10.101.132.14 with SMTP id j14mr9245923ann.58.1266496683282;
        Thu, 18 Feb 2010 04:38:03 -0800 (PST)
Received: from localhost.localdomain (cm91.zeta153.maxonline.com.sg [116.87.153.91])
        by mx.google.com with ESMTPS id 21sm381013ywh.17.2010.02.18.04.37.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 18 Feb 2010 04:37:59 -0800 (PST)
X-Mailer: git-send-email 1.7.0.20.gcb44ed
In-Reply-To: <1266496631-3980-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140334>

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 git-pull.sh |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index 38331a8..d45b50c 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -38,7 +38,7 @@ test -z "$(git ls-files -u)" || die_conflict
 test -f "$GIT_DIR/MERGE_HEAD" && die_merge
 
 strategy_args= diffstat= no_commit= squash= no_ff= ff_only=
-log_arg= verbosity=
+log_arg= verbosity= progress=
 merge_args=
 curr_branch=$(git symbolic-ref -q HEAD)
 curr_branch_short=$(echo "$curr_branch" | sed "s|refs/heads/||")
@@ -50,6 +50,8 @@ do
 		verbosity="$verbosity -q" ;;
 	-v|--verbose)
 		verbosity="$verbosity -v" ;;
+	--progress)
+		progress=--progress ;;
 	-n|--no-stat|--no-summary)
 		diffstat=--no-stat ;;
 	--stat|--summary)
@@ -214,7 +216,7 @@ test true = "$rebase" && {
 	done
 }
 orig_head=$(git rev-parse -q --verify HEAD)
-git fetch $verbosity --update-head-ok "$@" || exit 1
+git fetch $verbosity $progress --update-head-ok "$@" || exit 1
 
 curr_head=$(git rev-parse -q --verify HEAD)
 if test -n "$orig_head" && test "$curr_head" != "$orig_head"
-- 
1.7.0.27.g5d71b
