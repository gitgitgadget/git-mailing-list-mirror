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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F3FBC433E9
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 13:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24B2A22228
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 13:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbhAANIh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jan 2021 08:08:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727138AbhAANIf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jan 2021 08:08:35 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E4AC06179E
        for <git@vger.kernel.org>; Fri,  1 Jan 2021 05:07:19 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id r3so21992068wrt.2
        for <git@vger.kernel.org>; Fri, 01 Jan 2021 05:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qdUNlxbyQkWFS6y/ClELc3uYoAtpYK6+Zct2IZSbBYU=;
        b=np2NAt/GanbOj9JBYJm8FvmxkHh+I8OstUdik96GOERaC6V9vEQqAAcsO/1uuIrFZ2
         6xYXBlR27UFGJc0e4maK1+IGeiW2WlgrBHvN/hLjfh8kglvCv/un7kWTv2REKR6+CgND
         IaBjPm6iMUr6qFgebqo8Ecn5cD7QlHKLMWWm2hNxS5/c4AFfgAB5dFH8/BoIzhXzDbJX
         dPWHc3xOFaPUvAEJbe71tDLf+Xm9vlRWxP2BjeZhA/yQcnq5+cSIV2wQpN+ib6+bojYe
         eHfBXdvuFzyLgUxJsjW7umjmT/psgGp+cTscTT9Rv4Qk6WS7CYViQFKUxFKDUgkCWNZI
         GbWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qdUNlxbyQkWFS6y/ClELc3uYoAtpYK6+Zct2IZSbBYU=;
        b=G0YfsPiyGjDk41yRiKhKybEPk70Rtn3E1xEe9c6R+2xmJ/x5tmssfUd1f1oTDLmucd
         7i1QlEonbcve534XNGbLr7s+pfcPyUBNyBaoGPQeoXLMqDQzHKPmu31u4Miypho1x1nJ
         eONelAIEITrFs5ZgCfwXdVN+wepEm9suSCQ4k4U9TxpibaDxhJdb5HZ4h11cEN0Itxl0
         xGkZwAl6hFRcuHlljSbJXE9NJ1AO9KT9gBx3T6lSct/U8SQ8JSzBl7NL1jQT9tsNKBee
         nqyMU4uxJh96x3gRYfiNBqjoNywdBqcLaqCveulEOYczZOioVI+jkb/vmQtT32yfNXfI
         /09A==
X-Gm-Message-State: AOAM533PvN1An+pJUJlk2NKQcnlLwNpYOUoj5bXkYi+iOrk1I7XhokCz
        pVTZGx3zlHnRug5M+2qSTiXw2eSVXrQ=
X-Google-Smtp-Source: ABdhPJwF7Ds1mcVD/P9wdTCNUsrJGl6lInn63GBEOC9qhMXGQAMHSsDqiIwtC+pBJU1nj7fIhKZ1dQ==
X-Received: by 2002:a5d:6a4f:: with SMTP id t15mr70814123wrw.62.1609506438520;
        Fri, 01 Jan 2021 05:07:18 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c6sm52119432wrh.7.2021.01.01.05.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jan 2021 05:07:18 -0800 (PST)
Message-Id: <cf091799cae2a999b0c1dabd40159ad1f76d2bbc.1609506428.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.830.git.1609506428.gitgitgadget@gmail.com>
References: <pull.830.git.1609506428.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 01 Jan 2021 13:07:06 +0000
Subject: [PATCH 10/12] update-index: use add_index_entry()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

This is a mechanical replacement of add_cache_entry().

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/update-index.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 6f51fb4a14e..577ae2391b7 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -294,7 +294,7 @@ static int add_one_path(const struct cache_entry *old, const char *path, int len
 	}
 	option = allow_add ? ADD_CACHE_OK_TO_ADD : 0;
 	option |= allow_replace ? ADD_CACHE_OK_TO_REPLACE : 0;
-	if (add_cache_entry(ce, option)) {
+	if (add_index_entry(istate, ce, option)) {
 		discard_cache_entry(ce);
 		return error("%s: cannot add to the index - missing --add option?", path);
 	}
@@ -425,7 +425,7 @@ static int add_cacheinfo(unsigned int mode, const struct object_id *oid,
 		ce->ce_flags |= CE_VALID;
 	option = allow_add ? ADD_CACHE_OK_TO_ADD : 0;
 	option |= allow_replace ? ADD_CACHE_OK_TO_REPLACE : 0;
-	if (add_cache_entry(ce, option))
+	if (add_index_entry(istate, ce, option))
 		return error("%s: cannot add to the index - missing --add option?",
 			     path);
 	report("add '%s'", path);
@@ -683,12 +683,12 @@ static int unresolve_one(const char *path)
 	}
 
 	remove_file_from_index(istate, path);
-	if (add_cache_entry(ce_2, ADD_CACHE_OK_TO_ADD)) {
+	if (add_index_entry(istate, ce_2, ADD_CACHE_OK_TO_ADD)) {
 		error("%s: cannot add our version to the index.", path);
 		ret = -1;
 		goto free_return;
 	}
-	if (!add_cache_entry(ce_3, ADD_CACHE_OK_TO_ADD))
+	if (!add_index_entry(istate, ce_3, ADD_CACHE_OK_TO_ADD))
 		return 0;
 	error("%s: cannot add their version to the index.", path);
 	ret = -1;
-- 
gitgitgadget

