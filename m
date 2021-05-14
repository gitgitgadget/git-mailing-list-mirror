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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32125C43460
	for <git@archiver.kernel.org>; Fri, 14 May 2021 18:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19345610FC
	for <git@archiver.kernel.org>; Fri, 14 May 2021 18:31:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235227AbhENScn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 May 2021 14:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233718AbhENSce (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 May 2021 14:32:34 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A29BC061756
        for <git@vger.kernel.org>; Fri, 14 May 2021 11:31:20 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id x8so152034wrq.9
        for <git@vger.kernel.org>; Fri, 14 May 2021 11:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8BiWBmJ/VC9KkVb4hI/TM5y8+2cX+/ZhlTUXVP76k9Q=;
        b=irV5qHlWmd+EKrzcuilaJibVR0/LQO0LOT8OMyIDyqNXzOI/X7BKDqCBYijLal2kjU
         5OHG1jXyaU1Ph3X7YpwoRm0rQM5gwZ/r+pSI/egFRakr64ioXresb7XxI38rJ2fr67Vq
         sEkHJxlOLS8OwRsNEiHUfjw2ZnaIwx4td2cDqq+DH4LDwaTGzf2WMgbdYXftMwo7y0uJ
         PmycvuE/8WogU8PT+0GI2obB6LoCOsFILjCJCpSfgL1G2sGCc2M2xN3JJbn0jiAJN+Ky
         MfDHiz3pe1I7iXzk4XRlozYnw5pSNcGiRkfn4GBA+uWsrppBZtXWNtC7iD/rKHLXfsIg
         X3nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8BiWBmJ/VC9KkVb4hI/TM5y8+2cX+/ZhlTUXVP76k9Q=;
        b=SZknkx5dLbIoUYPlL+7p9WlTA6VfRMRc2Gl+f69QUf00fOvRm/DW+KEOpsUFvFrn9D
         CF48nRQB6UjbtP6mpv5XLOf4J8hmOdLMAJk3qJOwRP9J3XTssxaSvfN93xg4ERyDzyTR
         svAlJL7lpTV2Az8qlYRUO35q/F7SJBipt/4nGZE/+TKlPcwiWvR99musXv+fyVKNFML2
         m2vz3olUmb/owj+aL53PKRvNPxXLrbZUUbkkboPZKFyqS+dIq1T65ttXAZbiXOaqeT8Q
         Nym1FzSS5WgFAegbLNBAuhCeYO5U9UPxLca2BxudPz0/KP4c7CyGJ6reZOTebN4VSipI
         ZBQA==
X-Gm-Message-State: AOAM530S3vmPisOdOIe0VYiCO64uqlZBqjjO9ASfrLZxUJa9hCluZrmp
        TRyd1dkwjQ/ejZmtHx1+rUG6KW3MwZo=
X-Google-Smtp-Source: ABdhPJwSMTvJFMD0L3E07OIKChk9DyWrmyIE/hSAc8Tbt60+nKc4g7rKjnwTommhKwoQJsta79q1zA==
X-Received: by 2002:a05:6000:18a4:: with SMTP id b4mr58849930wri.86.1621017079051;
        Fri, 14 May 2021 11:31:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b12sm7354246wro.28.2021.05.14.11.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 11:31:18 -0700 (PDT)
Message-Id: <cc4a526e7947f40a0ef65396f2ec8d21d2445edf.1621017072.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v3.git.1621017072.gitgitgadget@gmail.com>
References: <pull.932.v2.git.1619213665.gitgitgadget@gmail.com>
        <pull.932.v3.git.1621017072.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 14 May 2021 18:31:05 +0000
Subject: [PATCH v3 06/12] unpack-trees: compare sparse directories correctly
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

