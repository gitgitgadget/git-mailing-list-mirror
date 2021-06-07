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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1443C4743F
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 12:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8DC7610E7
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 12:34:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbhFGMgY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 08:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbhFGMgX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 08:36:23 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A239CC061789
        for <git@vger.kernel.org>; Mon,  7 Jun 2021 05:34:19 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id a20so17471164wrc.0
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 05:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8BiWBmJ/VC9KkVb4hI/TM5y8+2cX+/ZhlTUXVP76k9Q=;
        b=LYVOnQL7PXDTM7S8YjCaYUoJhvZGWg4EQ/2df+lNtZ+arX+rTVuUUrZZjHMls6VrKq
         zpExnk+tj2S1wlqeZUEVUNJCWpGL0wq91Ckmt4Y+ExtNdJ0ISA2eZKxjxExtYL+odIOO
         P1Iz3hKf2BHwe5Kmu0i9ERNqG2O66e/HCzjP8r1TC9x1TUqM9Gpsgjyd1CLtL8/aQwRv
         lWa6kbziXBbk2dLbrUTvk3uFcrsPEUv2tEGod/vawl37nrEmBzqnkLSATypYctMWAnBJ
         QtdGyYX8BiAEQVNmlf1mTvsnTI4H4QAhWV8w8neJhfrLAszLnnDrXXvAzFM7d5b/QJaJ
         e+bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8BiWBmJ/VC9KkVb4hI/TM5y8+2cX+/ZhlTUXVP76k9Q=;
        b=X+IWmwmxc5WrYd1v8zc7C2sONgVd0neuHKDkE+9dTraaIqNU4K1Lvg4pwuPcJAxxVy
         U3nqh8SN57gfBel42H2PN8u9FkqKXdIEyrKIU6bY7PDBMn7mhbZEJ6aBSvehuF2cMFKo
         mPiqbgHcCGBgeB0xStNK23jYEI/RHCxJeSOSjg4+zmN82zik6WM6Xi7squEpMcahON6R
         yMQbLXaeMQqK/mJ5cd98whAYhHRf2ufpx6MND4mHuDqLQKKj0nXNrvndqmS0sDcsYSFQ
         DymziXEiWA1og2ihEj6tOlq9QS5Yop5IXzYeAC3mmnYjQ2PmUI9qKTZQRU5W4zXMhoyY
         stvQ==
X-Gm-Message-State: AOAM532PO0Rbq7z37kF57YoWmG6mluPtUVn9EYE96k5chmzNkbLESIJB
        DtwZRvho64CUc47kw258y/YapiiaeBQ=
X-Google-Smtp-Source: ABdhPJzoOBHddqQpI//K4CZzwnMXthXYR5rQl1ULWETtb2fe2jc6Y4L0a3h/lfBm0DWB7KkyQSATpQ==
X-Received: by 2002:a5d:5987:: with SMTP id n7mr16808643wri.293.1623069258315;
        Mon, 07 Jun 2021 05:34:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w13sm17243491wrc.31.2021.06.07.05.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 05:34:18 -0700 (PDT)
Message-Id: <45ae96adf28546c586cbf4e67f3ec59090ef2377.1623069252.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v5.git.1623069252.gitgitgadget@gmail.com>
References: <pull.932.v4.git.1621598382.gitgitgadget@gmail.com>
        <pull.932.v5.git.1623069252.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Jun 2021 12:34:05 +0000
Subject: [PATCH v5 07/14] unpack-trees: compare sparse directories correctly
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
exact string match on a sparse directory entry.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 unpack-trees.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 1067db19c9d2..ef6a2b1c951c 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -969,6 +969,7 @@ static int do_compare_entry(const struct cache_entry *ce,
 	int pathlen, ce_len;
 	const char *ce_name;
 	int cmp;
+	unsigned ce_mode;
 
 	/*
 	 * If we have not precomputed the traverse path, it is quicker
@@ -991,7 +992,8 @@ static int do_compare_entry(const struct cache_entry *ce,
 	ce_len -= pathlen;
 	ce_name = ce->name + pathlen;
 
-	return df_name_compare(ce_name, ce_len, S_IFREG, name, namelen, mode);
+	ce_mode = S_ISSPARSEDIR(ce->ce_mode) ? S_IFDIR : S_IFREG;
+	return df_name_compare(ce_name, ce_len, ce_mode, name, namelen, mode);
 }
 
 static int compare_entry(const struct cache_entry *ce, const struct traverse_info *info, const struct name_entry *n)
@@ -1000,6 +1002,15 @@ static int compare_entry(const struct cache_entry *ce, const struct traverse_inf
 	if (cmp)
 		return cmp;
 
+	/*
+	 * At this point, we know that we have a prefix match. If ce
+	 * is a sparse directory, then allow an exact match. This only
+	 * works when the input name is a directory, since ce->name
+	 * ends in a directory separator.
+	 */
+	if (S_ISSPARSEDIR(ce->ce_mode))
+		return 0;
+
 	/*
 	 * Even if the beginning compared identically, the ce should
 	 * compare as bigger than a directory leading up to it!
-- 
gitgitgadget

