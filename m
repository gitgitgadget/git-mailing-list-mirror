Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC70C432BE
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 09:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BF0860F3A
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 09:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244959AbhIBJGU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 05:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244917AbhIBJGS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 05:06:18 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3E8C061575
        for <git@vger.kernel.org>; Thu,  2 Sep 2021 02:05:20 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id q14so1724166wrp.3
        for <git@vger.kernel.org>; Thu, 02 Sep 2021 02:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hPiI6iYTFA/a2PMpNddc4bK5XRP/g0IXABNMsrGR6dE=;
        b=B4QKAhO9nE5Mr6boXRqVXXNLx204iA/S3K0mklXz2AOOJCzNp7XTbChBfBaqjN9Qb6
         M6QNI80D6wTskvbn2BfSRFJKJKz4v82vCNcAF+XOltqtPrBga0vJV2P6bK6YPdPKuEsi
         etYgRbLoE63Acbfl5wft3gbSsn21zrLQKXy/luTOAcygeoT3xm9X6KyfarYnI/jspE22
         KUGB30momRAU6TB7lFS/KYKdshGXtHG+H18Wy53cFreWyyyGGNStL0nXVYQUKNXPnR58
         GF2anpZeRL262kmH85rzNU7KRS6FLguJ45Pj3GWhF3va47NrWbvqrMHUI7NGH2B/AJCh
         NLsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hPiI6iYTFA/a2PMpNddc4bK5XRP/g0IXABNMsrGR6dE=;
        b=Z/jPM+Ii8sR9zFSXqEGarPmD7aGTq6Ys5eSkSJ3TQGrn83AC20QsbIOvY5WbQj7WPd
         0kSfcVLRkHBQBTsm1crcAmN0G5tpafCeYcqFwXe0pTBDt64LTNVtJTU6dz5Ti+05/8yI
         kEyEQ+mO5Z0u6pz2LX3QN55XfUkZhR4xg0bw/9WrsQxSuWLy/uFSvriLgJtghAGcGwM2
         rRXy+if1SExxa07RMG2/+RoyeBUNt42+Iu6v94dY2G1rBfJFjrkNNVevF6CIvL8o1hTN
         fOf/RXP3anS5s0gmywahdJ18EI+0wP9p3JsAoAddXmQgXV6A2z7ihv679ekFQgwB8Gas
         Qg+g==
X-Gm-Message-State: AOAM530WNm/UI1wHz2fn/v24MQPX8gnvNHOPWUTVY0a69lv4pldiMuAA
        iOFcNlnU4ygFeeWlayrUBRsEjGFXHxY=
X-Google-Smtp-Source: ABdhPJz8uw3wyfWV/aQxeQcGU8AydpVRy8BA+Gxo9Gc527GFRUu4Poubt4tyW+ELgDofqtImxzDvmQ==
X-Received: by 2002:a05:6000:22d:: with SMTP id l13mr2406458wrz.410.1630573518664;
        Thu, 02 Sep 2021 02:05:18 -0700 (PDT)
Received: from localhost.localdomain ([178.237.237.111])
        by smtp.gmail.com with ESMTPSA id l17sm1262516wrz.35.2021.09.02.02.05.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Sep 2021 02:05:18 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v6 2/6] t6030-bisect-porcelain: add test for bisect visualize
Date:   Thu,  2 Sep 2021 11:04:17 +0200
Message-Id: <20210902090421.93113-3-mirucam@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210902090421.93113-1-mirucam@gmail.com>
References: <20210902090421.93113-1-mirucam@gmail.com>
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

