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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15690C48BDF
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 04:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C413C611B0
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 04:59:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbhFMFB5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Jun 2021 01:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbhFMFB5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Jun 2021 01:01:57 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0535FC0617AF
        for <git@vger.kernel.org>; Sat, 12 Jun 2021 21:59:57 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 5-20020a9d01050000b02903c700c45721so7481004otu.6
        for <git@vger.kernel.org>; Sat, 12 Jun 2021 21:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vuoDBBZDUEBUj/UnRKf0FOhatbeeX6da52mTvAVLt6Y=;
        b=riP4F5XjB1f+FxGhoCoK0u6fIuyLigtmBfKKglbaukPcz7FhS12QEUAR3vy8uuVqeP
         gV1JT94MglsmlrS/A4qqziVj/3a+GgoVvwVlKb2QUieh+tq5vGjGqe1LCfbHOL6JBjze
         yUCTiZesWuUIPsuIYCV4DpysU+JQY9w06YAMz4DU+ry4w2GBSUQNque4/1zNf5CVWjmd
         XfSARGwu4pIisWGN84zHYZFK+KLZr3qaXltNfc5OUseApyR+5eb+zoT85JLqHy5R+JZ4
         qrFgo3kNgelGPKWQV01IcnqPLFs/sCdqsNar46b3+yDAcftkGGpT25gDDcbKR233/CwH
         hlEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vuoDBBZDUEBUj/UnRKf0FOhatbeeX6da52mTvAVLt6Y=;
        b=eWltjZcBUwRN3HHZlPk8wwc4qQmMzbY+KnOgLhNW3IJU0vynogcJTABRySXLTqpMEq
         p/OF/x8kZXWtVHqogg+UhfGGF/UOJ03+IrX/y0qE1qEiutFp2lifqzu4ogUfpc0JbuXL
         z+pPI4Ze4PoLLSDXB1MWXEYmOHsRv8K7odMsB8w/SfVFXz6lJM2IlPHRtJR8tICNAhEY
         ARifgxq/I49kx3vhcWEkwZw5N8JhdmRJ3KjfyhKLUuwtFmyYsgRyk2w9yKhqIj/v+VEb
         BBRus3/O9WYKOX0MFyjopb6EQZv9owMsnCXkrbwzSkOG6IIablSPLQTc+x60J3Xo2DVy
         ngYw==
X-Gm-Message-State: AOAM530Nm4lnW6VwEcx7mD8RkH9E6dxVO2QiMXUzeG9D7Ia9d+aDeFX4
        TgvTHTQ7dJ0Vj0FlQXH8Or5qJ7q8DR3PHQ==
X-Google-Smtp-Source: ABdhPJy4Y0poi8BcIglqc5G4GMmV3zeojJdTY5en17wxlGJDsrV8PoDQvdIsWsFjss+pCYrnr87FLA==
X-Received: by 2002:a05:6830:923:: with SMTP id v35mr8822731ott.358.1623560396206;
        Sat, 12 Jun 2021 21:59:56 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id u1sm2214171ooo.18.2021.06.12.21.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jun 2021 21:59:55 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 3/3] pull: trivial whitespace style fix
Date:   Sat, 12 Jun 2021 23:59:49 -0500
Message-Id: <20210613045949.255090-4-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210613045949.255090-1-felipe.contreras@gmail.com>
References: <20210613045949.255090-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Two spaces unaligned to anything is not part of the coding-style. A
single tab is.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/pull.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 80e2f55cbc..3e13f81084 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -126,9 +126,9 @@ static struct option pull_options[] = {
 	/* Options passed to git-merge or git-rebase */
 	OPT_GROUP(N_("Options related to merging")),
 	OPT_CALLBACK_F('r', "rebase", &opt_rebase,
-	  "(false|true|merges|preserve|interactive)",
-	  N_("incorporate changes by rebasing rather than merging"),
-	  PARSE_OPT_OPTARG, parse_opt_rebase),
+		"(false|true|merges|preserve|interactive)",
+		N_("incorporate changes by rebasing rather than merging"),
+		PARSE_OPT_OPTARG, parse_opt_rebase),
 	OPT_PASSTHRU('n', NULL, &opt_diffstat, NULL,
 		N_("do not show a diffstat at the end of the merge"),
 		PARSE_OPT_NOARG | PARSE_OPT_NONEG),
-- 
2.32.0

