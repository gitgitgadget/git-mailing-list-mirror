From: "Eduardo R. D'Avila" <erdavila@gmail.com>
Subject: [PATCH/RFC 3/3] git-prompt.sh: enable color prompt in non-pcmode
Date: Sun, 16 Jun 2013 14:32:12 -0300
Message-ID: <c875c17e4745d57bd26b680e82aa221659faf3cd.1371402672.git.erdavila@gmail.com>
References: <cover.1371402672.git.erdavila@gmail.com>
Cc: felipe.contreras@gmail.com, t.gummerer@gmail.com,
	artagnon@gmail.com, zoltan.klinger@gmail.com, hegge@resisty.net,
	martinerikwerner@gmail.com, s.oosthoek@xs4all.nl,
	gitster@pobox.com, jonathan@leto.net, szeder@ira.uka.de,
	"Eduardo R. D'Avila" <erdavila@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 16 19:32:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UoGoq-00009v-Oq
	for gcvg-git-2@plane.gmane.org; Sun, 16 Jun 2013 19:32:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755389Ab3FPRck (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Jun 2013 13:32:40 -0400
Received: from mail-gh0-f182.google.com ([209.85.160.182]:64736 "EHLO
	mail-gh0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755371Ab3FPRcd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Jun 2013 13:32:33 -0400
Received: by mail-gh0-f182.google.com with SMTP id z15so720498ghb.27
        for <git@vger.kernel.org>; Sun, 16 Jun 2013 10:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=K4nHukVL2IHxm6JVyr818TL0vWneNj+2HVQk64EyQ10=;
        b=JEjBot4tlcYh5R+IhhqF1Twm6sFOwVVLS2bKDiIKH1wjGujLlHZtDmDMTRs2//c+6/
         aYBUP629SqshfTPAdCj3jgieLgGXbHoTSDvlsB2Av8JBtBHru07X/jX8pwMGC5dD5uAA
         rOGr2Ut32Q4DRGuXPYDxUpl1DLSU+rGU4MzfQ/GZ5sftY0un33uCFfSqspEh8wBmdXY+
         1XLGL03uG4meDtj0OVhlPOpHZxf5fGKWPoADgqKAVHDURv8jqS/iWrPVIQFypUYVbwVa
         wwq0bv0uabBNt+AgZVyTea50bKSFpLshqQyEiA++b+iKWArfxYqhzYPozHq9mPF1i6QK
         hzgA==
X-Received: by 10.236.92.211 with SMTP id j59mr6289824yhf.204.1371403952778;
        Sun, 16 Jun 2013 10:32:32 -0700 (PDT)
Received: from localhost.localdomain ([177.18.63.49])
        by mx.google.com with ESMTPSA id s29sm18661561yhf.6.2013.06.16.10.32.29
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 16 Jun 2013 10:32:32 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.440.g82707f8
In-Reply-To: <cover.1371402672.git.erdavila@gmail.com>
In-Reply-To: <cover.1371402672.git.erdavila@gmail.com>
References: <cover.1371402672.git.erdavila@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228019>

The use of colors in a prompt is only possible in
pcmode (using the variable PROMPT_COMMAND).

Enable color prompt in non-pcmode (using the variable
PS1) for both Bash and ZSH.

Signed-off-by: Eduardo R. D'Avila <erdavila@gmail.com>
---
15	9	contrib/completion/git-prompt.sh
19	0	t/t9903-bash-prompt.sh
 contrib/completion/git-prompt.sh | 24 +++++++++++++++---------
 t/t9903-bash-prompt.sh           | 19 +++++++++++++++++++
 2 files changed, 34 insertions(+), 9 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 70515cc..c5c75e7 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -13,7 +13,7 @@
 #    3a) Change your PS1 to call __git_ps1 as
 #        command-substitution:
 #        Bash: PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
-#        ZSH:  PS1='[%n@%m %c$(__git_ps1 " (%s)")]\$ '
+#        ZSH:  setopt PROMPT_SUBST ; PS1='[%n@%m %c$(__git_ps1 " (%s)")]\$ '
 #        the optional argument will be used as format string.
 #    3b) Alternatively, if you are using bash, __git_ps1 can be
 #        used for PROMPT_COMMAND with two parameters, <pre> and
@@ -235,12 +235,18 @@ __git_ps1_colorize_gitstring ()
 		local c_lblue='%F{blue}'
 		local c_clear='%f'
 	else
-		# Using \[ and \] around colors
-		# is necessary to prevent wrapping issues!
-		local c_red='\[\e[31m\]'
-		local c_green='\[\e[32m\]'
-		local c_lblue='\[\e[1;34m\]'
-		local c_clear='\[\e[0m\]'
+		local c_red='\e[31m'
+		local c_green='\e[32m'
+		local c_lblue='\e[1;34m'
+		local c_clear='\e[0m'
+		if [ $pcmode = yes ]; then
+			# Using \[ and \] around colors
+			# is necessary to prevent wrapping issues!
+			c_red="\[$c_red\]"
+			c_green="\[$c_green\]"
+			c_lblue="\[$c_lblue\]"
+			c_clear="\[$c_clear\]"
+		fi
 	fi
 	local bad_color=$c_red
 	local ok_color=$c_green
@@ -411,7 +417,7 @@ __git_ps1 ()
 		local z="${GIT_PS1_STATESEPARATOR-" "}"
 
 		# NO color option unless in PROMPT_COMMAND mode
-		if [ $pcmode = yes ] && [ -n "${GIT_PS1_SHOWCOLORHINTS-}" ]; then
+		if [ -n "${GIT_PS1_SHOWCOLORHINTS-}" ]; then
 			__git_ps1_colorize_gitstring
 		fi
 
@@ -422,7 +428,7 @@ __git_ps1 ()
 			gitstring=$(printf -- "$printf_format" "$gitstring")
 			PS1="$ps1pc_start$gitstring$ps1pc_end"
 		else
-			printf -- "$printf_format" "$gitstring"
+			printf -- "${printf_format//%s/%b}" "$gitstring"
 		fi
 	fi
 }
diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index 22484c1..63abc72 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -785,4 +785,23 @@ test_expect_success 'prompt - zsh color pc mode - untracked files status indicat
 	test_cmp expected "$actual"
 '
 
+test_expect_success 'prompt - bash color ps1 mode - untracked files status indicator' '
+	printf " (\e[32mmaster\e[0m)" > expected &&
+	(
+		GIT_PS1_SHOWCOLORHINTS=y &&
+		__git_ps1 > "$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'prompt - zsh color ps1 mode - untracked files status indicator' '
+	printf " (%%F{green}master%%f)" > expected &&
+	(
+		GIT_PS1_SHOWCOLORHINTS=y &&
+		ZSH_VERSION=5.0.0 &&
+		__git_ps1 > "$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
 test_done
-- 
1.8.3.1.440.g82707f8
