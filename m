Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D45ECAAA1
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 09:33:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbiH3JdB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 05:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231867AbiH3Jcb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 05:32:31 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7E9DF661
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:32:16 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-11e7e0a63e2so14519113fac.4
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=jJzKaJIKYSSPAQm/JyDvzt6kwDenfCV005u8TajJqZo=;
        b=pmPTn3IR0halDVEBp3YaSq9HIM7xc2zg26QrvUy4Zmj76OuVHtzOgtur5U5NXDwfjQ
         hoTcqmHDsJNjL890boH5gWNmcPyL9NA1yQJ3PwIGZtZqINaopRwzcFW7VkMRGhlsHCX6
         57XdaBOTExCk/xb0Ttz9mPgeyw2h7zScfgTPt8Wz2O3NYQecLmuFTZBD6iVrkV6PpMLD
         53MGmNoq9oa6YKQn645awEA/8QgmMo++VEvou24L+lSB+igpUD9v1LaCqz+W0mrGVodw
         3PTSTPtg5HrZZVRvj7L7CHEcZnB32f82EKtdRw1t3xbwQ2XnNlvfo+IthyzBo0dAC4pe
         Q66g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=jJzKaJIKYSSPAQm/JyDvzt6kwDenfCV005u8TajJqZo=;
        b=6BL+cc92dXvDeJYyqTFyIrpTEPH/VF7APJHZijvtjyLrq0BRzECrXC3wXYkLnvR/Km
         XO+JVoCZ1We2gFSPKo9Gvj3O20YXvFH0Yk4D+sHtJ186drtT8IC5jP8/j4qYfWyssM3s
         qEpJGyPKXho2TAH1Jn5cSdPEqLAAv6EZPQje3ZlR8cR7qezyL1sD9nEhd2U3NFVJ5o8E
         rF1pxK0y17OdrLNWN08XHpvH13O5HnVjIWWNEDT7Be2INgsaLk6GaS8MWZ7LROtzozyy
         OnjryWw2qSyyZ/iX7Oce4yEAokUYAd2DBBwMcoQztELkOydR3UgkSzdXSg4re1pmcY45
         2oTQ==
X-Gm-Message-State: ACgBeo1bt/jaY4v9BZ+dWK3R56H9/vu0ugZZi/tr9OcLpx8XhDkxrIc3
        BDFAOx2O6ooXKrqCKjaVE7aNYxouAL0=
X-Google-Smtp-Source: AA6agR7nuRh6butW/S2Pkz1jgFpGu3Wv4fX54255cg8Bfd10FDJRlY48uXnQoM+MmdYV7BpBIL84xQ==
X-Received: by 2002:a05:6870:e408:b0:11c:37ad:773a with SMTP id n8-20020a056870e40800b0011c37ad773amr9957265oag.44.1661851935812;
        Tue, 30 Aug 2022 02:32:15 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:eec:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id k4-20020a056870958400b000fb2aa6eef2sm7485966oao.32.2022.08.30.02.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 02:32:14 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     git-fc@googlegroups.com,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 21/51] completion: zsh: add support for general -C opts
Date:   Tue, 30 Aug 2022 04:31:08 -0500
Message-Id: <20220830093138.1581538-22-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.37.2.351.g9bf691b78c.dirty
In-Reply-To: <20220830093138.1581538-1-felipe.contreras@gmail.com>
References: <20220830093138.1581538-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 6 ++++++
 t/t9904-zsh-completion.sh             | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 0e72b9add7..e771a2a53a 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -211,6 +211,7 @@ __git_zsh_main ()
 {
 	local curcontext="$curcontext" state state_descr line
 	typeset -A opt_args
+	local -a __git_C_args
 
 	_arguments -C \
 		'(-p --paginate --no-pager)'{-p,--paginate}'[pipe all output into ''less'']' \
@@ -226,6 +227,7 @@ __git_zsh_main ()
 		'--namespace=[set the git namespace]:' \
 		'--no-replace-objects[do not use replacement refs to replace git objects]' \
 		'(- :)--help[prints the synopsis and a list of the most commonly used commands]: :->arg' \
+		'*-C[run as if git was started in the given path]: :_directories' \
 		'(-): :->command' \
 		'(-)*:: :->arg' && return
 
@@ -248,6 +250,10 @@ __git_zsh_main ()
 			__git_dir=${~opt_args[--git-dir]}
 		fi
 
+		for x in ${(s.:.)opt_args[-C]}; do
+			__git_C_args+=('-C' ${~x})
+		done
+
 		(( $+opt_args[--help] )) && command='help'
 
 		words=( git ${words[@]} )
diff --git a/t/t9904-zsh-completion.sh b/t/t9904-zsh-completion.sh
index dbd0671ab6..cd223b6e2a 100755
--- a/t/t9904-zsh-completion.sh
+++ b/t/t9904-zsh-completion.sh
@@ -844,7 +844,7 @@ test_expect_success 'checkout completes ref names' '
 	EOF
 '
 
-test_expect_failure 'git -C <path> checkout uses the right repo' '
+test_expect_success 'git -C <path> checkout uses the right repo' '
 	test_completion "git -C subdir -C subsubdir -C .. -C ../otherrepo checkout b" <<-\EOF
 	branch-in-other Z
 	EOF
-- 
2.37.2.351.g9bf691b78c.dirty

