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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1284DC07E9C
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 17:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA056611C1
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 17:56:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235827AbhGLR6y (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 13:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235772AbhGLR6x (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 13:58:53 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570DEC0613DD
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 10:56:04 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id g16so16901624wrw.5
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 10:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HDhgtJZsDGyJtVd/z+kWysbOePZ/rRg7q4HZzXdKryk=;
        b=HdXsyucZHjP+cr7nmR/NXldpO1+GWP+nXJpaNzV216WAIj0A1S2fegcH8yx16SwdL5
         WGD9k84c4Y5yBc7UDf0tKzgZiKiVGVJos4Ju9zemA3CPTBKWlwVOwcR597CLvY7cmQSI
         WnuUVQufVc7nZHGl5cYolzVQxfiEXxBh1Xa6a+U9cclFaafX94Hlhpmz6aEfinjlWqgO
         h9TqZgf4K2QwgTEF84r+T4VOOg9u6iYX+L5zDDbFQTvo8Au6Y4JN+Z5GJh1ad0i87La8
         qRiIeJ2OfQGfTfXvd0LPQ6ptkNoIyPtr3BYMXwRSfWlm7/ZFndeZSLfeY2hBOX2ZoY0M
         b7og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HDhgtJZsDGyJtVd/z+kWysbOePZ/rRg7q4HZzXdKryk=;
        b=ix9R0nVss65BZrlrScrwu3J0bYO6iMClZa8nxFcenY0qjWkafNmL42Z5hdPhgSb1Io
         bH6+hv8NRxOS7DoQPjpNRObr8MlLaHKh51y1hyFK0cSf/f06UxgPn4MWQBAQkWpL3Hdz
         5BMHgPESrXp4d44VqbY0ww9cZ/Q2dN3/lUFrwxmhs674tUIkHFqW0Mt62uIbYW2KyO5c
         Fiidh6q4CM8Qe/xrnTbk578Aatryy3UAvfcgeYuf6GFRy1KzTguVUqBdXpBkHEqpPx10
         t/aJVzt/DQhaV7SQhzF6Jfs4DVbYVOOUTIF08/ExCZf3hOYj25BqVsowxpPZUbc4xVLl
         e7cA==
X-Gm-Message-State: AOAM533QLhJqZZZdSuim92IobaMUD/W2WpvVcxb1RjHrv+DhiaR28AV7
        oiErhqC4EefboOQLaAVW+UzSW3BqeSk=
X-Google-Smtp-Source: ABdhPJxHC6lqZyaq4KhkaBFSOoBOhZxQQ5VPKBqvEK96QfDmEWr3XiDYsSIJgwJOgtDAwVzV7y1LrQ==
X-Received: by 2002:adf:f90d:: with SMTP id b13mr241064wrr.336.1626112562737;
        Mon, 12 Jul 2021 10:56:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d9sm373606wrx.76.2021.07.12.10.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 10:56:02 -0700 (PDT)
Message-Id: <988ddce4d45d994488ca074039a9b8a8ed2ca285.1626112556.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v8.git.1626112556.gitgitgadget@gmail.com>
References: <pull.932.v7.git.1624932293.gitgitgadget@gmail.com>
        <pull.932.v8.git.1626112556.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Jul 2021 17:55:48 +0000
Subject: [PATCH v8 07/15] unpack-trees: compare sparse directories correctly
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>, git@jeffhostetler.com,
        johannes.schindelin@gmx.de,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

As we further integrate the sparse-index into unpack-trees, we need to
ensure that we compare sparse directory entries correctly with other
entries. This affects searching for an exact path as well as sorting
index entries.

Sparse directory entries contain the trailing directory separator. This
is important for the sorting, in particular. Thus, within
do_compare_entry() we stop using S_IFREG in all cases, since sparse
directories should use S_IFDIR to indicate that the comparison should
treat the entry name as a dirctory.

Within compare_entry(), it first calls do_compare_entry() to check the
leading portion of the name. When the input path is a directory name, we
could match exactly already. Thus, we should return 0 if we have an
exact string match on a sparse directory entry. The final check is a
length comparison between the strings.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 unpack-trees.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 87c1ed204c8..b113cc750f2 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -983,6 +983,7 @@ static int do_compare_entry(const struct cache_entry *ce,
 	int pathlen, ce_len;
 	const char *ce_name;
 	int cmp;
+	unsigned ce_mode;
 
 	/*
 	 * If we have not precomputed the traverse path, it is quicker
@@ -1005,7 +1006,8 @@ static int do_compare_entry(const struct cache_entry *ce,
 	ce_len -= pathlen;
 	ce_name = ce->name + pathlen;
 
-	return df_name_compare(ce_name, ce_len, S_IFREG, name, namelen, mode);
+	ce_mode = S_ISSPARSEDIR(ce->ce_mode) ? S_IFDIR : S_IFREG;
+	return df_name_compare(ce_name, ce_len, ce_mode, name, namelen, mode);
 }
 
 static int compare_entry(const struct cache_entry *ce, const struct traverse_info *info, const struct name_entry *n)
@@ -1014,6 +1016,16 @@ static int compare_entry(const struct cache_entry *ce, const struct traverse_inf
 	if (cmp)
 		return cmp;
 
+	/*
+	 * At this point, we know that we have a prefix match. If ce
+	 * is a sparse directory, then allow an exact match. This only
+	 * works when the input name is a directory, since ce->name
+	 * ends in a directory separator.
+	 */
+	if (S_ISSPARSEDIR(ce->ce_mode) &&
+	    ce->ce_namelen == traverse_path_len(info, tree_entry_len(n)) + 1)
+		return 0;
+
 	/*
 	 * Even if the beginning compared identically, the ce should
 	 * compare as bigger than a directory leading up to it!
-- 
gitgitgadget

