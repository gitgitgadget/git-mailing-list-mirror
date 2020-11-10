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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E57C56201
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 21:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D80DD20781
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 21:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HWb+N4gP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731992AbgKJVWS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 16:22:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731981AbgKJVWR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 16:22:17 -0500
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4253C0613D1
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 13:22:16 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id f16so93218otl.11
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 13:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IYC7gVr5eIGjvppjJl0gAqkW+P5nqXGLpF5XTw5hth4=;
        b=HWb+N4gPCNtgHJ56FTdJH/Rv67jNi+ZXgB+59ShwSj6cd5vSk0mBtdM7VmNYCbTf/w
         qpEtvtlAe9Mt96rlfnximkXzUogwdrKTDT99j7Y/wodQVORTyKOMAJ2mvGaXMznbDSOA
         c0IRBYsd5OCOmxEs9ZA6xthKm7/EltqMNAH77TNnHuEoInBiueHwTu27LfIl2fwH/6vJ
         R5SH6DbN99wVAH5A9KkRYGflvAgwaxrtmp5UtFqNR1/yYQKzzfm6322cmDbq7qF0Kzt+
         XRnazlqXIogQS3GNwzh4p9zfbegEoVPyxcvYOjDT2hE18wRYvnRlSz9JzIyr6LqltRx1
         lSdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IYC7gVr5eIGjvppjJl0gAqkW+P5nqXGLpF5XTw5hth4=;
        b=qz9VQZc93QGkvXtIfT4RwPj4JN0uCcBGcy+VnuZcVPdbnH31saO210xyhXseUafpCL
         5EI4vJYOwI8YWFSetaRqvS5hrypgembpiY/5gJNWhfmvMd0SV1XN2Rp7F3+vDOf0vCsr
         cX6Hsk/GGnriVISUWwxmpG7/7V20Y3IYD/SEesKKTbqpyhhq6j9h5XdXY8mgB6CrZNPt
         XQURmoZVVoE7EZ4W9qp6T5ZNjnuKNdSLRLPJgB/HdMet6AZHQ1x9st4dPDVmRSO1aeHv
         9mRgIrMBWotN44WF6i8gQrPB50+iX4EIWVFVHdC1jDPTMEi2Gt3BnYDYqNTXSyP/Ny8h
         8+ZA==
X-Gm-Message-State: AOAM531EAdOS5jQBx7LjO7V6N6xxjMzZ3yQZm8dI/CpNDFUWZHBLFB96
        HLgdgBrPaK36XGANsIXwPzzVPilX4wQCgQ==
X-Google-Smtp-Source: ABdhPJy+7VjovC6j8y9vK6Bt2FnVfFwct+wDTuYmgIxzDI4NzblT4e8l0o3qO01gwOTQv++3ImT7kA==
X-Received: by 2002:a9d:481a:: with SMTP id c26mr15776515otf.58.1605043335829;
        Tue, 10 Nov 2020 13:22:15 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id r67sm3389165oif.43.2020.11.10.13.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 13:22:15 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 19/26] completion: bash: refactor _get_comp_words_by_ref()
Date:   Tue, 10 Nov 2020 15:21:29 -0600
Message-Id: <20201110212136.870769-20-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201110212136.870769-1-felipe.contreras@gmail.com>
References: <20201110212136.870769-1-felipe.contreras@gmail.com>
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
index 4548f0c5bf..a7dd04bb31 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -186,21 +186,11 @@ __git_dequote ()
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
@@ -208,60 +198,55 @@ __git_dequote ()
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
2.29.2

