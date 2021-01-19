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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD0E1C433E6
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 19:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91EA22310B
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 19:58:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390462AbhAST6v (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 14:58:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392144AbhASTzd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 14:55:33 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E3BC061799
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 11:54:08 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id m187so885279wme.2
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 11:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1u4V06vH6u0mHUMgN5NtHBEHiw3x/FPsLgfL+4qUsO0=;
        b=daomNRxBMBg9ZctLBBMtPA9nCUCG5bgq1faqRzFJkIFlEhkKGYwpksw13CdHJJzzLP
         DcEkWa3Wkzc9BH+vJGnczuSgrTiUDnD9MBawuhD7RJx1U0MBNNUyD+n+YHUsXFSd7Tcx
         YNFf2kVR1I7ouX26ksVKur7eyJme6sjE6y+AdSHG6ubhZbTKPoqPgKev+iWHX4wMUjF4
         CNmlSe48VXUlrMmNAYK7YSV7YEgbmSj6JsBB33Ko3rXGNZcIHwwAIqocHodqaW7iITI1
         9ehih7XCWSMk/UvriV/951P1KJnEf0C+uKwRQha+/MA94ds8jAoblXbuhp1NrxFCelK4
         enlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1u4V06vH6u0mHUMgN5NtHBEHiw3x/FPsLgfL+4qUsO0=;
        b=rsCAqmNaPc69NZM4lb6EIV+nQ6AQXHuobxJBA5IDwyhfwd786sFLsgYGBsrrf2PLYr
         aRW+CxnymIyNxTDrS9Gd4R6vfyiW8ow6eNPK5K4RVnFkdDHTSFv8nEaox3IwpU4VCEUc
         eUbOUZ/rjAYxu8v2PJQnZdC77ZqzcGM0d7eHRcn4GEUf9qYFh1dQEaxaE0F9dns3n1GX
         cnG9fjc9T8J45sPfIIy6+7XT02KBAp8UOxddWCLohwS/WMkYlCfOvnmyKILJJZvYO1/d
         Y45I7e4CVe08HePAerkLj12x1D/iWVpsHCbEoL+fMKguQIP6PcxJxFfqJqsIaLVn3SvA
         Nx6A==
X-Gm-Message-State: AOAM531dpxFUphxnCFcxZpYHdPFq0fSLEaInnKjOfO/gqU3oCxfJ1Tt7
        9VhXvDa6UK4+mM0urbZ81Uf7Sg2UYTU=
X-Google-Smtp-Source: ABdhPJxnUgja0jMlDqJShcxMqgyGL6B7dLfQNVHlw/laJ2pC8EonWzZzGinXy7XQw6j+lszVETQ9UA==
X-Received: by 2002:a1c:7f94:: with SMTP id a142mr1078030wmd.145.1611086047475;
        Tue, 19 Jan 2021 11:54:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g18sm31443908wrw.61.2021.01.19.11.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 11:54:06 -0800 (PST)
Message-Id: <ee1398e3793c25f93ed325fede9f21394b487e63.1611086033.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.v3.git.1611086033.gitgitgadget@gmail.com>
References: <pull.835.v2.git.1610055365.gitgitgadget@gmail.com>
        <pull.835.v3.git.1611086033.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 19 Jan 2021 19:53:50 +0000
Subject: [PATCH v3 14/17] merge-ort: add a new toplevel_dir field
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Due to the string-equality-iff-pointer-equality requirements placed on
merged_info.directory_name, apply_directory_rename_modifications() will
need to have access to the exact toplevel directory name string pointer
and can't just use a new empty string.  Store it in a field that we can
use.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index ad8ecb7e448..5b3b56dc1cd 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -168,12 +168,15 @@ struct merge_options_internal {
 	struct rename_info renames;
 
 	/*
-	 * current_dir_name: temporary var used in collect_merge_info_callback()
+	 * current_dir_name, toplevel_dir: temporary vars
 	 *
-	 * Used to set merged_info.directory_name; see documentation for that
-	 * variable and the requirements placed on that field.
+	 * These are used in collect_merge_info_callback(), and will set the
+	 * various merged_info.directory_name for the various paths we get;
+	 * see documentation for that variable and the requirements placed on
+	 * that field.
 	 */
 	const char *current_dir_name;
+	const char *toplevel_dir;
 
 	/* call_depth: recursion level counter for merging merge bases */
 	int call_depth;
@@ -682,10 +685,10 @@ static int collect_merge_info(struct merge_options *opt,
 	int ret;
 	struct tree_desc t[3];
 	struct traverse_info info;
-	const char *toplevel_dir_placeholder = "";
 
-	opt->priv->current_dir_name = toplevel_dir_placeholder;
-	setup_traverse_info(&info, toplevel_dir_placeholder);
+	opt->priv->toplevel_dir = "";
+	opt->priv->current_dir_name = opt->priv->toplevel_dir;
+	setup_traverse_info(&info, opt->priv->toplevel_dir);
 	info.fn = collect_merge_info_callback;
 	info.data = opt;
 	info.show_all_errors = 1;
-- 
gitgitgadget

