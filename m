Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C06E5C433B4
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 16:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9DFD60C3D
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 16:21:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234572AbhDZQVw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 12:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234362AbhDZQVv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 12:21:51 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CBFBC061756
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 09:21:10 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id e89-20020a9d01e20000b0290294134181aeso26818550ote.5
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 09:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i7+vS/5aoAuq3LL9K7r+djOAxgDMZpd4DD73V+p+p+0=;
        b=p5KaLVMid/8gP9APDOof6dqoITKWNMz7kUGLZg9ZH8zIAxbg+tOfZfiTDYM24iCoJ9
         lwit745nkdr5s+FIyOS6UbfeOaT5t3SitEhUtW80yfEpd5ao/Er6xmMrSdfo6d/v2T5X
         n+RiKAJBV3dInPCVhS65gJL8f/eHPs1O1NENp5vxYfvZjXeO9gHbvknRWmkqu0L2aUf/
         L4QEJF/FxzfwYKRuarDzS4lC5CEeq3hws402mbZ2Sxwi7Y2m668pydx5sut9fEw0wumm
         x4ZPfYKrqDtR0kdF16JZjuf9hWQsES1RkpGzSSOXMco/M+YaOK0EzaAQ/zgRri5Rmril
         wUDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i7+vS/5aoAuq3LL9K7r+djOAxgDMZpd4DD73V+p+p+0=;
        b=d6QcSbVOoAWCGiO4Vp9BdT4CEWl1+VCDNLb9wiiZdV9XM0HJznt/TbjTr9DNxIxA1j
         kzqmb4CxNDiJE622SENhvDCy9k99w1eSELtxTmCQwnOcqprptg3aORL0qOHl09US1Uwr
         ToPsoea2GxD+yzBOcC2Dbns7wPSVHHk42H3XOn+8tB7QCVy4tTfJSfFpbggJMShxktaQ
         Q1xUoNtSfyFUlOwJSXzSpweChgLdJaTmu4qt95ddAUfqdb62V8MjiLfD4VLOO1x1jYJi
         mWt8ibG2Cmp95WIKKnf/lElIZrximTTwcv4CkKn7Uxk9wqoRjU4in0nkSfT8q9EbG8ed
         CeYg==
X-Gm-Message-State: AOAM531kz0ET21DUeUhnECEImqToAHOKZ09dnGnE+q8G6WuqEr+9dB7G
        RU5HWW0ZC/egTzECwBLznEBZEbTDdJhwWw==
X-Google-Smtp-Source: ABdhPJzMfbF4cKLxnevd3DasqEMkVFdQYTen0CNaRub9BgFhPD9buTRk25YvJPp73VF4p60stjZlGw==
X-Received: by 2002:a05:6830:618:: with SMTP id w24mr15425548oti.147.1619454069313;
        Mon, 26 Apr 2021 09:21:09 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:638f:a2c5:89ff:fe0c:1151])
        by smtp.gmail.com with ESMTPSA id b21sm74039oov.6.2021.04.26.09.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 09:21:08 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v1 43/43] completion: zsh: add higher-priority location
Date:   Mon, 26 Apr 2021 11:14:58 -0500
Message-Id: <20210426161458.49860-44-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210426161458.49860-1-felipe.contreras@gmail.com>
References: <20210426161458.49860-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

bash-completion looks in /usr/local/share first, we should too.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 43b7c1b210..0024fd742c 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -35,6 +35,7 @@ if [ -z "$script" ]; then
 	locations=(
 		"$(dirname ${funcsourcetrace[1]%:*})"/git-completion.bash
 		"$HOME/.local/share/bash-completion/completions/git"
+		'/usr/local/share/bash-completion/completions/git'
 		"$bash_completion/git"
 		'/etc/bash_completion.d/git' # old debian
 		)
-- 
2.31.0

