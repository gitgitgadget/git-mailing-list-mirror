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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F86C43603
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8807207A3
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:17:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbhAACRV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Dec 2020 21:17:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727173AbhAACRV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Dec 2020 21:17:21 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2145C0617A9
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:16:55 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id i6so19329445otr.2
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=94Zg6NH1PX9m26k7LzbarTZ58LdqXZUoxJ8JnT9saZY=;
        b=MQ0s1S7vo10AjeRWnKK4BiLuWi6f2DVFuiFr4kXMyCYUr+3zD6qkFtBxgNMIGlcMvR
         MqgLmRPVrj0qC6IfUHbvKVi58+DDQWn6yZTyflssAB4DMMftdRlAFJ8NuMRCNr72mvdg
         A5fPb5ETAKNX/Hu6ts4E4345ECWKh7B0Kvbm1kdXaPQ3jZ+ldr1HleibKyNEFBjlL8S0
         I6+E7XKJacFQdMR7Lvz3CdFgZYpGqjyt8StnOfKiE0YPUmru1XJ9/ve4elSlD4G3+9oE
         /atAW1YwsSG5ZAc4tz+K+/TQ+gk9wDkalfwWWN/F4nbfW2Q3I/3/kdIEO+Yuc1Ppxdka
         /4bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=94Zg6NH1PX9m26k7LzbarTZ58LdqXZUoxJ8JnT9saZY=;
        b=kPhw0Q63AHwUCBhKpPH2D160XJCErDLXEM6zV1Q3Drzj4o59YB7Qdlb7EnNM34ch/I
         RhELlcpP3LBYStqaTZETdih/fS3vTu63LiNsYI7J4jRX1hmwnYzUELwnSzdIWuMVBaHP
         KlEEV1bPHR5XmJWkf1wfSEzdQZf/GY4oaKYx/svXdApi3MxZi0zjzJGSimSRdM08tE00
         O/aAfu/1Jogqb0X8xsuR+CUQoXmZpg+VDwvnpUChMWtyO6AdomtXiUvIy34U99PnaImn
         dWDxBDV4Xny9OQUyKJcJRGgCp0/Ax6SzC7Qf0nE8YhovuD0HZUJ8yQgIfbaxqN5KwSrf
         Zk5Q==
X-Gm-Message-State: AOAM532S7e/aAyHNR9Fr1yVpqfG1nfy06Uc7wwBT1c6+FlT1p3EvGxSz
        uphM43jPhcTlEbDCFaIK+4ZQY0Sua0txYg==
X-Google-Smtp-Source: ABdhPJwvAqvsglSopSX/FBMoTrrfnMBIsSc1NMkih5KQQI+FlK/tduWLLk1kMg4DueGyU6ho1ysDDw==
X-Received: by 2002:a05:6830:1551:: with SMTP id l17mr44902006otp.309.1609467415169;
        Thu, 31 Dec 2020 18:16:55 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id u3sm11543541otk.31.2020.12.31.18.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 18:16:54 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 19/47] completion: zsh: always set compset
Date:   Thu, 31 Dec 2020 20:15:54 -0600
Message-Id: <20210101021622.798041-20-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210101021622.798041-1-felipe.contreras@gmail.com>
References: <20210101021622.798041-1-felipe.contreras@gmail.com>
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
2.30.0

