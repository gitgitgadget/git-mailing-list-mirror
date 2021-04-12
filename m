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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CECEFC433B4
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 21:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B48876135C
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 21:09:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244303AbhDLVJZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 17:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243998AbhDLVIz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 17:08:55 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96190C061346
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 14:08:36 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id p19so7601218wmq.1
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 14:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Ry30Ub54zs5fS2rT/tk3DbrPmbbOYHZgw4kzgYnFvxE=;
        b=dFpHbp7eDAWCFg6WOZ/2EGai7Jxhg01GOe8dXaye7iGIz2JW8uWg3Ip1BcPYj0o1Y1
         tCyG0HhCj1j7dEH7j7ltdv3p3q2QlYieSu3w1PhainBpFg0HJFYteI05kjl8OJv6Awpt
         arnLphIxN2tx4hh+eGhh3FGLZEihnqGifsgFmCJTN8n+zgCOfjomvxK4SWo2oMDpqj9f
         IpyfElXUMaKqYu/gJ6Nn6+n1z60Y4jqhiOq3IS+semmMZ49GCxokJNdKbHCEcRnMzusb
         u8sEWSEvUlnJ2HTaBOsdaa2PQvpC9j0LoMUUad6bTW0IxSu+832HUtx8WAFEck4MttsG
         vRLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Ry30Ub54zs5fS2rT/tk3DbrPmbbOYHZgw4kzgYnFvxE=;
        b=jkOLk700Yqsj5VedL/lGKMspPTP+N95ErdwVeuB4Vmkrs15nS7/dmdbbbNRi2r4SM9
         rhppH8wDiPpxMSA79bXxaYcErB/Mw7LW3nMhVqXR7O5wxbgwNCN8HxlZyEUFFhdoCIwl
         JoZvLqbHtu0cntyxJBU8S18lXK8qp8xXCheIDOYMVAl6YWPa5TwiK1zEyF8q8vxqHWwJ
         YoLeRA8+fV1A1y7fv+Nv9FNd/2eWAo4WdTQhWTEcVkvSH5R0WPelVes2y2Z96Bhs6jdi
         4wkGetarbny2mdci+FhgBMQZG+uxvu3XCu3rA/Lc/u7nAfWacjGhJ0if/3a4a8qLnUpa
         VMeg==
X-Gm-Message-State: AOAM5307Edx2146ZFYxIM1VQ3SmxHGwzRH//0uufJUIW1doGTtcDMgSz
        uH2eYomgKw8Nk/7oqIJRgXSQHAqHXx0=
X-Google-Smtp-Source: ABdhPJwpp4ce1erqhc+LH9wQVIVq+8MKLOakJYLuSK6UtGkjEoIybHyfbng9Xep+7C4dM38aH6x2fA==
X-Received: by 2002:a1c:b002:: with SMTP id z2mr866502wme.121.1618261715369;
        Mon, 12 Apr 2021 14:08:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s10sm46889wrt.23.2021.04.12.14.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 14:08:35 -0700 (PDT)
Message-Id: <1f3af8a886e5015a70a880dabd71f791d63c88df.1618261698.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.906.v3.git.1618261697.gitgitgadget@gmail.com>
References: <pull.906.v2.git.1617241802.gitgitgadget@gmail.com>
        <pull.906.v3.git.1618261697.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Apr 2021 21:08:17 +0000
Subject: [PATCH v3 26/26] name-hash: use expand_to_path()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com,
        Derrick Stolee <stolee@gmail.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

A sparse-index loads the name-hash data for its entries, including the
sparse-directory entries. If a caller asks for a path that is contained
within a sparse-directory entry, we need to expand to a full index and
recalculate the name hash table before returning the result. Insert
calls to expand_to_path() to protect against this case.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 name-hash.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/name-hash.c b/name-hash.c
index d08deaa2c9e7..383cf589969c 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -8,6 +8,7 @@
 #include "cache.h"
 #include "thread-utils.h"
 #include "trace2.h"
+#include "sparse-index.h"
 
 struct dir_entry {
 	struct hashmap_entry ent;
@@ -683,6 +684,7 @@ int index_dir_exists(struct index_state *istate, const char *name, int namelen)
 	struct dir_entry *dir;
 
 	lazy_init_name_hash(istate);
+	expand_to_path(istate, name, namelen, 0);
 	dir = find_dir_entry(istate, name, namelen);
 	return dir && dir->nr;
 }
@@ -693,6 +695,7 @@ void adjust_dirname_case(struct index_state *istate, char *name)
 	const char *ptr = startPtr;
 
 	lazy_init_name_hash(istate);
+	expand_to_path(istate, name, strlen(name), 0);
 	while (*ptr) {
 		while (*ptr && *ptr != '/')
 			ptr++;
@@ -716,6 +719,7 @@ struct cache_entry *index_file_exists(struct index_state *istate, const char *na
 	unsigned int hash = memihash(name, namelen);
 
 	lazy_init_name_hash(istate);
+	expand_to_path(istate, name, namelen, icase);
 
 	ce = hashmap_get_entry_from_hash(&istate->name_hash, hash, NULL,
 					 struct cache_entry, ent);
-- 
gitgitgadget
