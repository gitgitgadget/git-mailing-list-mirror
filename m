Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 417ACC4332F
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 21:49:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240094AbhLHVx1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 16:53:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237603AbhLHVxY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 16:53:24 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01929C0617A1
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 13:49:52 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id c6-20020a05600c0ac600b0033c3aedd30aso2738562wmr.5
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 13:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zeOacPG8foepzoe93AsPL3Dhk+VXAN8S9blbgW2/nvM=;
        b=j36lfctMVzSyWmiNML11FbAVejkxmhnzBbtU3dl9pnrwpcpvFOslWchiwssaBDr+qx
         h5ysMGpDUW7MeriNqkGdCOeoOwp1XgoxuHuHFBA7UDUYRhi+Z4Le76/u6kQ7R6Oxa6fk
         BMLCqGbQTECqZB3VMMbZHQcCSmqXEMsgOzkaXqna6rskOq+t+4TcR4JUXkRG2aRhX7OX
         HFwKgR60Rwy1ubcHq/DQxkTZkA+/2N7iKV2UBEkbqcmNDKtQdAklCsoiNVuQyMWUzAtC
         5i7ulLsl/fSuLqrQO0by50KvUN79SVfo3vtu0p5cml58AZ7MnyASwEtR4oKq3pq+64M+
         /sHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=zeOacPG8foepzoe93AsPL3Dhk+VXAN8S9blbgW2/nvM=;
        b=B9ivOe8PAOgrnfLmnBCCVdhas3wLYFb1kQnT/StwwQdA67HOPfEdjhx5yr/ay3hm9X
         GxyyeBI9yh1HgvH8imRKFzQEqb4NlqgrEWnHaJR59bMJfhb8qHDZoNp5f+/gtN94msJx
         +1t77Y775MI3qOpfA+OTG61mehLPjQKAhUEgDc9jDeYeliPT8t52XJG2Y3QPorIk8e36
         DL720PreM8q+sqK1CnKLA50WZQuD1hCLA7aJpf1w8N6SCXo3405Zk6oFkqicCgUeM44r
         GDl5NKO7blevlB5FNcJ2RxEoi7tzkEw5reMhlplqdTEWumHsoKpT+xolhWBack6OelYN
         KnOQ==
X-Gm-Message-State: AOAM5330dViJW4hZijJJONxu44w5IG2w2CgpRYltvXqmdB7lx0AiCr6e
        tPynuLM22L/UD0HgAl1BRDwz9DMfZNc=
X-Google-Smtp-Source: ABdhPJxLjp8NCv4GtGPw/XUgi6VK6mU4Y4Kdc2Q4CgzSos+3CURtjcmGcXAGCTmDeIPeNn7P9xuQNg==
X-Received: by 2002:a05:600c:34c2:: with SMTP id d2mr1757175wmq.102.1639000190364;
        Wed, 08 Dec 2021 13:49:50 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m17sm3636344wrz.22.2021.12.08.13.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 13:49:50 -0800 (PST)
Message-Id: <e052b2a61d618a6af0f586505d2a7a95d4ed4492.1639000187.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1152.v2.git.git.1639000187.gitgitgadget@gmail.com>
References: <pull.1152.git.git.1638899124.gitgitgadget@gmail.com>
        <pull.1152.v2.git.git.1639000187.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Dec 2021 21:49:38 +0000
Subject: [PATCH v2 03/11] reftable: fix resource leak blocksource.c
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

This would be triggered in the unlikely event of fstat() failing on an opened
file.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/blocksource.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/reftable/blocksource.c b/reftable/blocksource.c
index 0044eecd9aa..2605371c28d 100644
--- a/reftable/blocksource.c
+++ b/reftable/blocksource.c
@@ -134,8 +134,10 @@ int reftable_block_source_from_file(struct reftable_block_source *bs,
 	}
 
 	err = fstat(fd, &st);
-	if (err < 0)
-		return -1;
+	if (err < 0) {
+		close(fd);
+		return REFTABLE_IO_ERROR;
+	}
 
 	p = reftable_calloc(sizeof(struct file_block_source));
 	p->size = st.st_size;
-- 
gitgitgadget

