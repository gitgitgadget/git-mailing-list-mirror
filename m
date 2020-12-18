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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D70C9C3526C
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 21:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A998723B8C
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 21:11:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbgLRVLR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 16:11:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbgLRVLR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 16:11:17 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C57B7C061257
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 13:10:36 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id q25so3220221otn.10
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 13:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Lsl+sWriWCYORJvslnQcUmwMhoPI7rKMRcrlo3RHonk=;
        b=D3brVgX3PPiTUNBUIAdxzNtTC9zT0Z12DvTrr7q/C28nde17jOWzLjHbaJdcO9JO9W
         TdSJylr1dvS1vvAwBAYOvfWaHxGEalCjs7p0LRK3fXxNFrSFKB/HbxaxbSX0tbWqjLiE
         /M8OjY4uQ/HrHzyyVi9lI+Yq0RthrSyF6pJGGpIk+QcqGfLOaJ0UWjiwwEXhxdNytYfW
         py8hKIq+vJNdWKCQ+MJ/sRJdxkM/TOC2OpuZ7a4kCikRUd0H7L5FsHrOuzmd5dYhTZya
         K/kilhRMyEcGNirurtyHNU3ykaOYEWWRud9SBHbpdvqgOCflqAQ0UBdH6F5cb3Kbafxg
         tJPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lsl+sWriWCYORJvslnQcUmwMhoPI7rKMRcrlo3RHonk=;
        b=YXtfeg+exhhAzzyWuoG/OJepJ356JqgTwuzLxqGPyA793HuE8IS5v2nAjlB8gZWrL2
         mxkRqcl7ByM52Qr1piGymv4e1pKdPz7NBTPxh2qZYuq6bxL5aMj3Vo3LNb42SpKYlrZn
         /G1Xd0Sve7ZKQV6rXsPytm0LLxIWf9utFJlYf1xqQ3AX9/tD8tPopO/UAR/h3CqYS79c
         wozAKL1JXe2UksxHpXSljIhRKfOf373jHByMjjUuH8uevTuLXtIZNpeGAV3WPbQM9s/A
         Cn5hiSgFXvKuslAgIQmC+HpSCp2GlZ3xKFZkJh88VfBcrK21smimEROkTy5JhgBuOVO/
         3W5Q==
X-Gm-Message-State: AOAM5337GawJ0GftNsUOK7KJIDRcsD5YD/EovBo2+NYgZt2nLEfQI82k
        eqRR4QOZAgYTYJ80Swf95DeogXSybV/lTQ==
X-Google-Smtp-Source: ABdhPJx1hAwNfc8XKetJ/aPu4ImPU40gMc5bfvYR/B8LelUR7LbF3xQ8TLHOSeUhWbC5xssOFsbUAA==
X-Received: by 2002:a9d:12d7:: with SMTP id g81mr4374038otg.103.1608325836047;
        Fri, 18 Dec 2020 13:10:36 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id h7sm2146104otq.21.2020.12.18.13.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 13:10:35 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 05/13] pull: trivial whitespace style fix
Date:   Fri, 18 Dec 2020 15:10:18 -0600
Message-Id: <20201218211026.1937168-6-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.30.0.rc0
In-Reply-To: <20201218211026.1937168-1-felipe.contreras@gmail.com>
References: <20201218211026.1937168-1-felipe.contreras@gmail.com>
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
index 21089e5a29..48e25a5061 100644
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
2.30.0.rc0

