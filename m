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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B5DC433E9
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 00:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5001E6528D
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 00:10:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbhCIAK2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 19:10:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbhCIAKF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 19:10:05 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F2DC06174A
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 16:10:05 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id j4-20020a05600c4104b029010c62bc1e20so4865624wmi.3
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 16:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=D0Uir+rhhF+WjYNrc7vEgebea/JdT67xx/aFC/0Z1LU=;
        b=BjdqjGBc44O1gOd48IrKrHH20pI23HUqJ99pKDFiqdvNANdkAhR1O+pgOKWZ5am/1I
         A5e+7lnO5crWGFl/KDI2hysOfaq10TI/Kup115ph/r3+BGAj4juJkw3EiBWLLDkAAS7a
         pPqM1nMziKcZCJCoicDk/+GULJxIF7+46l6kC34AeoqzRWhrQOkW+RVhFzSiP5KYgNwH
         wx1b4oap/Qq9Omw3ETMUeX0shD+wrdhHhhdgT1z+RPHIIrVVEDc6p8Ww0hzFQdbgkHIo
         h7NBfQuo/Wr3+NiSmTWG2QrW2w/yCTOeaQpGviLRqiy4B5oa0zw33fZv1hZqhhI+o1JC
         S9cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=D0Uir+rhhF+WjYNrc7vEgebea/JdT67xx/aFC/0Z1LU=;
        b=dsIVHBc+PkpN4fVe0yGY85cZafmIOYNMwyJ/or4xBW3ia4owcfm4ru9hOZSjqGoAdA
         ChDEeF8Hh15Ey+8jd1v5eU/Le5KLCG+2dzu4pm/aJu4iSk50JkkeWlSyxmOPMnc/jPX9
         CFjZke/rBQhyKjQJ2oCv2qvXEiOl6DSY9IO+ivQyrjUlBvMxji5RTUFSGIO9DYjLUM3r
         j3J33764+yvmGurUThegtRzF1EHvKq28a+kb/eAqafL2u0+puNgpv+HpPu0plcCkPVMF
         GPNTL0mOlbhyWeLFnF2E6ONXl7gjfdkNMcdKJ7NsGXJ/N/yYwdWURROiaaELHqeCUKUq
         uObQ==
X-Gm-Message-State: AOAM533T6y23fuY/Yb8GibPhi5JrLriVHKG9oh31obqiWG818skIWlZb
        muYCTOE04fdyVY5dUGsjR9sCPHsopwc=
X-Google-Smtp-Source: ABdhPJz4H3xudopGjgIwSrND9IYUQtqRMVtHwseijSjBvERGw35hSDuQhiTa1BIQWmfpkXymg1gKkw==
X-Received: by 2002:a1c:dc42:: with SMTP id t63mr1094271wmg.153.1615248604333;
        Mon, 08 Mar 2021 16:10:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y10sm20714163wrl.19.2021.03.08.16.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 16:10:04 -0800 (PST)
Message-Id: <d62fdee45ad344a09062e2ab73702d1093c12efc.1615248599.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.845.v2.git.1615248599.gitgitgadget@gmail.com>
References: <pull.845.git.1614484707.gitgitgadget@gmail.com>
        <pull.845.v2.git.1615248599.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 09 Mar 2021 00:09:57 +0000
Subject: [PATCH v2 6/8] merge-ort: use relevant_sources to filter possible
 rename sources
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

The past several commits determined conditions when rename sources might
be needed, and filled a relevant_sources strset with those paths.  Pass
these along to diffcore_rename_extended() to use to limit the sources
that we need to detect renames for.

For the testcases mentioned in commit 557ac0350d ("merge-ort: begin
performance work; instrument with trace2_region_* calls", 2020-10-28),
this change improves the performance as follows:

                            Before                  After
    no-renames:       12.596 s ±  0.061 s     6.003 s ±  0.048 s
    mega-renames:    130.465 s ±  0.259 s   114.009 s ±  0.236 s
    just-one-mega:     3.958 s ±  0.010 s     3.489 s ±  0.017 s

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index 27acaa7380be..66892c63cee2 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -2209,7 +2209,7 @@ static void detect_regular_renames(struct merge_options *opt,
 	diff_queued_diff = renames->pairs[side_index];
 	trace2_region_enter("diff", "diffcore_rename", opt->repo);
 	diffcore_rename_extended(&diff_opts,
-				 NULL,
+				 &renames->relevant_sources[side_index],
 				 &renames->dirs_removed[side_index],
 				 &renames->dir_rename_count[side_index]);
 	trace2_region_leave("diff", "diffcore_rename", opt->repo);
-- 
gitgitgadget

