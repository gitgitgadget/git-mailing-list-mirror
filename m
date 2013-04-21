From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] prompt: fix tracked files for zsh
Date: Sun, 21 Apr 2013 03:11:30 -0500
Message-ID: <1366531890-19899-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 21 10:12:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTpOE-0003O5-Tu
	for gcvg-git-2@plane.gmane.org; Sun, 21 Apr 2013 10:12:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752265Ab3DUIMp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Apr 2013 04:12:45 -0400
Received: from mail-oa0-f51.google.com ([209.85.219.51]:45273 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751295Ab3DUIMo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Apr 2013 04:12:44 -0400
Received: by mail-oa0-f51.google.com with SMTP id k14so5079421oag.10
        for <git@vger.kernel.org>; Sun, 21 Apr 2013 01:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=yaHOw41yxvTU0OQ5R5NbDXUurTvAYHypxIZl1i5VjVc=;
        b=QnV5JO+Sz7uy7I39C09vsNBZ6oDuzsI41JV8cgZ6a2cweABLXYUsBkqT8KulctQHw1
         5fYnp3nX/DkJOCKwGGzsW30pBeqdLCILeQFXsKnTBr+FAiDEiZ8p1vjnQ10hPZabJt6Z
         RuX+FXNePCZdBF2Egs3RzYXajuVooUbGFmtSlrF686qGe21F9QvKcpYfO3gK+GeIjPRK
         6TwCsROCSO5ZgNMLO+R5+b8NQBT57NfIZ7mV6eVUI6RCtF5QL7GWc/5cxuhnJ1RLQnyJ
         c89ekkMit2y49POYsPUr5Lk3LKHNMJlZmScVWdYsqKzGn80e9fy5Ne1xtQ8xerMaSvcu
         Y7Gw==
X-Received: by 10.182.56.134 with SMTP id a6mr7179655obq.29.1366531963804;
        Sun, 21 Apr 2013 01:12:43 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id a3sm14114928oee.8.2013.04.21.01.12.41
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 21 Apr 2013 01:12:42 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.790.g4588561
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221915>

When this option is enabled, the prompt gets totally screwed in zsh
because all the codes start with % in zsh (like they are \ in bas). So
we need to escape the % character.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-prompt.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 756a951..4bedbcc 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -340,7 +340,11 @@ __git_ps1 ()
 			   [ "$(git config --bool bash.showUntrackedFiles)" != "false" ] &&
 			   [ -n "$(git ls-files --others --exclude-standard)" ]
 			then
-				u="%"
+				if [ -n "${ZSH_VERSION-}" ]; then
+					u="%%"
+				else
+					u="%"
+				fi
 			fi
 
 			if [ -n "${GIT_PS1_SHOWUPSTREAM-}" ]; then
-- 
1.8.2.1.790.g4588561
