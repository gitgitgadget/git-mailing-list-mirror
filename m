Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B84C433EF
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 06:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236958AbhLJGZs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 01:25:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbhLJGZr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 01:25:47 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E00A7C061746
        for <git@vger.kernel.org>; Thu,  9 Dec 2021 22:22:12 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id d9so13248759wrw.4
        for <git@vger.kernel.org>; Thu, 09 Dec 2021 22:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vCopqJhOEwyJdNyjuH1cCE5D7eUvD3sE47sI5uZXovE=;
        b=Wa6vq0DnReXgEPcMP+3IeRkxRH2SfgLN8KbqKrPfXL34/iqRatBRxTRS6QoSY6gkTH
         N8hsmxTJcBY7qzLvTkTashm6Iz69EhdfhrvMhEKPM91A5/lr2SgKFZbMY1WAKNrcM4m4
         G5l0RQmapyrnY6OzJ1wl/Yh8th5d10SuBRBGrPju1lIM0MuwV3sGFw9Nz++Ig/JTP2T7
         yNByP8cI3DCYBTKXeUq2qMK3Sv7US9pbBIVcQx484Ue32t/x3/DGuORnfE3D3ui69EbB
         cVj9ODNr4Dew+a3P+zrNwFm2Uf0jBm/9ss4wLt9hfyYheNuljC05glAQzyijRMpFPzFt
         HoNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=vCopqJhOEwyJdNyjuH1cCE5D7eUvD3sE47sI5uZXovE=;
        b=NtBdgEDdGlq20uIVdiR4UjUUE4i0AsEECzM7JZ+b9T96jp4zHluwsAWomYLGbMAIrR
         y82ADKXu1x3+fFFXq5UIJKePrAZvTe+EYX1PF3qAU1acNGN78PdCJ/qwxiZgWXXBtS0a
         uFZzBKXPIoNe3QXRwmTOHeQQbmMFSZu6x0DtWOEWEatvkfPclucT5xzddk9vOIbf0oEB
         EJT7rGJfMsyyvPuTLpokAGpUJv4oIABnj6nGutrozKdJ/+QRn5i4jZ+d7Z9kFfSCOk6M
         /xXqxuTQcZY4EX7NCdRHG+WBjjMiXwJX2c8zibuAgIcG9RpQas1dO+7GiVGQNLoCROi8
         A6HA==
X-Gm-Message-State: AOAM532M8MwMUkhM2XQEVixagzTNL7jgRrWuJZ2kvfKJlr8wQBDMEMij
        DlTeS5JPLkBUSov33b5z1yW5SPLR/sM=
X-Google-Smtp-Source: ABdhPJy23gymulZZlGSGtmR2MFy3EtsKNmkxo5cXaCzClhAtsptRSXFM+1a/1dV68ix9SJvL67VcJg==
X-Received: by 2002:a05:6000:18a7:: with SMTP id b7mr11792516wri.308.1639117331383;
        Thu, 09 Dec 2021 22:22:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d8sm1525567wrm.76.2021.12.09.22.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 22:22:11 -0800 (PST)
Message-Id: <e9f6be692db40978b835e7298c1a1c664566ec84.1639117329.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1095.git.1639117329.gitgitgadget@gmail.com>
References: <pull.1095.git.1639117329.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 10 Dec 2021 06:22:08 +0000
Subject: [PATCH 1/2] checkout: handling branch_info memory leak
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
        <pclouds@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

On the checkout code path, we dynamically allocate
memory for `refname` and `path` in `struct branch_info`,
but did not free their memory at the end. So introduce
branch_info_clear() which can free branch_info memory.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 builtin/checkout.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index cbf73b8c9f6..3eeac3147f2 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -103,6 +103,15 @@ struct branch_info {
 	char *checkout;
 };
 
+static void branch_info_clear(struct branch_info *branch_info) {
+	if (branch_info->path) {
+		free((char *)branch_info->path);
+		branch_info->path = NULL;
+	}
+	if (branch_info->refname)
+		FREE_AND_NULL(branch_info->refname);
+}
+
 static int post_checkout_hook(struct commit *old_commit, struct commit *new_commit,
 			      int changed)
 {
@@ -1578,6 +1587,7 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 {
 	struct branch_info new_branch_info;
 	int parseopt_flags = 0;
+	int ret = 0;
 
 	memset(&new_branch_info, 0, sizeof(new_branch_info));
 	opts->overwrite_ignore = 1;
@@ -1768,9 +1778,11 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 
 	UNLEAK(opts);
 	if (opts->patch_mode || opts->pathspec.nr)
-		return checkout_paths(opts, &new_branch_info);
+		ret = checkout_paths(opts, &new_branch_info);
 	else
-		return checkout_branch(opts, &new_branch_info);
+		ret = checkout_branch(opts, &new_branch_info);
+	branch_info_clear(&new_branch_info);
+	return ret;
 }
 
 int cmd_checkout(int argc, const char **argv, const char *prefix)
-- 
gitgitgadget

