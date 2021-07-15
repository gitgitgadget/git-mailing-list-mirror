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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A96C1B08C
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 00:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CA64613CC
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 00:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbhGOAsW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 20:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbhGOAsU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 20:48:20 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827EEC061760
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 17:45:27 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id f190so1076238wmf.4
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 17:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Om/ov8t+sbeiVrF95ZC6c1SOeL+sOEfF1lt5KPa62hQ=;
        b=eApmMnRZQBS993jrCSF712JyKx9hWRF5RuViL6uvrt5IN1HDdYiPtFZ0uluVUMLohc
         Zw7G8ELLopgApsuVbJpq/61RiHX9SVd5p1FV8T91W8vDQv3W/42xg3kJNlnf3Er86Z8y
         hOFNRO5+Hd44Nl/LvHc9cW+Z9VrOVLCqm1PzH4KTF1WJL0i7r8Ics5mgtSs1/LbHnzv9
         CDciuqag41ZBIDxKL+JgIsb1lvmz0MPvk4fYnsn9Vt33UWc6el9FwmNQ9jhC1AEwVXbC
         lQzZ2SQ91JlArCWCYDgagarq+cCLdhkr+ACAlDgyvK9awdfKEH2RI0/CMaQ440XIeeD3
         6S5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Om/ov8t+sbeiVrF95ZC6c1SOeL+sOEfF1lt5KPa62hQ=;
        b=gJWpvPJ+ZJexgL6krDR+lArsp+EnzC13hOk8gqnlxsV5kEIPqKAm3ayKE8AvMSp/B0
         086GsEm1tGqtjZHZ2+Ndo5bfsxIbL94RKYnxktJ6rwkO9ijzra+boA97v0JeSnOQwkLK
         giif+6fIZaRho2/gVVp2TVkGJ0Hvi7tp+B5uVQ1R/+AHI4eW41rpxvYSGYyP29J25Utk
         8MKVjVsy+hr8Ebw1yB3Gkz3Ae2DjlazfGhZt9NPoWc2bRoLdo3xYoFsAiR7R06WDu/3X
         OEMvNsHUujwfRTzaZpRR9LdgD5AdcZ3pJ1vHUo2O6vE3XrwQ4G8+SEiMvcOVFgI+EO02
         DhoQ==
X-Gm-Message-State: AOAM531Be6hifkVjozTThDxPPdmblBw7s3TWWXJVWfUhvBsTu2rUm2fl
        gDlSZjsOUm+eDXTVK8L7jUUdSQ/M03E=
X-Google-Smtp-Source: ABdhPJypt7U96OpVtqkejHXOyVzHPW5LvvJiK8RF6eMmHpECTgCxVXGmQIB2kcjXjbf2ZJn3T4WeGg==
X-Received: by 2002:a1c:a709:: with SMTP id q9mr6677447wme.23.1626309926112;
        Wed, 14 Jul 2021 17:45:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z13sm4354159wro.79.2021.07.14.17.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 17:45:25 -0700 (PDT)
Message-Id: <0d1d0f180a35aaf355683909987731f1e0f4539b.1626309924.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1044.v3.git.git.1626309924.gitgitgadget@gmail.com>
References: <pull.1044.v2.git.git.1626225153.gitgitgadget@gmail.com>
        <pull.1044.v3.git.git.1626309924.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 15 Jul 2021 00:45:21 +0000
Subject: [PATCH v3 1/4] diff: correct warning message when renameLimit
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

