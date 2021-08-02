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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F1DC4338F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 16:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD5AA610FF
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 16:53:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233147AbhHBQx5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 12:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232550AbhHBQxw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 12:53:52 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27436C061798
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 09:53:42 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id k38-20020a05600c1ca6b029025af5e0f38bso3077295wms.5
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 09:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vysnlRXYw/aOCYJK3a3w3iXK3uaa7j22KJHUUCfJpig=;
        b=jFqbOXtVgF+Bd0iLcTEXQZRg4t48GSXhuarF/Z38eKacyOZdterEvVS/dNSApfox29
         AzRiAUMaHA/54/15UMKtpZMcY/KKwqceth3XThbajVn9Oqj/ufJ+8cB4BWNrS1kr22oV
         dNvSwUGicZf8IQMlqqb598dcXzN/vBy4vM1cQ1p2rON9pjJyRfAwntmhWyrW6bcY5/PT
         u3NBgqLsernOBgjpfWZbwx17jlpQ7octOpunIMmQ3+eQflGbrhoT4mV4qZxCET4IRGyi
         GLmA5+kIL0JmR3G94cQAq2rJ3UJ9/2bhwu6JFzDljVhxNC3sgRfH1oUZfduB4U2VkdVB
         IpNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=vysnlRXYw/aOCYJK3a3w3iXK3uaa7j22KJHUUCfJpig=;
        b=kUJ5mm7m5I8ChfN+VmAWqMMrBq4ZM3T+8pu3Io7Tjl8dhLO6BmNdsoAeRJTWG+PTI8
         gGtMKlUuhmnsDL0o4WBFzyPvjwwu6+rJdhfYRvdv4Lztiq27V3OiSprDCGU0PpnLYu1K
         F/0Y6acVwEw1GB382b+FvZGu5ftqALgrWRHACYZVTs6/bUvznghD46xjRBqy9Moxxxp9
         HidEKmwGrAOlM+Zusy0Sv9Hsl4ySk1lXOJLHkIdpmWhdCowrMsabZwcj2JbVTjDAa0xu
         iVpOdCkhnBthfTVZa19Ql52DG4Dw+gvFw8BSOe7pGdfBeVp1KvQlKxuiuuvZw9+Rdp+X
         i6Pg==
X-Gm-Message-State: AOAM5332nhMwHOJbYNL0xsa9V5ZCWuSQrqozC8gwcvZ+sqkYqQnz9nMx
        0m8ZJJh9xXR7v0DtgJk1o7vn1GAvizs=
X-Google-Smtp-Source: ABdhPJzV2ze/K1ui+VH92HjI4AyWHvcT/fPyNOA/7Ba/ZpQ2Jcq4xpjaBumaD2i065TTccWHzdUEeA==
X-Received: by 2002:a05:600c:b51:: with SMTP id k17mr17253404wmr.119.1627923220837;
        Mon, 02 Aug 2021 09:53:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l7sm10468558wmj.9.2021.08.02.09.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 09:53:40 -0700 (PDT)
Message-Id: <ceca139bcfcb695a09fc20c4aa0acb5aa85494f4.1627923216.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1052.v3.git.git.1627923216.gitgitgadget@gmail.com>
References: <pull.1052.v2.git.git.1626989327.gitgitgadget@gmail.com>
        <pull.1052.v3.git.git.1627923216.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 02 Aug 2021 16:53:30 +0000
Subject: [PATCH v3 05/11] t2402: use ref-store test helper to create broken
 symlink
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

