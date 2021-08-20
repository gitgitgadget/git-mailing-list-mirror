Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB52C432BE
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 17:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C32FD6115A
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 17:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233743AbhHTRXm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 13:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233006AbhHTRXj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Aug 2021 13:23:39 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37401C061757
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 10:23:01 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id f5so15206715wrm.13
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 10:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hPiI6iYTFA/a2PMpNddc4bK5XRP/g0IXABNMsrGR6dE=;
        b=r56DX6cjDuSy6IrAFjUvi1nw2B//0blyVydlzVsF5SfwCEJ9u4BQOhmiyrVJiOooDb
         edaKtMSE6ATOhck5B4ADuSu++MijP+APZbhoKrnQqODoaZycGBZ8wAC/MAXE9zb1HQfj
         gv/WLiwUfnV9OEwI6mQd7CuiUkukGcpHzq6SjdGhQy8vWSMV12AmXidOzBx5qaZv5zpK
         YBF3EQGX+Jywe4Omd7oV86F5vOAuTmITeTfwyqVro8P8Wmu+Q/FIv8LhGVxAlN16acB9
         Ae5EoHKHhsnDLrC9wqB3dokFzrIDDHZDTTpzEDtgTTQ6i1jg7orTfAcv5EVIIfUDG7Hc
         uEAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hPiI6iYTFA/a2PMpNddc4bK5XRP/g0IXABNMsrGR6dE=;
        b=FQNBX1ZpOTHqqxi60bZYfC+pXdwHIB5d7UcoeLp2kUwr1d5pKLA6cf0dY7GIqHFFje
         3xibcKnf8Zjqqj9ZF5A5q+fXtwvFAlGgenb4zoBHMthWdvZ0eTBvfp9IyPiGaRHMHphF
         +j2t1hy+BUxrWF2gUh/57LAIFYm/WFWunDWSBOpear/0yagPMcQcBMsChqQkF0oEbGxF
         bcAiXphnaQqKMWIiEQt2OIIiQXSpFEZH0TrpP36KFaZOHdt3NARZmVEi93Em2oQETXH1
         xaR1k8EqjwKhwtDRTbsyGbxbDMr7d2yeY/rnFV0AkJxq8GXuhMpzyUMxa/jg75077zXm
         pquA==
X-Gm-Message-State: AOAM530VfEHmjTpmmAhvVFu7UPw1gK0b6BYCmUZH5NfQyPMVeD85WI/R
        jXxlzfubbfAqZZtIUKhi+hJvlVod/oI=
X-Google-Smtp-Source: ABdhPJwXuDISKge9twt4UtJ0qoQRGoJyI+aQi13nCo/13Ryoar+f60oWiB11In6DzSIYlVoAYKcB/Q==
X-Received: by 2002:a5d:6991:: with SMTP id g17mr11662830wru.253.1629480179831;
        Fri, 20 Aug 2021 10:22:59 -0700 (PDT)
Received: from localhost.localdomain ([178.237.232.111])
        by smtp.gmail.com with ESMTPSA id x13sm6623278wrq.44.2021.08.20.10.22.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Aug 2021 10:22:59 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v5 2/6] t6030-bisect-porcelain: add test for bisect visualize
Date:   Fri, 20 Aug 2021 19:21:44 +0200
Message-Id: <20210820172148.2249-3-mirucam@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210820172148.2249-1-mirucam@gmail.com>
References: <20210820172148.2249-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a test to control breakages in bisect visualize command.

Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 t/t6030-bisect-porcelain.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index e61b8143fd..f13eeac9ce 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -973,4 +973,11 @@ test_expect_success 'bisect run fails with exit code equals or greater than 128'
 	test_must_fail git bisect run ./test_script.sh >> my_bisect_log.txt
 '
 
+test_expect_success 'bisect visualize with a filename with dash and space' '
+	echo "My test line" >> -hello\ 2 &&
+	git add -- -hello\ 2 &&
+	git commit --quiet -m "Add test line" -- -hello\ 2 &&
+	git bisect visualize -p -- -hello\ 2 > my_bisect_log.txt
+'
+
 test_done
-- 
2.29.2

