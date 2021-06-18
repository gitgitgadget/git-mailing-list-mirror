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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE23C48BE8
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 18:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76ED7613E2
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 18:27:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235403AbhFRS3X (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 14:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235096AbhFRS2t (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 14:28:49 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D163C061574
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 11:26:39 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id v22-20020a0568301416b029044e2d8e855eso1377457otp.8
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 11:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UKz0w+fDZwtHdACEV3EyfOdt/qztcW5K7S4pEcj+Fgg=;
        b=e4C6NjY7RkuT20IWPlk4X5SRoz2NR2q0V1k8u1iMhxIvakD6ri3AXerOk5cHfO0yA0
         /JMbGRPaO0/MWMsIORUnJXPegMrxg7jmuKO3Kl3kI+nm2upgqHqBecUYtDWYjZo+05ic
         Qq5DoiHZoCZMvohGGhxREtvav5ckWQd6LE0tPLnvcoA3Z/ojfwUiSFSKVqHaIN26cOdF
         /2R66c/pdBgQcpjjesvQAB+x+lzTPL28Qr7P0SIxYSpCKbpnn3R1rG8vqRAdbaGnIGKC
         pnQvWnRV0aJKo0zvOFGjiqUnxlPT4ec5f54g47G16pfeqjLvaNTVh0uoWCK93esxxk94
         6Rlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UKz0w+fDZwtHdACEV3EyfOdt/qztcW5K7S4pEcj+Fgg=;
        b=TbSBQ782ZGrqI2N3fRRERrWjBH7EpRdwpix7gH1qN07KhL1AcITtRlf3IpqoqmACaK
         fvjn5x82EwpdH8b/i/XNdVqTjbG1RdnIMM9MZquxOSLhwLoViyKYkulaqVyj1eCp/q0n
         5+kKa42ZfiNrWBOYGoxqNGMC3FcAC7bul2myZ6kVzp3ZlpXr/FjYKsUMd/T3Mc3PhWF5
         j1UD5fCSXJwGOLRpzekYHapkgLDDRxfyDOA0xqsUyJKDcUQBqkp61bKhroSOYxISfhtR
         gWZhgLhSCb7NZNA6G2nvCFmKaR627CVSHuacm/2SlkcDkQJg6C4uPQ0+78SLX645Z3ti
         dNxg==
X-Gm-Message-State: AOAM533uTVCzxfMcmB00XixuV94vbQvT8fT4VLOoSGB8sSwQpMFpEssN
        kPwxs34y9broi0fgpN5bABk0+fvrls68Mw==
X-Google-Smtp-Source: ABdhPJwjO0gAWn7SZET+rL2XucbkApa5XVSPp5ODs4s5nZwkIalP9z0DNyLGfoEELGFejeoWLXx98A==
X-Received: by 2002:a9d:554a:: with SMTP id h10mr10886891oti.177.1624040798566;
        Fri, 18 Jun 2021 11:26:38 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id t15sm1930822oie.14.2021.06.18.11.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 11:26:38 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 42/45] completion: bash: refactor _get_comp_words_by_ref()
Date:   Fri, 18 Jun 2021 13:25:15 -0500
Message-Id: <20210618182518.697912-43-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618182518.697912-1-felipe.contreras@gmail.com>
References: <20210618182518.697912-1-felipe.contreras@gmail.com>
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
index 2c0b869aba..9976009951 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -334,21 +334,11 @@ __git_dequote ()
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
@@ -356,60 +346,55 @@ __git_dequote ()
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
2.32.0

