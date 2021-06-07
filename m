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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB5C5C47082
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 12:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0D3B61057
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 12:34:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbhFGMgP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 08:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbhFGMgM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 08:36:12 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9EF7C061795
        for <git@vger.kernel.org>; Mon,  7 Jun 2021 05:34:20 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id q5so17438034wrm.1
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 05:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IKPjTUqki+7odL+EABJRxmdzP4v6AWl9RXlIatOMDLM=;
        b=enLsZo1kPstXaNr5J3W8tk/S6xFiq7UjxYz5mUCWeres9J5xjM8x7hf98TokOswxCG
         WjXxrIHIx3KkAKcvsCqt5KU33Aydm2h6EYEYWpvyxFe1UDUZDgooGpWro3L5+Ezx96Po
         oAbsERCtuenjTghFr+EKJpOdWi9HCF/OBpVtC6PpK2S4mj6xBZqGtMG9S+9nXZ1rJKlB
         myPAdngHphCky8egWDpSrnmplIDXG1o8/ihtwZe9wok0ot1pEjfX7vDEoxLF67ft9/SK
         YYocUgN9i1WA5iex7GEEFrSmos7JLRFyfGDlBpKbLZoPZUPP60fTRdWGYqR5BlKjP8jj
         ktuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IKPjTUqki+7odL+EABJRxmdzP4v6AWl9RXlIatOMDLM=;
        b=O8lT8GRVr4neOxm9sWtFH/ojdnB7QynNP46PShCbCZjA6xKbCTKhg9mbyLGsbuM1OL
         UkWD1FhamDX4mImw+MW425u+TlY31P+9473XytqZxlJKsQb3de9Ry3jpK7IWVQGherN4
         VLGWZ2T/1xmh5Pucs4sCwYUBct4FBbaWJbZv7Poi3ODcinPEt+krB2EPo9aLmM77vTe+
         MToYKmmgvwECJVV5SM4dYAD0FdYVE0iqQdSTU6HKjpPeYQLz1heMprbrf6uC3tVOSGC3
         C4CK+7vnXRPmbD6XkA7FGXhbtvIwuyI1nPNO+rOKjuZ1w5HyuHjHB8XWd0/lICbqkXvp
         RtMA==
X-Gm-Message-State: AOAM533UNGdVbFeNIUAAJ9DjB52pyVi0dHcOEmdBfR96RsBPCDi0Uqp0
        4xAJ5kU+fkUYJ8M/dRTraN4skBeIN1U=
X-Google-Smtp-Source: ABdhPJx8j1NMlcK2a48QKt5X0EJ+ujmG70b7WpJ/wsFhHRWSXXNSDS0rRWFwxGzy+v+XhlJTI3KUVA==
X-Received: by 2002:a5d:4681:: with SMTP id u1mr9741087wrq.268.1623069259545;
        Mon, 07 Jun 2021 05:34:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k8sm13292770wrp.3.2021.06.07.05.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 05:34:19 -0700 (PDT)
Message-Id: <b8ff179f43e3f9713079f9b39d56ae3e3587faae.1623069252.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v5.git.1623069252.gitgitgadget@gmail.com>
References: <pull.932.v4.git.1621598382.gitgitgadget@gmail.com>
        <pull.932.v5.git.1623069252.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Jun 2021 12:34:07 +0000
Subject: [PATCH v5 09/14] dir.c: accept a directory as part of cone-mode
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

