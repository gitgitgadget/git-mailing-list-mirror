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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60FA9C48BDF
	for <git@archiver.kernel.org>; Sun, 20 Jun 2021 20:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F9E26117A
	for <git@archiver.kernel.org>; Sun, 20 Jun 2021 20:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbhFTUFr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Jun 2021 16:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbhFTUFj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Jun 2021 16:05:39 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3CA3C061760
        for <git@vger.kernel.org>; Sun, 20 Jun 2021 13:03:25 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id gb32so16956164ejc.2
        for <git@vger.kernel.org>; Sun, 20 Jun 2021 13:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cutGbTWE6TDPRNZb51Q8EtgzZcZ3xxRybUk+wxlVNFo=;
        b=SOwXKW4floK8eKJg7fzQT3998cfJGZlG2MTGHGTYxlNpMfo8CNdgXbL7h4pKWVA+3m
         b0G1RtisoC2Q2GYWDXj2EFbPQFZTedd2H1RcL1bbFj7oJPRkUg4LrtzLFw7mXk1kEXop
         GGPnX6MNDviRAP9tV3Bn71UGwUG8QNqBMGQbZZiq1ATi3syMR+wRQkJmXoI+9uSTngrr
         OjbJ/B+4jkFZuGbNqwuWnj3wUsHpTK7ivIQdirnTWPA3r6PgHEK44O5YRvg7ybFPQpPe
         Px+LTD6+ZZBCOygCrm5r1XHwoQQDeGbUvAepUlPp0d9mOeJ8ybFt6OcETfloREyMrRU8
         eB5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cutGbTWE6TDPRNZb51Q8EtgzZcZ3xxRybUk+wxlVNFo=;
        b=HrbpNaIfcZnFvzY1l5LlM7QsUYkqm/lQR7GSp4DvJ/oO7aGxQZqdpcU00qirs07Ago
         0JAnhpgUHzWS4UxaKY+7UuHgJOL7sOfJkgM4Z/uuVaQfX6w2Seu1ly8uZo3FQFV+awTs
         bdB0QyH9kSru0KOkuQHmz/nF3dJqsIu+ta8n+waXbcH2g9K5d8pgEARAExo4eBqu/s6q
         JoV4N17AwXXIgYBTG/ZmrJXqLFhmWnuNK+achRc/E2FoqnwCnyl384NfYsRV74Zxpr9I
         Ofbwn7mKTwXRqWnFnaPGQQdGCUZ0MNbZ6fj/BBl1Eu7q7+TtK1pr6+jcM54XOLxBaAPR
         uucw==
X-Gm-Message-State: AOAM533WF7NWeXM3VKOzuQI7d2xXguP72lrD87ehTvkZ6KAlj6d3235M
        ml8YldFBHKlzahHVuhLI2uJYR0mOc2s=
X-Google-Smtp-Source: ABdhPJz3ZqXwwV6U8JTvHLh2xhZoh1OPUe/lgwcZHFgEXviou4A2+k2ojAI0owdHPm6U4WrvmJXt5A==
X-Received: by 2002:a17:906:bcf4:: with SMTP id op20mr603810ejb.327.1624219404414;
        Sun, 20 Jun 2021 13:03:24 -0700 (PDT)
Received: from localhost.localdomain (94-21-23-215.pool.digikabel.hu. [94.21.23.215])
        by smtp.gmail.com with ESMTPSA id cw10sm3893904ejb.62.2021.06.20.13.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jun 2021 13:03:24 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 7/7] test-lib: enable GIT_TEST_CHECK_PROGRESS by default
Date:   Sun, 20 Jun 2021 22:03:03 +0200
Message-Id: <20210620200303.2328957-8-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.32.0.289.g44fbea0957
In-Reply-To: <20210620200303.2328957-1-szeder.dev@gmail.com>
References: <20210620200303.2328957-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Let's enable GIT_TEST_CHECK_PROGRESS by default, in the hope that it
will effectively prevent buggy progress line counters and nested
progress lines from entering our codebase in the future.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/test-lib.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index adaf03543e..ae2dd6d0d2 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1502,6 +1502,12 @@ then
 	export GIT_TEST_CHECK_CACHE_TREE
 fi
 
+if test -z "$GIT_TEST_CHECK_PROGRESS"
+then
+	GIT_TEST_CHECK_PROGRESS=true
+	export GIT_TEST_CHECK_PROGRESS
+fi
+
 test_lazy_prereq PIPE '
 	# test whether the filesystem supports FIFOs
 	test_have_prereq !MINGW,!CYGWIN &&
-- 
2.32.0.289.g44fbea0957

