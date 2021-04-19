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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D96CC433B4
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 10:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF96B61077
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 10:53:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbhDSKyU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 06:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238204AbhDSKxm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Apr 2021 06:53:42 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCCAC06174A
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 03:53:11 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id m9so20750091wrx.3
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 03:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=niVOFwUquJjmjDMBiQ//lZeh5gDuJbzhhIeA7vutwVo=;
        b=hc+nhSEirpqTS/9h29DEonodsjMxRo+OQdUFzENMGVU/LVFcYpXJr83QKSSVuIp9lk
         lQ6KoYIHd16586uuU0GyAQ/W81DQYrKNtcmcg/ntacPH0j7uNlK1BwooDRrvTruvXuwz
         LfMkFVEplP2J0LnEN+lV+/jgOmAkao5JUn2cy4ftUXtvp8KPX1/0pJ8WvFD9DV/83keO
         Shd5axUT2Y/unQmMvgVG4U8l9UK455b6upXM0cBfYOqtQr83sdpUNUTYGIQO0JqfC65P
         Yogao+/6SAamSY2LKK8LTf+OlphzLt5ijWkFSW0M0WcUod+s084xRxHqrDV365ATT4jg
         1/kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=niVOFwUquJjmjDMBiQ//lZeh5gDuJbzhhIeA7vutwVo=;
        b=fjiGjqXEBxZy9Ro/UZXoWXkShqQ8oG+mpwOIyzZi/VzKzwWdavgyMuEUzGgZfKA7Zz
         8zb7r7WyJBMaNtHrF0bMAGYlv1AwlU5aIKLgwMNUNRLRlZ8zJgTbNIrn7VEH+3GX6dvw
         FlQHlHscUkPJ6pIiSn1qYxGBY1VpZ6DaTY5s4jJCr+tXkgspKMbViFqXZob8mT6rMkl4
         4IAjY5B7wUMViVhW89CaW27gsl8OnaQQg/ikaowgukBnRv33HuHQgMankS5EFpgMrO/b
         nXE+dz9HyYftxsA1mcBXa0bl/yTR5yHcuIrEYD/P228f3mgbpwzcGBFakX83xorq+Xxb
         N9gA==
X-Gm-Message-State: AOAM532uatI8HFzWrCUuZQ+eVSpmGty8/bp/pt5rGuIg6eX317qzPL8E
        5aVHYeNY2AtpvV4JFfLS9vShoB8nWik=
X-Google-Smtp-Source: ABdhPJwB/Xz+EEqQ+5WgV0m03KpoXJTcvfPSklf8vhSZOtut/QH4Inr/HjP3DC7GLTuNzUIHBDj+Eg==
X-Received: by 2002:adf:dbc2:: with SMTP id e2mr12681113wrj.398.1618829590701;
        Mon, 19 Apr 2021 03:53:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 66sm22838241wmb.36.2021.04.19.03.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 03:53:10 -0700 (PDT)
Message-Id: <dd1f6969c28d95027d1ac9f7b6f6a43640babada.1618829583.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Apr 2021 10:52:56 +0000
Subject: [PATCH 11/18] t1407: require REFFILES for for_each_reflog test
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

It tries to setup a reflog by catting to .git/logs/

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/t1407-worktree-ref-store.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1407-worktree-ref-store.sh b/t/t1407-worktree-ref-store.sh
index d3fe77751122..27b57f248a94 100755
--- a/t/t1407-worktree-ref-store.sh
+++ b/t/t1407-worktree-ref-store.sh
@@ -52,7 +52,7 @@ test_expect_success 'create_symref(FOO, refs/heads/main)' '
 	test_cmp expected actual
 '
 
-test_expect_success 'for_each_reflog()' '
+test_expect_success REFFILES 'for_each_reflog()' '
 	echo $ZERO_OID > .git/logs/PSEUDO-MAIN &&
 	mkdir -p     .git/logs/refs/bisect &&
 	echo $ZERO_OID > .git/logs/refs/bisect/random &&
-- 
gitgitgadget

