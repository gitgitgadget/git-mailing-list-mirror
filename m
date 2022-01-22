Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA3A6C4332F
	for <git@archiver.kernel.org>; Sat, 22 Jan 2022 21:56:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235003AbiAVV4M (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Jan 2022 16:56:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234989AbiAVV4I (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Jan 2022 16:56:08 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90CAC06173B
        for <git@vger.kernel.org>; Sat, 22 Jan 2022 13:56:07 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id v6so6477793wra.8
        for <git@vger.kernel.org>; Sat, 22 Jan 2022 13:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=s/FNUD3Nfv1aJ56di/sqnJE/jJBUPQEIKWoIKlAJYVg=;
        b=TUGiTkabHqbZ3JXqPj885ckEpuws8CtmQy/AICerh5snxUhdQKRc5QvobsSb9Y6KkJ
         iaN9vQq0XESc0L2AGBntdDva9NkW3z9XA+PhWMhjkdC6xbw1eg7vfCyHDB92OKRBoaBg
         3N8tcj9wPfdqDHorfEJGipJGiW8B6D4+NZD3yycioMsRoIq8e2ka1PIGwabCwIKu6kJL
         vn79xsIXxZkySkHwEIZ4luKDVKZgbLpt1C6sq/8bvvAOh+6ulHFN9DW37Ey+npD18rf0
         DMPJFeb9cIZuT/uF5vJ1M5K1+WRwWcJT5smiBSqr1xZfJO4Vci3cr9GNqi6wtiF4IohT
         DoGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=s/FNUD3Nfv1aJ56di/sqnJE/jJBUPQEIKWoIKlAJYVg=;
        b=mWrX2yxPh4xZ/CyVvjzGNBGLfO9PE+deawAyDrOsYdOtGrI4tX7JwG7O4gx4LjyBtS
         bbSicP/l3XgBGpP4VeM8rL0F9SvF5QRlKwG3KbMC2f5AR5wA0DzSGVxX5LN8RUy/34y9
         a3IQJ10JZ3VNxf7x0/Afsrr4mb87jvE4s5YcgtCQtdPqCor1cPPnQX3rslU3p5s+4s4q
         1/5M9Zm4OBqMPAzrmwbBernoDEVHkNJgWO+us5Vc6angGgZjpBytwu5jFmuzFiRziSW7
         rorU6k1xaHAgNlngFydceHLrvXxtM/3c4yn742rJnQiWS/SqcqHPHCZf9XYWZwU5TCIy
         vwjQ==
X-Gm-Message-State: AOAM530ucTyFXHDV3Z+m4uVUupUDVFad4KCxrdmRNZbeRxRAhBK5mRkm
        DIpRYhG0oatODQadUH9+jigAPw0anwU=
X-Google-Smtp-Source: ABdhPJwxZqXPFCwokaI11TMnnz1ACOrU0WLipqPyJqSUyiGUBsZSMQ2uBYiZ8CtF1u8qaIhzbcBlHg==
X-Received: by 2002:adf:f383:: with SMTP id m3mr8542819wro.348.1642888566214;
        Sat, 22 Jan 2022 13:56:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n8sm9457wmk.18.2022.01.22.13.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jan 2022 13:56:05 -0800 (PST)
Message-Id: <4780ff6784d426bf0a96859ef9bf9c14e87d5f50.1642888562.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1122.git.1642888562.gitgitgadget@gmail.com>
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 22 Jan 2022 21:55:52 +0000
Subject: [PATCH 02/12] merge-tree: move logic for existing merge into new
 function
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

In preparation for adding a non-trivial merge capability to merge-tree,
move the existing merge logic for trivial merges into a new function.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/merge-tree.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 06f9eee9f78..914ec960b7e 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -366,15 +366,12 @@ static void *get_tree_descriptor(struct repository *r,
 	return buf;
 }
 
-int cmd_merge_tree(int argc, const char **argv, const char *prefix)
+static int trivial_merge(int argc, const char **argv)
 {
 	struct repository *r = the_repository;
 	struct tree_desc t[3];
 	void *buf1, *buf2, *buf3;
 
-	if (argc != 4)
-		usage(merge_tree_usage);
-
 	buf1 = get_tree_descriptor(r, t+0, argv[1]);
 	buf2 = get_tree_descriptor(r, t+1, argv[2]);
 	buf3 = get_tree_descriptor(r, t+2, argv[3]);
@@ -386,3 +383,10 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 	show_result();
 	return 0;
 }
+
+int cmd_merge_tree(int argc, const char **argv, const char *prefix)
+{
+	if (argc != 4)
+		usage(merge_tree_usage);
+	return trivial_merge(argc, argv);
+}
-- 
gitgitgadget

