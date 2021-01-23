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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF337C4332B
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 15:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEF92233E2
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 15:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbhAWPmq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jan 2021 10:42:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbhAWPmd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jan 2021 10:42:33 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46317C061793
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 07:41:52 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id b5so7943030wrr.10
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 07:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N7d5BGUMfOz9eoLoj7vSUfg3JBwXSYyJWhNUg/355mQ=;
        b=ZYyg19vv2UWxvTGe6QhvehkryvrfTqGBPOU465ReNnSTAjHYQ8/4kSaxjQlOFvXsyQ
         PJzHQefQ82wpXu3IHHG1tXAuDl6/kuRSvPfpFThklG9JX8H5ke0u1dhxdjdB3TK/5PwW
         dOuWmV6o6nEU7PBCuIHVhuZ4QtBYCJ5MYb9mZC+6rAOeAi99SnGHuQ4rRwhSxaYk61of
         yHlBpjhybhe/URmyOq0nDCNgeMPtuwzXrVO+ikDhd0AMu4iiLzwLcfAO+S8+0e17QD35
         bDdzFvxlO3CsHxatIrMqoCShzRwHr859dm9VCFNEqTptVji52xDsXj0F7xklsa0P+q01
         w1/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N7d5BGUMfOz9eoLoj7vSUfg3JBwXSYyJWhNUg/355mQ=;
        b=K5BQH/8FXTEkT3WN5noMADT6AZDrYgaxFDy526kYRmoXEfjDV2VLpWh3ht+g3CZBOn
         /sbSX2X49A/NtxRzIdqmn3+jtwtVtk/snOIzqh83kSU+CYeyQtK2+7Jd+pWYvE2MOIjU
         WTihgokQ0ex/8zr95I9WskQyJSTuub04SxARIoBMMZL9jCpRMamlvXwncQgHvRHqU8rs
         BFPMUx9WB3uRcmV2NkkjKafAPFJN3RpWuwj8qQf89Qo/038j94O7ZBmEmjz3SMx8H2hB
         2RtpS5PNq+yfoB5jIJTsK2ofrxL4FuMHIqNB87As8Vg7VTYsClxggi+bt8yKQu+VPwjO
         lrtQ==
X-Gm-Message-State: AOAM5307sPSa43PygmNvZqyBC/Vrtz9rReqL2aB3kA++TNQlOZc0Pd+i
        Nagb9TIsfbGbijZ0M0shYbWhjRf629I=
X-Google-Smtp-Source: ABdhPJy9eS4c9kmJSdecLLriLuHkcnosNQWcziUirgrZDQg9tp39OFzdHUclfxONPVvozWyz0Eeq9w==
X-Received: by 2002:a05:6000:2cf:: with SMTP id o15mr1059064wry.184.1611416511104;
        Sat, 23 Jan 2021 07:41:51 -0800 (PST)
Received: from localhost.localdomain ([81.0.50.72])
        by smtp.gmail.com with ESMTPSA id o8sm16772353wrm.17.2021.01.23.07.41.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Jan 2021 07:41:50 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v3 4/7] bisect--helper: use `res` instead of return in BISECT_RESET case option
Date:   Sat, 23 Jan 2021 16:40:53 +0100
Message-Id: <20210123154056.48234-5-mirucam@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210123154056.48234-1-mirucam@gmail.com>
References: <20210123154056.48234-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Pranit Bauva <pranit.bauva@gmail.com>

Use `res` variable to store `bisect_reset()` output in BISECT_RESET
case option to make bisect--helper.c more consistent.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 builtin/bisect--helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 1f731167f6..1ce0399ad4 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -1042,7 +1042,7 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	case BISECT_RESET:
 		if (argc > 1)
 			return error(_("--bisect-reset requires either no argument or a commit"));
-		return !!bisect_reset(argc ? argv[0] : NULL);
+		res = bisect_reset(argc ? argv[0] : NULL);
 		break;
 	case CHECK_AND_SET_TERMS:
 		if (argc != 3)
-- 
2.29.2

