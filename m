Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8025C56201
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 21:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90E85206F1
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 21:22:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TxK3KOIZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732020AbgKJVW0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 16:22:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732000AbgKJVWW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 16:22:22 -0500
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FCEDC0613D1
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 13:22:22 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id f16so93457otl.11
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 13:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0VqKHIhymTntDzvr1gPM0ji+e+nE+poyW90nI4hjCmw=;
        b=TxK3KOIZE07qBmTsBscAznjQt4975bylyWu2Zuf9AJYIoiAUG74N/jC/51lq/qRYNg
         tV4hJw1BxyKvEha+zhQ6ieaCEFgtCqiTampK8zXRzawEm2DRylIs9awXuquYwSW2jqa7
         VC3eacPVnRyTC5j420kxqSHpsOBDr0+fuytH3xCcO/P9C3PZ/VlhcS7hWDzh8XafNIZV
         QKXgdi9y6mMPlwdDxmfwo2Hyca2oLCAesYYDwGzV4bChte+AXEoI8EFy9zasTtamfAQw
         29lXy2wGv8/ZQ+BejL5AYln3wK02m8nZmmI0bWSPb9+r9PLWywgk5HT30b7HyEgRghC9
         uX+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0VqKHIhymTntDzvr1gPM0ji+e+nE+poyW90nI4hjCmw=;
        b=MtSP7XBbBQr59rhH0TC/5jnzeM3Cvtvks78fnvT49XBFbb7u2t48F/n9+el0xo0xst
         xdGaJwZafu74RTphmPAngPbr5lJGoO+Uyse7Yf2DdaPcOhp+Nc5WnOPHZucCD/7kFijA
         kEwOzVxHxpUmQcPb0YhXvNB41ypkL//7vjOaFPnU4rDke19WPWbJ32pZ4mi9zH17b36+
         0WG/SdtUNwMHOIa/BIT/wvLBq3s96mD+MykcDvTJODGDy319+EqJ1VqqNb4hOgEx+Nc5
         /vAXsLh79NpI2anEpBpKlg14JC61+xSPifFiwTLwT2Mb/BE9gqdPalE5Npw+3F3Eh05z
         naLA==
X-Gm-Message-State: AOAM530x8jiSy8/aiLKZ0ZlKpTKHzOsFenpboEdPeTnMGc2GYxJw23CS
        P1+2TKXRy9LELJpxAHg0veJQ1iwe7LSlcA==
X-Google-Smtp-Source: ABdhPJxcI33sQfz9TDCD2yBMLxQcZ7b3Bpg+Yxvp30mSYEjR2FHDNvFf7HAqTRRjl+bPQ/MrSqt+4A==
X-Received: by 2002:a9d:4aa:: with SMTP id 39mr15648809otm.11.1605043341502;
        Tue, 10 Nov 2020 13:22:21 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id e127sm3376501oia.12.2020.11.10.13.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 13:22:21 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 22/26] completion: bash: rename _get_comp_words_by_ref()
Date:   Tue, 10 Nov 2020 15:21:32 -0600
Message-Id: <20201110212136.870769-23-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201110212136.870769-1-felipe.contreras@gmail.com>
References: <20201110212136.870769-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's only used in one place, rename it, and use it even if
bash-completion's more inefficient version of _get_comp_words_by_ref()
is available.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 184 ++++++++++++-------------
 t/t9902-completion.sh                  |   2 +-
 2 files changed, 92 insertions(+), 94 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 26f9accc30..ffff7e2317 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -159,98 +159,6 @@ __git_dequote ()
 	done
 }
 
-# The following function is based on code from:
-#
-#   bash_completion - programmable completion functions for bash 3.2+
-#
-#   Copyright © 2006-2008, Ian Macdonald <ian@caliban.org>
-#             © 2009-2010, Bash Completion Maintainers
-#                     <bash-completion-devel@lists.alioth.debian.org>
-#
-#   This program is free software; you can redistribute it and/or modify
-#   it under the terms of the GNU General Public License as published by
-#   the Free Software Foundation; either version 2, or (at your option)
-#   any later version.
-#
-#   This program is distributed in the hope that it will be useful,
-#   but WITHOUT ANY WARRANTY; without even the implied warranty of
-#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#   GNU General Public License for more details.
-#
-#   You should have received a copy of the GNU General Public License
-#   along with this program; if not, see <http://www.gnu.org/licenses/>.
-#
-#   The latest version of this software can be obtained here:
-#
-#   http://bash-completion.alioth.debian.org/
-#
-#   RELEASE: 2.x
-
-# This function reorganizes the words on the command line to be processed by
-# the rest of the script.
-#
-# This is roughly equivalent to going back in time and setting
-# COMP_WORDBREAKS to exclude '=' and ':'.  The intent is to
-# make option types like --date=<type> and <rev>:<path> easy to
-# recognize by treating each shell word as a single token.
-#
-# It is best not to set COMP_WORDBREAKS directly because the value is
-# shared with other completion scripts.  By the time the completion
-# function gets called, COMP_WORDS has already been populated so local
-# changes to COMP_WORDBREAKS have no effect.
-
-if ! type _get_comp_words_by_ref >/dev/null 2>&1; then
-_get_comp_words_by_ref ()
-{
-	local exclude i j first
-
-	# Which word separators to exclude?
-	exclude="${COMP_WORDBREAKS//[^=:]}"
-	cword=$COMP_CWORD
-	if [ -n "$exclude" ]; then
-		# List of word completion separators has shrunk;
-		# re-assemble words to complete.
-		for ((i=0, j=0; i < ${#COMP_WORDS[@]}; i++, j++)); do
-			# Append each nonempty word consisting of just
-			# word separator characters to the current word.
-			first=t
-			while
-				[ $i -gt 0 ] &&
-				[ -n "${COMP_WORDS[$i]}" ] &&
-				# word consists of excluded word separators
-				[ "${COMP_WORDS[$i]//[^$exclude]}" = "${COMP_WORDS[$i]}" ]
-			do
-				# Attach to the previous token,
-				# unless the previous token is the command name.
-				if [ $j -ge 2 ] && [ -n "$first" ]; then
-					((j--))
-				fi
-				first=
-				words[$j]=${words[j]}${COMP_WORDS[i]}
-				if [ $i = $COMP_CWORD ]; then
-					cword=$j
-				fi
-				if (($i < ${#COMP_WORDS[@]} - 1)); then
-					((i++))
-				else
-					# Done.
-					break 2
-				fi
-			done
-			words[$j]=${words[j]}${COMP_WORDS[i]}
-			if [ $i = $COMP_CWORD ]; then
-				cword=$j
-			fi
-		done
-	else
-		words=("${COMP_WORDS[@]}")
-	fi
-
-	cur=${words[cword]}
-	prev=${words[cword-1]}
-}
-fi
-
 # Appends prefiltered words to COMPREPLY without any additional processing.
 # Callers must take care of providing only words that match the current word
 # to be completed and adding any prefix and/or suffix (trailing space!), if
@@ -3383,10 +3291,100 @@ if [[ -n ${ZSH_VERSION-} && -z ${GIT_SOURCING_ZSH_COMPLETION-} ]]; then
 	return
 fi
 
+# The following function is based on code from:
+#
+#   bash_completion - programmable completion functions for bash 3.2+
+#
+#   Copyright © 2006-2008, Ian Macdonald <ian@caliban.org>
+#             © 2009-2010, Bash Completion Maintainers
+#                     <bash-completion-devel@lists.alioth.debian.org>
+#
+#   This program is free software; you can redistribute it and/or modify
+#   it under the terms of the GNU General Public License as published by
+#   the Free Software Foundation; either version 2, or (at your option)
+#   any later version.
+#
+#   This program is distributed in the hope that it will be useful,
+#   but WITHOUT ANY WARRANTY; without even the implied warranty of
+#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#   GNU General Public License for more details.
+#
+#   You should have received a copy of the GNU General Public License
+#   along with this program; if not, see <http://www.gnu.org/licenses/>.
+#
+#   The latest version of this software can be obtained here:
+#
+#   http://bash-completion.alioth.debian.org/
+#
+#   RELEASE: 2.x
+
+# This function reorganizes the words on the command line to be processed by
+# the rest of the script.
+#
+# This is roughly equivalent to going back in time and setting
+# COMP_WORDBREAKS to exclude '=' and ':'.  The intent is to
+# make option types like --date=<type> and <rev>:<path> easy to
+# recognize by treating each shell word as a single token.
+#
+# It is best not to set COMP_WORDBREAKS directly because the value is
+# shared with other completion scripts.  By the time the completion
+# function gets called, COMP_WORDS has already been populated so local
+# changes to COMP_WORDBREAKS have no effect.
+
+__git_get_comp_words_by_ref ()
+{
+	local exclude i j first
+
+	# Which word separators to exclude?
+	exclude="${COMP_WORDBREAKS//[^=:]}"
+	cword=$COMP_CWORD
+	if [ -n "$exclude" ]; then
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
+				words[$j]=${words[j]}${COMP_WORDS[i]}
+				if [ $i = $COMP_CWORD ]; then
+					cword=$j
+				fi
+				if (($i < ${#COMP_WORDS[@]} - 1)); then
+					((i++))
+				else
+					# Done.
+					break 2
+				fi
+			done
+			words[$j]=${words[j]}${COMP_WORDS[i]}
+			if [ $i = $COMP_CWORD ]; then
+				cword=$j
+			fi
+		done
+	else
+		words=("${COMP_WORDS[@]}")
+	fi
+
+	cur=${words[cword]}
+	prev=${words[cword-1]}
+}
+
 __git_func_wrap ()
 {
 	local cur words cword prev
-	_get_comp_words_by_ref -n =: cur words cword prev
+	__git_get_comp_words_by_ref
 	$1
 }
 
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index e39febcc4a..efb98cc96c 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -38,7 +38,7 @@ GIT_TESTING_PORCELAIN_COMMAND_LIST='add checkout rebase'
 # We don't need this function to actually join words or do anything special.
 # Also, it's cleaner to avoid touching bash's internal completion variables.
 # So let's override it with a minimal version for testing purposes.
-_get_comp_words_by_ref ()
+__git_get_comp_words_by_ref ()
 {
 	cword=$_cword
 	cur=${_words[cword]}
-- 
2.29.2

