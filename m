Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BFECC43460
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 16:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC38F61158
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 16:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234485AbhDZQUN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 12:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234156AbhDZQUN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 12:20:13 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03C2C061574
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 09:19:31 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id w6-20020a4a9d060000b02901f9175244e7so289759ooj.9
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 09:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=36Ps/c6tYITbKpd1B9O85sbHJPq0DBcBeFZfKDNIsJo=;
        b=WlBeUoKPmgspMVv9dTfQlQgMem42pOEvZPFkb5GhjebNWeE/aXRsuJah6iXYtqYM7q
         2Fa1IYC+BFeluYSfSpdS/1JKg1/EL/XHsaFUFeowgQC+G0dzq2wyqnwpxkGkvlI/BnlT
         thV4otQGEjxwHy3chGxrM00BeYS+10iH3KzBGOnRFQLKOTOT4Ierm7UZV5vBWzamhOwV
         QAOr4GIExMWpgI1zWiHfdImElDYkpcbeARrpR5/0/rC9U2VRIjAWdkriiN2RoqSkRShg
         F5mJK5hlbW/zdxbT8pzFy6ezwjhDXVP6Zj/tqLyabdbudsAu6/IMYMJ8I3l9+WPYxSzP
         cyVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=36Ps/c6tYITbKpd1B9O85sbHJPq0DBcBeFZfKDNIsJo=;
        b=AaqGKF791ZdB3po6sJUxQgYeF3IrLyoalW+Ba1GpmS0ATqZjQ7rjvuriXd1hcKDu28
         QC0QQvOnOqZAuVSdBTysSFXC9Acr/t/JnCRn/X2XMMZB2Qp9iMF1X1qkohbD55ldm9WK
         vrTurD/9p/DnsqudITfmCxOFDqtHsXLe7eKPXugyu3AMKDnJyhoxt5q65m+MhfIO0wzW
         zrZOwMFhKt/tl6IN5e67dAC2hECnPzJyj/XuKzcI3HwTFyhooWIbBnnmxBVGwJHcL4oV
         QUcR11KcANaKjOl8vEYySA2oR//j4E+lfGXoiDEqNwaepuvtMnVywCgYfJW/aSjFGmPo
         FXbg==
X-Gm-Message-State: AOAM533bSj9+B3TgjSPfzwhtBso7AQvdT8sgXjroRm+Vgt8b0wViAgo2
        cOTZsnfMvLS0VjfWBJ7wkUD+3Dcpws6TaA==
X-Google-Smtp-Source: ABdhPJxAs7U8fRusCk2/QS+ZNjl/7DYdjNNwez4izTuxKI5PR/8uQOHENTNlY+RS2/aqHltqqRgAcg==
X-Received: by 2002:a4a:8e18:: with SMTP id q24mr14191949ook.66.1619453970676;
        Mon, 26 Apr 2021 09:19:30 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id o25sm619744oie.45.2021.04.26.09.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 09:19:30 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v1 31/43] completion: bash: shuffle __gitcomp functions
Date:   Mon, 26 Apr 2021 11:14:46 -0500
Message-Id: <20210426161458.49860-32-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210426161458.49860-1-felipe.contreras@gmail.com>
References: <20210426161458.49860-1-felipe.contreras@gmail.com>
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
index 44cf70daa4..d760434c0c 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -54,6 +54,145 @@
 #     When set to "1" suggest all options, including options which are
 #     typically hidden (e.g. '--allow-empty' for 'git commit').
 
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
@@ -296,81 +435,6 @@ _get_comp_words_by_ref ()
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
@@ -419,62 +483,6 @@ __gitcomp_builtin ()
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
2.31.0

