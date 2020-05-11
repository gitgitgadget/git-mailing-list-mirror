Return-Path: <SRS0=tgTL=6Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED43C54E8D
	for <git@archiver.kernel.org>; Mon, 11 May 2020 11:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6771C206F5
	for <git@archiver.kernel.org>; Mon, 11 May 2020 11:56:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OzQ/1uaQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729874AbgEKL4a (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 May 2020 07:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729365AbgEKL42 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 May 2020 07:56:28 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F15C061A0C
        for <git@vger.kernel.org>; Mon, 11 May 2020 04:56:27 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id u16so18866628wmc.5
        for <git@vger.kernel.org>; Mon, 11 May 2020 04:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LlANYpI+XJd+L6Xx5De89OPDRmiEWMcOo2uuNgbEz8U=;
        b=OzQ/1uaQCZ6DWL7ZgMUy6VUzKT+OIN3KIm7QC2VqhcPF1SIDUx7c6btIdRAqbDM97D
         Gu/4IEHF02gNwCzQsDme7Sb6KNSQArSe06fJ5c73LxoRsg/bqu4agL0evyrtq5IpCgs4
         YNc3i+Ha2Umm6DoMzrUtS5snubDGAVlEm4iHUr2PsETXaK5belU20kp5wFRrfFXV90pk
         SAHBNSgU+8wFCOsnhC+sVKNQiEqj1ZMKlLiYiCepm1zhQnDxt+o8pp2YWQoaOwfJWmXE
         cVza0nlFT2PpJvKECHMA5YwPrx7h0inrfCFDeDPa54PX3iGgOgtx2FgNwbvQkW5X4FPa
         /3Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=LlANYpI+XJd+L6Xx5De89OPDRmiEWMcOo2uuNgbEz8U=;
        b=UtCMABdcdRTrlQhJwvF7ev316F9xJt8OPJTsTxQtZdy7HLFg4vsZklGj6H78lYwbIr
         TboZv0rpYH0juwf8f6XJTF6kw0fi6/CYi6irolOpoTquNYIVD53IYEgpGvk2XT08d9mo
         6FvnJDxPxrIfeKm8DjTo1+CTLv5WwUGU4uuepoWY036DUgPp7ddIEqw/5iYYZ1egZbu2
         QCLrXPCDQMqmIC9UzeaLDh11DJPNWPC1qIqchNgQkB1SGr4nD6xKUGkmbOirFFWtnqA4
         8VxPeLVvQyTmaBep7Txat4BYD6VczW4cQr8AP/XBB+uGQIWAgqHw4EhUyiXgmZ+E0UsZ
         35EA==
X-Gm-Message-State: AGi0PuZvyovEFGHqxMo6o1YPziKjL9XGPsrIX/1eWQYJ9HKNbwlylnkg
        nnxseLMNA07S2e/IMMcWAhPMPQm1
X-Google-Smtp-Source: APiQypKJSxHzgFC1kOwPU4uzDVbOCFzPli5GnPCrtHYysyQ19bXBbdjz5zAi7dKE7pXx936lGBkVgg==
X-Received: by 2002:a1c:7213:: with SMTP id n19mr5496869wmc.88.1589198186176;
        Mon, 11 May 2020 04:56:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 89sm16795052wrj.37.2020.05.11.04.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 04:56:25 -0700 (PDT)
Message-Id: <8278b5c0918c6b357e1f1ab3ee65ed2091ec3f61.1589198180.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.622.v2.git.1589198180.gitgitgadget@gmail.com>
References: <pull.622.git.1588347029.gitgitgadget@gmail.com>
        <pull.622.v2.git.1589198180.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 11 May 2020 11:56:13 +0000
Subject: [PATCH v2 06/12] bloom: use num_changes not nr for limit detection
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

As diff_tree_oid() computes a diff, it will terminate early if the
total number of changed paths is strictly larger than max_changes.
This includes the directories that changed, not just the file paths.
However, only the file paths are reflected in the resulting diff
queue's "nr" value.

Use the "num_changes" from diffopt to check if the diff terminated
early. This is incredibly important, as it can result in incorrect
filters! For example, the first commit in the Linux kernel repo
reports only 471 changes, but since these are nested inside several
directories they expand to 513 "real" changes, and in fact the
total list of changes is not reported. Thus, the computed filter
for this commit is incorrect.

Demonstrate the subtle difference by using one fewer file change
in the 'get bloom filter for commit with 513 changes' test. Before,
this edited 513 files inside "bigDir" which hit this inequality.
However, dropping the file count by one demonstrates how the
previous inequality was incorrect but the new one is correct.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 bloom.c          | 2 +-
 t/t0095-bloom.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/bloom.c b/bloom.c
index 196cda0a1bd..e2ede44126c 100644
--- a/bloom.c
+++ b/bloom.c
@@ -215,7 +215,7 @@ struct bloom_filter *get_bloom_filter(struct repository *r,
 		diff_tree_oid(NULL, &c->object.oid, "", &diffopt);
 	diffcore_std(&diffopt);
 
-	if (diff_queued_diff.nr <= max_changes) {
+	if (diffopt.num_changes <= max_changes) {
 		struct hashmap pathmap;
 		struct pathmap_hash_entry *e;
 		struct hashmap_iter iter;
diff --git a/t/t0095-bloom.sh b/t/t0095-bloom.sh
index 6defeb544f1..48a90625596 100755
--- a/t/t0095-bloom.sh
+++ b/t/t0095-bloom.sh
@@ -100,7 +100,7 @@ test_expect_success EXPENSIVE 'get bloom filter for commit with 513 changes' '
 	rm actual &&
 	rm expect &&
 	mkdir bigDir &&
-	for i in $(test_seq 0 512)
+	for i in $(test_seq 0 511)
 	do
 		echo $i >bigDir/$i
 	done &&
-- 
gitgitgadget

