Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5856AC433E0
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 21:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F0942072E
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 21:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SMas2+UH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbgFJVTp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 17:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbgFJVTn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 17:19:43 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8959EC03E96B
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 14:19:42 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id c3so3903947wru.12
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 14:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cdxXOL6g6SoE1kibmxCg/3drSW0ta8hvQDe80NRLebQ=;
        b=SMas2+UHodbKIQg3rYDYKqPTGSd6x8aG15Zy06qc7ZmGtWL73NggCc/XzOqz8BjPMG
         7M503RCES2H3QAYC1pDEYRThFGhVuqzHgrADt6X8RmW2tWZvYQA/c9416J7SyZFLNlFx
         AQxT6GdbY4yyi283bq+IybwxdiiEFJCWRvEXGMGv68l5QM8j3m8Oth9rJl/de9ZGiPPF
         Bj+qwq98CRp+b2fS1OOzW/33cpr99ZLnDhIP/rbBBoNjxh62WqKCXw8LHRw9DvCA5NYW
         LjFHGMF6LmEGEP9Lt8rn/sRMwD5LfsARWB6nyDNRHb0yK7uNK0f80q36iFLB6RU/VyVg
         PYuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=cdxXOL6g6SoE1kibmxCg/3drSW0ta8hvQDe80NRLebQ=;
        b=N0vEDV3wVxdjwbAZLv9yPnG9X2A+fLHdHFBx4Czy31go9Y6ICqoyi6zsk4FoQWZpbL
         lhgeP/v6k6kEQNV5yhYmB/7wTZ886u3E7ycdCY4nw5tBFvJ38ocijCcwyaIjFLdqRlrI
         9ycjMIsWZ6OpfTe2N/UkZjtWIPYXLXR9Z2LlYpmrcyxqOuCypljZWlH4V0PGj/yau9yp
         mjGKmXcelOo35GzztbmpdZmi0sOsnhXWk30rWvqQP7d0gj+bjUcICBbi3RmM7yS4NnCk
         qxp+u5weVj9GnY2qXI9Fjpi+KZ99CxF5D2Bq8m7vEc6znsWkaBuAsomauQ/b5Q/YcfEi
         H/+w==
X-Gm-Message-State: AOAM533X0a3ijf8fKYNMQIpQ6LIYRV04ziWHq/Cp1ZQlZd/FYqGtuZih
        LyivxxPg+b6KUjbous1r6pTVkphC
X-Google-Smtp-Source: ABdhPJyZEZRyBKEiKWwvihwy7nBT1EtZHrblvNaJF/Wx8uyMYfFBX/K2esDONNUp068MjHldu3MSmg==
X-Received: by 2002:a5d:4009:: with SMTP id n9mr5443037wrp.97.1591823981138;
        Wed, 10 Jun 2020 14:19:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y17sm1628807wrn.12.2020.06.10.14.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 14:19:40 -0700 (PDT)
Message-Id: <f680e66dd6ddfc5294d04ddd11d4b2bd4ec1520c.1591823971.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.656.git.1591823971.gitgitgadget@gmail.com>
References: <pull.656.git.1591823971.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 10 Jun 2020 21:19:30 +0000
Subject: [PATCH 9/9] Document how the default branch name can be overridden
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     don@goodman-wilson.com, stolee@gmail.com, peff@peff.net,
        sandals@crustytoothpaste.net,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

There is a `GIT_TEST_*` environment variable and a `core.` config
setting (with the former taking precendence over the latter) to allow
overriding what name Git uses by default as main branch of new
repositories.

Now that all kinds of Git operations have learned to respect those,
let's document them.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/config/core.txt | 4 ++++
 t/README                      | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index 74619a9c03b..a11e1abdf59 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -626,3 +626,7 @@ core.abbrev::
 	in your repository, which hopefully is enough for
 	abbreviated object names to stay unique for some time.
 	The minimum length is 4.
+
+core.defaultBranchName::
+	Allows overriding the default branch name e.g. when initializing
+	a new repository or when cloning an empty repository.
diff --git a/t/README b/t/README
index cf863837ab9..b32f520a27f 100644
--- a/t/README
+++ b/t/README
@@ -421,6 +421,10 @@ GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=<boolean>, when true (which is
 the default when running tests), errors out when an abbreviated option
 is used.
 
+GIT_TEST_DEFAULT_BRANCH_NAME allows overriding the default branch name
+that is used for example when initializing new repositories, or when
+cloning a repository that has no branches yet.
+
 Naming Tests
 ------------
 
-- 
gitgitgadget
