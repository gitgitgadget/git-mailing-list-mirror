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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9BB2C433ED
	for <git@archiver.kernel.org>; Fri, 21 May 2021 12:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FCFB6008E
	for <git@archiver.kernel.org>; Fri, 21 May 2021 12:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235128AbhEUMBj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 08:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233890AbhEUMBN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 08:01:13 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23C1C06138C
        for <git@vger.kernel.org>; Fri, 21 May 2021 04:59:48 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id q5so20809289wrs.4
        for <git@vger.kernel.org>; Fri, 21 May 2021 04:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8BiWBmJ/VC9KkVb4hI/TM5y8+2cX+/ZhlTUXVP76k9Q=;
        b=HHtefpG8ETuk49kqGS+ZArKLOZmby3wzMH0mEoODLvFfGoAhaQpOQLX/Z/2jMjMZXb
         meMLu5kQ3vvX0nIlU0YGYAsZIElX1u0WIDDF7WZ6OOTZZSr78UdkLSU3SaRtHrsmUCcg
         giXBBnzRbqhO5y66oC2rt7miBSXzfWGpXI+Qrst1dbNjqao3v1GYUKulOplGl99WnNW2
         BUnj8MHZc64AA1ShZicZxTtlk60YshmjK13BbEi21Bfcx+gcAyhPFG0Udo+7rcglUOO/
         e5ukt7sLR66w9vqd/eF2Vux/iCxQurWIjIiKfdsvU9BqjEBW8G8jxSPvaFCeod8Edvt4
         FxyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8BiWBmJ/VC9KkVb4hI/TM5y8+2cX+/ZhlTUXVP76k9Q=;
        b=ZPvnmwzcFwsOMCZ9fo23q+hnwNElm7jht9anHk21mnUXg0hByFE51hM6o5II19aMy6
         KPj9+BR+sJkq8xn1ZzLgDr07+CNhIEJqVrQ1ApCxrZPsVOEPETXDvoivvB42ZuyzjG9W
         kya1xt9xbrypMOuMeXrJZjzhmDuqsXIr6YsqVac8ilh+S8v8sQ0pG3A7qbyQBnMyGXWN
         iGGuaHFOVycA5Xt3NdqbvNaucCVdP3onh8uMuiwrCoG5A7YW9eWezHAqy3ERg1ESlJBI
         RpZ2CjF1Q6LL/+12hL4DpSoj/aiqmVJBcjVcAJnH+v415w44ZFLlTDyT5la6bVlUymp3
         VNOA==
X-Gm-Message-State: AOAM532pPyzYHvN6ZUVgXKIkHSOtwcWWPWEpdMwC5j8gnJ/tMYzEFKE6
        dErE2I7kTsPrhtOZV6JPMpPyIL8ag60=
X-Google-Smtp-Source: ABdhPJzSx34vZyDyS8ukSca+j5xglx9/8XFoF9SX8g6fAJyRWB1M215hE5AQHL3b69ABJpkvx8AakQ==
X-Received: by 2002:a5d:64c6:: with SMTP id f6mr9439338wri.18.1621598387101;
        Fri, 21 May 2021 04:59:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e8sm1981161wrt.30.2021.05.21.04.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 04:59:46 -0700 (PDT)
Message-Id: <cc4a526e7947f40a0ef65396f2ec8d21d2445edf.1621598382.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v4.git.1621598382.gitgitgadget@gmail.com>
References: <pull.932.v3.git.1621017072.gitgitgadget@gmail.com>
        <pull.932.v4.git.1621598382.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 May 2021 11:59:35 +0000
Subject: [PATCH v4 06/12] unpack-trees: compare sparse directories correctly
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

