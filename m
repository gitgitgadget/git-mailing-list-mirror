Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B83D7C433FE
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 13:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F12161040
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 13:31:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236926AbhJLNdZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 09:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233296AbhJLNdV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 09:33:21 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48601C061749
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 06:31:20 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id t16so59351101eds.9
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 06:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iBDjdgd/Hpdiz9QOa9PGjBGbg5jmNn+Lkf/ybTrFUsM=;
        b=qscKEnY3v655tvC8qwOLR4jzGILUipE9wYP9Z+4qPTrXk632l3Q6NhFA+cQLnXEMtU
         t3eciYFDrC24gjIcJDfLG4yZXDu/d6NiiC7jTFjWmaKbJS3SplRz5vqEyC8xNvZzJgmX
         WCsRXira6Eo+0/XlHbM4oW4K3E8l4n5qR1HloqR6BhSUkzBO2zwAwb0R6gMXUUh4e7/g
         bBcmg6v3k+Z+VN7YoVAQ+PJZMinrDW2qt0B/GnzdjfNRyXfNKTnrfgU708nap8aSGmL8
         OnvnG8CeBN3fvneU4geEjufvOdGQax6Z91KqxrJnNvx4o8iGisauSSsGqNNRhx2EWJWq
         Q42w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iBDjdgd/Hpdiz9QOa9PGjBGbg5jmNn+Lkf/ybTrFUsM=;
        b=3BU8/uImUEnI0dXAk7EF+vQ8LsIvSQoSluUxQ62Jn+WgYbsZ48YT8C01Iaf1RyBSig
         ODed+2Oa6q1jsKnIcDb9bgTtN89YBmtI9SE2wc+m9+B9adFqyWRYMjf0TCcmegPYC6KI
         EtdGpYaRwdA5AwSybycocKS/R7aoGdvYToi0keN1vV50Jo3dHuOkfGzJKnsxcAvPtVuz
         51DDxn2fUA3NtL0HSBQ0LnEmg0GNbgW0k19TsaUka+GUTVJoGg3+ijjY57Qn/2LFWVrR
         Yud31f0jdAJVbmaxLoc8OQkOPB7VOz2qnYlL9Zps6YguNbvJWpRh9bYVpov/RBaCGwYp
         ZkKQ==
X-Gm-Message-State: AOAM530xvdzq1NYoTXPgiB1q0YLDubAQ0ENKLQm3JI0Uzu/8wxYY7J9l
        Vl7j68FnkGLoZ+rYl+P87jDii2Svq1Nlew==
X-Google-Smtp-Source: ABdhPJwYzjmC8K4Xqowy+Aiz4lEZz/x7FnEnn8XikUsWSBck3uso0VlL/Q6NX8fg9TyqRlttFS8jjA==
X-Received: by 2002:a17:907:6283:: with SMTP id nd3mr32368677ejc.362.1634045476680;
        Tue, 12 Oct 2021 06:31:16 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id bi23sm2016405ejb.122.2021.10.12.06.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 06:31:16 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Luke Diamand <luke@diamand.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 12/13] receive-pack: convert push-to-checkout hook to hook.h
Date:   Tue, 12 Oct 2021 15:30:37 +0200
Message-Id: <patch-12.13-d63b91196ae-20211012T131934Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1567.g7b23ce7ed9e
In-Reply-To: <cover-00.13-00000000000-20211012T131934Z-avarab@gmail.com>
References: <cover-00.13-00000000000-20211012T131934Z-avarab@gmail.com>
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
index 25cc0c907e1..22e7a431728 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1435,9 +1435,12 @@ static const char *push_to_checkout(unsigned char *hash,
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
+	if (run_hooks_oneshot(push_to_checkout_hook, &opt))
 		return "push-to-checkout hook declined";
 	else
 		return NULL;
-- 
2.33.0.1567.g7b23ce7ed9e

