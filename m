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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 738EBC433ED
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 10:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E50A61077
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 10:54:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237725AbhDSKzH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 06:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238516AbhDSKxv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Apr 2021 06:53:51 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB57C061344
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 03:53:15 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id t14-20020a05600c198eb029012eeb3edfaeso7940189wmq.2
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 03:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YvmYr9/bofH492YlD9AmNRB09EovSBOYsEeqrELZews=;
        b=uuI9csGz9emqkPhSgQ9J/S3J/qHspTxNGjvhDKyeZZ5JaQhU+YeXyuTU0Og2jiH+LR
         d9O8/DJlf4VE/ghgX/tkMtvCVA5p4f0ycVWy2M6p6HdfGwC4yQ+d2QAeLfDJlVvECAp3
         ojEUcrv6kIbr8RWKvhMeA/XzKErjtYTB+HSBhpHrWYnJDiupJawCSyH8qYDva9YP8t0f
         lNQBxMK+yHis0WdC90p8kSno/4kFpAJwQlh8qh81AQ4xXrk3uBBDZupoMVAKBIHAN7AQ
         OJIT+0r+Zf3NU2niOuM8NSFbP0Yh1+vum1AE+r/nxkDad8weKWP7xMJbaUIdtQfd2m5l
         u7cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=YvmYr9/bofH492YlD9AmNRB09EovSBOYsEeqrELZews=;
        b=s2lWb5rdEWif8DDp+Zl4wHS/WRJ/74MOXqeGKYWITeZ/8nlMqdn8iP7HMlXclH8v06
         SjDwE2ATHyEuKpZ+tA3DATyKQLFWGc2CvRjuM3y8SuO1elL29qYoy7xtlj23weP5DXF2
         ZFV0X01jlp81mmJ0x7BLIxjgqWgwCAmugFcPQkDp+pdrk74v6cZqADVr7PW6no3Jl8+o
         yn4/MLvLjJcvR36q6vZh4IMCbslnk7U97arjGD/jp+B3i1Pe1Vzx8NgoqwCOMQraJAXT
         2H6RnUN51etaMARIXnQyMrTjxgzJwF3VUimLyRXghoJq8fUJwAEBl2j4nsr5EdW5736T
         XK7A==
X-Gm-Message-State: AOAM531wyxzeuOFOynz0Lhef2iFsCt4MJeMrBFmQ2fIa09c2w8uciq32
        ssa7y/pmFRZHvBFemoZznsJCjDjr5u8=
X-Google-Smtp-Source: ABdhPJy+Ym9L/INIF7OZM4+IfIuwhhd9wcRkR3XMtBv/LfcsMAn0y38iMo8KxqEh3A6GvdvCHggX7A==
X-Received: by 2002:a05:600c:35cc:: with SMTP id r12mr4959741wmq.147.1618829594189;
        Mon, 19 Apr 2021 03:53:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z14sm21482293wrs.96.2021.04.19.03.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 03:53:13 -0700 (PDT)
Message-Id: <0665edb1308b8cd4536d6922fd36315e1abdd9d1.1618829584.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Apr 2021 10:53:03 +0000
Subject: [PATCH 18/18] t1415: set REFFILES for test specific to storage format
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
 t/t1415-worktree-refs.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1415-worktree-refs.sh b/t/t1415-worktree-refs.sh
index 7ab91241ab7c..a8083a0af3af 100755
--- a/t/t1415-worktree-refs.sh
+++ b/t/t1415-worktree-refs.sh
@@ -16,7 +16,7 @@ test_expect_success 'setup' '
 	git -C wt2 update-ref refs/worktree/foo HEAD
 '
 
-test_expect_success 'refs/worktree must not be packed' '
+test_expect_success REFFILES 'refs/worktree must not be packed' '
 	git pack-refs --all &&
 	test_path_is_missing .git/refs/tags/wt1 &&
 	test_path_is_file .git/refs/worktree/foo &&
-- 
gitgitgadget
