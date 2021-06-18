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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3133DC48BDF
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 18:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17A74613F0
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 18:27:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236352AbhFRS3Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 14:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235359AbhFRS2y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 14:28:54 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18973C061760
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 11:26:41 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 66-20020a9d02c80000b02903615edf7c1aso10530113otl.13
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 11:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4rgajWZl0DFSpJct7I4QXRMbu1+TGuK6SYgJ5hyjBlw=;
        b=h3t9vixaxsnP+82pGW65Jm4VhSpcUMyQ/1Xx+1VaYlWJPGNARVMBK8SCr2aU2Uqtk4
         kPYtjpHzXjlACc6b9rLsfmOcWPpbsJaZlEpeqjR1vTZnym5poLxw81B/dQ+3K14MmrRL
         nhDsqu2av4wU9bCkDFW1ny3vPolvKf0Z7WIk5A/QRos7/HAgmNu+1ISVhSPDvpjHWZbq
         J98XGBab0NUu7X5hgBrNkYPEZ8mpTnI62XrUsFcXfsuZam67vHci4lkuO9PoEisuo6f1
         7pNeHnnj2LrKaATMKVHlNfgf94OOVq+0YqxVip/2z3KePlF94aEnqACyeLXv8BEXfKYN
         fUlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4rgajWZl0DFSpJct7I4QXRMbu1+TGuK6SYgJ5hyjBlw=;
        b=EtjZKgOkoWeidWeyEI1TwFgJHbIq8mRKTEFFbdoCneK8/LvljrbiKmcQ+GWHor1rBS
         XPakZl2i9zUiCKtc3rkQarU3HnO+ezDJgy8RBxey0T6U0tba/nrTB0rLL7g0f/G4w2Pr
         TwMX03CDaLI9jyI1ZmM9B1hoTlIn9zHvSYEV/AapSCRMIV45Pe9N9AgVhaWBIu8G7dmJ
         gqzKUlC2mYq6xhKNm3Z+Vt15vzh/z300IgNnbZM9QQHR/QCReJQzrWwx8gcqlwgHQJLD
         LS7TrLFeCWjoS0LXbJbUa+QTcauiFAKGVXe03A4lt0g4PMG3zCCh+5lEqt/oFVWcSJnJ
         j8rA==
X-Gm-Message-State: AOAM530/82nrZ+oaeiGbsdR2BLfq+Zb00TANQqfuXBNuOnlmNCn+uYiE
        UhwnWzkd0xBIhzVO/qFyjx5FYaFi/4tj9A==
X-Google-Smtp-Source: ABdhPJxsZH+m8P0Tvp4/tn/SLnxlf3lN+BUlTLN4hTWtUuAzfjRU9z+czsZvm5dSPHpj9Ek0mH3MuA==
X-Received: by 2002:a9d:20a2:: with SMTP id x31mr9928330ota.263.1624040800265;
        Fri, 18 Jun 2021 11:26:40 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id u14sm991304oie.0.2021.06.18.11.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 11:26:39 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 43/45] completion: bash: cleanup _get_comp_words_by_ref()
Date:   Fri, 18 Jun 2021 13:25:16 -0500
Message-Id: <20210618182518.697912-44-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618182518.697912-1-felipe.contreras@gmail.com>
References: <20210618182518.697912-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove temporary variables.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 9976009951..0433713242 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -350,14 +350,13 @@ __git_dequote ()
 if ! type _get_comp_words_by_ref >/dev/null 2>&1; then
 _get_comp_words_by_ref ()
 {
-	local words_ cword_
 	local exclude i j first
 
 	# Which word separators to exclude?
 	exclude="${COMP_WORDBREAKS//[^=:]}"
-	cword_=$COMP_CWORD
+	cword=$COMP_CWORD
 	if [ -z "$exclude" ]; then
-		words_=("${COMP_WORDS[@]}")
+		words=("${COMP_WORDS[@]}")
 	else
 		# List of word completion separators has shrunk;
 		# re-assemble words to complete.
@@ -377,9 +376,9 @@ _get_comp_words_by_ref ()
 					((j--))
 				fi
 				first=
-				words_[$j]=${words_[j]}${COMP_WORDS[i]}
+				words[$j]=${words[j]}${COMP_WORDS[i]}
 				if [ $i = $COMP_CWORD ]; then
-					cword_=$j
+					cword=$j
 				fi
 				if (($i < ${#COMP_WORDS[@]} - 1)); then
 					((i++))
@@ -388,17 +387,15 @@ _get_comp_words_by_ref ()
 					break 2
 				fi
 			done
-			words_[$j]=${words_[j]}${COMP_WORDS[i]}
+			words[$j]=${words[j]}${COMP_WORDS[i]}
 			if [ $i = $COMP_CWORD ]; then
-				cword_=$j
+				cword=$j
 			fi
 		done
 	fi
 
-	cword=$cword_
-	cur=${words_[cword]}
-	prev=${words_[cword-1]}
-	words=("${words_[@]}")
+	cur=${words[cword]}
+	prev=${words[cword-1]}
 }
 fi
 
-- 
2.32.0

