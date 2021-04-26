Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B28CC43461
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 16:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D4476109E
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 16:21:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234507AbhDZQVs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 12:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233919AbhDZQVr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 12:21:47 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8464FC061574
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 09:21:05 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 5-20020a9d09050000b029029432d8d8c5so26667803otp.11
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 09:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sh9OuoY8vDNSir6QIrw5CcTHciXB5hZVSx7h7iUQD+k=;
        b=aGwa45mcwqBfgKFBh17qgZGlzhEcsWIftwyVzvUUzgjwoY+P9ZI/26SOyN8VMKCrhJ
         FaarxYaeLF4kyx1qL9/AtMCtUgT1VukSaaZaxq9I/ZZJ7hA650wq5Dp24kmIGfdQwRpu
         ut/WXu2BuJLiI/ntugnekALNCsVFFGFfT6pG6Qx7EE13toGbcd+rn6zM4CJKxLjyWyys
         7AxhwIBFKKAKnuLDh6r8jsyKawdpVWn3958zZyIPmmZaQ9B7N+jJvjXuiyeEobP58Fh1
         Ge6FkQbWMHiISxaD5ruY8xWcMQ3hqF5MG7zSnquL6UxNH0sGeq7GqDumCiPeoS3Jp7nB
         X4Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sh9OuoY8vDNSir6QIrw5CcTHciXB5hZVSx7h7iUQD+k=;
        b=YLl5c2LXnl1OmUhnRhYnvVvvFoyvDk2mXKJhmlopzlFVwiAM4CiCPGC5AyZtXwtGQ/
         RgVCX6tm62Wo+zVtAm7IxEKIrcju9X9o5l5AD3aIrfkO0odA8NZ4PYO354OAm1FbcgnJ
         eof4WFF4LXkbXNGFV6RiK74l7DJQTDgB8xo0YEaH1+yKoozlhZFZjs+1rxlng5j5pbBd
         +YiIrmhYpRdMlwf87lCxMSWlJO39Zs1vJa6vcrMCGv7jYGJuZuTbxKOHuPsK4w27khbu
         Q7ItFLg0r8dVd/MKlVOFYloOP9xqZeKdiKKskS0uKGM3QoX6nfcaa4dk3bBUh04rVeh8
         6IYA==
X-Gm-Message-State: AOAM533x3lPBuEtMN/vk1MaSyDTmk96woHTSuyVSUtIgvBK+GreIKXSp
        9LWSWbboTHneiMbW0js8sTSBsXlvLkwFCA==
X-Google-Smtp-Source: ABdhPJxuZeeM26BijxXoiJYGhcIuH9lKj7nGM+n1d3v0RDo2qnvZFTaCvlVrUxq7pC+PTxohCaOB7g==
X-Received: by 2002:a9d:60f:: with SMTP id 15mr15635648otn.81.1619454064586;
        Mon, 26 Apr 2021 09:21:04 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:638f:a2c5:89ff:fe0c:1151])
        by smtp.gmail.com with ESMTPSA id t9sm3549778otl.5.2021.04.26.09.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 09:21:04 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v1 42/43] completion: bash: rename _get_comp_words_by_ref()
Date:   Mon, 26 Apr 2021 11:14:57 -0500
Message-Id: <20210426161458.49860-43-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210426161458.49860-1-felipe.contreras@gmail.com>
References: <20210426161458.49860-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's only used in one place, rename it, and use it even if
bash-completion's more inefficient version of _get_comp_words_by_ref()
is available.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 184 ++++++++++++-------------
 t/t9902-completion.sh                  |   2 +-
 2 files changed, 92 insertions(+), 94 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 1cd249383b..d66db0ea99 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -307,98 +307,6 @@ __git_dequote ()
 	done
 }
 
-# The following function is based on code from:
-#
-#   bash_completion - programmable completion functions for bash 3.2+
-#
-#   Copyright © 2006-2008, Ian Macdonald <ian@caliban.org>
-#             © 2009-2010, Bash Completion Maintainers
-#                     <bash-completion-devel@lists.alioth.debian.org>
-#
-#   This program is free software; you can redistribute it and/or modify
-#   it under the terms of the GNU General Public License as published by
-#   the Free Software Foundation; either version 2, or (at your option)
-#   any later version.
-#
-#   This program is distributed in the hope that it will be useful,
-#   but WITHOUT ANY WARRANTY; without even the implied warranty of
-#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#   GNU General Public License for more details.
-#
-#   You should have received a copy of the GNU General Public License
-#   along with this program; if not, see <http://www.gnu.org/licenses/>.
-#
-#   The latest version of this software can be obtained here:
-#
-#   http://bash-completion.alioth.debian.org/
-#
-#   RELEASE: 2.x
-
-# This function reorganizes the words on the command line to be processed by
-# the rest of the script.
-#
-# This is roughly equivalent to going back in time and setting
-# COMP_WORDBREAKS to exclude '=' and ':'.  The intent is to
-# make option types like --date=<type> and <rev>:<path> easy to
-# recognize by treating each shell word as a single token.
-#
-# It is best not to set COMP_WORDBREAKS directly because the value is
-# shared with other completion scripts.  By the time the completion
-# function gets called, COMP_WORDS has already been populated so local
-# changes to COMP_WORDBREAKS have no effect.
-
-if ! type _get_comp_words_by_ref >/dev/null 2>&1; then
-_get_comp_words_by_ref ()
-{
-	local exclude i j first
-
-	# Which word separators to exclude?
-	exclude="${COMP_WORDBREAKS//[^=:]}"
-	cword=$COMP_CWORD
-	if [ -n "$exclude" ]; then
-		# List of word completion separators has shrunk;
-		# re-assemble words to complete.
-		for ((i=0, j=0; i < ${#COMP_WORDS[@]}; i++, j++)); do
-			# Append each nonempty word consisting of just
-			# word separator characters to the current word.
-			first=t
-			while
-				[ $i -gt 0 ] &&
-				[ -n "${COMP_WORDS[$i]}" ] &&
-				# word consists of excluded word separators
-				[ "${COMP_WORDS[$i]//[^$exclude]}" = "${COMP_WORDS[$i]}" ]
-			do
-				# Attach to the previous token,
-				# unless the previous token is the command name.
-				if [ $j -ge 2 ] && [ -n "$first" ]; then
-					((j--))
-				fi
-				first=
-				words[$j]=${words[j]}${COMP_WORDS[i]}
-				if [ $i = $COMP_CWORD ]; then
-					cword=$j
-				fi
-				if (($i < ${#COMP_WORDS[@]} - 1)); then
-					((i++))
-				else
-					# Done.
-					break 2
-				fi
-			done
-			words[$j]=${words[j]}${COMP_WORDS[i]}
-			if [ $i = $COMP_CWORD ]; then
-				cword=$j
-			fi
-		done
-	else
-		words=("${COMP_WORDS[@]}")
-	fi
-
-	cur=${words[cword]}
-	prev=${words[cword-1]}
-}
-fi
-
 # Clear the variables caching builtins' options when (re-)sourcing
 # the completion script.
 if [[ -n ${ZSH_VERSION-} ]]; then
@@ -3435,10 +3343,100 @@ if [[ -n ${ZSH_VERSION-} && -z ${GIT_SOURCING_ZSH_COMPLETION-} ]]; then
 	return
 fi
 
+# The following function is based on code from:
+#
+#   bash_completion - programmable completion functions for bash 3.2+
+#
+#   Copyright © 2006-2008, Ian Macdonald <ian@caliban.org>
+#             © 2009-2010, Bash Completion Maintainers
+#                     <bash-completion-devel@lists.alioth.debian.org>
+#
+#   This program is free software; you can redistribute it and/or modify
+#   it under the terms of the GNU General Public License as published by
+#   the Free Software Foundation; either version 2, or (at your option)
+#   any later version.
+#
+#   This program is distributed in the hope that it will be useful,
+#   but WITHOUT ANY WARRANTY; without even the implied warranty of
+#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#   GNU General Public License for more details.
+#
+#   You should have received a copy of the GNU General Public License
+#   along with this program; if not, see <http://www.gnu.org/licenses/>.
+#
+#   The latest version of this software can be obtained here:
+#
+#   http://bash-completion.alioth.debian.org/
+#
+#   RELEASE: 2.x
+
+# This function reorganizes the words on the command line to be processed by
+# the rest of the script.
+#
+# This is roughly equivalent to going back in time and setting
+# COMP_WORDBREAKS to exclude '=' and ':'.  The intent is to
+# make option types like --date=<type> and <rev>:<path> easy to
+# recognize by treating each shell word as a single token.
+#
+# It is best not to set COMP_WORDBREAKS directly because the value is
+# shared with other completion scripts.  By the time the completion
+# function gets called, COMP_WORDS has already been populated so local
+# changes to COMP_WORDBREAKS have no effect.
+
+__git_get_comp_words_by_ref ()
+{
+	local exclude i j first
+
+	# Which word separators to exclude?
+	exclude="${COMP_WORDBREAKS//[^=:]}"
+	cword=$COMP_CWORD
+	if [ -n "$exclude" ]; then
+		# List of word completion separators has shrunk;
+		# re-assemble words to complete.
+		for ((i=0, j=0; i < ${#COMP_WORDS[@]}; i++, j++)); do
+			# Append each nonempty word consisting of just
+			# word separator characters to the current word.
+			first=t
+			while
+				[ $i -gt 0 ] &&
+				[ -n "${COMP_WORDS[$i]}" ] &&
+				# word consists of excluded word separators
+				[ "${COMP_WORDS[$i]//[^$exclude]}" = "${COMP_WORDS[$i]}" ]
+			do
+				# Attach to the previous token,
+				# unless the previous token is the command name.
+				if [ $j -ge 2 ] && [ -n "$first" ]; then
+					((j--))
+				fi
+				first=
+				words[$j]=${words[j]}${COMP_WORDS[i]}
+				if [ $i = $COMP_CWORD ]; then
+					cword=$j
+				fi
+				if (($i < ${#COMP_WORDS[@]} - 1)); then
+					((i++))
+				else
+					# Done.
+					break 2
+				fi
+			done
+			words[$j]=${words[j]}${COMP_WORDS[i]}
+			if [ $i = $COMP_CWORD ]; then
+				cword=$j
+			fi
+		done
+	else
+		words=("${COMP_WORDS[@]}")
+	fi
+
+	cur=${words[cword]}
+	prev=${words[cword-1]}
+}
+
 __git_func_wrap ()
 {
 	local cur words cword prev
-	_get_comp_words_by_ref -n =: cur words cword prev
+	__git_get_comp_words_by_ref
 	$1
 }
 
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index dfa2cb3b21..a184254891 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -41,7 +41,7 @@ GIT_TESTING_PORCELAIN_COMMAND_LIST='add checkout rebase'
 # We don't need this function to actually join words or do anything special.
 # Also, it's cleaner to avoid touching bash's internal completion variables.
 # So let's override it with a minimal version for testing purposes.
-_get_comp_words_by_ref ()
+__git_get_comp_words_by_ref ()
 {
 	cword=$_cword
 	cur=${_words[cword]}
-- 
2.31.0

