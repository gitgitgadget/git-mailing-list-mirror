Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 274CBC433E6
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 020E0207A3
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:17:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbhAACRj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Dec 2020 21:17:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727374AbhAACRh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Dec 2020 21:17:37 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C92C06179F
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:17:22 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id i6so19329947otr.2
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eAAs/flHI/ezKbZQXxJOIuAnqMLBbVhSMzwjvdTGKwo=;
        b=GI5tAnhQLS19b9g5LMTpEDDGQ889DDiXzx6xgXRfHczSM0yA+Zask7LGugriaLn4+I
         ujWWYdg4xsYz16hnWOyfF8qebdgzwhheWUWRB32sFbcatior6JMWFgiu+WlxbU12HgI9
         6QEfZU3naFJchJQRvJz42AGG5NQh6XVBVgur9tIDAAlx22iPv5bOmUs8RUFvDaneSlIE
         DY6UIQ9yNwEyjNHNmvOyu2HDAq7kIDHPOquKnDLydTkQ74piLDqUZUSjzQQNNw/NEHAc
         6Mt7vN59hSwL98ImDsnXAxiVzekKxFITF18WWKUOCvgcG2i6Q5ADbTe1iQnK+g6ltODB
         4Ymw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eAAs/flHI/ezKbZQXxJOIuAnqMLBbVhSMzwjvdTGKwo=;
        b=Euf9plJr6qNWGW21JZUwinl1h5GlxS+EgB0vAEW6W9kLdvSNPMIvoJ2K/14R+ViEQC
         W441+mcKXCzFViRTKMMA2FAd12fabEpovg15l+dQcXiYYcaCXeMeIYLaAdniSmdq10aK
         XKqYu6Ipf5CkuSn9XjWwE1gzX7V/DNw+SDPAUb2NoPfT8Jnd4Y3rS1Tg2d9LNtGMM/R2
         NznctVgjjTv5BmzrJtfXsojrgpmP9Q2Nxg+0tKS9Ag4Qh/Tk3MkGK95/1sKCak3JdMrM
         q7g93FTYE7tzzXB+ZO491ki3GafFxMBA5j3Y7v2upwaCqGca518wJhxSb15yaS2GRuaV
         q2/w==
X-Gm-Message-State: AOAM532XEjyMvNJe/GYdo2q5bXBElzFuNHUL4CUGw3/yO5D+d1ao1Uhq
        G+h/1MmXh+rdLVChnxkYvbOlWQFZVe1iBA==
X-Google-Smtp-Source: ABdhPJyoI/VZo1SyBu12Tj8ebG3vpz2bS/iVIfdskoLkachMTL2KpDhnu+rp5iBygGztzWGacTvCgQ==
X-Received: by 2002:a9d:2287:: with SMTP id y7mr42033749ota.137.1609467441624;
        Thu, 31 Dec 2020 18:17:21 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id b188sm7858187oif.49.2020.12.31.18.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 18:17:21 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 36/47] completion: zsh: add __gitcompadd helper
Date:   Thu, 31 Dec 2020 20:16:11 -0600
Message-Id: <20210101021622.798041-37-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210101021622.798041-1-felipe.contreras@gmail.com>
References: <20210101021622.798041-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So we don't have to do the same over and over.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 82a4d6f470..4e9699f542 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -49,12 +49,16 @@ COMP_WORDBREAKS=':'
 GIT_SOURCING_ZSH_COMPLETION=y . "$script"
 functions[complete]="$old_complete"
 
+__gitcompadd ()
+{
+	compadd -p "${2-}" -S "${3- }" -- ${=1} && _ret=0
+}
+
 __gitcomp ()
 {
 	emulate -L zsh
 
-	local IFS=$' \t\n'
-	compadd -S "${4- }" -p "${2-}" -- ${=1} && _ret=0
+	IFS=$' \t\n' __gitcompadd "$1" "${2-}" "${4- }"
 }
 
 __gitcomp_opts ()
@@ -69,7 +73,7 @@ __gitcomp_opts ()
 	for c in ${=1}; do
 		if [[ $c == "--" ]]; then
 			[[ "$cur_" == --no-* ]] && continue
-			compadd -S " " -- "--no-..." && _ret=0
+			__gitcompadd "--no-..."
 			break
 		fi
 
@@ -81,7 +85,7 @@ __gitcomp_opts ()
 		else
 			sfx="$4"
 		fi
-		compadd -S "$sfx" -p "${2-}" -- "$c" && _ret=0
+		__gitcompadd "$c" "${2-}" "$sfx"
 	done
 }
 
-- 
2.30.0

