Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30989C433B4
	for <git@archiver.kernel.org>; Mon, 10 May 2021 15:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09CFB61492
	for <git@archiver.kernel.org>; Mon, 10 May 2021 15:35:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237254AbhEJPgT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 May 2021 11:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235776AbhEJPgC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 May 2021 11:36:02 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC41AC06175F
        for <git@vger.kernel.org>; Mon, 10 May 2021 08:34:56 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id z9so23955804lfu.8
        for <git@vger.kernel.org>; Mon, 10 May 2021 08:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+Tw3EfYkTystDWE6dFgpdsi6tMXjFDv0Loo9hwI4GWw=;
        b=NjNqTNC8+L3L0IwQJHy5/ieslmiGUkIxrSFBtvIlX+iMMHcJ0mFDzO58buF8TdlfIB
         9UuLV7H6nL457qLrrVj/DgjeYx8TwTf/dAbrrg5mN9+blGCoXxXQnbYE55yFR6EG+sMa
         ii2vs5akHTkarRZz3vyQ65DogxqTWe5q2lZOKnd9fG8ki7ScHfAB0mvX2Jc4nJct4qYF
         yqh4Hhl2W6XN0iPab95IM1Zr6Vp1xnzLDGvueIIogkRy02JWvzgtqRm1wtqNknd8/vn3
         kWETB2tU8JVyR1YrB/U7Fgw/IUZbBd4GsEbMGgOjdCqTsT6cglDbbWfwmdNavaQDJk9S
         Lz+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+Tw3EfYkTystDWE6dFgpdsi6tMXjFDv0Loo9hwI4GWw=;
        b=ih9nciQsw4p5sPII/kuvK2RmdaJUDNoq7Ow3X4zuVdOOxYlYAom6Odd56Fq6/CpGE8
         P9kmbFrsbm+sjpgyP7pF+H6dHWrexWErAZ8pBF7uWC8rDDxJHptrgYE4c42IYXG9qodK
         5MErFHEjqHZgOUXpSH09IKEYJc3YDkeT5IX78rvtTnRPtwr+kZuraxPyGaYxGBv0l43j
         j8cnJJHBhoUpIbtPJMZkNVHQHYBuRLd04Nk3H0EPv7nkZgMXmlHjMpY/oGvC1fmrD2K4
         uuPP51WNuN0Z4CwgYOvd41QrPbF5BbEGIC6PxD8v3D2Om2i7f3I/n1ihYSrJU7ZGtV6Q
         5ABw==
X-Gm-Message-State: AOAM531q39HJ4B4t+pxyAf77Txd5rpOdIA0l4MCvDFLk24WABGjNEK6M
        c82z+lbAlMtICIQIT/xyKpE=
X-Google-Smtp-Source: ABdhPJzcqTqTC5YX5ienLYgptZzGC5E7o29e/xP8oTz2zRIoTykJCnCj5GhS9EQu9AjDEWUp2H8dPw==
X-Received: by 2002:a19:6901:: with SMTP id e1mr16549016lfc.642.1620660895436;
        Mon, 10 May 2021 08:34:55 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id p8sm1525840lfe.224.2021.05.10.08.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 08:34:55 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Alex Henrie <alexhenrie24@gmail.com>,
        git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH 1/6] t4013: add test for "git diff-index -m"
Date:   Mon, 10 May 2021 18:34:46 +0300
Message-Id: <20210510153451.15090-2-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210510153451.15090-1-sorganov@gmail.com>
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
 <20210510153451.15090-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

-m in "git diff-index" means "match missing", that differs
from its meaning in "git diff". Let's check it in diff-index.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 t/t4013-diff-various.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 87def81699bf..bd16d4885cfd 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -483,6 +483,19 @@ test_expect_success 'git config log.diffMerges first-parent vs -m' '
 	test_cmp expected actual
 '
 
+# -m in "git diff-index" means "match missing", that differs
+# from its meaning in "git diff". Let's check it in diff-index.
+# The line in the output for removed file should disappear when
+# we provide -m in diff-index.
+test_expect_success 'git diff-index -m' '
+	rm -f file1 &&
+	git diff-index HEAD >without-m &&
+	lines_count=$(wc -l <without-m) &&
+	git diff-index -m HEAD >with-m &&
+	git restore file1 &&
+	test_line_count = $((lines_count - 1)) with-m
+'
+
 test_expect_success 'log -S requires an argument' '
 	test_must_fail git log -S
 '
-- 
2.25.1

