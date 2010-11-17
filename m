From: Stefan Naewe <stefan.naewe@googlemail.com>
Subject: [PATCH] git-gui: use --exclude-standard to check for untracked files
Date: Wed, 17 Nov 2010 16:13:24 +0100
Message-ID: <1290006804-9142-1-git-send-email-stefan.naewe@googlemail.com>
Cc: Stefan Naewe <stefan.naewe@googlemail.com>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 17 16:13:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIjhl-0005G0-KF
	for gcvg-git-2@lo.gmane.org; Wed, 17 Nov 2010 16:13:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934591Ab0KQPNn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Nov 2010 10:13:43 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:61884 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933120Ab0KQPNm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Nov 2010 10:13:42 -0500
Received: by yxf34 with SMTP id 34so1116778yxf.19
        for <git@vger.kernel.org>; Wed, 17 Nov 2010 07:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=DFtuVJkpijF+NqBzvyfuoBm4BwVawZt/gGdcJJPhBmQ=;
        b=R8M6tRbDwGc4EHJDKVa8QvnthroQKB8ESUbLti6WqUdtAirONGNn1lohWQJzyv63aU
         eWbuaSxFN5d/us87LOrQRy44E3CXThiIFDugdQP5JFx8dOOcJgHEn+1L8ME90RLQw3tP
         BI+exrHN8OmbKTaNsRngsu2SQx02m80/b77Vs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=sGrZ2J5+VS4GG1lFZ7oxX9FU4k+ziULpeB+QChH31Qpy3xncEDp8uvZxln9X6jRZj6
         MRBe51vKWhOtZg9rp/7ZWN9UpnQl7g7N77VA/8zNLYlRV3vJ63DQvQgjswxbwEBUJErl
         BYNfj7s4+kUgDu0WoUgtQBXH9qJbWEIIwJ7kw=
Received: by 10.204.62.136 with SMTP id x8mr9319220bkh.192.1290006821610;
        Wed, 17 Nov 2010 07:13:41 -0800 (PST)
Received: from darkstar.home (dslc-082-083-230-174.pools.arcor-ip.net [82.83.230.174])
        by mx.google.com with ESMTPS id p34sm1384974bkf.3.2010.11.17.07.13.40
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 17 Nov 2010 07:13:40 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161620>

This fixes git gui failing to display untracked files if
core.excludesfile is set to '~/.gitexcludes'.

Signed-off-by: Stefan Naewe <stefan.naewe@googlemail.com>
---
 git-gui/git-gui.sh |    9 +--------
 1 files changed, 1 insertions(+), 8 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 4617f29..7121526 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -1428,14 +1428,7 @@ proc rescan_stage2 {fd after} {
 		close $fd
 	}
 
-	set ls_others [list --exclude-per-directory=.gitignore]
-	if {[have_info_exclude]} {
-		lappend ls_others "--exclude-from=[gitdir info exclude]"
-	}
-	set user_exclude [get_config core.excludesfile]
-	if {$user_exclude ne {} && [file readable $user_exclude]} {
-		lappend ls_others "--exclude-from=$user_exclude"
-	}
+	set ls_others [list --exclude-standard]
 
 	set buf_rdi {}
 	set buf_rdf {}
-- 
1.7.3.2
