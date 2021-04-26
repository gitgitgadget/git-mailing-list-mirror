Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E7D6C43462
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 16:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C11B61175
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 16:16:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234378AbhDZQQ5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 12:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234365AbhDZQQy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 12:16:54 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8229CC061574
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 09:16:08 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id c8-20020a9d78480000b0290289e9d1b7bcso38530165otm.4
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 09:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i2MOBtdHMahanoqvZUvSdq1kGIAekDpUtvAp9RouC+w=;
        b=nWJuB1AShFfc1lx35PuepgvRAYGLhtJxA3DLaE9aiE3NIW5oTBqqjtcGbD9MC74CpX
         paLocp4sfAbm1N4qOkmSWEJ11GeIt0MEEadUtjRhm2bHQR4TzSGnNguZ6/1yuZ3kmf1y
         tskjgGZC6xDwyDbh9jAuP1mq3kBPcUFWJzHgS3FyiR9d8fo52goAy3c1jXtWRrzZSUp0
         D7kxmvq1aTfPEh1ie/Tm3IaY9JjMTuFjyr8v7GSrvhj1NM4Ez2pfU8XH2sToFwNWCGfd
         HO+R9zQWf7VRjrI78HMsEMZ7xp+n6+AyqnCAxgMneyRF4WRJVUEyG1miD4PnFXxNojff
         0mug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i2MOBtdHMahanoqvZUvSdq1kGIAekDpUtvAp9RouC+w=;
        b=MHK7M3vurWPJcq+JUko7TCydlbgy8AtsCvxkBAnQeO8NV3XsU1pFW9+gwRcmA5WbeH
         Ld9RLAaxdFy6rpQTspUGzpByBDovUNoDbMHKBwnIoWJ5GDFJXln38pfrhLro3z7Un912
         wp9A2YTyO2s3geOfYUpvI60drDXVTID6ItOyZp+MWms0M9XdlSC+gvYkyNNusrvUljRs
         hw8iPv7BOY1amrYhEFnkZo6l2ZikpQAVr1AY4uRrETprLYlYNAllBHl6RjxKtjJE1IKe
         LLZ+orQfEIB43ARpJEGGcXKHUjLP6FSZ7Rw68tELWjghRxYBRkDxQ8GxN56HTl8zobVU
         Uk5g==
X-Gm-Message-State: AOAM5329NoYPSUA8Viupk2tDTn03fBBgZ8Ew1IfzeysuYipF/QSnG2lu
        24LtvwfGpupwN4RN8AsNjGPWguQUfdqTYQ==
X-Google-Smtp-Source: ABdhPJxBHUylGBOUSU02vDKBel29C4hPIH/uvKTLXrTXiDlOnkX62rp6tWqPLf76DlRbCmXS76TqDg==
X-Received: by 2002:a9d:f28:: with SMTP id 37mr16485167ott.286.1619453767721;
        Mon, 26 Apr 2021 09:16:07 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id v3sm69444oom.38.2021.04.26.09.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 09:16:07 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v1 14/43] completion: zsh: add support for general -C opts
Date:   Mon, 26 Apr 2021 11:14:29 -0500
Message-Id: <20210426161458.49860-15-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210426161458.49860-1-felipe.contreras@gmail.com>
References: <20210426161458.49860-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 755135a2a5..a9177c7dcb 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -210,7 +210,7 @@ __git_zsh_main ()
 {
 	local curcontext="$curcontext" state state_descr line
 	typeset -A opt_args
-	local -a orig_words
+	local -a orig_words __git_C_args
 
 	orig_words=( ${words[@]} )
 
@@ -228,6 +228,7 @@ __git_zsh_main ()
 		'--namespace=[set the git namespace]:' \
 		'--no-replace-objects[do not use replacement refs to replace git objects]' \
 		'(- :)--help[prints the synopsis and a list of the most commonly used commands]: :->arg' \
+		'*-C[run as if git was started in the given path]: :_directories' \
 		'(-): :->command' \
 		'(-)*:: :->arg' && return
 
@@ -250,6 +251,10 @@ __git_zsh_main ()
 			__git_dir=${~opt_args[--git-dir]}
 		fi
 
+		for x in ${(s.:.)opt_args[-C]}; do
+			__git_C_args+=('-C' ${~x})
+		done
+
 		(( $+opt_args[--help] )) && command='help'
 
 		words=( ${orig_words[@]} )
-- 
2.31.0

