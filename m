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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D00A7C4167B
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 19:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 917D623C92
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 19:42:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbgLITme (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 14:42:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732302AbgLITmO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 14:42:14 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FCBBC061794
        for <git@vger.kernel.org>; Wed,  9 Dec 2020 11:41:33 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id r7so3031595wrc.5
        for <git@vger.kernel.org>; Wed, 09 Dec 2020 11:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nOg+LmwailRaVuyEjDjA0uYgU3WumywkoJgRf7dQFBQ=;
        b=bwXY1szCvxAKDYaFBxVhdWVWCGYVC9MnKWMrVvE00qddC0gkcaqqMLRjK7FEYrri73
         zlzBp9MaTmxqDyx6M/3klZ156gNi09FuChKTVpIzQ/1t0Y65JDaaTVx4vwpLCuZ4GQvH
         p6+Ui6pBThYMGYIH2HJyjdA7b80DJS00pghxiXpMdKVnNwqXH7MQlTM8eqWVT2ydrW6m
         y2+dOk7uEGWwucF5sPTby24u8IO119Zc9WKzSOhgV8GsXpn2JZbH9qwOmKlPINeuIRoA
         ZiywFJXExH2J6J5nmwvds+kmw6QlNzImA8kOlClp75QNNpvI30qiQHDdr4uPV3RfZvs0
         hRHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=nOg+LmwailRaVuyEjDjA0uYgU3WumywkoJgRf7dQFBQ=;
        b=PXwoosMhnpGq9FKF7Ejw8SiET8Ot9nm6sFEI/vJ86zcnc9Bx5ldXRELWkyKC3S2q7J
         SxxjVcdmYrVb4KzX/J02qUgkaz058T4huLz3XFFR3HYwlCtTMIpJkHZlpkXh0guigtTv
         RAVsZ5u11uzmVvfnRIxLJF+TPMB3CI6nn8FlmZzQxI4cYQonUNTlP+b/L9aJrtXwRYpt
         NSibrCpYmVc6auEIwj+uZDLYi0CpuCoWKfHKxt+5H6QJRnrc+CUepDIxd0m0PMKPzh41
         k2bYbxnIUK1pERhCx82UqRF1XjMOSUU2+EMFeWZvjYEJcDjFt679hqSXKiBC+H5zV6iy
         LoIg==
X-Gm-Message-State: AOAM533WBOeuDPTWN9p74OgPEqxD4ho8a5xK5Gbw/D0tXBQfJKQJRVxB
        mO3D+7MTi9bl6wTlBguCK2v83HJjSw0=
X-Google-Smtp-Source: ABdhPJyO3mFudcZ+eV/oVQg/jzICLjtD+l70UdAzBDCGFMnDNNoVi9lwh7e40j4kfRKAJnm+4wcsPQ==
X-Received: by 2002:adf:db44:: with SMTP id f4mr4475707wrj.97.1607542891974;
        Wed, 09 Dec 2020 11:41:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y130sm5745779wmc.22.2020.12.09.11.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 11:41:31 -0800 (PST)
Message-Id: <ba30bc8686ef11115b369d351b4447c75a7bb9b5.1607542887.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.812.git.1607542887.gitgitgadget@gmail.com>
References: <pull.812.git.1607542887.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 09 Dec 2020 19:41:19 +0000
Subject: [PATCH 03/11] merge-ort: implement detect_regular_renames()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Based heavily on merge-recursive's get_diffpairs() function.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index 92b765dd3f0..1ff637e57af 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -634,7 +634,33 @@ static void detect_regular_renames(struct merge_options *opt,
 				   struct tree *side,
 				   unsigned side_index)
 {
-	die("Not yet implemented.");
+	struct diff_options diff_opts;
+	struct rename_info *renames = opt->priv->renames;
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
+	if (diff_opts.needed_rename_limit > opt->priv->renames->needed_limit)
+		opt->priv->renames->needed_limit = diff_opts.needed_rename_limit;
+
+	renames->pairs[side_index] = diff_queued_diff;
+
+	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
+	diff_queued_diff.nr = 0;
+	diff_queued_diff.queue = NULL;
+	diff_flush(&diff_opts);
 }
 
 /*
@@ -1379,6 +1405,10 @@ void merge_switch_to_result(struct merge_options *opt,
 			printf("%s", sb->buf);
 		}
 		string_list_clear(&olist, 0);
+
+		/* Also include needed rename limit adjustment now */
+		diff_warn_rename_limit("merge.renamelimit",
+				       opti->renames->needed_limit, 0);
 	}
 
 	merge_finalize(opt, result);
-- 
gitgitgadget

