From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 1/2] completion: add new zsh completion
Date: Sun, 18 Nov 2012 12:08:08 +0100
Message-ID: <1353236889-15052-2-git-send-email-felipe.contreras@gmail.com>
References: <1353236889-15052-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Marc Khouzam <marc.khouzam@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Marius Storm-Olsen <marius@storm-olsen.com>,
	Marius Storm-Olsen <mstormo@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Peter van der Does <peter@avirtualhome.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Mark Lodato <lodatom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 18 12:08:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ta2k0-000681-A4
	for gcvg-git-2@plane.gmane.org; Sun, 18 Nov 2012 12:08:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751484Ab2KRLIa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Nov 2012 06:08:30 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:63037 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751268Ab2KRLI3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2012 06:08:29 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so1601033bkw.19
        for <git@vger.kernel.org>; Sun, 18 Nov 2012 03:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=jMjPWOCOC7+t+d5TD/QgBR+go1TspMBbREQxqhT1Deg=;
        b=wX99jzf2uzcI0OuciVhroa4dT5USruYtGNAaqSothgUqglQPhp2o1XJs3BDfJZmQzH
         won9CoCM6O5/Tm2HeLm5c0Va/d3Zs0KBNkto0FiCh3gO9MeaQ4nAfmhDo2pk3URvjwMP
         TNOYEwuDQ3OdEydh4OJMFlqI6LEG6b40fQ46hr+8IxNVIsAUetZve9eD0gIgMjJsXrbs
         Kr6690exc3h8V5XPBSiUiIsFQ/B41cAQyuXi7NOqpYmMWj9W5/JjTb9eXCFbyceguCmv
         oMYUzFvnT0ebp3FivhvTHzwK+XH+tqYcHabKwlcda/zgIEwHqLBGuLEHyqJoJQ/DiVt0
         Xo7Q==
Received: by 10.204.11.141 with SMTP id t13mr3764059bkt.65.1353236909061;
        Sun, 18 Nov 2012 03:08:29 -0800 (PST)
Received: from localhost (ip-109-43-0-81.web.vodafone.de. [109.43.0.81])
        by mx.google.com with ESMTPS id f24sm214294bkv.7.2012.11.18.03.08.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 18 Nov 2012 03:08:27 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1353236889-15052-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210023>

It seems there's always issues with zsh's bash completion emulation.
I've tried to fix as many as I could[1], and most of the fixes are already
in the latest version of zsh, but still, there are issues.

There is no point going through all that pain; the emulation is easy to
achieve, and this patch works better than zsh's bash completion
emulation.

[1] http://zsh.git.sourceforge.net/git/gitweb.cgi?p=zsh/zsh;a=commitdiff;h=23907bb840c80eef99eabba17e086e44c9b2d3fc

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 78 +++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)
 create mode 100644 contrib/completion/git-completion.zsh

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
new file mode 100644
index 0000000..4577502
--- /dev/null
+++ b/contrib/completion/git-completion.zsh
@@ -0,0 +1,78 @@
+#compdef git gitk
+
+# zsh completion wrapper for git
+#
+# You need git's bash completion script installed somewhere, by default on the
+# same directory as this script.
+#
+# If your script is on ~/.git-completion.sh instead, you can configure it on
+# your ~/.zshrc:
+#
+#  zstyle ':completion:*:*:git:*' script ~/.git-completion.sh
+#
+# The recommended way to install this script is to copy to
+# '~/.zsh/completion/_git', and then add the following to your ~/.zshrc file:
+#
+#  fpath=(~/.zsh/completion $fpath)
+
+complete ()
+{
+	# do nothing
+	return 0
+}
+
+zstyle -s ":completion:*:*:git:*" script script
+test -z "$script" && script="$(dirname ${funcsourcetrace[1]%:*})"/git-completion.bash
+ZSH_VERSION='' . "$script"
+
+__gitcomp ()
+{
+	emulate -L zsh
+
+	local cur_="${3-$cur}"
+
+	case "$cur_" in
+	--*=)
+		;;
+	*)
+		local c IFS=$' \t\n'
+		local -a array
+		for c in ${=1}; do
+			c="$c${4-}"
+			case $c in
+			--*=*|*.) ;;
+			*) c="$c " ;;
+			esac
+			array+=("$c")
+		done
+		compset -P '*[=:]'
+		compadd -Q -S '' -p "${2-}" -a -- array && _ret=0
+		;;
+	esac
+}
+
+__gitcomp_nl ()
+{
+	emulate -L zsh
+
+	local IFS=$'\n'
+	compset -P '*[=:]'
+	compadd -Q -S "${4- }" -p "${2-}" -- ${=1} && _ret=0
+}
+
+_git ()
+{
+	local _ret=1
+	() {
+		emulate -L ksh
+		local cur cword prev
+		cur=${words[CURRENT-1]}
+		prev=${words[CURRENT-2]}
+		let cword=CURRENT-1
+		__${service}_main
+	}
+	let _ret && _default -S '' && _ret=0
+	return _ret
+}
+
+_git
-- 
1.8.0
