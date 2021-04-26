Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51DC9C433ED
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 16:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27D026109E
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 16:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234554AbhDZQVm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 12:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234156AbhDZQVm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 12:21:42 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC81C061574
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 09:21:00 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id d25so19448671oij.5
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 09:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qt8puCLeEk0kBL/J008NHabnhWsHxnR+OCzSibOTT1w=;
        b=tZzPFiB/SxkAWQBo7mfFqscPWpRfX7i8akENd4eLaXbGojN4aCWi6Kbj/VChkyRLIE
         3GKHQoAyJ9XuFooHuBX1tK11e63TPJGTelCqGJmn+q9al3ZDA0jOx9gngDqohrnprCre
         CE7fGnzyMXEew6poaeb8zpl24li18CSouPA88gJw6PFGTAOr+S9OjOvyI6KlTrXMuieH
         8MvcRyQt7rsB3ueX55eBvH35PWIT6OfBSYqygXmcNyP6rLFGeRRKmNRHKpAz4J1mTYOd
         8MNfz3En5DpiCYMWqsBVT6Xo3PgNk6GueWxc7Br6w556ou20V0UvtlPEEZo8+6QElq0E
         aC4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qt8puCLeEk0kBL/J008NHabnhWsHxnR+OCzSibOTT1w=;
        b=fYG2cFWfaZyjq8T94xlTKKtko2QuwuHV7UkfoM9Kq8Dym9M7xozsLDAOiNny3ofZfn
         JXvmZfKchAeF+L2oDusDhkyLptFMeEupmSRRw8Ow5sVOrwCOGrWMW0vprRvswXP+M4Lk
         ifdoOmFNPACE+/5sLdmd4qvfYIBPIEGJGTRgSrKj5ZbGUj3QOvJiZGnvbVD75tZk7IOo
         Ah+K3pHl+CYiq/JxhyEOykW2/1egTavL+i5l5qPQjI6p7bHSQqRh62VlzqXYIfHBpF5a
         l+po3QsLK051WEpMwAkDdaAdcoRuRF/hGw2Qhx63a8xcGfN37EtfY7eQm/DBFtBJO+2y
         KcUg==
X-Gm-Message-State: AOAM530JsLM7hatvV0fOukazJVq55GqM4eSWGMTCgaQFvHtX5WxmqcEa
        dejeTZiFdATv7VvfPCNp+RxCi+MIdRoG8w==
X-Google-Smtp-Source: ABdhPJyWYlxK6iB7GcAwg94v29AN1S/NcMN9mnlRiAgTyKMXGGAGDdVUUA2JtdZpwYr8EBVLGSIjsQ==
X-Received: by 2002:aca:af45:: with SMTP id y66mr12446065oie.43.1619454060054;
        Mon, 26 Apr 2021 09:21:00 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id 186sm76899oof.14.2021.04.26.09.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 09:20:59 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v1 41/43] completion: bash: trivial cleanup
Date:   Mon, 26 Apr 2021 11:14:56 -0500
Message-Id: <20210426161458.49860-42-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210426161458.49860-1-felipe.contreras@gmail.com>
References: <20210426161458.49860-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The most typical case first (COMP_WORDBREAKS contains our wanted words).

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 4b01de38a9..1cd249383b 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -355,9 +355,7 @@ _get_comp_words_by_ref ()
 	# Which word separators to exclude?
 	exclude="${COMP_WORDBREAKS//[^=:]}"
 	cword=$COMP_CWORD
-	if [ -z "$exclude" ]; then
-		words=("${COMP_WORDS[@]}")
-	else
+	if [ -n "$exclude" ]; then
 		# List of word completion separators has shrunk;
 		# re-assemble words to complete.
 		for ((i=0, j=0; i < ${#COMP_WORDS[@]}; i++, j++)); do
@@ -392,6 +390,8 @@ _get_comp_words_by_ref ()
 				cword=$j
 			fi
 		done
+	else
+		words=("${COMP_WORDS[@]}")
 	fi
 
 	cur=${words[cword]}
-- 
2.31.0

