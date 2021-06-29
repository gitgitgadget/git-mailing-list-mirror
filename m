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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D291EC11F67
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 02:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFB1F61CEB
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 02:05:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbhF2CHd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 22:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbhF2CH1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 22:07:27 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45ACBC0617A6
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 19:05:00 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id j2so23718979wrs.12
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 19:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HDhgtJZsDGyJtVd/z+kWysbOePZ/rRg7q4HZzXdKryk=;
        b=XiXS9E5d72nTFTLR77JXYd7COWiY8sK9jM+bphCP0SJFcMRiqqRutqC8AfLhhcXLqZ
         111WUYHWZZ+5eahJ2TQKTBZZ7zD0wuu8dn1w2ofB3QWQUvbdIIl9/9mE6DVJFNfugLKD
         zQCIFQclwf1PMbg+VC7cyOjrQMZm0Q7q74AXtGHoTyhWMJVO40DRjnBURlsLmM4cXeYg
         kLsYTjSsSGqu/LA/JXnbY10nb+sNBMatCRj2Q2oN4nz71WAJ5U+XLp0K0wE8sauiTe/p
         S7snZxd/8a8LCxLsurZ7qm1WYsfYDR59C+VdV3Zc3q/rsXUNVvWwmyIwNsWSImltMRDu
         08nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HDhgtJZsDGyJtVd/z+kWysbOePZ/rRg7q4HZzXdKryk=;
        b=sb6K2DSwyp9NzUzfGdLmziQFfSsnidiCfPulx3k30IjqKjo16zsl2qLY5/nYi/QB2b
         PmZ+DtrsloQl/XEdJtIC2InZ54/UxclI67zKUz7GJOSERriWBXmcLc7ohExIFHMWCTks
         /UQjAX2jcgOLdWsblUMvRGU8rHAof/U74cG4QpZWIEdKmjOLW/O06NQQCUanUfPoBmgF
         HUePrF5vD2s5uo8uCqjZJyoZM+vXJod/ngihzroJPoeaWnONsfrBivqzuAq4CxAfBMBO
         uMcSrN8BQO0qJU/oIwY/22k/rjkqVJ+lS2BH/it30MIuEqZqGsu3lgLkASxvQn4Cftu0
         o8KA==
X-Gm-Message-State: AOAM530t+9n25YDUq4osRIfWHUZO7rfCk5IF5bhc3HkgV1gU81J1FpqC
        YffnlSC7oxwnyZV+i0alklLI4bYMiwA=
X-Google-Smtp-Source: ABdhPJyg5ntvrISEYcnteRqTxjv255CuzZum3bUE4QDeZnLiV2j/By8mswZuu+NsXHA5lEzuMnsDlw==
X-Received: by 2002:a5d:6d87:: with SMTP id l7mr1223817wrs.222.1624932298968;
        Mon, 28 Jun 2021 19:04:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z3sm1097740wmi.29.2021.06.28.19.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 19:04:58 -0700 (PDT)
Message-Id: <e52166f6e4c0a7316214971c462d66f4c2c9cad9.1624932294.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v7.git.1624932293.gitgitgadget@gmail.com>
References: <pull.932.v6.git.1624931502.gitgitgadget@gmail.com>
        <pull.932.v7.git.1624932293.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 29 Jun 2021 02:04:44 +0000
Subject: [PATCH v7 07/16] unpack-trees: compare sparse directories correctly
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

