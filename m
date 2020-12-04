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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D0E7C433FE
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 06:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E058922583
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 06:17:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbgLDGRw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 01:17:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgLDGRv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 01:17:51 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E58EC08E85E
        for <git@vger.kernel.org>; Thu,  3 Dec 2020 22:16:40 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id w3so3570465otp.13
        for <git@vger.kernel.org>; Thu, 03 Dec 2020 22:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oezrrA3ark1Rsun3Yi2/SRG7RZyrFaHuyx7ajAhhqkg=;
        b=i0/eUKUDzWTnSVPyv3yA7424RHpwZzfYjsALB7fxiwn6CACeD0D0wP06NQoCuHBdDp
         7ednfPZZwLJSitgBUmFcvdEomsnb7cxl+emrx4V7COBYjnXm2TURl0P7R5/oC8bbSlCh
         XxBd2hVNUEDfgYKaRYGTEPvI81+S079ep42nEHG8KV/Hy/+KwPK3MahXiaNC/nOQxvt+
         d+5TrymZcvmwkjDsQZYGdO7EjwLDsnTURZgidhZUOmBaQcCY3kELwgSdtUR8zCN1V0aV
         +ztGTVSbO20nbwR4rrXsv0jdAdkamLELIbQ5Pqlt6eU+duurqHQ+4eWvM65RnC5Oqaqq
         VnYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oezrrA3ark1Rsun3Yi2/SRG7RZyrFaHuyx7ajAhhqkg=;
        b=oXEDB1aYg4I7zdxYLtiEf4zXhKVWe9Z5nyAedFcxlqovrLIddsvAp13e9xpweVxaqk
         lQdk1mK3oWHwCvEoLoc6to6+/ktKGal2fLcyvOF2ZRDTDUGSqz6lhsUNb44XVXQ+aEgQ
         d97FE9IEPVCRn6Ee8DqQypIeFwGVlRpRZpFrO4JdyOD7PYh6EscZy++y/RXmL/tIr33v
         B4+VMny6sp7OQLFD50jOtMxRZRWvEYTt9Q/oeJ4xJkoSa+uNQPPQxHDMuX67XwQSS9by
         E86LUIogxPHIMeiND9RDr/w0w+LG1p72aFLa2bhJf1JkPpYaTSMb6RGfN0o7P6m3j3ww
         zhyQ==
X-Gm-Message-State: AOAM533fCQWOlQNYVBN7YB6hSrPZCz8dxnPQ18JVscQ/b6RKpDQ/HKb/
        kK8VGBiIFJWM44baE4fdbT2pdq/8UqGJkw==
X-Google-Smtp-Source: ABdhPJy0b+hNAya5sHT+Zi69Tuq9gyLxijeeA4N0KEUF9ik0+3/TnweyFUmdO4FFS+r/aohTQJKEGw==
X-Received: by 2002:a05:6830:104f:: with SMTP id b15mr2491916otp.20.1607062599669;
        Thu, 03 Dec 2020 22:16:39 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id r12sm461493ooo.25.2020.12.03.22.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 22:16:39 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?V=C3=ADt=20Ondruch?= <vondruch@redhat.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jacob Keller <jacob.keller@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        John Keeping <john@keeping.me.uk>,
        Richard Hansen <rhansen@rhansen.org>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        "W. Trevor King" <wking@tremily.us>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 08/14] pull: trivial whitespace style fix
Date:   Fri,  4 Dec 2020 00:16:17 -0600
Message-Id: <20201204061623.1170745-9-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201204061623.1170745-1-felipe.contreras@gmail.com>
References: <20201204061623.1170745-1-felipe.contreras@gmail.com>
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
index f0b1c6bfea..b200f7544c 100644
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

