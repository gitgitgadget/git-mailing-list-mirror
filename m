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
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED646C433E9
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 20:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6F9823444
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 20:02:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728131AbhAGUC1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 15:02:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727903AbhAGUC0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 15:02:26 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B548BC061285
        for <git@vger.kernel.org>; Thu,  7 Jan 2021 12:01:40 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id d26so6792430wrb.12
        for <git@vger.kernel.org>; Thu, 07 Jan 2021 12:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7SNw9eu+RPlhHL8eL3KhfrVAuFokhSKjmDIaKN5ygSU=;
        b=PnmUtrZ7W67oKK9aEmou2nLoZuNXc6Eu2XC85R9QeUHI9f6vg/PtlBNaMsGIyKlFZY
         Uahl5v8BaLxLCbddinTQi2uT+tSmjoxgu3I2q3ei8aixkDylqTEf+S38fpvZ1n48B5C6
         3CWCAmTljwqDLf+wA7uZRGie9LMKAybMYEjlaBJ0keoifZuZvktxL4r2KfVFnMjB4vUk
         9SQtR3Kubx2eTEDw73/Ua2BLEfEe8n4YE2zxc+bH4U61JCs/B2zzX8Y0q0srVvIv8S2g
         SyFkW4fk5QlwReei7M+DlfFpW8wQi6Gl8cF28zsZ5Y2NuuI903Fv250or+RTFQGVuTfW
         8TKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7SNw9eu+RPlhHL8eL3KhfrVAuFokhSKjmDIaKN5ygSU=;
        b=WTLwLkc9JD3nLEXrsqZT8lBKrl2WO8DFWwV4CslWhKCB0/zzujfQybwxYLaTXRHOMa
         JP9h6Xd8Q6X27teawRw7BdIgHkaR4r0CfGJAbEiakKagW4CDC/LKF2QUac52IE0uLv5d
         lGo43+XkaipJAu5Bgxf92wm8RtZG74dS0Rf84foVc5Ls7wgijdFGcVJ+hqAptXyXSDRZ
         ImJiSck4bmmkXsIF5/rEY5nrpDtHPhZT5hKEcNlDoxqIP8Of0eB4kskHbPAP+7IC+3b7
         UlV8RZVZi9UoYSRISRsKSDxQRJ7t6pmOCQGxsJbyyYDPgVnhftBmWYT/y7Nd67v1iXCY
         iu8w==
X-Gm-Message-State: AOAM531aHlo87tXwu8x+25GWrA1GP+W+0dYCjQaRMETm2cUiam/Z2vTE
        z+hq/2GJXHv3C9BbzH7kB0Sh3SByHeQ=
X-Google-Smtp-Source: ABdhPJwc5FBX90jkVwJYgAwVtutuFl6P32uhxQ/iCq23HCr4p83MYw5Db//ojxkm0spnpD+T1LswNg==
X-Received: by 2002:adf:fd0c:: with SMTP id e12mr269906wrr.61.1610049699351;
        Thu, 07 Jan 2021 12:01:39 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b127sm10674216wmc.45.2021.01.07.12.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 12:01:38 -0800 (PST)
Message-Id: <2ffb93c37ac7e9ca8697a43c41d618d987db4f47.1610049687.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.git.1610049687.gitgitgadget@gmail.com>
References: <pull.835.git.1610049687.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Jan 2021 20:01:20 +0000
Subject: [PATCH 11/18] merge-ort: implement apply_dir_rename() and
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

