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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 697AAC433E9
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C6CC207A3
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbhAACRh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Dec 2020 21:17:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727302AbhAACRf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Dec 2020 21:17:35 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1279C0617A4
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:17:14 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id a109so19308210otc.1
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TYZJlMbJRg/flUoz9KwLgKLaK0kjiGvpnuJudRD+UJ0=;
        b=Z5eyJ2ZSwpWzs9yzCpVCWQ0NGWw4GcSNcEoNKtRVLH6Wnonfwu9fkQLPWSiMgHqIrM
         1s+0Akw2tyJF5BAqWWC83xUn3ZgnrhP/TI2V5vGVc9wms9/LV2PzL0tv1ePsvJ7qnF4+
         UM8KSTjj+1PlgVkrQMxmjsYmTb+6m6bsrb0teqg0V4Fu7/juS3ifLMsu+v2sCHZBl0n8
         uxmZLVSJSce64Fa1qcsc18CTUwvSErENsm0HaBCn9udyd3D89QTNVldFvUVndR3TQplz
         GEWuP7oImt8J+vH590Je+2coKnyWujCfrP8IjyP1YP4laF49sNP8T2lIhZf9hhJOdcZV
         XGjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TYZJlMbJRg/flUoz9KwLgKLaK0kjiGvpnuJudRD+UJ0=;
        b=cVeU31jzq98/r3/WuvB9jxCZT9wEDvd+JIXpe7XjjCN0e0C9D7D9tkUEAwg3I2hO8D
         H8SXNaCUToTjzmkrNH2QYI8DSV9gONxbTofF4jzM5ecbuZE922hUeEnaunIm0OhdH3U9
         qJK2CYQI96jUBA7fhViNxgGsKkVLXXr6LaMNdjD7muT77vSIB6pWAtYT7hiOzifn9vyb
         wICvjcDSav/OQxYto14v1QCiGPvsM8AqffqZvGEKL9vdKnB7ALWQ9aMdZy98i8jbYxtI
         7C5zNbSz28eJYXtqqgTApieuxPJEJPc/ko0g3OPdbrF4Ykltf4R7EqDzUf692/EucpYk
         6PmQ==
X-Gm-Message-State: AOAM530X8f4sag1VHXpcSZ6o6lhSzRp3kmsiMxbnuLcOGPnqhGX6TkJV
        lgrGmn7fhSCwQhy7UmHAw61lm67ZDCOD3g==
X-Google-Smtp-Source: ABdhPJxX2h0kCOlb/mrjWv0l8+azLVYKNDxo2wescRly5atDNADh60CD5zjcGwUmlMS0sXj5aoz/IQ==
X-Received: by 2002:a9d:d52:: with SMTP id 76mr43362314oti.67.1609467433762;
        Thu, 31 Dec 2020 18:17:13 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id j126sm7946064oif.8.2020.12.31.18.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 18:17:13 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 31/47] completion: bash: shuffle __gitcomp functions
Date:   Thu, 31 Dec 2020 20:16:06 -0600
Message-Id: <20210101021622.798041-32-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210101021622.798041-1-felipe.contreras@gmail.com>
References: <20210101021622.798041-1-felipe.contreras@gmail.com>
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
index 9bcb484656..3fa597ce71 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -45,6 +45,145 @@
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
@@ -287,81 +426,6 @@ _get_comp_words_by_ref ()
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
@@ -410,62 +474,6 @@ __gitcomp_builtin ()
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
2.30.0

