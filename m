Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C4DC433EF
	for <git@archiver.kernel.org>; Sat, 29 Jan 2022 18:07:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353008AbiA2SHc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Jan 2022 13:07:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238996AbiA2SHW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Jan 2022 13:07:22 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE43C061749
        for <git@vger.kernel.org>; Sat, 29 Jan 2022 10:07:22 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id bg19-20020a05600c3c9300b0034565e837b6so5958439wmb.1
        for <git@vger.kernel.org>; Sat, 29 Jan 2022 10:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=EZj5VfrzAVp/cg0U4WT3oO9/KM+ihWSlfca29Ha9atg=;
        b=IBJNO855odHWn0DjckLP0KlgUWBu/Prz5vqlqhiHW72V9h7hkGSt9pgovQnjTk61rG
         Vk4j5IDBVZUr1/EuVDXrfGl1PVz96tkioLm2KT8ZBjDRnbe/TybTTTw7XckaaZtd1RyV
         UYtvC85OxRMk1KC9ghGtriu8PsjD97cbXFXTycw5qloHBL12eodBdLI4bg88w72EXrkS
         u3XRPc9iwJDyPqwtBQZ1NTbFRAru35AvpjjkikXK4x6qjmEj5pNvul0UVZt8K1f9qa0/
         wxkFeKC3AhlTxpHaXJLYdVurJca9qjrFsSYUWlsr/GF61L4EBwWwGDW8llNdGvbx8Y8U
         VBFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=EZj5VfrzAVp/cg0U4WT3oO9/KM+ihWSlfca29Ha9atg=;
        b=Yh6DLYC3AeR8xsxjIVChIOIzDrZGRWSzllWM+2o9hQQFdaK7Z1z3cnWFlRYfImgTYh
         wegWWHRNqEmjDL6Jz5ZjybNChQw/3oAqqo/8TwlXY6ZPGfbu8VlOmshHgxTSWt0/KytO
         pHMv+t7UsmdrydbvF6bBnUulrd/nDb9xbbVAz/dL0o00uuxkIZEWJAZyuICkR3DbyL2b
         hqPr/wz86NUgmY+f0pS0eEaOllSsqrDPxslUi9KBqkHDPoxXhGD+rAtXwuL9EjoRQvnX
         9FJ1quBwfX2kJr/BnwkUP8Oj/lpEW6UOLnMkrbqBF07RPAJCoo0RAsZ5BBSKSLydgcye
         Gi6g==
X-Gm-Message-State: AOAM5305+ePUucQUnxkCODHPgtk8cVWAndrJPFQ4oLHM4FiEj6pHZoN9
        lMFHh7dDNsaNwgTd/6wBxlkEOMKkaOM=
X-Google-Smtp-Source: ABdhPJwVWMMjJXaqVlLCbVk+kKo3M5np+AK8Yc7gKxYHjpOO+x7tMWHIeVsCEny+OZ+IAKXWw58z6w==
X-Received: by 2002:a7b:c4c5:: with SMTP id g5mr11726894wmk.139.1643479640608;
        Sat, 29 Jan 2022 10:07:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a6sm7525893wrx.101.2022.01.29.10.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jan 2022 10:07:20 -0800 (PST)
Message-Id: <593d0c00b574aa8097badd45d786097ec8601e18.1643479633.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1122.v2.git.1643479633.gitgitgadget@gmail.com>
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com>
        <pull.1122.v2.git.1643479633.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 29 Jan 2022 18:07:07 +0000
Subject: [PATCH v2 07/13] merge-ort: allow update messages to be written to
 different file stream
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
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

This modifies the new display_update_messages() function to allow
printing to somewhere other than stdout.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 9 +++++----
 merge-ort.h | 3 ++-
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 1ada3198390..d28d1721d14 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -4236,7 +4236,8 @@ static int record_conflicted_index_entries(struct merge_options *opt)
 }
 
 void merge_display_update_messages(struct merge_options *opt,
-				   struct merge_result *result)
+				   struct merge_result *result,
+				   FILE *stream)
 {
 	struct merge_options_internal *opti = result->priv;
 	struct hashmap_iter iter;
@@ -4263,13 +4264,13 @@ void merge_display_update_messages(struct merge_options *opt,
 	for (i = 0; i < olist.nr; ++i) {
 		struct strbuf *sb = olist.items[i].util;
 
-		printf("%s", sb->buf);
+		strbuf_write(sb, stream);
 	}
 	string_list_clear(&olist, 0);
 
 	/* Also include needed rename limit adjustment now */
 	diff_warn_rename_limit("merge.renamelimit",
-			       opti->renames.needed_limit, 0, stdout);
+			       opti->renames.needed_limit, 0, stream);
 
 	trace2_region_leave("merge", "display messages", opt->repo);
 }
@@ -4313,7 +4314,7 @@ void merge_switch_to_result(struct merge_options *opt,
 	}
 
 	if (display_update_msgs)
-		merge_display_update_messages(opt, result);
+		merge_display_update_messages(opt, result, stdout);
 
 	merge_finalize(opt, result);
 }
diff --git a/merge-ort.h b/merge-ort.h
index e5aec45b18f..d643b47cb7c 100644
--- a/merge-ort.h
+++ b/merge-ort.h
@@ -86,7 +86,8 @@ void merge_switch_to_result(struct merge_options *opt,
  * so only call this when bypassing merge_switch_to_result().
  */
 void merge_display_update_messages(struct merge_options *opt,
-				   struct merge_result *result);
+				   struct merge_result *result,
+				   FILE *stream);
 
 /* Do needed cleanup when not calling merge_switch_to_result() */
 void merge_finalize(struct merge_options *opt,
-- 
gitgitgadget

