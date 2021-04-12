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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE3CC433B4
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 21:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD96760238
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 21:09:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245050AbhDLVJU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 17:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243522AbhDLVIx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 17:08:53 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA56C061343
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 14:08:34 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id f12so14365236wro.0
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 14:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hhLYYq4GDu3XvoSbcr7sJoPjWfM0oLCRJFTPz+pdmsw=;
        b=RJFbRS7rnZmVppqDNjHs9yWRY/YOSGq/GoyS3S0VkNReGRDIzRrAZ3p1Qs6mDmnDuE
         MsrEK86g+RlM3jYCNhulMvMHBgjV6U+5roCOYyLOpKmolr6LYL+KMkbCwhDKBiStzjbk
         Afgl3HipzM11LX+kOm8CkI/7HxJh2TnLzATYslcgQG7DNOLlvW38nGJ8t8bQ3yGnVtWq
         31gawdS2ijQPXpCSazElELJH7hyyRwFJyXqqgIqzQsNa/3CyBRttU3CgRuX04piCeGQ4
         fwHpiBdtE8OxqkHIjNUVCNH2aJoaTnwKLT8eJLExXei6N/FW/Mn8z+A2LVw1Eln1TBM7
         FlCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hhLYYq4GDu3XvoSbcr7sJoPjWfM0oLCRJFTPz+pdmsw=;
        b=sAV2zVwL+dyw2yWmc+wq+dDGHdmb7br3+cq04yknWxKjrizh1oQVcYJylo5k5Bt7NS
         FUWtVM+d7NPtjMjvGr9S0vq/Kc2k3NRALEXX7sp4ST2aEYqKL4rMYMyr6O7wbvUL280v
         gMFmflOWtxh9s+U6kRGzDd/2pUN5kMp5WzvdNQD8JBb7THcmC6rfQIAfq+rp5DKX2GfM
         dL7hoo7QdmeRjm9ue6FonZjMFRtpu84r1F+UDMfCHKoAjkH4JNjxqE8cdIHL6l9DmuAN
         K5q3YMq23Wow08Jp7at9kGRbUtBjFqP5CLyfFcdHnQO9kk8T8C+pqD17zGNxvv4Dt7j1
         pMAQ==
X-Gm-Message-State: AOAM532dy1OHZFofusQMhztXisoXwVEEK8SBIOarZa9JrXCQr+o+aTtc
        MldzF6NK3xul9lH2On69yDDjporHg+k=
X-Google-Smtp-Source: ABdhPJziJ0ScQmt+bK08n7mHKv64MTse2AchkLCg4hVumLeSgpInujNlIAEv19SniKzA8EWpwEXyWg==
X-Received: by 2002:a5d:62cd:: with SMTP id o13mr4162671wrv.77.1618261713755;
        Mon, 12 Apr 2021 14:08:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z66sm505213wmc.4.2021.04.12.14.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 14:08:33 -0700 (PDT)
Message-Id: <f928e104f0d307b84477e4d37a701ecfe372b187.1618261698.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.906.v3.git.1618261697.gitgitgadget@gmail.com>
References: <pull.906.v2.git.1617241802.gitgitgadget@gmail.com>
        <pull.906.v3.git.1618261697.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Apr 2021 21:08:14 +0000
Subject: [PATCH v3 23/26] revision: ensure full index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com,
        Derrick Stolee <stolee@gmail.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Before iterating over all index entries, ensure that a sparse index is
expanded to a full index to avoid unexpected behavior. This case could
be integrated later by ensuring that we walk the tree in the
sparse-directory entry, but the current behavior is only expecting
blobs. Save this integration for later when it can be properly tested.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 revision.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/revision.c b/revision.c
index b78733f5089b..b72e0ac1bdca 100644
--- a/revision.c
+++ b/revision.c
@@ -1680,6 +1680,8 @@ static void do_add_index_objects_to_pending(struct rev_info *revs,
 {
 	int i;
 
+	/* TODO: audit for interaction with sparse-index. */
+	ensure_full_index(istate);
 	for (i = 0; i < istate->cache_nr; i++) {
 		struct cache_entry *ce = istate->cache[i];
 		struct blob *blob;
-- 
gitgitgadget

