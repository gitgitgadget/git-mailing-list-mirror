Return-Path: <SRS0=tgTL=6Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5EB3C54E8D
	for <git@archiver.kernel.org>; Mon, 11 May 2020 11:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83B70206F5
	for <git@archiver.kernel.org>; Mon, 11 May 2020 11:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jql+DgHL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729774AbgEKL40 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 May 2020 07:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729453AbgEKL4Z (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 May 2020 07:56:25 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E295C05BD0B
        for <git@vger.kernel.org>; Mon, 11 May 2020 04:56:25 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id u16so18866490wmc.5
        for <git@vger.kernel.org>; Mon, 11 May 2020 04:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Nn4gmGOaYqd6lOgt3ayZUi5PTjaf4uODIov+aDVelsQ=;
        b=Jql+DgHLQBE9r0fp07xPAIFIrqq6cdR4BPQ+S1bu0hCKVswdr4e6In5yaozlrf1of+
         Tb37XXr0ua5cCLeuL+rzhrDcwHki/lDgbKVFbu3gHweOeBxecYAVY5gMGGRFr2yeeLt3
         ySJn0u4Srk9yh+skpvkpqxn9jLLWax6qu9f8HtoloXJiTpwTiet3CpEWSlUEhx1lVdzl
         TlqvNdD+xAVyXc5IL8PsB3W3EB9Px/IfSEpaSg9YLHV8gXjOF62jImy7r0YSRN+gKxb9
         PzIRwhy92uG2a7MFpC2OMa9oxD2ulDfKoqkGRxDtnrjDWpDz573qtPbMTLVabfIO4pJi
         LDXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Nn4gmGOaYqd6lOgt3ayZUi5PTjaf4uODIov+aDVelsQ=;
        b=TgDtBW3NIlX4lhjJORtxV7Hk5Wc7q93F4fD4PT0TxbiD01JdYWUkb0YAmajDhU9jjY
         26YxxAqmrYmDCxCGcs7mIqM4jILZqpM5I1z/7wZnAmjdmKTxjOd1AIAIOOM9I5dLxnah
         GMmuDoeZ/wie7uLaKToWDoyQjELVEWveeWYS1JF1Bxhu3vmyRE7tCZbw0UZsGT8AAHkw
         VCCkUiwcV0zw0pRaPipXYzyLxd8DCMcmWXbYdrpS0e1PzUGhQmUIpQThQAdqtjukqxdo
         I5G7JA2VXKDn7ZbTfqtnsqjYFSqwyaz+MjRV2tNa1NL2bKnOuM/7KbmDaAbKv5hGD1W4
         +V4g==
X-Gm-Message-State: AGi0PuZJdzchXvQyyGSd7NNYVvkTBQCh23pvpo1Un0lbk37nxeCMW/Sy
        y1acSe6QhyicsmsTzC6Qvx8Y2fwx
X-Google-Smtp-Source: APiQypJopj6pPpfNeQr5IgLTmMr3AwnZbDid5q73KV0c2oQcP7GA7Tgnko3/43rSuPeQQ/R4B5II/A==
X-Received: by 2002:a05:600c:d8:: with SMTP id u24mr23851683wmm.19.1589198183860;
        Mon, 11 May 2020 04:56:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a12sm16897460wro.68.2020.05.11.04.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 04:56:23 -0700 (PDT)
Message-Id: <0e08cec78d325452f9901501b2e0b53b3145a022.1589198180.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.622.v2.git.1589198180.gitgitgadget@gmail.com>
References: <pull.622.git.1588347029.gitgitgadget@gmail.com>
        <pull.622.v2.git.1589198180.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 11 May 2020 11:56:10 +0000
Subject: [PATCH v2 03/12] bloom: parse commit before computing filters
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
index 2e3e0f5037b..96792782719 100644
--- a/bloom.c
+++ b/bloom.c
@@ -193,6 +193,9 @@ struct bloom_filter *get_bloom_filter(struct repository *r,
 	diffopt.max_changes = max_changes;
 	diff_setup_done(&diffopt);
 
+	/* ensure commit is parsed so we have parent information */
+	repo_parse_commit(r, c);
+
 	if (c->parents)
 		diff_tree_oid(&c->parents->item->object.oid, &c->object.oid, "", &diffopt);
 	else
-- 
gitgitgadget

