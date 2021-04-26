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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E19A7C433ED
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 16:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC17961131
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 16:17:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234170AbhDZQSU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 12:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234124AbhDZQSU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 12:18:20 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C256CC061574
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 09:17:38 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id n184so30938008oia.12
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 09:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V6UfQxIxsalvtrGNwglxAOOmRAOF5u8G5oVXrT36s9M=;
        b=AQ8dt8ScFCEriPH7meTNbebMn4N52SNstqNr7BfoWDlAeSXLyk6uu5dcfIokkdKkOP
         ZIPnsmiD1BeSLrQUaUZQalkuDZT5raLHxkSixNNd5Ol5ALlDEWV5Mf3XsyZLsO9Pk71o
         kWEIj2RcXd3zApCAPHM2tZHzFdG+iB6gsERhXSu2lWnVCLBsmSFgd7+GWZeaNRcL0pii
         JXzDLKzs/2GeWniJdm5Sgr9zHxaSa/YIx/FbqRSWepeTQ9/5ygJv+sb/4nCgJhVFLm1g
         lydjPIJ3Tfprv28PrS27j1KKhi3wy3gCnHBkVm0qX8pgp+OeH2tXbI8QzuFoaGVUdh4p
         LEDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V6UfQxIxsalvtrGNwglxAOOmRAOF5u8G5oVXrT36s9M=;
        b=iA55wWPUpS7gvArW7ve1ApP3fQWibMKfr6uCxNCcez1L04EnZUEd0TSpPtU74DzPeK
         S+XbWmTIHclB6Xz/iyr2JNI4T0Y0Lkzl5JAyTHNdtajCANY/I8B3h/yLyDfJOg8LmMH3
         7VROmsEw9GG1/IYTHjWipQFaWPFBXzIq/7zzTM0fNCC+/jxv09+PLjg0Tgat3NFCOcw3
         SbpdVjloUasCO9vcVgtGUNkMVoayyeQ25x28xmobRSXMyRZBlCexkGNLYmiSlq9LaMZU
         T5q/uYJkMc7LvEY5FficyMS7gY5pGWYfEaMZJnMNxBn1gLkoPkmzl+a6DrpCoi8UVHP3
         EnFA==
X-Gm-Message-State: AOAM532Fr2qql1tIvaaCYlX/R12mfiQl/XPAB3X5USeyWlYnI4D85+gV
        USM0ZKKqRKe/qqSEppTchd0EzFvnDbp8/Q==
X-Google-Smtp-Source: ABdhPJw9jyHkI/SZpCLiEgaGQGig/Z3qZX/eNQswZtBuGUprxF6vGfU0CeR4ZHp0/AaFqNz/ktt72A==
X-Received: by 2002:aca:6088:: with SMTP id u130mr4709467oib.51.1619453858001;
        Mon, 26 Apr 2021 09:17:38 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id p64sm3123971oib.57.2021.04.26.09.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 09:17:37 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v1 19/43] completion: zsh: always set compset
Date:   Mon, 26 Apr 2021 11:14:34 -0500
Message-Id: <20210426161458.49860-20-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210426161458.49860-1-felipe.contreras@gmail.com>
References: <20210426161458.49860-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So we don't have to set it every time.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 7cb0f33209..d754086877 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -72,7 +72,6 @@ __gitcomp ()
 			esac
 			array+=("$c")
 		done
-		compset -P '*[=:]'
 		compadd -Q -S '' -p "${2-}" -a -- array && _ret=0
 		;;
 	*)
@@ -91,7 +90,6 @@ __gitcomp ()
 			esac
 			array+=("$c")
 		done
-		compset -P '*[=:]'
 		compadd -Q -S '' -p "${2-}" -a -- array && _ret=0
 		;;
 	esac
@@ -101,7 +99,6 @@ __gitcomp_direct ()
 {
 	emulate -L zsh
 
-	compset -P '*[=:]'
 	compadd -Q -S '' -- ${(f)1} && _ret=0
 }
 
@@ -109,7 +106,6 @@ __gitcomp_nl ()
 {
 	emulate -L zsh
 
-	compset -P '*[=:]'
 	compadd -Q -S "${4- }" -p "${2-}" -- ${(f)1} && _ret=0
 }
 
@@ -117,7 +113,6 @@ __gitcomp_file ()
 {
 	emulate -L zsh
 
-	compset -P '*[=:]'
 	compadd -f -p "${2-}" -- ${(f)1} && _ret=0
 }
 
@@ -135,6 +130,8 @@ __git_complete_command ()
 {
 	emulate -L zsh
 
+	compset -P '*[=:]'
+
 	local command="$1"
 	local completion_func="_git_${command//-/_}"
 	if (( $+functions[$completion_func] )); then
-- 
2.31.0

