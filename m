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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1DE4C433E3
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 21:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A60261A33
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 21:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238501AbhCXVcq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Mar 2021 17:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238493AbhCXVck (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Mar 2021 17:32:40 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D02C06174A
        for <git@vger.kernel.org>; Wed, 24 Mar 2021 14:32:39 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id y124-20020a1c32820000b029010c93864955so1989958wmy.5
        for <git@vger.kernel.org>; Wed, 24 Mar 2021 14:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MlU//xxMNdCKgYSkstMNl9UIw6xYo68RnWfaUVnXDfo=;
        b=F4BpLJOlOjp8E/+26AQCqklZ7zzvnS7nw/vEAR0aZBVfWsjO2AuqNJ+stQ7YTdB90n
         vYqQLrKgGO2K625JleLjZ2LPCkWpKZJks6kenHU6LUvwF6TyzCLVCJjC9xos2aO7XGPE
         WoQ30fegyQ+BX3P9aKfjB/MY9NzEVLxn7NYJ4OUUtlKym2Rw/yB4qNfJ0I8wGYJr6o7R
         g+RAB/2VVXqTGNeIeYEKWLbHWjnC22p1jrvvsd8ojlFoMo4G799hBtf2NG1itpCJUYQ9
         cuvjzwAH8EBTGIVQMJ2DPc91Da6fXGjfPnNzwtALuA6mg+VVGA8dGUTh+NL1JtwDAoey
         yCdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=MlU//xxMNdCKgYSkstMNl9UIw6xYo68RnWfaUVnXDfo=;
        b=m9uqUVw69Ehgbft7YmCfxQOlgC+Na1k81tSCL6qKfx5V7IXLjKZVG0yPT+TvgtQzaa
         RHXezW8QEL4qwW60ZB1I7PRonuiw6DrON4p/94eqGBNpbUr0sMSQpVajgEmWocwzIAQf
         qFUP+GUBO0sOuOD369d37smQiTuv47LJrOwirLC5Jh4lWGyMK4/ab7BTq+h7riLAR2Kq
         6kfEIrLw9jjH90aZZWP2SbStRk8cKCT1HKa1sDpBTB5OifC9LMBPpf/lyJRBmjcuo2my
         shRiJ8pi1ffrdMZZV5Be8/kUP08G0i1/ElNzR6sUx/dNa+hymFjEfNF4VbmjyDMEV8Xe
         C4+Q==
X-Gm-Message-State: AOAM532Qyi0cVOd21B+hN6SJ5mU6Z5tdBSmbua1EMkdzBHaxhPQsvfac
        gjW4sL2WlJUUmZ0bZobuF+EjTAZprhI=
X-Google-Smtp-Source: ABdhPJykr4T/7u044u9IQObietsIN74I0edjSgeUyKwRiY+cwcvZ39yySLEQ0HIND9X2sxSZCZRNMw==
X-Received: by 2002:a1c:21c3:: with SMTP id h186mr4676515wmh.32.1616621558233;
        Wed, 24 Mar 2021 14:32:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l1sm3190709wrv.87.2021.03.24.14.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 14:32:37 -0700 (PDT)
Message-Id: <df12cb5a158e9acedac92dbc8f146d89025b4301.1616621553.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.859.git.1616621553.gitgitgadget@gmail.com>
References: <pull.859.git.1616621553.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 24 Mar 2021 21:32:30 +0000
Subject: [PATCH 4/7] merge-ort: avoid accidental API mis-use
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Previously, callers of the merge-ort API could have passed an
uninitialized value for struct merge_result *result.  However, we want
to check result to see if it has cached renames from a previous merge
that we can reuse; such values would be found behind result->priv.
However, if result->priv is uninitialized, attempting to access behind
it will give a segfault.  So, we need result->priv to be NULL (which
will be the case if the caller does a memset(&result, 0)), or be written
by a previous call to the merge-ort machinery.  Documenting this
requirement may help, but despite being the person who introduced this
requirement, I still missed it once and it did not fail in a very clear
way and led to a long debugging session.

Add a _properly_initialized field to merge_result; that value will be
0 if the caller zero'ed the merge_result, it will be set to a very
specific value by a previous run by the merge-ort machinery, and if it's
uninitialized it will most likely either be 0 or some value that does
not match the specific one we'd expect allowing us to throw a much more
meaningful error.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 7 +++++++
 merge-ort.h | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/merge-ort.c b/merge-ort.c
index bb47fa91a339..5d56b0f90128 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -52,6 +52,8 @@ enum merge_side {
 	MERGE_SIDE2 = 2
 };
 
+static unsigned RESULT_INITIALIZED = 0x1abe11ed; /* unlikely accidental value */
+
 struct traversal_callback_data {
 	unsigned long mask;
 	unsigned long dirmask;
@@ -3736,6 +3738,10 @@ static void merge_start(struct merge_options *opt, struct merge_result *result)
 	assert(opt->obuf.len == 0);
 
 	assert(opt->priv == NULL);
+	if (result->_properly_initialized != 0 &&
+	    result->_properly_initialized != RESULT_INITIALIZED)
+		BUG("struct merge_result passed to merge_incore_*recursive() must be zeroed or filled with values from a previous run");
+	assert(!!result->priv == !!result->_properly_initialized);
 	if (result->priv) {
 		opt->priv = result->priv;
 		result->priv = NULL;
@@ -3895,6 +3901,7 @@ static void merge_ort_nonrecursive_internal(struct merge_options *opt,
 	result->clean &= strmap_empty(&opt->priv->conflicted);
 	if (!opt->priv->call_depth) {
 		result->priv = opt->priv;
+		result->_properly_initialized = RESULT_INITIALIZED;
 		opt->priv = NULL;
 	}
 }
diff --git a/merge-ort.h b/merge-ort.h
index d53a0a339f33..c011864ffeb1 100644
--- a/merge-ort.h
+++ b/merge-ort.h
@@ -29,6 +29,8 @@ struct merge_result {
 	 * !clean) and to print "CONFLICT" messages.  Not for external use.
 	 */
 	void *priv;
+	/* Also private */
+	unsigned _properly_initialized;
 };
 
 /*
-- 
gitgitgadget

