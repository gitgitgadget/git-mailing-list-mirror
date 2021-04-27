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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF1BC433ED
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 10:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3CC061164
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 10:39:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235621AbhD0Kjk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Apr 2021 06:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238063AbhD0KjL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Apr 2021 06:39:11 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53106C061574
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 03:38:28 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id n4-20020a05600c4f84b029013151278decso6563441wmq.4
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 03:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hCsQOIxYRiZGmvP6afW8BZps1OSvbdwKuZbdnuIFjdk=;
        b=mrmcIpLHsjKGPd+13D5uXylZdkz2rB5LJFQA1tNDSZJsaklLaCAsXeyUC3Tj4nElu+
         YuHdhShQ0Vw0BnKDaHkLl76e7a8o7oFu5vu8+jMgjgYSAs9E52l4CpkprPOxKo9NB/3R
         JoKNj7A/01xVJU1kOctsNWDMIQS5wXcWKdmVVhW8ozWZSN5tb1DqaBXDO6e0zFBcMlp7
         bVshGAzAHHYul2kgDUgJKaRh+vW8PFY7kTaiDPyin20l9tMptjzMWkCkNlVy1MOVPT1b
         al/yzga4FgIiAr6OtYbhc7PvRLaeqXrqrGJcWBNU/Ixw0cyHOv019kL2Fnc3FLzrCPxq
         iR7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hCsQOIxYRiZGmvP6afW8BZps1OSvbdwKuZbdnuIFjdk=;
        b=mh0Q6Ih74DFXxud4aOK7UEQFnoRKvkPiJ2LtLz9blmKkmOgejzlAFfjlxVGn5yy7oB
         A2ALTRe5PBdCtATsRHKPeFK1FZZbx+lNaQUEqIOnLCrWi/7PXZ3o11k3pLe+340/9YJl
         oTvAHGcEj1FMmUhGssPR1qH/SRhJBplZO+JvkdXNFsn7ZFtSb/7qHMhF7JJ8MvKBc41/
         fjQ2SoeMrpfwiTr2OIWx1Wr+US3HGRXNgyIgIK/WRUtt6bAtmJ+qXydUhBsLuy26iwEh
         8ZB0q9/yD7lx2TrKy1ewz9qgyRLXr7fsamp4glmay1sO0HgOem5tqtdmY5ZgcBantYkF
         QVNg==
X-Gm-Message-State: AOAM532K5M0vhntk6/4sMOZWe8xEd8c6/s987v2E8A3mYPmPXH6N28oM
        WRWWntTB7V55HEOJ/O/gvsAu4xFJyII=
X-Google-Smtp-Source: ABdhPJyvsoJNOIoraiNr7TURFqnAEdOdfDYKJaf6dTIvXs6aAMt47hFKVcNgmzrCAMEQA92IYnhumQ==
X-Received: by 2002:a1c:55ca:: with SMTP id j193mr3593975wmb.58.1619519907169;
        Tue, 27 Apr 2021 03:38:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r2sm3318439wrt.79.2021.04.27.03.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 03:38:26 -0700 (PDT)
Message-Id: <369c968ab8372291fa08c7cc756432d2ff039157.1619519903.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com>
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
        <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 27 Apr 2021 10:38:05 +0000
Subject: [PATCH v2 04/21] t5601: read HEAD using rev-parse
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/t5601-clone.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 329ae599fd3c..7223372c7660 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -305,7 +305,8 @@ test_expect_success 'clone from original with relative alternate' '
 test_expect_success 'clone checking out a tag' '
 	git clone --branch=some-tag src dst.tag &&
 	GIT_DIR=src/.git git rev-parse some-tag >expected &&
-	test_cmp expected dst.tag/.git/HEAD &&
+	GIT_DIR=dst.tag/.git git rev-parse HEAD >actual &&
+	test_cmp expected actual &&
 	GIT_DIR=dst.tag/.git git config remote.origin.fetch >fetch.actual &&
 	echo "+refs/heads/*:refs/remotes/origin/*" >fetch.expected &&
 	test_cmp fetch.expected fetch.actual
-- 
gitgitgadget

