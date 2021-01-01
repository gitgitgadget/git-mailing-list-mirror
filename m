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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA76EC4321A
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9238D20798
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:17:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbhAACRW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Dec 2020 21:17:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727192AbhAACRV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Dec 2020 21:17:21 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7116C0617AB
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:16:58 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id n42so19270861ota.12
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OYmbLeCYNVIB/kCF1ypB+sA2xv3iHbDbP26TGrjz8uw=;
        b=RP19d4pj1+jCihR/BmdKwVMRT0+khOdsXmdGbOp4XCRjgLcoOjWHjFklWu6EIMh/1z
         WM1zrlFd1Ub8EFgE5pix1DKp2+wa8l4eqQC9RIsaKU72tAycxLUBuZmDQ/5aTE4dzhoh
         t1nUqfAexHaQpiQz5WJCRRsOghHYUS7OPsZameCOhz02fSXTod2dxe4rVE6fs32aeajH
         9PErlTbbWBnui3obtC1o58VjszAB5PKvTQDochosZjdkq6E59ZJSLV2DgFeyigOvaHz5
         y7djUrrOjqhRuvFIJv09qBpFLVLLjkciLRt++qUHrlubTCkbBLWm/odRvmoar+jYtyc0
         m6tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OYmbLeCYNVIB/kCF1ypB+sA2xv3iHbDbP26TGrjz8uw=;
        b=e62bcxU/H/9mDgONBhWFIwZYeeJDM2xsnEEhsZ5/G740iJnyQ5DQLiIX3Zt38+9CLu
         fgPBtos+IVJIWDywXajyN/LuHuuWeuqUbCjU5bhsccgpS6HjlebiORBKhavoa1puMcLi
         Gd2URRMBy/2PguqgUTuLa8SrWzM2U7A9Oo71fvZ5oehGJr48qzvLckbHXr8yYbAkvKx5
         bxJhEUhI38zC5bKeDbMA76QSuyatn2qbqq/aNP+QN1mxeSmoANz54Lxr5W8GjdV0civa
         +6G58JYAJQzsjkUwRgiWhZWRUqZePjh8Jda7mAEja2esRMn75sWGTyCN9Z3gMRTYt+6/
         UQsA==
X-Gm-Message-State: AOAM533+1ouOD9bBtKLMC7KQQDlDtpojP1s1R8yanvPRBZhM3S+p3is7
        Y8QWvsZX8E8/gdRlWHB0CDt3BL1Sqqz9Hg==
X-Google-Smtp-Source: ABdhPJxojb1UnbYTHfFSYLhlYMajrgTFSrmdVtZDrTJxSglMTsDLUnyGzervKjnt+dFoQenmgH6KOw==
X-Received: by 2002:a9d:694a:: with SMTP id p10mr26523955oto.149.1609467418046;
        Thu, 31 Dec 2020 18:16:58 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id p71sm10363850oic.34.2020.12.31.18.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 18:16:57 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 21/47] completion: simplify equal suffix check
Date:   Thu, 31 Dec 2020 20:15:56 -0600
Message-Id: <20210101021622.798041-22-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210101021622.798041-1-felipe.contreras@gmail.com>
References: <20210101021622.798041-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We know the prefix is already '--no-', there's no need to check for the
first '--'.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 contrib/completion/git-completion.zsh  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index ff5d29bf36..0522750b9f 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -335,7 +335,7 @@ __gitcomp ()
 			c="$c${4-}"
 			if [[ $c == "$cur_"* ]]; then
 				case $c in
-				--*=|*.) ;;
+				*=|*.) ;;
 				*) c="$c " ;;
 				esac
 				COMPREPLY[i++]="${2-}$c"
diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 090c644b71..8db7d0693d 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -67,7 +67,7 @@ __gitcomp ()
 			fi
 			c="$c${4-}"
 			case $c in
-			--*=|*.) ;;
+			*=|*.) ;;
 			*) c="$c " ;;
 			esac
 			array+=("$c")
-- 
2.30.0

