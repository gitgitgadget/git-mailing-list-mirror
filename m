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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60662C4332B
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 19:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E82F64FCE
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 19:32:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233859AbhCJTbv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 14:31:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233767AbhCJTbR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 14:31:17 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F27C061765
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 11:31:16 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id u5-20020a7bcb050000b029010e9316b9d5so8499945wmj.2
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 11:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BT1eQ9m7Cg+4MPuy2Wj0Rt+hvbdtI/KsEf7nXdoOSfk=;
        b=A0k4mh4Fl2rDk7ujMWoOUqR4GznwZ8wVSkw0slnpSosQEdD0bIfYLu3xLofkIUiy9h
         v4zJ5ZKWeAgwF0j1a850rH6WenZIThJcAWkb+QBkzesD++eYLAIBcVYHw1OSvvXu7ZDy
         lkzXtbKC9MlB6zCYbsVwMLy/5ivfdVkvwZ4OVJX91GazBGrWE2iqA4x31evQqJP3I7L0
         kvbZdtJ3c3mm6oGB4RBEMC45MChW9+XMgN4OpNY5brzBvvUXHcsqjOUoR+bdAtR6DZyr
         FH88xmizSDglbmaZ9XDURXlHJPWf0ODf4BAEnbmt1SKR8mhlqQs8L5s7sgw972BxCNue
         S5Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BT1eQ9m7Cg+4MPuy2Wj0Rt+hvbdtI/KsEf7nXdoOSfk=;
        b=iOiqW9fKhNbvN2fZBsFlybtRLKB+c49LSNjwO3N8ffURx14IvoxrYWGTPvzHhbp5+J
         vfkD24lef4PpGJMVY5SjacTeTQacMgXpge960WZ+HS9ncV6LZIpPpFUTmWHSK9NBEptD
         wuXjwrTDMyKMInRHbVEFjx8LE1MLzQZ57eyTtdL7/XMG6cXbrrhNnHSUU8lWzy9/EQ+A
         M8OENUv9jTX/RBmi/X/fEut55Xl52+HIB/x488zVTayZy6D+6C7Oj3b6hDmtguJAoEZ4
         z1m6wAA2Ka4eWjQNjIO9Trn3/jdrHP99+u3mrUSGWZU2HTDvpQbQEdEzoN52CGB4cyp/
         kvPw==
X-Gm-Message-State: AOAM5331//PMlPWq6c/dgJcSJFXbvXevs07+toMXl3iCpHAJt32mcRuN
        nBzyiFtcwSJO8HfnaoFQnJoeaNjFp5k=
X-Google-Smtp-Source: ABdhPJxFKMsJGhQVco13b+5wflvK5zOdHwrcuJvU+1MsFZbnQOEcrSySUT9PvWSgNXTJZb0msEarBA==
X-Received: by 2002:a1c:600a:: with SMTP id u10mr4235149wmb.139.1615404675284;
        Wed, 10 Mar 2021 11:31:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r10sm450588wmh.45.2021.03.10.11.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 11:31:15 -0800 (PST)
Message-Id: <6f1ebe6ccc08d10715ee339fe04289db341dfdc4.1615404665.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.883.v2.git.1615404664.gitgitgadget@gmail.com>
References: <pull.883.git.1614111270.gitgitgadget@gmail.com>
        <pull.883.v2.git.1615404664.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 10 Mar 2021 19:30:56 +0000
Subject: [PATCH v2 13/20] unpack-trees: allow sparse directories
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, pclouds@gmail.com,
        jrnieder@gmail.com,
        Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The index_pos_by_traverse_info() currently throws a BUG() when a
directory entry exists exactly in the index. We need to consider that it
is possible to have a directory in a sparse index as long as that entry
is itself marked with the skip-worktree bit.

The 'pos' variable is assigned a negative value if an exact match is not
found. Since a directory name can be an exact match, it is no longer an
error to have a nonnegative 'pos' value.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 unpack-trees.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 4dd99219073a..b324eec2a5d1 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -746,9 +746,12 @@ static int index_pos_by_traverse_info(struct name_entry *names,
 	strbuf_make_traverse_path(&name, info, names->path, names->pathlen);
 	strbuf_addch(&name, '/');
 	pos = index_name_pos(o->src_index, name.buf, name.len);
-	if (pos >= 0)
-		BUG("This is a directory and should not exist in index");
-	pos = -pos - 1;
+	if (pos >= 0) {
+		if (!o->src_index->sparse_index ||
+		    !(o->src_index->cache[pos]->ce_flags & CE_SKIP_WORKTREE))
+			BUG("This is a directory and should not exist in index");
+	} else
+		pos = -pos - 1;
 	if (pos >= o->src_index->cache_nr ||
 	    !starts_with(o->src_index->cache[pos]->name, name.buf) ||
 	    (pos > 0 && starts_with(o->src_index->cache[pos-1]->name, name.buf)))
-- 
gitgitgadget

