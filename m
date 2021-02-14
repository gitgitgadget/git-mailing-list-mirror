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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D2DCC433DB
	for <git@archiver.kernel.org>; Sun, 14 Feb 2021 08:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C54564E23
	for <git@archiver.kernel.org>; Sun, 14 Feb 2021 08:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbhBNIAa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Feb 2021 03:00:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbhBNH7t (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Feb 2021 02:59:49 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15CECC061788
        for <git@vger.kernel.org>; Sat, 13 Feb 2021 23:59:09 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id x4so4933045wmi.3
        for <git@vger.kernel.org>; Sat, 13 Feb 2021 23:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JN0wvt58itYZYUkNRwdYTTFw6FJIsIxDn0Jcd0Za3ok=;
        b=FYKmwOP49GzR75K4RaLIAzd5UDhBHxkstlRXw901PVYRCkNnYLghhFB5jH8aPd1zFp
         LOyZNZknAxNo33Z3SeObb7jzA9oUd3jxyMm2Ecz+ECFCw4CoTANfwMOctVc+DeG5a3B7
         to3fmyjCFleUpbrkYFsOWEKaEwSeFVT169Wxq1jUl6xhtwz5Pm4ohMTi1a4juXzyFsZE
         PnwxLFYosN/uSAPc6MAtTBvAE8KWt6ip+TxzJDE2aKN5Fibf/OhVLFjcuZeMZfg+R4JS
         bPkacm0O+xkpgT/R7DV9MIul0Ncp2xWW+vPW9rdwDv3E9BCiMQzYPbpkykyIV7yAGMXu
         BUxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JN0wvt58itYZYUkNRwdYTTFw6FJIsIxDn0Jcd0Za3ok=;
        b=dp0o4fXDKgMKbm9bV8rI/9WhxDtSxmEvCvftd9OCVV8qYkzohn8qbbTew2YJP+3hsO
         FfU0oDzrC2yYodBHUHKUr8rG2bHWf80FlWdXtaQVlE551Lwy9gFeoanbvp3bmbaesEu+
         JXHRKLkmTLNAEVHgfKkR2ygflhLcGiLI+9iLPdzNFqzzz0AvWQy2CaCsnorgHNLPtXaD
         xAPh4UgVuSLx6lZTfNs7Ecr7MZ625A7tuli8EB3tedB1DFj62Np3r0AAItEeGBbcYVTT
         QhhERrKvjFnP4HoIWhlesbA7+IAZsSIb+gQES9xH557w6JiSBsic4d2NWOSsbcCeLTj3
         U4ew==
X-Gm-Message-State: AOAM530/L+wIOLqg0o1xCe2FuVY0utyrXDCUr/X3nGDts1XiyKWBNXv+
        aGK/E5aEO8A5300b4k+8c3SvlEMrjzw=
X-Google-Smtp-Source: ABdhPJwnIkjD6o6bnjRNKHfbCqUQn4bPvb1JLasLxdvsqq7WmGddulcip9P3uP4S8XMmJvBFHwMWyQ==
X-Received: by 2002:a7b:c304:: with SMTP id k4mr9204471wmj.11.1613289547515;
        Sat, 13 Feb 2021 23:59:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z17sm3659414wrv.9.2021.02.13.23.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Feb 2021 23:59:07 -0800 (PST)
Message-Id: <f7bdad78219de6819d0403f8957e9a0c8b4218bc.1613289544.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.844.git.1613289544.gitgitgadget@gmail.com>
References: <pull.844.git.1613289544.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 14 Feb 2021 07:58:57 +0000
Subject: [PATCH 04/10] diffcore-rename: extend cleanup_dir_rename_info()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

When diffcore_rename_extended() is passed a NULL dir_rename_count, we
will still want to create a temporary one for use by
find_basename_matches(), but have it fully deallocated before
diffcore_rename_extended() returns.  However, when
diffcore_rename_extended() is passed a dir_rename_count, we want to fill
that strmap with appropriate values and return it.  However, for our
interim purposes we may also add entries corresponding to directories
that cannot have been renamed due to still existing on both sides.

Extend cleanup_dir_rename_info() to handle these two different cases,
cleaning up the relevant bits of information for each case.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diffcore-rename.c | 38 +++++++++++++++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 7759c9a3a2ed..aa21d4e7175c 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -507,13 +507,45 @@ void partial_clear_dir_rename_count(struct strmap *dir_rename_count)
 }
 
 MAYBE_UNUSED
-static void cleanup_dir_rename_info(struct dir_rename_info *info)
+static void cleanup_dir_rename_info(struct dir_rename_info *info,
+				    struct strset *dirs_removed,
+				    int keep_dir_rename_count)
 {
+	struct hashmap_iter iter;
+	struct strmap_entry *entry;
+
 	if (!info->setup)
 		return;
 
-	partial_clear_dir_rename_count(info->dir_rename_count);
-	strmap_clear(info->dir_rename_count, 1);
+	if (!keep_dir_rename_count) {
+		partial_clear_dir_rename_count(info->dir_rename_count);
+		strmap_clear(info->dir_rename_count, 1);
+		FREE_AND_NULL(info->dir_rename_count);
+	} else {
+		/*
+		 * Although dir_rename_count was passed in
+		 * diffcore_rename_extended() and we want to keep it around and
+		 * return it to that caller, we first want to remove any data
+		 * associated with directories that weren't renamed.
+		 */
+		struct string_list to_remove = STRING_LIST_INIT_NODUP;
+		int i;
+
+		strmap_for_each_entry(info->dir_rename_count, &iter, entry) {
+			const char *source_dir = entry->key;
+			struct strintmap *counts = entry->value;
+
+			if (!strset_contains(dirs_removed, source_dir)) {
+				string_list_append(&to_remove, source_dir);
+				strintmap_clear(counts);
+				continue;
+			}
+		}
+		for (i=0; i<to_remove.nr; ++i)
+			strmap_remove(info->dir_rename_count,
+				      to_remove.items[i].string, 1);
+		string_list_clear(&to_remove, 0);
+	}
 }
 
 static const char *get_basename(const char *filename)
-- 
gitgitgadget

