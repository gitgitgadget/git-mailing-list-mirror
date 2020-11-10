Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B223C55ABD
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 21:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B08A4206F1
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 21:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lDNw1s94"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732052AbgKJVWe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 16:22:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732030AbgKJVWa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 16:22:30 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05987C0613D4
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 13:22:30 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id n89so137721otn.3
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 13:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5/1QeBCX0cJkbLMBnrlRk2Qmcs/II1ykY3MtvDvC5mo=;
        b=lDNw1s94+8qYVy+indI40yH/QEmZsF8yMEiH2DdHn1TIP8yVYGjUrNvbbCWyzsn2U5
         XvSBa/ZVNx+aMEissPktd6GZJRpeTgxN44puygv6vM5ZlXPTXInh664wOWjYvgJEVFrI
         srAjBLYTRqkwGA8267teFiO+e0xTJGqpgZMouRjIAg9jvBlX8j+VUblPcVeS5yXjuQnL
         oDGQ0Z/LNAOax39XqzvR5t8uOg5Bz5QaLs4TbycZKfCAgQw4QkjjnGUY2ZyjyYF43FwW
         XpbsPTLibtdEHPBH36Zuws/8PdFgmhvjIWwoUI8pVgcFxGMjMmHy1Mh98iLC4nD1AFSo
         cE0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5/1QeBCX0cJkbLMBnrlRk2Qmcs/II1ykY3MtvDvC5mo=;
        b=Pyb6h1xXUKghNAsii6aAz4y1j9ZiW4ijWteVJh5qGPnTEzadWs6VZvqXuFw5LONeM+
         RcG7w6U2ovhq8wHaP3NeL2qXFLs4egERk8/K+xIeyXvW5y3rZtDv6r4fXK4xvXdqTUHc
         Yfs2NX1rVD1XhHI3XkKWmq6enBqg97aNZGvZaJHLxO7sCKRxUkg1gIJvrc5wFb42Tpxl
         lf10zKVu34TSaeOy04j+8U6jVNMwg9jIpT6XExL0PNdU8QawvS01B0HKsYNsHTGhd9w/
         PVElSbpXxAZgCHUCxdikrYkYG1cIYMLEup8VOOjWPpcPbgQFEPmvLPHK3Lt/Qmuy48ov
         aamg==
X-Gm-Message-State: AOAM533KIEqrHve8d98L3XYwTXXcaHtf08rDtuDNPB20CLqn4hkRTfBV
        5eU6/RgiwTGO/cJj60zDsQRveY/Lgx6J/w==
X-Google-Smtp-Source: ABdhPJwHeFnWEZIYIyYc3a3B/OJ3PU+NSEum8hwUwABdjhVVALkb0p70Zr1roSad9p1M69+WCDhaXw==
X-Received: by 2002:a9d:d37:: with SMTP id 52mr14975784oti.60.1605043349001;
        Tue, 10 Nov 2020 13:22:29 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id k13sm35258ooi.41.2020.11.10.13.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 13:22:28 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 26/26] completion: bash: shuffle __gitcomp functions
Date:   Tue, 10 Nov 2020 15:21:36 -0600
Message-Id: <20201110212136.870769-27-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201110212136.870769-1-felipe.contreras@gmail.com>
References: <20201110212136.870769-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

They are the ones that actually do the completion, put them at the top.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 262 +++++++++++++------------
 1 file changed, 135 insertions(+), 127 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index d73cdb7096..578b6b0d2f 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -45,6 +45,141 @@
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
+			case $c in
+			*=|*.) sfx="" ;;
+			*) sfx=" " ;;
+			esac
+			COMPREPLY[i++]="${2-}$c${4:-$sfx}"
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
@@ -159,77 +294,6 @@ __git_dequote ()
 	done
 }
 
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
-			case $c in
-			*=|*.) sfx="" ;;
-			*) sfx=" " ;;
-			esac
-			COMPREPLY[i++]="${2-}$c${4:-$sfx}"
-		fi
-	done
-}
-
 # Clear the variables caching builtins' options when (re-)sourcing
 # the completion script.
 if [[ -n ${ZSH_VERSION-} ]]; then
@@ -278,62 +342,6 @@ __gitcomp_builtin ()
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
2.29.2

