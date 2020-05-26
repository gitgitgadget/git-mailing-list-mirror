Return-Path: <SRS0=GnTn=7I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E53C433DF
	for <git@archiver.kernel.org>; Tue, 26 May 2020 19:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FE82208B6
	for <git@archiver.kernel.org>; Tue, 26 May 2020 19:13:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f54wPcuE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404199AbgEZTNW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 May 2020 15:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404246AbgEZTNV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 May 2020 15:13:21 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29325C03E96D
        for <git@vger.kernel.org>; Tue, 26 May 2020 12:13:21 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id u188so691618wmu.1
        for <git@vger.kernel.org>; Tue, 26 May 2020 12:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=gU+wSt/AixCehJwXKSN4CJBEWs34S+BTWcCw7uoKKek=;
        b=f54wPcuEuem6HP09mS4pN1C91SnH8xN4/VUqeW2Ieud8ITIx8mwV2F/vBFqVxgZW1E
         q6eM33ucqvpdbUAAAEI/AA86GogIbaNWKW3zEqvvBFYT/7c5nb7PJPJ6SkKdrz81IrRk
         ZB3COz7T9h0n8OAT6saIY+sP41jgILQPBAreRdux1DA3K9MsK1SMLEGsp6WJkP1uf0TB
         8iYXmM/TGO5zDjymSXvTAspSZvh3vir9JzKrfYjRoDJS7yI+BlB5d52JctLrkLTQc5Wz
         qscKeasA5qvztj9WmhXfm5pM2Nb67NW2wOC7NzN7imJjXGTTEWjYW/sOv9Yqyg/dkQhL
         +vSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=gU+wSt/AixCehJwXKSN4CJBEWs34S+BTWcCw7uoKKek=;
        b=B6FdvLJMzcDPLdXEBnnDae94hd3VO0vCY9z8xhgsVzcjOvokNRZnh0IbUNb7f3tUrT
         QJ+HfOqtmvL35oM3eF9+OB8nt280YNYe77KlNBqWjUGC4GjppVnsnv+/S6x8b/61XFXH
         4dw9RSurDwe4pjv2Hmn3EqNv10qrrZI+WVnHcx0Dj3etxk3UyTC+Yv5gAl9qaxdPe8DD
         Gxkyk9JzXuK1VkidCeXRpmhUNDuP+X+RhyH8L7N0nOZ3er2kKnqsuocC7onFLmuDmnC4
         tM3HXmKEMNb94oH8BY7QqgAFKaqTnT+Hgphg7x2IoGFf4Li22ecUnyW6XKBL9v6TkQX6
         7dVw==
X-Gm-Message-State: AOAM530wfieUd1xbF9lR5oMmpcE4gDiMJLfPNGSByoGtTQOYdZdCzXMq
        CyE7Sf0b7mrPwvXgFTrFuZvym1CA
X-Google-Smtp-Source: ABdhPJxJ33GdcFwwbfXZqmbrkX0Czmgr11BMT9GMnFwxmlTyeEWiytAvdEEzxqvCm1C/+0BJ3diPQQ==
X-Received: by 2002:a1c:e0c3:: with SMTP id x186mr610170wmg.17.1590520399332;
        Tue, 26 May 2020 12:13:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k14sm628960wrq.97.2020.05.26.12.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 12:13:18 -0700 (PDT)
Message-Id: <pull.645.git.1590520398132.gitgitgadget@gmail.com>
From:   "Marco Trevisan via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 26 May 2020 19:13:17 +0000
Subject: [PATCH] completion: use native ZSH array pattern matching
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Marco Trevisan <mail@3v1n0.net>,
        =?UTF-8?q?Marco=20Trevisan=20=28Trevi=C3=B1o=29?= <mail@3v1n0.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Marco=20Trevisan=20=28Trevi=C3=B1o=29?= <mail@3v1n0.net>

When clearing the builtin operations on re-sourcing in the ZSH case we
can use the native ${parameters} associative array keys values to get
the currently `__gitcomp_builtin_*` operations using pattern matching
instead of using sed.

As also stated in commit 94408dc7, introducing this change the usage of
sed has some overhead implications, while ZSH can do this check just
using its native syntax.

Signed-off-by: Marco Trevisan (Treviño) <mail@3v1n0.net>
---
    completion: Use native ZSH array pattern matching
    
    When clearing the builtin operations on re-sourcing in the ZSH case we
    can use the native ${parameters} associative array keys values to get
    the currently __gitcomp_builtin_* operations using pattern matching
    instead of using sed.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-645%2F3v1n0%2Fzsh-native-operation-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-645/3v1n0/zsh-native-operation-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/645

 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 70ad04e1b2a..ad6934a3864 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -373,7 +373,7 @@ __gitcomp ()
 # Clear the variables caching builtins' options when (re-)sourcing
 # the completion script.
 if [[ -n ${ZSH_VERSION-} ]]; then
-	unset $(set |sed -ne 's/^\(__gitcomp_builtin_[a-zA-Z0-9_][a-zA-Z0-9_]*\)=.*/\1/p') 2>/dev/null
+	unset ${(M)${(k)parameters[@]}:#__gitcomp_builtin_*} 2>/dev/null
 else
 	unset $(compgen -v __gitcomp_builtin_)
 fi

base-commit: d2ecc46c0981fb829fdfb204604ed0a2798cbe07
-- 
gitgitgadget
