Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E28E8C6FD1D
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 08:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjDAIsI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 04:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjDAIrU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 04:47:20 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1342221A
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 01:46:58 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id f19-20020a9d5f13000000b00693ce5a2f3eso13139694oti.8
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 01:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680338817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5kVFZsditD9fGYuV6a0EUyPpDwMhqyDg7ZIpT2I+SDs=;
        b=AjR/i7MxMW1smgwruE/PZLIBxSjlr0c7hj9cbYjmB8anTKlr8oiBYGTDpmZdV3wpRe
         YLmDLCP0K5rixz+OmeJLWhZ+2HQGj+OQ9oGU2r/Lexew4DaahEngLVajHWfGWCyVyqhp
         kADqBF3W+AM1/FXjHkODiyqBYeVzxRlLVViqi9QDLgl92V9sGcoRC8k5FF2B7yA0mtFL
         CIa6yy0vAYS2BoaLCKVHe6IE0VU623LiZ2STXrCLn47nw9WHqGZe5k/E8/V884xF9Ssd
         hkC15oetY4/wTk8fQndnHCJS2wVoe2g89to8SFaba2caMkCMJQP919harMZhBGZb0q1n
         SnHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680338817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5kVFZsditD9fGYuV6a0EUyPpDwMhqyDg7ZIpT2I+SDs=;
        b=GNQpqpPYCRmv8sCegbSbOG4b7CymVa/gwCTCDxkLS4jGTGZbgtSzVMyGnfIseIDy8/
         dbzc+0AmjZrZj++scLi87mOWIw9izp+JQTpZWOmCe5hrB6T2Zo/RlNd6j/WBLUzW1t7Y
         Tc7wdGFnir3LYOud/aKBGdKdOYWof7jXCPP75sde8wtaWRahb3lEv+9qX8WVc6stshdl
         y0WtTrSO77kmLpSda0RaFS/FiRb0VmQoH9O2ThoEuya7odkArtTuHGN1lJrKyK1OUDWA
         xYdc0YYF97yerOzgGqk/JiOsrgrXT9tGto2TnowkJLaJMAxDHCD1VWt1QvO432Y3jyHp
         5p7Q==
X-Gm-Message-State: AO0yUKVAvKukXCxGmjmVjftTzTxVJdU+6upVpuaJbQGAiRz31VV3cod+
        btLfksvqQ0XJ1EmnTcDwuslwLoq93iU=
X-Google-Smtp-Source: AK7set/jGQLuyj7xDk5RLzblIRMtgpPJSC1CjSwcbYR5lYQCiZRPGBUHNMbtit8HYYCAMycIpehYxA==
X-Received: by 2002:a05:6830:168c:b0:69f:7b9b:473e with SMTP id k12-20020a056830168c00b0069f7b9b473emr14749566otr.38.1680338817098;
        Sat, 01 Apr 2023 01:46:57 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id b22-20020a9d7556000000b006a305c68617sm733220otl.53.2023.04.01.01.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 01:46:56 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v7 21/49] completion: zsh: add support for general -C opts
Date:   Sat,  1 Apr 2023 02:45:58 -0600
Message-Id: <20230401084626.304356-22-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230401084626.304356-1-felipe.contreras@gmail.com>
References: <20230401084626.304356-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 6 ++++++
 t/t9904-completion-zsh.sh             | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index b49bce51ac..9e821eab9a 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -206,6 +206,7 @@ __git_zsh_main ()
 {
 	local curcontext="$curcontext" state state_descr line
 	typeset -A opt_args
+	local -a __git_C_args
 
 	_arguments -C \
 		'(-p --paginate --no-pager)'{-p,--paginate}'[pipe all output into ''less'']' \
@@ -221,6 +222,7 @@ __git_zsh_main ()
 		'--namespace=[set the git namespace]:' \
 		'--no-replace-objects[do not use replacement refs to replace git objects]' \
 		'(- :)--help[prints the synopsis and a list of the most commonly used commands]: :->arg' \
+		'*-C[run as if git was started in the given path]: :_directories' \
 		'(-): :->command' \
 		'(-)*:: :->arg' && return
 
@@ -243,6 +245,10 @@ __git_zsh_main ()
 			__git_dir=${~opt_args[--git-dir]}
 		fi
 
+		for x in ${(s.:.)opt_args[-C]}; do
+			__git_C_args+=('-C' ${~x})
+		done
+
 		(( $+opt_args[--help] )) && command='help'
 
 		words=( git ${words[@]} )
diff --git a/t/t9904-completion-zsh.sh b/t/t9904-completion-zsh.sh
index ee8cbe3320..27f5b42318 100755
--- a/t/t9904-completion-zsh.sh
+++ b/t/t9904-completion-zsh.sh
@@ -863,7 +863,7 @@ test_expect_success 'checkout completes ref names' '
 	EOF
 '
 
-test_expect_failure 'git -C <path> checkout uses the right repo' '
+test_expect_success 'git -C <path> checkout uses the right repo' '
 	test_completion "git -C subdir -C subsubdir -C .. -C ../otherrepo checkout b" <<-\EOF
 	branch-in-other Z
 	EOF
-- 
2.33.0

