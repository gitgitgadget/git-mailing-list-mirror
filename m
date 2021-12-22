Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A959C433EF
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 04:00:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242261AbhLVEAN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 23:00:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238870AbhLVEAC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 23:00:02 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF0EC061757
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 20:00:01 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id c66so689327wma.5
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 20:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ab1uxr9U2iog4UxufO1MxpAOKZi1TGVFChdPYp1iPB8=;
        b=ct50dJ1YjJbiyWAvhw8pb0eVinivBkrD/3eVMP36t4cFQ8zsIYGYspIM9gk1xn4kFQ
         6wNQlnTGjqVdVj3mQq2fkPjJ8CkT5IydKgNlC47qZa6ysY7SodqDIRA4mXTOtCwogCjA
         bIRbvCSLZW/xu1DqYGSoKDVDE05bYXhsxuWVPzLTgJQ1sXt+Jv/DddeBVHnL98eDlfV7
         Twlm4MBjRgoyrhfU7wD8CbiA/Nr2DJSeytk8opME1Ot5B3R6sc44P1oGg0ZSVXwKOxSH
         gyVqiCaZa0iTyvyv0/Qg7eJeg+2NUvX7zyF2w17nLGdhr+f41bF1YdMIhcYdd9Otf2ET
         GY1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ab1uxr9U2iog4UxufO1MxpAOKZi1TGVFChdPYp1iPB8=;
        b=z6j8byXR8O7SJjr5ksxIOIYNkK+v61oM4xSnkHUL0WZG0r8Vf/DuSHiC4hjKZOJWyA
         XEfeeP76uQLu+aMssrgSshl7hYKupVwk3RmFKLddfOUCk73d9WmMtoxY6lq3AnC0dW2Z
         3DBMatoabrnDxUlI+q8snxxlHsetJNgrRCdJInqqFkLnGOMH2ZdTKa+F7oOtNhyoMk0C
         5CkxtPJDwwg7mbYmb9zrEujKbvNMslFdrfQfelxQBN77AkCLbYMGu2JsrRx6b1VRH2eG
         VzbXNoJaaWqEhjVWYME5hLmm3ebbkmRH0Rr2kDC3MT4ZvPtbhGQ/ZbfBODI0gaYWIOUn
         +Npw==
X-Gm-Message-State: AOAM5337rjFYPa/4MP52ftBLQLq/f6OPg/bVvJavn1KIJx3VKIFxNfED
        tMePsuEbgfOb6oaYsz2ffnbz5idcirn+1g==
X-Google-Smtp-Source: ABdhPJyh2B7MWEbQxVSkjn3sdyypcLLoVE4gQG4yqHJOmGXhx0Hc75Fy8RTFIeXEai1V0kWOGHtBfA==
X-Received: by 2002:a05:600c:5010:: with SMTP id n16mr746521wmr.139.1640145599480;
        Tue, 21 Dec 2021 19:59:59 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s8sm867300wra.9.2021.12.21.19.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 19:59:58 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 16/17] receive-pack: convert push-to-checkout hook to hook.h
Date:   Wed, 22 Dec 2021 04:59:42 +0100
Message-Id: <patch-v6-16.17-c47b36ab41a-20211222T035755Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1146.gb52885e7c44
In-Reply-To: <cover-v6-00.17-00000000000-20211222T035755Z-avarab@gmail.com>
References: <cover-v5-00.17-00000000000-20211123T114206Z-avarab@gmail.com> <cover-v6-00.17-00000000000-20211222T035755Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

Move the push-to-checkout hook away from run-command.h to and over to
the new hook.h library.

This removes the last direct user of run_hook_le(), so we could remove
that function now, but let's leave that to a follow-up cleanup commit.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/receive-pack.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 4f92e6f059d..e99b1ecd103 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1424,9 +1424,12 @@ static const char *push_to_checkout(unsigned char *hash,
 				    struct strvec *env,
 				    const char *work_tree)
 {
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+
 	strvec_pushf(env, "GIT_WORK_TREE=%s", absolute_path(work_tree));
-	if (run_hook_le(env->v, push_to_checkout_hook,
-			hash_to_hex(hash), NULL))
+	strvec_pushv(&opt.env, env->v);
+	strvec_push(&opt.args, hash_to_hex(hash));
+	if (run_hooks_opt(push_to_checkout_hook, &opt))
 		return "push-to-checkout hook declined";
 	else
 		return NULL;
-- 
2.34.1.1146.gb52885e7c44

