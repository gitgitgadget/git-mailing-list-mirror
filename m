Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4582EC2D0A3
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 17:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BBE42087D
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 17:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V+lXX3jl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732110AbgKDRrf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 12:47:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728679AbgKDRrc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 12:47:32 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A0CC0613D3
        for <git@vger.kernel.org>; Wed,  4 Nov 2020 09:47:31 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id i18so15371148ots.0
        for <git@vger.kernel.org>; Wed, 04 Nov 2020 09:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UEW6E9+N/jkXvYi9lr0+pv6BPwfmU/Gz88cwmAxLmJc=;
        b=V+lXX3jljFicx27GPPZLilYojui4XL/Opb4pFhGDYux/SpVF48KGkCHe2eRGcf4zwH
         /93l6UWzzjej5HVomAzHcETkyzZSpuVH67l4IdctuFxK2ozvcXUKXTgfQX8XKZ4wmsqU
         TZMFO0ahfBSgugV3KxNvWF39Zjz0UKCxMGBX6t59zqzqLMU2Fw+1wlYGUtu8vcJlyuWN
         EKPee9gYHoTCgjEpqDnpiUBAiogBu4Ra5y8kIkVBGSn/H2HlQHbuMqZLZrEuuYObLcLD
         JobHfuG4O8iAAACI/avjnECWeNDLUmFhvS5M0KGPnwZ4ZRidH5jEp7Qtx9OSXOVXynDj
         TcmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UEW6E9+N/jkXvYi9lr0+pv6BPwfmU/Gz88cwmAxLmJc=;
        b=mqd1P5AKprYL2/7kfvx2PzirxABWJk3vUUnTIPEJ8gs9sI7VGfwppZ8HVegCooOmqK
         86akjSIJPZh2iPRKrMv6kV0sQKgnQphKTZzduHkzHpaCfYM3riEH8cf2E/Blxd5mlFFe
         DIdU9JGaQ0od/ZXaODkFxNvbqVV30FI0DHCpKkZHiPnbK7NLWeWPnU6kqnOIUI5CNOvH
         pPZwBpJf2wxl/HxdcVR4TVlD1nDTl8fMg/uxbZE5LTXMbOX74LKWWVNjnvIDMlfjmuX7
         lE167H6vQyXlm7p/voCQtusaun6knSlRB+EG6Z+ln+ch3JWASeBxSvSSHnIs0DHfcHCu
         nrIw==
X-Gm-Message-State: AOAM530VI2zk4a3yxJniW1c6/oT4KlTeV3JviOFcnVaZMi42GEeqE0BW
        587kzpsZlFOlg1LDq0DNIVy0ok8CkzKVqw==
X-Google-Smtp-Source: ABdhPJwpdB79p7vOsEIM+iH91FW22B1e1E729NzrsVdHjImmzHZflVTlJ2ib8vLX3qbWqIEyUU4sVA==
X-Received: by 2002:a9d:f67:: with SMTP id 94mr5643187ott.282.1604512050905;
        Wed, 04 Nov 2020 09:47:30 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id b1sm652277oof.43.2020.11.04.09.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 09:47:30 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 07/10] completion: bash: refactor _get_comp_words_by_ref()
Date:   Wed,  4 Nov 2020 11:47:13 -0600
Message-Id: <20201104174716.783348-8-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201104174716.783348-1-felipe.contreras@gmail.com>
References: <20201104174716.783348-1-felipe.contreras@gmail.com>
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
index 1bd81dcc9c..f856db148b 100644
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

