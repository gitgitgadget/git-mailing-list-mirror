Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00899C6FD1D
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 08:47:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjDAIrD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 04:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjDAIqx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 04:46:53 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F2B1D84C
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 01:46:41 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id d22-20020a9d5e16000000b0069b5252ced7so13128567oti.13
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 01:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680338801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SxY7AUnec4vLmKyh9PxgXeVlLFHg75UqJ5jiZs9xvc8=;
        b=jyU2iArcXs/sZ92X3mlQ8HQq4No9eKdwfuXFkvfmpxbELwlukqZJyLGLWFRD60JBIU
         acctGG1sEyHmTRV7PeBGv3H4Sv5eK8vjAsRzqrBRCZCHnh/C5pFUuin6QyqTU3VYzyNg
         gzo+W3ATzvu41xt4W76G554PiLGLOH3A79tj0z68CItwv1aL58e+bLeN8CIRcUTSCfWT
         fik3LfNe7C/TgPyyc0s2JNXku46yUT3s+kNZsp/RiXHqs1wd7sSWQAfnAgR+wg3CeUyP
         l6303vXsDwmsnsRU7KA/yBSA5tMWJh5K4dxJwZMvkKi7lC0r664uSFCjNyyLsEBg/q6Z
         +FgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680338801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SxY7AUnec4vLmKyh9PxgXeVlLFHg75UqJ5jiZs9xvc8=;
        b=yAVtDVqNOlqiT0GleG+Tl1DGpkz/QsEUIAJ2fawfj4UTe1YuyHFU5CStcYGXdC0KMX
         ofzkQlr1qymLHDMrmI43I1iVwbsEGwK7IW3sHa3JN+QjDV3HAwiwR6pdW5V3Xveskzmc
         km0kzLE0NTJT2abZ5GcEnHnIpIx6FeqIFoA5Tt837FO1YMGeyWXirwqmwPS3ut2nsTJV
         0J7ZTSJeSY7KfOqvTOWQX/eiKDplBopVbWU1M+Iki2oW2uewtdZrXO3yX2SG3NP3m8zE
         3giFnX6sNZu4ZA3uF6SQXQJn3QfDRrZSRq6HiHdWzQ1X4AnY5wqjl656h4L3vg9zTQGt
         S3tA==
X-Gm-Message-State: AAQBX9fN4mdd3+HltKICS8SA2/MW5g12zZ87INzEHhJJl+ADn9lKq6gt
        Gzgi30S+UOgpb5PHs51VQgpbr0ipdV4=
X-Google-Smtp-Source: AKy350YGA4M4bYr/PxnKWYXqaTvXv8aR6D5OwFYhrv4h3sfcjMK8qXe4QWmjqmEvY9S0DiIUW067wQ==
X-Received: by 2002:a9d:6395:0:b0:6a1:7f69:ffb2 with SMTP id w21-20020a9d6395000000b006a17f69ffb2mr3488683otk.38.1680338800781;
        Sat, 01 Apr 2023 01:46:40 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id z1-20020a9d7a41000000b006a144b97e73sm2043860otm.74.2023.04.01.01.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 01:46:40 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Harrison McCullough <mccullough.harrison@gmail.com>
Subject: [PATCH v7 09/49] completion: fix __git_cmd_idx regression for zsh
Date:   Sat,  1 Apr 2023 02:45:46 -0600
Message-Id: <20230401084626.304356-10-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230401084626.304356-1-felipe.contreras@gmail.com>
References: <20230401084626.304356-1-felipe.contreras@gmail.com>
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
 t/t9904-completion-zsh.sh             | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 4f22e8f85b..d11f4765b6 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -267,7 +267,7 @@ __git_zsh_main ()
 _git ()
 {
 	local _ret=1
-	local cur cword prev
+	local cur cword prev __git_cmd_idx=0
 
 	cur=${words[CURRENT]}
 	prev=${words[CURRENT-1]}
diff --git a/t/t9904-completion-zsh.sh b/t/t9904-completion-zsh.sh
index cb123261ab..b7e4029bf9 100755
--- a/t/t9904-completion-zsh.sh
+++ b/t/t9904-completion-zsh.sh
@@ -1140,4 +1140,10 @@ test_expect_failure 'options with value' '
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
2.33.0

