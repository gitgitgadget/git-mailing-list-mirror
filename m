Return-Path: <SRS0=OIeF=BS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB4EC433E0
	for <git@archiver.kernel.org>; Sat,  8 Aug 2020 17:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E155A206CD
	for <git@archiver.kernel.org>; Sat,  8 Aug 2020 17:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rfzxMSKO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbgHHRBf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Aug 2020 13:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgHHRB0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Aug 2020 13:01:26 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48387C061A27
        for <git@vger.kernel.org>; Sat,  8 Aug 2020 10:01:26 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id c15so4401872wrs.11
        for <git@vger.kernel.org>; Sat, 08 Aug 2020 10:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7plxrKhMKl9+/sbsqXF9IOcefO2M93xllUwjg2qsUM0=;
        b=rfzxMSKOhRWwxDzNVnywuzfw29aVaLS/neWZxPvZ6X00FTak+RSFnCCZJ6ee9QWRZA
         kBaMAkILEFdylOYsqX1ZiSQcDcCMH1Evq9gCx3NEdJyQrKrzpMWwtKetvOK2rTtlThiB
         3SyxadBJzUdpIa4lSyVCHOJ1ie+D79HCoUQpa9UmUFwMM9ciubZ3x3P5IZJ5jFnQMTWy
         /fLDUixbz1fbI4bJ19DtBdXYULmx1xffaWAACiJ9SMuYR5pPa8lRW9hcLmJQqbZi0D8q
         XaZItuDeFUbmAz+kbxfUThmsGQm8Z1+ED15if7bmcGnTQ26NZOmzfyQxfDF+bhRHMnMr
         R3LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7plxrKhMKl9+/sbsqXF9IOcefO2M93xllUwjg2qsUM0=;
        b=ew2kiNxynJGG7pcWKZZO17U5pMY2txlI0FZXlzjzN3lh31QFNDaQFXdpwexnhbwe+K
         qkPvPVnyjpH0YTZVHYk0uEsBdnjFe1lKjvc/ezRIflVT0tiwIFmOe6gbGqxsEAksTPT/
         EkKslvgcirg1zlh3S3N1ik/7LHv+jgYE57KlnIkFHtzzEiP/3yQOo9Hyv0SG7yU2ZdEe
         1fQVa8n8xEh+oVbg3yYugPzzFsZxpG490nbhFqO7LJHfeBTRjLwn5VFslY8AoIURs8Jw
         NPCtnUXi/MWhfttK1/K68Mui0dIEbStlNNC2zBIEj54oz59w0mUvUFIdFGWOd+J5zqHP
         arDQ==
X-Gm-Message-State: AOAM531+/iJo5upsDaOA0d8oIZuh6aDuxa6yAqmK+obsR8eGYxLAr5YX
        P7DF625fzI3NCvgVSl2sYm60HnEj
X-Google-Smtp-Source: ABdhPJxfAKXIz8ZdAPl8JpfaenIFgqJ0S0QuvNPjVveV8vN7taEbJqHqTE7/t6I/EWkyY1/HuUhs8Q==
X-Received: by 2002:a5d:4a0b:: with SMTP id m11mr16691247wrq.407.1596906084748;
        Sat, 08 Aug 2020 10:01:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k10sm13962887wrm.74.2020.08.08.10.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2020 10:01:24 -0700 (PDT)
Message-Id: <621c9a159ef6e64a5fd6b6fdcac01c0c7aa57d4b.1596906081.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.827.v2.git.git.1596906081.gitgitgadget@gmail.com>
References: <pull.827.git.git.1596644952296.gitgitgadget@gmail.com>
        <pull.827.v2.git.git.1596906081.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 08 Aug 2020 17:01:11 +0000
Subject: [PATCH v2 02/11] t6418: tighten delete/normalize conflict testcase
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

The testcase only required that the merge complete without conflict,
without specifying what the correct resolution was.  Since normalization
changed this from a modify/delete to a not-modified/delete, the correct
resolution is to have the file be removed at the end.  Add a check for
this resolution.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6418-merge-text-auto.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t6418-merge-text-auto.sh b/t/t6418-merge-text-auto.sh
index 5e8d5fa50c..517f7a450d 100755
--- a/t/t6418-merge-text-auto.sh
+++ b/t/t6418-merge-text-auto.sh
@@ -211,7 +211,8 @@ test_expect_success 'Test delete/normalize conflict' '
 	git commit -m "remove file" &&
 	git checkout master &&
 	git reset --hard a^ &&
-	git merge side
+	git merge side &&
+	test_path_is_missing file
 '
 
 test_done
-- 
gitgitgadget

