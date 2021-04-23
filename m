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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04750C433B4
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 21:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEB716146B
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 21:34:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244054AbhDWVfR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 17:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232686AbhDWVfI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 17:35:08 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D359AC06175F
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 14:34:29 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id c15so40732280wro.13
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 14:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0pOxUo1RuCQro+WwKXvgCKN+ys4nNfKLvPYvW8DNlHs=;
        b=HyZToWcaQguUd2rHnPIf17k+/1mYxwAqeo4ybAnR4v822P6gP8ZW9UQnHCyhir7Wsi
         Hh7HX5ApsYDRTmDdYpuxlFLBuwWcGB8xXdeZdVWiKRdi4fX3C/17FEYpd3cAd7Gp8RQ9
         edWvvjG4BnrrFHaoOuAHtIcFzcGEP02d98Y4FCYmJxBVWIQLqSwCjujz1+KxQrw8vMxK
         8RpnNYx1ds7ajiJEoUhUprhuQc6ZNz81J3dfM5i0J3HA/lKMDRgiFJfxJcPXNjnH6zyR
         TY9V6ci3a6TXmPaiTzUpRRp7nsAih0/HX1iUZSJXqmQ+R9nv+G5+NLGALUG5Q4Pdu1gu
         MHeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0pOxUo1RuCQro+WwKXvgCKN+ys4nNfKLvPYvW8DNlHs=;
        b=gzi9zi5IVbC3iiSUdIADWBQePpIQ69bg85ths0CepG3yAe8XStE3j5ZDOMDotc8ldT
         wrauTTmIBkavZfDT1wQB4/ZNJ9Uz+dIz/UHpHyVBMVJyKO4oxzAIrL5n6z/TmO1wRIFb
         K6617XVUfOI/FzsuTBju6PqdN5A/iaLqYZDrLGRCXrdUQk2vToi5yc+Lp42j9TPgReWM
         efdNyxL+MVcFYnieM/K546DQ7c3H8acsOgqVv4O4oYMG0kiKPQF4ybUSGnm/9yRZYMlx
         3Sp0NSSoCWTa2PH+gQ2Fk5OpB6ftnVOffxWgAM9rP6pxaZakJmpZHx1+Px15N1QtHnIb
         T4aQ==
X-Gm-Message-State: AOAM531YcntXyzcwPe5i/+njO1dOoKC8yrxOjqjlppyyDAEfmy1QOuIJ
        Tg9gzL/ciQ8P4NM8Vyy9VoP+kFYIm0U=
X-Google-Smtp-Source: ABdhPJz3tZmEhHNUcPv5kxbTYLjPYxsOHoxCQBwfbfeQaLueW0jesgVGIAvBW28AxNwdux1oExQxwg==
X-Received: by 2002:a5d:590a:: with SMTP id v10mr6998287wrd.306.1619213668689;
        Fri, 23 Apr 2021 14:34:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c77sm8822149wme.37.2021.04.23.14.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 14:34:28 -0700 (PDT)
Message-Id: <24e71d8c062239be9b995bcc31dd12edf84106e3.1619213665.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v2.git.1619213665.gitgitgadget@gmail.com>
References: <pull.932.git.1618322497.gitgitgadget@gmail.com>
        <pull.932.v2.git.1619213665.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 23 Apr 2021 21:34:20 +0000
Subject: [PATCH v2 3/8] unpack-trees: compare sparse directories correctly
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
 unpack-trees.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 1067db19c9d2..3af797093095 100644
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
@@ -1000,6 +1002,10 @@ static int compare_entry(const struct cache_entry *ce, const struct traverse_inf
 	if (cmp)
 		return cmp;
 
+	/* If ce is a sparse directory, then allow an exact match. */
+	if (S_ISSPARSEDIR(ce->ce_mode))
+		return 0;
+
 	/*
 	 * Even if the beginning compared identically, the ce should
 	 * compare as bigger than a directory leading up to it!
-- 
gitgitgadget

