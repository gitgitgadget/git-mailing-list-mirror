Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1BABC6FD1D
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 08:49:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjDAItP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 04:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjDAIsH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 04:48:07 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E956F1D843
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 01:47:20 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id a30-20020a9d3e1e000000b006a13f728172so9960037otd.3
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 01:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680338840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zfahy3Agolk9OqJbyPKo1v+PYCI3Km/h+s0Z27r2jGY=;
        b=WbcnwQUT4As2KcpY3nQgdxJrkbfdTq1bu6Yt/5Szsabs24ORcIUvCtPIxwg1voHTCC
         4w2UXd9JQJmy1IvkeTkkj8IYDv2c6cpyC0+TSf8uRyQa67y6n9RLsljqxN33RiGhVvhm
         wOU81v3QgBHit4HQHT/6Wgk8dSffyFAHcqJhFzpFuy2ks7ksGalQnVX9RZPx9jQEU0M7
         k4lhTTzTEB40yfiWUE/FVhCX9KECKVHktZrHJwfL00upx8octOnv5HR1AFl/yqg4cNEN
         SvMk6N6fpDy0IDY3oeVDhlPYb2rWDQy4xI3Jf1K7PCJt+y98soChthG3eOt56F4dHNdO
         RJ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680338840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zfahy3Agolk9OqJbyPKo1v+PYCI3Km/h+s0Z27r2jGY=;
        b=OjGkiVLw5IorT9Pboc2RWzm/Jv9ufJ1sEtOv2CI6LixQZ0I5zRNwc37ZMw8KnaMgSf
         7M0VlK0OX4OKw8zWeh8DOEOST4ZMbUq0duhQeQKnoFf3x+lmVnXqRW4+sD2L8W2ooQec
         +budLIHWc1KB1NJWwUfgmIhfdD/ahS3PNkvyTA0Z1Sj+McAPTYGpb74JruGTiDe/HtIj
         /pjguMrGXSodBolSbW+z324zPaAClbf3YiN4wWirtRQNm5MhoIS+xxeyByl9oz14C2s4
         O78it2Yk2JQLReW6sM0pKlR6HbVUt91venGnjtTiEi2jEAU5g4AofEY1+ytMmtfaEGPV
         k7bA==
X-Gm-Message-State: AO0yUKVamvGxBz0h0k6PnbgfvMrCtYE8a71INRW5tAQlw4KhdMFMLp4B
        9//oa5oclp4GQh0Aq2A29XFivBPRNLs=
X-Google-Smtp-Source: AK7set8QA2w72dqPjWzumn6SCLnkxa9rMGIU6Jtvb5mEJ9h7QG2reCjuIzDTzEqRSL6uqfTHhH+u2Q==
X-Received: by 2002:a9d:7301:0:b0:69f:a37c:49b0 with SMTP id e1-20020a9d7301000000b0069fa37c49b0mr13818102otk.20.1680338839964;
        Sat, 01 Apr 2023 01:47:19 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id d11-20020a9d5e0b000000b006a3170fe3efsm322507oti.27.2023.04.01.01.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 01:47:19 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v7 38/49] completion: bash: shuffle __gitcomp functions
Date:   Sat,  1 Apr 2023 02:46:15 -0600
Message-Id: <20230401084626.304356-39-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230401084626.304356-1-felipe.contreras@gmail.com>
References: <20230401084626.304356-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

They are the ones that actually do the completion, put them at the top.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 270 +++++++++++++------------
 1 file changed, 139 insertions(+), 131 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index bc6f83adce..3f48b61cbe 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -65,6 +65,145 @@
 #     case insensitively, even on systems with case sensitive file systems
 #     (e.g., completing tag name "FOO" on "git checkout f<TAB>").
 
+# The following functions are meant to modify COMPREPLY, which should not be
+# modified directly.  The purpose is to localize the modifications so it's
+# easier to emulate it in Zsh. Every time a new __gitcomp* function is added,
+# the corresponding function should be added to Zsh.
+
+__gitcompadd ()
+{
+	local x i=${#COMPREPLY[@]}
+	for x in $1; do
+		if [[ "$x" == "$3"* ]]; then
+			COMPREPLY[i++]="$2$x$4"
+		fi
+	done
+}
+
+# Creates completion replies.
+# It accepts 1 to 4 arguments:
+# 1: List of possible completion words.
+# 2: A prefix to be added to each possible completion word (optional).
+# 3: Generate possible completion matches for this word (optional).
+# 4: A suffix to be appended to each possible completion word (optional).
+__gitcomp ()
+{
+	local IFS=$' \t\n'
+	__gitcompadd "$1" "${2-}" "${3-$cur}" "${4- }"
+}
+
+# Generates completion reply from newline-separated possible completion words
+# by appending a space to all of them. The result is appended to COMPREPLY.
+# It accepts 1 to 4 arguments:
+# 1: List of possible completion words, separated by a single newline.
+# 2: A prefix to be added to each possible completion word (optional).
+# 3: Generate possible completion matches for this word (optional).
+# 4: A suffix to be appended to each possible completion word instead of
+#    the default space (optional).  If specified but empty, nothing is
+#    appended.
+__gitcomp_nl ()
+{
+	local IFS=$'\n'
+	__gitcompadd "$1" "${2-}" "${3-$cur}" "${4- }"
+}
+
+# Appends prefiltered words to COMPREPLY without any additional processing.
+# Callers must take care of providing only words that match the current word
+# to be completed and adding any prefix and/or suffix (trailing space!), if
+# necessary.
+# 1: List of newline-separated matching completion words, complete with
+#    prefix and suffix.
+__gitcomp_direct ()
+{
+	local IFS=$'\n'
+
+	COMPREPLY+=($1)
+}
+
+# Generates completion reply with compgen from newline-separated possible
+# completion filenames.
+# It accepts 1 to 3 arguments:
+# 1: List of possible completion filenames, separated by a single newline.
+# 2: A directory prefix to be added to each possible completion filename
+#    (optional).
+# 3: Generate possible completion matches for this word (optional).
+__gitcomp_file ()
+{
+	local IFS=$'\n'
+
+	# XXX does not work when the directory prefix contains a tilde,
+	# since tilde expansion is not applied.
+	# This means that COMPREPLY will be empty and Bash default
+	# completion will be used.
+	__gitcompadd "$1" "${2-}" "${3-$cur}" ""
+
+	# use a hack to enable file mode in bash < 4
+	compopt -o filenames +o nospace 2>/dev/null ||
+	compgen -f /non-existing-dir/ >/dev/null ||
+	true
+}
+
+# Fills the COMPREPLY array with prefiltered paths without any additional
+# processing.
+# Callers must take care of providing only paths that match the current path
+# to be completed and adding any prefix path components, if necessary.
+# 1: List of newline-separated matching paths, complete with all prefix
+#    path components.
+__gitcomp_file_direct ()
+{
+	local IFS=$'\n'
+
+	COMPREPLY+=($1)
+
+	# use a hack to enable file mode in bash < 4
+	compopt -o filenames +o nospace 2>/dev/null ||
+	compgen -f /non-existing-dir/ >/dev/null ||
+	true
+}
+
+# Creates completion replies, reorganizing options and adding suffixes as needed.
+# It accepts 1 to 4 arguments:
+# 1: List of possible completion words.
+# 2: A prefix to be added to each possible completion word (optional).
+# 3: Generate possible completion matches for this word (optional).
+# 4: A suffix to be appended to each possible completion word (optional).
+__gitcomp_opts ()
+{
+	local cur_="${3-$cur}"
+
+	if [[ "$cur_" == *= ]]; then
+		return
+	fi
+
+	local c i=0 IFS=$' \t\n' sfx
+	for c in $1; do
+		if [[ $c == "--" ]]; then
+			if [[ "$cur_" == --no-* ]]; then
+				continue
+			fi
+
+			if [[ --no == "$cur_"* ]]; then
+				COMPREPLY[i++]="--no-... "
+			fi
+			break
+		fi
+		if [[ $c == "$cur_"* ]]; then
+			if [[ -z "${4+set}" ]]; then
+				case $c in
+				*=|*.) sfx="" ;;
+				*) sfx=" " ;;
+				esac
+			else
+				sfx="$4"
+			fi
+			COMPREPLY[i++]="${2-}$c$sfx"
+		fi
+	done
+}
+
+# __gitcomp functions end here
+# ==============================================================================
+
 # Discovers the path to the git repository taking any '--git-dir=<path>' and
 # '-C <path>' options into account and stores it in the $__git_repo_path
 # variable.
@@ -307,81 +446,6 @@ _get_comp_words_by_ref ()
 }
 fi
 
-# Appends prefiltered words to COMPREPLY without any additional processing.
-# Callers must take care of providing only words that match the current word
-# to be completed and adding any prefix and/or suffix (trailing space!), if
-# necessary.
-# 1: List of newline-separated matching completion words, complete with
-#    prefix and suffix.
-__gitcomp_direct ()
-{
-	local IFS=$'\n'
-
-	COMPREPLY+=($1)
-}
-
-__gitcompadd ()
-{
-	local x i=${#COMPREPLY[@]}
-	for x in $1; do
-		if [[ "$x" == "$3"* ]]; then
-			COMPREPLY[i++]="$2$x$4"
-		fi
-	done
-}
-
-# Creates completion replies.
-# It accepts 1 to 4 arguments:
-# 1: List of possible completion words.
-# 2: A prefix to be added to each possible completion word (optional).
-# 3: Generate possible completion matches for this word (optional).
-# 4: A suffix to be appended to each possible completion word (optional).
-__gitcomp ()
-{
-	local IFS=$' \t\n'
-	__gitcompadd "$1" "${2-}" "${3-$cur}" "${4- }"
-}
-
-# Creates completion replies, reorganizing options and adding suffixes as needed.
-# It accepts 1 to 4 arguments:
-# 1: List of possible completion words.
-# 2: A prefix to be added to each possible completion word (optional).
-# 3: Generate possible completion matches for this word (optional).
-# 4: A suffix to be appended to each possible completion word (optional).
-__gitcomp_opts ()
-{
-	local cur_="${3-$cur}"
-
-	if [[ "$cur_" == *= ]]; then
-		return
-	fi
-
-	local c i=0 IFS=$' \t\n' sfx
-	for c in $1; do
-		if [[ $c == "--" ]]; then
-			if [[ "$cur_" == --no-* ]]; then
-				continue
-			fi
-
-			if [[ --no == "$cur_"* ]]; then
-				COMPREPLY[i++]="--no-... "
-			fi
-			break
-		fi
-		if [[ $c == "$cur_"* ]]; then
-			if [[ -z "${4+set}" ]]; then
-				case $c in
-				*=|*.) sfx="" ;;
-				*) sfx=" " ;;
-				esac
-			else
-				sfx="$4"
-			fi
-			COMPREPLY[i++]="${2-}$c$sfx"
-		fi
-	done
-}
-
 # Clear the variables caching builtins' options when (re-)sourcing
 # the completion script.
 if [[ -n ${ZSH_VERSION-} ]]; then
@@ -430,62 +494,6 @@ __gitcomp_builtin ()
 	__gitcomp_opts "$options"
 }
 
-# Generates completion reply from newline-separated possible completion words
-# by appending a space to all of them. The result is appended to COMPREPLY.
-# It accepts 1 to 4 arguments:
-# 1: List of possible completion words, separated by a single newline.
-# 2: A prefix to be added to each possible completion word (optional).
-# 3: Generate possible completion matches for this word (optional).
-# 4: A suffix to be appended to each possible completion word instead of
-#    the default space (optional).  If specified but empty, nothing is
-#    appended.
-__gitcomp_nl ()
-{
-	local IFS=$'\n'
-	__gitcompadd "$1" "${2-}" "${3-$cur}" "${4- }"
-}
-
-# Fills the COMPREPLY array with prefiltered paths without any additional
-# processing.
-# Callers must take care of providing only paths that match the current path
-# to be completed and adding any prefix path components, if necessary.
-# 1: List of newline-separated matching paths, complete with all prefix
-#    path components.
-__gitcomp_file_direct ()
-{
-	local IFS=$'\n'
-
-	COMPREPLY+=($1)
-
-	# use a hack to enable file mode in bash < 4
-	compopt -o filenames +o nospace 2>/dev/null ||
-	compgen -f /non-existing-dir/ >/dev/null ||
-	true
-}
-
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
-
-	# use a hack to enable file mode in bash < 4
-	compopt -o filenames +o nospace 2>/dev/null ||
-	compgen -f /non-existing-dir/ >/dev/null ||
-	true
-}
-
 # Execute 'git ls-files', unless the --committable option is specified, in
 # which case it runs 'git diff-index' to find out the files that can be
 # committed.  It return paths relative to the directory specified in the first
-- 
2.33.0

