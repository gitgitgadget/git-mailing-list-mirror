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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C10A4C4741F
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 17:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DF92208C7
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 17:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GVH0bI6i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730842AbgKDRrf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 12:47:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730685AbgKDRrd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 12:47:33 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77353C0613D4
        for <git@vger.kernel.org>; Wed,  4 Nov 2020 09:47:33 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id n11so20108309ota.2
        for <git@vger.kernel.org>; Wed, 04 Nov 2020 09:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AwsMYNgb0G5mnwFqNs/rWgQfqxDQJuNrB9U+MKHVaG4=;
        b=GVH0bI6ipWKasC4dYIkcLq4sVcuw3x2Koa9H+x7Y78ClNKgRTu7mznsi4UD63NQs22
         VOMJNXujGewNJUhhywvl7rNU8ZvFZNSr8suMLEXwTZehx6Jx2cyHF66YK19p4qXYG9h5
         lNfnX9CDKUP1aFlzqgqClcCDxibBI7d/X+tGJFqMo6gp1V5AdpUW/ksHFXUesUIUjBzp
         M66lNVqQkZcxGdP9NFwejdSoytDVdQxcvAoeLkZadShQv6N+ffd+m86Xu4aoyNNb3knQ
         sfCoLv8PelbHqDANaKO2OPUYmeKWCOC13VJk3r81ZwlYuD9uSDXxMdORmZyb0kOtwZiU
         HkdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AwsMYNgb0G5mnwFqNs/rWgQfqxDQJuNrB9U+MKHVaG4=;
        b=W0VfMBDsbisUUY/c4C2WimbMHesiltVTLuTBAJvVs6XCctrwCuH/XcqIZLyO02tI52
         /Z0CfQb1s74PuVr4RKOg2UXNG9avDQPl/Ar0+V1btsNwhWjqhnLj2DFXnsbNV5qwrvlP
         BWHFGqSh/f8IRHjQT2bHGa7OOcfAAIY3gR1B2wGUnhfd4GH9EsxuJF3+dlA/h1mnOS99
         9SvsuYVP2Lkp/q5X2rrUPi9v7P2Mc9et6m4kZxMdStM0oyEMBUOk1qgTjxpC7TJzAg0q
         PGO5fdVqdjWR6dVwpkK283mQXkfJCPh+2kGJBR70lMMJy/NTSqBQZCFwGxVsRGw9RrFj
         ighQ==
X-Gm-Message-State: AOAM533m6z7hCpje6KoLSWYJMGxYVIJ+7i064L91bdRbxieomDKVOCPr
        kk/EA11luFBgLwcFr0V3LMjAUo7ZZHsosw==
X-Google-Smtp-Source: ABdhPJyTCEHuIPm55x0//EGwa40o2ZoLTSqqTSF+TzYevmEKm1FuXR4r3tyJx2A/cpWvWdAWg/tFmQ==
X-Received: by 2002:a9d:46f:: with SMTP id 102mr3203894otc.293.1604512052650;
        Wed, 04 Nov 2020 09:47:32 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id v17sm616550ote.40.2020.11.04.09.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 09:47:32 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 08/10] completion: bash: cleanup _get_comp_words_by_ref()
Date:   Wed,  4 Nov 2020 11:47:14 -0600
Message-Id: <20201104174716.783348-9-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201104174716.783348-1-felipe.contreras@gmail.com>
References: <20201104174716.783348-1-felipe.contreras@gmail.com>
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
index f856db148b..3666fba8ca 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -202,14 +202,13 @@ __git_dequote ()
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
@@ -229,9 +228,9 @@ _get_comp_words_by_ref ()
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
@@ -240,17 +239,15 @@ _get_comp_words_by_ref ()
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
2.29.2

