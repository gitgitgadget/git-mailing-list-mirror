From: martinerikwerner@gmail.com
Subject: [PATCH v2] shell-prompt: clean up nested if-then
Date: Mon, 18 Feb 2013 23:59:03 +0100
Message-ID: <5122b23b.512e980a.32b9.ffffa580@mx.google.com>
References: <1361228206.17734.4.camel@mas>
Cc: git@vger.kernel.org, trsten@science-computing.de,
	felipe.contreras@gmail.com,
	Martin Erik Werner <martinerikwerner@gmail.com>
To: s.oosthoek@xs4all.nl, jrnieder@gmail.com
X-From: git-owner@vger.kernel.org Mon Feb 18 23:59:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7ZgM-0005n6-Ji
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 23:59:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757551Ab3BRW7K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 17:59:10 -0500
Received: from mail-lb0-f182.google.com ([209.85.217.182]:44295 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757512Ab3BRW7J (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 17:59:09 -0500
Received: by mail-lb0-f182.google.com with SMTP id gg6so4693438lbb.13
        for <git@vger.kernel.org>; Mon, 18 Feb 2013 14:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=grfV9d0uy0pDBPb1aM3LBm/XF8r47fiUMLsGT+U7F7Y=;
        b=PDO2muanvXuqtPa/oa5vO+Lr2QLORoYicXbMYE2P3s3b6xTOGFlRvEqAber8LAjEMg
         YfernxBmN9O3k43Glbg+ooTIipppTlYM1lT4HPHTXQEWI6XoXTs/qQMXdhe78T0eIp2k
         N3UeGE5l05vTjejQQhGFSxQYzb6nQNVGZ2M3DtWO188oCrTg3aAv2s51iGHT0p5SnRJK
         SOHFwUnfF17WF9DULddKYgcotJtw0zO9fAZOIqHsGy0Bzbyk4a7Aj8dUoU81N/jxWEN7
         duuDqMUfRUq1NDEAw7w7IrMJ6lPXVybF8BEwKfHISHtawTYM/ocOJhEeUJm7FHGhDfIx
         1VoA==
X-Received: by 10.152.105.17 with SMTP id gi17mr12027774lab.46.1361228347999;
        Mon, 18 Feb 2013 14:59:07 -0800 (PST)
Received: from mas (student-247-62.eduroam.uu.se. [130.238.247.62])
        by mx.google.com with ESMTPS id t17sm15640512lam.9.2013.02.18.14.59.06
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 18 Feb 2013 14:59:07 -0800 (PST)
Received: from arand by mas with local (Exim 4.80)
	(envelope-from <arand@mas>)
	id 1U7Zfs-0005h0-Sp; Mon, 18 Feb 2013 23:59:04 +0100
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1361228206.17734.4.camel@mas>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216546>

From: Martin Erik Werner <martinerikwerner@gmail.com>

Minor clean up of if-then nesting in checks for environment variables
and config options. No functional changes.

Signed-off-by: Martin Erik Werner <martinerikwerner@gmail.com>
---
 contrib/completion/git-prompt.sh |   27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 9b2eec2..341422a 100644
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
+			if [ -n "${GIT_PS1_SHOWDIRTYSTATE-}" ] &&
+			   [ "$(git config --bool bash.showDirtyState)" != "false" ]
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
+			if [ -n "${GIT_PS1_SHOWUNTRACKEDFILES-}" ] &&
+			   [ "$(git config --bool bash.showUntrackedFiles)" != "false" ] &&
+			   [ -n "$(git ls-files --others --exclude-standard)" ]
+			then
+				u="%"
 			fi
 
 			if [ -n "${GIT_PS1_SHOWUPSTREAM-}" ]; then
-- 
1.7.10.4
