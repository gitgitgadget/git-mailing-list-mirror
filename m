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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3249C47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 02:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 981656120F
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 02:38:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbhFHCkZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 22:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbhFHCkY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 22:40:24 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB74C061574
        for <git@vger.kernel.org>; Mon,  7 Jun 2021 19:38:20 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id v142so19712788oie.9
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 19:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WHhocZkXWhRFEwVR6K+G7ygTzsmFewp/nDkXSmxSQh0=;
        b=Hm5wdP7eeNA4CsoBs4boLtRTxYG/Q3N/TDWwr1dgLUL/VpvP9rok9sYN7RAWLwpkM1
         KsoH9mX+XdhPncc6MKBDdtIJJwro/8ItL+O5AN+67vfqguMPvFutxkwsR+Y9TEG0LmsL
         DD0NimbUE6U8qxlSnAEnXsx7eYN+ep5WjjUrDhcr3Ha6e8VwtnavYDy+XPDrLw+yLXcp
         BwH18ABhXcAhr6XpZtOwSZk8/KDEggQWSiZgPSKa3bbEQVlVRzb75WlZUgi1xSSC6r6A
         uUV8WM+uBLJggLZvf5sbz/08KhWdaXHHusDcaIgnDqq+M1JIBNvcu6hZVePg4ocHE2iQ
         L9Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WHhocZkXWhRFEwVR6K+G7ygTzsmFewp/nDkXSmxSQh0=;
        b=JawTYq2nj965vblTXtI42SfMC2rjGy/Wrs1mmHpZLi4N6vUNrWT7YmAVL23Pm/bx1Z
         aT7wcqdxKcFQMRjZuB5gRmdnY8AY8oKEivBHruKTYkI3N2G870VNuMwWHWcdBwkBYTzQ
         Gcmajeabcbsr3gQprDNte/gyp6SmpSG+Hp8BYnbGqBzHKohpdXV2xaDxir7DV/7wX/lD
         +QdzWiaPcWv3hfRJsDptNhu9BqwFM0nJGsrqt2K4fUGWK0exv302UCAalA6Y0z3sMo0X
         XWfDZuanzizjvlqxaJ3emxUxpPkTbi+6m2+D4d9+uluGs9SizMMmsxjd835d+LOICbPF
         PzbQ==
X-Gm-Message-State: AOAM532YIE8Jkn/f3XQdTtJ6TKFKoerfmdICN3zuxq+5UOWlxFAmzJGe
        49aRlQ49DJ5+OjZoiMPliltTcOFaDvcC0Q==
X-Google-Smtp-Source: ABdhPJxtOrpVVVzVc0fdwSdxpADZ4Zj+GjPqOZOaiTuiDIvuAAW/ogK598USBL5fDyozK1b5wssTcA==
X-Received: by 2002:a05:6808:6c4:: with SMTP id m4mr1467892oih.88.1623119899499;
        Mon, 07 Jun 2021 19:38:19 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id 6sm1382202otp.47.2021.06.07.19.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 19:38:19 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     David Aguilar <davvid@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] completion: zsh: trivial improvement
Date:   Mon,  7 Jun 2021 21:38:07 -0500
Message-Id: <20210608023807.907883-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.2.g41be0a4e50
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

$words has basically all the words we need, except the first one: git.

Lets simply add that instead of passing the original, which contains
options we don't want to pass downstream (like --git-dir).

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index cac6f61881..50f89145f3 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -219,9 +219,6 @@ __git_zsh_main ()
 {
 	local curcontext="$curcontext" state state_descr line
 	typeset -A opt_args
-	local -a orig_words
-
-	orig_words=( ${words[@]} )
 
 	_arguments -C \
 		'(-p --paginate --no-pager)'{-p,--paginate}'[pipe all output into ''less'']' \
@@ -261,7 +258,7 @@ __git_zsh_main ()
 
 		(( $+opt_args[--help] )) && command='help'
 
-		words=( ${orig_words[@]} )
+		words=( git ${words[@]} )
 
 		__git_zsh_bash_func $command
 		;;
-- 
2.32.0.2.g41be0a4e50

