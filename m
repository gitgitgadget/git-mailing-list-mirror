From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: [PATCH 1/2] rebase -i: run "commit --amend" with verbose if rebase was called with -v
Date: Sun, 24 Jul 2011 23:38:32 -0400
Message-ID: <1311565113-5022-2-git-send-email-andrew.kw.w@gmail.com>
References: <1311565113-5022-1-git-send-email-andrew.kw.w@gmail.com>
Cc: Andrew Wong <andrew.kw.w@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 30 09:04:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qn3aw-0006Ee-Ib
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jul 2011 09:04:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753350Ab1G3HEJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jul 2011 03:04:09 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:61198 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751439Ab1G3HEE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2011 03:04:04 -0400
Received: by iyb12 with SMTP id 12so4819685iyb.19
        for <git@vger.kernel.org>; Sat, 30 Jul 2011 00:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=NFcWxMLdYFKOU9lKBkk+4Mi1zm9L5uupCD1ILF3sEcc=;
        b=uFnyRVQjSDnNHwahOPi2LN0fREmNY38wtkWPYaEUOE2bpvJySJTcfc2HaXv9xx4xLM
         yFQ0+i6Xdityai2tPYk4hiNc4Df1iemWWlf8KaxzuSuhoZEV2qLNGcfm/CmdSCGIzqqG
         ddRfASI9na6aEQ+6yiGp/X4IcaMoCjDQA7EH8=
Received: by 10.42.173.135 with SMTP id r7mr874381icz.485.1312009444123;
        Sat, 30 Jul 2011 00:04:04 -0700 (PDT)
Received: from localhost.localdomain (24-246-58-202.cable.teksavvy.com [24.246.58.202])
        by mx.google.com with ESMTPS id h6sm3831145icw.19.2011.07.30.00.04.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 30 Jul 2011 00:04:03 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2
In-Reply-To: <1311565113-5022-1-git-send-email-andrew.kw.w@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178179>

This provides a convenient way to inspect the diff while rewording
commits, which is really useful when rewording commit messages that are
unclear.

Signed-off-by: Andrew Wong <andrew.kw.w@gmail.com>
---
 git-rebase--interactive.sh |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index c6ba7c1..df9f7e9 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -392,10 +392,12 @@ do_next () {
 	reword|r)
 		comment_for_reflog reword
 
+		test t = "$verbose" && commit_verbose_flag=--verbose
+
 		mark_action_done
 		pick_one $sha1 ||
 			die_with_patch $sha1 "Could not apply $sha1... $rest"
-		git commit --amend --no-post-rewrite
+		git commit $commit_verbose_flag --amend --no-post-rewrite
 		record_in_rewritten $sha1
 		;;
 	edit|e)
-- 
1.7.2.2
