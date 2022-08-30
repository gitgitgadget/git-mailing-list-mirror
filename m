Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BEDCECAAD4
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 09:35:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbiH3JfZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 05:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbiH3JeO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 05:34:14 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB88E42F4
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:33:01 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-11f11d932a8so6971484fac.3
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=366MRLfEN1K0YcOvitZAbjQZyBNnkO98Yq9qZOv58lE=;
        b=S3e1tDr4r2CbSaOU7ComQm24X0NUAg0fm2XbSzgp/YRkOuFBbLAe/qTJCqF+AjyaoI
         Ip9hAOr43r/6j1A1rHBHCEjOJo7IXvbI5HN6WBJVa6mrKBauJLxKCiFm6BystL/Ltag8
         669FMUePw8LI7tUfdvIjlTGSq9PzChRAYMoMdH3OaURMfpikgnuBg9tzp+HwKzUCQ3wM
         FwofSZJsAoTx47CtDR36d2UaL/AVjgO+zWsh5v4C/MSuxWqx98hbQdEOe8HxQjyEZU1L
         U1kxbX9XBJwXAutjkwpQvJy2EKFw4PrlZLLgZ9A0hUnnQWzyZXCdPjszZ2LHi7Zd4Ufm
         bLug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=366MRLfEN1K0YcOvitZAbjQZyBNnkO98Yq9qZOv58lE=;
        b=PsMc+Wc0yw4rXfOhzfPMuBh3c6mqA1CrSPA6nkuBta51eg6WWLnp+ppWCDnzs73Jly
         BckULkKutnzbwzAS78P98QfCk6xOJYFuVohSiFePbvW1hAYMYl2NFZ7k46rdgSa8A0Cl
         7x7QbWJqRZlGJExHtUqNfxb8ijRfK/C1a/IdEqhtrbCvDv2KQE9DDDCSI7JfrGIL/L9u
         9rwRK4KLI6lpFGoLk+kj1I8YmnpHreTr5B+PzxCfj8ZphtTAL2VYaN4JvrQ49BTBQsjr
         KntW2mdeXe+QOkgn8y0+tocznuPNZFbfieZKUtTPlwCfSOrO4aTj0inV7i0/YroYEXg5
         J6rg==
X-Gm-Message-State: ACgBeo3UME5Pm61vwJAffpkOgZWr9Q53GTrq8zUSa1lOcDYqkJb2T1fd
        cGibeEV2unT+4ubEMJ/CdjNmM35AtmY=
X-Google-Smtp-Source: AA6agR5V8/v+WClTUF3qCpKirOREpwpCisJNF8RKghXdNut9NeaXr1jVDOm5SbYqHbsnkWnR+xBXpQ==
X-Received: by 2002:a05:6870:783:b0:11c:7d1c:6ede with SMTP id en3-20020a056870078300b0011c7d1c6edemr9420001oab.239.1661851981307;
        Tue, 30 Aug 2022 02:33:01 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:eec:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id n14-20020a056870034e00b0010e046491f8sm4852900oaf.57.2022.08.30.02.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 02:33:00 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     git-fc@googlegroups.com,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 47/51] completion: bash: cleanup _get_comp_words_by_ref()
Date:   Tue, 30 Aug 2022 04:31:34 -0500
Message-Id: <20220830093138.1581538-48-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.37.2.351.g9bf691b78c.dirty
In-Reply-To: <20220830093138.1581538-1-felipe.contreras@gmail.com>
References: <20220830093138.1581538-1-felipe.contreras@gmail.com>
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
index 4261143d97..92831977d7 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -355,14 +355,13 @@ __git_dequote ()
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
@@ -382,9 +381,9 @@ _get_comp_words_by_ref ()
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
@@ -393,17 +392,15 @@ _get_comp_words_by_ref ()
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
2.37.2.351.g9bf691b78c.dirty

