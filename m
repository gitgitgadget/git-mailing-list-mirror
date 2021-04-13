Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F0BC433ED
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 14:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CB0F613AB
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 14:02:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237624AbhDMOC3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 10:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237373AbhDMOCF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 10:02:05 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 635DCC061756
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 07:01:44 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id r7so4589478wrm.1
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 07:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GV149/jGnSYB9xubiM2m3Ys9KHOjOAzJNLFmGygbCus=;
        b=hKvNYA8yLOZA0AHCnMHGdOA/4lnxkaDUrB9xhA36jPRuVHmJLhDcd9s7BDHdcTJRfe
         zS8i24IKHF0ZLS8r5hk103IVFLhe8kevDSCIXRbHNbe7Offxhpi4VyobjwkhHZMmp6M4
         q84tXWpjRkhEXgLABlwyp+jgbyVAzrf3Vos7eeJ8MA+JAY8DABAvz5N3aivsxfyR996R
         7q4gwPSCbJeY6IWONGT0CkNE1KexNZCI1CwHB9v/fj3wg6A9x54t4YeEm5uWaswwoyQU
         ZQPEiKLIykkf3wB1vGJPGHlwIEfx4b7dpJpgZcfNG1ArK+q/aoRc0iSgZIAFJGYw/fU6
         a/BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=GV149/jGnSYB9xubiM2m3Ys9KHOjOAzJNLFmGygbCus=;
        b=EtX3rCaCZlb2K5opDG5ABvhL8biQjTrdAP/rQN66xOvuEjJZ/LLs90TDmyHrajGwY1
         wgJbrBHo1RAyow79QMk1gnwixxZUVL4ZU+aRY8rQ+GhJW1FkdMx5LiV0d5DuMFdeEhKq
         sISEs2iE71WLY/efM4MxtzSC6I12+HEi2JARY3fa5Hdm+wsPs/kz8Rdx5rDSOByClh07
         bPKY0JR2lyZActRYWLyWdU91UsABpPdV+cb5ngJ/nFJj8sO1tgUKACDtrfMgb51Q1jtv
         SCuY1uoMOUof/SHH6KFpE+W8bs8XdHkgi5+UsXypv3oOlkjzyS3lyzDDZBmgQkOKlnyN
         A9OQ==
X-Gm-Message-State: AOAM531xAsa+qfFi2TRn0PnQvzn08fB7/Ei/EgiF2vpSEBjBoGA1Yueu
        sJOPL0L3QDXQ8f2qImoZn+d96jRcYbc=
X-Google-Smtp-Source: ABdhPJxxmAqDzCvCSuGaRWujWu7v75ct6FZfP8kh5gVtjxgfmZYYKopSNfCPxLddqPQVWM6SRzhYjQ==
X-Received: by 2002:a5d:484c:: with SMTP id n12mr519939wrs.377.1618322501918;
        Tue, 13 Apr 2021 07:01:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j6sm2517424wmq.16.2021.04.13.07.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 07:01:41 -0700 (PDT)
Message-Id: <28ca717e6526f0b66df696f3237d72b9bee2ffc3.1618322497.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.git.1618322497.gitgitgadget@gmail.com>
References: <pull.932.git.1618322497.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 13 Apr 2021 14:01:30 +0000
Subject: [PATCH 03/10] dir.c: accept a directory as part of cone-mode patterns
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When we have sparse directory entries in the index, we want to compare
that directory against sparse-checkout patterns. Those pattern matching
algorithms are built expecting a file path, not a directory path. This
is especially important in the "cone mode" patterns which will match
files that exist within the "parent directories" as well as the
recursive directory matches.

If path_matches_pattern_list() is given a directory, we can add a fake
filename ("-") to the directory and get the same results as before,
assuming we are in cone mode. Since sparse index requires cone mode
patterns, this is an acceptable assumption.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 dir.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/dir.c b/dir.c
index 166238e79f52..57e22e605cec 100644
--- a/dir.c
+++ b/dir.c
@@ -1378,6 +1378,11 @@ enum pattern_match_result path_matches_pattern_list(
 	strbuf_addch(&parent_pathname, '/');
 	strbuf_add(&parent_pathname, pathname, pathlen);
 
+	/* Directory requests should be added as if they are a file */
+	if (parent_pathname.len > 1 &&
+	    parent_pathname.buf[parent_pathname.len - 1] == '/')
+		strbuf_add(&parent_pathname, "-", 1);
+
 	if (hashmap_contains_path(&pl->recursive_hashmap,
 				  &parent_pathname)) {
 		result = MATCHED_RECURSIVE;
-- 
gitgitgadget

