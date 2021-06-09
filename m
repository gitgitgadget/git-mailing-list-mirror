Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 426BAC48BCD
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 13:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 287DA61285
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 13:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236882AbhFIN4u (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 09:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236881AbhFIN4t (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 09:56:49 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E785C06175F
        for <git@vger.kernel.org>; Wed,  9 Jun 2021 06:54:43 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 3-20020a05600c0243b029019f2f9b2b8aso4284850wmj.2
        for <git@vger.kernel.org>; Wed, 09 Jun 2021 06:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rlU16Argot/ypcOGcNIltKha5884Rr4csMMq3SHgObo=;
        b=sv3/gtnZjC9Y0Y7WiKAF7x1pd1uTNHlptp2FzYqix/GJgbtbGLikTQDtRp5l43S0xL
         nNOVOHzBzO9o8tlSfVUMfckQwN6147+pafVkLuuJiq3kOUWYbIIq73lyMzlC4Ux4W3TU
         5PPTIgSfxHRoKkv1MD6IW6nofiQL2B2STL0an+aWjNu16GbmDg5/yrm3XlXFPkeHj5yp
         32cfREfFqRIQGBn1t59saOujJRuwLmtVxsZk+2gKsPbepxEoJMilcDEo8E35nJsWvNvz
         EjD5Zgr4E2VPD6wd2U9U/y01COTQO3VbTd1G23Wy/KRUaERQeDSCDYHpMhuOdGWSfRTN
         sv6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rlU16Argot/ypcOGcNIltKha5884Rr4csMMq3SHgObo=;
        b=fRG6ejRR7MbFoDKMBHtz78R6J86GzoLe+EHSPgTXgzwIVYjCx5egAk37GUrEHb3HkM
         xS/fzs2TXlqidPp/kwHJ0h5DMH8goXaEEXxH2LypL4r7bWKFh5gXLxaQ5BGN54mACIxi
         keTtJq9T0D1Bfdu+LmLbtHm1m032L+Tetw0UJCxcOENJnFlGYwkk9xYJz+75chWgc9Rs
         cDYMZnhqQ5wuCuyluwtDjisgk91YYmfoOz+qSyTOtYcla7OZLsaqk2N8uU7a7bPOXWgY
         uuKzsw5JuZOYUaxaB+Z33IFCdbrBAWa8ay/twmQq03MLy9P8aIpRqT7r/OzrfuJS1Ov2
         1pqg==
X-Gm-Message-State: AOAM533PvyE3BJNAMiivmTU7nVYehMkmTesqyWmUBQjYfKiZLl8o9IwI
        /Y/uIgjxuxIC8e7LQoWRv0g8m9DflMI=
X-Google-Smtp-Source: ABdhPJyJL5qNOMQhszOoTZZMiRobvcu4yEn4s1svClLIsbse8OyU2+o/ZU4+jSI8ZLBpxKrpity08Q==
X-Received: by 2002:a05:600c:410a:: with SMTP id j10mr9702916wmi.6.1623246882130;
        Wed, 09 Jun 2021 06:54:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i21sm6235289wmq.12.2021.06.09.06.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 06:54:41 -0700 (PDT)
Message-Id: <feecbd7a0c6e3f974e0a0b5e04c84304107f1fab.1623246879.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.975.v2.git.1623246878.gitgitgadget@gmail.com>
References: <pull.975.git.1623085069.gitgitgadget@gmail.com>
        <pull.975.v2.git.1623246878.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 09 Jun 2021 13:54:37 +0000
Subject: [PATCH v2 3/4] *: fix typos
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sandals@crustytoothpaste.net, stolee@gmail.com,
        jrnieder@gmail.com, emilyshaffer@google.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Andrei Rybak <rybak.a.v@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Robert Karszniewicz <avoidr@posteo.de>,
        Jeff King <peff@peff.net>,
        "Kerry, Richard" <richard.kerry@atos.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

These typos were found while searching the codebase for gendered
pronouns.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 config.c               | 2 +-
 t/t9300-fast-import.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/config.c b/config.c
index f9c400ad3062..7bb96f8f7124 100644
--- a/config.c
+++ b/config.c
@@ -2837,7 +2837,7 @@ static void maybe_remove_section(struct config_store_data *store,
 	begin = store->parsed[i].begin;
 
 	/*
-	 * Next, make sure that we are removing he last key(s) in the section,
+	 * Next, make sure that we are removing the last key(s) in the section,
 	 * and that there are no comments that are possibly about the current
 	 * section.
 	 */
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 5c47ac4465cb..7039b5c6028d 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -1538,7 +1538,7 @@ test_expect_success 'O: comments are all skipped' '
 	commit refs/heads/O1
 	# -- ignore all of this text
 	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-	# $GIT_COMMITTER_NAME has inserted here for his benefit.
+	# $GIT_COMMITTER_NAME has inserted here for this benefit.
 	data <<COMMIT
 	dirty directory copy
 	COMMIT
-- 
gitgitgadget

