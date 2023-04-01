Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB1AC6FD1D
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 08:49:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbjDAItn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 04:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjDAIs3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 04:48:29 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B1AC24ADB
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 01:47:31 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id i4-20020a056820138400b0053e3ccf739cso2991061oow.10
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 01:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680338851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7zDVUklVnqdCHHIueKcYsEjxBEjEGyahRgIWWt6aQ0Q=;
        b=NtSRF5k96hsLQp3Bpj4+3gZq+/8ApjHsffWXYZ1L9PEngE1HNIv3O60Scj1p0phNF+
         vM3wLEKoZyOT6gQOiU28uCvPJf9NLXkfkADxfKTdCPdx+/7fZjnuCVFuLicwwTpQOA3O
         5tJ/kgH3yYUzTmJMGN+b4NDoYmKkxocZC4W9GSq+3lBJdgxo3/XftEjlixwOCM8CgpWO
         j9e0wL93ebgM/f+uC4ZJMZZr+RhjH2RtrWEVY0it7jsPxDhbPULXERXxqhhx8/X+ozIA
         wWcJClESx+GC2KaHQqN3ng3LQGwT7b/6hoCNaajOKdOEJYAM2Zby+2ee5u8bXPOcLlpQ
         FUkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680338851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7zDVUklVnqdCHHIueKcYsEjxBEjEGyahRgIWWt6aQ0Q=;
        b=AZBA2JRSIqfolB7WxhQtQBmeLzVTaxgZFgEEwwxTcOFfdyilbAyNdVCpILKze7duPR
         afQg9vfMHk94JcDcdCegwAiiRA3ULfYCRDG8DoMvWriA1CGZ0Bt2uaqv5tDUenQ0VFN5
         wLBUT6dlWwlUjscrVTjbY598xWM4z+pfJo5xxZQod3L5KHulQ6PdESiz5f6oxAseg+XU
         Bw2Jzuzhmr7yROPNvbzG/xpDQS9hx/Etu7d0lSCUTe+v/beQ9iJN4hrLVmQTqsoevX+9
         QICO+2Hd0nTaqwDdR83y/WV+LSNbYxaYkHq4Twej8mvhIlqE9z88JT4e0mC3+Q+M5+B+
         pa6Q==
X-Gm-Message-State: AO0yUKUcpnx3MUS/9SqiH3rjFH/j1h1huXnPnFPZ2DaqNRHZZdNW3iqE
        20gipMKNRoF1fMSMwAP8NQOV4PqJrns=
X-Google-Smtp-Source: AK7set+LmS0QKfjY47vnIYCuynZWWhlLSDqeGbSphQRxaCOXwlyiDoctRnd0fMR1zIfvL+iqivSQYA==
X-Received: by 2002:a4a:5515:0:b0:53b:6112:3b16 with SMTP id e21-20020a4a5515000000b0053b61123b16mr14929188oob.9.1680338850955;
        Sat, 01 Apr 2023 01:47:30 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id x80-20020a4a4153000000b0053d9be4be68sm1791768ooa.19.2023.04.01.01.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 01:47:30 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v7 46/49] completion: bash: refactor _get_comp_words_by_ref()
Date:   Sat,  1 Apr 2023 02:46:23 -0600
Message-Id: <20230401084626.304356-47-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230401084626.304356-1-felipe.contreras@gmail.com>
References: <20230401084626.304356-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We don't need a separate function to do what we already know we want to
do.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 109 +++++++++++--------------
 1 file changed, 47 insertions(+), 62 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 7b46ce503d..63a9409b0e 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -345,21 +345,11 @@ __git_dequote ()
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
@@ -367,60 +357,55 @@ __git_dequote ()
 # shared with other completion scripts.  By the time the completion
 # function gets called, COMP_WORDS has already been populated so local
 # changes to COMP_WORDBREAKS have no effect.
-#
-# Output: words_, cword_, cur_.
-
-__git_reassemble_comp_words_by_ref()
-{
-	local exclude i j first
-	# Which word separators to exclude?
-	exclude="${1//[^$COMP_WORDBREAKS]}"
-	cword_=$COMP_CWORD
-	if [ -z "$exclude" ]; then
-		words_=("${COMP_WORDS[@]}")
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
-			words_[$j]=${words_[j]}${COMP_WORDS[i]}
-			if [ $i = $COMP_CWORD ]; then
-				cword_=$j
-			fi
-			if (($i < ${#COMP_WORDS[@]} - 1)); then
-				((i++))
-			else
-				# Done.
-				return
-			fi
-		done
-		words_[$j]=${words_[j]}${COMP_WORDS[i]}
-		if [ $i = $COMP_CWORD ]; then
-			cword_=$j
-		fi
-	done
-}
 
 if ! type _get_comp_words_by_ref >/dev/null 2>&1; then
 _get_comp_words_by_ref ()
 {
 	local words_ cword_
-	__git_reassemble_comp_words_by_ref "=:"
+	local exclude i j first
+
+	# Which word separators to exclude?
+	exclude="${COMP_WORDBREAKS//[^=:]}"
+	cword_=$COMP_CWORD
+	if [ -z "$exclude" ]; then
+		words_=("${COMP_WORDS[@]}")
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
+			words_[$j]=${words_[j]}${COMP_WORDS[i]}
+			if [ $i = $COMP_CWORD ]; then
+				cword_=$j
+			fi
+		done
+	fi
+
 	cword=$cword_
 	cur=${words_[cword]}
 	prev=${words_[cword-1]}
-- 
2.33.0

