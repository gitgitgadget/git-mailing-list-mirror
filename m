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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB7F3C433ED
	for <git@archiver.kernel.org>; Mon, 10 May 2021 15:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99B2B61409
	for <git@archiver.kernel.org>; Mon, 10 May 2021 15:35:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234298AbhEJPge (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 May 2021 11:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236275AbhEJPgG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 May 2021 11:36:06 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59DC3C06138B
        for <git@vger.kernel.org>; Mon, 10 May 2021 08:34:59 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id b7so21346046ljr.4
        for <git@vger.kernel.org>; Mon, 10 May 2021 08:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GAK0Kmgdeu2Z6za0hohy+9fZwSEjprYEppbMV+tguz4=;
        b=q1bVpt4o4XIM760qj2qIyGBizt2kOfy0/KyR+/gjYWB8X5RpcZXNCr61VRJvI0gdJt
         A6mekxr05UyPL3KLEXcJu1Jqdw5Mcu4bKDhFm+39wZ+1NDx1SUYNy7cta7w+pebNoH3s
         ERjUosmRg+Klam/kt47Lj6wEh7PWlGiRgRDu7YQ5+uu3J8RBWjgjHQcO2/t5KwU9i/F1
         5CRxSWdOfhi19SXcOeUYUE+foXczcDU2IFXsW+zBSnVqxEPngND3grHGYgvpFGvdKZNe
         AddK2wzzWF05lXKizcpAUzBUd8d1JkMc5JN1RkLzfvcodwG71/4JC+b0+xdIZdIebxDw
         wu8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GAK0Kmgdeu2Z6za0hohy+9fZwSEjprYEppbMV+tguz4=;
        b=ndMpN0LMoXwOIP1kGEXS1fjKdZZvtDFEaEMdD1XsbXlJ3D6lZEUYpICMR4xY9dyT1E
         DSOCmPyye0Z+A2/+UX0nk+BlOpevTE00iePYygMmUdvYk/SAFasjLSb7tsT12NMVwu3f
         /qkXuLYYSbhbJf30Pgsekdj+881NktwVIYObw/eBu2zJpKKKrQuOe7bidoikpByD1POe
         EASImgQQqz19oA6l5/9mkr27c4bShUrLoq6nd4UmWmY5r6EKvBiHPzdmPlE34mEGbetZ
         UhDyAgsoSYTkXzUIncG9H7M8/SgqK9KBeHb6heV1DbK+jd7meecNmg36vyYg/p4zCICw
         gMKQ==
X-Gm-Message-State: AOAM530GmGrzFdIj+nRQU4K1B1HVW6BVI0FFn10JgFgVE7MtyydALROI
        F5ESEf/L5jFjC7choXpitNSDUBnwW9w=
X-Google-Smtp-Source: ABdhPJwdqhYPgV4LdW4oJfE0toQbJJAY3XuEt5SgKjZcLXRaiYYdAqsBbnEjg4R2NWaXZiIgc38JGw==
X-Received: by 2002:a2e:9346:: with SMTP id m6mr2426717ljh.150.1620660897950;
        Mon, 10 May 2021 08:34:57 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id p8sm1525840lfe.224.2021.05.10.08.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 08:34:57 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Alex Henrie <alexhenrie24@gmail.com>,
        git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH 4/6] stash list: stop passing "-m" to "git list"
Date:   Mon, 10 May 2021 18:34:49 +0300
Message-Id: <20210510153451.15090-5-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210510153451.15090-1-sorganov@gmail.com>
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
 <20210510153451.15090-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Passing "-m" in "git list --first-parent -m" is not needed as
--first-parent implies --diff-merges=first-parent anyway. OTOH, it
will stop being harmless once we let "-m" imply "-p".

While we are at it, fix corresponding test description in t3903-stash
to match what it actually tests.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 builtin/stash.c  | 2 +-
 t/t3903-stash.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index d68ed784d2af..fe8e97428808 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -761,7 +761,7 @@ static int list_stash(int argc, const char **argv, const char *prefix)
 
 	cp.git_cmd = 1;
 	strvec_pushl(&cp.args, "log", "--format=%gd: %gs", "-g",
-		     "--first-parent", "-m", NULL);
+		     "--first-parent", NULL);
 	strvec_pushv(&cp.args, argv);
 	strvec_push(&cp.args, ref_stash);
 	strvec_push(&cp.args, "--");
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 5f282ecf6175..873aa56e359d 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -859,7 +859,7 @@ test_expect_success 'setup stash with index and worktree changes' '
 	git stash
 '
 
-test_expect_success 'stash list implies --first-parent -m' '
+test_expect_success 'stash list -p shows simple diff' '
 	cat >expect <<-EOF &&
 	stash@{0}
 
-- 
2.25.1

