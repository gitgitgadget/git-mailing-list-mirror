Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D37C7C4320A
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 22:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE95E60560
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 22:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233116AbhHBWix (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 18:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbhHBWis (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 18:38:48 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B32C0613D5
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 15:38:38 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id p5so23200913wro.7
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 15:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sRMkGQ9d48liM5p3XqWstj4cz8j7g/2tUl9I/WtyjK8=;
        b=ZIa5nkAdpxVazOjVuRaK07VRQ57+X5BAyHCuAx7xKQZRsLQeRYSJJtM7McB/UwYsLA
         PaWFjMthOU/lL7Nv5SUE0iaz/tLyPPbFIuHgdVfGagdl9Cwrqjok2/ROx8suTG4nyffX
         lWIkMg7ab/ejeZQZzK2pOoy5pYolxdq1oeJQcjIWlAYpp8662gvEeKyBgdyYPiqkZLh+
         H9Ayjx4OyKpZJ+iX+gjloauqEdC6SzfzYwlm4IMkFy+fn6fZ65+VjNqQpPEczqk8J8EZ
         DQS0bgJVHsdDHScgmRjMBysCI2b6eZqTU3bM6nlwaXDp4z3XYpR9jxdR82DNp2AOg6YP
         VWpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sRMkGQ9d48liM5p3XqWstj4cz8j7g/2tUl9I/WtyjK8=;
        b=FsCMvKhkXNA1/JpABN6cvNcgFtdwngTN8kdc1aEDu1299Zx1wiqmLVg7G7xrXMESpI
         F0nWKtPcZJEhQd/woNAGPExkKejr6XkpvqZJds6JRQXjfrSyIyEKyQpsAywNWGOIRDqv
         SOZQZJf4pSnf48FzmQhiIr1sNmhkUHs4b07pJ5ZkN5H8jP3z/TqJAvl9GNWy9HKOOo1X
         RZcE8CNnTQRBhsKA2LXGfReiz1ustj6UyTsMVbHdtVPXKU1PG1hdmE6KcXE0HT6ErQY1
         YRiElQdVTJXuZNHlal0pUSrNlzGRYejPdzReJ2N0ls8aVTwNNcbhRnrw40gk86P7w8Mj
         HAHQ==
X-Gm-Message-State: AOAM532le2DQIjdVYBQvCMWR1PRU0vbWA9SsoP4j6aZbaa7FQbwkhLiD
        qEzvaElI24e7R96oJEKzla8TUurO7B0=
X-Google-Smtp-Source: ABdhPJznEc2ZAnBB32TmZwCLtogo1QnFpQCPHkrctjRxW7AC8A9oHUMQYaI1JYQkpFokdWx/cSUBfQ==
X-Received: by 2002:a5d:620d:: with SMTP id y13mr19856766wru.45.1627943916664;
        Mon, 02 Aug 2021 15:38:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s14sm11187046wmc.25.2021.08.02.15.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 15:38:36 -0700 (PDT)
Message-Id: <dd13a65ef0f648f13cc220303092a657148c19ac.1627943914.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1006.v2.git.1627943914.gitgitgadget@gmail.com>
References: <pull.1006.git.1627925390.gitgitgadget@gmail.com>
        <pull.1006.v2.git.1627943914.gitgitgadget@gmail.com>
From:   "Mahi Kolla via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 02 Aug 2021 22:38:33 +0000
Subject: [PATCH v2 2/3] clone: update submodule.recurse in config when using
 --recurse-submodule
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Mahi Kolla <mahikolla@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Mahi Kolla <mahikolla@google.com>

When running 'git clone --recurse-submodules', developers expect various other commands such as 'pull' and 'checkout' to also run recursively into submodules.The submitted code updates the 'submodule.recurse' config value to true when 'git clone' is run with the '--recurse-submodules' option.

Signed-off-by: Mahi Kolla <mahikolla@google.com>
---
 t/t5606-clone-options.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5606-clone-options.sh b/t/t5606-clone-options.sh
index 3daef8c941f..69c4bacf52f 100755
--- a/t/t5606-clone-options.sh
+++ b/t/t5606-clone-options.sh
@@ -19,7 +19,7 @@ test_expect_success 'setup' '
 test_expect_success 'clone --recurse-submodules sets submodule.recurse=true' '
 
         git clone --recurse-submodules parent clone-rec-submodule &&
-        test_config_global submodule.recurse true 
+        git config submodule.recurse true
 
 '
 
-- 
gitgitgadget

