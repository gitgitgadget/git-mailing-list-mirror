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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD831C433E0
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 21:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86C0123600
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 21:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbhAGVh2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 16:37:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727612AbhAGVh1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 16:37:27 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134BBC0612A5
        for <git@vger.kernel.org>; Thu,  7 Jan 2021 13:36:26 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id g25so5643464wmh.1
        for <git@vger.kernel.org>; Thu, 07 Jan 2021 13:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zuhaytbslpiiTsJARPXCZhteNOT9TskDEFoa6C7OWHg=;
        b=LgpJGbWt73DP7z4zGn+8hj0FuAHx3LliWSlr6tUM6rCGhLsgWnjnlYa6YPew2KRZcG
         ds23p9TFYmziTTBVufDi78aAqVS0HG8Rlr6PNqvDK3M4iqut52nOmMiLd4poev500H/v
         wm2kGksq5TB+UKPt2OIS4667OtAXKx72/ZClOW75hmPq6tqCM6I+rC10Lb4ZZ+GWCzfC
         rtQUvGLjk92dQv1coQaVN4ECghMjOxIggkEsF2J4tzWc9ONUuwjzkPDSbR6OI8B8lFtQ
         KMugEKFEbgulTr7lGsSUHmPWZBcuQqr0KCR2/jsgakNRWWAbdnHSvlzyiOeHV852ZPBg
         XD7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=zuhaytbslpiiTsJARPXCZhteNOT9TskDEFoa6C7OWHg=;
        b=W8oWirxmh9Iaz5RjMC/stBDA9lJB2HK0QfhUeVMiHgca8VNvlpj6sZMt89bIltHWAM
         7J63qmXkvRVQn0hzJrlKsteWY4Es6vOBRIjI2jkIQ578x2Ef0xtcaKdima723OyWoXUL
         +4ZL7IQyUowcIIizJ5mcRjAd2AHYWeAO6xS8/eOvlAqy8bSwpazlDvsPqw71KrnMQTkm
         xXKzcYv/yipTESyZCP+7PtzAOUpUa41iuUMWyuRC1CsUh0wgCShwRzPOR7sq0xK/1K6U
         Py+PviycBlRomRlFCoJtvoNXBAcBzNCdH6ehk9k0ISYGaOkk9rQtK834vdGxwRauCXXm
         Nqxg==
X-Gm-Message-State: AOAM5300szbKp/ACwCMz0tCn6tTEXBwkHm4+NhDV+YnM3NiMLY2Q8zBj
        OEAM2iwWBq3gL10PkfZj8/oNOh7pBmc=
X-Google-Smtp-Source: ABdhPJz3AcHLulUdmPnBGjnO1vjruw7pInpawbYPr5WL0dwzMaxSZFhUqDjaL5QKSOn6UNdtkAHbOQ==
X-Received: by 2002:a1c:dfd7:: with SMTP id w206mr434673wmg.48.1610055384587;
        Thu, 07 Jan 2021 13:36:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q15sm9737637wrw.75.2021.01.07.13.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 13:36:23 -0800 (PST)
Message-Id: <11e45af831d14296c6a78441e423aba315c8f76b.1610055365.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.v2.git.1610055365.gitgitgadget@gmail.com>
References: <pull.835.git.1610049687.gitgitgadget@gmail.com>
        <pull.835.v2.git.1610055365.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Jan 2021 21:36:04 +0000
Subject: [PATCH v2 16/17] merge-ort: process_renames() now needs more
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

