Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81356C43460
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 16:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44D7161158
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 16:20:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234546AbhDZQVi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 12:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234279AbhDZQVi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 12:21:38 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA0DC061574
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 09:20:56 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id g4-20020a9d6b040000b029029debbbb3ecso19643897otp.7
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 09:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ip6oa/1BmqqMO9VmS4ezgMQBQCHod7yBpmCLsS8sGYU=;
        b=Orr5+KswXMfRZKJ5fGYEJ+xFzpa7eTuBHLCNpGdL+V/HiCV5p9Jvi5nDoixcPMMtwq
         jI69ddgr4f9fTTFu8C9mImkulIVYLjeLMi9o93O2Xembws3Bkrlg5pGS0Z33NFYs/izq
         IYuYu1hIoSA4eCIX5v6q9COtJp18Q+Ck7b2HGcYgaxKl+8FYE3VOsjYpvmdLG8cyIynS
         g6iuTaXh0fub3Tq8LUDz36tjz3P+eZcNapoqVbFNh5Si8wAJ+M+lXphYIAurGHsFYQZH
         nQnHDi3uu70SUY21hn/EToLwcjRJlbBsK3M9y5FVO57VFMMYHvkHMoT/b6dnpUjTByyF
         MEqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ip6oa/1BmqqMO9VmS4ezgMQBQCHod7yBpmCLsS8sGYU=;
        b=A/DuygGZRfUXlG+mcl09Vpe28rXBWUDGQu/ERzQYpklKQvtLhs6a6fqt29wHwZJMYY
         g3xXou9/U9wbP4WW206vbpfm8WSWMSR4zo+JumXJAuv+6/UafbHV7TZNqs4pzVifUlzW
         Qlf0/HpR3EP0CwiVZXSjVxxFs3tm5F5Ndyn9x7RSbow0DPZwRY70jchNHBHLFgLET4tj
         OsPJgvZiGV7SxnSF7Sc/TDo5phSW8BpzVn+EKuiwC4TVkaVJUXHUrrCQMPzuypsguOib
         Bl+bNSpgK791DhaU5juatzOLhNS7SenizXy/2c1wY5J8afesHvTla9D1xATzsbRgjmvr
         YMNQ==
X-Gm-Message-State: AOAM531+4pAscL2eHCXNRYUw9dqjacOc0Zq/LcGYk9xLWlp6royNSZw1
        PDV85qCOujHk3/6jSNuY6NcHw/eqdWkIVA==
X-Google-Smtp-Source: ABdhPJwlfJ/80YF1VEhsbstnwY1t4JbyRwm9yOputxPkap9K3XPZG6kG38oPjOePSLkeTX05WpTzOg==
X-Received: by 2002:a9d:7ad7:: with SMTP id m23mr14916765otn.347.1619454055664;
        Mon, 26 Apr 2021 09:20:55 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:638f:a2c5:89ff:fe0c:1151])
        by smtp.gmail.com with ESMTPSA id k8sm3132313oig.6.2021.04.26.09.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 09:20:55 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v1 40/43] completion: bash: cleanup _get_comp_words_by_ref()
Date:   Mon, 26 Apr 2021 11:14:55 -0500
Message-Id: <20210426161458.49860-41-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210426161458.49860-1-felipe.contreras@gmail.com>
References: <20210426161458.49860-1-felipe.contreras@gmail.com>
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
index 05b6762210..4b01de38a9 100644
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
2.31.0

