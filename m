Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B735AC433B4
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 16:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B0E761139
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 16:16:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234356AbhDZQQl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 12:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234355AbhDZQQl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 12:16:41 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0F8C061574
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 09:15:59 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id z20-20020a0568301294b02902a52ecbaf18so240664otp.8
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 09:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2Vhw3XbjeOHteQa7HFxqAjjBI4kBKlE6wqvnhG7RLNg=;
        b=K97yfJaDgXTJjqGdpzV/4lJz6YjwqUi3GnnapGbAmdfOr7etCaZxBQWRqyU8gqzBtb
         1QInwMTjXu+1d0k1LMOxKin/2u8D2WX6+UHiNecRAuSg7Nu36tShLvB5Ic7kBvtINhOQ
         GL7RdnEpBOIY2biqapQWlfe+a9yLEVVpcipewWst2QAksf/Hj1sakzm6m/2iZ7Fr39Ne
         4I94p1J7iOGZ9gX4wOdvMPxSTCv0zyyEKO+XU/ECC64V2EIFFi4afGxaHAXHmzgwakaU
         CpdPXFSjAdDnnh0RZXH/nNtqZXHeegw/t16KOZv8X/7KmPAazrljnPBrKW8K4ls2kciK
         UHYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2Vhw3XbjeOHteQa7HFxqAjjBI4kBKlE6wqvnhG7RLNg=;
        b=KV6do/w6kOuciZu5lDelq4Q4ow+Bw5y/1NxaKiWejAupHsdmro7c7fbYIf0MmVLKCr
         KSeF1VYDxr6ZHp6j5Orpbmne+b+H4PXW6iTq+cgpYw8MTG/Btu8q5/bZ4ogGladJSsCQ
         KT3i0JliQtUPwbLFYihdkBt4zpr5e4GM5SoYihit1jRuqs2L2SHm+9Ag3HqfiuJsmTyZ
         dz6DLrEPfMUjx/VaK2Uc/fGSHyGoG9fl4y+2M02t6+wXor3d1Vm2vBdKRAjaFW8TWiMq
         PJvrhgMzZmKlvHgu9DkK+7JhZmOy2jTtn5g5Mjh3yEiPO7B0dlW/h21EW68/gl45E+ZD
         YhyQ==
X-Gm-Message-State: AOAM530G0qUK1PW/Z440s62WUzEa7zHyENgcKhCbt1HHIZKcNWR7zgrA
        roQY++65+xX7ROg7Y2Pus4oNvoOlRsB85g==
X-Google-Smtp-Source: ABdhPJwvQyJiU3lBqClFOnxi7rZJMykP4guobI6OvGKFM9xt/RgFkl/PQZWD/TuoxIbinM1SxzdI4A==
X-Received: by 2002:a9d:4d9a:: with SMTP id u26mr15382807otk.161.1619453758704;
        Mon, 26 Apr 2021 09:15:58 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:638f:a2c5:89ff:fe0c:1151])
        by smtp.gmail.com with ESMTPSA id p2sm64810ool.15.2021.04.26.09.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 09:15:58 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v1 12/43] completion: zsh: fix options with arguments
Date:   Mon, 26 Apr 2021 11:14:27 -0500
Message-Id: <20210426161458.49860-13-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210426161458.49860-1-felipe.contreras@gmail.com>
References: <20210426161458.49860-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

They support both '--git-dir=value' and '--git-dir value'. Fix the
arguments to support both.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 97d2bcadd6..966b2d9277 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -217,15 +217,15 @@ __git_zsh_main ()
 	_arguments -C \
 		'(-p --paginate --no-pager)'{-p,--paginate}'[pipe all output into ''less'']' \
 		'(-p --paginate)--no-pager[do not pipe git output into a pager]' \
-		'--git-dir=-[set the path to the repository]: :_directories' \
+		'--git-dir=[set the path to the repository]: :_directories' \
 		'--bare[treat the repository as a bare repository]' \
 		'(- :)--version[prints the git suite version]' \
-		'--exec-path=-[path to where your core git programs are installed]:: :_directories' \
+		'--exec-path=[path to where your core git programs are installed]:: :_directories' \
 		'--html-path[print the path where git''s HTML documentation is installed]' \
 		'--info-path[print the path where the Info files are installed]' \
 		'--man-path[print the manpath (see `man(1)`) for the man pages]' \
-		'--work-tree=-[set the path to the working tree]: :_directories' \
-		'--namespace=-[set the git namespace]' \
+		'--work-tree=[set the path to the working tree]: :_directories' \
+		'--namespace=[set the git namespace]:' \
 		'--no-replace-objects[do not use replacement refs to replace git objects]' \
 		'(- :)--help[prints the synopsis and a list of the most commonly used commands]: :->arg' \
 		'(-): :->command' \
-- 
2.31.0

