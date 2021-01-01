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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 100A8C4332B
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E129420798
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:17:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbhAACRc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Dec 2020 21:17:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727302AbhAACRb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Dec 2020 21:17:31 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE06C0613C1
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:16:51 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id f132so23396366oib.12
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3l9CiW/DLvSs0U1CBEq/KrZ4KKX/Bb1WjAloJhWFli0=;
        b=Fa3G+6zbA0gfCpGFxne+L2DDyQFLtQpyDQ54weA6T4kaATVaVF5Rn9GI0EVMHFXKdy
         TjvDPbKSUV6Y+2qgSt0d+PWGLlhWY2UyuIbsL1QECis6HboANG6PBfcAjFz8S7LwzjZP
         Su6AsZyErA/IifA2CT5PTH2Yt6bqorHW4KKaZwohCJvEmhxdBOL6v0hnSZX5EhRDTaJ/
         F3advEzfbFNIp1iq+FjOLCbtKIGP+ZvYWUJCXq+WuCBF6wRPCHzu8UkEcTVwN+/nMRxu
         K2Deo5X5SAMCTlkYL69Zmw9I78Pjvhf2Fou49P4cc6QTYoGqsLzRuZiAIb+ghVM9SB5j
         U1OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3l9CiW/DLvSs0U1CBEq/KrZ4KKX/Bb1WjAloJhWFli0=;
        b=QZODk4OtW3z8Xtg/F4hdBcI/AEc5lrV7/sKfTtpM2QJRqyJkXPnjF6JxPHZmAd5aQM
         QobYMAQiQlAsQmTkbBweX7NweEIrh92lRgA8lAN1AiX51fVDHmTaXZpzejPV3pAlR4Wr
         XpN3VaTDK7rHwmB67vwxgh8qzCmLAKfbEoZ0qwXx4cnzbaLnj+Mli0cDT6TyuYDT/fny
         63BRzjXIMsNE/4J8lXpcpfXaV6Qyxbw/QRF50bCRS1seKOlFdyVpmDGTKobVhjU2ruWB
         37IIHjStTWVdCaZZCpNicD8YSeDFBzJtKPVL83oZQAywMpQQvti3gDePoC2sx6p6VRym
         By6g==
X-Gm-Message-State: AOAM531r38QdSB7zHkhh/m7OOLLHChDZBmL5HiQAWruHmqsRKmo7SCFN
        xughxFR+LnBEuk790EAsMMWWxSmrMIcNOg==
X-Google-Smtp-Source: ABdhPJyOQikQekHdyLAT/xAadU7dYQuwrQC3Gk0ssUaEV1DqcCeUtofbt/wfvno6IesNlEeBjmHGew==
X-Received: by 2002:aca:c78a:: with SMTP id x132mr9474475oif.144.1609467410546;
        Thu, 31 Dec 2020 18:16:50 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id q127sm12124875oia.18.2020.12.31.18.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 18:16:50 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 16/47] completion: zsh: add support for general -c opts
Date:   Thu, 31 Dec 2020 20:15:51 -0600
Message-Id: <20210101021622.798041-17-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210101021622.798041-1-felipe.contreras@gmail.com>
References: <20210101021622.798041-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So we can specify configurations.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 46564126e4..6232d0a823 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -232,6 +232,7 @@ __git_zsh_main ()
 		'--no-replace-objects[do not use replacement refs to replace git objects]' \
 		'(- :)--help[prints the synopsis and a list of the most commonly used commands]: :->arg' \
 		'*-C[run as if git was started in the given path]: :_directories' \
+		'*-c[pass a configuration parameter to the command]: :->config' \
 		'(-): :->command' \
 		'(-)*:: :->arg' && return
 
@@ -245,6 +246,10 @@ __git_zsh_main ()
 			let _ret || break
 		done
 		;;
+	(config)
+		compset -P '*[=:]'
+		emulate ksh -c __git_complete_config_variable_name_and_value
+		;;
 	(arg)
 		local command="${words[1]}" __git_dir
 
-- 
2.30.0

