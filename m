From: Martin Erik Werner <martinerikwerner@gmail.com>
Subject: [PATCH] shell-prompt: clean up nested if-then
Date: Mon, 18 Feb 2013 17:23:21 +0100
Message-ID: <1361204601-4573-1-git-send-email-martinerikwerner@gmail.com>
References: <1361204512.4758.10.camel@mas>
Cc: git@vger.kernel.org, trsten@science-computing.de,
	Martin Erik Werner <martinerikwerner@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Feb 18 17:24:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7TVm-0002so-Ek
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 17:24:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754705Ab3BRQXt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 11:23:49 -0500
Received: from mail-la0-f52.google.com ([209.85.215.52]:59014 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752661Ab3BRQXs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 11:23:48 -0500
Received: by mail-la0-f52.google.com with SMTP id fs12so5563745lab.39
        for <git@vger.kernel.org>; Mon, 18 Feb 2013 08:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=Fya92+bjEAd0AYE53icqAjcvOidhRvbV4X9PF6T00sM=;
        b=z3ZUSG0uC4P5xkNWLYLn0WM+ciF89jmK3dx52MdKaB+zuY+rL5h6DhNIu6TpMqL3Zg
         KvnrmOhDEWd3rKnro+M1+FYx4vPn3VgABEemVgxgMCqXMBVDQyZH61GC2TQyTwAqOnEo
         bHvACCptCEhABTDyB0W8v0ExzorGUbojDPWKVJg0RJHWw6esAaiTQA82x4wlpQcy6WX9
         9l5nCz74+ssqTJzmf2NmYs9COKHkzPp8vixslLknkFp1VOMKWHpkhJkCNODLXfVwUG1m
         LXAy4tJsAV0jp9q5DjsWlrtWO+JfyHxh9yza+pK00zJc+tkAqVNtawOsswD2Z9cGy0cl
         wFqA==
X-Received: by 10.112.49.74 with SMTP id s10mr6022744lbn.92.1361204627045;
        Mon, 18 Feb 2013 08:23:47 -0800 (PST)
Received: from mas (student-247-62.eduroam.uu.se. [130.238.247.62])
        by mx.google.com with ESMTPS id b13sm17679862lbd.10.2013.02.18.08.23.44
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 18 Feb 2013 08:23:45 -0800 (PST)
Received: from arand by mas with local (Exim 4.80)
	(envelope-from <arand@mas>)
	id 1U7TVH-0001DC-Fu; Mon, 18 Feb 2013 17:23:43 +0100
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1361204512.4758.10.camel@mas>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216483>

Minor clean up of if-then nesting in checks for environment variables
and config options. No functional changes.
---
 contrib/completion/git-prompt.sh |   27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 9b2eec2..e29694d 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -320,26 +320,25 @@ __git_ps1 ()
 				b="GIT_DIR!"
 			fi
 		elif [ "true" = "$(git rev-parse --is-inside-work-tree 2>/dev/null)" ]; then
-			if [ -n "${GIT_PS1_SHOWDIRTYSTATE-}" ]; then
-				if [ "$(git config --bool bash.showDirtyState)" != "false" ]; then
-					git diff --no-ext-diff --quiet --exit-code || w="*"
-					if git rev-parse --quiet --verify HEAD >/dev/null; then
-						git diff-index --cached --quiet HEAD -- || i="+"
-					else
-						i="#"
-					fi
+			if test -n "${GIT_PS1_SHOWDIRTYSTATE-}" &&
+			   test "$(git config --bool bash.showDirtyState)" != "false"
+			then
+				git diff --no-ext-diff --quiet --exit-code || w="*"
+				if git rev-parse --quiet --verify HEAD >/dev/null; then
+					git diff-index --cached --quiet HEAD -- || i="+"
+				else
+					i="#"
 				fi
 			fi
 			if [ -n "${GIT_PS1_SHOWSTASHSTATE-}" ]; then
 				git rev-parse --verify refs/stash >/dev/null 2>&1 && s="$"
 			fi
 
-			if [ -n "${GIT_PS1_SHOWUNTRACKEDFILES-}" ]; then
-				if [ "$(git config --bool bash.showUntrackedFiles)" != "false" ]; then
-					if [ -n "$(git ls-files --others --exclude-standard)" ]; then
-						u="%"
-					fi
-				fi
+			if test -n "${GIT_PS1_SHOWUNTRACKEDFILES-}" &&
+			   test "$(git config --bool bash.showUntrackedFiles)" != "false" &&
+			   test -n "$(git ls-files --others --exclude-standard)"
+			then
+				u="%"
 			fi
 
 			if [ -n "${GIT_PS1_SHOWUPSTREAM-}" ]; then
-- 
1.7.10.4
