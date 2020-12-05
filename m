Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF34EC433FE
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 07:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71FD822D58
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 07:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbgLEHLM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Dec 2020 02:11:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbgLEHLM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Dec 2020 02:11:12 -0500
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3198FC0613D1
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 23:10:26 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id o25so9005462oie.5
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 23:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wkJVVEr87pMG+29kFO2xSe5x1qXVdlCg3XaAJ9iY/NM=;
        b=GHhBExlV86HBb6JUyjTh/XA5zXj5hEz+GoLg+BJFOjnwKirXWvveMSYQt7tP0Kqcxx
         VB2JTEyBaW7MjLgn8QJzhfCt9kZQAQEd7jKFwkJd02ufdx27CJznMXPRZmryfY/4ukPG
         A18xZzhnU/QY5d1zjiT54Z/cH0L92k5i/h6GkB572BojQ2xaJiohWilKUt13wy100VFT
         04HraA7TTSUUgcNLGWBSZSxyk8E/XPGdJWlH+98LSZf3HGXzEvK4RIS+x7qVsz/b1c1b
         wxj4IR6HP7OyYV7etwdeXI7aD2jvdYVcq+wonaW1KCo9gqnQQXi3pCfJXCgvAl4oN/WS
         dzQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wkJVVEr87pMG+29kFO2xSe5x1qXVdlCg3XaAJ9iY/NM=;
        b=ZgsixJVgVe1g/EgxZkcJBk4KQzMs+6suEZQTQMXBJYgdnOF2zfcmnJJi52EAlfyF83
         nuHlvi78bXv9tLlvXAK9woAHl4ZMrpsuAhvtJjsOIB5mrwPXUIA4T0a2a9vvrFYF4neq
         03MvLI3htSOTYXzm8y6npv4LDI28jiqyMAXn8HpN2QH2sszbBbufKycuLfzbqwcYJzx2
         7wVA/O0BTeG//OESsNMXZTYTUcmbgA7i1IfCBNiZ/xR3zZZWgxnbwq5S1bAKV63eOJSi
         4JW1Hm08wXD2HwOf6wRsVRQ56ISKjrQevANpapmkSc+eLCB1WSByN5HASiS3wKBCnmfo
         iCVg==
X-Gm-Message-State: AOAM530gWDstECYWgcBF6gMxGFBL8TR4K6/c5sYbeFKftQwEhO00P2aL
        AfyrtE7Uqfdn5zo7y63DiWKbRVcy3X7cNw==
X-Google-Smtp-Source: ABdhPJyiBcG1hWt9QVdczUde0KmWrrElvc65FhhRirhk7dsKBLuR1kOjgpK8Yya62hatseB8Pp9e4A==
X-Received: by 2002:aca:5e57:: with SMTP id s84mr5674314oib.102.1607152225332;
        Fri, 04 Dec 2020 23:10:25 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id a25sm1192852oos.23.2020.12.04.23.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 23:10:24 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH] completion: bash: fix gitk alias regression
Date:   Sat,  5 Dec 2020 01:10:23 -0600
Message-Id: <20201205071023.1270390-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Long time ago when the _git_complete helper was introduced, _gitk was
replaced with __gitk_main, and a placeholder for backwards compatibility
pointing to __git_wrap_main_gitk was left in place.

When "__git_complete gitk __gitk_main" was called, that created the
__git_wrap__gitk_main helper, which is just basically "__git_func_wrap
__gitk_main" plus `complete` options.

Unfortunately the commit b0a4b2d257 (completion: add support for
backwards compatibility, 2012-05-19) missed a previous instance of a
call to _gitk in _git_gitk

So, basically we had __git_wrap__git_main -> __git_func_wrap __git_main ->
__git_complete_command gitk -> _git_gitk -> _gitk ->
__git_wrap__gitk_main -> __git_func_wrap __gitk_main -> __gitk_main.

There was never any need to call __git_func_wrap twice. Since _git_gitk
is always called inside the wrapper, it can call __gitk_main directly.

And then, in commit 441ecdab37 (completion: bash: remove old compat
wrappers, 2020-10-27) _gitk was removed, which triggers the following
error:

  _git_gitk:9: command not found: _gitk

Let's call the correct function: __gitk_main.

Cc: SZEDER Gábor <szeder@ira.uka.de>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 1ed03623cd..463a3124da 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1829,7 +1829,7 @@ _git_fsck ()
 
 _git_gitk ()
 {
-	_gitk
+	__gitk_main
 }
 
 # Lists matching symbol names from a tag (as in ctags) file.
-- 
2.29.2

