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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EFF9C433DB
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 20:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28A5D23A01
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 20:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729085AbhAHUEY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 15:04:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729061AbhAHUEX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 15:04:23 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C26C0612A5
        for <git@vger.kernel.org>; Fri,  8 Jan 2021 12:03:09 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id c124so8690177wma.5
        for <git@vger.kernel.org>; Fri, 08 Jan 2021 12:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7ozUhWR+6ZY3BKwSXupnxTyk689IQLRDfnfUHNVtnhk=;
        b=oLu6q0BG7vCtqohM4yZPVepzNQM8b3Snb+T9tNvlBhNmrkCX9dFGnRx9CXeZ+leMB0
         dkBvGWkB6T9NtG+Href+Qv5sIyrQMzwwImf8UfjFL8p8pHimzBYyoQIF8qzFJgS++j/n
         w0chjDVi+tSNzfXg25CGa6kdvgMNCWejlT6sVHDJ8B44iub04XhEj2RI1qScruOyptXt
         fDzAaLn36byYnRJpcrASV/qZkYY59N4Y2yxEYuHx9UA0i0L1nNiN+HG+sq3uE43JDjU+
         FbpDXVHtHWn0fPlx/rZs07TeX7r5k96M25uCCf9KOU73VCDZBgzgEO6+n78MJtXr4Csj
         6ddw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7ozUhWR+6ZY3BKwSXupnxTyk689IQLRDfnfUHNVtnhk=;
        b=W/BE+gtv0WeU7Fh3i3Au6g8ld4d9ryICmpfUIB8iAEbw/SKlUlmIddnoMptBZx8OA5
         WBzP+Eo5ArLjM/HXHq3h24024PjCHhlieTLjooAG9DfVasuWiSq70uno72vZgV1IGETl
         sVB1HFIo/GHuZtyRPym7gZMUML2nDCFziOMgqFQmoItoOACAvizkrrKmVzHQga+MJ5Ts
         5u/4E9/LJIY3YFFiCcQjiORWrZquSlrO9pk92Jkivjdfhyo/OLsvMrq50vHQpUZkXaPu
         ZYZcIyl269KXAHMOCl6emzlVuowv9QMB0x2zGjEbuIsI/H3jxM65c8cOp3kq3h/mxZWm
         5NNg==
X-Gm-Message-State: AOAM532+iqYDT8FBRb2lRCmNZUxA5EsZ9gSlxRjZFJec+HXNMcW/lnLc
        FezNgZY9znfxXE+fn/wHGHAgEXDSZsk=
X-Google-Smtp-Source: ABdhPJyA/zeNjUIVlqDxnO9/zX+FL58Lca1tmqVfqVDc6go43/u9c1EB/zgcaUgI8s3F5UXwHeQygA==
X-Received: by 2002:a1c:2394:: with SMTP id j142mr4548928wmj.42.1610136187586;
        Fri, 08 Jan 2021 12:03:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e17sm14680772wrw.84.2021.01.08.12.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 12:03:07 -0800 (PST)
Message-Id: <8016b089556c7ae3633480a4e11c0b2ef055cd42.1610136177.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.830.v3.git.1610136177.gitgitgadget@gmail.com>
References: <pull.830.v2.git.1609821783.gitgitgadget@gmail.com>
        <pull.830.v3.git.1610136177.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 08 Jan 2021 20:02:52 +0000
Subject: [PATCH v3 09/14] update-index: use add_index_entry()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com, gitster@pobox.com,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

This is a mechanical replacement of add_cache_entry().

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/update-index.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 87fbc580032..a1e4ee89056 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -293,7 +293,7 @@ static int add_one_path(const struct cache_entry *old, const char *path, int len
 	}
 	option = allow_add ? ADD_CACHE_OK_TO_ADD : 0;
 	option |= allow_replace ? ADD_CACHE_OK_TO_REPLACE : 0;
-	if (add_cache_entry(ce, option)) {
+	if (add_index_entry(istate, ce, option)) {
 		discard_cache_entry(ce);
 		return error("%s: cannot add to the index - missing --add option?", path);
 	}
@@ -672,12 +672,12 @@ static int unresolve_one(const char *path)
 	}
 
 	remove_file_from_index(repo->index, path);
-	if (add_cache_entry(ce_2, ADD_CACHE_OK_TO_ADD)) {
+	if (add_index_entry(repo->index, ce_2, ADD_CACHE_OK_TO_ADD)) {
 		error("%s: cannot add our version to the index.", path);
 		ret = -1;
 		goto free_return;
 	}
-	if (!add_cache_entry(ce_3, ADD_CACHE_OK_TO_ADD))
+	if (!add_index_entry(repo->index, ce_3, ADD_CACHE_OK_TO_ADD))
 		return 0;
 	error("%s: cannot add their version to the index.", path);
 	ret = -1;
-- 
gitgitgadget

