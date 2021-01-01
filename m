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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B656C433E6
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 483A3207A3
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:17:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbhAACRo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Dec 2020 21:17:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727406AbhAACRm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Dec 2020 21:17:42 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA57C061575
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:17:27 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id r9so19257651otk.11
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xjGv7sBsQKOgqEP5Xw9AzGgVPmW3q8Sn5KKQPSyw1Ok=;
        b=hPBwEdbyiqpGaJgCu4ejnHkOZbZ3BOQo42p25YOkPNYEs2APBuskUQpKMdxvrlhDwK
         fWQLLSFFu+dLn9reaYbohOKM3KD1FrVehWaZXNZeOdrcU/m+W5Jgl2+a/kQWGurrQEJv
         bkNcOFCtozuCwVeyPfxWRW+FnFNdREKXuDeKXapldPHh2j4fon9amuI7NAMhRAgfhYaR
         JQh/9UEg4I5ZVcwF5Gq/8W+QP6+pq0kwxijG4CUf5OC0prX+cvpMBwFhEbz0djrF2PtU
         IJf3W+xhIwxUB77kcLSvcmBBW6ECw+5WKLP5S3x/C3xtzB0RO9Fav4vLOSvNCYux3pG+
         i6+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xjGv7sBsQKOgqEP5Xw9AzGgVPmW3q8Sn5KKQPSyw1Ok=;
        b=J17JI0ja0b1KFcarkoffXsKaxNvhW4tO+4ZFCo/6El+WXqsWjmLUPf3YSmwy8gc+VX
         X/LR71rzBNkqIRBvR0zoWDLMZBB+yUkDbbLF6wW4l8kE+vXsneMtIEc+BOqxM6qLnLMr
         g+ZIwCzuMWC34xsaOVw40lJ+MV41pcDuCltKNV5V1kJkLq9X8d5m+lB4CUFV0rwG/K2r
         zq0Rkrzt9de28KSSZRT916U39HpVBWL0U06YpUzQVW3kAt61gymcVLiRLr1crRbIjoY6
         uHb5gwoCKBDbdEmeTzM3bW0bY05fOBg6QilmMk+J0ThRc9yEUEj+/ZfWO1Qeli2f8P37
         8aAg==
X-Gm-Message-State: AOAM532g46MTGFZL8dsmYQwMfhlZHfiGehlHawrCdiEzt/SXahV+YWvt
        WrhDO6ZRBKxzWMLDUEX4y1bx+D3+obn2Ig==
X-Google-Smtp-Source: ABdhPJz8iaMKHnBzYUgOr96yDtXu3D3J7WeGnUyNhH0ZhqDfpdPVBWc4ZqkzsJ1zdivLwEnP8ImOng==
X-Received: by 2002:a05:6830:1105:: with SMTP id w5mr37160324otq.255.1609467446194;
        Thu, 31 Dec 2020 18:17:26 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id m3sm12320591ots.72.2020.12.31.18.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 18:17:25 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 39/47] completion: bash: refactor _get_comp_words_by_ref()
Date:   Thu, 31 Dec 2020 20:16:14 -0600
Message-Id: <20210101021622.798041-40-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210101021622.798041-1-felipe.contreras@gmail.com>
References: <20210101021622.798041-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We don't need a separate function to do what we already know we want to
do.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 93 +++++++++++---------------
 1 file changed, 39 insertions(+), 54 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 0510010ff6..040391f881 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -325,21 +325,11 @@ __git_dequote ()
 #
 #   RELEASE: 2.x
 
-# This function can be used to access a tokenized list of words
-# on the command line:
-#
-#	__git_reassemble_comp_words_by_ref '=:'
-#	if test "${words_[cword_-1]}" = -w
-#	then
-#		...
-#	fi
-#
-# The argument should be a collection of characters from the list of
-# word completion separators (COMP_WORDBREAKS) to treat as ordinary
-# characters.
+# This function reorganizes the words on the command line to be processed by
+# the rest of the script.
 #
 # This is roughly equivalent to going back in time and setting
-# COMP_WORDBREAKS to exclude those characters.  The intent is to
+# COMP_WORDBREAKS to exclude '=' and ':'.  The intent is to
 # make option types like --date=<type> and <rev>:<path> easy to
 # recognize by treating each shell word as a single token.
 #
@@ -347,60 +337,55 @@ __git_dequote ()
 # shared with other completion scripts.  By the time the completion
 # function gets called, COMP_WORDS has already been populated so local
 # changes to COMP_WORDBREAKS have no effect.
-#
-# Output: words_, cword_, cur_.
 
-__git_reassemble_comp_words_by_ref()
+if ! type _get_comp_words_by_ref >/dev/null 2>&1; then
+_get_comp_words_by_ref ()
 {
+	local words_ cword_
 	local exclude i j first
+
 	# Which word separators to exclude?
-	exclude="${1//[^$COMP_WORDBREAKS]}"
+	exclude="${COMP_WORDBREAKS//[^=:]}"
 	cword_=$COMP_CWORD
 	if [ -z "$exclude" ]; then
 		words_=("${COMP_WORDS[@]}")
-		return
-	fi
-	# List of word completion separators has shrunk;
-	# re-assemble words to complete.
-	for ((i=0, j=0; i < ${#COMP_WORDS[@]}; i++, j++)); do
-		# Append each nonempty word consisting of just
-		# word separator characters to the current word.
-		first=t
-		while
-			[ $i -gt 0 ] &&
-			[ -n "${COMP_WORDS[$i]}" ] &&
-			# word consists of excluded word separators
-			[ "${COMP_WORDS[$i]//[^$exclude]}" = "${COMP_WORDS[$i]}" ]
-		do
-			# Attach to the previous token,
-			# unless the previous token is the command name.
-			if [ $j -ge 2 ] && [ -n "$first" ]; then
-				((j--))
-			fi
-			first=
+	else
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
+				words_[$j]=${words_[j]}${COMP_WORDS[i]}
+				if [ $i = $COMP_CWORD ]; then
+					cword_=$j
+				fi
+				if (($i < ${#COMP_WORDS[@]} - 1)); then
+					((i++))
+				else
+					# Done.
+					break 2
+				fi
+			done
 			words_[$j]=${words_[j]}${COMP_WORDS[i]}
 			if [ $i = $COMP_CWORD ]; then
 				cword_=$j
 			fi
-			if (($i < ${#COMP_WORDS[@]} - 1)); then
-				((i++))
-			else
-				# Done.
-				return
-			fi
 		done
-		words_[$j]=${words_[j]}${COMP_WORDS[i]}
-		if [ $i = $COMP_CWORD ]; then
-			cword_=$j
-		fi
-	done
-}
+	fi
 
-if ! type _get_comp_words_by_ref >/dev/null 2>&1; then
-_get_comp_words_by_ref ()
-{
-	local words_ cword_
-	__git_reassemble_comp_words_by_ref "=:"
 	cword=$cword_
 	cur=${words_[cword]}
 	prev=${words_[cword-1]}
-- 
2.30.0

