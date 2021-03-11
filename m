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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A90C43381
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 00:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A6A864D99
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 00:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbhCKAiv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 19:38:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbhCKAig (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 19:38:36 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44D5C061760
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 16:38:35 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id d15so25361956wrv.5
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 16:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fcQkjCw6zC06N7gSUFzG0EzW9qGvc97YSBo5+h04zSE=;
        b=aMBGdwreoGCIZbtaMq5yrMLmywq4rFNjwuqdqpnPCUSEWSQy4VSzVDztasgXwCId07
         YU0eJGpNVAKLTqo59r2FzUUs/cnwJmYSKfY03W5lxB3kF1z00+5pX/CDSu2EFJItsiY6
         7jEjTobvg7v2nmxLKH0Euss4uV7mDYR3BM4tRTuax3h9IDJsFGf0rgKocbefqjS915fm
         4sRS1dlUB4hIDoxJNN9sLOh0E8gMGXzfwonKZi7KYsjCB/1LWLOW2SqQHTMwJYmGJkMo
         zKxxghTvWcZbv+umPNyvAI6PefC1cI/H+OyZGg35GTsGWC9/FH6sElq3OzqAPFDxhYZp
         5/SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fcQkjCw6zC06N7gSUFzG0EzW9qGvc97YSBo5+h04zSE=;
        b=HjnP3dYJ06rcp+iMlDFFGrKfDiSDtMQ6kgODKF96FbXVcegEiEyOMUpWyaQqeR+LFc
         7qaGwU5y+roixOYrEghef5zdE8sHDOu9wvapQkotfDlOkKn52rQDXAhMA2aFoDsFRbfC
         KlZEaghoFHZuyRoZaSE8tpFEzT2TtJOp6NbJIUB7JCJAZAeK+vDV+tlpWoN+3Hvvtzo+
         XLJQi/zHI6pCW/rk5Dil6mx2KXzuSk7DXki/WS8enx5et0Ixi9+QQwku2DKFHYoWGUka
         OLzjhopk5d1Tivt6IP2Qz2vF9HuDDiBPOff1MdSdMM1xHMw/MabP/jxAHK14J0C3wpko
         OXqA==
X-Gm-Message-State: AOAM531Ozf2/dyMTzhr1Ql/k1AYsmG6iDBfeO/XoQ7zL1LIoPFyOr+k7
        7zTmo0mqLBAl/q1VUohYw2VDpgdEP0I=
X-Google-Smtp-Source: ABdhPJwMjJ8JymazwUMAY6L4bnvyIFHaOBQsIdN5BIqUo1Wvg7gn4uWW8ouXEp6PkkMtGmq0bwGO6Q==
X-Received: by 2002:adf:df10:: with SMTP id y16mr6006493wrl.372.1615423114556;
        Wed, 10 Mar 2021 16:38:34 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h25sm1273362wml.32.2021.03.10.16.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 16:38:34 -0800 (PST)
Message-Id: <a57cc981608c67b068e1c32a68363c3180cab6e5.1615423112.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.845.v3.git.1615423111.gitgitgadget@gmail.com>
References: <pull.845.v2.git.1615248599.gitgitgadget@gmail.com>
        <pull.845.v3.git.1615423111.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 11 Mar 2021 00:38:26 +0000
Subject: [PATCH v3 3/8] merge-ort: add data structures for an alternate tree
 traversal
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

In order to determine whether directory rename detection is needed, we
as a pre-requisite need a way to traverse through all the files in a
given tree before visiting any directories within that tree.
traverse_trees() only iterates through the entries in the order they
appear, so add some data structures that will store all the entries as
we iterate through them in traverse_trees(), which will allow us to
re-traverse them in our desired order.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/merge-ort.c b/merge-ort.c
index 83aa4c08121f..d49cfa8b030b 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -51,6 +51,12 @@ enum merge_side {
 	MERGE_SIDE2 = 2
 };
 
+struct traversal_callback_data {
+	unsigned long mask;
+	unsigned long dirmask;
+	struct name_entry names[3];
+};
+
 struct rename_info {
 	/*
 	 * All variables that are arrays of size 3 correspond to data tracked
@@ -102,6 +108,22 @@ struct rename_info {
 	 */
 	struct strset relevant_sources[3];
 
+	/*
+	 * callback_data_*: supporting data structures for alternate traversal
+	 *
+	 * We sometimes need to be able to traverse through all the files
+	 * in a given tree before all immediate subdirectories within that
+	 * tree.  Since traverse_trees() doesn't do that naturally, we have
+	 * a traverse_trees_wrapper() that stores any immediate
+	 * subdirectories while traversing files, then traverses the
+	 * immediate subdirectories later.  These callback_data* variables
+	 * store the information for the subdirectories so that we can do
+	 * that traversal order.
+	 */
+	struct traversal_callback_data *callback_data;
+	int callback_data_nr, callback_data_alloc;
+	char *callback_data_traverse_path;
+
 	/*
 	 * needed_limit: value needed for inexact rename detection to run
 	 *
@@ -396,6 +418,10 @@ static void clear_or_reinit_internal_opts(struct merge_options_internal *opti,
 		}
 		strmap_clear(&opti->output, 0);
 	}
+
+	/* Clean out callback_data as well. */
+	FREE_AND_NULL(renames->callback_data);
+	renames->callback_data_nr = renames->callback_data_alloc = 0;
 }
 
 static int err(struct merge_options *opt, const char *err, ...)
-- 
gitgitgadget

