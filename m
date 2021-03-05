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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 373E9C433E6
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 00:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AF5E64FD3
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 00:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbhCEAzr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Mar 2021 19:55:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232016AbhCEAzn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Mar 2021 19:55:43 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC87DC061756
        for <git@vger.kernel.org>; Thu,  4 Mar 2021 16:55:42 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id b18so235480wrn.6
        for <git@vger.kernel.org>; Thu, 04 Mar 2021 16:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=z/aJo75dNhsQ7aTf5zagZWSLinhoohO+zk07aKf06jI=;
        b=KcALPoxPerN6b1KIiITkWQ/SFnDWz62CW9EZtS63A6S4mIVyiXcCL48ijy3q4de86n
         qYQfAZsPs9d9SO/lypHPlW/dpI+8a9V0oPbHmsP4DIeGlxjeJ1Uase/ksTyPafFwN2ms
         hx0cwL4G/S4OOQC5cXej6O3/02MzYxwAZ1Zpb1o0LKOCKn+NVCzS99vxbYRyQnybXW0a
         XAe09cnOssfF2KiUf90tvFsJ/8rFNPdL79HN3wK2SDUhVwbURlO/SuLEqwgD5qiCLMMF
         UtiMLabLqPsuki8u4y95/NVv1XXal0rH0y+U9Y8MaL+TVKsSFOFa7UHovTRSWn4IlgJ0
         uTnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=z/aJo75dNhsQ7aTf5zagZWSLinhoohO+zk07aKf06jI=;
        b=YWnfNoKxXzGvMKM6QkJ/PeTK3EhPUwpcENrnYRkvMelFx1V/FwJVSDiyGFT3SPyW/i
         LEH9ieQXx8U3yYzsen+HGKfZv4vL/KklklU8Jzu+FnTp6jegCoc9qaITU/oJTi0rb/iP
         Wp/rg2wTCbcxTxS4N7d9ssqfPd7ImK+R24RrYFsYMap+f6v93Ix/WILe1+Jha/6MT6Xd
         EODa5lDpuZqFHJv82cPxUxp5gP2Lbez16E1OLvZB93ppmthJ977nQZ5BDrvW5auDxTSJ
         4sHItL+N838XJJC4WkhyN0ui3kW282U6zipTz2WYBkFaISoLC3+RX5wHeUGE10m3xxln
         yvEQ==
X-Gm-Message-State: AOAM533Iy7TQb+iLyBkeXXD4uIKhb6ZxnSc3eF4vLp7d1SsnHhgh2Y5R
        S/8FgYIOTLqGFFT8xISN5gojKX28S10=
X-Google-Smtp-Source: ABdhPJwtiAE5v4bqiJFNtmDLESHeOEeA7E5OiK/SvOv21POfEFyww9JBKD0ircVwfnPQafScc8TfpA==
X-Received: by 2002:adf:e94a:: with SMTP id m10mr6519598wrn.55.1614905741566;
        Thu, 04 Mar 2021 16:55:41 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 91sm1768662wrl.20.2021.03.04.16.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 16:55:41 -0800 (PST)
Message-Id: <cb035ac5fe4ab18b697eff42afedcab62880ceec.1614905738.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.973.git.git.1614905738.gitgitgadget@gmail.com>
References: <pull.973.git.git.1614905738.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 05 Mar 2021 00:55:30 +0000
Subject: [PATCH 04/11] merge-ort: have ll_merge() calls use the attr_index for
 renormalization
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

ll_merge() needs an index when renormalization is requested.  Give it
the special one we created exactly for that purpose.  This fixes t6418.4
and t6418.5 under GIT_TEST_MERGE_ALGORITHM=ort.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 028d1adcd2c9..87c553c0882c 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -360,7 +360,7 @@ static void clear_or_reinit_internal_opts(struct merge_options_internal *opti,
 	string_list_clear(&opti->paths_to_free, 0);
 	opti->paths_to_free.strdup_strings = 0;
 
-	if (opti->attr_index.cache_nr)
+	if (opti->attr_index.cache_nr) /* true iff opt->renormalize */
 		discard_index(&opti->attr_index);
 
 	/* Free memory used by various renames maps */
@@ -988,7 +988,6 @@ static int merge_submodule(struct merge_options *opt,
 	return 0;
 }
 
-MAYBE_UNUSED
 static void initialize_attr_index(struct merge_options *opt)
 {
 	/*
@@ -1063,6 +1062,8 @@ static int merge_3way(struct merge_options *opt,
 	char *base, *name1, *name2;
 	int merge_status;
 
+	initialize_attr_index(opt);
+
 	ll_opts.renormalize = opt->renormalize;
 	ll_opts.extra_marker_size = extra_marker_size;
 	ll_opts.xdl_opts = opt->xdl_opts;
@@ -1101,7 +1102,7 @@ static int merge_3way(struct merge_options *opt,
 
 	merge_status = ll_merge(result_buf, path, &orig, base,
 				&src1, name1, &src2, name2,
-				opt->repo->index, &ll_opts);
+				&opt->priv->attr_index, &ll_opts);
 
 	free(base);
 	free(name1);
-- 
gitgitgadget

