Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E9F4C6FD1D
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 08:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjDAIrI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 04:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjDAIqy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 04:46:54 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6EC1F7B3
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 01:46:43 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id q27so17676746oiw.0
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 01:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680338802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YALdm2/0a1pXRLq+ru7XwkN3rxaKhRZCMQQLXCsdWm4=;
        b=DH+n2unKqJp32kRdQXG7Sc1QZ5Pby7Fjq4pVYKAQoYvjIkexLnRtytEJ/Bnmv8/G7v
         w2kmKLFFyGyJCNXX+g3FBTPYRQ4DCiADh3xrITJ6D2OfawN9xchpGNrbwVF/BRyF33QN
         TxjlWK4r/x6YgwyRFaN4d4nLEsyU+mldxmkH3Dxfo1dc4ahffgC/YdWTVpsNznEmIb/i
         5YbediwV/dbAGtKIJxf5/lVsBNqCnjpu40xZOcADc/vriIEw5cpf2pB1hWO/EK0ygKML
         6nXP5vpyF8E14K3lCb6JAP/h+E2R8683ZomlBcug2PQ5zPjT1V+/b4qeMFpcW/xo3h4h
         d3WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680338802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YALdm2/0a1pXRLq+ru7XwkN3rxaKhRZCMQQLXCsdWm4=;
        b=xsOx+AEa0JgahPF3Fgl3ucBMuo7VfWfM/MjKdbw1A+EKjdLnStZ9l4ZgYAN8Jh+YMY
         kL9DWxTuXB2tANUrWyncFvWD/ZMJSz6bU25vgVs4DnOrDjIyXcA+SyHTt3WdXGDifsbd
         tq7Z/NnUfyS2g1UqHHe+ehF0GzDlY/o+Gb5SPS29Iy30TX2b9Z1daNiAQ40GBc37TQem
         Q7mKfiPEDcB7YK9DY09oaLqGy2tr6nbdfyd6ZR+KOYJOQANDUrYae41CElnQ7qQeOly2
         lU7oLUZ+U2E1UMglIQm+s1rdExKvvKPa+OYHXahieCTVWZx5uUfF2P6LmthNKlVunpsw
         gmgw==
X-Gm-Message-State: AO0yUKU7nI+2bVySQ9Xl+I761vozDc7FDZg7f9LB5nzogd6g0lVl2LuM
        pCPRprQHCRiHU+Xx93k6ufoOWHn0jNo=
X-Google-Smtp-Source: AK7set/vXlDDJKbV1sSFzcYNgF21zCKuoalzsc+nknz2YVe/zYsLkc9Hq4zddyIm32gRp7yeJGouUA==
X-Received: by 2002:aca:2217:0:b0:387:6a3b:5a86 with SMTP id b23-20020aca2217000000b003876a3b5a86mr13044221oic.28.1680338802165;
        Sat, 01 Apr 2023 01:46:42 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id h4-20020aca1804000000b003896fc34eddsm1820393oih.52.2023.04.01.01.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 01:46:41 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v7 10/49] completion: fix for suboptions with value
Date:   Sat,  1 Apr 2023 02:45:47 -0600
Message-Id: <20230401084626.304356-11-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230401084626.304356-1-felipe.contreras@gmail.com>
References: <20230401084626.304356-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We need to ignore options that don't start with -- as well.

Depending on the value of COMP_WORDBREAKS, the last word could be
duplicated otherwise.

Can be tested with:

  git merge -X diff-algorithm=<tab>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 2 +-
 t/t9904-completion-zsh.sh             | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index d11f4765b6..13809f7894 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -56,7 +56,7 @@ __gitcomp ()
 	local cur_="${3-$cur}"
 
 	case "$cur_" in
-	--*=)
+	*=)
 		;;
 	--no-*)
 		local c IFS=$' \t\n'
diff --git a/t/t9904-completion-zsh.sh b/t/t9904-completion-zsh.sh
index b7e4029bf9..994d57a67f 100755
--- a/t/t9904-completion-zsh.sh
+++ b/t/t9904-completion-zsh.sh
@@ -176,7 +176,7 @@ test_expect_success '__gitcomp - expand/narrow all negative options' '
 	EOF
 '
 
-test_expect_failure '__gitcomp - equal skip' '
+test_expect_success '__gitcomp - equal skip' '
 	test_gitcomp "--option=" "--option=" <<-\EOF &&
 
 	EOF
@@ -1134,7 +1134,7 @@ test_expect_success 'git clone --config= - value' '
 	EOF
 '
 
-test_expect_failure 'options with value' '
+test_expect_success 'options with value' '
 	test_completion "git merge -X diff-algorithm=" <<-\EOF
 
 	EOF
-- 
2.33.0

