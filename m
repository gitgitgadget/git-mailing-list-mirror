From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] prompt: squelch error output from cat
Date: Thu, 13 Jun 2013 19:16:49 +0530
Message-ID: <1371131209-32479-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 13 15:45:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Un7pz-0007GZ-1h
	for gcvg-git-2@plane.gmane.org; Thu, 13 Jun 2013 15:45:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757076Ab3FMNo6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jun 2013 09:44:58 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:59072 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756867Ab3FMNoz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jun 2013 09:44:55 -0400
Received: by mail-pd0-f178.google.com with SMTP id w11so6866020pde.9
        for <git@vger.kernel.org>; Thu, 13 Jun 2013 06:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=UI20Ou7Txg0dVxjsbGGuE/sVD4J0EZSTz/3RFqTWX6Y=;
        b=FDo4qTXbzlej76Il8oU8Ygsg3hwzJtzS82HJQER/3kF1PC6CFdqQ3QX2AoUmkMqVei
         YSjWMaAr7fKwbgoI0RluyMqfo6wR/XNp+CjXEYavyryfkkI/7/z6PR41YJglwi4SK48j
         CwXz+aiMe4Uz+WmcvEBMAAg+RAJItyyVJOkh6gXJn9dcTICF4xLxKipjQnR2qLdGfjFK
         rNS2FuRP9hibnNl0cYSMlblwClnHNxMgTY1dyn/x0RdhnqvHZox9iRQB4M30PlAbROoX
         EMGtN+hwyPy7HRj/y8lr43fywTK3hxjingMcW1Sv2AyE4F+PsHTIxX4YjqXE7xgp9M/o
         aN5A==
X-Received: by 10.68.170.193 with SMTP id ao1mr998689pbc.18.1371131095187;
        Thu, 13 Jun 2013 06:44:55 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id xz1sm29481103pab.5.2013.06.13.06.44.53
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 13 Jun 2013 06:44:54 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.384.g7cec0b4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227736>

The files $g/rebase-{merge,apply}/{head-name,msgnum,end} are not
guaranteed to exist.  When attempting to cat them, squelch the error
output to get rid of messages like these:

  cat: .git/rebase-merge/msgnum: No such file or directory
  cat: .git/rebase-merge/end: No such file or directory

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 contrib/completion/git-prompt.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 86a4f3f..07a6218 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -347,9 +347,9 @@ __git_ps1 ()
 		local step=""
 		local total=""
 		if [ -d "$g/rebase-merge" ]; then
-			b="$(cat "$g/rebase-merge/head-name")"
-			step=$(cat "$g/rebase-merge/msgnum")
-			total=$(cat "$g/rebase-merge/end")
+			b="$(cat "$g/rebase-merge/head-name" 2>/dev/null)"
+			step=$(cat "$g/rebase-merge/msgnum" 2>/dev/null)
+			total=$(cat "$g/rebase-merge/end" 2>/dev/null)
 			if [ -f "$g/rebase-merge/interactive" ]; then
 				r="|REBASE-i"
 			else
@@ -357,10 +357,10 @@ __git_ps1 ()
 			fi
 		else
 			if [ -d "$g/rebase-apply" ]; then
-				step=$(cat "$g/rebase-apply/next")
-				total=$(cat "$g/rebase-apply/last")
+				step=$(cat "$g/rebase-apply/next" 2>/dev/null)
+				total=$(cat "$g/rebase-apply/last" 2>/dev/null)
 				if [ -f "$g/rebase-apply/rebasing" ]; then
-					b="$(cat "$g/rebase-apply/head-name")"
+					b="$(cat "$g/rebase-apply/head-name" 2>/dev/null)"
 					r="|REBASE"
 				elif [ -f "$g/rebase-apply/applying" ]; then
 					r="|AM"
-- 
1.8.3.1.384.g7cec0b4
