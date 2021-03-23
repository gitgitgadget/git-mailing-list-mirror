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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54035C433EA
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 13:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41169619C6
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 13:45:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbhCWNpD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 09:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231727AbhCWNon (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 09:44:43 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C401C061763
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 06:44:42 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id o16so20847108wrn.0
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 06:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=harCcaW6krA58Ri1udByTg/8REVVoWQHOitg/KDNLxQ=;
        b=pZhqsAFEZoL8uUePjB31o5xLZeJlomadxoIAA20xhmtbD0xLbtBhDKGX3/SZ/pZG4r
         iiFqhbEioPj5fux13S5EmBIJSMPVUnPocHnp57Hm903FnpVZwIsciE032FxgYfB1BhVT
         g84QimlT2f/VhYwTFnpXIdQBqV6WSYqUavVHURV0JCnjj5YwErLo+gqnB6grlS1seXJg
         yFS7XXLBKjMRygYXOnf1nFNpycmLNFPXB6EkIQl0liEF7djF6/+/aLmxCd0cqQnJ30db
         WKMhwzgRIvynlPYuaJNzga5bckQy21S3WBoEE+61r8GOBrN1ZEFw1Lz+dnfm54+0hG2W
         H+Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=harCcaW6krA58Ri1udByTg/8REVVoWQHOitg/KDNLxQ=;
        b=D6wM+YV6xB4UpahP7DsQkHXb+Cscvy6w5ac6T1Hfd0h4aXrMC4+n+P8sbTW+L+FvqO
         KJ69Ty8Rnw64sLqwNNELM7qRgSS9bou02wMMz8cksGN7fktUOqEP2GK9I30n7F9XSlrT
         HusyBnThKsuHZEZuowQv9jJBKQIgJxzAlFU67sFm4ytAe1QS869N10I9ipfsHmcmkX9h
         eyryPTpqSYPTlYITShbOYn1iz0ZSJUmSimoC2NHUVePYnxch/PaiQTLVQep+LYchGQhY
         kYLPdhQ+mCnz25AqJogx7lsMkoyxHF3UiiWTZr73CFtXb2/b3VK00HM2lg6O28ZhTs4S
         c5SA==
X-Gm-Message-State: AOAM532LvU+uBDgL5DGycootZlMa31YLCpQs97RZYx7xw0Z6uSrZPo1y
        T58MzO5t4kn3UA+vsZ7KktVkcDA0SGs=
X-Google-Smtp-Source: ABdhPJyO2QPXSaXC6tnTmE3nhK2VZm57bUzxGbgwcv1eyWNVLozRc8MvJg1+fFw761Br+7NpgHWzDg==
X-Received: by 2002:adf:9043:: with SMTP id h61mr4083564wrh.216.1616507081175;
        Tue, 23 Mar 2021 06:44:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m5sm3273426wrq.15.2021.03.23.06.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 06:44:40 -0700 (PDT)
Message-Id: <d24bd3348d98f0e8671424812cd009c0bca659e2.1616507069.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.883.v4.git.1616507069.gitgitgadget@gmail.com>
References: <pull.883.v3.git.1615912983.gitgitgadget@gmail.com>
        <pull.883.v4.git.1616507069.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Mar 2021 13:44:21 +0000
Subject: [PATCH v4 13/20] unpack-trees: allow sparse directories
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
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
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
 unpack-trees.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 4dd99219073a..0b888dab2246 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -746,9 +746,13 @@ static int index_pos_by_traverse_info(struct name_entry *names,
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
+	} else {
+		pos = -pos - 1;
+	}
 	if (pos >= o->src_index->cache_nr ||
 	    !starts_with(o->src_index->cache[pos]->name, name.buf) ||
 	    (pos > 0 && starts_with(o->src_index->cache[pos-1]->name, name.buf)))
-- 
gitgitgadget

