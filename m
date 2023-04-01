Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E80C77B60
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 08:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjDAIsJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 04:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjDAIrV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 04:47:21 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1664423B4B
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 01:46:58 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id y184so18416901oiy.8
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 01:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680338818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KNciQLgxXJHUBvXK16weR2Wzv1AKn+AF1Fb5rUXeHcM=;
        b=Id2Wfts59zFPRSqMA0pMESOcpHXkxkQoYyaJ9uER/xVJ40Ue+Vcg3uSQ8cmEs5Z/Tn
         3Jfn5ZIwB3nG4Zf1hMi7JUbGw2StwA1ohJsJHqRX+edt1kvvyDy1FPqlyMoqqi96YXzK
         8oGuuG462rdLHC7lpBSc5JV+v4Ev6FNd2apatoYTCe+ioaVmDXx97fJVMZEC1ez7acNv
         x/NTDWWnDLephlo18SX/K+jk7uF6Ui5lml0hBoE/KqLVYQKV5BTX71KSNxY4z5e7A/KH
         C/RwuJxwk4D2u1dz0Z3HrXAFhfLWk+HZKXKb5OkiyDFbDKNkB6VHvrvHc0wWtOwroEoU
         COaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680338818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KNciQLgxXJHUBvXK16weR2Wzv1AKn+AF1Fb5rUXeHcM=;
        b=nf14hGHSMbKhRNB7UVn8Pte1RuCYvn3zzyb/+sv4EGtTHkakGbkMCOD2L/hw7a3Dsb
         glXLn7XHveZVVTvoObgN98jWsY3iemaj0nl7nn+V2xUG14vEHhWzzrPtlsj+1ai8fbo0
         C83BoNK3CKm4r649mSjM6hfriOYI4lndyt0MgWkJN/o4zLb+vHwWy1eUTDEweQ2C5nx1
         8r6iGXTzOceLFJ3wtH0H2vxEawQlj+g+KE030b25X3pKJpyKZQhIHNCt5GszGGQHGBDz
         WyFwiViIx5WTIA2cH4fzEezSj4LSDkoPNO/PFR9afSi8M5TVQhfB48OD/fH0epnbz5BB
         yVoA==
X-Gm-Message-State: AAQBX9cI5hRozhsexnf5UIv/x5x99lVnxGq9igIbkQf1iCOmVJeXBmlW
        OGBiCHWu6jODd8SLV2llGPIqwsSzwNI=
X-Google-Smtp-Source: AKy350aQHPtL4B4mb+xd9GOzI0i+JqSiOVH3kZKqtGdmYlhHHLmgm5YCwxWTSMmi03tgK/9fBKF7Qg==
X-Received: by 2002:a05:6808:f8d:b0:389:50f2:4ac0 with SMTP id o13-20020a0568080f8d00b0038950f24ac0mr9313885oiw.33.1680338818359;
        Sat, 01 Apr 2023 01:46:58 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id s189-20020acadbc6000000b003874e6dfeefsm1860897oig.37.2023.04.01.01.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 01:46:57 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v7 22/49] completion: zsh: fix for undefined completions
Date:   Sat,  1 Apr 2023 02:45:59 -0600
Message-Id: <20230401084626.304356-23-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230401084626.304356-1-felipe.contreras@gmail.com>
References: <20230401084626.304356-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The parseopt helper can generate the completions even if the function is
unspecified.

  git version --<tab>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 3 +++
 t/t9904-completion-zsh.sh             | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 9e821eab9a..88157b0867 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -136,6 +136,9 @@ __git_complete_command ()
 	if (( $+functions[$completion_func] )); then
 		emulate ksh -c $completion_func
 		return 0
+	elif emulate ksh -c "__git_support_parseopt_helper $command"; then
+		emulate ksh -c "__git_complete_common $command"
+		return 0
 	else
 		return 1
 	fi
diff --git a/t/t9904-completion-zsh.sh b/t/t9904-completion-zsh.sh
index 27f5b42318..472b02d3e6 100755
--- a/t/t9904-completion-zsh.sh
+++ b/t/t9904-completion-zsh.sh
@@ -1034,7 +1034,7 @@ test_expect_success 'completion used <cmd> completion for alias: !f() { : git <c
 	EOF
 '
 
-test_expect_failure 'completion without explicit _git_xxx function' '
+test_expect_success 'completion without explicit _git_xxx function' '
 	test_completion "git version --" <<-\EOF
 	--build-options Z
 	--no-build-options Z
-- 
2.33.0

