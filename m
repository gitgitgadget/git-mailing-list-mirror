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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A99C07E99
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 12:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B6DF613AA
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 12:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbhGEMf0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jul 2021 08:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbhGEMfY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jul 2021 08:35:24 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282C6C061765
        for <git@vger.kernel.org>; Mon,  5 Jul 2021 05:32:48 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 11so20616851oid.3
        for <git@vger.kernel.org>; Mon, 05 Jul 2021 05:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EXJlkMkYlqVSJ9c2kxvJ+Ii7Dm2ffiHE84wGkLqv9TI=;
        b=aTvaHjYuHqHBPk2JgE3qae+tiKc/wTXGxSzyQy2l+Fe7AD51s5Hza1SW9/gMhed2Cv
         zgjBn/Xi2rbYHN05UtjL7Ib4lDDUGRos09tJT44UHNItFjw4E0QoedWW+bB5Av0qoqoJ
         VhDHfLVYr8OfD2WlOuwtEmGP8p+i3Qii9tgWKke//nyhndHFmd8dD9Wk3bSgJFmLsI5C
         ctb7GMBruO4th8bcSr+OoPxDh+ZbJqyAwu/GO7AU2qC2b5Ew6Gdd7WoPjBvHHXFP96mo
         7JQ+5OZFRYBnDp+Sf3HcEcVt3nxN0O7Da17AbHWCVmsxSsUkpxC+WZNvqQs3zyod+Atv
         Q5BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EXJlkMkYlqVSJ9c2kxvJ+Ii7Dm2ffiHE84wGkLqv9TI=;
        b=dP22CBjFwS0cICrF8R8ByVsi0mVpoWgMHhUUHLfaY+s4LgE1Iasndy45eWVj0my72G
         bFKXXU0G8SoskFBeDULNJI+6SvzZPJOol/BQ9eiQ27FoP+Vc50GYq9tzYbVL1sB58KFp
         +onmWaL2QT2CguSpTsZ0qH+AqHwA1XmI9HzDpXARsDSKm5fO0PXqzyPe2T3gAi9NhJi5
         /ShR2+DTdA2w2cbvTMbVFRCxeQcEMGDeEpcYtWfM0jLTstmZchTz7L2N3uiiqAQHZ3/h
         ZZCiG1WzIaGAbUpFa9AZzwY/3pv6jENsl7/dA4pQK37AF1EWdOhuxwJU8db35ek7qSo8
         w8lw==
X-Gm-Message-State: AOAM533yayg6ZQpfrbom4wia0e5iig0TxnU/wsgrE5/5jKW9KKsKU8wQ
        PEkTxQsV/1kRd1J+qthIyWzgZjMtbUFrIA==
X-Google-Smtp-Source: ABdhPJzo5GUlAIfcY/GfEk/sT5GdY3PAw1UJsUu3q8S1RCXOodEXTEbvo/GWnwXJHRwb39Kw3sCEMQ==
X-Received: by 2002:aca:3147:: with SMTP id x68mr10130303oix.126.1625488367354;
        Mon, 05 Jul 2021 05:32:47 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id 59sm2600548oto.3.2021.07.05.05.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 05:32:46 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Richard Hansen <rhansen@rhansen.org>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC PATCH 21/35] pull: trivial whitespace style fix
Date:   Mon,  5 Jul 2021 07:31:55 -0500
Message-Id: <20210705123209.1808663-22-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.36.g70aac2b1aa
In-Reply-To: <20210705123209.1808663-1-felipe.contreras@gmail.com>
References: <20210705123209.1808663-1-felipe.contreras@gmail.com>
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
2.32.0.36.g70aac2b1aa

