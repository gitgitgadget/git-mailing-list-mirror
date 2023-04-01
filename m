Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB48C6FD1D
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 08:48:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjDAIsQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 04:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjDAIr3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 04:47:29 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A8CFF1A
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 01:47:00 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id r16so18347126oij.5
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 01:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680338819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=McaFQALs4PpVc83rGiMAdmY7uQ+bWdI+3Lqnbd3QDyc=;
        b=YDHr1xoqw+0LdUnTqAXDNOpZs153aO/3uMbWmcZKooIyMD+LeI+OErLOKyjDUL6Bt8
         k5i7/P48plWQCWaKRmMSQKvVtT2RT6hvIOc2dzpH1+IWCrLPYgLA3Zw/5zlcqCdSbWw/
         uNZByj9JuDZbOR+hqkiuldP7zYoEQJR2Hq/cL8RanS5oSijaMYokv0xdVzcmgytmdnaY
         DyrhP4gR4rE2SH+/9HVPBAx2MjX6ChdN5FbHiQPOZMBmSZoc8/MnOo6jMerikrMN6XyO
         klYm2xHtjMWjZ0XAAfayF0P29OwIujRK8Ff1E/dDi/XqIdG6Dy+qI4ffE/EPbLkCfxCF
         MLcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680338819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=McaFQALs4PpVc83rGiMAdmY7uQ+bWdI+3Lqnbd3QDyc=;
        b=Yjxm6DdstUcglAS7mrN8AbZNuI22JbSxKCIhu/QllXUhKr6QhdV14wiPOUeiIBbnBf
         sSjXmGjzx/llEe1PFLNtnGdpaM0ykrGYUm0KdAK70sMDFAbBiPwjvQo4cP+mAafKO1fN
         b5qBkhWAGj2Ez4CPluwPJ6/Xoi8JRdD0i2GTuMyTKRiLZ8SREgo92/A5Nv4A94UQqCIW
         S1kxFEs1JeRmJu7n0LIBidVt0erwbD9yFomw1wO8Eq6Nq5RX74S8yLGTrQmpDNYBmu0V
         3GuMjn5KTl1ju8dp+yu5WJav+zhvu8XtGPkBzuAatBCVdl6UvPkys9lMq9hNdsikdcSU
         bl+Q==
X-Gm-Message-State: AAQBX9fgWogkqd7Ovai31zSo6QVRJpOEXAMGoTsM4fPOJTxH/2O37Cpq
        gddicu3HLx2WNPJkwBR4FElTIGF4NUU=
X-Google-Smtp-Source: AKy350bMZJXq4cKz05dUyswIVv7946NB+PO5ps6fjQ6vbYyKpK1zseWT40stXplYvc4yYrsVWqnLcw==
X-Received: by 2002:a54:4701:0:b0:389:70b5:abf6 with SMTP id k1-20020a544701000000b0038970b5abf6mr4113362oik.19.1680338819794;
        Sat, 01 Apr 2023 01:46:59 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id r84-20020acac157000000b003845f4991c7sm1846402oif.11.2023.04.01.01.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 01:46:59 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v7 23/49] completion: zsh: add support for general -c opts
Date:   Sat,  1 Apr 2023 02:46:00 -0600
Message-Id: <20230401084626.304356-24-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230401084626.304356-1-felipe.contreras@gmail.com>
References: <20230401084626.304356-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So we can specify configurations.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 5 +++++
 t/t9904-completion-zsh.sh             | 4 ++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 88157b0867..a7a5efbd13 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -226,6 +226,7 @@ __git_zsh_main ()
 		'--no-replace-objects[do not use replacement refs to replace git objects]' \
 		'(- :)--help[prints the synopsis and a list of the most commonly used commands]: :->arg' \
 		'*-C[run as if git was started in the given path]: :_directories' \
+		'*-c[pass a configuration parameter to the command]: :->config' \
 		'(-): :->command' \
 		'(-)*:: :->arg' && return
 
@@ -239,6 +240,10 @@ __git_zsh_main ()
 			let _ret || break
 		done
 		;;
+	(config)
+		compset -P '*[=:]'
+		emulate ksh -c __git_complete_config_variable_name_and_value
+		;;
 	(arg)
 		local command="${words[1]}" __git_dir __git_cmd_idx=1
 
diff --git a/t/t9904-completion-zsh.sh b/t/t9904-completion-zsh.sh
index 472b02d3e6..1b18bf5363 100755
--- a/t/t9904-completion-zsh.sh
+++ b/t/t9904-completion-zsh.sh
@@ -1090,7 +1090,7 @@ test_expect_success 'git config - value' '
 	EOF
 '
 
-test_expect_failure 'git -c - section' '
+test_expect_success 'git -c - section' '
 	test_completion "git -c br" <<-\EOF
 	branch.Z
 	browser.Z
@@ -1105,7 +1105,7 @@ test_expect_failure 'git -c - variable name' '
 	EOF
 '
 
-test_expect_failure 'git -c - value' '
+test_expect_success 'git -c - value' '
 	test_completion "git -c color.pager=" <<-\EOF
 	false Z
 	true Z
-- 
2.33.0

