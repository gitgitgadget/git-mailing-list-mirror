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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA39C4361B
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 00:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AAC423A04
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 00:28:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbgLHA2Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 19:28:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728656AbgLHA2P (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 19:28:15 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1BBBC0611C5
        for <git@vger.kernel.org>; Mon,  7 Dec 2020 16:27:04 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id q25so2559516otn.10
        for <git@vger.kernel.org>; Mon, 07 Dec 2020 16:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M4mcn83DsMB5yCouEjda20f4zIKR9PizsgSx6M/zUz8=;
        b=M0fKvmEmqq/b39/N8D23K6mv3StzF/lCLq56DhoQuDfo38VuNQnS/FFyrNT9g75VML
         8zmoOpvP8y7REk3e806dCFkHo9EqDowWHGf/fzl1mpvq0g39on+y8EzAdjWyf0n5k10o
         IUBERqscDC8+7js0ZbmIy7oAyfHfeXUnWK8T8Fz1/ssMFl+C1PmuWO29dKrgIpopuLbW
         hJ5TbBGSHOq+iSDFC/gNUYEh7HujFU/noaZ7o2gE1t8JsLFQLCxSJScgGkuePApyOK+V
         BZeJImlqnft7LsVBOa7qgIm/oqkdHQcyOEm9qH/LlgEiluj44OmBKIMJ7wux8K52mtsK
         hcsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M4mcn83DsMB5yCouEjda20f4zIKR9PizsgSx6M/zUz8=;
        b=p04ca/BTfUr6fqfrL7CBL+509u9Rp7Hp6q2vNwe7U3xpmlKxf1xeifLTJQLvec0/Ao
         EgFSI3TA1A2qxH30etOU+3xK1MJ2wjmhhsNo1f2W3VNyyRfnfwR3Gb/bfPqmGoRYhPz1
         01Tm7v18yi61RYAN+Q4k3SNU9HPcv7CgxsE2j56qoBpdeVq6VpyqCliP4CwwtN5UGyL6
         eZnbulONbt7Nho4ipl0metNBiGeMTWOnM5HxndpiweTPsXSv5aZcq8MbGsLfWA/PEWdE
         PNSy54mYwSm6q5ztSuMJwWVojsnSlSf+K78SIrv0JKMzISQzVIaGiTieKSW94zxjtBOP
         uVog==
X-Gm-Message-State: AOAM533nKA8iKf4ynUYdmNZJHPOD42Kfw7zxElqtfUY9DLYPOKqN63/9
        evAKfTHgLS09k/n6WEGV2au7dDNXV/UuhE84
X-Google-Smtp-Source: ABdhPJxJH9VSQDb4uHEOhrxeVKVjIRQb/oNTySW42YXDif9E0dn90xIx3mFA9cSVoQ2gZvuQwWo6eg==
X-Received: by 2002:a9d:64da:: with SMTP id n26mr767821otl.283.1607387223872;
        Mon, 07 Dec 2020 16:27:03 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id c18sm3158125oib.31.2020.12.07.16.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 16:27:03 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 08/19] pull: trivial whitespace style fix
Date:   Mon,  7 Dec 2020 18:26:37 -0600
Message-Id: <20201208002648.1370414-9-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201208002648.1370414-1-felipe.contreras@gmail.com>
References: <20201208002648.1370414-1-felipe.contreras@gmail.com>
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
index ab410d675f..4c91dd291b 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -128,9 +128,9 @@ static struct option pull_options[] = {
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
2.29.2

