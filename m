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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C0D8C433ED
	for <git@archiver.kernel.org>; Mon, 17 May 2021 16:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 417E361059
	for <git@archiver.kernel.org>; Mon, 17 May 2021 16:43:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237170AbhEQQpH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 12:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238970AbhEQQop (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 12:44:45 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E309C0AF563
        for <git@vger.kernel.org>; Mon, 17 May 2021 08:58:46 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id q7so8235904lfr.6
        for <git@vger.kernel.org>; Mon, 17 May 2021 08:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GAK0Kmgdeu2Z6za0hohy+9fZwSEjprYEppbMV+tguz4=;
        b=P+dnRJvqmo0G9d6ouG6dMzX2ahwuke82E0AAIo/fiOHaPpxrOiimu6KVcLUUd2pLuu
         UDuBwXGNI15VkukoYwuyV+SjTPPBXerdDj8ePir5oM+L6T4VUnE+5ndBgF9T16DHrn8u
         4SHEG8IMK+bBr1arKVbnVoZF0KmVzy7yqpmEWIG8Cec8h0GE7CVnm1352aRsOzHnG3Om
         0Od2s46n9JBL4OhM5XCc3xyDQY024hKI8KRq6vGerBAZDzKygBJjUfm+NvzVE033rhz5
         YExXsKMmM3tV4fM5gx4vefgl/uSdyEg9Nw39cRuqPOi+haoNT2iYpVUOojZBrpAEMQX7
         VXOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GAK0Kmgdeu2Z6za0hohy+9fZwSEjprYEppbMV+tguz4=;
        b=QUU4Qq9klRtYBV+n3DEjBdqL82oadODLhw/kzV/i+NnpVofbMpI4VgmG1+hqwW3LjM
         odZA6PlfTf6x+HpM0B5U2+dfvBkesUnFrxVrxCfVdYgZDMtP+cv4rwPqrS2MBqjYGNCk
         yOKKdIgaUchlXSDezd0Eroeu0flv3jZd8bgI0AFPMM0+UdqxjwFx7mSjw6XmCOqmJFvR
         GmPc9Ur0aVlk+fT4HJfA9lTTZ30Bccx1lyFXVbZBHyB/c1gLSxsvoDaqJjkgHF7nma3Z
         u4UGG7uY8h1njFLBLm3w8x7DTnmu29Fby/xg7ezAgvvIncMxICAVLxqykMwV7b6071lv
         vpjg==
X-Gm-Message-State: AOAM532lURR8WmqpSPdyjAo1FMHoM/fCks3+VFGo64arCF1EmNgijtda
        LLDzSSh250D9ZKGzoMQdXbo=
X-Google-Smtp-Source: ABdhPJyh+RiHAUoj3PTjIjE2VVijcQKCO+4DVBhbxFG5Ym2V9jXMDPqQHiEwaPj5509zw8nvRc9atA==
X-Received: by 2002:a05:6512:3b87:: with SMTP id g7mr380195lfv.241.1621267125080;
        Mon, 17 May 2021 08:58:45 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id i8sm1996834lfd.12.2021.05.17.08.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 08:58:44 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Alex Henrie <alexhenrie24@gmail.com>,
        git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v1 7/9] stash list: stop passing "-m" to "git list"
Date:   Mon, 17 May 2021 18:58:16 +0300
Message-Id: <20210517155818.32224-8-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210517155818.32224-1-sorganov@gmail.com>
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
 <20210517155818.32224-1-sorganov@gmail.com>
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

