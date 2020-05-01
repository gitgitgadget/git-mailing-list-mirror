Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A81C4724C
	for <git@archiver.kernel.org>; Fri,  1 May 2020 15:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 838E4208DB
	for <git@archiver.kernel.org>; Fri,  1 May 2020 15:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rfGuMGU+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729857AbgEAPal (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 May 2020 11:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729820AbgEAPah (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 May 2020 11:30:37 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60EBC08E859
        for <git@vger.kernel.org>; Fri,  1 May 2020 08:30:36 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id e26so61226wmk.5
        for <git@vger.kernel.org>; Fri, 01 May 2020 08:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3SG0W+07gUW8Nxz35zzLzoZKVsGQTz8tvZwUOfY0hTE=;
        b=rfGuMGU+qJPkY22Z8u0c9upeo9CpZ7h7Ztgkp0cCyoW0kpNX00y0y9T+4zbnAQhvGJ
         7MmWiGCeQTIwIrW/BYZJH/C0mvY3Gm8ZmGdTNcH7D6O03DrTIXIMtIp2q13VDDwsNawk
         uZQKnBXAPzTOHzl8UF+WfDGCAjUeFnzkWnDAW8IgnTvprYIn5jO48CDGg4+wMwVle0fU
         2iM1oMdQ+d4I74UAGqoR8rHhTFubjHRZlHp/oL7y/xg/Dp4n7YTnr4HK2Zepeg4ZIlRL
         MSYF2uq9u0ch+MFqDvCioyI5Pe8FeMIGXlVlmG+rpjLwnXhbHIP+6b7ziYreItinofHW
         fFuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3SG0W+07gUW8Nxz35zzLzoZKVsGQTz8tvZwUOfY0hTE=;
        b=sN6tK4HNX5n3roGt8Bqp2SWEEbpRftNGP5EH1m+BNGJDHhqmd7/wZeEdzwPYTvZpjs
         wrZIYwSCKWxLxK/iaWLv/zlX25MptPMvcjoq2QUoM8nHq2cAkuPR+w1BsstU1ApEDg28
         tcodBirw3RsXyT0NOO6PEOXS4u168h0j5Qf0FtVoLSWi9euj5heLu3gfLy22HcyhGmAt
         jM1ph04bHlM8ualDzaeWqUh1Hf6VeUjICGCP+qAqcEFS9R9YbaaLV+J7wI6v9VmKnpV3
         quft+E7DmvUBnao3a4l3ohdGMZMKky+zYLvEo2nkFbkwu97rbtIoS/KqXKYJhmRS6tfL
         z/Kg==
X-Gm-Message-State: AGi0PuabsUHsjZzutcqbsIUQ3eAdvnNxP0ISOoxLNVUgIlIkCio8XY5A
        i2ISBHNtR9It54Wqi8PiNIVAP+eK
X-Google-Smtp-Source: APiQypIe6B6icLCzvYIUFt9Iz2jLgFriXp6kEVM16sUW6hdLmp1kQYikFlBPvKKa2QfeE1YeECV+Fg==
X-Received: by 2002:a7b:ce88:: with SMTP id q8mr69944wmj.161.1588347035391;
        Fri, 01 May 2020 08:30:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h137sm120090wme.0.2020.05.01.08.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 08:30:35 -0700 (PDT)
Message-Id: <7d5561575d5e81128dcccb411bf2b052491d1850.1588347029.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.622.git.1588347029.gitgitgadget@gmail.com>
References: <pull.622.git.1588347029.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 01 May 2020 15:30:23 +0000
Subject: [PATCH 06/12] bloom: use num_changes not nr for limit detection
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
queue "nr" value.

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
index c3b81b1a38a..9a8386ac676 100644
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

