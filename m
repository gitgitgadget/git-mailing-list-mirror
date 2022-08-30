Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A6AECAAA1
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 09:32:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbiH3Jcd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 05:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbiH3JcL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 05:32:11 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8747BDCFF6
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:32:00 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-11c4d7d4683so15349050fac.8
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=4OxhtLA9xQDrAoCmNJUr+WszS//iCHJ0tAQIH3pEuR4=;
        b=KUApCs8eG1OBTsX0reL6uXgBQpW7Dnla4Iz8au8TUxho1dw1Fy7q6GTcX3uureuHh2
         4mW74Uigw19UioHGHUhu6Ppej5PD2l+xMKJL5GqhX+IfOAdW5YNHhZxB1dNDJU+UGK+x
         EWcN8n1Cfd2bihwEfZsqSJuazwNf94kFNzALaprWnwdLiEagIIfsobJs6W04pRSWBPIo
         U6NYGDZwq931OBBhynon5Ng79teBrgaXD+t29kyrDC9QZb9e22dw6PVpi5KOQTz9L+++
         Gx6roXtlsvb2VNvReJEVqUIC8vFYxebilYF8me7/Bd4j3CfRVamU1UXtCpvQ2R/9uTc1
         QrAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=4OxhtLA9xQDrAoCmNJUr+WszS//iCHJ0tAQIH3pEuR4=;
        b=2SUYvqXpb7pC6OacTi5HGQWIBOdF08bLpXxN7b/232LzMKptOCXTrxADFyHWBEQxKr
         YG6CokqaCY+mbX5I3NAmuDsixXkTI0zAdNG1kWH6jMgzWmO2nZsnwg7YS3086TpNbhmx
         Rwq216Kkv8eYW4BcNC2S7KcJgwpHr6FJ6B11S7x69WEb5QbADxmpkFUstCIKru0d6Zsb
         gH5umN+Fq7BwIGm7XDV6MTHQK32eEtRtAz6awv1LMpm3Ess42KoUI6thMCytf07f7ezg
         iOKAoOjcE/wCj3w7vJoM2Ynvj/j3yB0KzdLdBgi6bOw+eGzCNWNOLtc0A9gbEZy2oJg5
         QeHw==
X-Gm-Message-State: ACgBeo0+FjkV+pFNcbNxl3D8OpU3tKMMsQKNkLQ35i2zYx0WA0jzzugy
        EZzpqOJiO3rn4FeMKd2jWjLGSvaCaFg=
X-Google-Smtp-Source: AA6agR6R4lVvD+VWQFlP3C+dmAvUiwOrGd52n/NJMsAD2C5ydsEYP6HKMVVCERTC9Mp+0xuhf2GPkw==
X-Received: by 2002:a05:6870:b61e:b0:11c:d598:e612 with SMTP id cm30-20020a056870b61e00b0011cd598e612mr10089589oab.261.1661851919928;
        Tue, 30 Aug 2022 02:31:59 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:eec:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id f23-20020a4ad817000000b004359da266b4sm6412748oov.14.2022.08.30.02.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 02:31:59 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     git-fc@googlegroups.com,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 12/51] completion: bash: do not modify COMP_WORDBREAKS
Date:   Tue, 30 Aug 2022 04:30:59 -0500
Message-Id: <20220830093138.1581538-13-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.37.2.351.g9bf691b78c.dirty
In-Reply-To: <20220830093138.1581538-1-felipe.contreras@gmail.com>
References: <20220830093138.1581538-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There was no need for this once __git_reassemble_comp_words_by_ref() was
introduced. Now irrespective of the value of COMP_WORDBREAKS, words are
always joined together.

By default COMP_WORDBREAKS does contain a colon, and if it doesn't
somebody probably has a reason for it.

Completions are not supposed to modify COMP_WORDBREAKS and none of the
completions in the bash-completion project do.

We manually set it in Zsh so the Bash script is not confused.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 5 -----
 contrib/completion/git-completion.zsh  | 1 +
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 2df51ed946..ef0b7aa192 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -59,11 +59,6 @@
 #     When set to "1" suggest all options, including options which are
 #     typically hidden (e.g. '--allow-empty' for 'git commit').
 
-case "$COMP_WORDBREAKS" in
-*:*) : great ;;
-*)   COMP_WORDBREAKS="$COMP_WORDBREAKS:"
-esac
-
 # Discovers the path to the git repository taking any '--git-dir=<path>' and
 # '-C <path>' options into account and stores it in the $__git_repo_path
 # variable.
diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 4d81ca73b5..2de1a72c09 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -46,6 +46,7 @@ fi
 
 local old_complete="$functions[complete]"
 functions[complete]=:
+COMP_WORDBREAKS=':'
 GIT_SOURCING_ZSH_COMPLETION=y . "$script"
 functions[complete]="$old_complete"
 
-- 
2.37.2.351.g9bf691b78c.dirty

