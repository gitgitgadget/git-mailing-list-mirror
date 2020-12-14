Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4404C2BB9A
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 16:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C756225AC
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 16:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440171AbgLNQWv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Dec 2020 11:22:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440252AbgLNQW1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Dec 2020 11:22:27 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F22C061794
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 08:21:46 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id m5so17003687wrx.9
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 08:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2EJEhCVyrWEW/1Rsba7YQOxkLZkc7V5Ocg8faa9cQT0=;
        b=Ojr7hyV3zeAasjE3zivKH4+GF1QDyf8egGMX3QNY8WgNR8DW6dcFaWPHJNyhUfdAVL
         LSMevhwteQaxGP3cu5PhArOdtsf2wBEUOcSzofvkosZt1i0CJHa7qRBlKLPTuqLiLjPX
         4k5NNYE2BAJALTDCMCqixQ5AmJqkkoNItRmUydY/8JfaOP95OQVsWfNBUBeLo22Vst1w
         gPMTklvKzlGzd3t32yvSw3s11olCEMzyGJ3jWDY6nkyYsBGIbcrXFdq3y2SkDNq3EmhY
         1zVEFmjSaxzOpotZSqk2H/pQP5VwsvtoHFAKPDnmNJYgYDn6vWla14ZmojReIHuTjMfd
         bs9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2EJEhCVyrWEW/1Rsba7YQOxkLZkc7V5Ocg8faa9cQT0=;
        b=fODV3bhRFxYTmjasidrSl0UHXx59MZ2vtCA3Yc1Hat/TwAJI6+gZPwUjTTKbSu6mz3
         VdJGtzNM4xfbri19UOwfndBm1rqifV/44/lvAuoXqIJa/oHjXnyKqiYAPquAc4d0dD0F
         KkqgaqjToJ8ujDogoOi6KH2+7oLe9WdZnmeKfoapAQUmpTmoPI4ZAL+5WkfE9rKKP0hL
         9v5rUjNSH64ic5dnFQyz4sFtTOQW1SkUdtCf3L08W7opm4dRbT9gAYzoZq7wboUEu4Vq
         2bgs2bRBZHmwBs1vuTCVszGAQxdnnHJ3VnIdKRUEcEq1m5tEnd3oSz8OiOHnZRguKsNK
         dkZA==
X-Gm-Message-State: AOAM530fvb3Zhw72T4w/l6GogJRKF6oP7Qnwp2tFZVE6HViFa07AjavL
        J9/89DBoVFSzgl3fSOxNuSAeUcujbyU=
X-Google-Smtp-Source: ABdhPJzOkaVtGO/d95N8NUgIw10C/y9skAQ9ZFbNiIgy2muqTQAvmDtqcG+VRjqP1vF0Ut+sU4Pkgw==
X-Received: by 2002:adf:8b5a:: with SMTP id v26mr21931122wra.138.1607962905155;
        Mon, 14 Dec 2020 08:21:45 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l11sm21994724wrt.23.2020.12.14.08.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 08:21:44 -0800 (PST)
Message-Id: <620fc64032d26e374b2fb52a044564725e023f0f.1607962900.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.812.v2.git.1607962900.gitgitgadget@gmail.com>
References: <pull.812.git.1607542887.gitgitgadget@gmail.com>
        <pull.812.v2.git.1607962900.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 14 Dec 2020 16:21:32 +0000
Subject: [PATCH v2 03/11] merge-ort: implement detect_regular_renames()
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

Based heavily on merge-recursive's get_diffpairs() function, and also
includes the necessary paired call to diff_warn_rename_limit() so that
users will be warned if merge.renameLimit is not sufficiently large for
rename detection to run.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index 8552f5e2318..66f84d39b43 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -661,7 +661,33 @@ static void detect_regular_renames(struct merge_options *opt,
 				   struct tree *side,
 				   unsigned side_index)
 {
-	die("Not yet implemented.");
+	struct diff_options diff_opts;
+	struct rename_info *renames = &opt->priv->renames;
+
+	repo_diff_setup(opt->repo, &diff_opts);
+	diff_opts.flags.recursive = 1;
+	diff_opts.flags.rename_empty = 0;
+	diff_opts.detect_rename = DIFF_DETECT_RENAME;
+	diff_opts.rename_limit = opt->rename_limit;
+	if (opt->rename_limit <= 0)
+		diff_opts.rename_limit = 1000;
+	diff_opts.rename_score = opt->rename_score;
+	diff_opts.show_rename_progress = opt->show_rename_progress;
+	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
+	diff_setup_done(&diff_opts);
+	diff_tree_oid(&merge_base->object.oid, &side->object.oid, "",
+		      &diff_opts);
+	diffcore_std(&diff_opts);
+
+	if (diff_opts.needed_rename_limit > renames->needed_limit)
+		renames->needed_limit = diff_opts.needed_rename_limit;
+
+	renames->pairs[side_index] = diff_queued_diff;
+
+	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
+	diff_queued_diff.nr = 0;
+	diff_queued_diff.queue = NULL;
+	diff_flush(&diff_opts);
 }
 
 /*
@@ -1406,6 +1432,10 @@ void merge_switch_to_result(struct merge_options *opt,
 			printf("%s", sb->buf);
 		}
 		string_list_clear(&olist, 0);
+
+		/* Also include needed rename limit adjustment now */
+		diff_warn_rename_limit("merge.renamelimit",
+				       opti->renames.needed_limit, 0);
 	}
 
 	merge_finalize(opt, result);
-- 
gitgitgadget

