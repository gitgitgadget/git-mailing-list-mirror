Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6FFCECAAA1
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 09:33:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbiH3JdR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 05:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbiH3Jcc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 05:32:32 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA6FE01D2
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:32:20 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-11eb44f520dso11114888fac.10
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=16p2c6L0W5J0LiTr+3BZfTV9XPOHs57NzZeTdEr51cg=;
        b=EwhHfHLjFTFM/WkB5Rhn/IKGMmcAs5dkScKKv67gFTkfY/2M8ugUB0lRhaMpZuHFCs
         LivtsW6hcA0fAzry2vu+Re71frAxRZUx0WNL3Slt/DPxspmd7XebGo27o1S6bNJAaEAv
         rhAjUrv4XE70OSKHgumMEmpUcSfM+b9tUTowFPVMEzw5h/2ZjL6JocfOTuwKkSG01fgo
         KwGm3KNTUo+cIkl8FPJvQD96Kr4RD3pHCT9FT8X4T6fKxLGJ/D68ifMAWE/uWXoaq0/e
         MQzJ7j3SOsyVDuCN8OY2aBp1J691pDcL4B3cPkQjsadmZvBK2EAAp1pHaQ38gexlwGA3
         VjfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=16p2c6L0W5J0LiTr+3BZfTV9XPOHs57NzZeTdEr51cg=;
        b=y6v1EvjjRzyUO5NV8cMRdow3pDJxCmE9lqyEPH3T0DTr18J4acx/qJx8gGMsfE4TqM
         EAmheVz68kL5Ov4Pyolnc7LXSGZ8/T8gVzm2/bRNgv6HDePVq26JXrxQKOON1SxBiXuF
         PPRjzk2LnJrL8y5Bi97QK6mvrjntwVBpVv6OXw5R3bb83JpHg9S8rEKGLi2sBUaps+B/
         2fpKDliy5kz9xLtLpPjKgBeu5iK+rCfcT1PBaB018+FiTBb3+1qHtcFkaZWtLTMlXSAS
         ZXfAHiY224z7QO4cdSbjxBUZMjiK03duNhGdORm146y9lK2fM9E6nqIwcpbhOS42PFwT
         pBeg==
X-Gm-Message-State: ACgBeo2F/kxdJRDrhzgoOwA9wFFuHt0paYvjwT3OUUqtJv00z7Ey2JS6
        pbjJJ/iKntzAGjOuretzOPnJu7WS/cY=
X-Google-Smtp-Source: AA6agR5YQg5VkiMwyO9WKw8Y/iwvlpZp8iQbAeD0Zv+RiTgaJ/pmGpyOCkcpfOtYgt3N2RNSjqp6xA==
X-Received: by 2002:a05:6870:6087:b0:10b:aef4:db0a with SMTP id t7-20020a056870608700b0010baef4db0amr9468606oae.17.1661851939834;
        Tue, 30 Aug 2022 02:32:19 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:eec:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id t28-20020a056870f21c00b000f5e89a9c60sm7519464oao.3.2022.08.30.02.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 02:32:19 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     git-fc@googlegroups.com,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 23/51] completion: zsh: add support for general -c opts
Date:   Tue, 30 Aug 2022 04:31:10 -0500
Message-Id: <20220830093138.1581538-24-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.37.2.351.g9bf691b78c.dirty
In-Reply-To: <20220830093138.1581538-1-felipe.contreras@gmail.com>
References: <20220830093138.1581538-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So we can specify configurations.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 5 +++++
 t/t9904-zsh-completion.sh             | 4 ++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 30607aa93d..b062090a13 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -231,6 +231,7 @@ __git_zsh_main ()
 		'--no-replace-objects[do not use replacement refs to replace git objects]' \
 		'(- :)--help[prints the synopsis and a list of the most commonly used commands]: :->arg' \
 		'*-C[run as if git was started in the given path]: :_directories' \
+		'*-c[pass a configuration parameter to the command]: :->config' \
 		'(-): :->command' \
 		'(-)*:: :->arg' && return
 
@@ -244,6 +245,10 @@ __git_zsh_main ()
 			let _ret || break
 		done
 		;;
+	(config)
+		compset -P '*[=:]'
+		emulate ksh -c __git_complete_config_variable_name_and_value
+		;;
 	(arg)
 		local command="${words[1]}" __git_dir __git_cmd_idx=1
 
diff --git a/t/t9904-zsh-completion.sh b/t/t9904-zsh-completion.sh
index 14f5e5d9b8..4c7cf4234e 100755
--- a/t/t9904-zsh-completion.sh
+++ b/t/t9904-zsh-completion.sh
@@ -1071,7 +1071,7 @@ test_expect_success 'git config - value' '
 	EOF
 '
 
-test_expect_failure 'git -c - section' '
+test_expect_success 'git -c - section' '
 	test_completion "git -c br" <<-\EOF
 	branch.Z
 	browser.Z
@@ -1086,7 +1086,7 @@ test_expect_failure 'git -c - variable name' '
 	EOF
 '
 
-test_expect_failure 'git -c - value' '
+test_expect_success 'git -c - value' '
 	test_completion "git -c color.pager=" <<-\EOF
 	false Z
 	true Z
-- 
2.37.2.351.g9bf691b78c.dirty

