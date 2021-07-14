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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D09C07E95
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 01:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14F0E61380
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 01:12:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237301AbhGNBP2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 21:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237198AbhGNBP2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 21:15:28 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB325C0613DD
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 18:12:36 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id o30-20020a05600c511eb029022e0571d1a0so338945wms.5
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 18:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Om/ov8t+sbeiVrF95ZC6c1SOeL+sOEfF1lt5KPa62hQ=;
        b=RGsWL4E47mRgRMi7W45wdjyo+Eu1P1Nuw0s4+AlOCSqSZf2Ulv2NV5NpgTM+5yI5WV
         dZjGonQVpl57CMiKHaa3GSlOuN5XJ4tI6IkWA/xbIAMWWrTKQ2Br+YZtDF/mGH7gWMpL
         TiA9JepFjbQ4xyOB3BJI9eiT9YyXM1sJmur4wOlBgMQlmV18zPtplOq2bjjPnegy/3w7
         o6tMFXnAbK+Od2SOEBiE2q063fyzn6+x4nDmqx3EimhX/g/OVtq0BqA3G6HVtnvHQY89
         7OeJKS6SSU4c/8wyogAgscnQdLvO+F+f5nou/EBC7KTtXJLPNJgZfzHXYFrWPiaXhXiT
         YK9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Om/ov8t+sbeiVrF95ZC6c1SOeL+sOEfF1lt5KPa62hQ=;
        b=ABbuMP0ysvFIgMXoHKP8qrXxHZ8UDME3La7XsEhRLVojyulbqlREW5gyUkVIbyGlt1
         NCk7TUZWimEN6d/l5NNt+jCDqhnG+FrAmq/UMvkfkOY+7cUdGkZ3c/tuduiMKqpi0b+P
         T8KpnAXbGgk9OkTuW2G23cUASCk0qBGslyp8aWtVuryeqSwGH/fnwUTERLlCDausMGGi
         G+4oiqtbn7mfJiIHDHOMCGri4VKvAEg0bwwvNv6xjKuVT7dGoh9jO30iN0JYjv93SWwP
         xsnRjcpO2f2wnVEt7HpWQD/YUcAURC9UQKsxxx2TmAfWXKRpE8PHbEDo/KfoPSrkOXS1
         ODfw==
X-Gm-Message-State: AOAM5303U57gO+CnarIAcsKdB52WDF07jlMWax8Z8NgedsJ8/Aes/wQq
        LAzgrg8kGkzDA0jwpjBDAtsbNt8qXmE=
X-Google-Smtp-Source: ABdhPJwIa8RDo7GWakrOOA4GxqWWJpsw0LExHNW8cx1gwXVsAE8NEPtESsj3gzo1U0Xs8hIZ10Rk4A==
X-Received: by 2002:a1c:7c08:: with SMTP id x8mr8342664wmc.2.1626225155637;
        Tue, 13 Jul 2021 18:12:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y6sm519830wma.48.2021.07.13.18.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 18:12:35 -0700 (PDT)
Message-Id: <0d1d0f180a35aaf355683909987731f1e0f4539b.1626225154.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1044.v2.git.git.1626225153.gitgitgadget@gmail.com>
References: <pull.1044.git.git.1625964399.gitgitgadget@gmail.com>
        <pull.1044.v2.git.git.1626225153.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 14 Jul 2021 01:12:30 +0000
Subject: [PATCH v2 1/4] diff: correct warning message when renameLimit
 exceeded
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

The warning when quadratic rename detection was skipped referred to
"inexact rename detection".  For years, the only linear portion of
rename detection was looking for exact renames, so "inexact rename
detection" was an accurate way to refer to the quadratic portion of
rename detection.  However, that changed with commit bd24aa2f97a0
(diffcore-rename: guide inexact rename detection based on basenames,
2021-02-14).  Let's instead use the term "exhaustive rename detection"
to refer to the quadratic portion.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index 52c791574b7..2454e34cf6d 100644
--- a/diff.c
+++ b/diff.c
@@ -6284,7 +6284,7 @@ static int is_summary_empty(const struct diff_queue_struct *q)
 }
 
 static const char rename_limit_warning[] =
-N_("inexact rename detection was skipped due to too many files.");
+N_("exhaustive rename detection was skipped due to too many files.");
 
 static const char degrade_cc_to_c_warning[] =
 N_("only found copies from modified paths due to too many files.");
-- 
gitgitgadget

