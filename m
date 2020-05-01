Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1447AC47253
	for <git@archiver.kernel.org>; Fri,  1 May 2020 15:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E607A208DB
	for <git@archiver.kernel.org>; Fri,  1 May 2020 15:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dizEjW6b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729827AbgEAPah (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 May 2020 11:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729661AbgEAPag (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 May 2020 11:30:36 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0920CC061A0C
        for <git@vger.kernel.org>; Fri,  1 May 2020 08:30:36 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id k1so11921303wrx.4
        for <git@vger.kernel.org>; Fri, 01 May 2020 08:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dcwU0zhkFPHgFLpnGv35WM9VqZ1jQBnpAgs3jH3ylZ8=;
        b=dizEjW6b0h97KCXwNXWEpqCLNCM025BmtAIlwC8BhLWPsftghIQhYMJfKBOngrMD2z
         WxBrP8O1UYaI/B071XfiS/z3TVAFQ2S/7XrMfRDH+L1R113W4F/2hoy5SQ7KyesOptlA
         p+oyn6bGfYfzR2mLxjr/vakTXrpqkqeoPzNta9gEh5wMKROpGu7wia5DMs1Ltd0i/szL
         nAP/8UQzOc3iEfMNYP0cIcnXM0SYRVXGRc2i14Z/r8X4JzXTTKhc8nqYjHvaMTsOSXMb
         q1DPT7jTSA5377EoeGvTIhOJy7Y1qvwxrg0V5oqEkor0QkEdDBmCQTO0WiYoMY18hZpT
         0DlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dcwU0zhkFPHgFLpnGv35WM9VqZ1jQBnpAgs3jH3ylZ8=;
        b=QYkhEnXC/QP/qMIcTSs4KS17m498y8h+OtTt6+AjirmO+qk/aBf2ZjkuvMcTwGyEGc
         VOa9TWoVDNuByZSqvGRML9DqdYDuFzN0iZVwYHwyxJEwwih9Ykdizyemnr5y6RZZc1bH
         ABHlQ8dbbgC2UR8b7HGYsGAjc2XsdntD+7ssK5wi5PfDE27t7BZyUEoNncFKEZGsX5dG
         SyM9Gfc/7tyBeBkes+WXCeAi+yvN+i1rwAYcvep7opqezAQKv7IJdMLpwLlZioa0Mi5N
         0OvavfO4dszOSP4r7+QxXwarkHSYqYSSU8oCPMTradTIPiKeX3biD8ej3IcP/RqCDOr5
         lf3Q==
X-Gm-Message-State: AGi0PuabB+H3BaXWCfhV+OQ1lDMuSRp+Tvc/fJv0EwYiuKJHKoHzkvyi
        0l1IMe86KtixLN7EDN5VCdrXGsgh
X-Google-Smtp-Source: APiQypK5j+2+BpFnUKR1d+Z1zxRID2MsZ5KoO21BD3es0VsWqgBRYPFtAeCe4aYPPBwTs3CIR46WPw==
X-Received: by 2002:adf:f750:: with SMTP id z16mr5009550wrp.115.1588347034579;
        Fri, 01 May 2020 08:30:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g15sm5004156wrp.96.2020.05.01.08.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 08:30:34 -0700 (PDT)
Message-Id: <ef4c08e401bd57dddf327910032220632a36885f.1588347029.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.622.git.1588347029.gitgitgadget@gmail.com>
References: <pull.622.git.1588347029.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 01 May 2020 15:30:22 +0000
Subject: [PATCH 05/12] bloom: parse commit before computing filters
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, me@ttaylorr.com, garimasigit@gmail.com,
        szeder.dev@gmail.com, jnareb@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When computing changed-path Bloom filters for a commit, we need to
know if the commit has a parent or not. If the commit is not parsed,
then its parent pointer will be NULL.

As far as I can tell, the only opportunity to reach this code
without parsing the commit is inside "test-tool bloom
get_filter_for_commit" but it is best to be safe.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 bloom.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/bloom.c b/bloom.c
index eb08571c628..c3b81b1a38a 100644
--- a/bloom.c
+++ b/bloom.c
@@ -206,6 +206,9 @@ struct bloom_filter *get_bloom_filter(struct repository *r,
 	diffopt.max_changes = max_changes;
 	diff_setup_done(&diffopt);
 
+	/* ensure commit is parsed so we have parent information */
+	parse_commit(c);
+
 	if (c->parents)
 		diff_tree_oid(&c->parents->item->object.oid, &c->object.oid, "", &diffopt);
 	else
-- 
gitgitgadget

