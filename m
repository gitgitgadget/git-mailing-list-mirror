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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84442C2B9F4
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 17:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63786611C0
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 17:19:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235422AbhFNRVU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 13:21:20 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:38437 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235518AbhFNRVS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 13:21:18 -0400
Received: by mail-wr1-f47.google.com with SMTP id c9so15346215wrt.5
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 10:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xCjpoe9JYD/RtIQV0nMJL+iN3fXOGBcF6u+Av2YkRqM=;
        b=ebW+ZV++5uLYp1RhGP5FX/YeUPcqhtjYDBYiCm9vcjTizjbLn0jvTRJub8PcjCmWtQ
         eiDCem+eVaj0Hq3KCWcCVoZKturw6FRmVq8nowYbA9g+vRDyVqJ8mhZY4J+7qw7UZG92
         eK08cNlMPGg8yJCuj2DvO0pXtkOD3eVduYqN/+DSH8s4eHpXPthLk1KHvtWf1M7f8kRT
         /gP09Q/+Jy/rOaTGX4Z9HN4yGhDCYAeKVQqqUtgS4YcAixFzfR8Y+UUAWbx8j1VXz/W3
         geeWS5ql+HfslkLxrloNSeuNdow6nnvN8tiRwL6kpQSJj32I+JxvWSeItthmZ3rWDm2l
         bvKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xCjpoe9JYD/RtIQV0nMJL+iN3fXOGBcF6u+Av2YkRqM=;
        b=Jzf/3V40NtkVaXCVSrBBeeG4s6EJzxGjcyDcP9j8TF7VCqAMD21CWhQIjbAJgRjIPS
         WKDtEfh4RI65NqEbzrybeIhaE9FhcNaWakVmen+W+GeUxuIwkiHibwz0ilvs/lR81Wij
         0GabHJhwb42tIg+sHhxPrOwFf+Yc2NkJBqsLBZZ9iCc6nkekOudAAys1V7ZG1jCpVXcy
         xjyuK07s8DGlqghJ5LyInV+3NTOZBIiB3I4TuQrLRHBwn72HS97XZWsSpJ/VaPVxhQ0k
         nHgPTRss2wimSDfi2ZiFQXgeNRNfViXZf8h2WdqoYdpON6eHS8RafwIEssk0htGZEAgi
         S6tA==
X-Gm-Message-State: AOAM532gMmnyplPjxe/vh0cwqbvXYw0hB8sbmwlsBKAJlGVxYCMz7CaE
        /EYlWOvspXxVEhIiaPZO58YP4c+kfJ9qTQ==
X-Google-Smtp-Source: ABdhPJzV7xyxKpscBOpr+J+acRWLye2yap36nU+m6Nyy5BI0Yoxa6dMH29IitNL3w5NSnIXnrsJtEA==
X-Received: by 2002:adf:fb92:: with SMTP id a18mr19721068wrr.182.1623691094381;
        Mon, 14 Jun 2021 10:18:14 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i6sm83816wmb.15.2021.06.14.10.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 10:18:13 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Michael J Gruber <git@grubix.eu>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/4] show-branch tests: rename the one "show-branch" test file
Date:   Mon, 14 Jun 2021 19:18:07 +0200
Message-Id: <patch-1.4-7b8ac433392-20210614T171626Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.555.g0268d380f7b
In-Reply-To: <cover-0.4-00000000000-20210614T171626Z-avarab@gmail.com>
References: <cover-0.4-00000000000-20210614T171626Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename the only *show-branch* test file to indicate that more tests
belong it in than just the one-off octopus test it now contains.

The test was initially added in ce567d1867a (Add test to show that
show-branch misses out the 8th column, 2008-07-23) and
11ee57bc4c4 (sort_in_topological_order(): avoid setting a commit flag,
2008-07-23). Those two add almost the same content, one with a
test_expect_success and the other a test_expect_failure (a bug being
tested for was fixed on one of the branches).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/{t3202-show-branch-octopus.sh => t3202-show-branch.sh} | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename t/{t3202-show-branch-octopus.sh => t3202-show-branch.sh} (95%)

diff --git a/t/t3202-show-branch-octopus.sh b/t/t3202-show-branch.sh
similarity index 95%
rename from t/t3202-show-branch-octopus.sh
rename to t/t3202-show-branch.sh
index 5cb0126cfed..8cfbbf79c1b 100755
--- a/t/t3202-show-branch-octopus.sh
+++ b/t/t3202-show-branch.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-test_description='test show-branch with more than 8 heads'
+test_description='test show-branch'
 
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
-- 
2.32.0.555.g0268d380f7b

