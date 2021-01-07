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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D327C43332
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 21:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46018235FD
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 21:38:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbhAGVhj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 16:37:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727725AbhAGVhh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 16:37:37 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25DE5C0612A3
        for <git@vger.kernel.org>; Thu,  7 Jan 2021 13:36:24 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id t16so7051092wra.3
        for <git@vger.kernel.org>; Thu, 07 Jan 2021 13:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=VsDDCUfuM3/U0xqHj0cutD4REsVRsW0DC2i4mKl9dK0=;
        b=jcq4s1hIR7I/rmuUKJPyjl1QtZM5egrNNDfx+WeKU3770ZGi8DzQGuolLvLTTlLNBc
         FLzJYqJCePx2Q4IxCkEx+YIK0OJwRgrPs9t1WUMvC6PLc1MTbcYJPE7jIDy0xkFx2DAy
         +520ggMEEt6jgNWHzFN0ApfdemJfeCKZawpNFtGzj8dU4miGqzWnjZPTzEZskocNFbPi
         APy2MRryDXD6QZZB80y8vT1QUPNRmlplB2yDxgQ9E9B+B+7GWkmGyccCteHp7eCJYRMi
         hAPLd3KkauZh7lPBAeGzlQJYu7bI9gZ/0nyUfGUlB3jbO/uI19ABD8hR95jGxLBbj2C0
         d82Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=VsDDCUfuM3/U0xqHj0cutD4REsVRsW0DC2i4mKl9dK0=;
        b=R89ktbBw1a3OpE/ht7KhBK06tkXSG20jLSSDK+M4nCxehPri827F2JOgmpSKLkFCaB
         7DO32gQAfbN4WTn+0gUmnzAjZQViEDxg01Qr/f6GO0VAJvN/WJLZ990369tezhxSWJA2
         q/Zo0ZcXc5I+QD2hV3BMIC0dy+cI11vwhFD8AWEJNUTllhCc6oQuj/nwPBXETfAfsNXy
         NOrO1ET4Dt8zwl9WfHf2+g+i8yVEdA8sifiAzlAZ2Vy0CQ6zSHA0bjh7u5saLSF1TxkA
         dGSO7I0iS5U2EjgUF9xYAK5nLJh21cpTCx8YPS3xXTHC43NmLpz9iV77N0aRIU6c6ZS3
         y9nA==
X-Gm-Message-State: AOAM5336wrI0zi7mqh+b2ogXpLAyDgdJ5/t8q7VUpf97XVSeEp7AWDlg
        FVDlakGe9lh2qxOpTWNdJrO0mhOc+dA=
X-Google-Smtp-Source: ABdhPJybvP0H8L0gNxz/DEZh1LCBpZJ6uLCDTJFIS6xtk8v/ctAUef5LSkN0A9sGAseiFdSsx8VYJw==
X-Received: by 2002:a5d:504d:: with SMTP id h13mr558774wrt.246.1610055382759;
        Thu, 07 Jan 2021 13:36:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c16sm10556349wrx.51.2021.01.07.13.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 13:36:21 -0800 (PST)
Message-Id: <4b912f2c0251b7d19ba74f0af5563605f6ad9667.1610055365.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.v2.git.1610055365.gitgitgadget@gmail.com>
References: <pull.835.git.1610049687.gitgitgadget@gmail.com>
        <pull.835.v2.git.1610055365.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Jan 2021 21:36:02 +0000
Subject: [PATCH v2 14/17] merge-ort: add a new toplevel_dir field
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

