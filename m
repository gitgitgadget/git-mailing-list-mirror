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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB34C433DB
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 20:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2007723444
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 20:02:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbhAGUC0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 15:02:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727183AbhAGUCY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 15:02:24 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63FC8C0612A3
        for <git@vger.kernel.org>; Thu,  7 Jan 2021 12:01:45 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id d13so6773670wrc.13
        for <git@vger.kernel.org>; Thu, 07 Jan 2021 12:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zuhaytbslpiiTsJARPXCZhteNOT9TskDEFoa6C7OWHg=;
        b=KSauYskfzhP6kXK24rjwbyL78H3L6b1k+XwF/YmwKMMo4oVrgSxalGQziehupIubaL
         WrOTJJ3lz/ZidtApwjm1PeD+c7VCFZFsC0AM5z80adTkaZQEHlKIPcjHiVNFrgCL7ypn
         tgJnkBiNQpqb1MQTPdPNp+CVU9LYhdNVjDM7C8NRuRvpyzTJ+ZIuVFx++ViacV56ZTW/
         oe36GvxR0QhTmDjLLumGmvoYLOBdlwAzsuvpXwo+heZfhbJodrsNdBYcDRkJGIa2EJZK
         +At97cff9VQziBr5Oqhrzuf7FeIrIPJS+foDX0XGEeTwfW4hVFkObSupL85lhO0atkWY
         wvhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=zuhaytbslpiiTsJARPXCZhteNOT9TskDEFoa6C7OWHg=;
        b=UclN2TTlTjyM1WkCU4/iqSfZedkg9Q9ody84vjEJ61D1DzqnNDy72reEUPglVOBZmD
         6V+og76wNt3Q2yLKmPavzlg1dfbsiKQLHYehGvCiRQGUvvETHxjjpAy4GIYRPk8cVC0z
         Lb7eZjjW1OLnT7HTX7ogHZSU416yV8lleTkRzSuFlGMAtr4BVZyPXQVH64RTE9GTj1Vp
         XEu6kFfXr61q4g87mu02bb1etVqjNScZkOtv6D4mahI2nC89/hlQ3AP1e2BSONZABqtW
         KoLPHdHXUtzDpBJ5Cuq69r0Yo0RwJr4m3ViyuueQlmII+bPQoYXFlHQhyq2scL0WyCnR
         bGDg==
X-Gm-Message-State: AOAM531AGg8c8K72v3uwgbgpekgXPJIiiDBno5d7GBlDHaaWopAfgZuP
        r8OHZZqq9MB51M/svL5idaBuobC0V7I=
X-Google-Smtp-Source: ABdhPJwgX+P13QglD785DNlpDICXzWeRf71iUdoyrsmBfRsWcaFWBpOfldpRqI9m9yq9YQWx2ZQ5Pw==
X-Received: by 2002:a5d:4e86:: with SMTP id e6mr277624wru.33.1610049704012;
        Thu, 07 Jan 2021 12:01:44 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j59sm10544787wrj.13.2021.01.07.12.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 12:01:43 -0800 (PST)
Message-Id: <11e45af831d14296c6a78441e423aba315c8f76b.1610049687.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.git.1610049687.gitgitgadget@gmail.com>
References: <pull.835.git.1610049687.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Jan 2021 20:01:25 +0000
Subject: [PATCH 16/18] merge-ort: process_renames() now needs more
 defensiveness
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Since directory rename detection adds new paths to opt->priv->paths and
removes old ones, process_renames() needs to now check whether
pair->one->path actually exists in opt->priv->paths instead of just
assuming it does.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index ea6a08e23e2..9e4ebd9c4d6 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -1411,12 +1411,28 @@ static int process_renames(struct merge_options *opt,
 		const char *rename_branch = NULL, *delete_branch = NULL;
 
 		old_ent = strmap_get_entry(&opt->priv->paths, pair->one->path);
-		oldpath = old_ent->key;
-		oldinfo = old_ent->value;
-
 		new_ent = strmap_get_entry(&opt->priv->paths, pair->two->path);
-		newpath = new_ent->key;
-		newinfo = new_ent->value;
+		if (old_ent) {
+			oldpath = old_ent->key;
+			oldinfo = old_ent->value;
+		}
+		newpath = pair->two->path;
+		if (new_ent) {
+			newpath = new_ent->key;
+			newinfo = new_ent->value;
+		}
+
+		/*
+		 * If pair->one->path isn't in opt->priv->paths, that means
+		 * that either directory rename detection removed that
+		 * path, or a parent directory of oldpath was resolved and
+		 * we don't even need the rename; in either case, we can
+		 * skip it.  If oldinfo->merged.clean, then the other side
+		 * of history had no changes to oldpath and we don't need
+		 * the rename and can skip it.
+		 */
+		if (!oldinfo || oldinfo->merged.clean)
+			continue;
 
 		/*
 		 * diff_filepairs have copies of pathnames, thus we have to
-- 
gitgitgadget

