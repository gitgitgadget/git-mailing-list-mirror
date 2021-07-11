Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35EA9C07E9C
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 00:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05F6461355
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 00:27:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbhGKAaL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jul 2021 20:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbhGKAaK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jul 2021 20:30:10 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D52C0613E5
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 17:27:23 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id d12so17811282wre.13
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 17:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cBXAr4C9PhS8HT7XeRkrKFLUcx/iLJNZS1aFIEbfMs4=;
        b=GRVKezhbgxd7BRX44lfsUIs19ShRGAjZrE2SyNbWpZFaua8lMrBvON+RzaEwrH99Z3
         g4E8iolxm/bwsy48hWTeF06W1APzWyo1amYJY14Nd9Nhg8ra+t7025fW9zLH1FaPbulh
         wu8czwGwGvTeUHt0nvfAcY8r0N+cR5xABCoaeoJpADOmeAoB9AjtApXmgJLxHhlUy/bu
         tvcXIQ+/55FNoCz6YkI4hp6plrKe0eM3RwdM1ln3ix1LwDIGe/JmTjT4Z9o4Ar5LitYM
         FhpdQz2epwnXyTAhhWHtqKUcHDsywIwiBcg/GexzFmVMmpV0c6YcjOa1fjXr2wRrn/q/
         f9zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=cBXAr4C9PhS8HT7XeRkrKFLUcx/iLJNZS1aFIEbfMs4=;
        b=ZWXMd/PO2IfOGdtVSrnDC2GEBwgKtCMX8VXPNmDGodJE4/k++mQOBYYoPD0iruJllO
         O59nPbFtIvXHQe0f2Xmlt4eDadsd0UiURQB/aEkdCALRAyBSjfj4vXgis9L5rOne7HU/
         KkhKyWMevsAyMKFNogFicprSYOgPAGYgVvYnPGrZXJGLE7SQDxdN/4AMkzoeLLYmEbcy
         Ud6AO1DfEqBV1udA4m3yC23J6CFGtFxGrxeyvbzSIOqe+VUahiIq2UCEr2ZnZlOl3dIC
         1R8J88kM6bbSn46Zb+sDgIM8kDr1HLJP33YXjJwQtne8OnEdyudYYgFkVFoIlLOo9qo+
         P+9g==
X-Gm-Message-State: AOAM532NCpEIbKIgFTF/Oi6K7RCKV0l1+GYpjD+wEB5yoyQLHgcNiheF
        TPWfxhJluG/Kg6ocQLK+mUHaYKNTYjE=
X-Google-Smtp-Source: ABdhPJzUqnu1Mspuoa/UMQLFIrSLxNtTULTcp4kR/zksvcpqb/PLck1vlDPBjE/jEyWqBkJKjEN+jg==
X-Received: by 2002:adf:e78c:: with SMTP id n12mr32514841wrm.382.1625963242304;
        Sat, 10 Jul 2021 17:27:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j12sm9953845wrq.83.2021.07.10.17.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jul 2021 17:27:22 -0700 (PDT)
Message-Id: <5618933279dadf48ba51b79fc11beec8c163820e.1625963240.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.992.v3.git.1625963240.gitgitgadget@gmail.com>
References: <pull.992.v2.git.1625759443.gitgitgadget@gmail.com>
        <pull.992.v3.git.1625963240.gitgitgadget@gmail.com>
From:   "Stephen Manz via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 11 Jul 2021 00:27:18 +0000
Subject: [PATCH v3 1/3] t2400: clean up '"add" worktree with lock' test
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Stephen Manz <smanz@alum.mit.edu>,
        Stephen Manz <smanz@alum.mit.edu>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stephen Manz <smanz@alum.mit.edu>

- remove unneeded `git rev-parse` which must have come from a copy-paste
  of another test
- unlock the worktree with test_when_finished

Signed-off-by: Stephen Manz <smanz@alum.mit.edu>
---
 t/t2400-worktree-add.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index 96dfca15542..93d3795cab9 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -67,8 +67,8 @@ test_expect_success '"add" worktree' '
 '
 
 test_expect_success '"add" worktree with lock' '
-	git rev-parse HEAD >expect &&
 	git worktree add --detach --lock here-with-lock main &&
+	test_when_finished "git worktree unlock here-with-lock || :" &&
 	test -f .git/worktrees/here-with-lock/locked
 '
 
-- 
gitgitgadget

