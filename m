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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39271C433E6
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 20:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF9EB23444
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 20:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbhAGUCT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 15:02:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727833AbhAGUCR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 15:02:17 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99BBAC0612A1
        for <git@vger.kernel.org>; Thu,  7 Jan 2021 12:01:43 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id y23so6579099wmi.1
        for <git@vger.kernel.org>; Thu, 07 Jan 2021 12:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=VsDDCUfuM3/U0xqHj0cutD4REsVRsW0DC2i4mKl9dK0=;
        b=jhYRmY/syqj36Z6Pg3EPgp87yIVQ7A+nOezf0PPq/2EriFTAfk61aNPA2A/kHq8JS1
         wyvlMYv56p//Te3N4Zpy/cTcIvdh1kCrNyPVDnUfnKSiQ5TfH8tfIkNnx0Myy/wFVH2+
         9FvTA+msihX2E8S0gNlYx7eT/HOqyruUw+YWiWit15PMriQfK6er9U3sxMU1Btu6WLqx
         Y7nbyEts8+lEtd+4PS0KCklAPsw9eA64IrTbJq+jNOf0XNL12MlprV3Fpx4h5BLh6JPW
         iSeW0aeXT0YgZ1ZpuwCG++y0XwKYJrtZDbOVRdiILk7TzQ0Zknm1BKgC/f7NFPTBE5oY
         RpsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=VsDDCUfuM3/U0xqHj0cutD4REsVRsW0DC2i4mKl9dK0=;
        b=aYTcw2JmP8Oso8Es2kl6Wj8v58PhESjG3U1S273EbMqkSXV2ZYDLtzbgL13Vca2bqh
         Sy61N0IprAVkzjoU0ProrwzgkiExrurJGCJlTRfuufHxuK3qJKOry5TyvlY6/tFY4VD9
         9lz6yWVLX7xxKEgkhP7W7dq+og40/RuyMoFnNLimCSrkEafhdN5fuVRHz373SZ8YQJWT
         /2jMbCHbQLxtONxHuz+utMfTLB7EWOmX632OnOJls3LqOlqNiScIH4Et/BZlB1HiQaH0
         1mJc5XzY7MaaPujiJzbrf6kzWuItJWfk30zCM7958JI45RktQMLt2Bzmswqj8wrIc1Q4
         6MRQ==
X-Gm-Message-State: AOAM533kgMneIiREioIQE8jMxvhxHSaI+Lht01mr5+iZchMOJzAuxZyD
        lQPSeaf/zyZCJ6+VNjRYT+EDMLH3XQ0=
X-Google-Smtp-Source: ABdhPJy2t+ZwJmXiXtIQi0LVpLgPtf3IjFe6d6k0Q6zSdtD4j38xTRT/QeF38EqJzelF+8OrqrZCbA==
X-Received: by 2002:a1c:24c4:: with SMTP id k187mr193858wmk.14.1610049702199;
        Thu, 07 Jan 2021 12:01:42 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l1sm10008383wrq.64.2021.01.07.12.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 12:01:41 -0800 (PST)
Message-Id: <4b912f2c0251b7d19ba74f0af5563605f6ad9667.1610049687.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.git.1610049687.gitgitgadget@gmail.com>
References: <pull.835.git.1610049687.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Jan 2021 20:01:23 +0000
Subject: [PATCH 14/18] merge-ort: add a new toplevel_dir field
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
index 43cfee29bd0..19850ffc0ab 100644
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

