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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D942C43331
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 21:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0ACB4235FD
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 21:38:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbhAGVhj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 16:37:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727719AbhAGVhh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 16:37:37 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED490C0612A0
        for <git@vger.kernel.org>; Thu,  7 Jan 2021 13:36:20 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 3so6740750wmg.4
        for <git@vger.kernel.org>; Thu, 07 Jan 2021 13:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7SNw9eu+RPlhHL8eL3KhfrVAuFokhSKjmDIaKN5ygSU=;
        b=Sx+ts0oajqHkOaVNaBKEJHDPHr1dvXX3sjbx80Igz7wFN4Mov33zijTlCmm1xwTUEa
         E+O97UKOivOp8imgypx/I8nPSeswrWXmYbMOmbXxiHieynATA2/DS2OxiJV5TzyObGJt
         9zx9TMs9qs8ljorUKI4SKPPkUrBlg4pruYYEPkymDJAMmK1yMn5MJeTVOg1S4zM3Ahxg
         LFS2falksAZYwJLv8ihAW62XGNJQ0ZNXtIA2kLwd8N7nswVTithuaWPKj0xMWY+B5Y6F
         8L60Q/D3iBGMT0CyQgbczFKtygErGwBfrMjwmRHzQ3YROsUlliDQTzgrEVlinWY5HisA
         Jg7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7SNw9eu+RPlhHL8eL3KhfrVAuFokhSKjmDIaKN5ygSU=;
        b=QWl1NXxst1j1ClYytinplyB3P8QdAaKIuByrbAfNeThq252g6GnMO5H5ZVvLozLETP
         bkONLy7tEY5Oqpos7HzjWrfVwAJYvzyGVTbzN4z5LshBq7BxVc5ANQVVjLzZTEVK7em+
         solKXS1YOW7+K2PnM5K8HEaV28ebFZwtxSu/gbQ4y3CHRIK/2zUWWBcxWLQUnfp49dbY
         AyOar7BCBmPDGHvWvgKQ22D+nTQfrA92pZPN6Epv8ww1p2ELfWIET6e7xzzGOgrelVQq
         /XJTwkkhQw6q08l34xxYrxvxjUzNBkIkX74nUU5QynaWWTElMdJlnE9CDM3kgSuBiDPr
         Lmug==
X-Gm-Message-State: AOAM532K9n2QG7OadK/+A+WTMIUIeAd9pEGg9yTUMhw6yzsY+FW1gcOT
        eiyLpCNDndg69FzphKw+F0ZttEt2+e4=
X-Google-Smtp-Source: ABdhPJzh529WEg+zv1yqtI2EaxRU3GBVBwoIL7uqGIDO1YNcL09An1AEpJsl5ZjmpPs7E/27TD2hcw==
X-Received: by 2002:a05:600c:2219:: with SMTP id z25mr403560wml.27.1610055379489;
        Thu, 07 Jan 2021 13:36:19 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u6sm11154933wrm.90.2021.01.07.13.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 13:36:18 -0800 (PST)
Message-Id: <2ffb93c37ac7e9ca8697a43c41d618d987db4f47.1610055365.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.v2.git.1610055365.gitgitgadget@gmail.com>
References: <pull.835.git.1610049687.gitgitgadget@gmail.com>
        <pull.835.v2.git.1610055365.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Jan 2021 21:35:59 +0000
Subject: [PATCH v2 11/17] merge-ort: implement apply_dir_rename() and
 check_dir_renamed()
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

Both of these are copied from merge-recursive.c, with just minor tweaks
due to using strmap API and not having a non_unique_new_dir field.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 37 +++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index e436418d0d2..8ee9c685c7b 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -736,7 +736,29 @@ struct collision_info {
 static char *apply_dir_rename(struct strmap_entry *rename_info,
 			      const char *old_path)
 {
-	die("Not yet implemented!");
+	struct strbuf new_path = STRBUF_INIT;
+	const char *old_dir = rename_info->key;
+	const char *new_dir = rename_info->value;
+	int oldlen, newlen, new_dir_len;
+
+	oldlen = strlen(old_dir);
+	if (*new_dir == '\0')
+		/*
+		 * If someone renamed/merged a subdirectory into the root
+		 * directory (e.g. 'some/subdir' -> ''), then we want to
+		 * avoid returning
+		 *     '' + '/filename'
+		 * as the rename; we need to make old_path + oldlen advance
+		 * past the '/' character.
+		 */
+		oldlen++;
+	new_dir_len = strlen(new_dir);
+	newlen = new_dir_len + (strlen(old_path) - oldlen) + 1;
+	strbuf_grow(&new_path, newlen);
+	strbuf_add(&new_path, new_dir, new_dir_len);
+	strbuf_addstr(&new_path, &old_path[oldlen]);
+
+	return strbuf_detach(&new_path, NULL);
 }
 
 static void get_renamed_dir_portion(const char *old_path, const char *new_path,
@@ -981,7 +1003,18 @@ static void handle_directory_level_conflicts(struct merge_options *opt)
 static struct strmap_entry *check_dir_renamed(const char *path,
 					      struct strmap *dir_renames)
 {
-	die("Not yet implemented!");
+	char *temp = xstrdup(path);
+	char *end;
+	struct strmap_entry *e = NULL;
+
+	while ((end = strrchr(temp, '/'))) {
+		*end = '\0';
+		e = strmap_get_entry(dir_renames, temp);
+		if (e)
+			break;
+	}
+	free(temp);
+	return e;
 }
 
 static void compute_collisions(struct strmap *collisions,
-- 
gitgitgadget

