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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4CE6C48BE8
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 18:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFB18611AC
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 18:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236332AbhFRS2U (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 14:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236337AbhFRS2P (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 14:28:15 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F104AC0617AE
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 11:26:04 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id c13so11462925oib.13
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 11:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2s21LxaNeZcA4LBi9OL+tF8uuoc0Xw8+P8No5sCsc9Y=;
        b=P7UbiaOVlg+jJKKKE+XvtLM8odSj6JaEajBoM1/Cxbs7vyWdgsEQfuISZkOZKqwbjC
         Wn9BW2Yxz87ABXFBYjipEPArImXATnEphOgbmOtOl70lyBcRw77FoU1e4gtDio5R48h0
         xrLVy/kqPwKFsEjjXSGf8hq79/EBusl4pUUqkKTo3QLa70K0r91oXJJvePtD1QWQKEAj
         w78Y84QE+rzRd2KH66CH7ANNkdAzPIlZculLl6LUWCWM4t3il0CG7LfJw2j1MZisIyhi
         bEpYLkJiEmLmFTsbCbOnsghMhVuHd7e++boLwvA2sOaIl1ZXECZo50WM7s91vApltuL+
         yAXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2s21LxaNeZcA4LBi9OL+tF8uuoc0Xw8+P8No5sCsc9Y=;
        b=XnatIFu2F44953bf5DJORMOPRnReNvtki++k+uiLoDx46Uesc7FD1sP8GI7AgkZ74Q
         6cIldBqTeI9mf4Xw9kAxNvNN/c7TCWLfjUW3NtEPf2S6286UZogwn6Z/hbsJev6DCu74
         6DRSkscsFmUTK5c7Y4SJCo6pKewuDwxfXnZW57vNdXDlwVUSEjM5MA0TK0fH3njfaIpN
         mII2ESR4f08JkUjDpY57pKyvysAucUhC1kQduS1DI0IFeD1bd93J0jHyBx2w/3E/umBm
         H2BQCo5qLAmr3lresTpUOFfafoI2/uWaJ0t9XWkSZbac+9V/TCbjQmY7WGzdCeOYqjlh
         1ryA==
X-Gm-Message-State: AOAM530hCl5H7V8VSreYTthZxL4Zl4GAwETi2ZSI5aEZ6lpAyTJ8f6DH
        wm3yfj8Kul8HuBPzq59mIubyovAzKWRI3w==
X-Google-Smtp-Source: ABdhPJxJhPcxJqSoReJx4cwxmASjW9rU3qBoPDJb3z4G4gz53DliG+b9/ndlvqr34eAlDyhtzzqPHg==
X-Received: by 2002:aca:5dc6:: with SMTP id r189mr16004622oib.164.1624040764150;
        Fri, 18 Jun 2021 11:26:04 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id l18sm2128007otr.50.2021.06.18.11.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 11:26:03 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 22/45] completion: zsh: always set compset
Date:   Fri, 18 Jun 2021 13:24:55 -0500
Message-Id: <20210618182518.697912-23-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618182518.697912-1-felipe.contreras@gmail.com>
References: <20210618182518.697912-1-felipe.contreras@gmail.com>
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
index 426eec10a2..b9c2c75c79 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -73,7 +73,6 @@ __gitcomp ()
 			esac
 			array+=("$c")
 		done
-		compset -P '*[=:]'
 		compadd -Q -S '' -p "${2-}" -a -- array && _ret=0
 		;;
 	*)
@@ -92,7 +91,6 @@ __gitcomp ()
 			esac
 			array+=("$c")
 		done
-		compset -P '*[=:]'
 		compadd -Q -S '' -p "${2-}" -a -- array && _ret=0
 		;;
 	esac
@@ -102,7 +100,6 @@ __gitcomp_direct ()
 {
 	emulate -L zsh
 
-	compset -P '*[=:]'
 	compadd -Q -S '' -- ${(f)1} && _ret=0
 }
 
@@ -110,7 +107,6 @@ __gitcomp_nl ()
 {
 	emulate -L zsh
 
-	compset -P '*[=:]'
 	compadd -Q -S "${4- }" -p "${2-}" -- ${(f)1} && _ret=0
 }
 
@@ -118,7 +114,6 @@ __gitcomp_file ()
 {
 	emulate -L zsh
 
-	compset -P '*[=:]'
 	compadd -f -p "${2-}" -- ${(f)1} && _ret=0
 }
 
@@ -136,6 +131,8 @@ __git_complete_command ()
 {
 	emulate -L zsh
 
+	compset -P '*[=:]'
+
 	local command="$1"
 	local completion_func="_git_${command//-/_}"
 	if (( $+functions[$completion_func] )); then
-- 
2.32.0

