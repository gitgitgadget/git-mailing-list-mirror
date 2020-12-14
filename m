Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98349C4361B
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 16:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B59B22795
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 16:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440133AbgLNQWl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Dec 2020 11:22:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440250AbgLNQWZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Dec 2020 11:22:25 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6445C0613D6
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 08:21:44 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id a11so9273027wrr.13
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 08:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bjCZpoR7X/4iQp728JJIq89yo2vC+dnNlcpJ/DFfq80=;
        b=YKVvh/Yz958gnFaEz4FQVP7m1kRHO7iLyu5iMFICTrnppEpqsSipbVkj5mJfNGl2f2
         wmOnckvSmUdNGXV0eQzDZ7mkpJMijVSLPnH4CrvRfNxhEJ9v9+dJnTsi+7mhZS5OgKXH
         vyWgpj9ad5u2f1g1C68o8ngRFDk8zynyIDndXfZa+bkzFPPR9QJwmxThjKD55A6KvsYV
         KCesenxecha0UCVA1e9gloYSkan51wsBtC/zE7KFM1UTGkV9DQtE9YYpE2beXpw18qE5
         egrcsa0/d8SNkYBoDREP/N+AImU+tHgl84n6FhztGBMxwwCse8Ebs+lyID8a600J+7x5
         pjOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=bjCZpoR7X/4iQp728JJIq89yo2vC+dnNlcpJ/DFfq80=;
        b=qPh5LGLvMwsM3KLsGtRbuhfWGNpLHYp9jUwGHFpxE5PJxYGpFIScK5++F9uok4HLY0
         iI/I7E0SW6p7cSfj+lamFRcrHPdgwtxzi7gZGIVyL2qm1ZX7q12XiGKMVm04LYjbgb6k
         Prk1Typ7KF3H3YYzO6Ax0FjkdQFBiGO1IMKFhDyIUa34EgdEcR1wDpwsniZ+nrrJncAU
         m2wJWmXDE1ROo5HioZ/MI2MIHiDKtaPvPnsGdp1UvcdtzbFUxn9dEuHnWmVA5dioi0DT
         ztogl5DyWSXKO6CqWwYPO/YxwxigmiCSa21cGFj/q/uH6259D2xZeqzwtgCVQ5Xtukx6
         GxXg==
X-Gm-Message-State: AOAM530Gr+fvEj4h6IBLi5GnGnZoEsfK7f39CyuTBEQEldQtbhsyh6jI
        qO/wwheA06kvuBI9YBPp8pM7m+qv9Pk=
X-Google-Smtp-Source: ABdhPJw6AwSUE5dcEowyErQQtopVqGKjPjSuc6OBXdjRwKjRreiGpP9FLupAk1CuiNm7WuE3RdQm5w==
X-Received: by 2002:adf:9e4d:: with SMTP id v13mr29171114wre.135.1607962903302;
        Mon, 14 Dec 2020 08:21:43 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s25sm15117662wrs.49.2020.12.14.08.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 08:21:42 -0800 (PST)
Message-Id: <78621ca07887e39a41ad9cff7b8dd5dcc9b33fbc.1607962900.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.812.v2.git.1607962900.gitgitgadget@gmail.com>
References: <pull.812.git.1607542887.gitgitgadget@gmail.com>
        <pull.812.v2.git.1607962900.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 14 Dec 2020 16:21:30 +0000
Subject: [PATCH v2 01/11] merge-ort: add basic data structures for handling
 renames
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

This will grow later, but we only need a few fields for basic rename
handling.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/merge-ort.c b/merge-ort.c
index 414e7b7eeac..1c1a7fa4bf1 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -46,6 +46,25 @@ enum merge_side {
 	MERGE_SIDE2 = 2
 };
 
+struct rename_info {
+	/*
+	 * pairs: pairing of filenames from diffcore_rename()
+	 *
+	 * Index 1 and 2 correspond to sides 1 & 2 as used in
+	 * conflict_info.stages.  Index 0 unused.
+	 */
+	struct diff_queue_struct pairs[3];
+
+	/*
+	 * needed_limit: value needed for inexact rename detection to run
+	 *
+	 * If the current rename limit wasn't high enough for inexact
+	 * rename detection to run, this records the limit needed.  Otherwise,
+	 * this value remains 0.
+	 */
+	int needed_limit;
+};
+
 struct merge_options_internal {
 	/*
 	 * paths: primary data structure in all of merge ort.
@@ -113,6 +132,11 @@ struct merge_options_internal {
 	 */
 	struct strmap output;
 
+	/*
+	 * renames: various data relating to rename detection
+	 */
+	struct rename_info renames;
+
 	/*
 	 * current_dir_name: temporary var used in collect_merge_info_callback()
 	 *
-- 
gitgitgadget

