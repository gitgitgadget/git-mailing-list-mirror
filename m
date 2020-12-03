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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CFB0C4167B
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 16:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B6CD207AA
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 16:01:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731141AbgLCQAu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Dec 2020 11:00:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgLCQAt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Dec 2020 11:00:49 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25326C061A54
        for <git@vger.kernel.org>; Thu,  3 Dec 2020 07:59:57 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id e7so2380112wrv.6
        for <git@vger.kernel.org>; Thu, 03 Dec 2020 07:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=VNxxLgrPuJxEVC6iKX9rAAyfurlQPJJGP/oQrjVCsek=;
        b=dxBQhFC6VBdAi+VrH9/CgDZqw9vbD0squCEQJUairMwjt1nck37//5JtEsU20aY87u
         G6sYBu5+aPfJML30dP+3ni/KAbL0ZYfwno/YiIAPiOPUqjjbu3k5GNsVC56Nduui8D8H
         2/286DSQ/gStYwF4QtjIOx5yGmnBsncZwoVik6D8yN9CpFPkXAlavq0haAX2jFB6uDSP
         pha7rliG5QUk4pMUBwFdZI9U16deKrJBm/m5YGjM2Qi+fBC01tJCHQXEz+0J8z3oz2dl
         XFAamZ8xs2yW8PVVXe/E7YK/XqexpKfgc+nUgx5h3yHx3jjd73iIDb3JSpc3sakseeZ5
         PAJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=VNxxLgrPuJxEVC6iKX9rAAyfurlQPJJGP/oQrjVCsek=;
        b=arcxojlsTs1A10/xaPCugGSqYSvGkHZIE63YVc0P4xlTi4Kvub510N8LN62GToPl5A
         snh6kd0cakJxCi2EhSulwfu3j6I2jbIk+n/7RUm1AT1tn05+D6KTwMWVfGTfXiXXCJHt
         Fygkcw/sZGQ33IK2w6DpjZQmpxT+y+bbCVeDYlkg5GnWOrdm+UMs3vUKZo4z8/3Lq0Gl
         yN+wfcoDpMTYQBdWFlIWsgrYD7y4wmSsSFOFpCJ7oYo0lGn3/uutJt/Eq9svGrfqzFSC
         uAsgjs0VH6FHEPF5J/+Tpjr/Qefdfh97GZ6Qfv+9B5F3oWkatQlMyFTZNfUC+VEptcFV
         DXew==
X-Gm-Message-State: AOAM533VGGaDCHynIkjYcfxgnePBIgzsUOHKGGJO55I8UcJM7Ju+NsL0
        K3YDL889QK2aepdFxFJVQTGKkfge70c=
X-Google-Smtp-Source: ABdhPJxLoPmkYTNRG3rKBT+eum9OUlO6CeZq3mXk5wvOKNHK/hImazYGbTCfMeRblZ5dEsDYqY53Gw==
X-Received: by 2002:a5d:4448:: with SMTP id x8mr4520447wrr.364.1607011195698;
        Thu, 03 Dec 2020 07:59:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q17sm2290710wrr.53.2020.12.03.07.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 07:59:55 -0800 (PST)
Message-Id: <d37724031f2bced7b7f6fb3a0a5266a20a99b1cc.1607011187.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.803.git.1607011187.gitgitgadget@gmail.com>
References: <pull.803.git.1607011187.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 03 Dec 2020 15:59:43 +0000
Subject: [PATCH 4/7] merge-ort: add a paths_to_free field to
 merge_options_internal
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

This field will be used in future patches to allow removal of paths from
opt->priv->paths.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index bcd53d3799..89b9fdb04a 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -41,6 +41,8 @@ struct merge_options_internal {
 	 *   * these keys serve to intern all the path strings, which allows
 	 *     us to do pointer comparison on directory names instead of
 	 *     strcmp; we just have to be careful to use the interned strings.
+	 *     (Technically paths_to_free may track some strings that were
+	 *      removed from froms paths.)
 	 *
 	 * The values of paths:
 	 *   * either a pointer to a merged_info, or a conflict_info struct
@@ -75,6 +77,16 @@ struct merge_options_internal {
 	 */
 	struct strmap conflicted;
 
+	/*
+	 * paths_to_free: additional list of strings to free
+	 *
+	 * If keys are removed from "paths", they are added to paths_to_free
+	 * to ensure they are later freed.  We avoid free'ing immediately since
+	 * other places (e.g. conflict_info.pathnames[]) may still be
+	 * referencing these paths.
+	 */
+	struct string_list paths_to_free;
+
 	/*
 	 * current_dir_name: temporary var used in collect_merge_info_callback()
 	 *
@@ -222,6 +234,17 @@ static void clear_internal_opts(struct merge_options_internal *opti,
 	 * don't free the keys and we pass 0 for free_values.
 	 */
 	strmap_clear(&opti->conflicted, 0);
+
+	/*
+	 * opti->paths_to_free is similar to opti->paths; we created it with
+	 * strdup_strings = 0 to avoid making _another_ copy of the fullpath
+	 * but now that we've used it and have no other references to these
+	 * strings, it is time to deallocate them.  We do so by temporarily
+	 * setting strdup_strings to 1.
+	 */
+	opti->paths_to_free.strdup_strings = 1;
+	string_list_clear(&opti->paths_to_free, 0);
+	opti->paths_to_free.strdup_strings = 0;
 }
 
 static int err(struct merge_options *opt, const char *err, ...)
@@ -1206,13 +1229,14 @@ static void merge_start(struct merge_options *opt, struct merge_result *result)
 	 * Although we initialize opt->priv->paths with strdup_strings=0,
 	 * that's just to avoid making yet another copy of an allocated
 	 * string.  Putting the entry into paths means we are taking
-	 * ownership, so we will later free it.
+	 * ownership, so we will later free it.  paths_to_free is similar.
 	 *
 	 * In contrast, conflicted just has a subset of keys from paths, so
 	 * we don't want to free those (it'd be a duplicate free).
 	 */
 	strmap_init_with_options(&opt->priv->paths, NULL, 0);
 	strmap_init_with_options(&opt->priv->conflicted, NULL, 0);
+	string_list_init(&opt->priv->paths_to_free, 0);
 }
 
 /*
-- 
gitgitgadget

