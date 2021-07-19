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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ADA0C12002
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 18:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CF28610FB
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 18:11:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355311AbhGSRbM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jul 2021 13:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380089AbhGSR1h (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jul 2021 13:27:37 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45803C061768
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 10:52:10 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id f8-20020a1c1f080000b029022d4c6cfc37so12101097wmf.5
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 11:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vysnlRXYw/aOCYJK3a3w3iXK3uaa7j22KJHUUCfJpig=;
        b=nK1VCEPaKynMxXUgV5qHMyfP2eK2gLmaRRCnmwnLrdkR1mIqjTzVihjnO9KeiUVKwV
         v3fbWhU5f6Q6rUlfPlj+/f9M15kHr7XX17nXFRwUpF0otRIqParVsgYvWmENgpiOXdnj
         5D9z3QNfl0c53S4VUw7o6bUF/JB0+Nurygw9MPKLGt7vtlQ1hYV9CT5YiNWKNabq4TCn
         08eE8TBSKalrJWjtwGb0yVEy5ur2FvMwUVrJO/jVxUoCo6GmRi7hmx6YwAqTnoG7+si9
         0/UkptGwsVN75NIUWN+ZWv3xYtQUQCHZ+4lx6UwQJDZnLpXSi1s0GXlXlREuJNKGDZYS
         dvtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=vysnlRXYw/aOCYJK3a3w3iXK3uaa7j22KJHUUCfJpig=;
        b=Ak2U6igc8JyIzV65+JzFtHcmKGOKIX3sl5NPNlYkQ5V2S7Y3zTeWNu2Z4MORj6BIIZ
         /bj9b2FCq3MmaPh/sJj9hLPQ8cDi3lsfy1l+ItswFNeMK5J+Qe6srBXulxMYbgSfwuDJ
         IpLvcYRVwBSTVhbxxGr6044wYzgUKQ+hbq5TNDBMRjPH1PHJJTaxGaXVDKWJipKgc6my
         BhJlEwABBC1AzhtwglJ49IgcLySl+lYgRwEC25wHowzIgocbiYU/qCiAEtDzC7Wgvukw
         VYVKNq34oHGGnZr9yUbMIxGVxd7MJ/cXvhhAXkpiV/OSkT8zXBC8PpDz9dU+01eWQdnZ
         3Kdg==
X-Gm-Message-State: AOAM5303Bwpog2r6sDcLvzAtzAnDB7zWoaRX8U8iJIeerzmGXCQvx30/
        e5pEvygj+8RcPCM06DZpLFSgyuFec4U=
X-Google-Smtp-Source: ABdhPJyak2aYmB7+RFvpe7dD0CW7DUNts5t11CSVm0ZvumVuz/MToVqd4KuDt+d3wra8qCrx1aIASw==
X-Received: by 2002:a05:600c:a01:: with SMTP id z1mr33449831wmp.77.1626718055263;
        Mon, 19 Jul 2021 11:07:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b16sm22219159wrs.51.2021.07.19.11.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 11:07:34 -0700 (PDT)
Message-Id: <4d83f70e13323c97bbae685c3ee6f5c94876cf78.1626718050.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1052.git.git.1626718050.gitgitgadget@gmail.com>
References: <pull.1052.git.git.1626718050.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Jul 2021 18:07:30 +0000
Subject: [PATCH 6/6] t2402: use ref-store test helper to create broken symlink
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/t2402-worktree-list.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t2402-worktree-list.sh b/t/t2402-worktree-list.sh
index fedcefe8de3..4012bd67b04 100755
--- a/t/t2402-worktree-list.sh
+++ b/t/t2402-worktree-list.sh
@@ -230,7 +230,7 @@ test_expect_success 'broken main worktree still at the top' '
 		EOF
 		cd linked &&
 		echo "worktree $(pwd)" >expected &&
-		echo "ref: .broken" >../.git/HEAD &&
+		(cd ../ && test-tool ref-store main create-symref HEAD .broken ) &&
 		git worktree list --porcelain >out &&
 		head -n 3 out >actual &&
 		test_cmp ../expected actual &&
-- 
gitgitgadget
