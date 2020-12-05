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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72824C19437
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 19:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4788F22DBF
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 19:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgLETyL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Dec 2020 14:54:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgLETyJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Dec 2020 14:54:09 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E977C061A54
        for <git@vger.kernel.org>; Sat,  5 Dec 2020 11:53:24 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id w3so8102755otp.13
        for <git@vger.kernel.org>; Sat, 05 Dec 2020 11:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gEPr2/OPjoqlViE//B8E+wSUc/C0xsTCHmfwsNHnVOM=;
        b=e5z2u0WZxF6KGZN2DjvElT2jjq6XIEumcbvCarMOssozjZdpdzFBpZC1k7ZGJSUI26
         0dDah5MkUqMZMB2KXFKiPefsOLebVffWJ/395GNDro3k4rLyXxFse0uYrwrv+51j8py5
         EIWWwDzy8rWq82FQL8YtT79GH+3I+V1na+7vKC4/xOJEZyZLYYjhjq0s2o530v2xSokd
         4dSJSVdrJc9kFNQx854HqMLraf/r/X4SahoCyk0U1QLEFE3QCt6b4x5MA0juiATwK8tV
         xBluPqFf3ggxFMN57W5pJ6IT1kI5y1cvU7HouIhNI5tFogb5rq5hXPkP96tzHsbuecw5
         SD1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gEPr2/OPjoqlViE//B8E+wSUc/C0xsTCHmfwsNHnVOM=;
        b=O7HB5v1WFePhUCn62uj7RoIrVCC3v+FDC10F+ScMFKOPwfWxfhnvsebL/RboLhZRQl
         xG44SjW0PPozTxogzNDhLThjpmr4djUJma7BYTkShmgjwJ+B+PSHlA5kNam40RyVoSqK
         xg1U3ncSZZYrM91E1ZCcF+vss7bw4F7bscCkl3mQZ5CHZBVQjYxChQoXDOkx6ZMJydNr
         d01+aWSO//NB4PiG1cyQDn9hHpae3AzyAEZezJB4O87FZ/dGLjYMPe0Oz+LtYzP9M6dD
         JC/GiN/KTpmsW12KO67gOpJdLZLbTxGj0zh9RH4p6jrXqqwrb3pP8h3JboCa/gaI4oi9
         4xXw==
X-Gm-Message-State: AOAM532LLaIZrZ7YJNB+U+ZqBDWlRZK699bN8bZwlL9kQinw9OHH+Q+x
        Ve2/+YO3h6x+3CHbe13Cit5kwxv+2ypwzQ==
X-Google-Smtp-Source: ABdhPJyLC7GGgKntYVJ3+40BtmUEJbekcI4C4ntoWAUu7csiOqBrFSt/V9U7qEvNy9F7uP5lmpUIoA==
X-Received: by 2002:a9d:38e:: with SMTP id f14mr8202467otf.176.1607198003580;
        Sat, 05 Dec 2020 11:53:23 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id u66sm1503971otb.48.2020.12.05.11.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Dec 2020 11:53:23 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 05/16] pull: trivial cleanup
Date:   Sat,  5 Dec 2020 13:53:02 -0600
Message-Id: <20201205195313.1557473-6-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201205195313.1557473-1-felipe.contreras@gmail.com>
References: <20201205195313.1557473-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's no need to store ran_ff. Now it's obvious from the conditionals.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/pull.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index d2f80e8615..feadded1b6 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -1024,19 +1024,18 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 
 	if (opt_rebase) {
 		int ret = 0;
-		int ran_ff = 0;
 		if ((recurse_submodules == RECURSE_SUBMODULES_ON ||
 		     recurse_submodules == RECURSE_SUBMODULES_ON_DEMAND) &&
 		    submodule_touches_in_range(the_repository, &rebase_fork_point, &curr_head))
 			die(_("cannot rebase with locally recorded submodule modifications"));
+
 		if (get_can_ff(&orig_head, &merge_heads.oid[0])) {
 			/* we can fast-forward this without invoking rebase */
 			opt_ff = "--ff-only";
-			ran_ff = 1;
 			ret = run_merge();
-		}
-		if (!ran_ff)
+		} else {
 			ret = run_rebase(&curr_head, merge_heads.oid, &rebase_fork_point);
+		}
 
 		if (!ret && (recurse_submodules == RECURSE_SUBMODULES_ON ||
 			     recurse_submodules == RECURSE_SUBMODULES_ON_DEMAND))
-- 
2.29.2

