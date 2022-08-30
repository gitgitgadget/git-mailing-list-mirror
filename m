Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79EF6ECAAD4
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 09:35:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbiH3Jf0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 05:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbiH3Jee (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 05:34:34 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31854E58A1
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:33:05 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-11f4e634072so1127052fac.13
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=HnH6dC7OHuStdtDb06m88U0BNK3ncjzQYgWcrLZaKCQ=;
        b=DRifiaLOMf0dVjz0lTgjyfJPw+cV1zDCOBF+4tzI8ym/5O0Wt3TBWEGBoHS9M8nx95
         rDlLXHuJe5tVGWVG6oS0vF3zj6gSbD1Najy1PvSzej5KkxK1u2rJwPdZnrLNmLlLgi6n
         sOKAC3aR1jGi5tFHaiLhYbRHOv+RNlml05QKGd4R1puGvYeF+aW4lAPxQSt2da3I00Su
         WfhFwB725FKkUqh/Mf+65WoQMTlpuiPt+Jy4UFZoxH+s556NrjzolaMkLswsCsqyLd9L
         bqvfNqC2X+EjC0JkXFVFaMkk88VHhkCtp/8DEO/Y5aYyFvwy5F2Z/Kc+QZLjxrLYzbzU
         u6UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=HnH6dC7OHuStdtDb06m88U0BNK3ncjzQYgWcrLZaKCQ=;
        b=RhTA4+Qds/jrYSNoyhH2/PPgXHuNDGCZwzjkN49UGb1R9grOIrFZDoWTmsqfW7qRvV
         RYY+abyHkRNtgMnjedYQqNVqWNrBXvCdJSXNdyJsCkO1Adr5pPoMtmcJSCn3ZGt0mfT5
         DGM9SgzVeUNRyHHdWw1NIwWY1wivbfV4LWkQWpdvhC97iMak4FXV9TObOY497RuCwYLo
         u9lfA/z6WKmZBcbA5BO5fEfbPdu36XpWEpqCsCX/CgCDBaXKtIjdeg26Hk7YeEMRS7P2
         mg0P5aVG1mWQPi1P5WPA6AcDd9AsZ0xdTAy8r3yIBgZPdRvimYDLz/rBRevuwSmuBPwn
         KTSA==
X-Gm-Message-State: ACgBeo3NjizTWU3W+FS1YuEHsYErBmTAXYjuwFh2Kal1uly3MqW3Vweh
        IF+gVAVMwTkKibn/9RSM2dgbOJ2IQ44=
X-Google-Smtp-Source: AA6agR4bhwmmBCSOeN6gxMVIL/pqZjwNk7lzxS9AUv/pl7ma7ZqKACcmESdi+IUAK6NC7nmxAvs5YQ==
X-Received: by 2002:a05:6870:4302:b0:10d:c587:d30e with SMTP id w2-20020a056870430200b0010dc587d30emr9904645oah.28.1661851979797;
        Tue, 30 Aug 2022 02:32:59 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:eec:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id q22-20020a056870e61600b0011c65559b04sm8072803oag.34.2022.08.30.02.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 02:32:59 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     git-fc@googlegroups.com,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 46/51] completion: bash: refactor _get_comp_words_by_ref()
Date:   Tue, 30 Aug 2022 04:31:33 -0500
Message-Id: <20220830093138.1581538-47-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.37.2.351.g9bf691b78c.dirty
In-Reply-To: <20220830093138.1581538-1-felipe.contreras@gmail.com>
References: <20220830093138.1581538-1-felipe.contreras@gmail.com>
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
index 45550f7839..4261143d97 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -339,21 +339,11 @@ __git_dequote ()
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
@@ -361,60 +351,55 @@ __git_dequote ()
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
2.37.2.351.g9bf691b78c.dirty

