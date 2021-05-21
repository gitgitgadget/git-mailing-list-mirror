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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB24C433ED
	for <git@archiver.kernel.org>; Fri, 21 May 2021 12:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1838613D6
	for <git@archiver.kernel.org>; Fri, 21 May 2021 12:00:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbhEUMBs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 08:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234416AbhEUMBP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 08:01:15 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE17DC061763
        for <git@vger.kernel.org>; Fri, 21 May 2021 04:59:49 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id b7so10392017wmh.5
        for <git@vger.kernel.org>; Fri, 21 May 2021 04:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IKPjTUqki+7odL+EABJRxmdzP4v6AWl9RXlIatOMDLM=;
        b=GWcqxVbAtIevRvM0kdQxvEuUHoHozSiDIaNxDoCq6NA2fnnbRe9ZJuHlsiOqRTSD4O
         pMvEMZ5Wnr8Ymo9qEzsRi/9xHoc7kStYRdyZuHTa+fAw68hd6GDO7SP3DDk/Yoqbni87
         rD1y+14ik2PztLGKaHcHog4eLykzpVo8gONL6n9dvqQ47ktU2ScyBw10Z5cJZmAi+AzV
         0pvma3AoB9Rt7N4StW9cqBfOixGpoIerj1E7YndP2vXTyuEbMl6Bra1WO7T9svTpFlzQ
         MmvJoaO+xfo85agIS93iR6P4AWZUIXxf22r8ZlWL+jYN3m0INKgqzHTDeSdznmVGuFqq
         Ww+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IKPjTUqki+7odL+EABJRxmdzP4v6AWl9RXlIatOMDLM=;
        b=Bwct27KtStnGYEs2sdbLoo+L0PI9p5SHX8X5CHRyQtwHvSk8VRsYZ+LBGJ6QM0/JA4
         1guujGYPBO8a/qN6aw7svtbDLjJvvbSGCK1NvgZMsVqJyteoNY83IrpU91N4iLDmdkUD
         BVjHS0KO+1bn7OAIWcjdLo3kLKILyI3B4QnWoM/UeLGoOke2DxGiMHqEyBLxU2dO6rEq
         C17A3bxC7Ea3P9FMc0p0m1UXNicew2u4WtEVlBOmaDLcdWb/UmuwqGBqqm41l8a+uYEC
         SG6/eoyAu2dUfCiaecEJZte+2/yaaU9hf+sb+9j2UEkRAcoGdtHgCULm5KAeRFMNcbt7
         AIwQ==
X-Gm-Message-State: AOAM531aR3J5dKtlh6YhH3kd+H+LUQ1O4/09zAczS9aHNcG0Qfjth1yp
        GbSQJrv/NgyeVnOVT8qUiU7JE4WWvFY=
X-Google-Smtp-Source: ABdhPJwDuYtm7f9xiRJE92M4ar0JNOefHjBjuqkYLrt+8nbFUK7C2wCs83uN4U6KBY82ZumG/83iXg==
X-Received: by 2002:a05:600c:410a:: with SMTP id j10mr8617376wmi.5.1621598388170;
        Fri, 21 May 2021 04:59:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z12sm1924855wrv.68.2021.05.21.04.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 04:59:47 -0700 (PDT)
Message-Id: <2cc3a93d4434d546cf385fa2c902064748f1b2b6.1621598382.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v4.git.1621598382.gitgitgadget@gmail.com>
References: <pull.932.v3.git.1621017072.gitgitgadget@gmail.com>
        <pull.932.v4.git.1621598382.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 May 2021 11:59:37 +0000
Subject: [PATCH v4 08/12] dir.c: accept a directory as part of cone-mode
 patterns
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>,
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
 dir.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/dir.c b/dir.c
index 166238e79f52..ab76ef286495 100644
--- a/dir.c
+++ b/dir.c
@@ -1378,6 +1378,17 @@ enum pattern_match_result path_matches_pattern_list(
 	strbuf_addch(&parent_pathname, '/');
 	strbuf_add(&parent_pathname, pathname, pathlen);
 
+	/*
+	 * Directory entries are matched if and only if a file
+	 * contained immediately within them is matched. For the
+	 * case of a directory entry, modify the path to create
+	 * a fake filename within this directory, allowing us to
+	 * use the file-base matching logic in an equivalent way.
+	 */
+	if (parent_pathname.len > 0 &&
+	    parent_pathname.buf[parent_pathname.len - 1] == '/')
+		strbuf_add(&parent_pathname, "-", 1);
+
 	if (hashmap_contains_path(&pl->recursive_hashmap,
 				  &parent_pathname)) {
 		result = MATCHED_RECURSIVE;
-- 
gitgitgadget

