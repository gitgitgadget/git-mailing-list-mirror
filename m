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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF9AC43460
	for <git@archiver.kernel.org>; Wed, 19 May 2021 11:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 533A7610CB
	for <git@archiver.kernel.org>; Wed, 19 May 2021 11:48:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352459AbhESLuE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 07:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352416AbhESLuA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 07:50:00 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E67E4C06175F
        for <git@vger.kernel.org>; Wed, 19 May 2021 04:48:40 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id m11so18637485lfg.3
        for <git@vger.kernel.org>; Wed, 19 May 2021 04:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FbQncOG/KfycyARQfcu0X5g1uj2Y12NXje0qRt++RfU=;
        b=b1Iu2Lc08rG/ZGSV5Za4Y3yzY1ptHDD991rCut1u/WX+pTABcRpdZmbpILpdqvVl8E
         Ym9nhPPYgmQJxe6q0HpkPdcRIBkMxerBAsacsKS/OjgZpaHyDKlmohVxFS305VN9z9kr
         5L3GVlznWvuQIl085KZmqkMzw91mLOrftC4aAKgpZ7AipcPnoT0TNn84NuSpZ+4Kq/Od
         un7bi2tpLQ3kH15uEeHbONro3y6dTP/G8IqpVYpxKGIudNcuKkMf44oZCYBHkQtSZ7dh
         xLBK/xx9SMG8tqB7Qsbuwe5M0CV13YKirJcuTZAiFIdNRvCdgfgv75ocaYT1yC5JOM+8
         Hb9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FbQncOG/KfycyARQfcu0X5g1uj2Y12NXje0qRt++RfU=;
        b=WqcpMmKYJFBXtpMlcr/8haTaVUQw+CE5heePDR/P+es++1OAx4uiaMhB1WoLS6xkbZ
         BlvmYYt4mjsTMLxOf1s5PG1FT1wY9tGZ5jkfm1JW+1ALsK/aosKAvbfsDjYajhaE3gdx
         dShustGtr8DebvpQZqPBPX7bgAuSvzT1txsstf06LRQ8NPVmCUhR/Iztt0KoZLKhVc3G
         X3cUl9p7DUGh6c5RfmGTqm7L3JjXON97FTk2b7WkwNq8rptO5bNbRYyeqAS4hsrvfqcl
         4Hrogiqm8zkjii6ivFnIp3PP++GDFBF8uEiq8hZUEC9nJ3YjvyxohriBia1W8hhSKMUZ
         EsaA==
X-Gm-Message-State: AOAM5320wu/SMEpNNwFzye8NjT7YVz81IH9WSjQZyXFxKeE0JhDzZsUS
        Lw1OCqEB0uR8LCM+rHACOY0=
X-Google-Smtp-Source: ABdhPJx07yd6odZvbj0n36REo6zSdPrUYkjdGCCXF7iCC9ZydGZAfo+Ffu2RgMnve5JcKGzAWxCFsg==
X-Received: by 2002:a05:6512:693:: with SMTP id t19mr8251805lfe.91.1621424919352;
        Wed, 19 May 2021 04:48:39 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id o2sm1846470ljp.60.2021.05.19.04.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 04:48:39 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Alex Henrie <alexhenrie24@gmail.com>,
        git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v2 7/9] stash list: stop passing "-m" to "git log"
Date:   Wed, 19 May 2021 14:45:50 +0300
Message-Id: <20210519114552.4180-8-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210519114552.4180-1-sorganov@gmail.com>
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
 <20210519114552.4180-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Passing "-m" in "git log --first-parent -m" is not needed as
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

