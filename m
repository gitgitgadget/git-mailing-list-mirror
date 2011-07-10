From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH v3] git-rebase.txt: clarify that --abort checks out <branch>
Date: Sun, 10 Jul 2011 14:31:01 -0400
Message-ID: <1310322661-24924-1-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1310092069-19708-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Drew Northup <drew.northup@maine.edu>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 10 20:31:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qfymo-0002XD-L3
	for gcvg-git-2@lo.gmane.org; Sun, 10 Jul 2011 20:31:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756343Ab1GJSbS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Jul 2011 14:31:18 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:54347 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756310Ab1GJSbR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jul 2011 14:31:17 -0400
Received: by qyk9 with SMTP id 9so1884851qyk.19
        for <git@vger.kernel.org>; Sun, 10 Jul 2011 11:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=+7k5xKWxb3xydt3hH/5FkJIMzfNSLbdpQf6i83Y6i3E=;
        b=QY27FxYiNCx4HRRPd5Q4SMkuDwrkpxX1E8THPfZId1Ei80YfQKaWsxLhQr38wMg3Gy
         uOoJejGYZHkeSBP2pEyWxLOrJlT8366R8b/M66/6xsoL1wVz/LqZ9YcAz85l05abal3R
         +1qEDgjJ7Ov9jgHYtw6SnTqR8RQXQ13SESsNQ=
Received: by 10.224.209.72 with SMTP id gf8mr2907434qab.362.1310322676555;
        Sun, 10 Jul 2011 11:31:16 -0700 (PDT)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id 13sm1185920qcc.10.2011.07.10.11.31.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 10 Jul 2011 11:31:13 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.51.g07e0e
In-Reply-To: <1310092069-19708-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176826>

The description for 'git rebase --abort' currently says:

    Restore the original branch and abort the rebase operation.

The "restore" can be misinterpreted to imply that the original branch
was somehow in a broken state during the rebase operation. It is also
not completely clear what "the original branch" is --- is it the
branch that was checked out before the rebase operation was called or
is the the branch that is being rebased (it is the latter)? Although
both issues are made clear in the DESCRIPTION section, let us also
make the entry in the OPTIONS secion more clear.

Also remove the term "rebasing process" from the usage text, since the
user already knows that the text is about "git rebase".

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
 Documentation/git-rebase.txt |    6 +++++-
 git-rebase.sh                |    6 +++---
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index a9e0e50..d2f2cd9 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -232,7 +232,11 @@ leave out at most one of A and B, in which case it defaults to HEAD.
 	Restart the rebasing process after having resolved a merge conflict.
 
 --abort::
-	Restore the original branch and abort the rebase operation.
+	Abort the rebase operation and reset HEAD to the original
+	branch. If <branch> was provided when the rebase operation was
+	started, then HEAD will be reset to <branch>. Otherwise HEAD
+	will be reset to where it was when the rebase operation was
+	started.
 
 --skip::
 	Restart the rebasing process by skipping the current patch.
diff --git a/git-rebase.sh b/git-rebase.sh
index d7855ea..9065c16 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -57,9 +57,9 @@ whitespace=!       passed to 'git apply'
 ignore-whitespace! passed to 'git apply'
 C=!                passed to 'git apply'
  Actions:
-continue!          continue rebasing process
-abort!             abort rebasing process and restore original branch
-skip!              skip current patch and continue rebasing process
+continue!          continue
+abort!             abort and check out the original branch
+skip!              skip current patch and continue
 "
 . git-sh-setup
 set_reflog_action rebase
-- 
1.7.6.51.g07e0e
