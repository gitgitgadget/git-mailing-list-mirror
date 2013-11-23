From: Heikki Hokkanen <hoxu@users.sf.net>
Subject: [PATCH] bash prompt: add option to disable for a repository
Date: Sat, 23 Nov 2013 15:18:23 +0200
Message-ID: <1385212703-9611-1-git-send-email-hoxu@users.sf.net>
Cc: hoxu@users.sf.net, szeder@ira.uka.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 23 14:18:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VkD6u-0007Za-7u
	for gcvg-git-2@plane.gmane.org; Sat, 23 Nov 2013 14:18:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755297Ab3KWNSw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Nov 2013 08:18:52 -0500
Received: from mail-lb0-f172.google.com ([209.85.217.172]:38816 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753299Ab3KWNSv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Nov 2013 08:18:51 -0500
Received: by mail-lb0-f172.google.com with SMTP id z5so1871601lbh.17
        for <git@vger.kernel.org>; Sat, 23 Nov 2013 05:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=jnvmV6wEh3i4gU75XYMjF1KP0Do7HDsqkcRqYYwdilI=;
        b=pTANyRhFM1RW0BH8vt/fwZnYe/Gl5DFxykFPMOom95q8Yl1a3qcwo5tXQ4X4746zeu
         GtuCTUs7jxOPAJ3Vjs4mgisPFjyxRBmR/21f41G9Nq+xbnUFKu/Bd/W+guQDBkUbQ4Ft
         BzYa6bgIustnpw1/gxs2Utkxmh1sXjWa+MBMwAQN24iZoHmIhEtYa3CXBeUj5CM7NdDO
         u9BdJ4ZwSNO5/Dqv594bRy1D2wSDSdvM4yZPBjzpgMZVuPLDD9M+hsET6iMKn72aHqSc
         tP+UuJZZhUCkF5mZVjmRqCG//5g6zN0RK7AJQ6iMo7FKKg4uTXkd0sbJx1Hqxehtreee
         UPLQ==
X-Received: by 10.152.8.18 with SMTP id n18mr14336925laa.24.1385212730104;
        Sat, 23 Nov 2013 05:18:50 -0800 (PST)
Received: from odin.elisa-laajakaista.fi (a88-112-183-5.elisa-laajakaista.fi. [88.112.183.5])
        by mx.google.com with ESMTPSA id m5sm34072920laj.4.2013.11.23.05.18.49
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Nov 2013 05:18:49 -0800 (PST)
X-Mailer: git-send-email 1.8.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238233>

If bash.prompt is set to false, disable the prompt. This is useful
for huge repositories like the home directory.

Signed-off-by: Heikki Hokkanen <hoxu@users.sf.net>
---
git-prompt.sh performance seems to be quite bad for big repositories, so
without a way to disable it selectively for repositories, it becomes unusable
for people who have their homedir under git. This patch generalizes the problem
a bit by allowing the prompt to be disabled by setting bash.prompt to false in
any repository.

 contrib/completion/git-prompt.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 7b732d2..c982fde 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -84,6 +84,8 @@
 # GIT_PS1_SHOWCOLORHINTS to a nonempty value. The colors are based on
 # the colored output of "git status -sb" and are available only when
 # using __git_ps1 for PROMPT_COMMAND or precmd.
+#
+# To disable prompt for a repository, run "git config bash.prompt false"
 
 # check whether printf supports -v
 __git_printf_supports_v=
@@ -304,6 +306,12 @@ __git_ps1 ()
 		return
 	fi
 
+	local prompt_setting
+	prompt_setting=$(git config --bool bash.prompt)
+	if [ -n "$prompt_setting" ] && [ "$prompt_setting" == "false" ]; then
+		return
+	fi
+
 	local short_sha
 	if [ "$rev_parse_exit_code" = "0" ]; then
 		short_sha="${repo_info##*$'\n'}"
-- 
1.8.4
