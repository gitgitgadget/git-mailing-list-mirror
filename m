Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A0CEECAAA1
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 09:31:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbiH3Jby (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 05:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbiH3Jbr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 05:31:47 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 563269D8E2
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:31:46 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id u3-20020a4ab5c3000000b0044b125e5d9eso1871620ooo.12
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=6/cizRKdLoQzx+cPHSd+Ub9D1a/k7U0p+UD2tp3Hs+4=;
        b=c7SrbYGw/Gf9fSIFaa2w7E7Klee35IAgGD3bbfnatgqvphYyisQ6kRPbaIBaYGogTq
         3iXMrL4fE8R51DtvgvNf2JlZTigf7Pn16ghgim0AtU/T1pcWhpM0NiEZtVZim0ocRk7G
         0MyqzD0eDuBuF1OhWCz8fn4GfMooVti01gXba2zHjiqdZUeolEpu+nszCecsxPa/UKF1
         sboO38OkDg0cn3bhOTmQPWGqpC2PE+huiqXJjWcDd+C8btZTPCQKOtDaqyv2UdhNxEoj
         9V9hHBDt0jdsCr0vYs5JoHkmrOJXsotN9QARZyAW6XkuIdFHA/5s9rzZ8xCp4iejmwXF
         EBCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=6/cizRKdLoQzx+cPHSd+Ub9D1a/k7U0p+UD2tp3Hs+4=;
        b=mM5wiKLH64hSadSq6XDO5zTlqZuOR0e3umjXXWXa3gu3p80A2ovj4JiPUJ+f2cwP6q
         3SgiG9IfJq6ajBtzJBrHLZW0ktE1d25gtLwooPkqbqdEdTtoVwrFWZG8S4eT7+tPQyW1
         1ikORwP46h3IN15fbjQlwXD6NjoJyItev8xp/UK8LDvYWlDqoT3fxq9VouKMJe2OBNyt
         qnuTKRyPTfafRFN4muMygDJUj42hj1dKhJh5KybyLLlWVuaJ0RKzBE6OTIaTpEyEDQqJ
         4g2Ny6f83JB4jULAnxRB/v5L9Q1/GK+l6sFtlw0VEGfoUwWQWD3mg3VXgJksyQ86sbuk
         bBjA==
X-Gm-Message-State: ACgBeo27fmFbzBcLYKey0ovUDLy984NBoiD/0I6VB4pBvZt8TZTPM6HJ
        IesJufxrlptWn3H0g4xDwuH4Ylx55y0=
X-Google-Smtp-Source: AA6agR4Cx5zaT1P33r5SLkWW62Qx5NtAzlWbKdQmTvMfI25E4CypywOM001tQ5iCPD1RzOuRMkz0Xw==
X-Received: by 2002:a4a:e0d8:0:b0:44a:e39b:26d4 with SMTP id e24-20020a4ae0d8000000b0044ae39b26d4mr6932822oot.2.1661851905451;
        Tue, 30 Aug 2022 02:31:45 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:eec:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id s2-20020a4aeac2000000b0044884c40c8asm6385288ooh.30.2022.08.30.02.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 02:31:44 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     git-fc@googlegroups.com,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Harrison McCullough <mccullough.harrison@gmail.com>
Subject: [PATCH 03/51] completion: fix __git_cmd_idx regression for zsh
Date:   Tue, 30 Aug 2022 04:30:50 -0500
Message-Id: <20220830093138.1581538-4-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.37.2.351.g9bf691b78c.dirty
In-Reply-To: <20220830093138.1581538-1-felipe.contreras@gmail.com>
References: <20220830093138.1581538-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The commit 59d85a2a05 (git-completion.bash: use $__git_cmd_idx in more
places, 2021-04-22) caused a regression when using __git_complete and a
command relies on __git_cmd_idx. This was fixed in cea232194d
(completion: bash: fix late declaration of __git_cmd_idx, 2021-06-18)
but only for bash.

We need the function wrapper (__git_func_wrap in bash and _git in zsh)
to define __git_cmd_idx.

Otherwise the equivalent of __git_complete in zsh fails:

  compdef _git ga=git_add
  ga <tab>
  ga __git_find_on_cmdline:[:14: unknown condition: -lt

Reported-by: Harrison McCullough <mccullough.harrison@gmail.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 2 +-
 t/t9904-zsh-completion.sh             | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index cac6f61881..a1f2d27817 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -271,7 +271,7 @@ __git_zsh_main ()
 _git ()
 {
 	local _ret=1
-	local cur cword prev
+	local cur cword prev __git_cmd_idx=0
 
 	cur=${words[CURRENT]}
 	prev=${words[CURRENT-1]}
diff --git a/t/t9904-zsh-completion.sh b/t/t9904-zsh-completion.sh
index 5179b2dc76..656eaf77ab 100755
--- a/t/t9904-zsh-completion.sh
+++ b/t/t9904-zsh-completion.sh
@@ -1121,4 +1121,10 @@ test_expect_failure 'options with value' '
 	EOF
 '
 
+test_expect_success 'main sets correct __git_cmd_idx' '
+	echo modified > file1 &&
+	touch file3 &&
+	test_completion "compdef _git ga=git_add${LF}ga --update f" "file1"
+'
+
 test_done
-- 
2.37.2.351.g9bf691b78c.dirty

