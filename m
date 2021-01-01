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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75AB4C4332D
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A9AA20798
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:17:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbhAACRb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Dec 2020 21:17:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727302AbhAACRa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Dec 2020 21:17:30 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49080C0617A5
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:16:48 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id o11so19320545ote.4
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5y+4DtCXeaD9Knoxg4NCohvRcDUJjPCGNeZxkz17Haw=;
        b=NlU/ao4nv+T3Mwr8i9ltHO5gGAJfsa3ur/NCmXADC7VARM5rWTX7CkMCzARhDSUorX
         IYPQQ+yjBHjAzTQL/ACxgd1E0z1bWWETN5lwyUOV0UB4P9EEOaMSKipfgt9pj6tlTU57
         4bTZaj/Mpg6Y2BI5eKUeyWiswZigZGM3Yp38wcBmlBlvlLPkSlevX5sfGNSZEj+7/wKC
         v/k3uyhfeeIUFkm75Wr1UNEhK2XsLfDXD/kdl5750CprulwAQ1gydDucoDsgZgjq2FxS
         K+j6zXbYIGJx+Vni+Gg/nyB5qiLZEMSbC7qzG2ubt4LQoARJ3rbKjG3H14FfC46bfZ5N
         Jm7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5y+4DtCXeaD9Knoxg4NCohvRcDUJjPCGNeZxkz17Haw=;
        b=gGVwnnnQaCFBpEhYuKnpD9gLbQQ+/DLQM5MJH9fnIR+Lgr4xnT3ily5Bu7zuNpPV34
         vMyeKDZbtVM9LaZvDTp4JYK0mmdWWAHEIO+kIhCVVFRRLB5tl5oap04zWyeIYeVlxLN0
         4EuLhXwJsUQJIX/akCwVstuh6hdTMI5DAm81YwqkJVMZ2F6ER0aySoCdyq2HW5mrbnzy
         3RLu0HZaWC1xbbKaZnw+L5vJBvYcD4xM6DN45XFEs0r9skhtmyWZfG/1USsMvBchVrJe
         WJxZ4wl0i8f7aoBpH4p4yIqfuqbQ8l9Q1rc6Vmaui10dQBWPp0BQLaQmWpONsYs/4n0T
         xMWA==
X-Gm-Message-State: AOAM533NkAf62cz73fC3T2YISEJjBfT2DBQU++jj+tHNSmLnVP1BTlAn
        8+wiCSmiMGBOcv4hJ4IHGsE0P0OT13Z2dQ==
X-Google-Smtp-Source: ABdhPJwu/bperEGJQuQind8PoMpnrs7Nzsr1ayt5suW3fe/8lYCUmX8dRla36evypR9Xj1zjqkvA5w==
X-Received: by 2002:a05:6830:400f:: with SMTP id h15mr44125194ots.284.1609467407500;
        Thu, 31 Dec 2020 18:16:47 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id z6sm11315509ooz.17.2020.12.31.18.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 18:16:47 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 14/47] completion: zsh: add support for general -C opts
Date:   Thu, 31 Dec 2020 20:15:49 -0600
Message-Id: <20210101021622.798041-15-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210101021622.798041-1-felipe.contreras@gmail.com>
References: <20210101021622.798041-1-felipe.contreras@gmail.com>
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
2.30.0

