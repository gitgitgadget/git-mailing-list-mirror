Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B7EC433FE
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 19:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5F28230FA
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 19:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgLETy0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Dec 2020 14:54:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbgLETyZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Dec 2020 14:54:25 -0500
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AEA5C08E864
        for <git@vger.kernel.org>; Sat,  5 Dec 2020 11:53:47 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id s75so7435158oih.1
        for <git@vger.kernel.org>; Sat, 05 Dec 2020 11:53:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bpaJmWqJNQ+6DkuSnN0Ra46VfprtnQPxAvNZfM5xGgY=;
        b=hDBiTdbyT4bYCd/6C15fIxOdv6kSLfTFxegY04Nm7KcXlR1l9w1r31Jkoe30/AC3cI
         78BadRhKdTwR6jn9TbB7V8PcSrYMng+sbd2e06akNgW8l+cxEpP7LwneVRowdRs+/bdH
         2NqiaHt30qfq8RwsaeKk2wv5QaR3HfpDRnd2p13onnG7APRejTCuX7O8gPKWmeJF8rjc
         Tuv+9xVgjxXO6HW9aKXcIonqqTjrJzj0RF03+JjdUj4wg/xUpPWdbJUq9xwQvAHjeiyh
         GwvoOcuCnECmemrDrcoNjZdqyL1QHvV6FmgxxAYiGUhnf1gTgVk9aSZByYA1XukHhhdj
         UIVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bpaJmWqJNQ+6DkuSnN0Ra46VfprtnQPxAvNZfM5xGgY=;
        b=LHuE0ZQaSjroVRK8DLvVJrnKFGVmDuZcnauuPe5fWB+ejc7fIqaxK+GTbzs8pOdMKU
         6dmvnRjBhyae6yQsSMNQUGx+9ac/JgGeMqejEyz7o+1Z8/omGvAC9tJVVFTxF1HfuTlL
         7MWXcrmSO4ISTvxqsALTTmhvPCgbmA94BD9IkDv+ditKh47nK9XC9z+HJYFJ/2yNxTTq
         RsRgpW+evAxcTVHTBMKk7ucydqoU/lKNilqizIDCbsEnDDxnys7Xi8UuHRvYJuQ5UL6R
         WL+M2qcOQSrzoI030p3e9dtW0O2tT19xaI+W0479AQeK+BhYh64/rE0D3tHJTJpqF8kW
         KU+g==
X-Gm-Message-State: AOAM533u49Nr17OQssQ9Zh8ADzcXh26qe+iFS9lZim1pQ0gcSwHwNc6R
        3ZF9Q0n8S29crJfS1jgdVTZtE0rfOJ47RQ==
X-Google-Smtp-Source: ABdhPJzLmCwF87z4J6TbdjrzH3mDyO/beNR6L9qrcepLBCz5UfqWGWO53U7XGS5Arq/j/VgaOj8VWA==
X-Received: by 2002:aca:bb43:: with SMTP id l64mr7266470oif.52.1607198026516;
        Sat, 05 Dec 2020 11:53:46 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id 43sm1506630otf.28.2020.12.05.11.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Dec 2020 11:53:46 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 16/16] pull: trivial memory fix
Date:   Sat,  5 Dec 2020 13:53:13 -0600
Message-Id: <20201205195313.1557473-17-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201205195313.1557473-1-felipe.contreras@gmail.com>
References: <20201205195313.1557473-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The opt_ff variable is supposed to have an allocated string (strdup), we
can't just overwrite it with a const char *.

Functionally it doesn't matter, since after this point opt_ff is never
freed, only accessed, but still...

It's better to be consistent.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/pull.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 54c58618e9..0735c77f42 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -1057,7 +1057,8 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 
 		if (can_ff) {
 			/* we can fast-forward this without invoking rebase */
-			opt_ff = "--ff-only";
+			free(opt_ff);
+			opt_ff = xstrdup_or_null("--ff-only");
 			ret = run_merge();
 		} else {
 			ret = run_rebase(&curr_head, merge_heads.oid, &rebase_fork_point);
-- 
2.29.2

