From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 08/11] completion: get rid of __gitcomp_file()
Date: Sat, 27 Apr 2013 05:19:51 -0500
Message-ID: <1367057994-19887-9-git-send-email-felipe.contreras@gmail.com>
References: <1367057994-19887-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Manlio Perillo <manlio.perillo@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 27 12:21:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UW2GE-0003IE-IS
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 12:21:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755784Ab3D0KVg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Apr 2013 06:21:36 -0400
Received: from mail-oa0-f49.google.com ([209.85.219.49]:51186 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755757Ab3D0KVd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 06:21:33 -0400
Received: by mail-oa0-f49.google.com with SMTP id j1so4656033oag.8
        for <git@vger.kernel.org>; Sat, 27 Apr 2013 03:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=08gToUn7co1baiyH2pTxLKX4bfU0x8/5ZxXYwd/Sb5Y=;
        b=qKwxdze3IH8BgxbSltqPkGttm0VNFqcOhMenfvwC/x79WMx4LdVaeKJEA3eiCaZkLp
         cNayPKvOQe7M/byZpQvjhmItw6tLLb/U/38otR8SrkfrtgQPuDH7DL2Psjcmo/o4rD8N
         Q9tDC40VJY1aRXwnV+a5Z2VcVXGeC/wBe3GBkTC+yMnjaRRa5iSfCrd8T4lja3fGVYzt
         2X1c4zV6CSyR3s63+nduKOcEkEpkWMFj4ZvE6imTAiLRnsKJI7rwzif6IMW6jzu1dYab
         dTf6SYZ12eeAhi4Z63Iuc/8TDd3HNO9nC6yIQfHGk/WjRe/vQ6Q9l8W5gx4hKuVZQBnN
         Q3sw==
X-Received: by 10.182.241.134 with SMTP id wi6mr19483693obc.46.1367058092906;
        Sat, 27 Apr 2013 03:21:32 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id b2sm11670390oby.5.2013.04.27.03.21.31
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 27 Apr 2013 03:21:32 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.1031.g2ee5873
In-Reply-To: <1367057994-19887-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222632>

Now that we don't use -o filenames, it's no different from
__gitcomp_nl().

The only reason we might want it is for other shells, like zsh, which
can do more useful things if they know it's a file, like colouring the
output. But that can be done in the zsh completion.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 29 +----------------------------
 contrib/completion/git-completion.zsh  |  9 ---------
 2 files changed, 1 insertion(+), 37 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 5dd6646..a9b6a48 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -237,24 +237,6 @@ __gitcomp_nl ()
 	__gitcompadd "$1" "${2-}" "${3-$cur}" "${4- }"
 }
 
-# Generates completion reply with compgen from newline-separated possible
-# completion filenames.
-# It accepts 1 to 3 arguments:
-# 1: List of possible completion filenames, separated by a single newline.
-# 2: A directory prefix to be added to each possible completion filename
-#    (optional).
-# 3: Generate possible completion matches for this word (optional).
-__gitcomp_file ()
-{
-	local IFS=$'\n'
-
-	# XXX does not work when the directory prefix contains a tilde,
-	# since tilde expansion is not applied.
-	# This means that COMPREPLY will be empty and Bash default
-	# completion will be used.
-	__gitcompadd "$1" "${2-}" "${3-$cur}" ""
-}
-
 # Process path list returned by "ls-files" and "diff-index --name-only"
 # commands, in order to list only file names relative to a specified
 # directory, and append a slash to directory names.
@@ -518,7 +500,7 @@ __git_complete_index_file ()
 		;;
 	esac
 
-	__gitcomp_file "$(__git_index_files "$1" "$pfx")" "$pfx" "$cur_"
+	__gitcomp_nl "$(__git_index_files "$1" "$pfx")" "$pfx" "$cur_" ""
 }
 
 __git_complete_file ()
@@ -2594,15 +2576,6 @@ if [[ -n ${ZSH_VERSION-} ]]; then
 		compadd -Q -S "${4- }" -p "${2-}" -- ${=1} && _ret=0
 	}
 
-	__gitcomp_file ()
-	{
-		emulate -L zsh
-
-		local IFS=$'\n'
-		compset -P '*[=:]'
-		compadd -Q -p "${2-}" -f -- ${=1} && _ret=0
-	}
-
 	__git_zsh_helper ()
 	{
 		emulate -L ksh
diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index cf8116d..4577502 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -60,15 +60,6 @@ __gitcomp_nl ()
 	compadd -Q -S "${4- }" -p "${2-}" -- ${=1} && _ret=0
 }
 
-__gitcomp_file ()
-{
-	emulate -L zsh
-
-	local IFS=$'\n'
-	compset -P '*[=:]'
-	compadd -Q -p "${2-}" -f -- ${=1} && _ret=0
-}
-
 _git ()
 {
 	local _ret=1
-- 
1.8.2.1.1031.g2ee5873
